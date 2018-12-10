Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD78C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983402082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983402082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbeLJQbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:31:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:45670 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726962AbeLJQbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:31:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3BC59AFE0;
        Mon, 10 Dec 2018 16:31:31 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Henrik Rydberg <rydberg@bitmath.org>
Cc:     linux-rpi-kernel@lists.infradead.org, stefan.wahren@i2se.com,
        eric@anholt.net, agraf@suse.de,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Rob Herring <robh@kernel.org>,
        Mark Jonas <mark.jonas@de.bosch.com>,
        Zhu Yi <yi.zhu5@cn.bosch.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Masanari Iida <standby24x7@gmail.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH 1/2] input: add official Raspberry Pi's touchscreen driver
Date:   Mon, 10 Dec 2018 17:30:20 +0100
Message-Id: <20181210163036.24813-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210163036.24813-1-nsaenzjulienne@suse.de>
References: <20181210163036.24813-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add's support to Raspberry Pi's 7" Touch device. Instead of using a
conventional bus all information is copied into a memory mapped area by
RPi's firmware.

Based on the driver found in RPi's kernel repository.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/input/touchscreen/Kconfig          |  12 ++
 drivers/input/touchscreen/Makefile         |   1 +
 drivers/input/touchscreen/raspberrypi-ts.c | 223 +++++++++++++++++++++
 3 files changed, 236 insertions(+)
 create mode 100644 drivers/input/touchscreen/raspberrypi-ts.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 2a80675cfd94..a9be434de738 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -696,6 +696,18 @@ config TOUCHSCREEN_EDT_FT5X06
 	  To compile this driver as a module, choose M here: the
 	  module will be called edt-ft5x06.
 
+config TOUCHSCREEN_RASPBERRYPI_TS
+	tristate "Raspberry Pi's firmware base touch screen support"
+	depends on RASPBERRYPI_FIRMWARE || COMPILE_TEST
+	help
+	  Say Y here if you have the offitial Raspberry Pi 7' scren on your
+	  system.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called raspberrypi-ts.
+
 config TOUCHSCREEN_MIGOR
 	tristate "Renesas MIGO-R touchscreen"
 	depends on (SH_MIGOR || COMPILE_TEST) && I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 5911a4190cd2..3eccb1925e89 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -109,3 +109,4 @@ obj-$(CONFIG_TOUCHSCREEN_ZET6223)	+= zet6223.o
 obj-$(CONFIG_TOUCHSCREEN_ZFORCE)	+= zforce_ts.o
 obj-$(CONFIG_TOUCHSCREEN_COLIBRI_VF50)	+= colibri-vf50-ts.o
 obj-$(CONFIG_TOUCHSCREEN_ROHM_BU21023)	+= rohm_bu21023.o
+obj-$(CONFIG_TOUCHSCREEN_RASPBERRYPI_TS)	+= raspberrypi-ts.o
diff --git a/drivers/input/touchscreen/raspberrypi-ts.c b/drivers/input/touchscreen/raspberrypi-ts.c
new file mode 100644
index 000000000000..edc92018687e
--- /dev/null
+++ b/drivers/input/touchscreen/raspberrypi-ts.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Raspberry Pi 3 firmware based touchscreen driver
+ *
+ * Copyright (C) 2015, 2017 Raspberry Pi
+ * Copyright (C) 2018 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
+ */
+
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/bitops.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/input-polldev.h>
+#include <linux/input/touchscreen.h>
+#include <soc/bcm2835/raspberrypi-firmware.h>
+
+#define RPI_TS_DEFAULT_WIDTH	800
+#define RPI_TS_DEFAULT_HEIGHT	480
+
+#define RPI_TS_MAX_SUPPORTED_POINTS	10
+
+#define RPI_TS_FTS_TOUCH_DOWN		0
+#define RPI_TS_FTS_TOUCH_CONTACT	2
+
+#define RPI_TS_POLL_INTERVAL		17	/* 60fps */
+
+struct rpi_ts {
+	struct platform_device *pdev;
+	struct input_polled_dev *poll_dev;
+	struct touchscreen_properties prop;
+
+	void __iomem *fw_regs_va;
+	dma_addr_t fw_regs_phys;
+
+	int known_ids;
+};
+
+struct rpi_ts_regs {
+	u8 device_mode;
+	u8 gesture_id;
+	u8 num_points;
+	struct rpi_ts_touch {
+		u8 xh;
+		u8 xl;
+		u8 yh;
+		u8 yl;
+		u8 pressure; /* Not supported */
+		u8 area;     /* Not supported */
+	} point[RPI_TS_MAX_SUPPORTED_POINTS];
+};
+
+/*
+ * We poll the memory based register copy of the touchscreen chip using the
+ * number of points register to know whether the copy has been updated (we
+ * write 99 to the memory copy, the GPU will write between 0 - 10 points)
+ */
+static void rpi_ts_poll(struct input_polled_dev *dev)
+{
+	struct input_dev *input = dev->input;
+	struct rpi_ts *ts = dev->private;
+	struct rpi_ts_regs regs;
+	int modified_ids = 0;
+	long released_ids;
+	int event_type;
+	int touchid;
+	int x, y;
+	int i;
+
+	memcpy_fromio(&regs, ts->fw_regs_va, sizeof(regs));
+	iowrite8(99, ts->fw_regs_va + offsetof(struct rpi_ts_regs, num_points));
+
+	if (regs.num_points == 99 ||
+	    (regs.num_points == 0 && ts->known_ids == 0))
+	    return;
+
+	for (i = 0; i < regs.num_points; i++) {
+		x = (((int)regs.point[i].xh & 0xf) << 8) + regs.point[i].xl;
+		y = (((int)regs.point[i].yh & 0xf) << 8) + regs.point[i].yl;
+		touchid = (regs.point[i].yh >> 4) & 0xf;
+		event_type = (regs.point[i].xh >> 6) & 0x03;
+
+		modified_ids |= BIT(touchid);
+
+		if (event_type == RPI_TS_FTS_TOUCH_DOWN ||
+		    event_type == RPI_TS_FTS_TOUCH_CONTACT) {
+			input_mt_slot(input, touchid);
+			input_mt_report_slot_state(input, MT_TOOL_FINGER, 1);
+			touchscreen_report_pos(input, &ts->prop, x, y, true);
+		}
+	}
+
+	released_ids = ts->known_ids & ~modified_ids;
+	for_each_set_bit(i, &released_ids, RPI_TS_MAX_SUPPORTED_POINTS) {
+		input_mt_slot(input, i);
+		input_mt_report_slot_state(input, MT_TOOL_FINGER, 0);
+		modified_ids &= ~(BIT(i));
+	}
+	ts->known_ids = modified_ids;
+
+	input_mt_sync_frame(input);
+	input_sync(input);
+}
+
+static void rpi_ts_dma_cleanup(void *data)
+{
+	struct rpi_ts *ts = data;
+	struct device *dev = &ts->pdev->dev;
+
+	if(ts->fw_regs_va)
+		dma_free_coherent(dev, PAGE_SIZE, ts->fw_regs_va,
+				  ts->fw_regs_phys);
+}
+
+static int rpi_ts_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct input_polled_dev *poll_dev;
+	struct device_node *fw_node;
+	struct rpi_firmware *fw;
+	struct input_dev *input;
+	struct rpi_ts *ts;
+	u32 touchbuf;
+	int ret;
+
+	fw_node = of_get_parent(np);
+	if (!fw_node) {
+		dev_err(dev, "Missing firmware node\n");
+		return -ENOENT;
+	}
+
+	fw = rpi_firmware_get(fw_node);
+	of_node_put(fw_node);
+	if (!fw)
+		return -EPROBE_DEFER;
+
+	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
+	if (!ts) {
+		dev_err(dev, "Failed to allocate memory\n");
+		return -ENOMEM;
+	}
+	ts->pdev = pdev;
+
+	ret = devm_add_action_or_reset(dev, rpi_ts_dma_cleanup, ts);
+	if (ret)
+		return ret;
+
+	ts->fw_regs_va = dma_zalloc_coherent(dev, PAGE_SIZE, &ts->fw_regs_phys,
+					     GFP_KERNEL);
+	if (!ts->fw_regs_va) {
+		dev_err(dev, "failed to dma_alloc_coherent\n");
+		return -ENOMEM;
+	}
+
+	touchbuf = (u32)ts->fw_regs_phys;
+	ret = rpi_firmware_property(fw, RPI_FIRMWARE_FRAMEBUFFER_SET_TOUCHBUF,
+				    &touchbuf, sizeof(touchbuf));
+
+	if (ret || touchbuf != 0) {
+		dev_warn(dev, "Failed to set touchbuf, trying to get err:%x\n",
+			 ret);
+		return ret;
+	}
+
+	poll_dev = devm_input_allocate_polled_device(dev);
+	if (!poll_dev) {
+		dev_err(dev, "Failed to allocate input device\n");
+		return -ENOMEM;
+	}
+	ts->poll_dev = poll_dev;
+	input = poll_dev->input;
+
+	input->name = "raspberrypi-ts";
+	input->id.bustype = BUS_HOST;
+	poll_dev->poll_interval = RPI_TS_POLL_INTERVAL;
+	poll_dev->poll = rpi_ts_poll;
+	poll_dev->private = ts;
+
+	__set_bit(EV_SYN, input->evbit);
+	__set_bit(EV_KEY, input->evbit);
+	__set_bit(EV_ABS, input->evbit);
+
+	input_set_abs_params(input, ABS_MT_POSITION_X, 0,
+			     RPI_TS_DEFAULT_WIDTH, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_Y, 0,
+			     RPI_TS_DEFAULT_HEIGHT, 0, 0);
+	touchscreen_parse_properties(input, true, &ts->prop);
+
+	input_mt_init_slots(input, RPI_TS_MAX_SUPPORTED_POINTS,
+			    INPUT_MT_DIRECT | INPUT_MT_POINTER);
+
+	ret = input_register_polled_device(poll_dev);
+	if (ret) {
+		dev_err(dev, "could not register input device, %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id rpi_ts_match[] = {
+	{ .compatible = "raspberrypi,firmware-ts", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rpi_ts_match);
+
+static struct platform_driver rpi_ts_driver = {
+	.driver = {
+		.name   = "raspberrypi-ts",
+		.of_match_table = rpi_ts_match,
+	},
+	.probe          = rpi_ts_probe,
+};
+module_platform_driver(rpi_ts_driver);
+
+MODULE_AUTHOR("Gordon Hollingworth");
+MODULE_AUTHOR("Nicolas Saenz Julienne <nsaenzjulienne@suse.de>");
+MODULE_DESCRIPTION("Raspberry Pi 3 firmware based touchscreen driver");
+MODULE_LICENSE("GPL v2");
-- 
2.19.2

