Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D83C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE992198F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE992198F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeHHARK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 20:17:10 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:27444 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbeHHARJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 20:17:09 -0400
Received: from localhost.localdomain ([81.67.76.113])
        by mwinf5d58 with ME
        id LN0T1y0022Sg6Vd03N0fXe; Wed, 08 Aug 2018 00:00:40 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWF4aS5qb3VyZGFuQHdhbmFkb28uZnI=
X-ME-Date: Wed, 08 Aug 2018 00:00:40 +0200
X-ME-IP: 81.67.76.113
From:   Maxime Jourdan <maxi.jourdan@wanadoo.fr>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Maxime Jourdan <maxi.jourdan@wanadoo.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 4/4] drm/meson: convert to the new canvas module
Date:   Wed,  8 Aug 2018 00:00:11 +0200
Message-Id: <20180807220011.24436-5-maxi.jourdan@wanadoo.fr>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807220011.24436-1-maxi.jourdan@wanadoo.fr>
References: <20180807220011.24436-1-maxi.jourdan@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the meson_canvas files within the meson/drm layer
and makes use of the new canvas module that is referenced in the dts.

Canvases can be used by different IPs and modules, and it is as such
preferable to rely on a module that can safely dispatch canvases on
demand.

Signed-off-by: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/display/amlogic,meson-vpu.txt    |  9 +--
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |  7 +-
 drivers/gpu/drm/meson/Kconfig                 |  1 +
 drivers/gpu/drm/meson/Makefile                |  2 +-
 drivers/gpu/drm/meson/meson_canvas.c          | 70 -------------------
 drivers/gpu/drm/meson/meson_canvas.h          | 42 -----------
 drivers/gpu/drm/meson/meson_crtc.c            |  9 ++-
 drivers/gpu/drm/meson/meson_drv.c             | 22 ++----
 drivers/gpu/drm/meson/meson_drv.h             |  5 +-
 drivers/gpu/drm/meson/meson_plane.c           |  3 +-
 drivers/gpu/drm/meson/meson_viu.c             |  1 -
 11 files changed, 26 insertions(+), 145 deletions(-)
 delete mode 100644 drivers/gpu/drm/meson/meson_canvas.c
 delete mode 100644 drivers/gpu/drm/meson/meson_canvas.h

diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
index 057b81335775..60b6e1398636 100644
--- a/Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
+++ b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
@@ -60,9 +60,9 @@ Required properties:
 - reg: base address and size of he following memory-mapped regions :
 	- vpu
 	- hhi
-	- dmc
 - reg-names: should contain the names of the previous memory regions
 - interrupts: should contain the VENC Vsync interrupt number
+- amlogic,canvas: should point to a meson canvas provider node
 
 Optional properties:
 - power-domains: Optional phandle to associated power domain as described in
@@ -98,13 +98,14 @@ tv-connector {
 vpu: vpu@d0100000 {
 	compatible = "amlogic,meson-gxbb-vpu";
 	reg = <0x0 0xd0100000 0x0 0x100000>,
-	      <0x0 0xc883c000 0x0 0x1000>,
-	      <0x0 0xc8838000 0x0 0x1000>;
-	reg-names = "vpu", "hhi", "dmc";
+	      <0x0 0xc883c000 0x0 0x1000>;
+	reg-names = "vpu", "hhi";
 	interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
 	#address-cells = <1>;
 	#size-cells = <0>;
 
+	amlogic,canvas = <&canvas>;
+
 	/* CVBS VDAC output port */
 	port@0 {
 		reg = <0>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index c98198662ae2..8b4dfe7dd4bb 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -503,13 +503,14 @@
 		vpu: vpu@d0100000 {
 			compatible = "amlogic,meson-gx-vpu";
 			reg = <0x0 0xd0100000 0x0 0x100000>,
-			      <0x0 0xc883c000 0x0 0x1000>,
-			      <0x0 0xc8838000 0x0 0x1000>;
-			reg-names = "vpu", "hhi", "dmc";
+			      <0x0 0xc883c000 0x0 0x1000>;
+			reg-names = "vpu", "hhi";
 			interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 
+			amlogic,canvas = <&canvas>;
+
 			/* CVBS VDAC output port */
 			cvbs_vdac_port: port@0 {
 				reg = <0>;
diff --git a/drivers/gpu/drm/meson/Kconfig b/drivers/gpu/drm/meson/Kconfig
index 3ce51d8dfe1c..c28b69f48555 100644
--- a/drivers/gpu/drm/meson/Kconfig
+++ b/drivers/gpu/drm/meson/Kconfig
@@ -7,6 +7,7 @@ config DRM_MESON
 	select DRM_GEM_CMA_HELPER
 	select VIDEOMODE_HELPERS
 	select REGMAP_MMIO
+	select MESON_CANVAS
 
 config DRM_MESON_DW_HDMI
 	tristate "HDMI Synopsys Controller support for Amlogic Meson Display"
diff --git a/drivers/gpu/drm/meson/Makefile b/drivers/gpu/drm/meson/Makefile
index c5c4cc362f02..bd67429185ff 100644
--- a/drivers/gpu/drm/meson/Makefile
+++ b/drivers/gpu/drm/meson/Makefile
@@ -1,5 +1,5 @@
 meson-drm-y := meson_drv.o meson_plane.o meson_crtc.o meson_venc_cvbs.o
-meson-drm-y += meson_viu.o meson_vpp.o meson_venc.o meson_vclk.o meson_canvas.o
+meson-drm-y += meson_viu.o meson_vpp.o meson_venc.o meson_vclk.o
 
 obj-$(CONFIG_DRM_MESON) += meson-drm.o
 obj-$(CONFIG_DRM_MESON_DW_HDMI) += meson_dw_hdmi.o
diff --git a/drivers/gpu/drm/meson/meson_canvas.c b/drivers/gpu/drm/meson/meson_canvas.c
deleted file mode 100644
index 08f6073d967e..000000000000
--- a/drivers/gpu/drm/meson/meson_canvas.c
+++ /dev/null
@@ -1,70 +0,0 @@
-/*
- * Copyright (C) 2016 BayLibre, SAS
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- * Copyright (C) 2015 Amlogic, Inc. All rights reserved.
- * Copyright (C) 2014 Endless Mobile
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include "meson_drv.h"
-#include "meson_canvas.h"
-#include "meson_registers.h"
-
-/**
- * DOC: Canvas
- *
- * CANVAS is a memory zone where physical memory frames information
- * are stored for the VIU to scanout.
- */
-
-/* DMC Registers */
-#define DMC_CAV_LUT_DATAL	0x48 /* 0x12 offset in data sheet */
-#define CANVAS_WIDTH_LBIT	29
-#define CANVAS_WIDTH_LWID       3
-#define DMC_CAV_LUT_DATAH	0x4c /* 0x13 offset in data sheet */
-#define CANVAS_WIDTH_HBIT       0
-#define CANVAS_HEIGHT_BIT       9
-#define CANVAS_BLKMODE_BIT      24
-#define DMC_CAV_LUT_ADDR	0x50 /* 0x14 offset in data sheet */
-#define CANVAS_LUT_WR_EN        (0x2 << 8)
-#define CANVAS_LUT_RD_EN        (0x1 << 8)
-
-void meson_canvas_setup(struct meson_drm *priv,
-			uint32_t canvas_index, uint32_t addr,
-			uint32_t stride, uint32_t height,
-			unsigned int wrap,
-			unsigned int blkmode)
-{
-	unsigned int val;
-
-	regmap_write(priv->dmc, DMC_CAV_LUT_DATAL,
-		(((addr + 7) >> 3)) |
-		(((stride + 7) >> 3) << CANVAS_WIDTH_LBIT));
-
-	regmap_write(priv->dmc, DMC_CAV_LUT_DATAH,
-		((((stride + 7) >> 3) >> CANVAS_WIDTH_LWID) <<
-						CANVAS_WIDTH_HBIT) |
-		(height << CANVAS_HEIGHT_BIT) |
-		(wrap << 22) |
-		(blkmode << CANVAS_BLKMODE_BIT));
-
-	regmap_write(priv->dmc, DMC_CAV_LUT_ADDR,
-			CANVAS_LUT_WR_EN | canvas_index);
-
-	/* Force a read-back to make sure everything is flushed. */
-	regmap_read(priv->dmc, DMC_CAV_LUT_DATAH, &val);
-}
diff --git a/drivers/gpu/drm/meson/meson_canvas.h b/drivers/gpu/drm/meson/meson_canvas.h
deleted file mode 100644
index af1759da4b27..000000000000
--- a/drivers/gpu/drm/meson/meson_canvas.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/*
- * Copyright (C) 2016 BayLibre, SAS
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- * Copyright (C) 2014 Endless Mobile
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-/* Canvas LUT Memory */
-
-#ifndef __MESON_CANVAS_H
-#define __MESON_CANVAS_H
-
-#define MESON_CANVAS_ID_OSD1	0x4e
-
-/* Canvas configuration. */
-#define MESON_CANVAS_WRAP_NONE	0x00
-#define	MESON_CANVAS_WRAP_X	0x01
-#define	MESON_CANVAS_WRAP_Y	0x02
-
-#define	MESON_CANVAS_BLKMODE_LINEAR	0x00
-#define	MESON_CANVAS_BLKMODE_32x32	0x01
-#define	MESON_CANVAS_BLKMODE_64x64	0x02
-
-void meson_canvas_setup(struct meson_drm *priv,
-			uint32_t canvas_index, uint32_t addr,
-			uint32_t stride, uint32_t height,
-			unsigned int wrap,
-			unsigned int blkmode);
-
-#endif /* __MESON_CANVAS_H */
diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
index 05520202c967..9580b85de679 100644
--- a/drivers/gpu/drm/meson/meson_crtc.c
+++ b/drivers/gpu/drm/meson/meson_crtc.c
@@ -36,7 +36,6 @@
 #include "meson_venc.h"
 #include "meson_vpp.h"
 #include "meson_viu.h"
-#include "meson_canvas.h"
 #include "meson_registers.h"
 
 /* CRTC definition */
@@ -193,10 +192,10 @@ void meson_crtc_irq(struct meson_drm *priv)
 		} else
 			meson_vpp_disable_interlace_vscaler_osd1(priv);
 
-		meson_canvas_setup(priv, MESON_CANVAS_ID_OSD1,
-			   priv->viu.osd1_addr, priv->viu.osd1_stride,
-			   priv->viu.osd1_height, MESON_CANVAS_WRAP_NONE,
-			   MESON_CANVAS_BLKMODE_LINEAR);
+		meson_canvas_setup(priv->canvas, priv->canvas_id_osd1,
+				priv->viu.osd1_addr, priv->viu.osd1_stride,
+				priv->viu.osd1_height, MESON_CANVAS_WRAP_NONE,
+				MESON_CANVAS_BLKMODE_LINEAR, 0);
 
 		/* Enable OSD1 */
 		writel_bits_relaxed(VPP_OSD1_POSTBLEND, VPP_OSD1_POSTBLEND,
diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index d3443125e661..fb5b0e3c5efc 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -47,7 +47,6 @@
 #include "meson_vpp.h"
 #include "meson_viu.h"
 #include "meson_venc.h"
-#include "meson_canvas.h"
 #include "meson_registers.h"
 
 #define DRIVER_NAME "meson"
@@ -216,25 +215,15 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 		goto free_drm;
 	}
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dmc");
-	if (!res) {
-		ret = -EINVAL;
-		goto free_drm;
-	}
-	/* Simply ioremap since it may be a shared register zone */
-	regs = devm_ioremap(dev, res->start, resource_size(res));
-	if (!regs) {
-		ret = -EADDRNOTAVAIL;
+	priv->canvas = meson_canvas_get(dev);
+	if (IS_ERR(priv->canvas)) {
+		ret = PTR_ERR(priv->canvas);
 		goto free_drm;
 	}
 
-	priv->dmc = devm_regmap_init_mmio(dev, regs,
-					  &meson_regmap_config);
-	if (IS_ERR(priv->dmc)) {
-		dev_err(&pdev->dev, "Couldn't create the DMC regmap\n");
-		ret = PTR_ERR(priv->dmc);
+	ret = meson_canvas_alloc(priv->canvas, &priv->canvas_id_osd1);
+	if (ret)
 		goto free_drm;
-	}
 
 	priv->vsync_irq = platform_get_irq(pdev, 0);
 
@@ -315,6 +304,7 @@ static void meson_drv_unbind(struct device *dev)
 	struct drm_device *drm = dev_get_drvdata(dev);
 	struct meson_drm *priv = drm->dev_private;
 
+	meson_canvas_free(priv->canvas, priv->canvas_id_osd1);
 	drm_dev_unregister(drm);
 	drm_kms_helper_poll_fini(drm);
 	drm_fbdev_cma_fini(priv->fbdev);
diff --git a/drivers/gpu/drm/meson/meson_drv.h b/drivers/gpu/drm/meson/meson_drv.h
index 8450d6ac8c9b..9e902a6df784 100644
--- a/drivers/gpu/drm/meson/meson_drv.h
+++ b/drivers/gpu/drm/meson/meson_drv.h
@@ -22,15 +22,18 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/of.h>
+#include <linux/soc/amlogic/meson-canvas.h>
 #include <drm/drmP.h>
 
 struct meson_drm {
 	struct device *dev;
 	void __iomem *io_base;
 	struct regmap *hhi;
-	struct regmap *dmc;
 	int vsync_irq;
 
+	struct meson_canvas *canvas;
+	u8 canvas_id_osd1;
+
 	struct drm_device *drm;
 	struct drm_crtc *crtc;
 	struct drm_fbdev_cma *fbdev;
diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
index 12c80dfcff59..8745f9209625 100644
--- a/drivers/gpu/drm/meson/meson_plane.c
+++ b/drivers/gpu/drm/meson/meson_plane.c
@@ -36,7 +36,6 @@
 #include "meson_plane.h"
 #include "meson_vpp.h"
 #include "meson_viu.h"
-#include "meson_canvas.h"
 #include "meson_registers.h"
 
 struct meson_plane {
@@ -105,7 +104,7 @@ static void meson_plane_atomic_update(struct drm_plane *plane,
 				   OSD_BLK0_ENABLE;
 
 	/* Set up BLK0 to point to the right canvas */
-	priv->viu.osd1_blk0_cfg[0] = ((MESON_CANVAS_ID_OSD1 << OSD_CANVAS_SEL) |
+	priv->viu.osd1_blk0_cfg[0] = ((priv->canvas_id_osd1 << OSD_CANVAS_SEL) |
 				      OSD_ENDIANNESS_LE);
 
 	/* On GXBB, Use the old non-HDR RGB2YUV converter */
diff --git a/drivers/gpu/drm/meson/meson_viu.c b/drivers/gpu/drm/meson/meson_viu.c
index 6bcfa527c180..5b48c4c0985b 100644
--- a/drivers/gpu/drm/meson/meson_viu.c
+++ b/drivers/gpu/drm/meson/meson_viu.c
@@ -25,7 +25,6 @@
 #include "meson_viu.h"
 #include "meson_vpp.h"
 #include "meson_venc.h"
-#include "meson_canvas.h"
 #include "meson_registers.h"
 
 /**
-- 
2.18.0

