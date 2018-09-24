Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB53C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE3A2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE3A2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbeIXVFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:05:20 -0400
Received: from foss.arm.com ([217.140.101.70]:37288 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729395AbeIXVFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:05:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B93AA80D;
        Mon, 24 Sep 2018 08:02:42 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6648A3F5B7;
        Mon, 24 Sep 2018 08:02:42 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id C082B6805AB; Mon, 24 Sep 2018 16:02:40 +0100 (BST)
Date:   Mon, 24 Sep 2018 16:02:40 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>
Cc:     Brian Starkey <Brian.Starkey@arm.com>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, nd <nd@arm.com>
Subject: Re: [PATCH v2] drm/arm/malidp: Validate rotations for
 compressed/uncompressed framebuffers for each layer
Message-ID: <20180924150240.GD936@e110455-lin.cambridge.arm.com>
References: <20180615124654.GD15072@e110455-lin.cambridge.arm.com>
 <20180921143353.15943-1-Liviu.Dudau@arm.com>
 <20180924144012.GA7942@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180924144012.GA7942@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 03:40:15PM +0100, Ayan Halder wrote:
> Hi Liviu,

Hi Ayan,

> 
> On Fri, Sep 21, 2018 at 03:33:53PM +0100, Liviu Dudau wrote:
> > From: Ayan Kumar Halder <ayan.halder@arm.com>
> > 
> > Add support for compressed framebuffers that are described using
> > the framebuffer's modifier field. Mali DP uses the rotation memory for
> > the decompressor of the format, so we need to check for space when
> > the modifiers are present.
> > 
> > Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
> > Reviewed-by: Brian Starkey <brian.starkey@arm.com>
> > [re-worded commit, rebased, cleaned up duplicated checks for
> >  RGB888 and BGR888 and removed additional parameter for
> >  rotmem_required function hook]
> > Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
> > ---
> >  drivers/gpu/drm/arm/malidp_crtc.c   | 28 ++++++++++++---------
> >  drivers/gpu/drm/arm/malidp_hw.c     | 38 ++++++++++++-----------------
> >  drivers/gpu/drm/arm/malidp_hw.h     |  7 ++++++
> >  drivers/gpu/drm/arm/malidp_planes.c | 19 +++++++++++----
> >  4 files changed, 53 insertions(+), 39 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/malidp_crtc.c
> > index ef44202fb43f8..e1b72782848c3 100644
> > --- a/drivers/gpu/drm/arm/malidp_crtc.c
> > +++ b/drivers/gpu/drm/arm/malidp_crtc.c
> > @@ -348,19 +348,20 @@ static int malidp_crtc_atomic_check(struct drm_crtc *crtc,
> >  
> >  	/*
> >  	 * check if there is enough rotation memory available for planes
> > -	 * that need 90?? and 270?? rotation. Each plane has set its required
> > -	 * memory size in the ->plane_check() callback, here we only make
> > -	 * sure that the sums are less that the total usable memory.
> > +	 * that need 90?? and 270?? rotion or planes that are compressed.
> > +	 * Each plane has set its required memory size in the ->plane_check()
> > +	 * callback, here we only make sure that the sums are less that the
> > +	 * total usable memory.
> >  	 *
> >  	 * The rotation memory allocation algorithm (for each plane):
> > -	 *  a. If no more rotated planes exist, all remaining rotate
> > -	 *     memory in the bank is available for use by the plane.
> > -	 *  b. If other rotated planes exist, and plane's layer ID is
> > -	 *     DE_VIDEO1, it can use all the memory from first bank if
> > -	 *     secondary rotation memory bank is available, otherwise it can
> > +	 *  a. If no more rotated or compressed planes exist, all remaining
> > +	 *     rotate memory in the bank is available for use by the plane.
> > +	 *  b. If other rotated or compressed planes exist, and plane's
> > +	 *     layer ID is DE_VIDEO1, it can use all the memory from first bank
> > +	 *     if secondary rotation memory bank is available, otherwise it can
> >  	 *     use up to half the bank's memory.
> > -	 *  c. If other rotated planes exist, and plane's layer ID is not
> > -	 *     DE_VIDEO1, it can use half of the available memory
> > +	 *  c. If other rotated or compressed planes exist, and plane's layer ID
> > +	 *     is not DE_VIDEO1, it can use half of the available memory.
> >  	 *
> >  	 * Note: this algorithm assumes that the order in which the planes are
> >  	 * checked always has DE_VIDEO1 plane first in the list if it is
> > @@ -372,7 +373,9 @@ static int malidp_crtc_atomic_check(struct drm_crtc *crtc,
> >  
> >  	/* first count the number of rotated planes */
> >  	drm_atomic_crtc_state_for_each_plane_state(plane, pstate, state) {
> > -		if (pstate->rotation & MALIDP_ROTATED_MASK)
> > +		struct drm_framebuffer *fb = pstate->fb;
> > +
> > +		if ((pstate->rotation & MALIDP_ROTATED_MASK) || fb->modifier)
> >  			rotated_planes++;
> >  	}
> >  
> > @@ -388,8 +391,9 @@ static int malidp_crtc_atomic_check(struct drm_crtc *crtc,
> >  	drm_atomic_crtc_state_for_each_plane_state(plane, pstate, state) {
> >  		struct malidp_plane *mp = to_malidp_plane(plane);
> >  		struct malidp_plane_state *ms = to_malidp_plane_state(pstate);
> > +		struct drm_framebuffer *fb = pstate->fb;
> >  
> > -		if (pstate->rotation & MALIDP_ROTATED_MASK) {
> > +		if ((pstate->rotation & MALIDP_ROTATED_MASK) || fb->modifier) {
> >  			/* process current plane */
> >  			rotated_planes--;
> >  
> > diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
> > index b33000634a4ee..5549092e6c36a 100644
> > --- a/drivers/gpu/drm/arm/malidp_hw.c
> > +++ b/drivers/gpu/drm/arm/malidp_hw.c
> > @@ -85,41 +85,43 @@ static const struct malidp_format_id malidp550_de_formats[] = {
> >  
> >  static const struct malidp_layer malidp500_layers[] = {
> >  	/*  id, base address, fb pointer address base, stride offset,
> > -		yuv2rgb matrix offset, mmu control register offset */
> > +	    yuv2rgb matrix offset, mmu control register offset, rotation_features */
> >  	{ DE_VIDEO1, MALIDP500_DE_LV_BASE, MALIDP500_DE_LV_PTR_BASE,
> > -		MALIDP_DE_LV_STRIDE0, MALIDP500_LV_YUV2RGB, 0 },
> > +		MALIDP_DE_LV_STRIDE0, MALIDP500_LV_YUV2RGB, 0, ROTATE_ANY },
> >  	{ DE_GRAPHICS1, MALIDP500_DE_LG1_BASE, MALIDP500_DE_LG1_PTR_BASE,
> > -		MALIDP_DE_LG_STRIDE, 0, 0 },
> > +		MALIDP_DE_LG_STRIDE, 0, 0, ROTATE_ANY },
> >  	{ DE_GRAPHICS2, MALIDP500_DE_LG2_BASE, MALIDP500_DE_LG2_PTR_BASE,
> > -		MALIDP_DE_LG_STRIDE, 0, 0 },
> > +		MALIDP_DE_LG_STRIDE, 0, 0, ROTATE_ANY },
> >  };
> >  
> >  static const struct malidp_layer malidp550_layers[] = {
> >  	/*  id, base address, fb pointer address base, stride offset,
> > -		yuv2rgb matrix offset, mmu control register offset */
> > +		yuv2rgb matrix offset, mmu control register offset, rotation_features */
> >  	{ DE_VIDEO1, MALIDP550_DE_LV1_BASE, MALIDP550_DE_LV1_PTR_BASE,
> > -		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, 0 },
> > +		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, 0, ROTATE_ANY },
> >  	{ DE_GRAPHICS1, MALIDP550_DE_LG_BASE, MALIDP550_DE_LG_PTR_BASE,
> > -		MALIDP_DE_LG_STRIDE, 0, 0 },
> > +		MALIDP_DE_LG_STRIDE, 0, 0, ROTATE_ANY },
> >  	{ DE_VIDEO2, MALIDP550_DE_LV2_BASE, MALIDP550_DE_LV2_PTR_BASE,
> > -		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, 0 },
> > +		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, 0, ROTATE_ANY },
> >  	{ DE_SMART, MALIDP550_DE_LS_BASE, MALIDP550_DE_LS_PTR_BASE,
> > -		MALIDP550_DE_LS_R1_STRIDE, 0, 0 },
> > +		MALIDP550_DE_LS_R1_STRIDE, 0, 0, ROTATE_NONE },
> >  };
> >  
> >  static const struct malidp_layer malidp650_layers[] = {
> >  	/*  id, base address, fb pointer address base, stride offset,
> > -		yuv2rgb matrix offset, mmu control register offset */
> > +		yuv2rgb matrix offset, mmu control register offset, rotation_features */
> >  	{ DE_VIDEO1, MALIDP550_DE_LV1_BASE, MALIDP550_DE_LV1_PTR_BASE,
> >  		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB,
> > -		MALIDP650_DE_LV_MMU_CTRL },
> > +		MALIDP650_DE_LV_MMU_CTRL, ROTATE_ANY },
> >  	{ DE_GRAPHICS1, MALIDP550_DE_LG_BASE, MALIDP550_DE_LG_PTR_BASE,
> > -		MALIDP_DE_LG_STRIDE, 0, MALIDP650_DE_LG_MMU_CTRL },
> > +		MALIDP_DE_LG_STRIDE, 0, MALIDP650_DE_LG_MMU_CTRL,
> > +		ROTATE_COMPRESSED },
> >  	{ DE_VIDEO2, MALIDP550_DE_LV2_BASE, MALIDP550_DE_LV2_PTR_BASE,
> >  		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB,
> > -		MALIDP650_DE_LV_MMU_CTRL },
> > +		MALIDP650_DE_LV_MMU_CTRL, ROTATE_ANY },
> >  	{ DE_SMART, MALIDP550_DE_LS_BASE, MALIDP550_DE_LS_PTR_BASE,
> > -		MALIDP550_DE_LS_R1_STRIDE, 0, MALIDP650_DE_LS_MMU_CTRL },
> > +		MALIDP550_DE_LS_R1_STRIDE, 0, MALIDP650_DE_LS_MMU_CTRL,
> > +		ROTATE_NONE },
> >  };
> >  
> >  #define SE_N_SCALING_COEFFS	96
> > @@ -314,10 +316,6 @@ static void malidp500_modeset(struct malidp_hw_device *hwdev, struct videomode *
> >  
> >  static int malidp500_rotmem_required(struct malidp_hw_device *hwdev, u16 w, u16 h, u32 fmt)
> >  {
> > -	/* RGB888 or BGR888 can't be rotated */
> > -	if ((fmt == DRM_FORMAT_RGB888) || (fmt == DRM_FORMAT_BGR888))
> > -		return -EINVAL;
> > -
> >  	/*
> >  	 * Each layer needs enough rotation memory to fit 8 lines
> >  	 * worth of pixel data. Required size is then:
> > @@ -605,10 +603,6 @@ static int malidp550_rotmem_required(struct malidp_hw_device *hwdev, u16 w, u16
> >  {
> >  	u32 bytes_per_col;
> >  
> > -	/* raw RGB888 or BGR888 can't be rotated */
> > -	if ((fmt == DRM_FORMAT_RGB888) || (fmt == DRM_FORMAT_BGR888))
> > -		return -EINVAL;
> > -
> >  	switch (fmt) {
> >  	/* 8 lines at 4 bytes per pixel */
> >  	case DRM_FORMAT_ARGB2101010:
> > diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
> > index 0d7f9ea0ade89..3ab133d49bbad 100644
> > --- a/drivers/gpu/drm/arm/malidp_hw.h
> > +++ b/drivers/gpu/drm/arm/malidp_hw.h
> > @@ -36,6 +36,12 @@ enum {
> >  	SE_MEMWRITE = BIT(5),
> >  };
> >  
> > +enum rotation_features {
> > +	ROTATE_NONE,		/* does not support rotation at all */
> > +	ROTATE_ANY,		/* supports rotation on any buffers */
> > +	ROTATE_COMPRESSED,	/* supports rotation only on compressed buffers */
> > +};
> > +
> >  struct malidp_format_id {
> >  	u32 format;		/* DRM fourcc */
> >  	u8 layer;		/* bitmask of layers supporting it */
> > @@ -63,6 +69,7 @@ struct malidp_layer {
> >  	u16 stride_offset;	/* offset to the first stride register. */
> >  	s16 yuv2rgb_offset;	/* offset to the YUV->RGB matrix entries */
> >  	u16 mmu_ctrl_offset;    /* offset to the MMU control register */
> > +	enum rotation_features rot;	/* type of rotation supported */
> >  };
> >  
> >  enum malidp_scaling_coeff_set {
> > diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
> > index c21b44effa5a7..36d2952774b22 100644
> > --- a/drivers/gpu/drm/arm/malidp_planes.c
> > +++ b/drivers/gpu/drm/arm/malidp_planes.c
> > @@ -433,11 +433,20 @@ static int malidp_de_plane_check(struct drm_plane *plane,
> >  	if (ret)
> >  		return ret;
> >  
> > -	/* packed RGB888 / BGR888 can't be rotated or flipped */
> > -	if (state->rotation != DRM_MODE_ROTATE_0 &&
> > -	    (fb->format->format == DRM_FORMAT_RGB888 ||
> > -	     fb->format->format == DRM_FORMAT_BGR888))
> > -		return -EINVAL;
> > +	/* validate the rotation constraints for each layer */
> > +	if (state->rotation != DRM_MODE_ROTATE_0) {
> > +		if (mp->layer->rot == ROTATE_NONE)
> > +			return -EINVAL;
> > +		if ((mp->layer->rot == ROTATE_COMPRESSED) && !!(fb->modifier))
> This should be !(fb->modifier) because the driver should return EINVAL
> when the layer supports only compressed rotation and no framebuffer
> modifiers (which denotes compression) have been provided.
> > +			return -EINVAL;
> > +		/*
> > +		 * packed RGB888 / BGR888 can't be rotated or flipped
> > +		 * unless they are stored in a compressed way
> > +		 */
> > +		if ((fb->format->format == DRM_FORMAT_RGB888 ||
> > +		     fb->format->format == DRM_FORMAT_BGR888) && !!(fb->modifier))
> This should also be !(fb->modifier)

Thanks for reviewing this! I have made the changes in the internal tree
and will push the patches into the public mali-dp tree soon.

Best regards,
Liviu

> > +			return -EINVAL;
> > +	}
> >  
> >  	ms->rotmem_size = 0;
> >  	if (state->rotation & MALIDP_ROTATED_MASK) {
> > -- 
> > 2.18.0

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
