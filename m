Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751586AbeCUKu1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 06:50:27 -0400
Received: from hermes.apache.org ([140.211.11.3]:64938 "HELO mail.apache.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751477AbeCUKuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 06:50:22 -0400
From: Robert Munteanu <rombert@apache.org>
To: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Robert Munteanu <rombert@apache.org>
Subject: [PATCH v3] Fix modifier keys for Redragon Asura Keyboard
Date: Wed, 21 Mar 2018 11:43:31 +0100
Message-Id: <20180321104331.22783-1-rombert@apache.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The microdia family of keyboards uses a non-standard way of sending
modifier keys.

The down event always sets the first bit to 0x04 and the second keycode
to a custom value For instance, left shift sends the following bits

  04 02 00 00 00 00 00 00

while left control sends

  04 01 00 00 00 00 00 00

As a result all modifier keys are mapped to left shift and the keyboard is
non-functional in that respect. To solve the problem, we capture the
raw data in raw_event and manually generate the correct input events.

The keyboard functions mostly as expected now, with only a few minor
issues:

- two USB devices are detected instead of 1
- some key combinations are not triggered - e.g.
  left shift + left ctrl + p. However, the same combination is recognized
  with the right shift key.

Changelog:

- v2: modifier keys work, some combinations are still troublesome
- v3: style cleanup, rebase on top of 4.14
- v4: remove most debugging calls, make init info useful for user,
  rebased on top of 4.15

Signed-off-by: Robert Munteanu <rombert@apache.org>
---
 drivers/hid/Kconfig        |   9 +++
 drivers/hid/Makefile       |   2 +-
 drivers/hid/hid-core.c     |   3 +
 drivers/hid/hid-ids.h      |   3 +
 drivers/hid/hid-microdia.c | 148 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 164 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hid/hid-microdia.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 779c5ae47f36..c3350f2ec4ea 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -548,6 +548,15 @@ config HID_MAYFLASH
 	Say Y here if you have HJZ Mayflash PS3 game controller adapters
 	and want to enable force feedback support.
 
+config HID_MICRODIA
+	tristate "Microdia based keyboards"
+	depends on HID
+	default !EXPERT
+	---help---
+    Support for Microdia devices that are not compliant with the HID standard.
+
+    One known example if the Redragon Asura Keyboard.
+
 config HID_MICROSOFT
 	tristate "Microsoft non-fully HID-compliant devices"
 	depends on HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 235bd2a7b333..e66a305876c5 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_HID_LOGITECH_DJ)	+= hid-logitech-dj.o
 obj-$(CONFIG_HID_LOGITECH_HIDPP)	+= hid-logitech-hidpp.o
 obj-$(CONFIG_HID_MAGICMOUSE)	+= hid-magicmouse.o
 obj-$(CONFIG_HID_MAYFLASH)	+= hid-mf.o
+obj-$(CONFIG_HID_MICRODIA)  += hid-microdia.o
 obj-$(CONFIG_HID_MICROSOFT)	+= hid-microsoft.o
 obj-$(CONFIG_HID_MONTEREY)	+= hid-monterey.o
 obj-$(CONFIG_HID_MULTITOUCH)	+= hid-multitouch.o
@@ -121,4 +122,3 @@ obj-$(CONFIG_USB_KBD)		+= usbhid/
 
 obj-$(CONFIG_I2C_HID)		+= i2c-hid/
 
-obj-$(CONFIG_INTEL_ISH_HID)	+= intel-ish-hid/
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 0c3f608131cf..b36c2df4b755 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2393,6 +2393,9 @@ static const struct hid_device_id hid_have_special_driver[] = {
 #endif
 #if IS_ENABLED(CONFIG_HID_ZYDACRON)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ZYDACRON, USB_DEVICE_ID_ZYDACRON_REMOTE_CONTROL) },
+#endif
+#if IS_ENABLED(CONFIG_HID_MICRODIA)
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICRODIA,  USB_DEVICE_ID_REDRAGON_ASURA) },
 #endif
 	{ }
 };
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 5da3d6256d25..146869e55c5a 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1171,4 +1171,7 @@
 #define USB_VENDOR_ID_UGTIZER			0x2179
 #define USB_DEVICE_ID_UGTIZER_TABLET_GP0610	0x0053
 
+#define USB_VENDOR_ID_MICRODIA          0x0c45
+#define USB_DEVICE_ID_REDRAGON_ASURA    0x760b
+
 #endif
diff --git a/drivers/hid/hid-microdia.c b/drivers/hid/hid-microdia.c
new file mode 100644
index 000000000000..f9d8de18a989
--- /dev/null
+++ b/drivers/hid/hid-microdia.c
@@ -0,0 +1,148 @@
+/*
+ *  HID driver for Microdia-based keyboards
+ *
+ *  Copyright (c) 2017 Robert Munteanu
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <linux/device.h>
+#include <linux/input.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+#include <linux/log2.h>
+#include <linux/input-event-codes.h>
+
+#include "hid-ids.h"
+
+
+// The microdia family of keyboards uses a non-standard way of sending
+// modifier keys
+//
+// The down event always sets the first bit to 0x04 and the second keycode
+// to a custom value. For instance, left shift sends the following bits
+//
+//   04 02 00 00 00 00 00 00
+//
+// while left control sends
+//
+//   04 01 00 00 00 00 00 00
+//
+// Unfortunately these are all mapped to left shift and the keyboard is
+// non-functional in that respect. To solve the problem, we capture the
+// raw data in raw_event and manually generate the correct input events
+//
+// TODO
+//
+// 1. Some modifiers keys still don't work, e.g. Ctrl-Shift-P
+//    Interestingly enough, this happens when pressing the physical
+//    left shift key, but now when pressing the physical right shift key.
+//    hexdump does not show them either.
+// 2. A second USB keyboard is registered, but it should be removed
+// 3. Modifier keys sometimes get stuck, need to re-press to clear
+
+static int microdia_input_configured(struct hid_device *hdev,
+	struct hid_input *hi)
+{
+
+	hid_info(hdev, "Keyboard configured with limited support (modifier keys may get stuck, some modifiers combinations with left-shift not working) ");
+
+	hid_set_drvdata(hdev, hi);
+
+	return 0;
+}
+
+static int microdia_input_mapping(struct hid_device *hdev, struct hid_input *hi,
+		struct hid_field *field, struct hid_usage *usage,
+		unsigned long **bit, int *max)
+{
+	// do not map left shift since we will manually generate input
+	// events in microdia_raw_event
+	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_KEYBOARD)
+		if ((usage->hid & HID_USAGE) == 0xe1)
+			return -1;
+
+	return 0;
+}
+
+// array index of a modifier matches the bit index in the data payload
+// the modifier data is always stored in the second int
+// e.g. for left alt the 1 bit is set - 04 04 ...
+// TODO - second entry should be left shift, but that's not possible
+// since we ignore it in the mapping
+static int microdia_modifiers[7] = {
+		KEY_LEFTCTRL,
+		KEY_RIGHTSHIFT,
+		KEY_LEFTALT,
+		KEY_LEFTMETA,
+		KEY_RIGHTCTRL,
+		KEY_RIGHTSHIFT,
+		KEY_RIGHTALT
+};
+
+static int microdia_last_handled_modifier;
+
+static int microdia_raw_event(struct hid_device *hdev,
+		struct hid_report *report, u8 *data, int size)
+{
+	int i, changed_key, new_value, mapped_key;
+	struct hid_input *hi;
+
+	// 1. validate that we get 8 bits of the for 04 xx 00 00 00 00 00 00
+	if (size != 8)
+		return 0;
+
+	if (data[0] != 4)
+		return 0;
+
+	// TODO - can I somehow use a bit mask? data & 0x00ffffff != 0
+	for (i = 2; i < size; i++)
+		if (data[i] != 0)
+			return 0;
+
+	// TODO - don't process the keyup event 04 00 00 00 00 00 00 00
+	// if we don't expect a modifier key 'up' event
+
+	// 2. detect based on previous data what key was pressed or depressed
+	// a key was pressed or depressed if its bit has a different value
+	// between this and the previous invocation. If the bit is set
+	// it was pressed
+
+	changed_key = data[1] ^ microdia_last_handled_modifier;
+	new_value = (data[1] & changed_key) != 0;
+	// TODO - is ilog2 really needed?
+	mapped_key = microdia_modifiers[ilog2(changed_key)];
+
+	// 3. report the key event and track what was sent
+	hi = hid_get_drvdata(hdev);
+
+	input_report_key(hi->input, mapped_key, new_value);
+
+	microdia_last_handled_modifier = data[1];
+
+	return 1;
+}
+
+static const struct hid_device_id microdia_devices[] = {
+	{HID_USB_DEVICE(USB_VENDOR_ID_MICRODIA, USB_DEVICE_ID_REDRAGON_ASURA)},
+	{}
+};
+
+MODULE_DEVICE_TABLE(hid, microdia_devices);
+
+static struct hid_driver microdia_driver = {
+	.name = "microdia",
+	.input_mapping = microdia_input_mapping,
+	.id_table = microdia_devices,
+	.raw_event = microdia_raw_event,
+	.input_configured = microdia_input_configured,
+};
+
+module_hid_driver(microdia_driver);
+
+MODULE_LICENSE("GPL");
-- 
2.16.2
