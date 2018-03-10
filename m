Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752248AbeCJLFp (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 06:05:45 -0500
Received: from vps.xff.cz ([195.181.215.36]:37266 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752166AbeCJLFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 06:05:32 -0500
From: megous@megous.com
To: dev@linux-sunxi.org
Cc: Ondrej Jirman <megous@megous.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR ALLWINNER
        A10),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/sun4i: Fix exclusivity of the TCON clocks
Date: Sat, 10 Mar 2018 12:05:11 +0100
Message-Id: <20180310110511.14697-1-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

Currently the exclusivity is enabled when the rate is set by
the mode setting functions. These functions are called by
mode_set_nofb callback of drm_crc_helper. Then exclusivity
is disabled when tcon is disabled by atomic_disable
callback.

What happens is that mode_set_nofb can be called once when
mode chnages, and afterwards the system can call atomic_enable
and atomic_disable multiple times without further calls to
mode_set_nofb.

This happens:

mode_set_nofb   - clk exclusivity is enabled
atomic_enable
atomic_disable  - clk exclusivity is disabled
atomic_enable
atomic_disable  - clk exclusivity is already disabled, leading to WARN
                  in clk_rate_exclusive_put

Solution is to enable exclusivity in sun4i_tcon_channel_set_status.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index d4a29847dadd..cc29daa062f7 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -104,6 +104,7 @@ static void sun4i_tcon_channel_set_status(struct sun4i_tcon *tcon, int channel,
 
 	if (enabled) {
 		clk_prepare_enable(clk);
+		clk_rate_exclusive_get(clk);
 	} else {
 		clk_rate_exclusive_put(clk);
 		clk_disable_unprepare(clk);
@@ -263,7 +264,7 @@ static void sun4i_tcon0_mode_set_common(struct sun4i_tcon *tcon,
 					const struct drm_display_mode *mode)
 {
 	/* Configure the dot clock */
-	clk_set_rate_exclusive(tcon->dclk, mode->crtc_clock * 1000);
+	clk_set_rate(tcon->dclk, mode->crtc_clock * 1000);
 
 	/* Set the resolution */
 	regmap_write(tcon->regs, SUN4I_TCON0_BASIC0_REG,
@@ -428,7 +429,7 @@ static void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
 	WARN_ON(!tcon->quirks->has_channel_1);
 
 	/* Configure the dot clock */
-	clk_set_rate_exclusive(tcon->sclk1, mode->crtc_clock * 1000);
+	clk_set_rate(tcon->sclk1, mode->crtc_clock * 1000);
 
 	/* Adjust clock delay */
 	clk_delay = sun4i_tcon_get_clk_delay(mode, 1);
-- 
2.16.2
