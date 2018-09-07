Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0212EC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 04:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B668B20869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 04:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B668B20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbeIGJHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 05:07:45 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:39964 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbeIGJHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 05:07:43 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id C87335FD20; Fri,  7 Sep 2018 12:19:50 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Jonathan Liu <net147@gmail.com>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 3/6] drm/sun4i: tcon: Add dithering support for RGB565/RGB666 LCD panels
Date:   Fri,  7 Sep 2018 12:19:45 +0800
Message-Id: <20180907041948.19913-4-wens@csie.org>
X-Mailer: git-send-email 2.19.0.rc1
In-Reply-To: <20180907041948.19913-1-wens@csie.org>
References: <20180907041948.19913-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Liu <net147@gmail.com>

The hardware supports dithering on TCON channel 0 which is used for LCD
panels.

Dithering is a method of approximating a color from a mixture of other
colors when the required color isn't available. It reduces color
banding artifacts that can be observed when displaying gradients
(e.g. grayscale gradients). This may occur when the image that needs
to be displayed is 24-bit but the LCD panel is a lower bit depth and
does not perform dithering on its own.

Signed-off-by: Jonathan Liu <net147@gmail.com>
[wens@csie.org: check display_info.bpc first; handle LVDS and MIPI DSI]
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 61 ++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index d6f9d5f3b15b..4834c90b4912 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -12,6 +12,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_encoder.h>
@@ -277,6 +278,57 @@ static void sun4i_tcon0_mode_set_common(struct sun4i_tcon *tcon,
 		     SUN4I_TCON0_BASIC0_Y(mode->crtc_vdisplay));
 }
 
+static void sun4i_tcon0_mode_set_dithering(struct sun4i_tcon *tcon,
+					   const struct drm_connector *connector)
+{
+	u32 bus_format = 0;
+	u32 val = 0;
+
+	/* XXX Would this ever happen? */
+	if (!connector)
+		return;
+
+	/*
+	 * FIXME: Undocumented bits
+	 *
+	 * The whole dithering process and these parameters are not
+	 * explained in the vendor documents or BSP kernel code.
+	 */
+	regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED_PR_REG, 0x11111111);
+	regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED_PG_REG, 0x11111111);
+	regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED_PB_REG, 0x11111111);
+	regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED_LR_REG, 0x11111111);
+	regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED_LG_REG, 0x11111111);
+	regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED_LB_REG, 0x11111111);
+	regmap_write(tcon->regs, SUN4I_TCON0_FRM_TBL0_REG, 0x01010000);
+	regmap_write(tcon->regs, SUN4I_TCON0_FRM_TBL1_REG, 0x15151111);
+	regmap_write(tcon->regs, SUN4I_TCON0_FRM_TBL2_REG, 0x57575555);
+	regmap_write(tcon->regs, SUN4I_TCON0_FRM_TBL3_REG, 0x7f7f7777);
+
+	/* Do dithering if panel only supports 6 bits per color */
+	if (connector->display_info.bpc == 6)
+		val |= SUN4I_TCON0_FRM_CTL_EN;
+
+	if (connector->display_info.num_bus_formats == 1)
+		bus_format = connector->display_info.bus_formats[0];
+
+	/* Check the connection format */
+	switch (bus_format) {
+	case MEDIA_BUS_FMT_RGB565_1X16:
+		/* R and B components are only 5 bits deep */
+		val |= SUN4I_TCON0_FRM_CTL_MODE_R;
+		val |= SUN4I_TCON0_FRM_CTL_MODE_B;
+	case MEDIA_BUS_FMT_RGB666_1X18:
+	case MEDIA_BUS_FMT_RGB666_1X7X3_SPWG:
+		/* Fall through: enable dithering */
+		val |= SUN4I_TCON0_FRM_CTL_EN;
+		break;
+	}
+
+	/* Write dithering settings */
+	regmap_write(tcon->regs, SUN4I_TCON_FRM_CTL_REG, val);
+}
+
 static void sun4i_tcon0_mode_set_cpu(struct sun4i_tcon *tcon,
 				     const struct drm_encoder *encoder,
 				     const struct drm_display_mode *mode)
@@ -294,6 +346,9 @@ static void sun4i_tcon0_mode_set_cpu(struct sun4i_tcon *tcon,
 
 	sun4i_tcon0_mode_set_common(tcon, mode);
 
+	/* Set dithering if needed */
+	sun4i_tcon0_mode_set_dithering(tcon, sun4i_tcon_get_connector(encoder));
+
 	regmap_update_bits(tcon->regs, SUN4I_TCON0_CTL_REG,
 			   SUN4I_TCON0_CTL_IF_MASK,
 			   SUN4I_TCON0_CTL_IF_8080);
@@ -359,6 +414,9 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
 	tcon->dclk_max_div = 7;
 	sun4i_tcon0_mode_set_common(tcon, mode);
 
+	/* Set dithering if needed */
+	sun4i_tcon0_mode_set_dithering(tcon, sun4i_tcon_get_connector(encoder));
+
 	/* Adjust clock delay */
 	clk_delay = sun4i_tcon_get_clk_delay(mode, 0);
 	regmap_update_bits(tcon->regs, SUN4I_TCON0_CTL_REG,
@@ -432,6 +490,9 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 	tcon->dclk_max_div = 127;
 	sun4i_tcon0_mode_set_common(tcon, mode);
 
+	/* Set dithering if needed */
+	sun4i_tcon0_mode_set_dithering(tcon, tcon->panel->connector);
+
 	/* Adjust clock delay */
 	clk_delay = sun4i_tcon_get_clk_delay(mode, 0);
 	regmap_update_bits(tcon->regs, SUN4I_TCON0_CTL_REG,
-- 
2.19.0.rc1

