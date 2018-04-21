Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbeDUFA2 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 01:00:28 -0400
Received: from vps.xff.cz ([195.181.215.36]:46516 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750805AbeDUFA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 01:00:27 -0400
From: megous@megous.com
To: dev@linux-sunxi.org
Cc: Ondrej Jirman <megous@megous.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR ALLWINNER
        A10),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Revert "drm/sun4i: add lvds mode_valid function"
Date: Sat, 21 Apr 2018 06:51:55 +0200
Message-Id: <20180421045155.15332-1-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

The reverted commit broke LVDS output on TBS A711 Tablet. That tablet
has simple-panel node that has fixed pixel clock-frequency that A83T
SoC used in the tablet can't generate exactly.

Requested rate is 52000000 and rounded_rate is calculated as 51857142.
It's close enough for it to work in practice, but with strict check
in the reverted commit, the mode is rejected needlessly in this case.

DT allows to specify a range of values for simple-panel/clock-frequency,
but driver doesn't respect that ATM. Given that TBS A711 is the single
user of sun4i-lvds driver, let's revert that commit for now, until
a better solution for the problem is found.

Also see: https://patchwork.kernel.org/patch/9446385/ for relevant
discussion (or search for "[RFC] drm/sun4i: rgb: Add 5% tolerance
to dot clock frequency check").

Fixes: e4e4b7ad50cf ("drm/sun4i: add lvds mode_valid function")
Reported-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 drivers/gpu/drm/sun4i/sun4i_lvds.c | 55 ------------------------------
 1 file changed, 55 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_lvds.c b/drivers/gpu/drm/sun4i/sun4i_lvds.c
index bffff4c9fbf5..be3f14d7746d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_lvds.c
+++ b/drivers/gpu/drm/sun4i/sun4i_lvds.c
@@ -94,64 +94,9 @@ static void sun4i_lvds_encoder_disable(struct drm_encoder *encoder)
 	}
 }
 
-static enum drm_mode_status sun4i_lvds_encoder_mode_valid(struct drm_encoder *crtc,
-							  const struct drm_display_mode *mode)
-{
-	struct sun4i_lvds *lvds = drm_encoder_to_sun4i_lvds(crtc);
-	struct sun4i_tcon *tcon = lvds->tcon;
-	u32 hsync = mode->hsync_end - mode->hsync_start;
-	u32 vsync = mode->vsync_end - mode->vsync_start;
-	unsigned long rate = mode->clock * 1000;
-	long rounded_rate;
-
-	DRM_DEBUG_DRIVER("Validating modes...\n");
-
-	if (hsync < 1)
-		return MODE_HSYNC_NARROW;
-
-	if (hsync > 0x3ff)
-		return MODE_HSYNC_WIDE;
-
-	if ((mode->hdisplay < 1) || (mode->htotal < 1))
-		return MODE_H_ILLEGAL;
-
-	if ((mode->hdisplay > 0x7ff) || (mode->htotal > 0xfff))
-		return MODE_BAD_HVALUE;
-
-	DRM_DEBUG_DRIVER("Horizontal parameters OK\n");
-
-	if (vsync < 1)
-		return MODE_VSYNC_NARROW;
-
-	if (vsync > 0x3ff)
-		return MODE_VSYNC_WIDE;
-
-	if ((mode->vdisplay < 1) || (mode->vtotal < 1))
-		return MODE_V_ILLEGAL;
-
-	if ((mode->vdisplay > 0x7ff) || (mode->vtotal > 0xfff))
-		return MODE_BAD_VVALUE;
-
-	DRM_DEBUG_DRIVER("Vertical parameters OK\n");
-
-	tcon->dclk_min_div = 7;
-	tcon->dclk_max_div = 7;
-	rounded_rate = clk_round_rate(tcon->dclk, rate);
-	if (rounded_rate < rate)
-		return MODE_CLOCK_LOW;
-
-	if (rounded_rate > rate)
-		return MODE_CLOCK_HIGH;
-
-	DRM_DEBUG_DRIVER("Clock rate OK\n");
-
-	return MODE_OK;
-}
-
 static const struct drm_encoder_helper_funcs sun4i_lvds_enc_helper_funcs = {
 	.disable	= sun4i_lvds_encoder_disable,
 	.enable		= sun4i_lvds_encoder_enable,
-	.mode_valid	= sun4i_lvds_encoder_mode_valid,
 };
 
 static const struct drm_encoder_funcs sun4i_lvds_enc_funcs = {
-- 
2.17.0
