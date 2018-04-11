Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeDKJuL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:50:11 -0400
Received: from hermes.apache.org ([140.211.11.3]:21300 "HELO mail.apache.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751883AbeDKJuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:50:09 -0400
From: Robert Munteanu <rombert@apache.org>
To: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Robert Munteanu <rombert@apache.org>
Subject: [PATCH v5] Fix modifier keys for Redragon Asura Keyboard
Date: Wed, 11 Apr 2018 12:49:53 +0300
Message-Id: <20180411094953.12053-1-rombert@apache.org>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:

- v2: modifier keys work, some combinations are still troublesome
- v3: style cleanup, rebase on top of 4.14
- v4: remove most debugging calls, make init info useful for user,
  rebased on top of 4.15
- v5: fix the HID descriptor as suggested by Benjamin Tissoires,
  use existing USB vendor id, update comment style, add SPDX
  license identifier, rename to hid-redragon, stop registering
  two input devices, rebased on top of 4.16

Signed-off-by: Robert Munteanu <rombert@apache.org>
---
 drivers/hid/Kconfig        |  7 ++++
 drivers/hid/Makefile       |  1 +
 drivers/hid/hid-ids.h      |  1 +
 drivers/hid/hid-quirks.c   |  3 ++
 drivers/hid/hid-redragon.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 101 insertions(+)
 create mode 100644 drivers/hid/hid-redragon.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 19c499f5623d..1125e4813716 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -560,6 +560,13 @@ config HID_MAYFLASH
 	Say Y here if you have HJZ Mayflash PS3 game controller adapters
 	and want to enable force feedback support.
 
+config HID_REDRAGON
+	tristate "Redragon keyboards"
+	depends on HID
+	default !EXPERT
+	---help---
+    Support for Redragon keyboards that need fix-ups to work properly.
+
 config HID_MICROSOFT
 	tristate "Microsoft non-fully HID-compliant devices"
 	depends on HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index eb13b9e92d85..a36f3f40ba63 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -84,6 +84,7 @@ hid-picolcd-$(CONFIG_DEBUG_FS)		+= hid-picolcd_debugfs.o
 
 obj-$(CONFIG_HID_PLANTRONICS)	+= hid-plantronics.o
 obj-$(CONFIG_HID_PRIMAX)	+= hid-primax.o
+obj-$(CONFIG_HID_REDRAGON)	+= hid-redragon.o
 obj-$(CONFIG_HID_RETRODE)	+= hid-retrode.o
 obj-$(CONFIG_HID_ROCCAT)	+= hid-roccat.o hid-roccat-common.o \
 	hid-roccat-arvo.o hid-roccat-isku.o hid-roccat-kone.o \
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 9454ac134ce2..41a64d0e91f9 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -599,6 +599,7 @@
 #define USB_VENDOR_ID_JESS		0x0c45
 #define USB_DEVICE_ID_JESS_YUREX	0x1010
 #define USB_DEVICE_ID_ASUS_MD_5112	0x5112
+#define USB_DEVICE_ID_REDRAGON_ASURA	0x760b
 
 #define USB_VENDOR_ID_JESS2		0x0f30
 #define USB_DEVICE_ID_JESS2_COLOR_RUMBLE_PAD 0x0111
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index e92b77fa574a..5f1253f1739a 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -557,6 +557,9 @@ static const struct hid_device_id hid_have_special_driver[] = {
 #if IS_ENABLED(CONFIG_HID_PRODIKEYS)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CREATIVELABS, USB_DEVICE_ID_PRODIKEYS_PCMIDI) },
 #endif
+#if IS_ENABLED(CONFIG_HID_REDRAGON)
+	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS,  USB_DEVICE_ID_REDRAGON_ASURA) },
+#endif
 #if IS_ENABLED(CONFIG_HID_RETRODE)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_FUTURE_TECHNOLOGY, USB_DEVICE_ID_RETRODE2) },
 #endif
diff --git a/drivers/hid/hid-redragon.c b/drivers/hid/hid-redragon.c
new file mode 100644
index 000000000000..ff98a5dbb8e2
--- /dev/null
+++ b/drivers/hid/hid-redragon.c
@@ -0,0 +1,89 @@
+/*
+ *  HID driver for Redragon keyboards
+ *
+ *  Copyright (c) 2017 Robert Munteanu
+ *  SPDX-License-Identifier: GPL-2.0
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
+/*
+ * The Redragon Asura keyboard sends an incorrect HID descriptor.
+ * At byte 100 it contains
+ *
+ *   0x81, 0x00
+ *
+ * which is Input (Data, Arr, Abs), but it should be
+ *
+ *   0x81, 0x02
+ *
+ * which is Input (Data, Var, Abs), which is consistent with the way
+ * key codes are generated.
+ */
+
+static __u8 *redragon_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+	unsigned int *rsize)
+{
+	if (*rsize >= 102 && rdesc[100] == 0x81 && rdesc[101] == 0x00) {
+		dev_info(&hdev->dev, "Fixing Redragon ASURA report descriptor.\n");
+		rdesc[101] = 0x02;
+	}
+
+	return rdesc;
+}
+
+static int redragon_probe(struct hid_device *dev,
+	const struct hid_device_id *id)
+{
+	int ret;
+
+	ret = hid_parse(dev);
+	if (ret) {
+		hid_err(dev, "parse failed\n");
+		return ret;
+	}
+
+	/* do not register unused input device */
+	if (dev->maxapplication == 1)
+		return 0;
+
+	ret = hid_hw_start(dev, HID_CONNECT_DEFAULT);
+	if (ret) {
+		hid_err(dev, "hw start failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+static const struct hid_device_id redragon_devices[] = {
+	{HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_REDRAGON_ASURA)},
+	{}
+};
+
+MODULE_DEVICE_TABLE(hid, redragon_devices);
+
+static struct hid_driver redragon_driver = {
+	.name = "redragon",
+	.id_table = redragon_devices,
+	.report_fixup = redragon_report_fixup,
+	.probe = redragon_probe
+};
+
+module_hid_driver(redragon_driver);
+
+MODULE_LICENSE("GPL");
-- 
2.16.3
