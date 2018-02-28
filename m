Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752473AbeB1Mwu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 07:52:50 -0500
Received: from mail.micronovasrl.com ([212.103.203.10]:55216 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752206AbeB1Mws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 07:52:48 -0500
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH] drm/sun4i: init dclk_min_div & dclk_max_div inside encoder init functions
Date: Wed, 28 Feb 2018 13:51:58 +0100
Message-Id: <1519822318-3974-1-git-send-email-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sun4i_dclk_round_rate is called before sun4i_tcon_mode_set,
so it finds dclk_min_div and dclk_max_div set to 0 and fails
adding crtc.

Move dclk_min_div and dclk_max_div to encoders init functions.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/gpu/drm/sun4i/sun4i_lvds.c | 4 ++++
 drivers/gpu/drm/sun4i/sun4i_rgb.c  | 4 ++++
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 ----
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_lvds.c b/drivers/gpu/drm/sun4i/sun4i_lvds.c
index be3f14d..6e1abd6 100644
--- a/drivers/gpu/drm/sun4i/sun4i_lvds.c
+++ b/drivers/gpu/drm/sun4i/sun4i_lvds.c
@@ -123,6 +123,10 @@ int sun4i_lvds_init(struct drm_device *drm, struct sun4i_tcon *tcon)
 		return 0;
 	}
 
+	/* Init min and max clock divisor according to LVDS encoder */
+	tcon->dclk_min_div = 7;
+	tcon->dclk_max_div = 7;
+
 	drm_encoder_helper_add(&lvds->encoder,
 			       &sun4i_lvds_enc_helper_funcs);
 	ret = drm_encoder_init(drm,
diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index 832f8f9..75ab3e5 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -187,6 +187,10 @@ int sun4i_rgb_init(struct drm_device *drm, struct sun4i_tcon *tcon)
 		return 0;
 	}
 
+	/* Init min and max clock divisor according to RGB encoder */
+	tcon->dclk_min_div = 6;
+	tcon->dclk_max_div = 127;
+
 	drm_encoder_helper_add(&rgb->encoder,
 			       &sun4i_rgb_enc_helper_funcs);
 	ret = drm_encoder_init(drm,
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index e7c5e3c..ce89fd4 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -277,8 +277,6 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
 	u8 clk_delay;
 	u32 reg, val = 0;
 
-	tcon->dclk_min_div = 7;
-	tcon->dclk_max_div = 7;
 	sun4i_tcon0_mode_set_common(tcon, mode);
 
 	/* Adjust clock delay */
@@ -348,8 +346,6 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 	u8 clk_delay;
 	u32 val = 0;
 
-	tcon->dclk_min_div = 6;
-	tcon->dclk_max_div = 127;
 	sun4i_tcon0_mode_set_common(tcon, mode);
 
 	/* Adjust clock delay */
-- 
2.7.4
