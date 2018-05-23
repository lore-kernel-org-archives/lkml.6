Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754684AbeEWQDT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 12:03:19 -0400
Received: from zoot.epublica.de ([78.46.103.157]:44962 "EHLO zoot.epublica.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753723AbeEWQDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 12:03:15 -0400
To: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
From: Hanno Zulla <abos@hanno.de>
Subject: [PATCH] HID: Add support for 146b:0902 Bigben Interactive Kids'
 gamepad
Cc: linux-kernel@vger.kernel.org
Message-ID: <31245206-038e-4a5b-a1a1-8877463556a7@hanno.de>
Date: Wed, 23 May 2018 17:57:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------5BFA2B3E0B9A52F8A48CBA63"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5BFA2B3E0B9A52F8A48CBA63
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello,

this is a driver for the "BigBen Interactive Kid-friendly Wired
Controller PS3OFMINIPAD SONY" [1] with USB id 146b:0902. It was
originally sold as a PS3 accessory and serves as a very nice gamepad for
Retropie.

With the help of serialusb [2], it was possible to analyze the protocol
used by the gamepad and fix the missing entries for the descriptor.


This is my *first* driver, so please review accordingly.


Three things where I'm not sure and hope to hear from you about:

- is that the correct use of hid_validate_values() in bigben_probe()?

- is the error handling in bigben_probe() correct?

- how do I properly test possible suspend/resume scenarios?

Thanks,

Hanno


[1]
<https://www.bigben-interactive.co.uk/bigben-products/gaming-accessories/wired-mini-controller-ps3>

[2] <https://github.com/matlo/serialusb>

--------------5BFA2B3E0B9A52F8A48CBA63
Content-Type: text/x-patch;
 name="0001-HID-Bigben-gamepad-driver.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-HID-Bigben-gamepad-driver.patch"


---
 drivers/hid/Kconfig        |  10 +
 drivers/hid/Makefile       |   1 +
 drivers/hid/hid-bigbenff.c | 429 +++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-ids.h      |   3 +
 drivers/hid/hid-quirks.c   |   3 +
 5 files changed, 446 insertions(+)
 create mode 100644 drivers/hid/hid-bigbenff.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 0000434a1fbd..30352520b012 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -182,6 +182,16 @@ config HID_BETOP_FF
 	Currently the following devices are known to be supported:
 	 - BETOP 2185 PC & BFM MODE
 
+config HID_BIGBEN_FF
+	tristate "BigBen Interactive force feedback support"
+	depends on USB_HID
+	depends on NEW_LEDS
+	depends on LEDS_CLASS
+	select INPUT_FF_MEMLESS
+	---help---
+	Say Y here if you want to enable force feedback and LED support for
+	the Kid-friendly Wired Controller gamepad made by BigBen Interactive.
+
 config HID_CHERRY
 	tristate "Cherry Cymotion keyboard"
 	depends on HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 17a8bd97da9d..db6365af3fcf 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_HID_ASUS)		+= hid-asus.o
 obj-$(CONFIG_HID_AUREAL)	+= hid-aureal.o
 obj-$(CONFIG_HID_BELKIN)	+= hid-belkin.o
 obj-$(CONFIG_HID_BETOP_FF)	+= hid-betopff.o
+obj-$(CONFIG_HID_BIGBEN_FF)	+= hid-bigbenff.o
 obj-$(CONFIG_HID_CHERRY)	+= hid-cherry.o
 obj-$(CONFIG_HID_CHICONY)	+= hid-chicony.o
 obj-$(CONFIG_HID_CMEDIA)	+= hid-cmedia.o
diff --git a/drivers/hid/hid-bigbenff.c b/drivers/hid/hid-bigbenff.c
new file mode 100644
index 000000000000..d08eea9e4382
--- /dev/null
+++ b/drivers/hid/hid-bigbenff.c
@@ -0,0 +1,429 @@
+/*
+ *  LED & force feedback support for BigBen Interactive
+ *
+ *  0x146b:0x0902 "Bigben Interactive Bigben Game Pad"
+ *  "Kid-friendly Wired Controller" PS3OFMINIPAD SONY
+ *  sold for use with the PS3
+ *
+ *  Copyright (c) 2018 Hanno Zulla <kontakt@hanno.de>
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+
+#include <linux/input.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/leds.h>
+#include <linux/hid.h>
+
+#include "hid-ids.h"
+
+
+/*
+ * The original descriptor for 0x146b:0x0902
+ *
+ *   0x05, 0x01,        // Usage Page (Generic Desktop Ctrls)
+ *   0x09, 0x05,        // Usage (Game Pad)
+ *   0xA1, 0x01,        // Collection (Application)
+ *   0x15, 0x00,        //   Logical Minimum (0)
+ *   0x25, 0x01,        //   Logical Maximum (1)
+ *   0x35, 0x00,        //   Physical Minimum (0)
+ *   0x45, 0x01,        //   Physical Maximum (1)
+ *   0x75, 0x01,        //   Report Size (1)
+ *   0x95, 0x0D,        //   Report Count (13)
+ *   0x05, 0x09,        //   Usage Page (Button)
+ *   0x19, 0x01,        //   Usage Minimum (0x01)
+ *   0x29, 0x0D,        //   Usage Maximum (0x0D)
+ *   0x81, 0x02,        //   Input (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position)
+ *   0x95, 0x03,        //   Report Count (3)
+ *   0x81, 0x01,        //   Input (Const,Array,Abs,No Wrap,Linear,Preferred State,No Null Position)
+ *   0x05, 0x01,        //   Usage Page (Generic Desktop Ctrls)
+ *   0x25, 0x07,        //   Logical Maximum (7)
+ *   0x46, 0x3B, 0x01,  //   Physical Maximum (315)
+ *   0x75, 0x04,        //   Report Size (4)
+ *   0x95, 0x01,        //   Report Count (1)
+ *   0x65, 0x14,        //   Unit (System: English Rotation, Length: Centimeter)
+ *   0x09, 0x39,        //   Usage (Hat switch)
+ *   0x81, 0x42,        //   Input (Data,Var,Abs,No Wrap,Linear,Preferred State,Null State)
+ *   0x65, 0x00,        //   Unit (None)
+ *   0x95, 0x01,        //   Report Count (1)
+ *   0x81, 0x01,        //   Input (Const,Array,Abs,No Wrap,Linear,Preferred State,No Null Position)
+ *   0x26, 0xFF, 0x00,  //   Logical Maximum (255)
+ *   0x46, 0xFF, 0x00,  //   Physical Maximum (255)
+ *   0x09, 0x30,        //   Usage (X)
+ *   0x09, 0x31,        //   Usage (Y)
+ *   0x09, 0x32,        //   Usage (Z)
+ *   0x09, 0x35,        //   Usage (Rz)
+ *   0x75, 0x08,        //   Report Size (8)
+ *   0x95, 0x04,        //   Report Count (4)
+ *   0x81, 0x02,        //   Input (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position)
+ *   0x06, 0x00, 0xFF,  //   Usage Page (Vendor Defined 0xFF00)
+ *   0x09, 0x20,        //   Usage (0x20)
+ *   0x09, 0x21,        //   Usage (0x21)
+ *   0x09, 0x22,        //   Usage (0x22)
+ *   0x09, 0x23,        //   Usage (0x23)
+ *   0x09, 0x24,        //   Usage (0x24)
+ *   0x09, 0x25,        //   Usage (0x25)
+ *   0x09, 0x26,        //   Usage (0x26)
+ *   0x09, 0x27,        //   Usage (0x27)
+ *   0x09, 0x28,        //   Usage (0x28)
+ *   0x09, 0x29,        //   Usage (0x29)
+ *   0x09, 0x2A,        //   Usage (0x2A)
+ *   0x09, 0x2B,        //   Usage (0x2B)
+ *   0x95, 0x0C,        //   Report Count (12)
+ *   0x81, 0x02,        //   Input (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position)
+ *   0x0A, 0x21, 0x26,  //   Usage (0x2621)
+ *   0x95, 0x08,        //   Report Count (8)
+ *   0xB1, 0x02,        //   Feature (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position,Non-volatile)
+ *   0x0A, 0x21, 0x26,  //   Usage (0x2621)
+ *   0x91, 0x02,        //   Output (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position,Non-volatile)
+ *   0x26, 0xFF, 0x03,  //   Logical Maximum (1023)
+ *   0x46, 0xFF, 0x03,  //   Physical Maximum (1023)
+ *   0x09, 0x2C,        //   Usage (0x2C)
+ *   0x09, 0x2D,        //   Usage (0x2D)
+ *   0x09, 0x2E,        //   Usage (0x2E)
+ *   0x09, 0x2F,        //   Usage (0x2F)
+ *   0x75, 0x10,        //   Report Size (16)
+ *   0x95, 0x04,        //   Report Count (4)
+ *   0x81, 0x02,        //   Input (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position)
+ *   0xC0,              // End Collection
+ */
+
+#define PID0902_RDESC_ORIG_SIZE 137
+
+/*
+ * The fixed descriptor for 0x146b:0x0902
+ *
+ * - assign right stick from Z/Rz to Rx/Ry
+ * - map analog triggers to Z/RZ
+ * - simplify feature and output descriptor
+ */
+static __u8 pid0902_rdesc_fixed[] = {
+	0x05, 0x01,        // Usage Page (Generic Desktop Ctrls)
+	0x09, 0x05,        // Usage (Game Pad)
+	0xA1, 0x01,        // Collection (Application)
+	0x15, 0x00,        //   Logical Minimum (0)
+	0x25, 0x01,        //   Logical Maximum (1)
+	0x35, 0x00,        //   Physical Minimum (0)
+	0x45, 0x01,        //   Physical Maximum (1)
+	0x75, 0x01,        //   Report Size (1)
+	0x95, 0x0D,        //   Report Count (13)
+	0x05, 0x09,        //   Usage Page (Button)
+	0x19, 0x01,        //   Usage Minimum (0x01)
+	0x29, 0x0D,        //   Usage Maximum (0x0D)
+	0x81, 0x02,        //   Input (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position)
+	0x75, 0x01,        //   Report Size (1)
+	0x95, 0x03,        //   Report Count (3)
+	0x81, 0x01,        //   Input (Const,Array,Abs,No Wrap,Linear,Preferred State,No Null Position)
+	0x05, 0x01,        //   Usage Page (Generic Desktop Ctrls)
+	0x25, 0x07,        //   Logical Maximum (7)
+	0x46, 0x3B, 0x01,  //   Physical Maximum (315)
+	0x75, 0x04,        //   Report Size (4)
+	0x95, 0x01,        //   Report Count (1)
+	0x65, 0x14,        //   Unit (System: English Rotation, Length: Centimeter)
+	0x09, 0x39,        //   Usage (Hat switch)
+	0x81, 0x42,        //   Input (Data,Var,Abs,No Wrap,Linear,Preferred State,Null State)
+	0x65, 0x00,        //   Unit (None)
+	0x95, 0x01,        //   Report Count (1)
+	0x81, 0x01,        //   Input (Const,Array,Abs,No Wrap,Linear,Preferred State,No Null Position)
+	0x26, 0xFF, 0x00,  //   Logical Maximum (255)
+	0x46, 0xFF, 0x00,  //   Physical Maximum (255)
+	0x09, 0x30,        //   Usage (X)
+	0x09, 0x31,        //   Usage (Y)
+	0x09, 0x33,        //   Usage (Rx)
+	0x09, 0x34,        //   Usage (Ry)
+	0x75, 0x08,        //   Report Size (8)
+	0x95, 0x04,        //   Report Count (4)
+	0x81, 0x02,        //   Input (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position)
+	0x95, 0x0A,        //   Report Count (10)
+	0x81, 0x01,        //   Input (Const,Array,Abs,No Wrap,Linear,Preferred State,No Null Position)
+	0x05, 0x01,        //   Usage Page (Generic Desktop Ctrls)
+	0x26, 0xFF, 0x00,  //   Logical Maximum (255)
+	0x46, 0xFF, 0x00,  //   Physical Maximum (255)
+	0x09, 0x32,        //   Usage (Z)
+	0x09, 0x35,        //   Usage (Rz)
+	0x95, 0x02,        //   Report Count (2)
+	0x81, 0x02,        //   Input (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position)
+	0x95, 0x08,        //   Report Count (8)
+	0x81, 0x01,        //   Input (Const,Array,Abs,No Wrap,Linear,Preferred State,No Null Position)
+	0x06, 0x00, 0xFF,  //   Usage Page (Vendor Defined 0xFF00)
+	0xB1, 0x02,        //   Feature (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position,Non-volatile)
+	0x0A, 0x21, 0x26,  //   Usage (0x2621)
+	0x95, 0x08,        //   Report Count (8)
+	0x91, 0x02,        //   Output (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position,Non-volatile)
+	0x0A, 0x21, 0x26,  //   Usage (0x2621)
+	0x95, 0x08,        //   Report Count (8)
+	0x81, 0x02,        //   Input (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position)
+	0xC0,              // End Collection
+};
+
+
+#define NUM_LEDS 4
+
+struct bigben_device {
+	int device_id;
+	struct hid_device *hid;
+	struct hid_report *report;
+	u8 led_state;         // LED1 = 1 .. LED4 = 8
+	u8 right_motor_on;    // right motor off/on 0/1
+	u8 left_motor_force;  // left motor force 0-255
+	struct led_classdev *leds[NUM_LEDS];
+	bool work_led;
+	bool work_ff;
+	struct work_struct worker;
+};
+
+
+static void bigben_worker(struct work_struct *work)
+{
+	struct bigben_device *bigben = container_of(work,
+		struct bigben_device, worker);
+	struct hid_field *report_field = bigben->report->field[0];
+
+	if (bigben->work_led) {
+		bigben->work_led = false;
+		report_field->value[0] = 0x01; // 1 = led message
+		report_field->value[1] = 0x08; // reserved value, always 8
+		report_field->value[2] = bigben->led_state;
+		report_field->value[3] = 0x00; // padding
+		report_field->value[4] = 0x00; // padding
+		report_field->value[5] = 0x00; // padding
+		report_field->value[6] = 0x00; // padding
+		report_field->value[7] = 0x00; // padding
+		hid_hw_request(bigben->hid, bigben->report, HID_REQ_SET_REPORT);
+	}
+
+	if (bigben->work_ff) {
+		bigben->work_ff = false;
+		report_field->value[0] = 0x02; // 2 = rumble effect message
+		report_field->value[1] = 0x08; // reserved value, always 8
+		report_field->value[2] = bigben->right_motor_on;
+		report_field->value[3] = bigben->left_motor_force;
+		report_field->value[4] = 0xff; // duration 0-254 (255 = nonstop)
+		report_field->value[5] = 0x00; // padding
+		report_field->value[6] = 0x00; // padding
+		report_field->value[7] = 0x00; // padding
+		hid_hw_request(bigben->hid, bigben->report, HID_REQ_SET_REPORT);
+	}
+}
+
+static int hid_bigben_play(struct input_dev *dev, void *data,
+			 struct ff_effect *effect)
+{
+	struct bigben_device *bigben = data;
+	u8 right_motor_on;
+	u8 left_motor_force;
+
+	if (effect->type != FF_RUMBLE)
+		return 0;
+
+	right_motor_on   = effect->u.rumble.weak_magnitude ? 1 : 0;
+	left_motor_force = effect->u.rumble.strong_magnitude / 256;
+
+	if (right_motor_on != bigben->right_motor_on ||
+			left_motor_force != bigben->left_motor_force) {
+		bigben->right_motor_on   = right_motor_on;
+		bigben->left_motor_force = left_motor_force;
+		bigben->work_ff = true;
+		schedule_work(&bigben->worker);
+	}
+
+	return 0;
+}
+
+static void bigben_set_led(struct led_classdev *led,
+	enum led_brightness value)
+{
+	struct device *dev = led->dev->parent;
+	struct hid_device *hid = to_hid_device(dev);
+	struct bigben_device *bigben = hid_get_drvdata(hid);
+	int n;
+	bool work;
+
+	if (!bigben) {
+		hid_err(hid, "No device data\n");
+		return;
+	}
+
+	for (n = 0; n < NUM_LEDS; n++) {
+		if (led == bigben->leds[n]) {
+			if (value == LED_OFF) {
+				work = (bigben->led_state & BIT(n));
+				bigben->led_state &= ~BIT(n);
+			} else {
+				work = !(bigben->led_state & BIT(n));
+				bigben->led_state |= BIT(n);
+			}
+
+			if (work) {
+				bigben->work_led = true;
+				schedule_work(&bigben->worker);
+			}
+			return;
+		}
+	}
+}
+
+static enum led_brightness bigben_get_led(struct led_classdev *led)
+{
+	struct device *dev = led->dev->parent;
+	struct hid_device *hid = to_hid_device(dev);
+	struct bigben_device *bigben = hid_get_drvdata(hid);
+	int n;
+
+	if (!bigben) {
+		hid_err(hid, "No device data\n");
+		return LED_OFF;
+	}
+
+	for (n = 0; n < NUM_LEDS; n++) {
+		if (led == bigben->leds[n])
+			return (bigben->led_state & BIT(n)) ? LED_ON : LED_OFF;
+	}
+
+	return LED_OFF;
+}
+
+static void bigben_remove_leds(struct bigben_device *bigben) {
+	struct led_classdev *led;
+	int n;
+
+	for (n = 0; n < NUM_LEDS; n++) {
+		led = bigben->leds[n];
+		bigben->leds[n] = NULL;
+		if (!led)
+			continue;
+		led_classdev_unregister(led);
+		kfree(led);
+	}
+}
+
+static void bigben_remove(struct hid_device *hid)
+{
+	struct bigben_device *bigben = hid_get_drvdata(hid);
+	bigben_remove_leds(bigben);
+	cancel_work_sync(&bigben->worker);
+	hid_hw_close(hid);
+	hid_hw_stop(hid);
+}
+
+static int bigben_probe(struct hid_device *hid,
+	const struct hid_device_id *id)
+{
+	struct bigben_device *bigben;
+	struct hid_input *hidinput;
+	struct list_head *report_list;
+	struct led_classdev *led;
+	char *name;
+	size_t name_sz;
+	int n, error;
+
+	error = hid_parse(hid);
+	if (error) {
+		hid_err(hid, "parse failed\n");
+		return error;
+	}
+
+	error = hid_hw_start(hid, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
+	if (error) {
+		hid_err(hid, "hw start failed\n");
+		return error;
+	}
+
+	if (!hid_validate_values(hid, HID_OUTPUT_REPORT, 0, 0, 8))
+		return -ENODEV;
+
+	bigben = kzalloc(sizeof(*bigben), GFP_KERNEL);
+	if (!bigben)
+		return -ENOMEM;
+
+	hid_set_drvdata(hid, bigben);
+	bigben->hid = hid;
+	report_list = &hid->report_enum[HID_OUTPUT_REPORT].report_list;
+	bigben->report = list_entry(report_list->next,
+		struct hid_report, list);
+
+	hidinput = list_first_entry(&hid->inputs, struct hid_input, list);
+	set_bit(FF_RUMBLE, hidinput->input->ffbit);
+
+	INIT_WORK(&bigben->worker, bigben_worker);
+
+	error = input_ff_create_memless(hidinput->input, bigben,
+		hid_bigben_play);
+	if (error)
+		goto error;
+
+	name_sz = strlen(dev_name(&hid->dev)) + strlen("::bigben#") + 1;
+
+	for (n = 0; n < NUM_LEDS; n++) {
+		led = kzalloc(sizeof(struct led_classdev) + name_sz, GFP_KERNEL);
+		if (!led) {
+			error = -ENOMEM;
+			goto error;
+		}
+		name = (void *)(&led[1]);
+		snprintf(name, name_sz,
+			"%s::bigben%d",
+			dev_name(&hid->dev), n + 1
+		);
+		led->name = name;
+		led->brightness = (n == 0) ? LED_ON : LED_OFF;
+		led->max_brightness = 1;
+		led->brightness_get = bigben_get_led;
+		led->brightness_set = bigben_set_led;
+		bigben->leds[n] = led;
+		error = led_classdev_register(&hid->dev, led);
+		if (error)
+			goto error;
+	}
+
+	// initial state: LED1 is on, no rumble effect
+	bigben->led_state = 0b0001;
+	bigben->right_motor_on = 0;
+	bigben->left_motor_force = 0;
+	bigben->work_led = true;
+	bigben->work_ff = true;
+	schedule_work(&bigben->worker);
+
+	hid_info(hid, "Force feedback and LED support for BigBen gamepad\n");
+
+	return 0;
+
+error:
+	bigben_remove_leds(bigben);
+	kfree(bigben);
+	return error;
+}
+
+static __u8 *bigben_report_fixup(struct hid_device *hid, __u8 *rdesc,
+	unsigned int *rsize)
+{
+	if (*rsize == PID0902_RDESC_ORIG_SIZE) {
+		rdesc = pid0902_rdesc_fixed;
+		*rsize = sizeof(pid0902_rdesc_fixed);
+	}
+	return rdesc;
+}
+
+static const struct hid_device_id bigben_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_BIGBEN, USB_DEVICE_ID_BIGBEN_PS3OFMINIPAD) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, bigben_devices);
+
+static struct hid_driver bigben_driver = {
+	.name = "bigben",
+	.id_table = bigben_devices,
+	.probe = bigben_probe,
+	.report_fixup = bigben_report_fixup,
+	.remove = bigben_remove,
+};
+module_hid_driver(bigben_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 46f5ecd11bf7..50a7e7c63a37 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -227,6 +227,9 @@
 #define USB_VENDOR_ID_BETOP_2185V2PC	0x8380
 #define USB_VENDOR_ID_BETOP_2185V2BFM	0x20bc
 
+#define USB_VENDOR_ID_BIGBEN	0x146b
+#define USB_DEVICE_ID_BIGBEN_PS3OFMINIPAD	0x0902
+
 #define USB_VENDOR_ID_BTC		0x046e
 #define USB_DEVICE_ID_BTC_EMPREX_REMOTE	0x5578
 #define USB_DEVICE_ID_BTC_EMPREX_REMOTE_2	0x5577
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 587e2681a53f..f347df8767b3 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -303,6 +303,9 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BETOP_2185V2PC, 0x1850) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BETOP_2185V2BFM, 0x5500) },
 #endif
+#if IS_ENABLED(CONFIG_HID_BIGBEN_FF)
+	{ HID_USB_DEVICE(USB_VENDOR_ID_BIGBEN, USB_DEVICE_ID_BIGBEN_PS3OFMINIPAD) },
+#endif
 #if IS_ENABLED(CONFIG_HID_CHERRY)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHERRY, USB_DEVICE_ID_CHERRY_CYMOTION) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHERRY, USB_DEVICE_ID_CHERRY_CYMOTION_SOLAR) },
-- 
2.17.0


--------------5BFA2B3E0B9A52F8A48CBA63--
