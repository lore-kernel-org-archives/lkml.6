Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936322AbeCBPoo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:44:44 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:9946 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S936268AbeCBPol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:44:41 -0500
From: yannick fertre <yannick.fertre@st.com>
To: Vikas Manocha <vikas.manocha@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Patrice Chotard <patrice.chotard@st.com>,
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
Subject: [PATCH v2 01/10] video: stm32: stm32_ltdc: add bridge to display controller
Date: Fri, 2 Mar 2018 16:44:02 +0100
Message-ID: <1520005451-23217-2-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520005451-23217-1-git-send-email-yannick.fertre@st.com>
References: <1520005451-23217-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.68]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-02_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manage a bridge insert between the display controller & a panel.

Signed-off-by: yannick fertre <yannick.fertre@st.com>
---
 drivers/video/stm32/stm32_ltdc.c | 107 ++++++++++++++++++++++++++-------------
 1 file changed, 71 insertions(+), 36 deletions(-)

diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm32_ltdc.c
index e160c77..bd9c0de 100644
--- a/drivers/video/stm32/stm32_ltdc.c
+++ b/drivers/video/stm32/stm32_ltdc.c
@@ -8,6 +8,7 @@
 
 #include <common.h>
 #include <clk.h>
+#include <display.h>
 #include <dm.h>
 #include <panel.h>
 #include <reset.h>
@@ -15,12 +16,12 @@
 #include <asm/io.h>
 #include <asm/arch/gpio.h>
 #include <dm/device-internal.h>
+#include <video_bridge.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
 struct stm32_ltdc_priv {
 	void __iomem *regs;
-	struct display_timing timing;
 	enum video_log2_bpp l2bpp;
 	u32 bg_col_argb;
 	u32 crop_x, crop_y, crop_w, crop_h;
@@ -210,23 +211,23 @@ static void stm32_ltdc_enable(struct stm32_ltdc_priv *priv)
 	setbits_le32(priv->regs + LTDC_GCR, GCR_LTDCEN);
 }
 
-static void stm32_ltdc_set_mode(struct stm32_ltdc_priv *priv)
+static void stm32_ltdc_set_mode(struct stm32_ltdc_priv *priv,
+				struct display_timing *timings)
 {
 	void __iomem *regs = priv->regs;
-	struct display_timing *timing = &priv->timing;
 	u32 hsync, vsync, acc_hbp, acc_vbp, acc_act_w, acc_act_h;
 	u32 total_w, total_h;
 	u32 val;
 
 	/* Convert video timings to ltdc timings */
-	hsync = timing->hsync_len.typ - 1;
-	vsync = timing->vsync_len.typ - 1;
-	acc_hbp = hsync + timing->hback_porch.typ;
-	acc_vbp = vsync + timing->vback_porch.typ;
-	acc_act_w = acc_hbp + timing->hactive.typ;
-	acc_act_h = acc_vbp + timing->vactive.typ;
-	total_w = acc_act_w + timing->hfront_porch.typ;
-	total_h = acc_act_h + timing->vfront_porch.typ;
+	hsync = timings->hsync_len.typ - 1;
+	vsync = timings->vsync_len.typ - 1;
+	acc_hbp = hsync + timings->hback_porch.typ;
+	acc_vbp = vsync + timings->vback_porch.typ;
+	acc_act_w = acc_hbp + timings->hactive.typ;
+	acc_act_h = acc_vbp + timings->vactive.typ;
+	total_w = acc_act_w + timings->hfront_porch.typ;
+	total_h = acc_act_h + timings->vfront_porch.typ;
 
 	/* Synchronization sizes */
 	val = (hsync << 16) | vsync;
@@ -248,14 +249,14 @@ static void stm32_ltdc_set_mode(struct stm32_ltdc_priv *priv)
 
 	/* Signal polarities */
 	val = 0;
-	debug("%s: timing->flags 0x%08x\n", __func__, timing->flags);
-	if (timing->flags & DISPLAY_FLAGS_HSYNC_HIGH)
+	debug("%s: timing->flags 0x%08x\n", __func__, timings->flags);
+	if (timings->flags & DISPLAY_FLAGS_HSYNC_HIGH)
 		val |= GCR_HSPOL;
-	if (timing->flags & DISPLAY_FLAGS_VSYNC_HIGH)
+	if (timings->flags & DISPLAY_FLAGS_VSYNC_HIGH)
 		val |= GCR_VSPOL;
-	if (timing->flags & DISPLAY_FLAGS_DE_HIGH)
+	if (timings->flags & DISPLAY_FLAGS_DE_HIGH)
 		val |= GCR_DEPOL;
-	if (timing->flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
+	if (timings->flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
 		val |= GCR_PCPOL;
 	clrsetbits_le32(regs + LTDC_GCR,
 			GCR_HSPOL | GCR_VSPOL | GCR_DEPOL | GCR_PCPOL, val);
@@ -331,7 +332,11 @@ static int stm32_ltdc_probe(struct udevice *dev)
 	struct video_uc_platdata *uc_plat = dev_get_uclass_platdata(dev);
 	struct video_priv *uc_priv = dev_get_uclass_priv(dev);
 	struct stm32_ltdc_priv *priv = dev_get_priv(dev);
-	struct udevice *panel;
+#ifdef CONFIG_VIDEO_BRIDGE
+	struct udevice *bridge = NULL;
+#endif
+	struct udevice *panel = NULL;
+	struct display_timing timings;
 	struct clk pclk;
 	struct reset_ctl rst;
 	int rate, ret;
@@ -364,63 +369,93 @@ static int stm32_ltdc_probe(struct udevice *dev)
 	/* Reset */
 	reset_deassert(&rst);
 
-	ret = uclass_first_device(UCLASS_PANEL, &panel);
+#ifdef CONFIG_VIDEO_BRIDGE
+	ret = uclass_get_device(UCLASS_VIDEO_BRIDGE, 0, &bridge);
 	if (ret) {
-		debug("%s: panel device error %d\n", __func__, ret);
-		return ret;
+		debug("%s: No video bridge, or no backlight on bridge\n",
+		      __func__);
 	}
 
-	ret = panel_enable_backlight(panel);
+	if (bridge) {
+		ret = video_bridge_attach(bridge);
+		if (ret) {
+			debug("%s: fail to attach bridge\n", __func__);
+			return ret;
+		}
+	}
+#endif
+	ret = uclass_first_device(UCLASS_PANEL, &panel);
 	if (ret) {
-		debug("%s: panel %s enable backlight error %d\n",
-		      __func__, panel->name, ret);
+		debug("%s: panel device error %d\n", __func__, ret);
 		return ret;
 	}
 
-	ret = fdtdec_decode_display_timing(gd->fdt_blob,
-					   dev_of_offset(dev), 0,
-					   &priv->timing);
+	ret = fdtdec_decode_display_timing(gd->fdt_blob, dev_of_offset(panel),
+					   0, &timings);
 	if (ret) {
 		debug("%s: decode display timing error %d\n",
 		      __func__, ret);
-		return -EINVAL;
+		return ret;
 	}
 
-	rate = clk_set_rate(&pclk, priv->timing.pixelclock.typ);
+	rate = clk_set_rate(&pclk, timings.pixelclock.typ);
 	if (rate < 0) {
 		debug("%s: fail to set pixel clock %d hz %d hz\n",
-		      __func__, priv->timing.pixelclock.typ, rate);
+		      __func__, timings.pixelclock.typ, rate);
 		return rate;
 	}
 
 	debug("%s: Set pixel clock req %d hz get %d hz\n", __func__,
-	      priv->timing.pixelclock.typ, rate);
+	      timings.pixelclock.typ, rate);
 
 	/* TODO Below parameters are hard-coded for the moment... */
 	priv->l2bpp = VIDEO_BPP16;
 	priv->bg_col_argb = 0xFFFFFFFF; /* white no transparency */
 	priv->crop_x = 0;
 	priv->crop_y = 0;
-	priv->crop_w = priv->timing.hactive.typ;
-	priv->crop_h = priv->timing.vactive.typ;
+	priv->crop_w = timings.hactive.typ;
+	priv->crop_h = timings.vactive.typ;
 	priv->alpha = 0xFF;
 
 	debug("%s: %dx%d %dbpp frame buffer at 0x%lx\n", __func__,
-	      priv->timing.hactive.typ, priv->timing.vactive.typ,
+	      timings.hactive.typ, timings.vactive.typ,
 	      VNBITS(priv->l2bpp), uc_plat->base);
 	debug("%s: crop %d,%d %dx%d bg 0x%08x alpha %d\n", __func__,
 	      priv->crop_x, priv->crop_y, priv->crop_w, priv->crop_h,
 	      priv->bg_col_argb, priv->alpha);
 
 	/* Configure & start LTDC */
-	stm32_ltdc_set_mode(priv);
+	stm32_ltdc_set_mode(priv, &timings);
 	stm32_ltdc_set_layer1(priv, uc_plat->base);
 	stm32_ltdc_enable(priv);
 
-	uc_priv->xsize = priv->timing.hactive.typ;
-	uc_priv->ysize = priv->timing.vactive.typ;
+	uc_priv->xsize = timings.hactive.typ;
+	uc_priv->ysize = timings.vactive.typ;
 	uc_priv->bpix = priv->l2bpp;
 
+#ifdef CONFIG_VIDEO_BRIDGE
+	if (bridge) {
+		ret = video_bridge_set_backlight(bridge, 80);
+		if (ret) {
+			debug("%s: fail to set backlight\n", __func__);
+			return ret;
+		}
+	} else {
+		ret = panel_enable_backlight(panel);
+		if (ret) {
+			debug("%s: panel %s enable backlight error %d\n",
+			      __func__, panel->name, ret);
+			return ret;
+		}
+	}
+#else
+	ret = panel_enable_backlight(panel);
+	if (ret) {
+		debug("%s: panel %s enable backlight error %d\n",
+		      __func__, panel->name, ret);
+		return ret;
+	}
+#endif
 	video_set_flush_dcache(dev, true);
 
 	return 0;
-- 
1.9.1
