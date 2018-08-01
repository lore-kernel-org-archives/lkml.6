Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CA6C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23A820862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23A820862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387424AbeHAUjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:39:08 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:16404 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731501AbeHAUjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:39:08 -0400
Received: from localhost.localdomain ([81.67.76.113])
        by mwinf5d86 with ME
        id Huro1y0012Sg6Vd03ury0j; Wed, 01 Aug 2018 20:51:58 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWF4aS5qb3VyZGFuQHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 Aug 2018 20:51:58 +0200
X-ME-IP: 81.67.76.113
From:   Maxime Jourdan <maxi.jourdan@wanadoo.fr>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Maxime Jourdan <maxi.jourdan@wanadoo.fr>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] soc: amlogic: add meson-canvas driver
Date:   Wed,  1 Aug 2018 20:51:25 +0200
Message-Id: <20180801185128.23440-2-maxi.jourdan@wanadoo.fr>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801185128.23440-1-maxi.jourdan@wanadoo.fr>
References: <20180801185128.23440-1-maxi.jourdan@wanadoo.fr>
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
---
 drivers/soc/amlogic/Kconfig              |   7 +
 drivers/soc/amlogic/Makefile             |   1 +
 drivers/soc/amlogic/meson-canvas.c       | 182 +++++++++++++++++++++++
 include/linux/soc/amlogic/meson-canvas.h |  37 +++++
 4 files changed, 227 insertions(+)
 create mode 100644 drivers/soc/amlogic/meson-canvas.c
 create mode 100644 include/linux/soc/amlogic/meson-canvas.h

diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
index b04f6e4aedbc..5bd049899d88 100644
--- a/drivers/soc/amlogic/Kconfig
+++ b/drivers/soc/amlogic/Kconfig
@@ -1,5 +1,12 @@
 menu "Amlogic SoC drivers"
 
+config MESON_CANVAS
+	bool "Amlogic Meson Canvas driver"
+	depends on ARCH_MESON || COMPILE_TEST
+	default ARCH_MESON
+	help
+	  Say yes to support the canvas IP within Amlogic Meson Soc family.
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
index 000000000000..671eb89c8904
--- /dev/null
+++ b/drivers/soc/amlogic/meson-canvas.c
@@ -0,0 +1,182 @@
+/*
+ * Copyright (C) 2018 Maxime Jourdan
+ * Copyright (C) 2016 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ * Copyright (C) 2015 Amlogic, Inc. All rights reserved.
+ * Copyright (C) 2014 Endless Mobile
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <linux/soc/amlogic/meson-canvas.h>
+#include <asm/io.h>
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
+	struct mutex lock;
+	u8 used[NUM_CANVAS];
+};
+
+static struct meson_canvas canvas = { 0 };
+
+static int meson_canvas_setup(uint8_t canvas_index, uint32_t addr,
+			uint32_t stride, uint32_t height,
+			unsigned int wrap,
+			unsigned int blkmode,
+			unsigned int endian)
+{
+	struct regmap *regmap = canvas.regmap_dmc;
+	u32 val;
+
+	mutex_lock(&canvas.lock);
+
+	if (!canvas.used[canvas_index]) {
+		dev_err(canvas.dev,
+			"Trying to setup non allocated canvas %u\n",
+			canvas_index);
+		mutex_unlock(&canvas.lock);
+		return -EINVAL;
+	}
+
+	regmap_write(regmap, DMC_CAV_LUT_DATAL,
+		((addr + 7) >> 3) |
+		(((stride + 7) >> 3) << CANVAS_WIDTH_LBIT));
+
+	regmap_write(regmap, DMC_CAV_LUT_DATAH,
+		((((stride + 7) >> 3) >> CANVAS_WIDTH_LWID) <<
+						CANVAS_WIDTH_HBIT) |
+		(height << CANVAS_HEIGHT_BIT) |
+		(wrap << 22) |
+		(blkmode << CANVAS_BLKMODE_BIT) |
+		(endian << 26));
+
+	regmap_write(regmap, DMC_CAV_LUT_ADDR,
+		CANVAS_LUT_WR_EN | canvas_index);
+
+	/* Force a read-back to make sure everything is flushed. */
+	regmap_read(regmap, DMC_CAV_LUT_DATAH, &val);
+	mutex_unlock(&canvas.lock);
+
+	return 0;
+}
+
+static int meson_canvas_alloc(uint8_t *canvas_index)
+{
+	int i;
+
+	mutex_lock(&canvas.lock);
+	for (i = 0; i < NUM_CANVAS; ++i) {
+		if (!canvas.used[i]) {
+			canvas.used[i] = 1;
+			mutex_unlock(&canvas.lock);
+			*canvas_index = i;
+			return 0;
+		}
+	}
+	mutex_unlock(&canvas.lock);
+	dev_err(canvas.dev, "No more canvas available\n");
+
+	return -ENODEV;
+}
+
+static int meson_canvas_free(uint8_t canvas_index)
+{
+	mutex_lock(&canvas.lock);
+	if (!canvas.used[canvas_index]) {
+		dev_err(canvas.dev,
+			"Trying to free unused canvas %u\n", canvas_index);
+		mutex_unlock(&canvas.lock);
+		return -EINVAL;
+	}
+	canvas.used[canvas_index] = 0;
+	mutex_unlock(&canvas.lock);
+
+	return 0;
+}
+
+static struct meson_canvas_platform_data canvas_platform_data = {
+	.alloc = meson_canvas_alloc,
+	.free = meson_canvas_free,
+	.setup = meson_canvas_setup,
+};
+
+static int meson_canvas_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap_dmc;
+	struct device *dev;
+
+	dev = &pdev->dev;
+
+	regmap_dmc = syscon_node_to_regmap(of_get_parent(dev->of_node));
+	if (IS_ERR(regmap_dmc)) {
+		dev_err(&pdev->dev, "failed to get DMC regmap\n");
+		return PTR_ERR(regmap_dmc);
+	}
+
+	canvas.dev = dev;
+	canvas.regmap_dmc = regmap_dmc;
+	mutex_init(&canvas.lock);
+
+	dev->platform_data = &canvas_platform_data;
+
+	return 0;
+}
+
+static int meson_canvas_remove(struct platform_device *pdev)
+{
+	mutex_destroy(&canvas.lock);
+	return 0;
+}
+
+static const struct of_device_id canvas_dt_match[] = {
+	{ .compatible = "amlogic,meson-canvas" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, canvas_dt_match);
+
+static struct platform_driver meson_canvas_driver = {
+	.probe = meson_canvas_probe,
+	.remove = meson_canvas_remove,
+	.driver = {
+		.name = "meson-canvas",
+		.of_match_table = canvas_dt_match,
+	},
+};
+module_platform_driver(meson_canvas_driver);
+
+MODULE_ALIAS("platform:meson-canvas");
+MODULE_DESCRIPTION("AMLogic Meson Canvas driver");
+MODULE_AUTHOR("Maxime Jourdan <maxi.jourdan@wanadoo.fr>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/soc/amlogic/meson-canvas.h b/include/linux/soc/amlogic/meson-canvas.h
new file mode 100644
index 000000000000..af9e2415056a
--- /dev/null
+++ b/include/linux/soc/amlogic/meson-canvas.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright (c) 2018 Maxime Jourdan
+ * Author: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
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
+struct meson_canvas_platform_data {
+	int (*alloc)(uint8_t *canvas_index);
+	int (*free) (uint8_t canvas_index);
+	int (*setup)(uint8_t canvas_index, uint32_t addr,
+			uint32_t stride, uint32_t height,
+			unsigned int wrap,
+			unsigned int blkmode,
+			unsigned int endian);
+};
+
+#endif
-- 
2.17.1

