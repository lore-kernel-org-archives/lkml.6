Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752860AbeCUPcb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:32:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47295 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752710AbeCUPau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:30:50 -0400
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 10/10] drm/sun4i: Add support for YUV-based formats in MB32 tiles
Date: Wed, 21 Mar 2018 16:29:04 +0100
Message-Id: <20180321152904.22411-11-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds all the required configuration and support for handling YUV
formats tiled with the Allwinner MB32 modifier. This newly-introduced
YUV support should be in as good a shape as RGB support.

While this implementation covers most MB32-capable formats supported
by the frontend, only NV12-based formats were actually tested.
Since most of the logic is common, it is likely that other formats will
work just as well.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c  |  10 +++-
 drivers/gpu/drm/sun4i/sun4i_backend.h  |   2 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c      |   1 +
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 100 ++++++++++++++++++++++++++++-----
 drivers/gpu/drm/sun4i/sun4i_frontend.h |   3 +-
 drivers/gpu/drm/sun4i/sun4i_layer.c    |  16 +++++-
 6 files changed, 113 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 3de7f3a427c3..335c444b1547 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -147,11 +147,14 @@ static const uint32_t sun4i_backend_formats[] = {
 	DRM_FORMAT_VYUY,
 };
 
-bool sun4i_backend_format_is_supported(uint32_t fmt)
+bool sun4i_backend_format_is_supported(uint32_t fmt, uint64_t modifier)
 {
 	bool found = false;
 	unsigned int i;
 
+	if (modifier == DRM_FORMAT_MOD_ALLWINNER_MB32_TILED)
+		return false;
+
 	for (i = 0; i < ARRAY_SIZE(sun4i_backend_formats); i++) {
 		if (sun4i_backend_formats[i] == fmt) {
 			found = true;
@@ -437,7 +440,8 @@ static bool sun4i_backend_plane_uses_frontend(struct drm_plane_state *state)
 	 * not supported by either. There is still room to check this later in
 	 * the atomic check process.
 	 */
-	if (!sun4i_backend_format_is_supported(fb->format->format))
+	if (!sun4i_backend_format_is_supported(fb->format->format,
+					       fb->modifier))
 		return true;
 
 	/*
@@ -489,7 +493,7 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 		struct drm_format_name_buf format_name;
 
 		if (sun4i_backend_plane_uses_frontend(plane_state)) {
-			if (!sun4i_frontend_format_is_supported(fb->format->format)) {
+			if (!sun4i_frontend_plane_check(plane_state)) {
 				DRM_DEBUG_DRIVER("Frontend plane check failed\n");
 				return -EINVAL;
 			}
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.h b/drivers/gpu/drm/sun4i/sun4i_backend.h
index a7bfc38f12bd..bd93808c3ee7 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.h
@@ -207,6 +207,6 @@ int sun4i_backend_update_layer_zpos(struct sun4i_backend *backend,
 				    int layer, struct drm_plane *plane);
 void sun4i_backend_disable_layer_frontend(struct sun4i_backend *backend,
 					  int layer);
-bool sun4i_backend_format_is_supported(uint32_t fmt);
+bool sun4i_backend_format_is_supported(uint32_t fmt, uint64_t modifier);
 
 #endif /* _SUN4I_BACKEND_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index e9cb03d34b44..41888743722a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -208,6 +208,7 @@ static int sun4i_drv_bind(struct device *dev)
 	}
 
 	drm_mode_config_init(drm);
+	drm->mode_config.allow_fb_modifiers = true;
 
 	ret = component_bind_all(drm->dev, drm);
 	if (ret) {
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index d9e58e96119c..85f75046712c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -99,16 +99,56 @@ void sun4i_frontend_update_buffer(struct sun4i_frontend *frontend,
 	width = state->src_w >> 16;
 	height = state->src_h >> 16;
 
-	regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD0_REG,
-		     fb->pitches[0]);
+	if (fb->modifier == DRM_FORMAT_MOD_ALLWINNER_MB32_TILED) {
+		/*
+		 * In MB32 tiled mode, the stride is defined as the distance
+		 * between the start of the end line of the current tile and
+		 * the start of the first line in the next vertical tile.
+		 *
+		 * Tiles are represented linearly in memory, thus the end line
+		 * of current tile starts at: 31 * 32 (31 lines of 32 cols),
+		 * the next vertical tile starts at: 32-bit-aligned-width * 32
+		 * and the distance is: 32 * (32-bit-aligned-width - 31).
+		 */
+
+		stride = (fb->pitches[0] - 31) * 32;
+		regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD0_REG,
+			     stride);
+
+		/* Offset of the bottom-right point in the end tile. */
+		offset = (width + (32 - 1)) & (32 - 1);
+		regmap_write(frontend->regs, SUN4I_FRONTEND_TB_OFF0_REG,
+			     SUN4I_FRONTEND_TB_OFF_X1(offset));
+
+		if (drm_format_num_planes(format) > 1) {
+			stride = (fb->pitches[1] - 31) * 32;
+			regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD1_REG,
+				     stride);
+
+			regmap_write(frontend->regs, SUN4I_FRONTEND_TB_OFF1_REG,
+				     SUN4I_FRONTEND_TB_OFF_X1(offset));
+		}
+
+		if (drm_format_num_planes(format) > 2) {
+			stride = (fb->pitches[2] - 31) * 32;
+			regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD2_REG,
+				     stride);
+
+			regmap_write(frontend->regs, SUN4I_FRONTEND_TB_OFF2_REG,
+				     SUN4I_FRONTEND_TB_OFF_X1(offset));
+		}
+	} else {
+		regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD0_REG,
+			     fb->pitches[0]);
 
-	if (drm_format_num_planes(format) > 1)
-		regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD1_REG,
-			     fb->pitches[1]);
+		if (drm_format_num_planes(format) > 1)
+			regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD1_REG,
+				     fb->pitches[1]);
 
-	if (drm_format_num_planes(format) > 2)
-		regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD2_REG,
-			     fb->pitches[2]);
+		if (drm_format_num_planes(format) > 2)
+			regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD2_REG,
+				     fb->pitches[2]);
+	}
 
 	/* Set the physical address of the buffer in memory */
 	paddr = drm_fb_cma_get_gem_addr(fb, state, 0);
@@ -155,14 +195,22 @@ static int sun4i_frontend_drm_format_to_input_fmt(uint32_t fmt, u32 *val)
 	return 0;
 }
 
-static int sun4i_frontend_drm_format_to_input_mode(uint32_t fmt, u32 *val)
+static int sun4i_frontend_drm_format_to_input_mode(uint32_t fmt, u32 *val,
+						   uint64_t modifier)
 {
+	bool tiled = modifier == DRM_FORMAT_MOD_ALLWINNER_MB32_TILED;
+
+	if (tiled && !sun4i_format_supports_tiling(fmt))
+		return -EINVAL;
+
 	if (sun4i_format_is_packed(fmt))
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PACKED;
 	else if (sun4i_format_is_semiplanar(fmt))
-		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_SEMIPLANAR;
+		*val = tiled ? SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_MB32_SEMIPLANAR
+			     : SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_SEMIPLANAR;
 	else if (sun4i_format_is_planar(fmt))
-		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PLANAR;
+		*val = tiled ? SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_MB32_PLANAR
+			     : SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PLANAR;
 	else
 		return -EINVAL;
 
@@ -268,7 +316,7 @@ static const uint32_t sun4i_frontend_formats[] = {
 	DRM_FORMAT_YVU411,
 };
 
-bool sun4i_frontend_format_is_supported(uint32_t fmt)
+bool sun4i_frontend_format_is_supported(uint32_t fmt, uint64_t modifier)
 {
 	bool found = false;
 	unsigned int i;
@@ -283,6 +331,31 @@ bool sun4i_frontend_format_is_supported(uint32_t fmt)
 	if (!found)
 		return false;
 
+	if (modifier == DRM_FORMAT_MOD_ALLWINNER_MB32_TILED)
+		return sun4i_format_supports_tiling(fmt);
+
+	return true;
+}
+
+bool sun4i_frontend_plane_check(struct drm_plane_state *state)
+{
+	struct drm_framebuffer *fb = state->fb;
+	uint32_t format = fb->format->format;
+	uint32_t width = state->src_w >> 16;
+	uint64_t modifier = fb->modifier;
+	bool supported;
+
+	supported = sun4i_frontend_format_is_supported(format, modifier);
+	if (!supported)
+		return false;
+
+	/* Width is required to be even for MB32 tiled format. */
+	if (modifier == DRM_FORMAT_MOD_ALLWINNER_MB32_TILED &&
+	    (width % 2) != 0) {
+		DRM_DEBUG_DRIVER("MB32 tiled format requires an even width\n");
+		return false;
+	}
+
 	return true;
 }
 
@@ -320,7 +393,8 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 		return ret;
 	}
 
-	ret = sun4i_frontend_drm_format_to_input_mode(format, &in_mod_val);
+	ret = sun4i_frontend_drm_format_to_input_mode(format, &in_mod_val,
+						      fb->modifier);
 	if (ret) {
 		DRM_DEBUG_DRIVER("Invalid input mode\n");
 		return ret;
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index 6dd1d18752f4..ab6ab4f16f74 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -134,7 +134,8 @@ void sun4i_frontend_update_coord(struct sun4i_frontend *frontend,
 				 struct drm_plane *plane);
 int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 				  struct drm_plane *plane, uint32_t out_fmt);
-bool sun4i_frontend_format_is_supported(uint32_t fmt);
+bool sun4i_frontend_format_is_supported(uint32_t fmt, uint64_t modifier);
+bool sun4i_frontend_plane_check(struct drm_plane_state *plane_state);
 bool sun4i_frontend_format_chroma_requires_swap(uint32_t fmt);
 
 #endif /* _SUN4I_FRONTEND_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index a39eed6a0e75..d456148ed4b3 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -114,6 +114,13 @@ static void sun4i_backend_layer_atomic_update(struct drm_plane *plane,
 	sun4i_backend_layer_enable(backend, layer->id, true);
 }
 
+static bool sun4i_layer_format_mod_supported(struct drm_plane *plane,
+					     uint32_t format, uint64_t modifier)
+{
+	return sun4i_backend_format_is_supported(format, modifier) ||
+		sun4i_frontend_format_is_supported(format, modifier);
+}
+
 static const struct drm_plane_helper_funcs sun4i_backend_layer_helper_funcs = {
 	.atomic_disable	= sun4i_backend_layer_atomic_disable,
 	.atomic_update	= sun4i_backend_layer_atomic_update,
@@ -126,6 +133,7 @@ static const struct drm_plane_funcs sun4i_backend_layer_funcs = {
 	.disable_plane		= drm_atomic_helper_disable_plane,
 	.reset			= sun4i_backend_layer_reset,
 	.update_plane		= drm_atomic_helper_update_plane,
+	.format_mod_supported	= sun4i_layer_format_mod_supported,
 };
 
 static const uint32_t sun4i_layer_formats[] = {
@@ -161,6 +169,12 @@ static const uint32_t sun4i_layer_formats[] = {
 	DRM_FORMAT_YVU411,
 };
 
+static const uint64_t sun4i_layer_modifiers[] = {
+	DRM_FORMAT_MOD_LINEAR,
+	DRM_FORMAT_MOD_ALLWINNER_MB32_TILED,
+	DRM_FORMAT_MOD_INVALID
+};
+
 static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
 						struct sun4i_backend *backend,
 						enum drm_plane_type type)
@@ -177,7 +191,7 @@ static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
 				       &sun4i_backend_layer_funcs,
 				       sun4i_layer_formats,
 				       ARRAY_SIZE(sun4i_layer_formats),
-				       NULL, type, NULL);
+				       sun4i_layer_modifiers, type, NULL);
 	if (ret) {
 		dev_err(drm->dev, "Couldn't initialize layer\n");
 		return ERR_PTR(ret);
-- 
2.16.2
