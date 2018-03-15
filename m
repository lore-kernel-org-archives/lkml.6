Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751559AbeCOB2m (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 21:28:42 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35981 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbeCOB2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 21:28:40 -0400
X-Google-Smtp-Source: AG47ELswbdKJfzYm7pvIsnk/RKca+YznefmZalhWnq3H9BUURVZBC0m24EBruPxh2hNCkbPEtGefIg==
From: Nicolas Boichat <drinkcat@chromium.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        groeck@chromium.org, dtor@chromium.org
Subject: [PATCH] HID: google: add google hammer HID driver
Date: Thu, 15 Mar 2018 09:28:25 +0800
Message-Id: <20180315012825.145329-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei-Ning Huang <wnhuang@chromium.org>

Add Google hammer HID driver. This driver allow us to control hammer
keyboard backlight and support future features.

Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

Changes since v4:
 - HID quirk is actually not necessary, as recent kernel always prefers
   binding specialized drivers over hid-generic.
 - Rework backlight detection, relying only on HID report descriptor. We
   also make the test a little more specific, to make sure the output
   descriptor is actually a backlight control.

Changes since v3:
 - Rebase on latest linux-next/master, which moved the quirk list from
   hid-core.c to hid-quirks.c. Also, completely rework the logic to make
   it possible to bind google-hammer driver to keyboard interface, and
   generic multitouch driver to touchpad interface, as it is much simpler
   to do now that quirks are read early in hid_add_device.
 - Add dynamic backlight detection support (only such devices have an
   output HID descriptor).
 - Add support for wand (one more USB product ID).
 - Add SPDX-License-Identifier, fix one minor formatting issue.

 drivers/hid/Kconfig             |   6 ++
 drivers/hid/Makefile            |   1 +
 drivers/hid/hid-google-hammer.c | 124 ++++++++++++++++++++++++++++++++
 drivers/hid/hid-ids.h           |   3 +
 4 files changed, 134 insertions(+)
 create mode 100644 drivers/hid/hid-google-hammer.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 1fce4c94e5ac..60252fd796f6 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -339,6 +339,12 @@ config HOLTEK_FF
 	  Say Y here if you have a Holtek On Line Grip based game controller
 	  and want to have force feedback support for it.
 
+config HID_GOOGLE_HAMMER
+	tristate "Google Hammer Keyboard"
+	depends on USB_HID && LEDS_CLASS
+	---help---
+	Say Y here if you have a Google Hammer device.
+
 config HID_GT683R
 	tristate "MSI GT68xR LED support"
 	depends on LEDS_CLASS && USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 713601c7bfa6..17a8bd97da9d 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_HID_ELO)		+= hid-elo.o
 obj-$(CONFIG_HID_EZKEY)		+= hid-ezkey.o
 obj-$(CONFIG_HID_GEMBIRD)	+= hid-gembird.o
 obj-$(CONFIG_HID_GFRM)		+= hid-gfrm.o
+obj-$(CONFIG_HID_GOOGLE_HAMMER)	+= hid-google-hammer.o
 obj-$(CONFIG_HID_GT683R)	+= hid-gt683r.o
 obj-$(CONFIG_HID_GYRATION)	+= hid-gyration.o
 obj-$(CONFIG_HID_HOLTEK)	+= hid-holtek-kbd.o
diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
new file mode 100644
index 000000000000..6486469ce0f6
--- /dev/null
+++ b/drivers/hid/hid-google-hammer.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  HID driver for Google Hammer device.
+ *
+ *  Copyright (c) 2017 Google Inc.
+ *  Author: Wei-Ning Huang <wnhuang@google.com>
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <linux/hid.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+
+#include "hid-ids.h"
+
+#define MAX_BRIGHTNESS 100
+
+/* HID usage for keyboard backlight (Alphanumeric display brightness) */
+#define HID_AD_BRIGHTNESS 0x00140046
+
+struct hammer_kbd_leds {
+	struct led_classdev cdev;
+	struct hid_device *hdev;
+	u8 buf[2] ____cacheline_aligned;
+};
+
+static int hammer_kbd_brightness_set_blocking(struct led_classdev *cdev,
+		enum led_brightness br)
+{
+	struct hammer_kbd_leds *led = container_of(cdev,
+						   struct hammer_kbd_leds,
+						   cdev);
+	int ret;
+
+	led->buf[0] = 0;
+	led->buf[1] = br;
+
+	ret = hid_hw_output_report(led->hdev, led->buf, sizeof(led->buf));
+	if (ret == -ENOSYS)
+		ret = hid_hw_raw_request(led->hdev, 0, led->buf,
+					 sizeof(led->buf),
+					 HID_OUTPUT_REPORT,
+					 HID_REQ_SET_REPORT);
+	if (ret < 0)
+		hid_err(led->hdev, "failed to set keyboard backlight: %d\n",
+			ret);
+	return ret;
+}
+
+static int hammer_register_leds(struct hid_device *hdev)
+{
+	struct hammer_kbd_leds *kbd_backlight;
+
+	kbd_backlight = devm_kzalloc(&hdev->dev,
+				     sizeof(*kbd_backlight),
+				     GFP_KERNEL);
+	if (!kbd_backlight)
+		return -ENOMEM;
+
+	kbd_backlight->hdev = hdev;
+	kbd_backlight->cdev.name = "hammer::kbd_backlight";
+	kbd_backlight->cdev.max_brightness = MAX_BRIGHTNESS;
+	kbd_backlight->cdev.brightness_set_blocking =
+		hammer_kbd_brightness_set_blocking;
+	kbd_backlight->cdev.flags = LED_HW_PLUGGABLE;
+
+	/* Set backlight to 0% initially. */
+	hammer_kbd_brightness_set_blocking(&kbd_backlight->cdev, 0);
+
+	return devm_led_classdev_register(&hdev->dev, &kbd_backlight->cdev);
+}
+
+static int hammer_input_configured(struct hid_device *hdev,
+				   struct hid_input *hi)
+{
+	struct list_head *report_list =
+		&hdev->report_enum[HID_OUTPUT_REPORT].report_list;
+	struct hid_report *report;
+
+	if (list_empty(report_list))
+		return 0;
+
+	report = list_first_entry(report_list, struct hid_report, list);
+
+	if (report->maxfield == 1 &&
+	    report->field[0]->application == HID_GD_KEYBOARD &&
+	    report->field[0]->maxusage == 1 &&
+	    report->field[0]->usage[0].hid == HID_AD_BRIGHTNESS) {
+		int err = hammer_register_leds(hdev);
+
+		if (err)
+			hid_warn(hdev,
+				"Failed to register keyboard backlight: %d\n",
+				err);
+	}
+
+	return 0;
+}
+
+static const struct hid_device_id hammer_devices[] = {
+	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_HAMMER) },
+	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STAFF) },
+	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_WAND) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, hammer_devices);
+
+static struct hid_driver hammer_driver = {
+	.name = "hammer",
+	.id_table = hammer_devices,
+	.input_configured = hammer_input_configured,
+};
+module_hid_driver(hammer_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 41f227a841fb..5a3a7ead3012 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -448,7 +448,10 @@
 #define USB_DEVICE_ID_GOODTOUCH_000f	0x000f
 
 #define USB_VENDOR_ID_GOOGLE		0x18d1
+#define USB_DEVICE_ID_GOOGLE_HAMMER	0x5022
 #define USB_DEVICE_ID_GOOGLE_TOUCH_ROSE	0x5028
+#define USB_DEVICE_ID_GOOGLE_STAFF	0x502b
+#define USB_DEVICE_ID_GOOGLE_WAND	0x502d
 
 #define USB_VENDOR_ID_GOTOP		0x08f2
 #define USB_DEVICE_ID_SUPER_Q2		0x007f
-- 
2.16.2.804.g6dcf76e118-goog
