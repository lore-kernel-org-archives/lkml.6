Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A6FECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58ECA20862
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58ECA20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbeGQILP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:11:15 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55455 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbeGQILO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:11:14 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 32791207E8; Tue, 17 Jul 2018 09:39:58 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id CB4BD20799;
        Tue, 17 Jul 2018 09:39:47 +0200 (CEST)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@googlegroups.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH] drm/sun4i: sun8i: Avoid clearing blending order at each atomic commit
Date:   Tue, 17 Jul 2018 09:39:04 +0200
Message-Id: <20180717073904.14259-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Blending order is set based on the z position of each DRM plane. The
blending order register is currently cleared at each atomic DRM commit,
with the intent that each committed plane will set the appropriate
bits (based on its z-pos) when enabling the plane.

However, it sometimes happens that a particular plane is left unchanged
by an atomic commit and thus will not be configured again. In that
scenario, blending order is cleared and only the bits relevant for the
planes affected by the commit are set. This leaves the planes that did
not change without their blending order set in the register, leading
to that plane not being displayed.

Instead of clearing the blending order register at every atomic commit,
this change moves the register's initial clear at bind time and only
clears the bits for a specific plane when disabling it or changing its
zpos.

This way, planes that are left untouched by a DRM atomic commit are
no longer disabled.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 11 +++--------
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 24 ++++++++++++++++++++----
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 24 ++++++++++++++++++++----
 3 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 9bd069de3124..12cb7183ce51 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -260,13 +260,6 @@ const struct de2_fmt_info *sun8i_mixer_format_info(u32 format)
 	return NULL;
 }
 
-static void sun8i_mixer_atomic_begin(struct sunxi_engine *engine,
-				     struct drm_crtc_state *old_state)
-{
-	regmap_update_bits(engine->regs, SUN8I_MIXER_BLEND_PIPE_CTL,
-			   SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK, 0);
-}
-
 static void sun8i_mixer_commit(struct sunxi_engine *engine)
 {
 	DRM_DEBUG_DRIVER("Committing changes\n");
@@ -318,7 +311,6 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 }
 
 static const struct sunxi_engine_ops sun8i_engine_ops = {
-	.atomic_begin	= sun8i_mixer_atomic_begin,
 	.commit		= sun8i_mixer_commit,
 	.layers_init	= sun8i_layers_init,
 };
@@ -445,6 +437,9 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 		regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_MODE(i),
 			     SUN8I_MIXER_BLEND_MODE_DEF);
 
+	regmap_update_bits(mixer->engine.regs, SUN8I_MIXER_BLEND_PIPE_CTL,
+			   SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK, 0);
+
 	return 0;
 
 err_disable_bus_clk:
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index 1a12cb02f2d2..f98fd9a9dd78 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -27,7 +27,8 @@
 #include "sun8i_ui_scaler.h"
 
 static void sun8i_ui_layer_enable(struct sun8i_mixer *mixer, int channel,
-				  int overlay, bool enable, unsigned int zpos)
+				  int overlay, bool enable, unsigned int zpos,
+				  unsigned int old_zpos)
 {
 	u32 val;
 
@@ -43,6 +44,18 @@ static void sun8i_ui_layer_enable(struct sun8i_mixer *mixer, int channel,
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(channel, overlay),
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN, val);
 
+	if (!enable || zpos != old_zpos) {
+		regmap_update_bits(mixer->engine.regs,
+				   SUN8I_MIXER_BLEND_PIPE_CTL,
+				   SUN8I_MIXER_BLEND_PIPE_CTL_EN(old_zpos),
+				   0);
+
+		regmap_update_bits(mixer->engine.regs,
+				   SUN8I_MIXER_BLEND_ROUTE,
+				   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(old_zpos),
+				   0);
+	}
+
 	if (enable) {
 		val = SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
 
@@ -242,9 +255,11 @@ static void sun8i_ui_layer_atomic_disable(struct drm_plane *plane,
 					  struct drm_plane_state *old_state)
 {
 	struct sun8i_ui_layer *layer = plane_to_sun8i_ui_layer(plane);
+	unsigned int old_zpos = old_state->normalized_zpos;
 	struct sun8i_mixer *mixer = layer->mixer;
 
-	sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay, false, 0);
+	sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay, false, 0,
+			      old_zpos);
 }
 
 static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
@@ -252,11 +267,12 @@ static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
 {
 	struct sun8i_ui_layer *layer = plane_to_sun8i_ui_layer(plane);
 	unsigned int zpos = plane->state->normalized_zpos;
+	unsigned int old_zpos = old_state->normalized_zpos;
 	struct sun8i_mixer *mixer = layer->mixer;
 
 	if (!plane->state->visible) {
 		sun8i_ui_layer_enable(mixer, layer->channel,
-				      layer->overlay, false, zpos);
+				      layer->overlay, false, zpos, old_zpos);
 		return;
 	}
 
@@ -267,7 +283,7 @@ static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
 	sun8i_ui_layer_update_buffer(mixer, layer->channel,
 				     layer->overlay, plane);
 	sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay,
-			      true, zpos);
+			      true, zpos, old_zpos);
 }
 
 static struct drm_plane_helper_funcs sun8i_ui_layer_helper_funcs = {
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index 8ef64f164c1d..dd935a5fffa6 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -21,7 +21,8 @@
 #include "sun8i_vi_scaler.h"
 
 static void sun8i_vi_layer_enable(struct sun8i_mixer *mixer, int channel,
-				  int overlay, bool enable, unsigned int zpos)
+				  int overlay, bool enable, unsigned int zpos,
+				  unsigned int old_zpos)
 {
 	u32 val;
 
@@ -37,6 +38,18 @@ static void sun8i_vi_layer_enable(struct sun8i_mixer *mixer, int channel,
 			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(channel, overlay),
 			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN, val);
 
+	if (!enable || zpos != old_zpos) {
+		regmap_update_bits(mixer->engine.regs,
+				   SUN8I_MIXER_BLEND_PIPE_CTL,
+				   SUN8I_MIXER_BLEND_PIPE_CTL_EN(old_zpos),
+				   0);
+
+		regmap_update_bits(mixer->engine.regs,
+				   SUN8I_MIXER_BLEND_ROUTE,
+				   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(old_zpos),
+				   0);
+	}
+
 	if (enable) {
 		val = SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
 
@@ -270,9 +283,11 @@ static void sun8i_vi_layer_atomic_disable(struct drm_plane *plane,
 					  struct drm_plane_state *old_state)
 {
 	struct sun8i_vi_layer *layer = plane_to_sun8i_vi_layer(plane);
+	unsigned int old_zpos = old_state->normalized_zpos;
 	struct sun8i_mixer *mixer = layer->mixer;
 
-	sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay, false, 0);
+	sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay, false, 0,
+			      old_zpos);
 }
 
 static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
@@ -280,11 +295,12 @@ static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
 {
 	struct sun8i_vi_layer *layer = plane_to_sun8i_vi_layer(plane);
 	unsigned int zpos = plane->state->normalized_zpos;
+	unsigned int old_zpos = old_state->normalized_zpos;
 	struct sun8i_mixer *mixer = layer->mixer;
 
 	if (!plane->state->visible) {
 		sun8i_vi_layer_enable(mixer, layer->channel,
-				      layer->overlay, false, zpos);
+				      layer->overlay, false, zpos, old_zpos);
 		return;
 	}
 
@@ -295,7 +311,7 @@ static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
 	sun8i_vi_layer_update_buffer(mixer, layer->channel,
 				     layer->overlay, plane);
 	sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay,
-			      true, zpos);
+			      true, zpos, old_zpos);
 }
 
 static struct drm_plane_helper_funcs sun8i_vi_layer_helper_funcs = {
-- 
2.17.1

