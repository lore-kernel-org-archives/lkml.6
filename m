Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED1AECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943AA21508
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943AA21508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbeIRW4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:56:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:1404 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730180AbeIRW4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:56:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 10:22:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,390,1531810800"; 
   d="scan'208";a="71005837"
Received: from dkiernan-mobl3.ger.corp.intel.com (HELO eengestr-dev.ger.corp.intel.com) ([10.252.16.103])
  by fmsmga007.fm.intel.com with ESMTP; 18 Sep 2018 10:22:46 -0700
From:   Eric Engestrom <eric.engestrom@intel.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] i915: rename modifiers to follow the naming convention
Date:   Tue, 18 Sep 2018 18:22:00 +0100
Message-Id: <20180918172217.18754-2-eric.engestrom@intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180918172217.18754-1-eric.engestrom@intel.com>
References: <20180918172217.18754-1-eric.engestrom@intel.com>
MIME-Version: 1.0
Organization: Intel Corp UK
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$ sed -i s/I915_FORMAT_MOD_/DRM_FORMAT_MOD_INTEL_/g $(git grep -l I915_FORMAT_MOD_)
$ git checkout include/uapi/drm/drm_fourcc.h

Signed-off-by: Eric Engestrom <eric.engestrom@intel.com>
---
 drivers/gpu/drm/i915/intel_atomic_plane.c |  12 +-
 drivers/gpu/drm/i915/intel_display.c      | 128 +++++++++++-----------
 drivers/gpu/drm/i915/intel_pm.c           |  26 ++---
 drivers/gpu/drm/i915/intel_sprite.c       |  58 +++++-----
 4 files changed, 112 insertions(+), 112 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_atomic_plane.c b/drivers/gpu/drm/i915/intel_atomic_plane.c
index fa7df5fe154bf06bdfc5..c26f0b25afa2dc8c3a3c 100644
--- a/drivers/gpu/drm/i915/intel_atomic_plane.c
+++ b/drivers/gpu/drm/i915/intel_atomic_plane.c
@@ -126,8 +126,8 @@ int intel_plane_atomic_check_with_state(const struct intel_crtc_state *old_crtc_
 	if (state->fb && drm_rotation_90_or_270(state->rotation)) {
 		struct drm_format_name_buf format_name;
 
-		if (state->fb->modifier != I915_FORMAT_MOD_Y_TILED &&
-		    state->fb->modifier != I915_FORMAT_MOD_Yf_TILED) {
+		if (state->fb->modifier != DRM_FORMAT_MOD_INTEL_Y_TILED &&
+		    state->fb->modifier != DRM_FORMAT_MOD_INTEL_Yf_TILED) {
 			DRM_DEBUG_KMS("Y/Yf tiling required for 90/270!\n");
 			return -EINVAL;
 		}
@@ -169,10 +169,10 @@ int intel_plane_atomic_check_with_state(const struct intel_crtc_state *old_crtc_
 	 */
 	if (state->fb && INTEL_GEN(dev_priv) >= 9 && crtc_state->base.enable &&
 	    adjusted_mode->flags & DRM_MODE_FLAG_INTERLACE) {
-		if (state->fb->modifier == I915_FORMAT_MOD_Y_TILED ||
-		    state->fb->modifier == I915_FORMAT_MOD_Yf_TILED ||
-		    state->fb->modifier == I915_FORMAT_MOD_Y_TILED_CCS ||
-		    state->fb->modifier == I915_FORMAT_MOD_Yf_TILED_CCS) {
+		if (state->fb->modifier == DRM_FORMAT_MOD_INTEL_Y_TILED ||
+		    state->fb->modifier == DRM_FORMAT_MOD_INTEL_Yf_TILED ||
+		    state->fb->modifier == DRM_FORMAT_MOD_INTEL_Y_TILED_CCS ||
+		    state->fb->modifier == DRM_FORMAT_MOD_INTEL_Yf_TILED_CCS) {
 			DRM_DEBUG_KMS("Y/Yf tiling not supported in IF-ID mode\n");
 			return -EINVAL;
 		}
diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index b2bab57cd113f2293850..087302d655f9a146846a 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -69,7 +69,7 @@ static const uint32_t i965_primary_formats[] = {
 };
 
 static const uint64_t i9xx_format_modifiers[] = {
-	I915_FORMAT_MOD_X_TILED,
+	DRM_FORMAT_MOD_INTEL_X_TILED,
 	DRM_FORMAT_MOD_LINEAR,
 	DRM_FORMAT_MOD_INVALID
 };
@@ -106,19 +106,19 @@ static const uint32_t skl_pri_planar_formats[] = {
 };
 
 static const uint64_t skl_format_modifiers_noccs[] = {
-	I915_FORMAT_MOD_Yf_TILED,
-	I915_FORMAT_MOD_Y_TILED,
-	I915_FORMAT_MOD_X_TILED,
+	DRM_FORMAT_MOD_INTEL_Yf_TILED,
+	DRM_FORMAT_MOD_INTEL_Y_TILED,
+	DRM_FORMAT_MOD_INTEL_X_TILED,
 	DRM_FORMAT_MOD_LINEAR,
 	DRM_FORMAT_MOD_INVALID
 };
 
 static const uint64_t skl_format_modifiers_ccs[] = {
-	I915_FORMAT_MOD_Yf_TILED_CCS,
-	I915_FORMAT_MOD_Y_TILED_CCS,
-	I915_FORMAT_MOD_Yf_TILED,
-	I915_FORMAT_MOD_Y_TILED,
-	I915_FORMAT_MOD_X_TILED,
+	DRM_FORMAT_MOD_INTEL_Yf_TILED_CCS,
+	DRM_FORMAT_MOD_INTEL_Y_TILED_CCS,
+	DRM_FORMAT_MOD_INTEL_Yf_TILED,
+	DRM_FORMAT_MOD_INTEL_Y_TILED,
+	DRM_FORMAT_MOD_INTEL_X_TILED,
 	DRM_FORMAT_MOD_LINEAR,
 	DRM_FORMAT_MOD_INVALID
 };
@@ -1925,25 +1925,25 @@ intel_tile_width_bytes(const struct drm_framebuffer *fb, int plane)
 	switch (fb->modifier) {
 	case DRM_FORMAT_MOD_LINEAR:
 		return cpp;
-	case I915_FORMAT_MOD_X_TILED:
+	case DRM_FORMAT_MOD_INTEL_X_TILED:
 		if (IS_GEN2(dev_priv))
 			return 128;
 		else
 			return 512;
-	case I915_FORMAT_MOD_Y_TILED_CCS:
+	case DRM_FORMAT_MOD_INTEL_Y_TILED_CCS:
 		if (plane == 1)
 			return 128;
 		/* fall through */
-	case I915_FORMAT_MOD_Y_TILED:
+	case DRM_FORMAT_MOD_INTEL_Y_TILED:
 		if (IS_GEN2(dev_priv) || HAS_128_BYTE_Y_TILING(dev_priv))
 			return 128;
 		else
 			return 512;
-	case I915_FORMAT_MOD_Yf_TILED_CCS:
+	case DRM_FORMAT_MOD_INTEL_Yf_TILED_CCS:
 		if (plane == 1)
 			return 128;
 		/* fall through */
-	case I915_FORMAT_MOD_Yf_TILED:
+	case DRM_FORMAT_MOD_INTEL_Yf_TILED:
 		switch (cpp) {
 		case 1:
 			return 64;
@@ -2055,14 +2055,14 @@ static unsigned int intel_surf_alignment(const struct drm_framebuffer *fb,
 	switch (fb->modifier) {
 	case DRM_FORMAT_MOD_LINEAR:
 		return intel_linear_alignment(dev_priv);
-	case I915_FORMAT_MOD_X_TILED:
+	case DRM_FORMAT_MOD_INTEL_X_TILED:
 		if (INTEL_GEN(dev_priv) >= 9)
 			return 256 * 1024;
 		return 0;
-	case I915_FORMAT_MOD_Y_TILED_CCS:
-	case I915_FORMAT_MOD_Yf_TILED_CCS:
-	case I915_FORMAT_MOD_Y_TILED:
-	case I915_FORMAT_MOD_Yf_TILED:
+	case DRM_FORMAT_MOD_INTEL_Y_TILED_CCS:
+	case DRM_FORMAT_MOD_INTEL_Yf_TILED_CCS:
+	case DRM_FORMAT_MOD_INTEL_Y_TILED:
+	case DRM_FORMAT_MOD_INTEL_Yf_TILED:
 		return 1 * 1024 * 1024;
 	default:
 		MISSING_CASE(fb->modifier);
@@ -2416,10 +2416,10 @@ static int intel_fb_offset_to_xy(int *x, int *y,
 static unsigned int intel_fb_modifier_to_tiling(uint64_t fb_modifier)
 {
 	switch (fb_modifier) {
-	case I915_FORMAT_MOD_X_TILED:
+	case DRM_FORMAT_MOD_INTEL_X_TILED:
 		return I915_TILING_X;
-	case I915_FORMAT_MOD_Y_TILED:
-	case I915_FORMAT_MOD_Y_TILED_CCS:
+	case DRM_FORMAT_MOD_INTEL_Y_TILED:
+	case DRM_FORMAT_MOD_INTEL_Y_TILED_CCS:
 		return I915_TILING_Y;
 	default:
 		return I915_TILING_NONE;
@@ -2465,8 +2465,8 @@ static const struct drm_format_info *
 intel_get_format_info(const struct drm_mode_fb_cmd2 *cmd)
 {
 	switch (cmd->modifier[0]) {
-	case I915_FORMAT_MOD_Y_TILED_CCS:
-	case I915_FORMAT_MOD_Yf_TILED_CCS:
+	case DRM_FORMAT_MOD_INTEL_Y_TILED_CCS:
+	case DRM_FORMAT_MOD_INTEL_Yf_TILED_CCS:
 		return lookup_format_info(ccs_formats,
 					  ARRAY_SIZE(ccs_formats),
 					  cmd->pixel_format);
@@ -2477,8 +2477,8 @@ intel_get_format_info(const struct drm_mode_fb_cmd2 *cmd)
 
 bool is_ccs_modifier(u64 modifier)
 {
-	return modifier == I915_FORMAT_MOD_Y_TILED_CCS ||
-	       modifier == I915_FORMAT_MOD_Yf_TILED_CCS;
+	return modifier == DRM_FORMAT_MOD_INTEL_Y_TILED_CCS ||
+	       modifier == DRM_FORMAT_MOD_INTEL_Yf_TILED_CCS;
 }
 
 static int
@@ -2906,7 +2906,7 @@ static int skl_max_plane_width(const struct drm_framebuffer *fb, int plane,
 
 	switch (fb->modifier) {
 	case DRM_FORMAT_MOD_LINEAR:
-	case I915_FORMAT_MOD_X_TILED:
+	case DRM_FORMAT_MOD_INTEL_X_TILED:
 		switch (cpp) {
 		case 8:
 			return 4096;
@@ -2919,11 +2919,11 @@ static int skl_max_plane_width(const struct drm_framebuffer *fb, int plane,
 			break;
 		}
 		break;
-	case I915_FORMAT_MOD_Y_TILED_CCS:
-	case I915_FORMAT_MOD_Yf_TILED_CCS:
+	case DRM_FORMAT_MOD_INTEL_Y_TILED_CCS:
+	case DRM_FORMAT_MOD_INTEL_Yf_TILED_CCS:
 		/* FIXME AUX plane? */
-	case I915_FORMAT_MOD_Y_TILED:
-	case I915_FORMAT_MOD_Yf_TILED:
+	case DRM_FORMAT_MOD_INTEL_Y_TILED:
+	case DRM_FORMAT_MOD_INTEL_Yf_TILED:
 		switch (cpp) {
 		case 8:
 			return 2048;
@@ -3043,7 +3043,7 @@ static int skl_check_main_surface(const struct intel_crtc_state *crtc_state,
 	 *
 	 * TODO: linear and Y-tiled seem fine, Yf untested,
 	 */
-	if (fb->modifier == I915_FORMAT_MOD_X_TILED) {
+	if (fb->modifier == DRM_FORMAT_MOD_INTEL_X_TILED) {
 		int cpp = fb->format->cpp[0];
 
 		while ((x + w) * cpp > fb->pitches[0]) {
@@ -3262,7 +3262,7 @@ static u32 i9xx_plane_ctl(const struct intel_crtc_state *crtc_state,
 	}
 
 	if (INTEL_GEN(dev_priv) >= 4 &&
-	    fb->modifier == I915_FORMAT_MOD_X_TILED)
+	    fb->modifier == DRM_FORMAT_MOD_INTEL_X_TILED)
 		dspcntr |= DISPPLANE_TILED;
 
 	if (rotation & DRM_MODE_ROTATE_180)
@@ -3551,15 +3551,15 @@ static u32 skl_plane_ctl_tiling(uint64_t fb_modifier)
 	switch (fb_modifier) {
 	case DRM_FORMAT_MOD_LINEAR:
 		break;
-	case I915_FORMAT_MOD_X_TILED:
+	case DRM_FORMAT_MOD_INTEL_X_TILED:
 		return PLANE_CTL_TILED_X;
-	case I915_FORMAT_MOD_Y_TILED:
+	case DRM_FORMAT_MOD_INTEL_Y_TILED:
 		return PLANE_CTL_TILED_Y;
-	case I915_FORMAT_MOD_Y_TILED_CCS:
+	case DRM_FORMAT_MOD_INTEL_Y_TILED_CCS:
 		return PLANE_CTL_TILED_Y | PLANE_CTL_RENDER_DECOMPRESSION_ENABLE;
-	case I915_FORMAT_MOD_Yf_TILED:
+	case DRM_FORMAT_MOD_INTEL_Yf_TILED:
 		return PLANE_CTL_TILED_YF;
-	case I915_FORMAT_MOD_Yf_TILED_CCS:
+	case DRM_FORMAT_MOD_INTEL_Yf_TILED_CCS:
 		return PLANE_CTL_TILED_YF | PLANE_CTL_RENDER_DECOMPRESSION_ENABLE;
 	default:
 		MISSING_CASE(fb_modifier);
@@ -7752,7 +7752,7 @@ i9xx_get_initial_plane_config(struct intel_crtc *crtc,
 	if (INTEL_GEN(dev_priv) >= 4) {
 		if (val & DISPPLANE_TILED) {
 			plane_config->tiling = I915_TILING_X;
-			fb->modifier = I915_FORMAT_MOD_X_TILED;
+			fb->modifier = DRM_FORMAT_MOD_INTEL_X_TILED;
 		}
 	}
 
@@ -8804,19 +8804,19 @@ skylake_get_initial_plane_config(struct intel_crtc *crtc,
 		break;
 	case PLANE_CTL_TILED_X:
 		plane_config->tiling = I915_TILING_X;
-		fb->modifier = I915_FORMAT_MOD_X_TILED;
+		fb->modifier = DRM_FORMAT_MOD_INTEL_X_TILED;
 		break;
 	case PLANE_CTL_TILED_Y:
 		if (val & PLANE_CTL_RENDER_DECOMPRESSION_ENABLE)
-			fb->modifier = I915_FORMAT_MOD_Y_TILED_CCS;
+			fb->modifier = DRM_FORMAT_MOD_INTEL_Y_TILED_CCS;
 		else
-			fb->modifier = I915_FORMAT_MOD_Y_TILED;
+			fb->modifier = DRM_FORMAT_MOD_INTEL_Y_TILED;
 		break;
 	case PLANE_CTL_TILED_YF:
 		if (val & PLANE_CTL_RENDER_DECOMPRESSION_ENABLE)
-			fb->modifier = I915_FORMAT_MOD_Yf_TILED_CCS;
+			fb->modifier = DRM_FORMAT_MOD_INTEL_Yf_TILED_CCS;
 		else
-			fb->modifier = I915_FORMAT_MOD_Yf_TILED;
+			fb->modifier = DRM_FORMAT_MOD_INTEL_Yf_TILED;
 		break;
 	default:
 		MISSING_CASE(tiling);
@@ -13342,7 +13342,7 @@ static bool i8xx_plane_format_mod_supported(struct drm_plane *_plane,
 {
 	switch (modifier) {
 	case DRM_FORMAT_MOD_LINEAR:
-	case I915_FORMAT_MOD_X_TILED:
+	case DRM_FORMAT_MOD_INTEL_X_TILED:
 		break;
 	default:
 		return false;
@@ -13354,7 +13354,7 @@ static bool i8xx_plane_format_mod_supported(struct drm_plane *_plane,
 	case DRM_FORMAT_XRGB1555:
 	case DRM_FORMAT_XRGB8888:
 		return modifier == DRM_FORMAT_MOD_LINEAR ||
-			modifier == I915_FORMAT_MOD_X_TILED;
+			modifier == DRM_FORMAT_MOD_INTEL_X_TILED;
 	default:
 		return false;
 	}
@@ -13365,7 +13365,7 @@ static bool i965_plane_format_mod_supported(struct drm_plane *_plane,
 {
 	switch (modifier) {
 	case DRM_FORMAT_MOD_LINEAR:
-	case I915_FORMAT_MOD_X_TILED:
+	case DRM_FORMAT_MOD_INTEL_X_TILED:
 		break;
 	default:
 		return false;
@@ -13379,7 +13379,7 @@ static bool i965_plane_format_mod_supported(struct drm_plane *_plane,
 	case DRM_FORMAT_XRGB2101010:
 	case DRM_FORMAT_XBGR2101010:
 		return modifier == DRM_FORMAT_MOD_LINEAR ||
-			modifier == I915_FORMAT_MOD_X_TILED;
+			modifier == DRM_FORMAT_MOD_INTEL_X_TILED;
 	default:
 		return false;
 	}
@@ -13392,12 +13392,12 @@ static bool skl_plane_format_mod_supported(struct drm_plane *_plane,
 
 	switch (modifier) {
 	case DRM_FORMAT_MOD_LINEAR:
-	case I915_FORMAT_MOD_X_TILED:
-	case I915_FORMAT_MOD_Y_TILED:
-	case I915_FORMAT_MOD_Yf_TILED:
+	case DRM_FORMAT_MOD_INTEL_X_TILED:
+	case DRM_FORMAT_MOD_INTEL_Y_TILED:
+	case DRM_FORMAT_MOD_INTEL_Yf_TILED:
 		break;
-	case I915_FORMAT_MOD_Y_TILED_CCS:
-	case I915_FORMAT_MOD_Yf_TILED_CCS:
+	case DRM_FORMAT_MOD_INTEL_Y_TILED_CCS:
+	case DRM_FORMAT_MOD_INTEL_Yf_TILED_CCS:
 		if (!plane->has_ccs)
 			return false;
 		break;
@@ -13421,13 +13421,13 @@ static bool skl_plane_format_mod_supported(struct drm_plane *_plane,
 	case DRM_FORMAT_UYVY:
 	case DRM_FORMAT_VYUY:
 	case DRM_FORMAT_NV12:
-		if (modifier == I915_FORMAT_MOD_Yf_TILED)
+		if (modifier == DRM_FORMAT_MOD_INTEL_Yf_TILED)
 			return true;
 		/* fall through */
 	case DRM_FORMAT_C8:
 		if (modifier == DRM_FORMAT_MOD_LINEAR ||
-		    modifier == I915_FORMAT_MOD_X_TILED ||
-		    modifier == I915_FORMAT_MOD_Y_TILED)
+		    modifier == DRM_FORMAT_MOD_INTEL_X_TILED ||
+		    modifier == DRM_FORMAT_MOD_INTEL_Y_TILED)
 			return true;
 		/* fall through */
 	default:
@@ -14394,12 +14394,12 @@ u32 intel_fb_pitch_limit(struct drm_i915_private *dev_priv,
 	} else if (gen >= 5 && !HAS_GMCH_DISPLAY(dev_priv)) {
 		return 32*1024;
 	} else if (gen >= 4) {
-		if (fb_modifier == I915_FORMAT_MOD_X_TILED)
+		if (fb_modifier == DRM_FORMAT_MOD_INTEL_X_TILED)
 			return 16*1024;
 		else
 			return 32*1024;
 	} else if (gen >= 3) {
-		if (fb_modifier == I915_FORMAT_MOD_X_TILED)
+		if (fb_modifier == DRM_FORMAT_MOD_INTEL_X_TILED)
 			return 8*1024;
 		else
 			return 16*1024;
@@ -14439,7 +14439,7 @@ static int intel_framebuffer_init(struct intel_framebuffer *intel_fb,
 		}
 	} else {
 		if (tiling == I915_TILING_X) {
-			mode_cmd->modifier[0] = I915_FORMAT_MOD_X_TILED;
+			mode_cmd->modifier[0] = DRM_FORMAT_MOD_INTEL_X_TILED;
 		} else if (tiling == I915_TILING_Y) {
 			DRM_DEBUG_KMS("No Y tiling for legacy addfb\n");
 			goto err;
@@ -14448,8 +14448,8 @@ static int intel_framebuffer_init(struct intel_framebuffer *intel_fb,
 
 	/* Passed in modifier sanity checking. */
 	switch (mode_cmd->modifier[0]) {
-	case I915_FORMAT_MOD_Y_TILED_CCS:
-	case I915_FORMAT_MOD_Yf_TILED_CCS:
+	case DRM_FORMAT_MOD_INTEL_Y_TILED_CCS:
+	case DRM_FORMAT_MOD_INTEL_Yf_TILED_CCS:
 		switch (mode_cmd->pixel_format) {
 		case DRM_FORMAT_XBGR8888:
 		case DRM_FORMAT_ABGR8888:
@@ -14461,15 +14461,15 @@ static int intel_framebuffer_init(struct intel_framebuffer *intel_fb,
 			goto err;
 		}
 		/* fall through */
-	case I915_FORMAT_MOD_Y_TILED:
-	case I915_FORMAT_MOD_Yf_TILED:
+	case DRM_FORMAT_MOD_INTEL_Y_TILED:
+	case DRM_FORMAT_MOD_INTEL_Yf_TILED:
 		if (INTEL_GEN(dev_priv) < 9) {
 			DRM_DEBUG_KMS("Unsupported tiling 0x%llx!\n",
 				      mode_cmd->modifier[0]);
 			goto err;
 		}
 	case DRM_FORMAT_MOD_LINEAR:
-	case I915_FORMAT_MOD_X_TILED:
+	case DRM_FORMAT_MOD_INTEL_X_TILED:
 		break;
 	default:
 		DRM_DEBUG_KMS("Unsupported fb modifier 0x%llx!\n",
diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
index d99e5fabe93c3a822361..c62a52b20e9bee09ecc0 100644
--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -3757,7 +3757,7 @@ bool intel_can_enable_sagv(struct drm_atomic_state *state)
 
 		if (skl_needs_memory_bw_wa(intel_state) &&
 		    plane->base.state->fb->modifier ==
-		    I915_FORMAT_MOD_X_TILED)
+		    DRM_FORMAT_MOD_INTEL_X_TILED)
 			latency += 15;
 
 		/*
@@ -4233,10 +4233,10 @@ skl_ddb_min_alloc(const struct drm_plane_state *pstate, const int plane)
 		return 0;
 
 	/* For Non Y-tile return 8-blocks */
-	if (fb->modifier != I915_FORMAT_MOD_Y_TILED &&
-	    fb->modifier != I915_FORMAT_MOD_Yf_TILED &&
-	    fb->modifier != I915_FORMAT_MOD_Y_TILED_CCS &&
-	    fb->modifier != I915_FORMAT_MOD_Yf_TILED_CCS)
+	if (fb->modifier != DRM_FORMAT_MOD_INTEL_Y_TILED &&
+	    fb->modifier != DRM_FORMAT_MOD_INTEL_Yf_TILED &&
+	    fb->modifier != DRM_FORMAT_MOD_INTEL_Y_TILED_CCS &&
+	    fb->modifier != DRM_FORMAT_MOD_INTEL_Yf_TILED_CCS)
 		return 8;
 
 	/*
@@ -4531,13 +4531,13 @@ skl_compute_plane_wm_params(const struct drm_i915_private *dev_priv,
 		return -EINVAL;
 	}
 
-	wp->y_tiled = fb->modifier == I915_FORMAT_MOD_Y_TILED ||
-		      fb->modifier == I915_FORMAT_MOD_Yf_TILED ||
-		      fb->modifier == I915_FORMAT_MOD_Y_TILED_CCS ||
-		      fb->modifier == I915_FORMAT_MOD_Yf_TILED_CCS;
-	wp->x_tiled = fb->modifier == I915_FORMAT_MOD_X_TILED;
-	wp->rc_surface = fb->modifier == I915_FORMAT_MOD_Y_TILED_CCS ||
-			 fb->modifier == I915_FORMAT_MOD_Yf_TILED_CCS;
+	wp->y_tiled = fb->modifier == DRM_FORMAT_MOD_INTEL_Y_TILED ||
+		      fb->modifier == DRM_FORMAT_MOD_INTEL_Yf_TILED ||
+		      fb->modifier == DRM_FORMAT_MOD_INTEL_Y_TILED_CCS ||
+		      fb->modifier == DRM_FORMAT_MOD_INTEL_Yf_TILED_CCS;
+	wp->x_tiled = fb->modifier == DRM_FORMAT_MOD_INTEL_X_TILED;
+	wp->rc_surface = fb->modifier == DRM_FORMAT_MOD_INTEL_Y_TILED_CCS ||
+			 fb->modifier == DRM_FORMAT_MOD_INTEL_Yf_TILED_CCS;
 	wp->is_planar = fb->format->format == DRM_FORMAT_NV12;
 
 	if (plane->id == PLANE_CURSOR) {
@@ -4559,7 +4559,7 @@ skl_compute_plane_wm_params(const struct drm_i915_private *dev_priv,
 							     intel_pstate);
 
 	if (INTEL_GEN(dev_priv) >= 11 &&
-	    fb->modifier == I915_FORMAT_MOD_Yf_TILED && wp->cpp == 8)
+	    fb->modifier == DRM_FORMAT_MOD_INTEL_Yf_TILED && wp->cpp == 8)
 		wp->dbuf_block_size = 256;
 	else
 		wp->dbuf_block_size = 512;
diff --git a/drivers/gpu/drm/i915/intel_sprite.c b/drivers/gpu/drm/i915/intel_sprite.c
index 9600ccfc5b7699ff54b1..9546199e17032539e7b9 100644
--- a/drivers/gpu/drm/i915/intel_sprite.c
+++ b/drivers/gpu/drm/i915/intel_sprite.c
@@ -520,7 +520,7 @@ static u32 vlv_sprite_ctl(const struct intel_crtc_state *crtc_state,
 	if (plane_state->base.color_encoding == DRM_COLOR_YCBCR_BT709)
 		sprctl |= SP_YUV_FORMAT_BT709;
 
-	if (fb->modifier == I915_FORMAT_MOD_X_TILED)
+	if (fb->modifier == DRM_FORMAT_MOD_INTEL_X_TILED)
 		sprctl |= SP_TILED;
 
 	if (rotation & DRM_MODE_ROTATE_180)
@@ -577,7 +577,7 @@ vlv_update_plane(struct intel_plane *plane,
 	I915_WRITE_FW(SPSTRIDE(pipe, plane_id), fb->pitches[0]);
 	I915_WRITE_FW(SPPOS(pipe, plane_id), (crtc_y << 16) | crtc_x);
 
-	if (fb->modifier == I915_FORMAT_MOD_X_TILED)
+	if (fb->modifier == DRM_FORMAT_MOD_INTEL_X_TILED)
 		I915_WRITE_FW(SPTILEOFF(pipe, plane_id), (y << 16) | x);
 	else
 		I915_WRITE_FW(SPLINOFF(pipe, plane_id), linear_offset);
@@ -681,7 +681,7 @@ static u32 ivb_sprite_ctl(const struct intel_crtc_state *crtc_state,
 	if (plane_state->base.color_range == DRM_COLOR_YCBCR_FULL_RANGE)
 		sprctl |= SPRITE_YUV_RANGE_CORRECTION_DISABLE;
 
-	if (fb->modifier == I915_FORMAT_MOD_X_TILED)
+	if (fb->modifier == DRM_FORMAT_MOD_INTEL_X_TILED)
 		sprctl |= SPRITE_TILED;
 
 	if (rotation & DRM_MODE_ROTATE_180)
@@ -743,7 +743,7 @@ ivb_update_plane(struct intel_plane *plane,
 	 * register */
 	if (IS_HASWELL(dev_priv) || IS_BROADWELL(dev_priv))
 		I915_WRITE_FW(SPROFFSET(pipe), (y << 16) | x);
-	else if (fb->modifier == I915_FORMAT_MOD_X_TILED)
+	else if (fb->modifier == DRM_FORMAT_MOD_INTEL_X_TILED)
 		I915_WRITE_FW(SPRTILEOFF(pipe), (y << 16) | x);
 	else
 		I915_WRITE_FW(SPRLINOFF(pipe), linear_offset);
@@ -845,7 +845,7 @@ static u32 g4x_sprite_ctl(const struct intel_crtc_state *crtc_state,
 	if (plane_state->base.color_range == DRM_COLOR_YCBCR_FULL_RANGE)
 		dvscntr |= DVS_YUV_RANGE_CORRECTION_DISABLE;
 
-	if (fb->modifier == I915_FORMAT_MOD_X_TILED)
+	if (fb->modifier == DRM_FORMAT_MOD_INTEL_X_TILED)
 		dvscntr |= DVS_TILED;
 
 	if (rotation & DRM_MODE_ROTATE_180)
@@ -903,7 +903,7 @@ g4x_update_plane(struct intel_plane *plane,
 	I915_WRITE_FW(DVSSTRIDE(pipe), fb->pitches[0]);
 	I915_WRITE_FW(DVSPOS(pipe), (crtc_y << 16) | crtc_x);
 
-	if (fb->modifier == I915_FORMAT_MOD_X_TILED)
+	if (fb->modifier == DRM_FORMAT_MOD_INTEL_X_TILED)
 		I915_WRITE_FW(DVSTILEOFF(pipe), (y << 16) | x);
 	else
 		I915_WRITE_FW(DVSLINOFF(pipe), linear_offset);
@@ -1228,7 +1228,7 @@ static const uint32_t g4x_plane_formats[] = {
 };
 
 static const uint64_t i9xx_plane_format_modifiers[] = {
-	I915_FORMAT_MOD_X_TILED,
+	DRM_FORMAT_MOD_INTEL_X_TILED,
 	DRM_FORMAT_MOD_LINEAR,
 	DRM_FORMAT_MOD_INVALID
 };
@@ -1282,19 +1282,19 @@ static uint32_t skl_planar_formats[] = {
 };
 
 static const uint64_t skl_plane_format_modifiers_noccs[] = {
-	I915_FORMAT_MOD_Yf_TILED,
-	I915_FORMAT_MOD_Y_TILED,
-	I915_FORMAT_MOD_X_TILED,
+	DRM_FORMAT_MOD_INTEL_Yf_TILED,
+	DRM_FORMAT_MOD_INTEL_Y_TILED,
+	DRM_FORMAT_MOD_INTEL_X_TILED,
 	DRM_FORMAT_MOD_LINEAR,
 	DRM_FORMAT_MOD_INVALID
 };
 
 static const uint64_t skl_plane_format_modifiers_ccs[] = {
-	I915_FORMAT_MOD_Yf_TILED_CCS,
-	I915_FORMAT_MOD_Y_TILED_CCS,
-	I915_FORMAT_MOD_Yf_TILED,
-	I915_FORMAT_MOD_Y_TILED,
-	I915_FORMAT_MOD_X_TILED,
+	DRM_FORMAT_MOD_INTEL_Yf_TILED_CCS,
+	DRM_FORMAT_MOD_INTEL_Y_TILED_CCS,
+	DRM_FORMAT_MOD_INTEL_Yf_TILED,
+	DRM_FORMAT_MOD_INTEL_Y_TILED,
+	DRM_FORMAT_MOD_INTEL_X_TILED,
 	DRM_FORMAT_MOD_LINEAR,
 	DRM_FORMAT_MOD_INVALID
 };
@@ -1304,7 +1304,7 @@ static bool g4x_sprite_format_mod_supported(struct drm_plane *_plane,
 {
 	switch (modifier) {
 	case DRM_FORMAT_MOD_LINEAR:
-	case I915_FORMAT_MOD_X_TILED:
+	case DRM_FORMAT_MOD_INTEL_X_TILED:
 		break;
 	default:
 		return false;
@@ -1317,7 +1317,7 @@ static bool g4x_sprite_format_mod_supported(struct drm_plane *_plane,
 	case DRM_FORMAT_UYVY:
 	case DRM_FORMAT_VYUY:
 		if (modifier == DRM_FORMAT_MOD_LINEAR ||
-		    modifier == I915_FORMAT_MOD_X_TILED)
+		    modifier == DRM_FORMAT_MOD_INTEL_X_TILED)
 			return true;
 		/* fall through */
 	default:
@@ -1330,7 +1330,7 @@ static bool snb_sprite_format_mod_supported(struct drm_plane *_plane,
 {
 	switch (modifier) {
 	case DRM_FORMAT_MOD_LINEAR:
-	case I915_FORMAT_MOD_X_TILED:
+	case DRM_FORMAT_MOD_INTEL_X_TILED:
 		break;
 	default:
 		return false;
@@ -1344,7 +1344,7 @@ static bool snb_sprite_format_mod_supported(struct drm_plane *_plane,
 	case DRM_FORMAT_UYVY:
 	case DRM_FORMAT_VYUY:
 		if (modifier == DRM_FORMAT_MOD_LINEAR ||
-		    modifier == I915_FORMAT_MOD_X_TILED)
+		    modifier == DRM_FORMAT_MOD_INTEL_X_TILED)
 			return true;
 		/* fall through */
 	default:
@@ -1357,7 +1357,7 @@ static bool vlv_sprite_format_mod_supported(struct drm_plane *_plane,
 {
 	switch (modifier) {
 	case DRM_FORMAT_MOD_LINEAR:
-	case I915_FORMAT_MOD_X_TILED:
+	case DRM_FORMAT_MOD_INTEL_X_TILED:
 		break;
 	default:
 		return false;
@@ -1376,7 +1376,7 @@ static bool vlv_sprite_format_mod_supported(struct drm_plane *_plane,
 	case DRM_FORMAT_UYVY:
 	case DRM_FORMAT_VYUY:
 		if (modifier == DRM_FORMAT_MOD_LINEAR ||
-		    modifier == I915_FORMAT_MOD_X_TILED)
+		    modifier == DRM_FORMAT_MOD_INTEL_X_TILED)
 			return true;
 		/* fall through */
 	default:
@@ -1391,12 +1391,12 @@ static bool skl_plane_format_mod_supported(struct drm_plane *_plane,
 
 	switch (modifier) {
 	case DRM_FORMAT_MOD_LINEAR:
-	case I915_FORMAT_MOD_X_TILED:
-	case I915_FORMAT_MOD_Y_TILED:
-	case I915_FORMAT_MOD_Yf_TILED:
+	case DRM_FORMAT_MOD_INTEL_X_TILED:
+	case DRM_FORMAT_MOD_INTEL_Y_TILED:
+	case DRM_FORMAT_MOD_INTEL_Yf_TILED:
 		break;
-	case I915_FORMAT_MOD_Y_TILED_CCS:
-	case I915_FORMAT_MOD_Yf_TILED_CCS:
+	case DRM_FORMAT_MOD_INTEL_Y_TILED_CCS:
+	case DRM_FORMAT_MOD_INTEL_Yf_TILED_CCS:
 		if (!plane->has_ccs)
 			return false;
 		break;
@@ -1420,13 +1420,13 @@ static bool skl_plane_format_mod_supported(struct drm_plane *_plane,
 	case DRM_FORMAT_UYVY:
 	case DRM_FORMAT_VYUY:
 	case DRM_FORMAT_NV12:
-		if (modifier == I915_FORMAT_MOD_Yf_TILED)
+		if (modifier == DRM_FORMAT_MOD_INTEL_Yf_TILED)
 			return true;
 		/* fall through */
 	case DRM_FORMAT_C8:
 		if (modifier == DRM_FORMAT_MOD_LINEAR ||
-		    modifier == I915_FORMAT_MOD_X_TILED ||
-		    modifier == I915_FORMAT_MOD_Y_TILED)
+		    modifier == DRM_FORMAT_MOD_INTEL_X_TILED ||
+		    modifier == DRM_FORMAT_MOD_INTEL_Y_TILED)
 			return true;
 		/* fall through */
 	default:
-- 
Cheers,
  Eric

