//
//  ViewController.swift
//  5.TestViewAnimation
//
//  Created by apple on 2020/7/28.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var orangeView: UIView!
    
    var originFrame:CGRect!
    var firstSubView:UIView!
    var firstSubViewFrame:CGRect!
    lazy var orangeLayer:CALayer = {
        let orangeLayer = CALayer()
        orangeLayer.backgroundColor = UIColor.orange.cgColor
        orangeLayer.frame = CGRect(x: 10, y: 300, width: 30, height: 30)
        return orangeLayer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        originFrame = self.orangeView.frame
        let firstRect = CGRect(x: 10, y: 10, width: 30, height: 30)
        firstSubView = UIView(frame: firstRect)
        firstSubView.backgroundColor = .red
        firstSubViewFrame = firstRect
        orangeView.addSubview(firstSubView)
        self.view.layer.addSublayer(orangeLayer)
    }
    
    
    @IBAction func startBtnClick(_ sender: Any) {
//        basicAnimation()
//        optionAnimation()
//        operateSubview()
//        implicitAnimation()
//        showAnimation()
        keyFrameAnimation()
    }
    
    @IBAction func fallbackBtnClick(_ sender: Any) {
        self.orangeView.frame = originFrame
        self.orangeView.layer.removeAllAnimations()
        self.firstSubView.layer.removeAllAnimations()
    }
    
    
    func basicAnimation() {
        UIView.animate(withDuration: 2) {
//            print("\()")
            self.orangeView.frame.origin.x += 100
        }
    }
    func optionAnimation() {
        UIView.animate(withDuration: 2, delay: 0.0, options: .repeat, animations: {
            self.orangeView.frame.origin.x += 100
            self.orangeView.backgroundColor = UIColor.magenta
        }) { (finish) in
            print("动画结束...")
        }
    }
    // 转场动画
    func operateSubview() {
        UIView.transition(with: orangeView, duration: 2, options: .transitionCurlUp, animations: {
            self.firstSubView.isHidden = true
        }) { (finish) in
            
        }
    }
    // 隐式动画
    func implicitAnimation() {
        orangeLayer.position.y += 100
    }
    // 显示动画
    func showAnimation() {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 2.0
        scaleAnimation.repeatCount = MAXFLOAT
        scaleAnimation.autoreverses = true
        scaleAnimation.duration = 2.0
        let opaqueAnimation = CABasicAnimation(keyPath: "opacity")
        opaqueAnimation.fromValue = 0.0
        opaqueAnimation.toValue = 1.0
        opaqueAnimation.repeatCount = MAXFLOAT
        opaqueAnimation.autoreverses = true
        opaqueAnimation.duration = 2.0
        
        orangeView.layer.add(scaleAnimation, forKey: "scaleAnimation")
        orangeView.layer.add(opaqueAnimation, forKey: "opaqueAnimation")
    }
    
    // 关键动画
    func keyFrameAnimation() {
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "position")
        let position = orangeView.layer.position
        let value0 = NSValue(cgPoint: position)
        let value1 = NSValue(cgPoint: CGPoint(x: position.x, y: position.y + 200))
        let value2 = NSValue(cgPoint: CGPoint(x: position.x + 200, y: position.y + 200))
        let value3 = NSValue(cgPoint: CGPoint(x: position.x + 200, y: position.y))
        let value4 = NSValue(cgPoint: position)
        
        let timing0 = CAMediaTimingFunction(name: .easeIn)
        let timing1 = CAMediaTimingFunction(name: .easeOut)
        let timing2 = CAMediaTimingFunction(name: .easeInEaseOut)
        let timing3 = CAMediaTimingFunction(name: .linear)
        
        // 运动路线
        keyFrameAnimation.values = [value0, value1, value2, value3, value4]
        // 每条路线的速度
        keyFrameAnimation.timingFunctions = [timing0, timing1, timing2, timing3]
        // 每条路线的时间比
        keyFrameAnimation.keyTimes = [0.0, 0.4, 0.5, 0.6, 1]
        
        keyFrameAnimation.duration = 5.0
        keyFrameAnimation.repeatCount = MAXFLOAT
        keyFrameAnimation.autoreverses = false
        
        orangeView.layer.add(keyFrameAnimation, forKey: "keyFrameAnimation")
    }
}

