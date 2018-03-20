Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeCTLFG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:05:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752753AbeCTLFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:05:01 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/7] HID: multitouch: remove dead zones of Razer Blade Stealth
Date: Tue, 20 Mar 2018 12:04:46 +0100
Message-Id: <20180320110451.16582-3-benjamin.tissoires@redhat.com>
In-Reply-To: <20180320110451.16582-1-benjamin.tissoires@redhat.com>
References: <20180320110451.16582-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Razer Blade Stealth detects palms too aggressively and this creates
a dead zone around the touchpad. Users like being able to use their
entire touchpad, so we should probably not filter out the "palm" events
from the device and report them as regular touches, leaving the palm
detection up to the upper stack

Link: https://bugs.freedesktop.org/show_bug.cgi?id=105409

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index fc80a9bf3e39..520cb5e2c5c3 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -184,6 +184,7 @@ static void mt_post_parse(struct mt_device *td);
 #define MT_CLS_ASUS				0x010b
 #define MT_CLS_VTL				0x0110
 #define MT_CLS_GOOGLE				0x0111
+#define MT_CLS_RAZER_BLADE_STEALTH		0x0112
 
 #define MT_DEFAULT_MAXCONTACT	10
 #define MT_MAX_MAXCONTACT	250
@@ -326,6 +327,13 @@ static struct mt_class mt_classes[] = {
 			MT_QUIRK_SLOT_IS_CONTACTID |
 			MT_QUIRK_HOVERING
 	},
+	{ .name = MT_CLS_RAZER_BLADE_STEALTH,
+		.quirks = MT_QUIRK_ALWAYS_VALID |
+			MT_QUIRK_IGNORE_DUPLICATES |
+			MT_QUIRK_HOVERING |
+			MT_QUIRK_CONTACT_CNT_ACCURATE |
+			MT_QUIRK_WIN8_PTP_BUTTONS,
+	},
 	{ }
 };
 
@@ -1792,6 +1800,11 @@ static const struct hid_device_id mt_devices[] = {
 		MT_USB_DEVICE(USB_VENDOR_ID_QUANTA,
 			USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3001) },
 
+	/* Razer touchpads */
+	{ .driver_data = MT_CLS_RAZER_BLADE_STEALTH,
+		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_SYNAPTICS, 0x8323) },
+
 	/* Stantum panels */
 	{ .driver_data = MT_CLS_CONFIDENCE,
 		MT_USB_DEVICE(USB_VENDOR_ID_STANTUM_STM,
-- 
2.14.3
