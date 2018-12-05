Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE5AC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D10208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D10208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbeLEWNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:13:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:42000 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727339AbeLEWNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:13:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CACC4ADDF;
        Wed,  5 Dec 2018 22:13:03 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Henrik Rydberg <rydberg@bitmath.org>
Cc:     linux-rpi-kernel@lists.infradead.org, stefan.wahren@i2se.com,
        eric@anholt.net, agraf@suse.de,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Masanari Iida <standby24x7@gmail.com>,
        Zhu Yi <yi.zhu5@cn.bosch.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>,
        Heiko Schocher <hs@denx.de>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH RFC 1/2] input: add official Raspberry Pi's 7" touchscreen driver
Date:   Wed,  5 Dec 2018 23:09:03 +0100
Message-Id: <20181205220902.27682-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205220902.27682-1-nsaenzjulienne@suse.de>
References: <20181205220902.27682-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support to Raspberry Pi's 7" touchscreen device. Instead of using
a conventional bus all information is copied into a memory mapped area
by RPi's VC4 firmware.

Based on the driver found in RPi's downstream kernel repository.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/input/touchscreen/Kconfig          |  12 +
 drivers/input/touchscreen/Makefile         |   1 +
 drivers/input/touchscreen/raspberrypi-ts.c | 252 +++++++++++++++++++++
 3 files changed, 265 insertions(+)
 create mode 100644 drivers/input/touchscreen/raspberrypi-ts.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 2a80675cfd94..8d0fcb3dc8a8 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -696,6 +696,18 @@ config TOUCHSCREEN_EDT_FT5X06
 	  To compile this driver as a module, choose M here: the
 	  module will be called edt-ft5x06.
 
+config TOUCHSCREEN_RASPBERRYPI_TS
+	tristate "Raspberry Pi's firmware base touch screen support"
+	depends on OF
+	help
+	  Say Y here if you have the official Raspberry Pi 7' touchscren
+	  connected on your system.
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
index 000000000000..9d29411a5674
--- /dev/null
+++ b/drivers/input/touchscreen/raspberrypi-ts.c
@@ -0,0 +1,252 @@
+/*
+ * Raspberry Pi 3 firmware based touchscreen driver
+ *
+ * Copyright (C) 2015, 2017 Raspberry Pi
+ * Copyright (C) 2018 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
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
+struct rpi_ts {
+	struct input_dev *input;
+	struct touchscreen_properties prop;
+
+	void __iomem *ts_base;
+	dma_addr_t bus_addr;
+
+	struct delayed_work work;
+	int known_ids;
+};
+
+struct rpi_ts_regs {
+	uint8_t device_mode;
+	uint8_t gesture_id;
+	uint8_t num_points;
+	struct rpi_ts_touch {
+		uint8_t xh;
+		uint8_t xl;
+		uint8_t yh;
+		uint8_t yl;
+		uint8_t pressure; /* Not supported */
+		uint8_t area;     /* Not supported */
+	} point[RPI_TS_MAX_SUPPORTED_POINTS];
+};
+
+/*
+ * This process polls the memory based register copy of the touch screen chip
+ * registers using the number of points register to know whether the copy has
+ * been updated (we write 99 to the memory copy, the GPU will write between 0 -
+ * 10 points)
+ */
+static void rpi_ts_work(struct work_struct *work)
+{
+	struct rpi_ts *ts = container_of(work, struct rpi_ts, work.work);
+	struct input_dev *input = ts->input;
+	struct rpi_ts_regs regs;
+	int modified_ids = 0;
+	int released_ids;
+	int event_type;
+	int touchid;
+	int x, y;
+	int i;
+
+	memcpy_fromio(&regs, ts->ts_base, sizeof(struct rpi_ts_regs));
+	iowrite8(99, ts->ts_base + offsetof(struct rpi_ts_regs, num_points));
+
+	if (regs.num_points == 99 ||
+	    (regs.num_points == 0 && ts->known_ids == 0))
+	    goto out;
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
+	for (i = 0; released_ids && i < RPI_TS_MAX_SUPPORTED_POINTS; i++) {
+		if (released_ids & BIT(i)) {
+			input_mt_slot(input, i);
+			input_mt_report_slot_state(input, MT_TOOL_FINGER, 0);
+			modified_ids &= ~(BIT(i));
+		}
+	}
+	ts->known_ids = modified_ids;
+
+	input_mt_report_pointer_emulation(ts->input, true);
+	input_sync(ts->input);
+
+out:
+	schedule_delayed_work(&ts->work, msecs_to_jiffies(17)); /* 60 fps */
+}
+
+static int rpi_ts_open(struct input_dev *dev)
+{
+	struct rpi_ts *ts = input_get_drvdata(dev);
+
+	schedule_delayed_work(&ts->work, 0);
+
+	return 0;
+}
+
+static void rpi_ts_close(struct input_dev *dev)
+{
+	struct rpi_ts *ts = input_get_drvdata(dev);
+
+	cancel_delayed_work_sync(&ts->work);
+}
+
+static int rpi_ts_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct device_node *fw_node;
+	struct input_dev *input;
+	struct rpi_firmware *fw;
+	struct rpi_ts *ts;
+	u32 touchbuf;
+	int err = 0;
+
+	fw_node = of_get_parent(np);
+	if (!fw_node) {
+		dev_err(dev, "Missing firmware node\n");
+		return -ENOENT;
+	}
+
+	fw = rpi_firmware_get(fw_node);
+	if (!fw)
+		return -EPROBE_DEFER;
+
+	ts = devm_kzalloc(dev, sizeof(struct rpi_ts), GFP_KERNEL);
+	if (!ts) {
+		dev_err(dev, "Failed to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	input = input_allocate_device();
+	if (!input) {
+		dev_err(dev, "Failed to allocate input device\n");
+		return -ENOMEM;
+	}
+	ts->input = input;
+
+	ts->ts_base = dma_zalloc_coherent(dev, PAGE_SIZE, &ts->bus_addr,
+					  GFP_KERNEL);
+	if (!ts->ts_base) {
+		dev_err(dev, "failed to dma_alloc_coherent\n");
+		err = -ENOMEM;
+		goto undegister_input_device;
+	}
+
+	touchbuf = (u32)ts->bus_addr;
+	err = rpi_firmware_property(fw, RPI_FIRMWARE_FRAMEBUFFER_SET_TOUCHBUF,
+				    &touchbuf, sizeof(touchbuf));
+
+	if (err || touchbuf != 0) {
+		dev_warn(dev, "Failed to set touchbuf, trying to get err:%x\n",
+			 err);
+		goto clean_dma_buf;
+	}
+
+	INIT_DELAYED_WORK(&ts->work, rpi_ts_work);
+	platform_set_drvdata(pdev, ts);
+
+	input->name = "raspberrypi-ts";
+	input->id.bustype = BUS_HOST;
+	input->open = rpi_ts_open;
+	input->close = rpi_ts_close;
+	input->dev.parent = &pdev->dev;
+
+	__set_bit(EV_KEY, input->evbit);
+	__set_bit(EV_SYN, input->evbit);
+	__set_bit(EV_ABS, input->evbit);
+
+	input_set_abs_params(input, ABS_MT_POSITION_X, 0,
+			     RPI_TS_DEFAULT_WIDTH, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_Y, 0,
+			     RPI_TS_DEFAULT_HEIGHT, 0, 0);
+	touchscreen_parse_properties(input, true, &ts->prop);
+
+	input_mt_init_slots(input, RPI_TS_MAX_SUPPORTED_POINTS,
+			    INPUT_MT_DIRECT);
+
+	input_set_drvdata(input, ts);
+
+	err = input_register_device(input);
+	if (err) {
+		dev_err(dev, "could not register input device, %d\n",
+			err);
+		goto clean_dma_buf;
+	}
+	return 0;
+
+clean_dma_buf:
+	dma_free_coherent(dev, PAGE_SIZE, ts->ts_base, ts->bus_addr);
+undegister_input_device:
+	input_unregister_device(ts->input);
+
+	return err;
+}
+
+static int rpi_ts_remove(struct platform_device *pdev)
+{
+	struct rpi_ts *ts = (struct rpi_ts *)platform_get_drvdata(pdev);
+
+	input_unregister_device(ts->input);
+	dma_free_coherent(&pdev->dev, PAGE_SIZE, ts->ts_base, ts->bus_addr);
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
+		.owner  = THIS_MODULE,
+		.of_match_table = rpi_ts_match,
+	},
+	.probe          = rpi_ts_probe,
+	.remove         = rpi_ts_remove,
+};
+
+module_platform_driver(rpi_ts_driver);
+
+MODULE_AUTHOR("Gordon Hollingworth");
+MODULE_AUTHOR("Nicolas Saenz Julienne <nsaenzjulienne@suse.de>");
+MODULE_DESCRIPTION("Raspberry Pi 3 firmware based touchscreen driver");
+MODULE_LICENSE("GPL");
-- 
2.19.2

