Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38B2C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B8024003
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B8024003
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753625AbeGERiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:38:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54520 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753346AbeGERiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:38:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3B5F18A;
        Thu,  5 Jul 2018 10:38:23 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5199E3F2EA;
        Thu,  5 Jul 2018 10:38:23 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id A9439680117; Thu,  5 Jul 2018 18:38:21 +0100 (BST)
Date:   Thu, 5 Jul 2018 18:38:21 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Ayan Halder <ayan.halder@arm.com>
Cc:     Liviu Dudau <Liviu.Dudau@foss.arm.com>, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        malidp@foss.arm.com, nd@arm.com
Subject: Re: [RFC PATCH 3/4] drm/arm/malidp: Set the AFBC register bits if
 the framebuffer has AFBC modifier
Message-ID: <20180705173821.GI15340@e110455-lin.cambridge.arm.com>
References: <1529070694-21088-1-git-send-email-ayan.halder@arm.com>
 <1529070694-21088-4-git-send-email-ayan.halder@arm.com>
 <20180626131716.GA14974@e110455-lin.cambridge.arm.com>
 <20180705133147.GA31243@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180705133147.GA31243@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 02:31:47PM +0100, Ayan Halder wrote:
> On Tue, Jun 26, 2018 at 02:17:17PM +0100, Liviu Dudau wrote:
> > Hi Ayan,
> > 
> > Thanks for the patch! I have some small comments to make:
> > 
> > On Fri, Jun 15, 2018 at 02:51:33PM +0100, Ayan Kumar Halder wrote:
> > > Added the AFBC decoder registers for DP500 , DP550 and DP650.
> > > These registers control the processing of AFBC buffers. It controls various
> > > features like AFBC decoder enable, lossless transformation and block split
> > > as well as setting of the left, right, top and bottom cropping of AFBC buffers
> > > (in number of pixels).
> > > All the layers (except DE_SMART) support framebuffers with AFBC modifiers.
> > > One needs to set the pixel values of the top, left, bottom and right cropping
> > > for the AFBC framebuffer.
> > > Added the functionality in malidp_de_plane_update() to set the various
> > > registers for AFBC decoder, depending on the modifiers.
> > > 
> > > Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> > > Reviewed-by: Brian Starkey <brian.starkey@arm.com>
> > > ---
> > >  drivers/gpu/drm/arm/malidp_hw.c     | 27 ++++++++-----
> > >  drivers/gpu/drm/arm/malidp_hw.h     |  2 +
> > >  drivers/gpu/drm/arm/malidp_planes.c | 81 +++++++++++++++++++++++++++++++++----
> > >  drivers/gpu/drm/arm/malidp_regs.h   | 20 +++++++++
> > >  4 files changed, 111 insertions(+), 19 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
> > > index 4dbf39f..fd6b510 100644
> > > --- a/drivers/gpu/drm/arm/malidp_hw.c
> > > +++ b/drivers/gpu/drm/arm/malidp_hw.c
> > > @@ -76,33 +76,38 @@ static const struct malidp_format_id malidp550_de_formats[] = {
> > >  
> > >  static const struct malidp_layer malidp500_layers[] = {
> > >  	{ DE_VIDEO1, MALIDP500_DE_LV_BASE, MALIDP500_DE_LV_PTR_BASE,
> > > -		MALIDP_DE_LV_STRIDE0, MALIDP500_LV_YUV2RGB, ROTATE_ANY },
> > > +		MALIDP_DE_LV_STRIDE0, MALIDP500_LV_YUV2RGB, ROTATE_ANY,
> > > +		MALIDP500_DE_LV_AD_CTRL },
> > >  	{ DE_GRAPHICS1, MALIDP500_DE_LG1_BASE, MALIDP500_DE_LG1_PTR_BASE,
> > > -		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY },
> > > +		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY, MALIDP500_DE_LG1_AD_CTRL },
> > >  	{ DE_GRAPHICS2, MALIDP500_DE_LG2_BASE, MALIDP500_DE_LG2_PTR_BASE,
> > > -		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY },
> > > +		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY, MALIDP500_DE_LG2_AD_CTRL },
> > >  };
> > >  
> > >  static const struct malidp_layer malidp550_layers[] = {
> > >  	{ DE_VIDEO1, MALIDP550_DE_LV1_BASE, MALIDP550_DE_LV1_PTR_BASE,
> > > -		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
> > > +		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY,
> > > +		MALIDP550_DE_LV1_AD_CTRL },
> > >  	{ DE_GRAPHICS1, MALIDP550_DE_LG_BASE, MALIDP550_DE_LG_PTR_BASE,
> > > -		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY },
> > > +		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY, MALIDP550_DE_LG_AD_CTRL },
> > >  	{ DE_VIDEO2, MALIDP550_DE_LV2_BASE, MALIDP550_DE_LV2_PTR_BASE,
> > > -		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
> > > +		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY,
> > > +		MALIDP550_DE_LV2_AD_CTRL },
> > >  	{ DE_SMART, MALIDP550_DE_LS_BASE, MALIDP550_DE_LS_PTR_BASE,
> > > -		MALIDP550_DE_LS_R1_STRIDE, 0, ROTATE_NONE },
> > > +		MALIDP550_DE_LS_R1_STRIDE, 0, ROTATE_NONE, 0 },
> > >  };
> > >  
> > >  static const struct malidp_layer malidp650_layers[] = {
> > >  	{ DE_VIDEO1, MALIDP550_DE_LV1_BASE, MALIDP550_DE_LV1_PTR_BASE,
> > > -		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
> > > +		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY,
> > > +		MALIDP550_DE_LV1_AD_CTRL },
> > >  	{ DE_GRAPHICS1, MALIDP550_DE_LG_BASE, MALIDP550_DE_LG_PTR_BASE,
> > > -		MALIDP_DE_LG_STRIDE, 0, ROTATE_COMPRESSED },
> > > +		MALIDP_DE_LG_STRIDE, 0, ROTATE_COMPRESSED, MALIDP550_DE_LG_AD_CTRL },
> > >  	{ DE_VIDEO2, MALIDP550_DE_LV2_BASE, MALIDP550_DE_LV2_PTR_BASE,
> > > -		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
> > > +		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY,
> > > +		MALIDP550_DE_LV2_AD_CTRL },
> > >  	{ DE_SMART, MALIDP550_DE_LS_BASE, MALIDP550_DE_LS_PTR_BASE,
> > > -		MALIDP550_DE_LS_R1_STRIDE, 0, ROTATE_NONE },
> > > +		MALIDP550_DE_LS_R1_STRIDE, 0, ROTATE_NONE, 0 },
> > >  };
> > >  
> > >  #define SE_N_SCALING_COEFFS	96
> > > diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
> > > index 4390243..bbe6883 100644
> > > --- a/drivers/gpu/drm/arm/malidp_hw.h
> > > +++ b/drivers/gpu/drm/arm/malidp_hw.h
> > > @@ -67,6 +67,8 @@ struct malidp_layer {
> > >  	u16 stride_offset;	/* offset to the first stride register. */
> > >  	s16 yuv2rgb_offset;	/* offset to the YUV->RGB matrix entries */
> > >  	enum rotation_features rot;    /* type of rotation supported */
> > > +	/* address offset for the AFBC decoder registers */
> > > +	u16 afbc_decoder_offset;
> > >  };
> > >  
> > >  enum malidp_scaling_coeff_set {
> > > diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
> > > index 533cdde..3950504 100644
> > > --- a/drivers/gpu/drm/arm/malidp_planes.c
> > > +++ b/drivers/gpu/drm/arm/malidp_planes.c
> > > @@ -330,6 +330,71 @@ static void malidp_de_set_color_encoding(struct malidp_plane *plane,
> > >  	}
> > >  }
> > >  
> > > +static void malidp_set_plane_base_addr(struct drm_framebuffer *fb,
> > > +				       struct malidp_plane *mp,
> > > +				       int plane_index)
> > > +{
> > > +	dma_addr_t paddr;
> > > +	u16 ptr;
> > > +	struct drm_plane *plane = &mp->base;
> > > +	bool afbc = fb->modifier ? true : false;
> > 
> > The decision to set afbc based on wether the fb has a modifier or not
> > seems a bit weak. Should we also (at least) check that the modifier is
> > an ARM one?
> 
> In my next patch (of this series) ie
> https://patchwork.kernel.org/patch/10466537/, we have checked for the
> validity of modifier and format in malidp_format_mod_supported(). When
> drm_atomic_commit() is invoked, it first calls (indirectly via some
> intermediate functions)
> malidp_format_mod_supported() and then invokes
> malidp_set_plane_base_addr(). So there is no way that an invalid
> modifier could be passed to malidp_set_plane_base_addr(). If
> malidp_format_mod_supported() returns error then drm_atomic_commit()
> would return error too.
> > 
> > > +
> > > +	ptr = mp->layer->ptr + (plane_index << 4);
> > > +
> > > +	/*
> > > +	 * For AFBC buffers, cropping is handled by AFBC decoder rather than
> > > +	 * pointer manipulation.
> > > +	 */
> > > +	if (!afbc) {
> > > +		paddr = drm_fb_cma_get_gem_addr(fb, plane->state,
> > > +						plane_index);
> > > +	} else {
> > > +		struct drm_gem_cma_object *obj;
> > > +
> > > +		obj = drm_fb_cma_get_gem_obj(fb, plane_index);
> > > +
> > > +		if (WARN_ON(!obj))
> > > +			return;
> > > +		paddr = obj->paddr;
> > > +	}
> > > +
> > > +	malidp_hw_write(mp->hwdev, lower_32_bits(paddr), ptr);
> > > +	malidp_hw_write(mp->hwdev, upper_32_bits(paddr), ptr + 4);
> > > +}
> > > +
> > > +static void malidp_de_set_plane_afbc(struct drm_plane *plane)
> > > +{
> > > +	struct malidp_plane *mp;
> > > +	u32 src_w, src_h, val = 0, src_x, src_y;
> > > +	struct drm_framebuffer *fb = plane->state->fb;
> > > +
> > > +	mp = to_malidp_plane(plane);
> > > +
> > > +	/* convert src values from Q16 fixed point to integer */
> > > +	src_w = plane->state->src_w >> 16;
> > > +	src_h = plane->state->src_h >> 16;
> > > +	src_x = plane->state->src_x >> 16;
> > > +	src_y = plane->state->src_y >> 16;
> > > +
> > > +	val = ((fb->width - (src_x + src_w)) << MALIDP_AD_CROP_RIGHT_OFFSET) |
> > > +		   src_x;
> > > +	malidp_hw_write(mp->hwdev, val,
> > > +			mp->layer->afbc_decoder_offset + MALIDP_AD_CROP_H);
> > > +
> > > +	val = ((fb->height - (src_y + src_h)) << MALIDP_AD_CROP_BOTTOM_OFFSET) |
> > > +		   src_y;
> > > +	malidp_hw_write(mp->hwdev, val,
> > > +			mp->layer->afbc_decoder_offset + MALIDP_AD_CROP_V);
> > > +
> > > +	val = MALIDP_AD_EN;
> > > +	if (fb->modifier & AFBC_FORMAT_MOD_SPLIT)
> > > +		val |= MALIDP_AD_BS;
> > > +	if (fb->modifier & AFBC_FORMAT_MOD_YTR)
> > > +		val |= MALIDP_AD_YTR;
> > > +
> > > +	malidp_hw_write(mp->hwdev, val, mp->layer->afbc_decoder_offset);
> > > +}
> > > +
> > >  static void malidp_de_plane_update(struct drm_plane *plane,
> > >  				   struct drm_plane_state *old_state)
> > >  {
> > > @@ -338,6 +403,7 @@ static void malidp_de_plane_update(struct drm_plane *plane,
> > >  	u32 src_w, src_h, dest_w, dest_h, val;
> > >  	int i;
> > >  	bool format_has_alpha = plane->state->fb->format->has_alpha;
> > > +	struct drm_framebuffer *fb = plane->state->fb;
> > >  
> > >  	mp = to_malidp_plane(plane);
> > >  
> > > @@ -349,15 +415,9 @@ static void malidp_de_plane_update(struct drm_plane *plane,
> > >  
> > >  	malidp_hw_write(mp->hwdev, ms->format, mp->layer->base);
> > >  
> > > -	for (i = 0; i < ms->n_planes; i++) {
> > > -		/* calculate the offset for the layer's plane registers */
> > > -		u16 ptr = mp->layer->ptr + (i << 4);
> > > -		dma_addr_t fb_addr = drm_fb_cma_get_gem_addr(plane->state->fb,
> > > -							     plane->state, i);
> > > +	for (i = 0; i < ms->n_planes; i++)
> > > +		malidp_set_plane_base_addr(fb, mp, i);
> > >  
> > > -		malidp_hw_write(mp->hwdev, lower_32_bits(fb_addr), ptr);
> > > -		malidp_hw_write(mp->hwdev, upper_32_bits(fb_addr), ptr + 4);
> > > -	}
> > >  	malidp_de_set_plane_pitches(mp, ms->n_planes,
> > >  				    plane->state->fb->pitches);
> > >  
> > > @@ -381,6 +441,11 @@ static void malidp_de_plane_update(struct drm_plane *plane,
> > >  				LAYER_H_VAL(src_w) | LAYER_V_VAL(src_h),
> > >  				mp->layer->base + MALIDP550_LS_R1_IN_SIZE);
> > >  
> > > +	if (fb->modifier)
> > > +		malidp_de_set_plane_afbc(plane);
> > > +	else
> > > +		malidp_hw_write(mp->hwdev, 0, mp->layer->afbc_decoder_offset);
> > 
> > Given that you are testing for the non-zero value of fb->modifier inside
> > malidp_de_set_plane_afbc() function before setting the afbc_decoder
> > register value, I feel that you could take the 'else' branch from here
> > and merge it into malidp_de_set_plane_afbc() function (possibly also
> > rename it to malidp_de_set_plane).
> 
> I am not exactly sure what you meant here. We are testing for the non
> zero value of fb->modifier in malidp_de_plane_update(). If
> fb->modifier is not zero, we set the afbc specific registers in
> malidp_de_set_plane_afbc(). Thus, malidp_de_plane_update()  will
> invoke malidp_de_set_plane_afbc() for setting afbc stuff and will
> continue with the other register settings. I do not see a clear reason
> to refactor this code.

What I'm suggesting is:

 - rename malidp_de_set_plane_afbc to malidp_de_set_plane()
 - remove the if .. else malidp_hw_write(mp->hwdev, 0, mp->layer->afbc_decoder_offset);
   and keep just the call to malidp_de_set_plane() without any other
   condition
 - inside malidp_de_set_plane(), change from:
	val = MALIDP_AD_EN;
   to
	val = fb->modifier ? MALIDP_AD_EN : 0;

   and then the 0 value will be written correctly into the
   afbc_decoder_offset if fb->modifier is zero.

Best regards,
Liviu

> 
> > With those small changes:
> > 
> > Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> > 
> > Best regards,
> > Liviu
> > 
> > 
> > > +
> > >  	/* first clear the rotation bits */
> > >  	val = malidp_hw_read(mp->hwdev, mp->layer->base + MALIDP_LAYER_CONTROL);
> > >  	val &= ~LAYER_ROT_MASK;
> > > diff --git a/drivers/gpu/drm/arm/malidp_regs.h b/drivers/gpu/drm/arm/malidp_regs.h
> > > index 149024f..54f4ec5 100644
> > > --- a/drivers/gpu/drm/arm/malidp_regs.h
> > > +++ b/drivers/gpu/drm/arm/malidp_regs.h
> > > @@ -180,10 +180,13 @@
> > >  #define MALIDP500_LV_YUV2RGB		((s16)(-0xB8))
> > >  #define MALIDP500_DE_LV_BASE		0x00100
> > >  #define MALIDP500_DE_LV_PTR_BASE	0x00124
> > > +#define MALIDP500_DE_LV_AD_CTRL		0x00400
> > >  #define MALIDP500_DE_LG1_BASE		0x00200
> > >  #define MALIDP500_DE_LG1_PTR_BASE	0x0021c
> > > +#define MALIDP500_DE_LG1_AD_CTRL	0x0040c
> > >  #define MALIDP500_DE_LG2_BASE		0x00300
> > >  #define MALIDP500_DE_LG2_PTR_BASE	0x0031c
> > > +#define MALIDP500_DE_LG2_AD_CTRL	0x00418
> > >  #define MALIDP500_SE_BASE		0x00c00
> > >  #define MALIDP500_SE_CONTROL		0x00c0c
> > >  #define MALIDP500_SE_PTR_BASE		0x00e0c
> > > @@ -208,10 +211,13 @@
> > >  #define MALIDP550_LV_YUV2RGB		0x00084
> > >  #define MALIDP550_DE_LV1_BASE		0x00100
> > >  #define MALIDP550_DE_LV1_PTR_BASE	0x00124
> > > +#define MALIDP550_DE_LV1_AD_CTRL	0x001B8
> > >  #define MALIDP550_DE_LV2_BASE		0x00200
> > >  #define MALIDP550_DE_LV2_PTR_BASE	0x00224
> > > +#define MALIDP550_DE_LV2_AD_CTRL	0x002B8
> > >  #define MALIDP550_DE_LG_BASE		0x00300
> > >  #define MALIDP550_DE_LG_PTR_BASE	0x0031c
> > > +#define MALIDP550_DE_LG_AD_CTRL		0x00330
> > >  #define MALIDP550_DE_LS_BASE		0x00400
> > >  #define MALIDP550_DE_LS_PTR_BASE	0x0042c
> > >  #define MALIDP550_DE_PERF_BASE		0x00500
> > > @@ -223,6 +229,20 @@
> > >  #define MALIDP550_CONFIG_VALID		0x0c014
> > >  #define MALIDP550_CONFIG_ID		0x0ffd4
> > >  
> > > +/* AFBC register offsets relative to MALIDPXXX_DE_LX_AD_CTRL */
> > > +/* The following register offsets are common for DP500, DP550 and DP650 */
> > > +#define MALIDP_AD_CROP_H                0x4
> > > +#define MALIDP_AD_CROP_V                0x8
> > > +#define MALIDP_AD_END_PTR_LOW           0xc
> > > +#define MALIDP_AD_END_PTR_HIGH          0x10
> > > +
> > > +/* AFBC decoder Registers */
> > > +#define MALIDP_AD_EN                    BIT(0)
> > > +#define MALIDP_AD_YTR                   BIT(4)
> > > +#define MALIDP_AD_BS                    BIT(8)
> > > +#define MALIDP_AD_CROP_RIGHT_OFFSET     16
> > > +#define MALIDP_AD_CROP_BOTTOM_OFFSET    16
> > > +
> > >  /*
> > >   * Starting with DP550 the register map blocks has been standardised to the
> > >   * following layout:
> > > -- 
> > > 2.7.4
> > > 
> > 
> > -- 
> > ====================
> > | I would like to |
> > | fix the world,  |
> > | but they're not |
> > | giving me the   |
> >  \ source code!  /
> >   ---------------
> >     ??\_(???)_/??
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
