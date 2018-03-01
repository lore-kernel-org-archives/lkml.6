Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033458AbeCAR3v (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 12:29:51 -0500
Received: from erebus.the-tk.com ([109.74.205.187]:57606 "EHLO
        erebus.the-tk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033044AbeCAR3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 12:29:49 -0500
From: Tomasz Kramkowski <tk@the-tk.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomasz Kramkowski <tk@the-tk.com>
Subject: [PATCH 1/2] HID: elecom: refer to trackballs by model name instead of series
Date: Thu,  1 Mar 2018 17:22:23 +0000
Message-Id: <20180301172224.1276-1-tk@the-tk.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes all references to ELECOM trackballs using their
series name to refer to them by their model name.

ELECOM provides multiple series of mice such as EX-G, HUGE, and DEFT.
Although it has not caused conflicts in the driver, there can be more
than one iteration of mice in each series. For example, there are 7
variants of EX-G trackballs but only three (M-XT3URBK, M-XT3DRBK, and
M-XT4DRBK) need a driver to work correctly.

There are also 4 DEFT series trackballs but two of them have the same
VID:PID as the other two. I picked the earlier model for the naming of
the PID macros.

Signed-off-by: Tomasz Kramkowski <tk@the-tk.com>
---
If this patch is too trivial to bother then feel free to ask and I'll
amend the second patch to use a different naming scheme.

I did a survey of mouse model names and VID:PID values here:
https://www.reddit.com/r/Trackballs/comments/7vqraz/
---
 drivers/hid/Kconfig      |  6 +++---
 drivers/hid/hid-elecom.c | 30 +++++++++++++++---------------
 drivers/hid/hid-ids.h    | 12 ++++++------
 drivers/hid/hid-quirks.c | 12 ++++++------
 4 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 19c499f5623d..4989ec4028bf 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -280,9 +280,9 @@ config HID_ELECOM
 	---help---
 	Support for ELECOM devices:
 	  - BM084 Bluetooth Mouse
-	  - EX-G Trackball (Wired and wireless)
-	  - DEFT Trackball (Wired and wireless)
-	  - HUGE Trackball (Wired and wireless)
+	  - EX-G Trackballs (M-XT3DRBK, M-XT3URBK)
+	  - DEFT Trackballs (M-DT1DRBK, M-DT1URBK, M-DT2DRBK, M-DT2URBK)
+	  - HUGE Trackballs (M-HT1DRBK, M-HT1URBK)
 
 config HID_ELO
 	tristate "ELO USB 4000/4500 touchscreen"
diff --git a/drivers/hid/hid-elecom.c b/drivers/hid/hid-elecom.c
index 1a1ecc491c02..21e15dc91aac 100644
--- a/drivers/hid/hid-elecom.c
+++ b/drivers/hid/hid-elecom.c
@@ -1,9 +1,9 @@
 /*
  *  HID driver for ELECOM devices:
  *  - BM084 Bluetooth Mouse
- *  - EX-G Trackball (Wired and wireless)
- *  - DEFT Trackball (Wired and wireless)
- *  - HUGE Trackball (Wired and wireless)
+ *  - EX-G Trackballs (M-XT3DRBK, M-XT3URBK)
+ *  - DEFT Trackballs (M-DT1DRBK, M-DT1URBK, M-DT2DRBK, M-DT2URBK)
+ *  - HUGE Trackballs (M-HT1DRBK, M-HT1URBK)
  *
  *  Copyright (c) 2010 Richard Nauber <Richard.Nauber@gmail.com>
  *  Copyright (c) 2016 Yuxuan Shui <yshuiv7@gmail.com>
@@ -65,14 +65,14 @@ static __u8 *elecom_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 			rdesc[47] = 0x00;
 		}
 		break;
-	case USB_DEVICE_ID_ELECOM_EX_G_WIRED:
-	case USB_DEVICE_ID_ELECOM_EX_G_WIRELESS:
+	case USB_DEVICE_ID_ELECOM_M_XT3URBK:
+	case USB_DEVICE_ID_ELECOM_M_XT3DRBK:
 		mouse_button_fixup(hdev, rdesc, *rsize, 6);
 		break;
-	case USB_DEVICE_ID_ELECOM_DEFT_WIRED:
-	case USB_DEVICE_ID_ELECOM_DEFT_WIRELESS:
-	case USB_DEVICE_ID_ELECOM_HUGE_WIRED:
-	case USB_DEVICE_ID_ELECOM_HUGE_WIRELESS:
+	case USB_DEVICE_ID_ELECOM_M_DT1URBK:
+	case USB_DEVICE_ID_ELECOM_M_DT1DRBK:
+	case USB_DEVICE_ID_ELECOM_M_HT1URBK:
+	case USB_DEVICE_ID_ELECOM_M_HT1DRBK:
 		mouse_button_fixup(hdev, rdesc, *rsize, 8);
 		break;
 	}
@@ -81,12 +81,12 @@ static __u8 *elecom_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 
 static const struct hid_device_id elecom_devices[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_EX_G_WIRED) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_EX_G_WIRELESS) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_DEFT_WIRED) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_DEFT_WIRELESS) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_HUGE_WIRED) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_HUGE_WIRELESS) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3URBK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3DRBK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT1URBK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT1DRBK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1URBK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1DRBK) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, elecom_devices);
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 43ddcdfbd0da..830c022c3624 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -371,12 +371,12 @@
 
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
-#define USB_DEVICE_ID_ELECOM_EX_G_WIRED	0x00fb
-#define USB_DEVICE_ID_ELECOM_EX_G_WIRELESS	0x00fc
-#define USB_DEVICE_ID_ELECOM_DEFT_WIRED	0x00fe
-#define USB_DEVICE_ID_ELECOM_DEFT_WIRELESS	0x00ff
-#define USB_DEVICE_ID_ELECOM_HUGE_WIRED	0x010c
-#define USB_DEVICE_ID_ELECOM_HUGE_WIRELESS	0x010d
+#define USB_DEVICE_ID_ELECOM_M_XT3URBK	0x00fb
+#define USB_DEVICE_ID_ELECOM_M_XT3DRBK	0x00fc
+#define USB_DEVICE_ID_ELECOM_M_DT1URBK	0x00fe
+#define USB_DEVICE_ID_ELECOM_M_DT1DRBK	0x00ff
+#define USB_DEVICE_ID_ELECOM_M_HT1URBK	0x010c
+#define USB_DEVICE_ID_ELECOM_M_HT1DRBK	0x010d
 
 #define USB_VENDOR_ID_DREAM_CHEEKY	0x1d34
 #define USB_DEVICE_ID_DREAM_CHEEKY_WN	0x0004
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 5f6035a5ce36..9675cd500776 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -335,12 +335,12 @@ static const struct hid_device_id hid_have_special_driver[] = {
 #endif
 #if IS_ENABLED(CONFIG_HID_ELECOM)
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_EX_G_WIRED) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_EX_G_WIRELESS) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_DEFT_WIRED) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_DEFT_WIRELESS) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_HUGE_WIRED) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_HUGE_WIRELESS) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3URBK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3DRBK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT1URBK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT1DRBK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1URBK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1DRBK) },
 #endif
 #if IS_ENABLED(CONFIG_HID_ELO)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELO, 0x0009) },
-- 
2.16.2
