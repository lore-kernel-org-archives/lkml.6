Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB93C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B902133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbeLQOBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:01:12 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56700 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbeLQOBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:01:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60D05A78;
        Mon, 17 Dec 2018 06:01:11 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CDE43F59C;
        Mon, 17 Dec 2018 06:01:11 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 5D1E4680208; Mon, 17 Dec 2018 14:01:09 +0000 (GMT)
Date:   Mon, 17 Dec 2018 14:01:09 +0000
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "corbet@lwn.net" <corbet@lwn.net>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        nd <nd@arm.com>, "sean@poorly.run" <sean@poorly.run>
Subject: Re: [RFC v3 AFBC 04/12] drm/arm/malidp: Set the AFBC register bits
 if the framebuffer has AFBC modifier
Message-ID: <20181217140109.GY988@e110455-lin.cambridge.arm.com>
References: <1543836703-8491-1-git-send-email-ayan.halder@arm.com>
 <1543836703-8491-5-git-send-email-ayan.halder@arm.com>
 <20181204165051.GL988@e110455-lin.cambridge.arm.com>
 <20181214134512.GA19564@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181214134512.GA19564@arm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 01:45:13PM +0000, Ayan Halder wrote:
> On Tue, Dec 04, 2018 at 04:50:51PM +0000, Liviu Dudau wrote:
> 
> Hi Liviu,
> 
> Please let me know if you agree with my comments. Then I will send a
> v4 patch for this.
> > On Mon, Dec 03, 2018 at 11:31:58AM +0000, Ayan Halder wrote:
> > > Added the AFBC decoder registers for DP500 , DP550 and DP650.
> > > These registers control the processing of AFBC buffers. It controls various
> > > features like AFBC decoder enable, lossless transformation and block split
> > > as well as setting of the left, right, top and bottom cropping of AFBC buffers
> > > (in number of pixels).
> > > All the layers (except DE_SMART) support framebuffers with AFBC modifiers.
> > > One needs to set the pixel values of the top, left, bottom and right cropping
> > > for the AFBC framebuffer.
> > > Cropping an AFBC framebuffer is controlled by the AFBC crop registers.
> > > In that case, the layer input size registers should be configured with
> > > framebuffer's dimensions and not with drm_plane_state source width/height
> > > values (which is used for non AFBC framebuffer to denote cropping).
> > > 
> > > Changes from v1:
> > >  - Removed the "if (fb->modifier)" check from malidp_de_plane_update()
> > > and added it in malidp_de_set_plane_afbc(). This will consolidate all the
> > > AFBC specific register configurations in a single function ie
> > > malidp_de_set_plane_afbc().
> > > 
> > > Changes from v2:
> > >  - For AFBC framebuffer, layer input size register should be set to framebuffer's
> > > width and height
> > > 
> > > Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
> > > ---
> > >  drivers/gpu/drm/arm/malidp_hw.c     |  25 +++++----
> > >  drivers/gpu/drm/arm/malidp_hw.h     |   2 +
> > >  drivers/gpu/drm/arm/malidp_planes.c | 109 +++++++++++++++++++++++++++++++-----
> > >  drivers/gpu/drm/arm/malidp_regs.h   |  20 +++++++
> > >  4 files changed, 130 insertions(+), 26 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
> > > index b9bed11..87b7b12 100644
> > > --- a/drivers/gpu/drm/arm/malidp_hw.c
> > > +++ b/drivers/gpu/drm/arm/malidp_hw.c
> > > @@ -94,11 +94,12 @@ static const struct malidp_layer malidp500_layers[] = {
> > >  	 *	yuv2rgb matrix offset, mmu control register offset, rotation_features
> > >  	 */
> > >  	{ DE_VIDEO1, MALIDP500_DE_LV_BASE, MALIDP500_DE_LV_PTR_BASE,
> > > -		MALIDP_DE_LV_STRIDE0, MALIDP500_LV_YUV2RGB, 0, ROTATE_ANY },
> > > +		MALIDP_DE_LV_STRIDE0, MALIDP500_LV_YUV2RGB, 0, ROTATE_ANY,
> > > +		MALIDP500_DE_LV_AD_CTRL },
> > >  	{ DE_GRAPHICS1, MALIDP500_DE_LG1_BASE, MALIDP500_DE_LG1_PTR_BASE,
> > > -		MALIDP_DE_LG_STRIDE, 0, 0, ROTATE_ANY },
> > > +		MALIDP_DE_LG_STRIDE, 0, 0, ROTATE_ANY, MALIDP500_DE_LG1_AD_CTRL },
> > >  	{ DE_GRAPHICS2, MALIDP500_DE_LG2_BASE, MALIDP500_DE_LG2_PTR_BASE,
> > > -		MALIDP_DE_LG_STRIDE, 0, 0, ROTATE_ANY },
> > > +		MALIDP_DE_LG_STRIDE, 0, 0, ROTATE_ANY, MALIDP500_DE_LG2_AD_CTRL },
> > >  };
> > >  
> > >  static const struct malidp_layer malidp550_layers[] = {
> > > @@ -106,13 +107,15 @@ static const struct malidp_layer malidp550_layers[] = {
> > >  	 *	yuv2rgb matrix offset, mmu control register offset, rotation_features
> > >  	 */
> > >  	{ DE_VIDEO1, MALIDP550_DE_LV1_BASE, MALIDP550_DE_LV1_PTR_BASE,
> > > -		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, 0, ROTATE_ANY },
> > > +		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, 0, ROTATE_ANY,
> > > +		MALIDP550_DE_LV1_AD_CTRL },
> > >  	{ DE_GRAPHICS1, MALIDP550_DE_LG_BASE, MALIDP550_DE_LG_PTR_BASE,
> > > -		MALIDP_DE_LG_STRIDE, 0, 0, ROTATE_ANY },
> > > +		MALIDP_DE_LG_STRIDE, 0, 0, ROTATE_ANY, MALIDP550_DE_LG_AD_CTRL },
> > >  	{ DE_VIDEO2, MALIDP550_DE_LV2_BASE, MALIDP550_DE_LV2_PTR_BASE,
> > > -		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, 0, ROTATE_ANY },
> > > +		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, 0, ROTATE_ANY,
> > > +		MALIDP550_DE_LV2_AD_CTRL },
> > >  	{ DE_SMART, MALIDP550_DE_LS_BASE, MALIDP550_DE_LS_PTR_BASE,
> > > -		MALIDP550_DE_LS_R1_STRIDE, 0, 0, ROTATE_NONE },
> > > +		MALIDP550_DE_LS_R1_STRIDE, 0, 0, ROTATE_NONE, 0 },
> > >  };
> > >  
> > >  static const struct malidp_layer malidp650_layers[] = {
> > > @@ -122,16 +125,16 @@ static const struct malidp_layer malidp650_layers[] = {
> > >  	 */
> > >  	{ DE_VIDEO1, MALIDP550_DE_LV1_BASE, MALIDP550_DE_LV1_PTR_BASE,
> > >  		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB,
> > > -		MALIDP650_DE_LV_MMU_CTRL, ROTATE_ANY },
> > > +		MALIDP650_DE_LV_MMU_CTRL, ROTATE_ANY, MALIDP550_DE_LV1_AD_CTRL },
> > >  	{ DE_GRAPHICS1, MALIDP550_DE_LG_BASE, MALIDP550_DE_LG_PTR_BASE,
> > >  		MALIDP_DE_LG_STRIDE, 0, MALIDP650_DE_LG_MMU_CTRL,
> > > -		ROTATE_COMPRESSED },
> > > +		ROTATE_COMPRESSED, MALIDP550_DE_LG_AD_CTRL },
> > >  	{ DE_VIDEO2, MALIDP550_DE_LV2_BASE, MALIDP550_DE_LV2_PTR_BASE,
> > >  		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB,
> > > -		MALIDP650_DE_LV_MMU_CTRL, ROTATE_ANY },
> > > +		MALIDP650_DE_LV_MMU_CTRL, ROTATE_ANY, MALIDP550_DE_LV2_AD_CTRL },
> > >  	{ DE_SMART, MALIDP550_DE_LS_BASE, MALIDP550_DE_LS_PTR_BASE,
> > >  		MALIDP550_DE_LS_R1_STRIDE, 0, MALIDP650_DE_LS_MMU_CTRL,
> > > -		ROTATE_NONE },
> > > +		ROTATE_NONE, 0 },
> > >  };
> > >  
> > >  #define SE_N_SCALING_COEFFS	96
> > > diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
> > > index 40155e2..651558f 100644
> > > --- a/drivers/gpu/drm/arm/malidp_hw.h
> > > +++ b/drivers/gpu/drm/arm/malidp_hw.h
> > > @@ -70,6 +70,8 @@ struct malidp_layer {
> > >  	s16 yuv2rgb_offset;	/* offset to the YUV->RGB matrix entries */
> > >  	u16 mmu_ctrl_offset;    /* offset to the MMU control register */
> > >  	enum rotation_features rot;	/* type of rotation supported */
> > > +	/* address offset for the AFBC decoder registers */
> > > +	u16 afbc_decoder_offset;
> > >  };
> > >  
> > >  enum malidp_scaling_coeff_set {
> > > diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
> > > index c9a6d3e..cd60f73 100644
> > > --- a/drivers/gpu/drm/arm/malidp_planes.c
> > > +++ b/drivers/gpu/drm/arm/malidp_planes.c
> > > @@ -592,6 +592,80 @@ static void malidp_de_set_mmu_control(struct malidp_plane *mp,
> > >  			mp->layer->base + mp->layer->mmu_ctrl_offset);
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
> > > +
> > > +	ptr = mp->layer->ptr + (plane_index << 4);
> > > +
> > > +	/*
> > > +	 * For AFBC buffers, cropping is handled by AFBC decoder rather than
> > > +	 * pointer manipulation.
> > > +	 */
> > 
> > I think this comment needs to go in malidp_de_plane_update, not in this function.
> > This function only updates the plane's base address.
> >
> I will reword the comment like this if it sounds sane :-
> 
> drm_fb_cma_get_gem_addr() alters the physical base address of the framebuffer
> as per the plane's src_x, src_y co-ordinates (ie to take care of source cropping).
> For AFBC, this is not needed as the cropping is handled by _AD_CROP_H
> and _AD_CROP_V registers.

Yeah, that sounds more in line with what the code does.

> 
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
> > > +	/* no afbc_decoder_offset means AFBC is not supported on this plane */
> > > +	if (!mp->layer->afbc_decoder_offset)
> > > +		return;
> > > +
> > > +	if (!fb->modifier) {
> > > +		malidp_hw_write(mp->hwdev, 0, mp->layer->afbc_decoder_offset);
> > > +		return;
> > > +	}
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
> > > @@ -600,30 +674,33 @@ static void malidp_de_plane_update(struct drm_plane *plane,
> > >  	struct drm_plane_state *state = plane->state;
> > >  	u16 pixel_alpha = state->pixel_blend_mode;
> > >  	u8 plane_alpha = state->alpha >> 8;
> > > +	bool format_has_alpha = state->fb->format->has_alpha;
> > >  	u32 src_w, src_h, dest_w, dest_h, val;
> > >  	int i;
> > > +	struct drm_framebuffer *fb = plane->state->fb;
> > >  
> > >  	mp = to_malidp_plane(plane);
> > >  
> > > -	/* convert src values from Q16 fixed point to integer */
> > > -	src_w = state->src_w >> 16;
> > > -	src_h = state->src_h >> 16;
> > > -	dest_w = state->crtc_w;
> > > -	dest_h = state->crtc_h;
> > > +	/* For AFBC framebuffer, use the framebuffer width and height for configuring
> > > +	 * layer input size register.
> > > +	 */
> > > +	if (fb->modifier) {
> > > +		src_w = fb->width;
> > > +		src_h = fb->height;
> > > +	} else {
> > > +		/* convert src values from Q16 fixed point to integer */
> > > +		src_w = ms->base.src_w >> 16;
> > > +		src_h = ms->base.src_h >> 16;
> > > +	}
> > > +	dest_w = ms->base.crtc_w;
> > > +	dest_h = ms->base.crtc_h;
> > 
> > These two lines above are equivalent to the last two lines you deleted. Why you need this change?
> > 
> Agreed, I will remove this change.
> > >  
> > >  	val = malidp_hw_read(mp->hwdev, mp->layer->base);
> > >  	val = (val & ~LAYER_FORMAT_MASK) | ms->format;
> > >  	malidp_hw_write(mp->hwdev, val, mp->layer->base);
> > >  
> > > -	for (i = 0; i < ms->n_planes; i++) {
> > > -		/* calculate the offset for the layer's plane registers */
> > > -		u16 ptr = mp->layer->ptr + (i << 4);
> > > -		dma_addr_t fb_addr = drm_fb_cma_get_gem_addr(state->fb,
> > > -							     state, i);
> > > -
> > > -		malidp_hw_write(mp->hwdev, lower_32_bits(fb_addr), ptr);
> > > -		malidp_hw_write(mp->hwdev, upper_32_bits(fb_addr), ptr + 4);
> > > -	}
> > > +	for (i = 0; i < ms->n_planes; i++)
> > > +		malidp_set_plane_base_addr(fb, mp, i);
> > >  
> > >  	malidp_de_set_mmu_control(mp, ms);
> > >  
> > > @@ -657,6 +734,8 @@ static void malidp_de_plane_update(struct drm_plane *plane,
> > >  				mp->layer->base + MALIDP550_LS_R1_IN_SIZE);
> > >  	}
> > >  
> > > +	malidp_de_set_plane_afbc(plane);
> > 
> > I feel like this function call should be done only if (fb->modifier) is
> > true.
> We need to call this function even is fb->modifier = 0. Please refer
> to the following snippet in malidp_de_set_plane_afbc()
> 
> if (!fb->modifier) {
>       malidp_hw_write(mp->hwdev, 0, mp->layer->afbc_decoder_offset);
>       return;
> }

Right, that is to reset the afbc_decoder_offset, correct? Still, it
would look a bit more obvious if the code looked like this here:

	if (!fb->modifier)
		malidp_hw_write(mp->hwdev, 0, mp->layer->afbc_decoder_offset);
	else
		malidp_de_set_plane_afbc(plane);

> I will prefer to keep all the AFBC register configuration in a single
> function.

But I agree, it is probably easier to keep them all together. Please
discard my previous comment.

Best regards,
Liviu

> 
> Thanks,
> Ayan Kumar Halder
> > 
> > > +
> > >  	/* first clear the rotation bits */
> > >  	val = malidp_hw_read(mp->hwdev, mp->layer->base + MALIDP_LAYER_CONTROL);
> > >  	val &= ~LAYER_ROT_MASK;
> > > @@ -674,7 +753,7 @@ static void malidp_de_plane_update(struct drm_plane *plane,
> > >  
> > >  	if (state->alpha != DRM_BLEND_ALPHA_OPAQUE) {
> > >  		val |= LAYER_COMP_PLANE;
> > > -	} else if (state->fb->format->has_alpha) {
> > > +	} else if (format_has_alpha) {
> > 
> > This change has nothing to do with AFBC, it should not be in this patch.
> > 
> > >  		/* We only care about blend mode if the format has alpha */
> > >  		switch (pixel_alpha) {
> > >  		case DRM_MODE_BLEND_PREMULTI:
> > > diff --git a/drivers/gpu/drm/arm/malidp_regs.h b/drivers/gpu/drm/arm/malidp_regs.h
> > > index 7ce3e14..a0dd6e1 100644
> > > --- a/drivers/gpu/drm/arm/malidp_regs.h
> > > +++ b/drivers/gpu/drm/arm/malidp_regs.h
> > > @@ -198,10 +198,13 @@
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
> > >  #define MALIDP500_SE_MEMWRITE_OUT_SIZE	0x00c2c
> > > @@ -228,10 +231,13 @@
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
> > > @@ -258,6 +264,20 @@
> > >  #define MALIDP_MMU_CTRL_PX_PS(x)	(1 << (8 + (x)))
> > >  #define MALIDP_MMU_CTRL_PP_NUM_REQ(x)	(((x) & 0x7f) << 12)
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
> > Best regards,
> > Liviu
> > 
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
