Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3899C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722992198F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722992198F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbeHHARE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 20:17:04 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:46686 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbeHHARE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 20:17:04 -0400
Received: from localhost.localdomain ([81.67.76.113])
        by mwinf5d58 with ME
        id LN0T1y0022Sg6Vd03N0aX5; Wed, 08 Aug 2018 00:00:34 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWF4aS5qb3VyZGFuQHdhbmFkb28uZnI=
X-ME-Date: Wed, 08 Aug 2018 00:00:34 +0200
X-ME-IP: 81.67.76.113
From:   Maxime Jourdan <maxi.jourdan@wanadoo.fr>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Maxime Jourdan <maxi.jourdan@wanadoo.fr>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] soc: amlogic: add meson-canvas driver
Date:   Wed,  8 Aug 2018 00:00:08 +0200
Message-Id: <20180807220011.24436-2-maxi.jourdan@wanadoo.fr>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807220011.24436-1-maxi.jourdan@wanadoo.fr>
References: <20180807220011.24436-1-maxi.jourdan@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic SoCs have a repository of 256 canvas which they use to
describe pixel buffers.

They contain metadata like width, height, block mode, endianness [..]

Many IPs within those SoCs like vdec/vpu rely on those canvas to read/write
pixels.

Signed-off-by: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/soc/amlogic/Kconfig              |   7 +
 drivers/soc/amlogic/Makefile             |   1 +
 drivers/soc/amlogic/meson-canvas.c       | 185 +++++++++++++++++++++++
 include/linux/soc/amlogic/meson-canvas.h |  65 ++++++++
 4 files changed, 258 insertions(+)
 create mode 100644 drivers/soc/amlogic/meson-canvas.c
 create mode 100644 include/linux/soc/amlogic/meson-canvas.h

diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
index b04f6e4aedbc..2f282b472912 100644
--- a/drivers/soc/amlogic/Kconfig
+++ b/drivers/soc/amlogic/Kconfig
@@ -1,5 +1,12 @@
 menu "Amlogic SoC drivers"
 
+config MESON_CANVAS
+	tristate "Amlogic Meson Canvas driver"
+	depends on ARCH_MESON || COMPILE_TEST
+	default n
+	help
+	  Say yes to support the canvas IP for Amlogic SoCs.
+
 config MESON_GX_SOCINFO
 	bool "Amlogic Meson GX SoC Information driver"
 	depends on ARCH_MESON || COMPILE_TEST
diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
index 8fa321893928..0ab16d35ac36 100644
--- a/drivers/soc/amlogic/Makefile
+++ b/drivers/soc/amlogic/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_MESON_CANVAS) += meson-canvas.o
 obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
 obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
 obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
diff --git a/drivers/soc/amlogic/meson-canvas.c b/drivers/soc/amlogic/meson-canvas.c
new file mode 100644
index 000000000000..c461334b36d4
--- /dev/null
+++ b/drivers/soc/amlogic/meson-canvas.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 Maxime Jourdan <maxi.jourdan@wanadoo.fr>
+ * Copyright (C) 2016 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ * Copyright (C) 2015 Amlogic, Inc. All rights reserved.
+ * Copyright (C) 2014 Endless Mobile
+ */
+
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/soc/amlogic/meson-canvas.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/io.h>
+
+#define NUM_CANVAS 256
+
+/* DMC Registers */
+#define DMC_CAV_LUT_DATAL	0x48 /* 0x12 offset in data sheet */
+	#define CANVAS_WIDTH_LBIT	29
+	#define CANVAS_WIDTH_LWID       3
+#define DMC_CAV_LUT_DATAH	0x4c /* 0x13 offset in data sheet */
+	#define CANVAS_WIDTH_HBIT       0
+	#define CANVAS_HEIGHT_BIT       9
+	#define CANVAS_BLKMODE_BIT      24
+#define DMC_CAV_LUT_ADDR	0x50 /* 0x14 offset in data sheet */
+	#define CANVAS_LUT_WR_EN        (0x2 << 8)
+	#define CANVAS_LUT_RD_EN        (0x1 << 8)
+
+struct meson_canvas {
+	struct device *dev;
+	struct regmap *regmap_dmc;
+	spinlock_t lock; /* canvas device lock */
+	u8 used[NUM_CANVAS];
+};
+
+struct meson_canvas *meson_canvas_get(struct device *dev)
+{
+	struct device_node *canvas_node;
+	struct platform_device *canvas_pdev;
+	struct meson_canvas *canvas;
+
+	canvas_node = of_parse_phandle(dev->of_node, "amlogic,canvas", 0);
+	if (!canvas_node)
+		return ERR_PTR(-ENODEV);
+
+	canvas_pdev = of_find_device_by_node(canvas_node);
+	if (!canvas_pdev) {
+		dev_err(dev, "Unable to find canvas pdev\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	canvas = dev_get_drvdata(&canvas_pdev->dev);
+	if (!canvas)
+		return ERR_PTR(-ENODEV);
+
+	return canvas;
+}
+EXPORT_SYMBOL_GPL(meson_canvas_get);
+
+int meson_canvas_setup(struct meson_canvas *canvas, u8 canvas_index,
+		       u32 addr, u32 stride, u32 height,
+		       unsigned int wrap,
+		       unsigned int blkmode,
+		       unsigned int endian)
+{
+	struct regmap *regmap = canvas->regmap_dmc;
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&canvas->lock, flags);
+	if (!canvas->used[canvas_index]) {
+		dev_err(canvas->dev,
+			"Trying to setup non allocated canvas %u\n",
+			canvas_index);
+		spin_unlock_irqrestore(&canvas->lock, flags);
+		return -EINVAL;
+	}
+
+	regmap_write(regmap, DMC_CAV_LUT_DATAL,
+		     ((addr + 7) >> 3) |
+		     (((stride + 7) >> 3) << CANVAS_WIDTH_LBIT));
+
+	regmap_write(regmap, DMC_CAV_LUT_DATAH,
+		     ((((stride + 7) >> 3) >> CANVAS_WIDTH_LWID) <<
+						CANVAS_WIDTH_HBIT) |
+		     (height << CANVAS_HEIGHT_BIT) |
+		     (wrap << 22) |
+		     (blkmode << CANVAS_BLKMODE_BIT) |
+		     (endian << 26));
+
+	regmap_write(regmap, DMC_CAV_LUT_ADDR,
+		     CANVAS_LUT_WR_EN | canvas_index);
+
+	/* Force a read-back to make sure everything is flushed. */
+	regmap_read(regmap, DMC_CAV_LUT_DATAH, &val);
+	spin_unlock_irqrestore(&canvas->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(meson_canvas_setup);
+
+int meson_canvas_alloc(struct meson_canvas *canvas, u8 *canvas_index)
+{
+	int i;
+	unsigned long flags;
+
+	spin_lock_irqsave(&canvas->lock, flags);
+	for (i = 0; i < NUM_CANVAS; ++i) {
+		if (!canvas->used[i]) {
+			canvas->used[i] = 1;
+			spin_unlock_irqrestore(&canvas->lock, flags);
+			*canvas_index = i;
+			return 0;
+		}
+	}
+	spin_unlock_irqrestore(&canvas->lock, flags);
+
+	dev_err(canvas->dev, "No more canvas available\n");
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(meson_canvas_alloc);
+
+int meson_canvas_free(struct meson_canvas *canvas, u8 canvas_index)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&canvas->lock, flags);
+	if (!canvas->used[canvas_index]) {
+		dev_err(canvas->dev,
+			"Trying to free unused canvas %u\n", canvas_index);
+		spin_unlock_irqrestore(&canvas->lock, flags);
+		return -EINVAL;
+	}
+	canvas->used[canvas_index] = 0;
+	spin_unlock_irqrestore(&canvas->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(meson_canvas_free);
+
+static int meson_canvas_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct meson_canvas *canvas;
+
+	canvas = devm_kzalloc(dev, sizeof(*canvas), GFP_KERNEL);
+	if (!canvas)
+		return -ENOMEM;
+
+	canvas->regmap_dmc =
+		syscon_node_to_regmap(of_get_parent(dev->of_node));
+	if (IS_ERR(canvas->regmap_dmc)) {
+		dev_err(dev, "failed to get DMC regmap\n");
+		return PTR_ERR(canvas->regmap_dmc);
+	}
+
+	canvas->dev = dev;
+	spin_lock_init(&canvas->lock);
+	dev_set_drvdata(dev, canvas);
+
+	return 0;
+}
+
+static const struct of_device_id canvas_dt_match[] = {
+	{ .compatible = "amlogic,canvas" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, canvas_dt_match);
+
+static struct platform_driver meson_canvas_driver = {
+	.probe = meson_canvas_probe,
+	.driver = {
+		.name = "amlogic-canvas",
+		.of_match_table = canvas_dt_match,
+	},
+};
+module_platform_driver(meson_canvas_driver);
+
+MODULE_DESCRIPTION("Amlogic Canvas driver");
+MODULE_AUTHOR("Maxime Jourdan <maxi.jourdan@wanadoo.fr>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/soc/amlogic/meson-canvas.h b/include/linux/soc/amlogic/meson-canvas.h
new file mode 100644
index 000000000000..c164202d8e39
--- /dev/null
+++ b/include/linux/soc/amlogic/meson-canvas.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2018 Maxime Jourdan <maxi.jourdan@wanadoo.fr>
+ */
+#ifndef MESON_CANVAS_H
+#define MESON_CANVAS_H
+
+#include <linux/kernel.h>
+
+#define MESON_CANVAS_WRAP_NONE	0x00
+#define MESON_CANVAS_WRAP_X	0x01
+#define MESON_CANVAS_WRAP_Y	0x02
+
+#define MESON_CANVAS_BLKMODE_LINEAR	0x00
+#define MESON_CANVAS_BLKMODE_32x32	0x01
+#define MESON_CANVAS_BLKMODE_64x64	0x02
+
+#define MESON_CANVAS_ENDIAN_SWAP16	0x1
+#define MESON_CANVAS_ENDIAN_SWAP32	0x3
+#define MESON_CANVAS_ENDIAN_SWAP64	0x7
+#define MESON_CANVAS_ENDIAN_SWAP128	0xf
+
+struct meson_canvas;
+
+/**
+ * meson_canvas_get() - get a canvas provider instance
+ *
+ * @dev: your device
+ */
+struct meson_canvas *meson_canvas_get(struct device *dev);
+
+/**
+ * meson_canvas_alloc() - take ownership of a canvas
+ *
+ * @canvas: canvas provider instance retrieved from meson_canvas_get()
+ * @canvas_index: will be filled with the canvas ID
+ */
+int meson_canvas_alloc(struct meson_canvas *canvas, u8 *canvas_index);
+
+/**
+ * meson_canvas_free() - remove ownership from a canvas
+ *
+ * @canvas: canvas provider instance retrieved from meson_canvas_get()
+ * @canvas_index: canvas ID that was obtained via meson_canvas_alloc()
+ */
+int meson_canvas_free(struct meson_canvas *canvas, u8 canvas_index);
+
+/**
+ * meson_canvas_setup() - configure a canvas
+ *
+ * @canvas: canvas provider instance retrieved from meson_canvas_get()
+ * @canvas_index: canvas ID that was obtained via meson_canvas_alloc()
+ * @addr: physical address to the pixel buffer
+ * @stride: width of the buffer
+ * @height: height of the buffer
+ * @wrap: undocumented
+ * @blkmode: block mode (linear, 32x32, 64x64)
+ * @endian: byte swapping (swap16, swap32, swap64, swap128)
+ */
+int meson_canvas_setup(struct meson_canvas *canvas, u8 canvas_index,
+		       u32 addr, u32 stride, u32 height,
+		       unsigned int wrap, unsigned int blkmode,
+		       unsigned int endian);
+
+#endif
-- 
2.18.0

