//
//  ContentView.swift
//  SwiftUIContactPicker
//
//  Created by Stefano Rampazzo on 24/02/2020.
//  Copyright © 2020 Stefano Rampazzo. All rights reserved.
//

import SwiftUI
import ContactsUI

struct ContentView: View {
    @EnvironmentObject var contactObj: ContactObject
    private let contactPickerDelegate = ContactPickerDelegate()

    
    var body: some View {
        ZStack {
     
                VStack{
                    Spacer()
                    Button(action: {
                        self.presentContactPicker()
                    }) {
                        Text("Pick a contact")
                    }
                    Spacer()
                    Text("\(self.contactObj.cObj.givenName) \(self.contactObj.cObj.familyName)")
                    Spacer()
                    Text("From an original idea of Florent Morin")
                  
                }
           
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

 
// MARK: The contact picker part
extension ContentView {

    /// Delegate for view controller as `CNContactPickerDelegate`
    private class ContactPickerDelegate : NSObject, CNContactPickerDelegate {
        
        var contactObj : ContactObject = ContactObject()
        
        func contactPickerController(_ controller: CNContactPickerViewController,
                                   error: Error?) {
             //Customize here
            
            controller.dismiss(animated: true)
        }
        
       

         func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
              picker.dismiss(animated: false) {
                 print (contact)
                self.setContact(contact:contact)
              }
         }
        
        func setContact(contact: CNContact ){
           self.contactObj.cObj = contact
    
        }
        

    }

    /// Present an mail compose view controller modally in UIKit environment
    private func presentContactPicker() {
        let win = UIApplication.shared.windows.first { $0.isKeyWindow }
        let vc = win?.rootViewController
        let composeVC = CNContactPickerViewController()
        contactPickerDelegate.contactObj=contactObj
        composeVC.delegate = contactPickerDelegate
        vc?.present(composeVC, animated: true)
    }
}
