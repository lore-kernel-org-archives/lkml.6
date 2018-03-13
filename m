Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753098AbeCMNvq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:51:46 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:65371 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752607AbeCMNvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:51:44 -0400
From: yannick fertre <yannick.fertre@st.com>
To: Vikas Manocha <vikas.manocha@st.com>, Tom Rini <trini@konsulko.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        "Patrice Chotard" <patrice.chotard@st.com>,
        Patrick DELAUNAY <patrick.delaunay@st.com>,
        Christophe KERELLO <christophe.kerello@st.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Brian Norris <briannorris@chromium.org>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Albert Aribaud <albert.u.boot@aribaud.net>,
        "Simon Glass" <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>,
        Thierry Reding <thierry.reding@gmail.com>
CC: <u-boot@lists.denx.de>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 02/10] video: stm32: stm32_ltdc: update debug log
Date: Tue, 13 Mar 2018 14:50:03 +0100
Message-ID: <1520949014-21468-5-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520949014-21468-1-git-send-email-yannick.fertre@st.com>
References: <1520949014-21468-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.68]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace  macro debug by pr_error, pr_warn or pr_info.

Signed-off-by: yannick fertre <yannick.fertre@st.com>
---
 drivers/video/stm32/stm32_ltdc.c | 67 ++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 37 deletions(-)

diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm32_ltdc.c
index bd9c0de..3e12c71 100644
--- a/drivers/video/stm32/stm32_ltdc.c
+++ b/drivers/video/stm32/stm32_ltdc.c
@@ -5,7 +5,6 @@
  *
  * SPDX-License-Identifier: GPL-2.0+
  */
-
 #include <common.h>
 #include <clk.h>
 #include <display.h>
@@ -13,12 +12,10 @@
 #include <panel.h>
 #include <reset.h>
 #include <video.h>
+#include <video_bridge.h>
 #include <asm/io.h>
 #include <asm/arch/gpio.h>
 #include <dm/device-internal.h>
-#include <video_bridge.h>
-
-DECLARE_GLOBAL_DATA_PTR;
 
 struct stm32_ltdc_priv {
 	void __iomem *regs;
@@ -176,13 +173,13 @@ static u32 stm32_ltdc_get_pixel_format(enum video_log2_bpp l2bpp)
 	case VIDEO_BPP2:
 	case VIDEO_BPP4:
 	default:
-		debug("%s: warning %dbpp not supported yet, %dbpp instead\n",
-		      __func__, VNBITS(l2bpp), VNBITS(VIDEO_BPP16));
+		pr_warn("warning %dbpp not supported yet, %dbpp instead\n",
+			VNBITS(l2bpp), VNBITS(VIDEO_BPP16));
 		pf = PF_RGB565;
 		break;
 	}
 
-	debug("%s: %d bpp -> ltdc pf %d\n", __func__, VNBITS(l2bpp), pf);
+	pr_info("%d bpp -> ltdc pf %d\n", VNBITS(l2bpp), pf);
 
 	return (u32)pf;
 }
@@ -249,7 +246,7 @@ static void stm32_ltdc_set_mode(struct stm32_ltdc_priv *priv,
 
 	/* Signal polarities */
 	val = 0;
-	debug("%s: timing->flags 0x%08x\n", __func__, timings->flags);
+	dev_info(dev, "timing->flags 0x%08x\n", timings->flags);
 	if (timings->flags & DISPLAY_FLAGS_HSYNC_HIGH)
 		val |= GCR_HSPOL;
 	if (timings->flags & DISPLAY_FLAGS_VSYNC_HIGH)
@@ -343,26 +340,25 @@ static int stm32_ltdc_probe(struct udevice *dev)
 
 	priv->regs = (void *)dev_read_addr(dev);
 	if ((fdt_addr_t)priv->regs == FDT_ADDR_T_NONE) {
-		debug("%s: ltdc dt register address error\n", __func__);
+		dev_err(dev, "ltdc dt register address error\n");
 		return -EINVAL;
 	}
 
 	ret = clk_get_by_index(dev, 0, &pclk);
 	if (ret) {
-		debug("%s: peripheral clock get error %d\n", __func__, ret);
+		dev_err(dev, "peripheral clock get error %d\n", ret);
 		return ret;
 	}
 
 	ret = clk_enable(&pclk);
 	if (ret) {
-		debug("%s: peripheral clock enable error %d\n",
-		      __func__, ret);
+		dev_err(dev, "peripheral clock enable error %d\n", ret);
 		return ret;
 	}
 
 	ret = reset_get_by_index(dev, 0, &rst);
 	if (ret) {
-		debug("%s: missing ltdc hardware reset\n", __func__);
+		dev_err(dev, "missing ltdc hardware reset\n");
 		return -ENODEV;
 	}
 
@@ -371,42 +367,39 @@ static int stm32_ltdc_probe(struct udevice *dev)
 
 #ifdef CONFIG_VIDEO_BRIDGE
 	ret = uclass_get_device(UCLASS_VIDEO_BRIDGE, 0, &bridge);
-	if (ret) {
-		debug("%s: No video bridge, or no backlight on bridge\n",
-		      __func__);
-	}
+	if (ret)
+		dev_info(dev, "No video bridge, or no backlight on bridge\n");
 
 	if (bridge) {
 		ret = video_bridge_attach(bridge);
 		if (ret) {
-			debug("%s: fail to attach bridge\n", __func__);
+			dev_err(dev, "fail to attach bridge\n");
 			return ret;
 		}
 	}
 #endif
 	ret = uclass_first_device(UCLASS_PANEL, &panel);
 	if (ret) {
-		debug("%s: panel device error %d\n", __func__, ret);
+		dev_err(dev, "panel device error %d\n", ret);
 		return ret;
 	}
 
 	ret = fdtdec_decode_display_timing(gd->fdt_blob, dev_of_offset(panel),
 					   0, &timings);
 	if (ret) {
-		debug("%s: decode display timing error %d\n",
-		      __func__, ret);
+		dev_err(dev, "decode display timing error %d\n", ret);
 		return ret;
 	}
 
 	rate = clk_set_rate(&pclk, timings.pixelclock.typ);
 	if (rate < 0) {
-		debug("%s: fail to set pixel clock %d hz %d hz\n",
-		      __func__, timings.pixelclock.typ, rate);
+		dev_err(dev, "fail to set pixel clock %d hz %d hz\n",
+			timings.pixelclock.typ, rate);
 		return rate;
 	}
 
-	debug("%s: Set pixel clock req %d hz get %d hz\n", __func__,
-	      timings.pixelclock.typ, rate);
+	dev_info(dev, "set pixel clock req %d hz get %d hz\n",
+		 timings.pixelclock.typ, rate);
 
 	/* TODO Below parameters are hard-coded for the moment... */
 	priv->l2bpp = VIDEO_BPP16;
@@ -417,12 +410,12 @@ static int stm32_ltdc_probe(struct udevice *dev)
 	priv->crop_h = timings.vactive.typ;
 	priv->alpha = 0xFF;
 
-	debug("%s: %dx%d %dbpp frame buffer at 0x%lx\n", __func__,
-	      timings.hactive.typ, timings.vactive.typ,
-	      VNBITS(priv->l2bpp), uc_plat->base);
-	debug("%s: crop %d,%d %dx%d bg 0x%08x alpha %d\n", __func__,
-	      priv->crop_x, priv->crop_y, priv->crop_w, priv->crop_h,
-	      priv->bg_col_argb, priv->alpha);
+	dev_info(dev, "%dx%d %dbpp frame buffer at 0x%lx\n",
+		 timings.hactive.typ, timings.vactive.typ,
+		 VNBITS(priv->l2bpp), uc_plat->base);
+	dev_info(dev, "crop %d,%d %dx%d bg 0x%08x alpha %d\n",
+		 priv->crop_x, priv->crop_y, priv->crop_w, priv->crop_h,
+		 priv->bg_col_argb, priv->alpha);
 
 	/* Configure & start LTDC */
 	stm32_ltdc_set_mode(priv, &timings);
@@ -437,22 +430,22 @@ static int stm32_ltdc_probe(struct udevice *dev)
 	if (bridge) {
 		ret = video_bridge_set_backlight(bridge, 80);
 		if (ret) {
-			debug("%s: fail to set backlight\n", __func__);
+			dev_err(dev, "fail to set backlight\n");
 			return ret;
 		}
 	} else {
 		ret = panel_enable_backlight(panel);
 		if (ret) {
-			debug("%s: panel %s enable backlight error %d\n",
-			      __func__, panel->name, ret);
+			dev_err(dev, "panel %s enable backlight error %d\n",
+				panel->name, ret);
 			return ret;
 		}
 	}
 #else
 	ret = panel_enable_backlight(panel);
 	if (ret) {
-		debug("%s: panel %s enable backlight error %d\n",
-		      __func__, panel->name, ret);
+		dev_err(dev, "panel %s enable backlight error %d\n",
+			panel->name, ret);
 		return ret;
 	}
 #endif
@@ -468,7 +461,7 @@ static int stm32_ltdc_bind(struct udevice *dev)
 	uc_plat->size = CONFIG_VIDEO_STM32_MAX_XRES *
 			CONFIG_VIDEO_STM32_MAX_YRES *
 			(CONFIG_VIDEO_STM32_MAX_BPP >> 3);
-	debug("%s: frame buffer max size %d bytes\n", __func__, uc_plat->size);
+	dev_info(dev, "frame buffer max size %d bytes\n", uc_plat->size);
 
 	return 0;
 }
-- 
1.9.1
