Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753027AbeDSJdd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 05:33:33 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:35708 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752778AbeDSJcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 05:32:35 -0400
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Jonathan Liu <net147@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 3/6] drm/sun4i: tcon: Add dithering support for RGB565/RGB666 LCD panels
Date: Thu, 19 Apr 2018 17:32:22 +0800
Message-Id: <20180419093225.614-4-wens@csie.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419093225.614-1-wens@csie.org>
References: <20180419093225.614-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
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

Hi Maxime,

The dithering parameters used here are different from the ones you used
in your MIPI DSI series. You might want to check if it still works for
you.

---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 63 +++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 2bd53ef7d4b8..827518f4790e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -12,6 +12,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_encoder.h>
@@ -276,8 +277,59 @@ static void sun4i_tcon0_mode_set_common(struct sun4i_tcon *tcon,
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
-				     struct drm_encoder *encoder,
+				     const struct drm_encoder *encoder,
 				     const struct drm_display_mode *mode)
 {
 	/* TODO support normal CPU interface modes */
@@ -293,6 +345,9 @@ static void sun4i_tcon0_mode_set_cpu(struct sun4i_tcon *tcon,
 
 	sun4i_tcon0_mode_set_common(tcon, mode);
 
+	/* Set dithering if needed */
+	sun4i_tcon0_mode_set_dithering(tcon, sun4i_tcon_get_connector(encoder));
+
 	regmap_update_bits(tcon->regs, SUN4I_TCON0_CTL_REG,
 			   SUN4I_TCON0_CTL_IF_MASK,
 			   SUN4I_TCON0_CTL_IF_8080);
@@ -358,6 +413,9 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
 	tcon->dclk_max_div = 7;
 	sun4i_tcon0_mode_set_common(tcon, mode);
 
+	/* Set dithering if needed */
+	sun4i_tcon0_mode_set_dithering(tcon, sun4i_tcon_get_connector(encoder));
+
 	/* Adjust clock delay */
 	clk_delay = sun4i_tcon_get_clk_delay(mode, 0);
 	regmap_update_bits(tcon->regs, SUN4I_TCON0_CTL_REG,
@@ -434,6 +492,9 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 	tcon->dclk_max_div = 127;
 	sun4i_tcon0_mode_set_common(tcon, mode);
 
+	/* Set dithering if needed */
+	sun4i_tcon0_mode_set_dithering(tcon, tcon->panel->connector);
+
 	/* Adjust clock delay */
 	clk_delay = sun4i_tcon_get_clk_delay(mode, 0);
 	regmap_update_bits(tcon->regs, SUN4I_TCON0_CTL_REG,
-- 
2.17.0
