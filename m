Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeFDMdA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:33:00 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39893 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752712AbeFDMc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:32:56 -0400
X-Google-Smtp-Source: ADUXVKLeBbUhKEObchv/PKS43hZPM76ALJqxVIeOAJ50447zyndrSlaSmkSc1P7+lrPAgbd1gaaJYw==
From: Chris Chiu <chiu@endlessm.com>
To: corentin.chary@gmail.com, dvhart@infradead.org,
        andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, hdegoede@redhat.com,
        linux@endlessm.com, Chris Chiu <chiu@endlessm.com>
Subject: [PATCH 2/2] platform/x86: asus-wmi: Add keyboard backlight toggle support
Date: Mon,  4 Jun 2018 20:32:38 +0800
Message-Id: <20180604123238.82200-2-chiu@endlessm.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
In-Reply-To: <20180604123238.82200-1-chiu@endlessm.com>
References: <20180604123238.82200-1-chiu@endlessm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some ASUS laptops like UX550GE has hotkey (Fn+F7) for keyboard
backlight toggle which would emit the scan code 0xc7 each keypress.
On the UX550GE, the max keyboard brightness level is 3 so the
toggle would not be simply on/off the led but need to be cyclic.
Per ASUS spec, it should increment the brightness for each keypress,
then toggle(off) the LED when it already reached the max level.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 drivers/platform/x86/asus-wmi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index b4915b7718c1..100e13e0817e 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -67,6 +67,7 @@ MODULE_LICENSE("GPL");
 #define NOTIFY_BRNDOWN_MAX		0x2e
 #define NOTIFY_KBD_BRTUP		0xc4
 #define NOTIFY_KBD_BRTDWN		0xc5
+#define NOTIFY_KBD_BRTTOGGLE		0xc7
 
 /* WMI Methods */
 #define ASUS_WMI_METHODID_SPEC	        0x43455053 /* BIOS SPECification */
@@ -1704,7 +1705,9 @@ static int is_display_toggle(int code)
 
 static int is_kbd_led_event(int code)
 {
-	if (code == NOTIFY_KBD_BRTUP || code == NOTIFY_KBD_BRTDWN)
+	if (code == NOTIFY_KBD_BRTUP ||
+	    code ==  NOTIFY_KBD_BRTDWN ||
+	    code ==  NOTIFY_KBD_BRTTOGGLE)
 		return 1;
 	return 0;
 }
@@ -1755,7 +1758,10 @@ static void asus_wmi_notify(u32 value, void *context)
 	}
 
 	if (is_kbd_led_event(code)) {
-		if (code == NOTIFY_KBD_BRTDWN)
+		if (code == NOTIFY_KBD_BRTTOGGLE &&
+		    asus->kbd_led_wk == asus->kbd_led.max_brightness)
+			kbd_led_set(&asus->kbd_led, 0);
+		else if (code == NOTIFY_KBD_BRTDWN)
 			kbd_led_set(&asus->kbd_led, asus->kbd_led_wk - 1);
 		else
 			kbd_led_set(&asus->kbd_led, asus->kbd_led_wk + 1);
-- 
2.11.0
