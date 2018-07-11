Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C72C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B1F20883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B1F20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbeGKJgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:36:07 -0400
Received: from foss.arm.com ([217.140.101.70]:59922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbeGKJgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:36:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1486ED1;
        Wed, 11 Jul 2018 02:32:41 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EA903F5AF;
        Wed, 11 Jul 2018 02:32:41 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id EDFC96818E4; Wed, 11 Jul 2018 10:32:39 +0100 (BST)
Date:   Wed, 11 Jul 2018 10:32:39 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Ayan Kumar Halder <ayan.halder@arm.com>
Cc:     brian.starkey@arm.com, malidp@foss.arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nd@arm.com
Subject: Re: [PATCH v2 3/4] drm/arm/malidp: Set the AFBC register bits if the
 framebuffer has AFBC modifier
Message-ID: <20180711093239.GP15340@e110455-lin.cambridge.arm.com>
References: <1531228737-5450-1-git-send-email-ayan.halder@arm.com>
 <1531228737-5450-4-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531228737-5450-4-git-send-email-ayan.halder@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 02:18:56PM +0100, Ayan Kumar Halder wrote:
> Added the AFBC decoder registers for DP500 , DP550 and DP650.
> These registers control the processing of AFBC buffers. It controls various
> features like AFBC decoder enable, lossless transformation and block split
> as well as setting of the left, right, top and bottom cropping of AFBC buffers
> (in number of pixels).
> All the layers (except DE_SMART) support framebuffers with AFBC modifiers.
> One needs to set the pixel values of the top, left, bottom and right cropping
> for the AFBC framebuffer.
> Added the functionality in malidp_de_plane_update() to set the various
> registers for AFBC decoder, depending on the modifiers.
> 
> Changes from v2:-
> - Removed the "if (fb->modifier)" check from malidp_de_plane_update()
> and added it in malidp_de_set_plane_afbc(). This will consolidate all the
> AFBC specific register configurations in a single function ie
> malidp_de_set_plane_afbc().
> 
> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> Reviewed-by: Brian Starkey <brian.starkey@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks,
Liviu

> ---
>  drivers/gpu/drm/arm/malidp_hw.c     | 27 +++++++-----
>  drivers/gpu/drm/arm/malidp_hw.h     |  2 +
>  drivers/gpu/drm/arm/malidp_planes.c | 83 +++++++++++++++++++++++++++++++++----
>  drivers/gpu/drm/arm/malidp_regs.h   | 20 +++++++++
>  4 files changed, 113 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
> index 4dbf39f..fd6b510 100644
> --- a/drivers/gpu/drm/arm/malidp_hw.c
> +++ b/drivers/gpu/drm/arm/malidp_hw.c
> @@ -76,33 +76,38 @@ static const struct malidp_format_id malidp550_de_formats[] = {
>  
>  static const struct malidp_layer malidp500_layers[] = {
>  	{ DE_VIDEO1, MALIDP500_DE_LV_BASE, MALIDP500_DE_LV_PTR_BASE,
> -		MALIDP_DE_LV_STRIDE0, MALIDP500_LV_YUV2RGB, ROTATE_ANY },
> +		MALIDP_DE_LV_STRIDE0, MALIDP500_LV_YUV2RGB, ROTATE_ANY,
> +		MALIDP500_DE_LV_AD_CTRL },
>  	{ DE_GRAPHICS1, MALIDP500_DE_LG1_BASE, MALIDP500_DE_LG1_PTR_BASE,
> -		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY },
> +		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY, MALIDP500_DE_LG1_AD_CTRL },
>  	{ DE_GRAPHICS2, MALIDP500_DE_LG2_BASE, MALIDP500_DE_LG2_PTR_BASE,
> -		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY },
> +		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY, MALIDP500_DE_LG2_AD_CTRL },
>  };
>  
>  static const struct malidp_layer malidp550_layers[] = {
>  	{ DE_VIDEO1, MALIDP550_DE_LV1_BASE, MALIDP550_DE_LV1_PTR_BASE,
> -		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
> +		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY,
> +		MALIDP550_DE_LV1_AD_CTRL },
>  	{ DE_GRAPHICS1, MALIDP550_DE_LG_BASE, MALIDP550_DE_LG_PTR_BASE,
> -		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY },
> +		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY, MALIDP550_DE_LG_AD_CTRL },
>  	{ DE_VIDEO2, MALIDP550_DE_LV2_BASE, MALIDP550_DE_LV2_PTR_BASE,
> -		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
> +		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY,
> +		MALIDP550_DE_LV2_AD_CTRL },
>  	{ DE_SMART, MALIDP550_DE_LS_BASE, MALIDP550_DE_LS_PTR_BASE,
> -		MALIDP550_DE_LS_R1_STRIDE, 0, ROTATE_NONE },
> +		MALIDP550_DE_LS_R1_STRIDE, 0, ROTATE_NONE, 0 },
>  };
>  
>  static const struct malidp_layer malidp650_layers[] = {
>  	{ DE_VIDEO1, MALIDP550_DE_LV1_BASE, MALIDP550_DE_LV1_PTR_BASE,
> -		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
> +		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY,
> +		MALIDP550_DE_LV1_AD_CTRL },
>  	{ DE_GRAPHICS1, MALIDP550_DE_LG_BASE, MALIDP550_DE_LG_PTR_BASE,
> -		MALIDP_DE_LG_STRIDE, 0, ROTATE_COMPRESSED },
> +		MALIDP_DE_LG_STRIDE, 0, ROTATE_COMPRESSED, MALIDP550_DE_LG_AD_CTRL },
>  	{ DE_VIDEO2, MALIDP550_DE_LV2_BASE, MALIDP550_DE_LV2_PTR_BASE,
> -		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
> +		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY,
> +		MALIDP550_DE_LV2_AD_CTRL },
>  	{ DE_SMART, MALIDP550_DE_LS_BASE, MALIDP550_DE_LS_PTR_BASE,
> -		MALIDP550_DE_LS_R1_STRIDE, 0, ROTATE_NONE },
> +		MALIDP550_DE_LS_R1_STRIDE, 0, ROTATE_NONE, 0 },
>  };
>  
>  #define SE_N_SCALING_COEFFS	96
> diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
> index 4390243..bbe6883 100644
> --- a/drivers/gpu/drm/arm/malidp_hw.h
> +++ b/drivers/gpu/drm/arm/malidp_hw.h
> @@ -67,6 +67,8 @@ struct malidp_layer {
>  	u16 stride_offset;	/* offset to the first stride register. */
>  	s16 yuv2rgb_offset;	/* offset to the YUV->RGB matrix entries */
>  	enum rotation_features rot;    /* type of rotation supported */
> +	/* address offset for the AFBC decoder registers */
> +	u16 afbc_decoder_offset;
>  };
>  
>  enum malidp_scaling_coeff_set {
> diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
> index 533cdde..0122091 100644
> --- a/drivers/gpu/drm/arm/malidp_planes.c
> +++ b/drivers/gpu/drm/arm/malidp_planes.c
> @@ -330,6 +330,76 @@ static void malidp_de_set_color_encoding(struct malidp_plane *plane,
>  	}
>  }
>  
> +static void malidp_set_plane_base_addr(struct drm_framebuffer *fb,
> +				       struct malidp_plane *mp,
> +				       int plane_index)
> +{
> +	dma_addr_t paddr;
> +	u16 ptr;
> +	struct drm_plane *plane = &mp->base;
> +	bool afbc = fb->modifier ? true : false;
> +
> +	ptr = mp->layer->ptr + (plane_index << 4);
> +
> +	/*
> +	 * For AFBC buffers, cropping is handled by AFBC decoder rather than
> +	 * pointer manipulation.
> +	 */
> +	if (!afbc) {
> +		paddr = drm_fb_cma_get_gem_addr(fb, plane->state,
> +						plane_index);
> +	} else {
> +		struct drm_gem_cma_object *obj;
> +
> +		obj = drm_fb_cma_get_gem_obj(fb, plane_index);
> +
> +		if (WARN_ON(!obj))
> +			return;
> +		paddr = obj->paddr;
> +	}
> +
> +	malidp_hw_write(mp->hwdev, lower_32_bits(paddr), ptr);
> +	malidp_hw_write(mp->hwdev, upper_32_bits(paddr), ptr + 4);
> +}
> +
> +static void malidp_de_set_plane_afbc(struct drm_plane *plane)
> +{
> +	struct malidp_plane *mp;
> +	u32 src_w, src_h, val = 0, src_x, src_y;
> +	struct drm_framebuffer *fb = plane->state->fb;
> +
> +	mp = to_malidp_plane(plane);
> +
> +	if (!fb->modifier) {
> +		malidp_hw_write(mp->hwdev, 0, mp->layer->afbc_decoder_offset);
> +		return;
> +	}
> +
> +	/* convert src values from Q16 fixed point to integer */
> +	src_w = plane->state->src_w >> 16;
> +	src_h = plane->state->src_h >> 16;
> +	src_x = plane->state->src_x >> 16;
> +	src_y = plane->state->src_y >> 16;
> +
> +	val = ((fb->width - (src_x + src_w)) << MALIDP_AD_CROP_RIGHT_OFFSET) |
> +		   src_x;
> +	malidp_hw_write(mp->hwdev, val,
> +			mp->layer->afbc_decoder_offset + MALIDP_AD_CROP_H);
> +
> +	val = ((fb->height - (src_y + src_h)) << MALIDP_AD_CROP_BOTTOM_OFFSET) |
> +		   src_y;
> +	malidp_hw_write(mp->hwdev, val,
> +			mp->layer->afbc_decoder_offset + MALIDP_AD_CROP_V);
> +
> +	val = MALIDP_AD_EN;
> +	if (fb->modifier & AFBC_FORMAT_MOD_SPLIT)
> +		val |= MALIDP_AD_BS;
> +	if (fb->modifier & AFBC_FORMAT_MOD_YTR)
> +		val |= MALIDP_AD_YTR;
> +
> +	malidp_hw_write(mp->hwdev, val, mp->layer->afbc_decoder_offset);
> +}
> +
>  static void malidp_de_plane_update(struct drm_plane *plane,
>  				   struct drm_plane_state *old_state)
>  {
> @@ -338,6 +408,7 @@ static void malidp_de_plane_update(struct drm_plane *plane,
>  	u32 src_w, src_h, dest_w, dest_h, val;
>  	int i;
>  	bool format_has_alpha = plane->state->fb->format->has_alpha;
> +	struct drm_framebuffer *fb = plane->state->fb;
>  
>  	mp = to_malidp_plane(plane);
>  
> @@ -349,15 +420,9 @@ static void malidp_de_plane_update(struct drm_plane *plane,
>  
>  	malidp_hw_write(mp->hwdev, ms->format, mp->layer->base);
>  
> -	for (i = 0; i < ms->n_planes; i++) {
> -		/* calculate the offset for the layer's plane registers */
> -		u16 ptr = mp->layer->ptr + (i << 4);
> -		dma_addr_t fb_addr = drm_fb_cma_get_gem_addr(plane->state->fb,
> -							     plane->state, i);
> +	for (i = 0; i < ms->n_planes; i++)
> +		malidp_set_plane_base_addr(fb, mp, i);
>  
> -		malidp_hw_write(mp->hwdev, lower_32_bits(fb_addr), ptr);
> -		malidp_hw_write(mp->hwdev, upper_32_bits(fb_addr), ptr + 4);
> -	}
>  	malidp_de_set_plane_pitches(mp, ms->n_planes,
>  				    plane->state->fb->pitches);
>  
> @@ -381,6 +446,8 @@ static void malidp_de_plane_update(struct drm_plane *plane,
>  				LAYER_H_VAL(src_w) | LAYER_V_VAL(src_h),
>  				mp->layer->base + MALIDP550_LS_R1_IN_SIZE);
>  
> +	malidp_de_set_plane_afbc(plane);
> +
>  	/* first clear the rotation bits */
>  	val = malidp_hw_read(mp->hwdev, mp->layer->base + MALIDP_LAYER_CONTROL);
>  	val &= ~LAYER_ROT_MASK;
> diff --git a/drivers/gpu/drm/arm/malidp_regs.h b/drivers/gpu/drm/arm/malidp_regs.h
> index 149024f..54f4ec5 100644
> --- a/drivers/gpu/drm/arm/malidp_regs.h
> +++ b/drivers/gpu/drm/arm/malidp_regs.h
> @@ -180,10 +180,13 @@
>  #define MALIDP500_LV_YUV2RGB		((s16)(-0xB8))
>  #define MALIDP500_DE_LV_BASE		0x00100
>  #define MALIDP500_DE_LV_PTR_BASE	0x00124
> +#define MALIDP500_DE_LV_AD_CTRL		0x00400
>  #define MALIDP500_DE_LG1_BASE		0x00200
>  #define MALIDP500_DE_LG1_PTR_BASE	0x0021c
> +#define MALIDP500_DE_LG1_AD_CTRL	0x0040c
>  #define MALIDP500_DE_LG2_BASE		0x00300
>  #define MALIDP500_DE_LG2_PTR_BASE	0x0031c
> +#define MALIDP500_DE_LG2_AD_CTRL	0x00418
>  #define MALIDP500_SE_BASE		0x00c00
>  #define MALIDP500_SE_CONTROL		0x00c0c
>  #define MALIDP500_SE_PTR_BASE		0x00e0c
> @@ -208,10 +211,13 @@
>  #define MALIDP550_LV_YUV2RGB		0x00084
>  #define MALIDP550_DE_LV1_BASE		0x00100
>  #define MALIDP550_DE_LV1_PTR_BASE	0x00124
> +#define MALIDP550_DE_LV1_AD_CTRL	0x001B8
>  #define MALIDP550_DE_LV2_BASE		0x00200
>  #define MALIDP550_DE_LV2_PTR_BASE	0x00224
> +#define MALIDP550_DE_LV2_AD_CTRL	0x002B8
>  #define MALIDP550_DE_LG_BASE		0x00300
>  #define MALIDP550_DE_LG_PTR_BASE	0x0031c
> +#define MALIDP550_DE_LG_AD_CTRL		0x00330
>  #define MALIDP550_DE_LS_BASE		0x00400
>  #define MALIDP550_DE_LS_PTR_BASE	0x0042c
>  #define MALIDP550_DE_PERF_BASE		0x00500
> @@ -223,6 +229,20 @@
>  #define MALIDP550_CONFIG_VALID		0x0c014
>  #define MALIDP550_CONFIG_ID		0x0ffd4
>  
> +/* AFBC register offsets relative to MALIDPXXX_DE_LX_AD_CTRL */
> +/* The following register offsets are common for DP500, DP550 and DP650 */
> +#define MALIDP_AD_CROP_H                0x4
> +#define MALIDP_AD_CROP_V                0x8
> +#define MALIDP_AD_END_PTR_LOW           0xc
> +#define MALIDP_AD_END_PTR_HIGH          0x10
> +
> +/* AFBC decoder Registers */
> +#define MALIDP_AD_EN                    BIT(0)
> +#define MALIDP_AD_YTR                   BIT(4)
> +#define MALIDP_AD_BS                    BIT(8)
> +#define MALIDP_AD_CROP_RIGHT_OFFSET     16
> +#define MALIDP_AD_CROP_BOTTOM_OFFSET    16
> +
>  /*
>   * Starting with DP550 the register map blocks has been standardised to the
>   * following layout:
> -- 
> 2.7.4
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
