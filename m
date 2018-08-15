Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA51C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551DD2156D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551DD2156D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbeHONE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 09:04:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53528 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbeHONEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 09:04:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A822F18A;
        Wed, 15 Aug 2018 03:13:22 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 550EF3F5BD;
        Wed, 15 Aug 2018 03:13:22 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id A7DD668058B; Wed, 15 Aug 2018 11:13:20 +0100 (BST)
Date:   Wed, 15 Aug 2018 11:13:20 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Lowry Li <lowry.li@arm.com>
Cc:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        daniel.vetter@intel.com, seanpaul@chromium.org, airlied@linux.ie,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, brian.starkey@arm.com,
        malidp@foss.arm.com, emil.l.velikov@gmail.com, nd@arm.com
Subject: Re: [PATCH v4 2/2] drm/mali-dp: Implement plane alpha and pixel
 blend on malidp
Message-ID: <20180815101320.GJ907@e110455-lin.cambridge.arm.com>
References: <1534314933-23182-1-git-send-email-lowry.li@arm.com>
 <1534314933-23182-3-git-send-email-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1534314933-23182-3-git-send-email-lowry.li@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 02:35:33PM +0800, Lowry Li wrote:
> Checks the pixel blending mode and plane alpha value when
> do the plane_check. Mali DP supports blending the current plane
> with the background either based on the pixel alpha blending
> mode or by using the layer's alpha value, but not both at the
> same time. If both case, plane_check will return failed.
> 
> Sets the HW when doing plane_update accordingly. If plane alpha
> is the 0xffff, set the pixel blending bits accordingly. If not
> we'd set ALPHA bit as zero and layer alpha value.
> 
> Changes since v1:
>  - Introduces to use it in the malidp driver, which depends on
>    the plane alpha patch
> Changes since v2:
>  - Refines the comments of drm/mali-dp patchset
> Changes since v3:
>  - Updates on drm/malidp, hardware limitation check only when
>    the format has alpha pixel.
> 
> Signed-off-by: Lowry Li <lowry.li@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks,
Liviu

> ---
>  drivers/gpu/drm/arm/malidp_planes.c | 74 +++++++++++++++++++++----------------
>  1 file changed, 43 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
> index 49c37f6..17be123 100644
> --- a/drivers/gpu/drm/arm/malidp_planes.c
> +++ b/drivers/gpu/drm/arm/malidp_planes.c
> @@ -36,6 +36,7 @@
>  #define   LAYER_COMP_MASK		(0x3 << 12)
>  #define   LAYER_COMP_PIXEL		(0x3 << 12)
>  #define   LAYER_COMP_PLANE		(0x2 << 12)
> +#define   LAYER_PMUL_ENABLE		(0x1 << 14)
>  #define   LAYER_ALPHA_OFFSET		(16)
>  #define   LAYER_ALPHA_MASK		(0xff)
>  #define   LAYER_ALPHA(x)		(((x) & LAYER_ALPHA_MASK) << LAYER_ALPHA_OFFSET)
> @@ -180,6 +181,7 @@ static int malidp_de_plane_check(struct drm_plane *plane,
>  	struct malidp_plane_state *ms = to_malidp_plane_state(state);
>  	bool rotated = state->rotation & MALIDP_ROTATED_MASK;
>  	struct drm_framebuffer *fb;
> +	u16 pixel_alpha = state->pixel_blend_mode;
>  	int i, ret;
>  
>  	if (!state->crtc || !state->fb)
> @@ -242,6 +244,11 @@ static int malidp_de_plane_check(struct drm_plane *plane,
>  		ms->rotmem_size = val;
>  	}
>  
> +	/* HW can't support plane + pixel blending */
> +	if ((state->alpha != DRM_BLEND_ALPHA_OPAQUE) &&
> +	    (pixel_alpha != DRM_MODE_BLEND_PIXEL_NONE))
> +		return -EINVAL;
> +
>  	return 0;
>  }
>  
> @@ -323,17 +330,19 @@ static void malidp_de_plane_update(struct drm_plane *plane,
>  {
>  	struct malidp_plane *mp;
>  	struct malidp_plane_state *ms = to_malidp_plane_state(plane->state);
> +	struct drm_plane_state *state = plane->state;
> +	u16 pixel_alpha = state->pixel_blend_mode;
> +	u8 plane_alpha = state->alpha >> 8;
>  	u32 src_w, src_h, dest_w, dest_h, val;
>  	int i;
> -	bool format_has_alpha = plane->state->fb->format->has_alpha;
>  
>  	mp = to_malidp_plane(plane);
>  
>  	/* convert src values from Q16 fixed point to integer */
> -	src_w = plane->state->src_w >> 16;
> -	src_h = plane->state->src_h >> 16;
> -	dest_w = plane->state->crtc_w;
> -	dest_h = plane->state->crtc_h;
> +	src_w = state->src_w >> 16;
> +	src_h = state->src_h >> 16;
> +	dest_w = state->crtc_w;
> +	dest_h = state->crtc_h;
>  
>  	val = malidp_hw_read(mp->hwdev, mp->layer->base);
>  	val = (val & ~LAYER_FORMAT_MASK) | ms->format;
> @@ -342,14 +351,14 @@ static void malidp_de_plane_update(struct drm_plane *plane,
>  	for (i = 0; i < ms->n_planes; i++) {
>  		/* calculate the offset for the layer's plane registers */
>  		u16 ptr = mp->layer->ptr + (i << 4);
> -		dma_addr_t fb_addr = drm_fb_cma_get_gem_addr(plane->state->fb,
> -							     plane->state, i);
> +		dma_addr_t fb_addr = drm_fb_cma_get_gem_addr(state->fb,
> +							     state, i);
>  
>  		malidp_hw_write(mp->hwdev, lower_32_bits(fb_addr), ptr);
>  		malidp_hw_write(mp->hwdev, upper_32_bits(fb_addr), ptr + 4);
>  	}
>  	malidp_de_set_plane_pitches(mp, ms->n_planes,
> -				    plane->state->fb->pitches);
> +				    state->fb->pitches);
>  
>  	if ((plane->state->color_encoding != old_state->color_encoding) ||
>  	    (plane->state->color_range != old_state->color_range))
> @@ -362,8 +371,8 @@ static void malidp_de_plane_update(struct drm_plane *plane,
>  	malidp_hw_write(mp->hwdev, LAYER_H_VAL(dest_w) | LAYER_V_VAL(dest_h),
>  			mp->layer->base + MALIDP_LAYER_COMP_SIZE);
>  
> -	malidp_hw_write(mp->hwdev, LAYER_H_VAL(plane->state->crtc_x) |
> -			LAYER_V_VAL(plane->state->crtc_y),
> +	malidp_hw_write(mp->hwdev, LAYER_H_VAL(state->crtc_x) |
> +			LAYER_V_VAL(state->crtc_y),
>  			mp->layer->base + MALIDP_LAYER_OFFSET);
>  
>  	if (mp->layer->id == DE_SMART)
> @@ -376,38 +385,35 @@ static void malidp_de_plane_update(struct drm_plane *plane,
>  	val &= ~LAYER_ROT_MASK;
>  
>  	/* setup the rotation and axis flip bits */
> -	if (plane->state->rotation & DRM_MODE_ROTATE_MASK)
> +	if (state->rotation & DRM_MODE_ROTATE_MASK)
>  		val |= ilog2(plane->state->rotation & DRM_MODE_ROTATE_MASK) <<
>  		       LAYER_ROT_OFFSET;
> -	if (plane->state->rotation & DRM_MODE_REFLECT_X)
> +	if (state->rotation & DRM_MODE_REFLECT_X)
>  		val |= LAYER_H_FLIP;
> -	if (plane->state->rotation & DRM_MODE_REFLECT_Y)
> +	if (state->rotation & DRM_MODE_REFLECT_Y)
>  		val |= LAYER_V_FLIP;
>  
> -	val &= ~LAYER_COMP_MASK;
> -	if (format_has_alpha) {
> -
> -		/*
> -		 * always enable pixel alpha blending until we have a way
> -		 * to change blend modes
> -		 */
> -		val |= LAYER_COMP_PIXEL;
> -	} else {
> +	val &= ~(LAYER_COMP_MASK | LAYER_PMUL_ENABLE | LAYER_ALPHA(0xff));
>  
> -		/*
> -		 * do not enable pixel alpha blending as the color channel
> -		 * does not have any alpha information
> -		 */
> +	if (state->alpha != DRM_BLEND_ALPHA_OPAQUE) {
>  		val |= LAYER_COMP_PLANE;
> -
> -		/* Set layer alpha coefficient to 0xff ie fully opaque */
> -		val |= LAYER_ALPHA(0xff);
> +	} else if (state->fb->format->has_alpha) {
> +		/* We only care about blend mode if the format has alpha */
> +		switch (pixel_alpha) {
> +		case DRM_MODE_BLEND_PREMULTI:
> +			val |= LAYER_COMP_PIXEL | LAYER_PMUL_ENABLE;
> +			break;
> +		case DRM_MODE_BLEND_COVERAGE:
> +			val |= LAYER_COMP_PIXEL;
> +			break;
> +		}
>  	}
> +	val |= LAYER_ALPHA(plane_alpha);
>  
>  	val &= ~LAYER_FLOWCFG(LAYER_FLOWCFG_MASK);
> -	if (plane->state->crtc) {
> +	if (state->crtc) {
>  		struct malidp_crtc_state *m =
> -			to_malidp_crtc_state(plane->state->crtc->state);
> +			to_malidp_crtc_state(state->crtc->state);
>  
>  		if (m->scaler_config.scale_enable &&
>  		    m->scaler_config.plane_src_id == mp->layer->id)
> @@ -446,6 +452,9 @@ int malidp_de_planes_init(struct drm_device *drm)
>  	unsigned long crtcs = 1 << drm->mode_config.num_crtc;
>  	unsigned long flags = DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_180 |
>  			      DRM_MODE_ROTATE_270 | DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y;
> +	unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
> +				  BIT(DRM_MODE_BLEND_PREMULTI)   |
> +				  BIT(DRM_MODE_BLEND_COVERAGE);
>  	u32 *formats;
>  	int ret, i, j, n;
>  
> @@ -498,6 +507,9 @@ int malidp_de_planes_init(struct drm_device *drm)
>  		malidp_hw_write(malidp->dev, MALIDP_ALPHA_LUT,
>  				plane->layer->base + MALIDP_LAYER_COMPOSE);
>  
> +		drm_plane_create_alpha_property(&plane->base);
> +		drm_plane_create_blend_mode_property(&plane->base, blend_caps);
> +
>  		/* Attach the YUV->RGB property only to video layers */
>  		if (id & (DE_VIDEO1 | DE_VIDEO2)) {
>  			/* default encoding for YUV->RGB is BT601 NARROW */
> -- 
> 1.9.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
