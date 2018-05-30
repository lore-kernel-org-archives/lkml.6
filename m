Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbeE3Nej (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 09:34:39 -0400
Received: from foss.arm.com ([217.140.101.70]:56330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751559AbeE3Nei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 09:34:38 -0400
Date: Wed, 30 May 2018 14:34:33 +0100
From: Brian Starkey <brian.starkey@arm.com>
To: Lowry Li <lowry.li@arm.com>
Cc: liviu.dudau@arm.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, daniel.vetter@intel.com,
        jani.nikula@linux.intel.com, seanpaul@chromium.org, airlied@linux.ie,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, malidp@foss.arm.com, nd@arm.com
Subject: Re: [PATCH v2 2/2] drm/mali-dp: Implement plane alpha and pixel
 blend on malidp
Message-ID: <20180530133433.GB27705@e107564-lin.cambridge.arm.com>
References: <1527679434-13228-1-git-send-email-lowry.li@arm.com>
 <1527679434-13228-3-git-send-email-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1527679434-13228-3-git-send-email-lowry.li@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lowry,

On Wed, May 30, 2018 at 07:23:54PM +0800, Lowry Li wrote:
>Check the pixel blending mode and plane alpha value when
>do the plane_check. Mali DP supports blending the current plane
>with the background either based on the pixel alpha blending
>mode or by using the layer's alpha value, but not both at the
>same time. If both case, plane_check will return failed.
>
>Set the HW when doing plane_update accordingly. If plane alpha
>is the 0xffff, set the PREM bit accordingly. If not we'd set
>ALPHA bit as zero and layer alpha value.

The code looks correct - but the description of the PREM bit seems
wrong here. Did you mean "set the pixel blending bits accordingly"?

With that fixed:

Reviewed-by: Brian Starkey <brian.starkey@arm.com>

>
>Signed-off-by: Lowry Li <lowry.li@arm.com>
>---
> drivers/gpu/drm/arm/malidp_planes.c | 76 +++++++++++++++++++++----------------
> 1 file changed, 44 insertions(+), 32 deletions(-)
>
>diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
>index 7a44897..daa3f4f 100644
>--- a/drivers/gpu/drm/arm/malidp_planes.c
>+++ b/drivers/gpu/drm/arm/malidp_planes.c
>@@ -35,6 +35,7 @@
> #define   LAYER_COMP_MASK		(0x3 << 12)
> #define   LAYER_COMP_PIXEL		(0x3 << 12)
> #define   LAYER_COMP_PLANE		(0x2 << 12)
>+#define   LAYER_PMUL_ENABLE		(0x1 << 14)
> #define   LAYER_ALPHA_OFFSET		(16)
> #define   LAYER_ALPHA_MASK		(0xff)
> #define   LAYER_ALPHA(x)		(((x) & LAYER_ALPHA_MASK) << LAYER_ALPHA_OFFSET)
>@@ -182,6 +183,7 @@ static int malidp_de_plane_check(struct drm_plane *plane,
> 	struct malidp_plane_state *ms = to_malidp_plane_state(state);
> 	bool rotated = state->rotation & MALIDP_ROTATED_MASK;
> 	struct drm_framebuffer *fb;
>+	u16 pixel_alpha = state->pixel_blend_mode;
> 	int i, ret;
>
> 	if (!state->crtc || !state->fb)
>@@ -244,6 +246,11 @@ static int malidp_de_plane_check(struct drm_plane *plane,
> 		ms->rotmem_size = val;
> 	}
>
>+	/* HW can't support plane + pixel blending */
>+	if ((state->alpha != DRM_BLEND_ALPHA_OPAQUE) &&
>+	    (pixel_alpha != DRM_MODE_BLEND_PIXEL_NONE))
>+		return -EINVAL;
>+
> 	return 0;
> }
>
>@@ -325,31 +332,33 @@ static void malidp_de_plane_update(struct drm_plane *plane,
> {
> 	struct malidp_plane *mp;
> 	struct malidp_plane_state *ms = to_malidp_plane_state(plane->state);
>+	struct drm_plane_state *state = plane->state;
>+	u16 pixel_alpha = state->pixel_blend_mode;
>+	u8 plane_alpha = state->alpha >> 8;
> 	u32 src_w, src_h, dest_w, dest_h, val;
> 	int i;
>-	bool format_has_alpha = plane->state->fb->format->has_alpha;
>
> 	mp = to_malidp_plane(plane);
>
> 	/* convert src values from Q16 fixed point to integer */
>-	src_w = plane->state->src_w >> 16;
>-	src_h = plane->state->src_h >> 16;
>-	dest_w = plane->state->crtc_w;
>-	dest_h = plane->state->crtc_h;
>+	src_w = state->src_w >> 16;
>+	src_h = state->src_h >> 16;
>+	dest_w = state->crtc_w;
>+	dest_h = state->crtc_h;
>
> 	malidp_hw_write(mp->hwdev, ms->format, mp->layer->base);
>
> 	for (i = 0; i < ms->n_planes; i++) {
> 		/* calculate the offset for the layer's plane registers */
> 		u16 ptr = mp->layer->ptr + (i << 4);
>-		dma_addr_t fb_addr = drm_fb_cma_get_gem_addr(plane->state->fb,
>-							     plane->state, i);
>+		dma_addr_t fb_addr = drm_fb_cma_get_gem_addr(state->fb,
>+							     state, i);
>
> 		malidp_hw_write(mp->hwdev, lower_32_bits(fb_addr), ptr);
> 		malidp_hw_write(mp->hwdev, upper_32_bits(fb_addr), ptr + 4);
> 	}
> 	malidp_de_set_plane_pitches(mp, ms->n_planes,
>-				    plane->state->fb->pitches);
>+				    state->fb->pitches);
>
> 	if ((plane->state->color_encoding != old_state->color_encoding) ||
> 	    (plane->state->color_range != old_state->color_range))
>@@ -362,8 +371,8 @@ static void malidp_de_plane_update(struct drm_plane *plane,
> 	malidp_hw_write(mp->hwdev, LAYER_H_VAL(dest_w) | LAYER_V_VAL(dest_h),
> 			mp->layer->base + MALIDP_LAYER_COMP_SIZE);
>
>-	malidp_hw_write(mp->hwdev, LAYER_H_VAL(plane->state->crtc_x) |
>-			LAYER_V_VAL(plane->state->crtc_y),
>+	malidp_hw_write(mp->hwdev, LAYER_H_VAL(state->crtc_x) |
>+			LAYER_V_VAL(state->crtc_y),
> 			mp->layer->base + MALIDP_LAYER_OFFSET);
>
> 	if (mp->layer->id == DE_SMART)
>@@ -376,38 +385,35 @@ static void malidp_de_plane_update(struct drm_plane *plane,
> 	val &= ~LAYER_ROT_MASK;
>
> 	/* setup the rotation and axis flip bits */
>-	if (plane->state->rotation & DRM_MODE_ROTATE_MASK)
>+	if (state->rotation & DRM_MODE_ROTATE_MASK)
> 		val |= ilog2(plane->state->rotation & DRM_MODE_ROTATE_MASK) <<
> 		       LAYER_ROT_OFFSET;
>-	if (plane->state->rotation & DRM_MODE_REFLECT_X)
>+	if (state->rotation & DRM_MODE_REFLECT_X)
> 		val |= LAYER_H_FLIP;
>-	if (plane->state->rotation & DRM_MODE_REFLECT_Y)
>+	if (state->rotation & DRM_MODE_REFLECT_Y)
> 		val |= LAYER_V_FLIP;
>
>-	val &= ~LAYER_COMP_MASK;
>-	if (format_has_alpha) {
>-
>-		/*
>-		 * always enable pixel alpha blending until we have a way
>-		 * to change blend modes
>-		 */
>-		val |= LAYER_COMP_PIXEL;
>-	} else {
>-
>-		/*
>-		 * do not enable pixel alpha blending as the color channel
>-		 * does not have any alpha information
>-		 */
>-		val |= LAYER_COMP_PLANE;
>-
>-		/* Set layer alpha coefficient to 0xff ie fully opaque */
>+	val &= ~(LAYER_COMP_MASK | LAYER_PMUL_ENABLE);
>+
>+	if (state->alpha != DRM_BLEND_ALPHA_OPAQUE) {
>+		val |= LAYER_COMP_PLANE | LAYER_ALPHA(plane_alpha);
>+	} else if (state->fb->format->has_alpha) {
>+		/* We only care about blend mode if the format has alpha */
>+		switch (pixel_alpha) {
>+		case DRM_MODE_BLEND_PREMULTI:
>+			val |= LAYER_COMP_PIXEL | LAYER_PMUL_ENABLE;
>+			break;
>+		case DRM_MODE_BLEND_COVERAGE:
>+			val |= LAYER_COMP_PIXEL;
>+			break;
>+		}
> 		val |= LAYER_ALPHA(0xff);
> 	}
>
> 	val &= ~LAYER_FLOWCFG(LAYER_FLOWCFG_MASK);
>-	if (plane->state->crtc) {
>+	if (state->crtc) {
> 		struct malidp_crtc_state *m =
>-			to_malidp_crtc_state(plane->state->crtc->state);
>+			to_malidp_crtc_state(state->crtc->state);
>
> 		if (m->scaler_config.scale_enable &&
> 		    m->scaler_config.plane_src_id == mp->layer->id)
>@@ -446,6 +452,9 @@ int malidp_de_planes_init(struct drm_device *drm)
> 	unsigned long crtcs = 1 << drm->mode_config.num_crtc;
> 	unsigned long flags = DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_180 |
> 			      DRM_MODE_ROTATE_270 | DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y;
>+	unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>+				  BIT(DRM_MODE_BLEND_PREMULTI)   |
>+				  BIT(DRM_MODE_BLEND_COVERAGE);
> 	u32 *formats;
> 	int ret, i, j, n;
>
>@@ -498,6 +507,9 @@ int malidp_de_planes_init(struct drm_device *drm)
> 		malidp_hw_write(malidp->dev, MALIDP_ALPHA_LUT,
> 				plane->layer->base + MALIDP_LAYER_COMPOSE);
>
>+		drm_plane_create_alpha_property(&plane->base);
>+		drm_plane_create_blend_mode_property(&plane->base, blend_caps);
>+
> 		/* Attach the YUV->RGB property only to video layers */
> 		if (id & (DE_VIDEO1 | DE_VIDEO2)) {
> 			/* default encoding for YUV->RGB is BT601 NARROW */
>-- 
>1.9.1
>
