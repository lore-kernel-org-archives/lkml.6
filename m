Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751087AbeBJRTR (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 12:19:17 -0500
Received: from arianus.sliepen.org ([92.243.30.131]:38096 "EHLO
        arianus.sliepen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750857AbeBJRTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 12:19:16 -0500
From: Guus Sliepen <guus@sliepen.org>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        jikos@kernel.org
Cc: Guus Sliepen <guus@sliepen.org>
Subject: [PATCH] HID: corsair: Add support for the GLAIVE RGB gaming mouse
Date: Sat, 10 Feb 2018 18:12:12 +0100
Message-Id: <20180210171212.7988-1-guus@sliepen.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This mouse sold by Corsair as the GLAIVE RGB gaming mouse has the same
problem with its HID reports as the Scimitar PRO RGB, so reuse the
same fix for the GLAIVE RGB.

Signed-off-by: Guus Sliepen <guus@sliepen.org>
---
 drivers/hid/hid-corsair.c | 16 ++++++++++------
 drivers/hid/hid-ids.h     |  1 +
 drivers/hid/hid-quirks.c  |  2 ++
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
index 9ba5d98a1..6c9c8fe1b 100644
--- a/drivers/hid/hid-corsair.c
+++ b/drivers/hid/hid-corsair.c
@@ -673,7 +673,7 @@ static int corsair_input_mapping(struct hid_device *dev,
 }
 
 /*
- * The report descriptor of Corsair Scimitar RGB Pro gaming mouse is
+ * The report descriptor of some of the Corsair gaming mice is
  * non parseable as they define two consecutive Logical Minimum for
  * the Usage Page (Consumer) in rdescs bytes 75 and 77 being 77 0x16
  * that should be obviousy 0x26 for Logical Magimum of 16 bits. This
@@ -681,7 +681,8 @@ static int corsair_input_mapping(struct hid_device *dev,
  * Minimum being larger than Logical Maximum.
  *
  * This driver fixes the report descriptor for:
- * - USB ID b1c:1b3e, sold as Scimitar RGB Pro Gaming mouse
+ * - USB ID 1b1c:1b34, sold as GLAIVE RGB Gaming mouse
+ * - USB ID 1b1c:1b3e, sold as Scimitar RGB Pro Gaming mouse
  */
 
 static __u8 *corsair_mouse_report_fixup(struct hid_device *hdev, __u8 *rdesc,
@@ -691,13 +692,14 @@ static __u8 *corsair_mouse_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 
 	if (intf->cur_altsetting->desc.bInterfaceNumber == 1) {
 		/*
-		 * Corsair Scimitar RGB Pro report descriptor is broken and
-		 * defines two different Logical Minimum for the Consumer
-		 * Application. The byte 77 should be a 0x26 defining a 16
-		 * bits integer for the Logical Maximum but it is a 0x16
+		 * Corsair GLAIVE RGB and Scimitar RGB Pro report descriptor is
+		 * broken and defines two different Logical Minimum for the
+		 * Consumer Application. The byte 77 should be a 0x26 defining
+		 * a 16 bits integer for the Logical Maximum but it is a 0x16
 		 * instead (Logical Minimum)
 		 */
 		switch (hdev->product) {
+		case USB_DEVICE_ID_CORSAIR_GLAIVE_RGB:
 		case USB_DEVICE_ID_CORSAIR_SCIMITAR_PRO_RGB:
 			if (*rsize >= 172 && rdesc[75] == 0x15 && rdesc[77] == 0x16
 			&& rdesc[78] == 0xff && rdesc[79] == 0x0f) {
@@ -715,6 +717,8 @@ static const struct hid_device_id corsair_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_K90),
 		.driver_data = CORSAIR_USE_K90_MACRO |
 			       CORSAIR_USE_K90_BACKLIGHT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR,
+            USB_DEVICE_ID_CORSAIR_GLAIVE_RGB) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR,
             USB_DEVICE_ID_CORSAIR_SCIMITAR_PRO_RGB) },
 	{}
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 43ddcdfbd..a099e5194 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -291,6 +291,7 @@
 #define USB_DEVICE_ID_CORSAIR_K70RGB    0x1b13
 #define USB_DEVICE_ID_CORSAIR_STRAFE    0x1b15
 #define USB_DEVICE_ID_CORSAIR_K65RGB    0x1b17
+#define USB_DEVICE_ID_CORSAIR_GLAIVE_RGB        0x1b34
 #define USB_DEVICE_ID_CORSAIR_K70RGB_RAPIDFIRE  0x1b38
 #define USB_DEVICE_ID_CORSAIR_K65RGB_RAPIDFIRE  0x1b39
 #define USB_DEVICE_ID_CORSAIR_SCIMITAR_PRO_RGB  0x1b3e
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 5f6035a5c..7203eba3c 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -62,6 +62,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_K70R), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_K95RGB), HID_QUIRK_NO_INIT_REPORTS | HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_M65RGB), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_GLAIVE_RGB), HID_QUIRK_NO_INIT_REPORTS | HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_SCIMITAR_PRO_RGB), HID_QUIRK_NO_INIT_REPORTS | HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_STRAFE), HID_QUIRK_NO_INIT_REPORTS | HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CREATIVELABS, USB_DEVICE_ID_CREATIVE_SB_OMNI_SURROUND_51), HID_QUIRK_NOGET },
@@ -317,6 +318,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 #endif
 #if IS_ENABLED(CONFIG_HID_CORSAIR)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_K90) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_GLAIVE_RGB) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_SCIMITAR_PRO_RGB) },
 #endif
 #if IS_ENABLED(CONFIG_HID_CP2112)
-- 
2.16.1
