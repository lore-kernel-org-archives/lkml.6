Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 17070C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6173208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6173208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936163AbeFOMq6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 08:46:58 -0400
Received: from foss.arm.com ([217.140.101.70]:42052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754760AbeFOMq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 08:46:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1273080D;
        Fri, 15 Jun 2018 05:46:57 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B31023F59D;
        Fri, 15 Jun 2018 05:46:56 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 144EF68030C; Fri, 15 Jun 2018 13:46:55 +0100 (BST)
Date:   Fri, 15 Jun 2018 13:46:55 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Ayan Kumar Halder <ayan.halder@arm.com>
Cc:     brian.starkey@arm.com, malidp@foss.arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nd@arm.com
Subject: Re: [PATCH] drm/arm/malidp: Validate rotations for
 compressed/uncompressed framebuffers for each layer
Message-ID: <20180615124654.GD15072@e110455-lin.cambridge.arm.com>
References: <1529060099-12023-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1529060099-12023-1-git-send-email-ayan.halder@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ayan,

Minor nits:

On Fri, Jun 15, 2018 at 11:54:59AM +0100, Ayan Kumar Halder wrote:
> Mali-DP 500 supports rotations for both compressed/uncompressed buffers
> for all the layers.
> Mali-DP 550 supports rotations for both compressed/uncompressed buffers for
> VIDEO and GRAPHICS layers only. The SMART layer does not support any
> rotation.
> Mali-DP 650 supports rotations for both compressed/uncompressed buffers for
> VIDEO layers and compressed buffers only for GRAPHICS layer. SMART layer
> behaves similar to that of Malidp-550.

This information is probably useful for someone trying to find out what
the hardware can do, but it tells me nothing about the changes contained
inside the patch. In future, please also describe some of the changes
you are introducting. As an example, for this patch, I would say:

  - add support for compressed buffers that are described using
    framebuffer's modifier fields.
  - split the DP550 and DP650 layer info to account for differences
    when it comes to compressed/rotated buffers.
  - rotation memory is also used by the decompressor, include compressed
    buffers into the check for rotation memory space


> 
> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> Reviewed-by: Brian Starkey <brian.starkey@arm.com>
> ---
>  drivers/gpu/drm/arm/malidp_crtc.c   | 31 ++++++++++++++----------
>  drivers/gpu/drm/arm/malidp_hw.c     | 48 ++++++++++++++++++++++++++-----------
>  drivers/gpu/drm/arm/malidp_hw.h     | 10 +++++++-
>  drivers/gpu/drm/arm/malidp_planes.c | 24 +++++++++++++------
>  4 files changed, 79 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/malidp_crtc.c
> index fcc62bc..21c5d05 100644
> --- a/drivers/gpu/drm/arm/malidp_crtc.c
> +++ b/drivers/gpu/drm/arm/malidp_crtc.c
> @@ -348,19 +348,20 @@ static int malidp_crtc_atomic_check(struct drm_crtc *crtc,
>  
>  	/*
>  	 * check if there is enough rotation memory available for planes
> -	 * that need 90° and 270° rotation. Each plane has set its required
> -	 * memory size in the ->plane_check() callback, here we only make
> -	 * sure that the sums are less that the total usable memory.
> +	 * that need 90° and 270° rotion or planes that are compressed.
> +	 * Each plane has set its required memory size in the ->plane_check()
> +	 * callback, here we only make sure that the sums are less that the
> +	 * total usable memory.
>  	 *
>  	 * The rotation memory allocation algorithm (for each plane):
> -	 *  a. If no more rotated planes exist, all remaining rotate
> -	 *     memory in the bank is available for use by the plane.
> -	 *  b. If other rotated planes exist, and plane's layer ID is
> -	 *     DE_VIDEO1, it can use all the memory from first bank if
> -	 *     secondary rotation memory bank is available, otherwise it can
> +	 *  a. If no more rotated or compressed planes exist, all remaining
> +	 *     rotate memory in the bank is available for use by the plane.
> +	 *  b. If other rotated or compressed planes exist, and plane's
> +	 *     layer ID is DE_VIDEO1, it can use all the memory from first bank
> +	 *     if secondary rotation memory bank is available, otherwise it can
>  	 *     use up to half the bank's memory.
> -	 *  c. If other rotated planes exist, and plane's layer ID is not
> -	 *     DE_VIDEO1, it can use half of the available memory
> +	 *  c. If other rotated or compressed planes exist, and plane's layer ID
> +	 *     is not DE_VIDEO1, it can use half of the available memory.
>  	 *
>  	 * Note: this algorithm assumes that the order in which the planes are
>  	 * checked always has DE_VIDEO1 plane first in the list if it is
> @@ -368,11 +369,15 @@ static int malidp_crtc_atomic_check(struct drm_crtc *crtc,
>  	 * place, under current DRM version things work, but if ever the order
>  	 * in which drm_atomic_crtc_state_for_each_plane() iterates over planes
>  	 * changes, we need to pre-sort the planes before validation.
> +	 *

You don't need this.

>  	 */
>  
>  	/* first count the number of rotated planes */
>  	drm_atomic_crtc_state_for_each_plane_state(plane, pstate, state) {
> -		if (pstate->rotation & MALIDP_ROTATED_MASK)
> +		struct malidp_plane_state *ms = to_malidp_plane_state(pstate);
> +		struct drm_framebuffer *fb = ms->base.fb;
> +
> +		if ((pstate->rotation & MALIDP_ROTATED_MASK) || fb->modifier)
>  			rotated_planes++;
>  	}
>  
> @@ -388,8 +393,10 @@ static int malidp_crtc_atomic_check(struct drm_crtc *crtc,
>  	drm_atomic_crtc_state_for_each_plane_state(plane, pstate, state) {
>  		struct malidp_plane *mp = to_malidp_plane(plane);
>  		struct malidp_plane_state *ms = to_malidp_plane_state(pstate);
> +		struct drm_framebuffer *fb = ms->base.fb;
> +
> +		if ((pstate->rotation & MALIDP_ROTATED_MASK) || fb->modifier) {
>  
> -		if (pstate->rotation & MALIDP_ROTATED_MASK) {
>  			/* process current plane */
>  			rotated_planes--;
>  
> diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
> index d789b46..4dbf39f 100644
> --- a/drivers/gpu/drm/arm/malidp_hw.c
> +++ b/drivers/gpu/drm/arm/malidp_hw.c
> @@ -75,16 +75,34 @@ static const struct malidp_format_id malidp550_de_formats[] = {
>  };
>  
>  static const struct malidp_layer malidp500_layers[] = {
> -	{ DE_VIDEO1, MALIDP500_DE_LV_BASE, MALIDP500_DE_LV_PTR_BASE, MALIDP_DE_LV_STRIDE0, MALIDP500_LV_YUV2RGB },
> -	{ DE_GRAPHICS1, MALIDP500_DE_LG1_BASE, MALIDP500_DE_LG1_PTR_BASE, MALIDP_DE_LG_STRIDE, 0 },
> -	{ DE_GRAPHICS2, MALIDP500_DE_LG2_BASE, MALIDP500_DE_LG2_PTR_BASE, MALIDP_DE_LG_STRIDE, 0 },
> +	{ DE_VIDEO1, MALIDP500_DE_LV_BASE, MALIDP500_DE_LV_PTR_BASE,
> +		MALIDP_DE_LV_STRIDE0, MALIDP500_LV_YUV2RGB, ROTATE_ANY },
> +	{ DE_GRAPHICS1, MALIDP500_DE_LG1_BASE, MALIDP500_DE_LG1_PTR_BASE,
> +		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY },
> +	{ DE_GRAPHICS2, MALIDP500_DE_LG2_BASE, MALIDP500_DE_LG2_PTR_BASE,
> +		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY },
>  };
>  
>  static const struct malidp_layer malidp550_layers[] = {
> -	{ DE_VIDEO1, MALIDP550_DE_LV1_BASE, MALIDP550_DE_LV1_PTR_BASE, MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB },
> -	{ DE_GRAPHICS1, MALIDP550_DE_LG_BASE, MALIDP550_DE_LG_PTR_BASE, MALIDP_DE_LG_STRIDE, 0 },
> -	{ DE_VIDEO2, MALIDP550_DE_LV2_BASE, MALIDP550_DE_LV2_PTR_BASE, MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB },
> -	{ DE_SMART, MALIDP550_DE_LS_BASE, MALIDP550_DE_LS_PTR_BASE, MALIDP550_DE_LS_R1_STRIDE, 0 },
> +	{ DE_VIDEO1, MALIDP550_DE_LV1_BASE, MALIDP550_DE_LV1_PTR_BASE,
> +		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
> +	{ DE_GRAPHICS1, MALIDP550_DE_LG_BASE, MALIDP550_DE_LG_PTR_BASE,
> +		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY },
> +	{ DE_VIDEO2, MALIDP550_DE_LV2_BASE, MALIDP550_DE_LV2_PTR_BASE,
> +		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
> +	{ DE_SMART, MALIDP550_DE_LS_BASE, MALIDP550_DE_LS_PTR_BASE,
> +		MALIDP550_DE_LS_R1_STRIDE, 0, ROTATE_NONE },
> +};
> +
> +static const struct malidp_layer malidp650_layers[] = {
> +	{ DE_VIDEO1, MALIDP550_DE_LV1_BASE, MALIDP550_DE_LV1_PTR_BASE,
> +		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
> +	{ DE_GRAPHICS1, MALIDP550_DE_LG_BASE, MALIDP550_DE_LG_PTR_BASE,
> +		MALIDP_DE_LG_STRIDE, 0, ROTATE_COMPRESSED },
> +	{ DE_VIDEO2, MALIDP550_DE_LV2_BASE, MALIDP550_DE_LV2_PTR_BASE,
> +		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
> +	{ DE_SMART, MALIDP550_DE_LS_BASE, MALIDP550_DE_LS_PTR_BASE,
> +		MALIDP550_DE_LS_R1_STRIDE, 0, ROTATE_NONE },
>  };
>  
>  #define SE_N_SCALING_COEFFS	96
> @@ -272,10 +290,11 @@ static void malidp500_modeset(struct malidp_hw_device *hwdev, struct videomode *
>  		malidp_hw_clearbits(hwdev, MALIDP_DISP_FUNC_ILACED, MALIDP_DE_DISPLAY_FUNC);
>  }
>  
> -static int malidp500_rotmem_required(struct malidp_hw_device *hwdev, u16 w, u16 h, u32 fmt)
> +static int malidp500_rotmem_required(struct malidp_hw_device *hwdev, u16 w,
> +				     u16 h, u32 fmt, bool has_modifier)
>  {
> -	/* RGB888 or BGR888 can't be rotated */
> -	if ((fmt == DRM_FORMAT_RGB888) || (fmt == DRM_FORMAT_BGR888))
> +	/* raw RGB888 or BGR888 can't be rotated */
> +	if ((fmt == DRM_FORMAT_RGB888 || fmt == DRM_FORMAT_BGR888) && !has_modifier)
>  		return -EINVAL;
>  
>  	/*
> @@ -496,12 +515,13 @@ static void malidp550_modeset(struct malidp_hw_device *hwdev, struct videomode *
>  		malidp_hw_clearbits(hwdev, MALIDP_DISP_FUNC_ILACED, MALIDP_DE_DISPLAY_FUNC);
>  }
>  
> -static int malidp550_rotmem_required(struct malidp_hw_device *hwdev, u16 w, u16 h, u32 fmt)
> +static int malidp550_rotmem_required(struct malidp_hw_device *hwdev, u16 w,
> +				     u16 h, u32 fmt, bool has_modifier)
>  {
>  	u32 bytes_per_col;
>  
>  	/* raw RGB888 or BGR888 can't be rotated */
> -	if ((fmt == DRM_FORMAT_RGB888) || (fmt == DRM_FORMAT_BGR888))
> +	if ((fmt == DRM_FORMAT_RGB888 || fmt == DRM_FORMAT_BGR888) && !has_modifier)
>  		return -EINVAL;
>  
>  	switch (fmt) {
> @@ -700,8 +720,8 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DEVICES] = {
>  			.dc_base = MALIDP550_DC_BASE,
>  			.out_depth_base = MALIDP550_DE_OUTPUT_DEPTH,
>  			.features = MALIDP_REGMAP_HAS_CLEARIRQ,
> -			.n_layers = ARRAY_SIZE(malidp550_layers),
> -			.layers = malidp550_layers,
> +			.n_layers = ARRAY_SIZE(malidp650_layers),
> +			.layers = malidp650_layers,
>  			.de_irq_map = {
>  				.irq_mask = MALIDP_DE_IRQ_UNDERRUN |
>  					    MALIDP650_DE_IRQ_DRIFT |
> diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
> index b5dd6c7..41f4521 100644
> --- a/drivers/gpu/drm/arm/malidp_hw.h
> +++ b/drivers/gpu/drm/arm/malidp_hw.h
> @@ -54,12 +54,19 @@ struct malidp_irq_map {
>  	u32 vsync_irq;		/* IRQ bit used for signaling during VSYNC */
>  };
>  
> +enum rotation_features {
> +	ROTATE_ANY,	        /* supports rotation on any buffers */
> +	ROTATE_COMPRESSED,	/* supports rotation only on compressed buffers */
> +	ROTATE_NONE,        /* does not support rotation at all */

The comment seems to be aligned with spaces, not tabs.

> +};
> +
>  struct malidp_layer {
>  	u16 id;			/* layer ID */
>  	u16 base;		/* address offset for the register bank */
>  	u16 ptr;		/* address offset for the pointer register */
>  	u16 stride_offset;	/* offset to the first stride register. */
>  	s16 yuv2rgb_offset;	/* offset to the YUV->RGB matrix entries */
> +	enum rotation_features rot;    /* type of rotation supported */
>  };
>  
>  enum malidp_scaling_coeff_set {
> @@ -168,7 +175,8 @@ struct malidp_hw {
>  	 * Calculate the required rotation memory given the active area
>  	 * and the buffer format.
>  	 */
> -	int (*rotmem_required)(struct malidp_hw_device *hwdev, u16 w, u16 h, u32 fmt);
> +	int (*rotmem_required)(struct malidp_hw_device *hwdev, u16 w, u16 h,
> +			       u32 fmt, bool has_modifier);
>  
>  	int (*se_set_scaling_coeffs)(struct malidp_hw_device *hwdev,
>  				     struct malidp_se_config *se_config,
> diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
> index 7a44897..377382e 100644
> --- a/drivers/gpu/drm/arm/malidp_planes.c
> +++ b/drivers/gpu/drm/arm/malidp_planes.c
> @@ -197,12 +197,19 @@ static int malidp_de_plane_check(struct drm_plane *plane,
>  
>  	ms->n_planes = fb->format->num_planes;
>  	for (i = 0; i < ms->n_planes; i++) {
> +		struct drm_gem_cma_object *obj;
> +
>  		u8 alignment = malidp_hw_get_pitch_align(mp->hwdev, rotated);
>  		if (fb->pitches[i] & (alignment - 1)) {
>  			DRM_DEBUG_KMS("Invalid pitch %u for plane %d\n",
>  				      fb->pitches[i], i);
>  			return -EINVAL;
>  		}
> +
> +		obj = drm_fb_cma_get_gem_obj(fb, i);
> +
> +		if (WARN_ON(!obj))
> +			return -EINVAL;
>  	}
>  
>  	if ((state->crtc_w > mp->hwdev->max_line_size) ||
> @@ -225,19 +232,22 @@ static int malidp_de_plane_check(struct drm_plane *plane,
>  	if (ret)
>  		return ret;
>  
> -	/* packed RGB888 / BGR888 can't be rotated or flipped */
> -	if (state->rotation != DRM_MODE_ROTATE_0 &&
> -	    (fb->format->format == DRM_FORMAT_RGB888 ||
> -	     fb->format->format == DRM_FORMAT_BGR888))
> -		return -EINVAL;
> +	/* validate the rotation constraints for each layer */
> +	if (state->rotation != DRM_MODE_ROTATE_0) {
> +		if (mp->layer->rot == ROTATE_NONE)
> +			return -EINVAL;
> +		else if ((mp->layer->rot == ROTATE_COMPRESSED) && (!fb->modifier))

For consistency with the rest of the code I would drop the extra
paranthesis around !fb->modifier.

> +			return -EINVAL;
> +	}
>  
>  	ms->rotmem_size = 0;
> -	if (state->rotation & MALIDP_ROTATED_MASK) {
> +	if (state->rotation != DRM_MODE_ROTATE_0 || fb->modifier) {
>  		int val;
>  
>  		val = mp->hwdev->hw->rotmem_required(mp->hwdev, state->crtc_h,
>  						     state->crtc_w,
> -						     fb->format->format);
> +						     fb->format->format,
> +						     !!(fb->modifier));
>  		if (val < 0)
>  			return val;
>  
> -- 
> 2.7.4
> 

Other than that,

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks for all your work adding support for this!

Best regards,
Liviu


-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
