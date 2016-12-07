//
//  ViewController.swift
//  NewNotifications
//
//  Created by Emmanuel Erilibe on 2016-12-06.
//  Copyright © 2016 Emmanuel Erilibe. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Request Notifications
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
            if granted {
                print("Notification access granted")
            } else {
                print(error?.localizedDescription)
            }
        })
    }
    
    @IBAction func notifyButtonTapped(sender: UIButton) {
        scheduleNotification(inSeconds: 5, completion: {success in
            if success {
                print("Successfully scheduled notification")
            } else {
                print("Error scheduling notification")
            }
        })
    }
    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        // Add an attachment
        let myImage = "rick_grimes"
        guard let imageUrl = Bundle.main.url(forResource: myImage, withExtension: "gif") else {
            completion(false)
            return
        }
        
        var attachment: UNNotificationAttachment
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageUrl, options: .none)
        
        let notify = UNMutableNotificationContent()
        
        //ONLY FOR EXTENSION
        notify.categoryIdentifier = "myNotificationCategory"
        
        notify.title = "New Notification"
        notify.subtitle = "These are great"
        notify.body = "The new notifications option are very good for your tommy, don't stay hungry"
        notify.attachments = [attachment]
        
        let notifyTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notify, trigger: notifyTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
            
                print(error)
                completion(false)
                
            } else {
                completion(true)
            }
        })
    }


}

