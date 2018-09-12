Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66ABC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5EA20833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5EA20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeILUpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:45:32 -0400
Received: from foss.arm.com ([217.140.101.70]:33974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbeILUpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:45:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADFAF7A9;
        Wed, 12 Sep 2018 08:40:27 -0700 (PDT)
Received: from DESKTOP-E1NTVVP.localdomain (desktop-e1ntvvp.cambridge.arm.com [10.1.34.160])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F9E73F5C0;
        Wed, 12 Sep 2018 08:40:25 -0700 (PDT)
Date:   Wed, 12 Sep 2018 16:40:17 +0100
From:   Brian Starkey <brian.starkey@arm.com>
To:     Liviu Dudau <liviu.dudau@arm.com>
Cc:     dri-devel@lists.freedesktop.org, daniel@fooishbar.org,
        airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        linux-kernel@vger.kernel.org, alexandru-cosmin.gheorghe@arm.com,
        ayan.halder@arm.com, tfiga@chromium.org, hoegsberg@chromium.org
Subject: Re: [RFC PATCH v2 1/3] drm/fourcc: Add 'bpp' field for formats with
 non-integer bytes-per-pixel
Message-ID: <20180912154016.GA22445@DESKTOP-E1NTVVP.localdomain>
References: <20180823152343.6474-1-brian.starkey@arm.com>
 <20180823152343.6474-2-brian.starkey@arm.com>
 <20180831081730.GM21634@phenom.ffwll.local>
 <20180907124535.GA3461@DESKTOP-E1NTVVP.localdomain>
 <20180907192626.GA7176@phenom.ffwll.local>
 <20180910085003.GA36@DESKTOP-E1NTVVP.localdomain>
 <20180910195325.GC19774@phenom.ffwll.local>
 <20180912152704.GF936@e110455-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180912152704.GF936@e110455-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 04:27:04PM +0100, Liviu Dudau wrote:
>On Mon, Sep 10, 2018 at 09:53:25PM +0200, Daniel Vetter wrote:
>> On Mon, Sep 10, 2018 at 09:50:03AM +0100, Brian Starkey wrote:
>> > Hi,
>> >
>> > On Fri, Sep 07, 2018 at 09:28:44PM +0200, Daniel Vetter wrote:
>> > > On Fri, Sep 07, 2018 at 01:45:36PM +0100, Brian Starkey wrote:
>> > > > Hi Daniel,
>> > > >
>> > > > On Fri, Aug 31, 2018 at 10:17:30AM +0200, Daniel Vetter wrote:
>> > > > > On Thu, Aug 23, 2018 at 04:23:41PM +0100, Brian Starkey wrote:
>> > > > > > Some formats have a non-integer number of bytes per pixel, which can't
>> > > > > > be handled with the existing 'cpp' field in drm_format_info. To handle
>> > > > > > these formats, add a 'bpp' field, which is only used if cpp[0] == 0.
>> > > > > >
>> > > > > > This updates all the users of format->cpp in the core DRM code,
>> > > > > > converting them to use a new function to get the bits-per-pixel for any
>> > > > > > format.
>> > > > > >
>> > > > > > It's assumed that drivers will use the 'bpp' field when they add support
>> > > > > > for pixel formats with non-integer bytes-per-pixel.
>> > > > > >
>> > > > > > Signed-off-by: Brian Starkey <brian.starkey@arm.com>
>> > > > >
>> > > > > I assume you still require that stuff is eventually aligned to bytes? In
>> > > > > that case, can we subsume this into the tile work Alex is doing? It's
>> > > > > essentially just another special case of having storage-size units
>> > > > > measured in bytes which span more than 1x1 pixel. And I kinda don't want a
>> > > > > metric pile of special cases here in the format code, because that just
>> > > > > means every driver handles a different subset, with different bugs.
>> > > > > -Daniel
>> > > >
>> > > > Sorry for the delay, been struggling to free some cycles to think
>> > > > about this.
>> > > >
>> > > > I'm not sure how to pull this in with the tiling stuff. In the AFBC
>> > > > case then our AFBC superblocks are always nice round numbers (256
>> > > > pixels), and so it does end up being a multiple of bytes.
>> > > >
>> > > > However, AFBC supports different superblock sizes, so picking just one
>> > > > doesn't really work out, and putting AFBC in the core format table
>> > > > which reflects AFBC doesn't seem good.
>> > > >
>> > > > We could make something up (e.g. call these formats "tiled" with 2x4
>> > > > tiles, which guarantees a multiple of 8), but it would be an
>> > > > arbitrarily-selected lie, which often seems to spell trouble. If we
>> > > > did do that, would you re-define cpp as "bytes-per-tile"? Otherwise
>> > > > we still need to add a new field anyway.
>> > > >
>> > > > What's the pile of special cases you're worried about? The helper I've
>> > > > added here means that drivers which need to care can use one API and
>> > > > not implement their own bugs.
>> > >
>> > > I'm confused ... the new bits-per-pixel stuff you're adding here is for
>> > > yuv formats, not afbc. I'm just suggesting we have only 1 way of
>> > > describing such formats that need more descriptive power than cpp, whether
>> > > they have some kind of pixel-groups or small tiles.
>> >
>> > Well, not really. The three formats which have non-integer cpp are:
>> > DRM_FORMAT_VUY101010, DRM_FORMAT_YUV420_8BIT and
>> > DRM_FORMAT_YUV420_10BIT. These formats are only valid with non-linear
>> > modifiers (no linear encoding is defined). Mali only supports them
>> > with AFBC.
>> >
>> > The formats themselves have no notion of tiling or grouping - the
>> > modifier adds that. I'm not aware of any non-AFBC uses of these
>> > formats, so I don't want to "make up" a small-tile layout restriction
>> > for them.
>>
>> Ah, I missed that.
>>
>> > > For very special stuff like afbc you need to validate in the driver
>> > > anyway, too complicated. So I have no idea why you bring this up here?
>> >
>> > Sure, we can just let drivers provide their own format_info's for
>> > these, if that's what you prefer. The core format checking code can
>> > error out if it ever encounters them.
>>
>> It's format_info we're talking about. What I mean is that you just set all
>> these to 0 and let the format_info code ignore it. And then having a
>> bespoke drm_format_check_afbc helper function or similar, which checks all
>> the layout restrictions of afbc.
>>
>> I still maintain that bpp and tile_size are equavalent, and we really
>> don't need both. Both are defacto a form of numerator/denumerator. If you
>> don't like that you have to introduce "fake" tiles for afbc, then we can
>> rename tile_size to numerator and tile_h/w to denumerator_h/w. Doesn't
>> change one bit of the math. bpp simply hardcodes a denumerator of 8, and I
>> don't see why we need that special case. Except if you love to write
>> redundant self tests for all the math :-)
>
>My $.02 worth of thoughts:
>
>I get the fact that Daniel doesn't like us to add 3 new variables into
>format_info (bpp, tile_w, tile_h) and that adding a "bits_per_unit"
>variable should be able to take care of linear (where unit = 1 pixel)
>and tiled (where unit = tile_w * tile_h pixels) formats. And I also see
>Daniel's option 2 below, where he says it is reasonable to check AFBC
>without using format_info.
>
>However, the problem we are trying to solve is 2 fold: we are trying to
>calculate the size of the framebuffer (and the "bits_per_unit" or
>Brian's bpp is useful for that), but we also try to validate the sizes
>passed by userspace based on the drm_fourcc.h+modifier info. In that
>case, the driver still needs to store somewhere the tile_w/tile_h for
>that given format in order to check that the stride is a whole multiple
>of tile sizes, so we thought that putting it in format_info is not
>entirely pointless, because others might use those variables in order to
>do their driver specific validation, without creating new structures.

Even if we only wanted to do one of those things (calculate the size
in bytes of the framebuffer), we need to know the bits_per_unit, as
well as the number of units. Without the second (+third) variables, we
can't figure out number of units and so we can't figure out the size.

Separate point: modifiers certainly shouldn't come in to this
discussion - modifier-related validation is always going to need to be
in the driver, and is a separate thing entirely (not contained in
drm_format_info).

>
>Did I capture the discussion correctly? If so, can we agree that it is
>not just the framebuffer size calculation that matters and that tiled
>formats validation requires a tile_w/tile_h info, therefore Alex's
>patches and Brian's need to be discussed separately (so that we can
>bikeshed on whether format_info is the right place or not)?

It looks to me that the right thing to do is set cpp to zero for the
"non integer" formats I want to add, and entirely defer to drivers to
figure those out (after all, any size calculation the core does for
them will be moot, because they are only valid with modifiers, and
modifiers can change the size).

How the tiled stuff (Y0L0, Y0L2) gets described can be a separate
topic. If it happens to support non-integer cpp formats as a side
effect, then more the better - when someone comes along with a
non-integer-cpp format which actually _is_ supported in linear layout
they can use it. I hope Daniel can describe in more detail exactly how
he sees that bit working though, because I don't think that either
Alex or me understand that yet.

Cheers,
-Brian

>
>Best regards,
>Liviu
>
>>
>> So two options that I think are reasonable:
>> - one common numerator/denumerator. I don't care how you call that
>>   bikeshed.
>> - don't check afbc using format_info, have your own helper that does that
>>   using custom code.
>>
>> Cheers, Daniel
>>
>> > Cheers,
>> > -Brian
>> >
>> > > -Daniel
>> > >
>> > > >
>> > > > Cheers,
>> > > > -Brian
>> > > >
>> > > > >
>> > > > > > ---
>> > > > > >  drivers/gpu/drm/drm_fb_cma_helper.c          |  6 +++-
>> > > > > >  drivers/gpu/drm/drm_fb_helper.c              |  8 +++--
>> > > > > >  drivers/gpu/drm/drm_fourcc.c                 | 50 ++++++++++++++++++++++++++++
>> > > > > >  drivers/gpu/drm/drm_framebuffer.c            |  8 ++---
>> > > > > >  drivers/gpu/drm/drm_gem_framebuffer_helper.c |  3 +-
>> > > > > >  include/drm/drm_fourcc.h                     |  4 +++
>> > > > > >  6 files changed, 70 insertions(+), 9 deletions(-)
>> > > > > >
>> > > > > > diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb_cma_helper.c
>> > > > > > index 186d00adfb5f..e279d70d3e60 100644
>> > > > > > --- a/drivers/gpu/drm/drm_fb_cma_helper.c
>> > > > > > +++ b/drivers/gpu/drm/drm_fb_cma_helper.c
>> > > > > > @@ -118,13 +118,17 @@ dma_addr_t drm_fb_cma_get_gem_addr(struct drm_framebuffer *fb,
>> > > > > >  {
>> > > > > >  	struct drm_gem_cma_object *obj;
>> > > > > >  	dma_addr_t paddr;
>> > > > > > +	u8 bpp = drm_format_info_plane_bpp(fb->format, plane);
>> > > > > > +
>> > > > > > +	/* This can't work for non-integer bytes-per-pixel */
>> > > > > > +	WARN_ON(bpp % 8);
>> > > > > >
>> > > > > >  	obj = drm_fb_cma_get_gem_obj(fb, plane);
>> > > > > >  	if (!obj)
>> > > > > >  		return 0;
>> > > > > >
>> > > > > >  	paddr = obj->paddr + fb->offsets[plane];
>> > > > > > -	paddr += fb->format->cpp[plane] * (state->src_x >> 16);
>> > > > > > +	paddr += (bpp / 8) * (state->src_x >> 16);
>> > > > > >  	paddr += fb->pitches[plane] * (state->src_y >> 16);
>> > > > > >
>> > > > > >  	return paddr;
>> > > > > > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
>> > > > > > index 0646b108030b..ab369f250af4 100644
>> > > > > > --- a/drivers/gpu/drm/drm_fb_helper.c
>> > > > > > +++ b/drivers/gpu/drm/drm_fb_helper.c
>> > > > > > @@ -1572,6 +1572,7 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
>> > > > > >  	struct drm_fb_helper *fb_helper = info->par;
>> > > > > >  	struct drm_framebuffer *fb = fb_helper->fb;
>> > > > > >  	int depth;
>> > > > > > +	u8 bpp = drm_format_info_plane_bpp(fb->format, 0);
>> > > > > >
>> > > > > >  	if (var->pixclock != 0 || in_dbg_master())
>> > > > > >  		return -EINVAL;
>> > > > > > @@ -1580,14 +1581,14 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
>> > > > > >  	 * Changes struct fb_var_screeninfo are currently not pushed back
>> > > > > >  	 * to KMS, hence fail if different settings are requested.
>> > > > > >  	 */
>> > > > > > -	if (var->bits_per_pixel != fb->format->cpp[0] * 8 ||
>> > > > > > +	if (var->bits_per_pixel != bpp ||
>> > > > > >  	    var->xres > fb->width || var->yres > fb->height ||
>> > > > > >  	    var->xres_virtual > fb->width || var->yres_virtual > fb->height) {
>> > > > > >  		DRM_DEBUG("fb requested width/height/bpp can't fit in current fb "
>> > > > > >  			  "request %dx%d-%d (virtual %dx%d) > %dx%d-%d\n",
>> > > > > >  			  var->xres, var->yres, var->bits_per_pixel,
>> > > > > >  			  var->xres_virtual, var->yres_virtual,
>> > > > > > -			  fb->width, fb->height, fb->format->cpp[0] * 8);
>> > > > > > +			  fb->width, fb->height, bpp);
>> > > > > >  		return -EINVAL;
>> > > > > >  	}
>> > > > > >
>> > > > > > @@ -1949,11 +1950,12 @@ void drm_fb_helper_fill_var(struct fb_info *info, struct drm_fb_helper *fb_helpe
>> > > > > >  			    uint32_t fb_width, uint32_t fb_height)
>> > > > > >  {
>> > > > > >  	struct drm_framebuffer *fb = fb_helper->fb;
>> > > > > > +	u8 bpp = drm_format_info_plane_bpp(fb->format, 0);
>> > > > > >
>> > > > > >  	info->pseudo_palette = fb_helper->pseudo_palette;
>> > > > > >  	info->var.xres_virtual = fb->width;
>> > > > > >  	info->var.yres_virtual = fb->height;
>> > > > > > -	info->var.bits_per_pixel = fb->format->cpp[0] * 8;
>> > > > > > +	info->var.bits_per_pixel = bpp;
>> > > > > >  	info->var.accel_flags = FB_ACCELF_TEXT;
>> > > > > >  	info->var.xoffset = 0;
>> > > > > >  	info->var.yoffset = 0;
>> > > > > > diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
>> > > > > > index 3b42c25bd58d..bb28919c32f3 100644
>> > > > > > --- a/drivers/gpu/drm/drm_fourcc.c
>> > > > > > +++ b/drivers/gpu/drm/drm_fourcc.c
>> > > > > > @@ -272,10 +272,60 @@ int drm_format_plane_cpp(uint32_t format, int plane)
>> > > > > >  	if (!info || plane >= info->num_planes)
>> > > > > >  		return 0;
>> > > > > >
>> > > > > > +	/*
>> > > > > > +	 * Not valid for formats with non-integer cpp,
>> > > > > > +	 * use drm_format{_info}_plane_bpp instead
>> > > > > > +	 */
>> > > > > > +	WARN_ON(!info->cpp[0]);
>> > > > > > +
>> > > > > >  	return info->cpp[plane];
>> > > > > >  }
>> > > > > >  EXPORT_SYMBOL(drm_format_plane_cpp);
>> > > > > >
>> > > > > > +/**
>> > > > > > + * drm_format_plane_bpp - determine the bits per pixel value
>> > > > > > + * @format: pixel format (DRM_FORMAT_*)
>> > > > > > + * @plane: plane index
>> > > > > > + *
>> > > > > > + * Returns:
>> > > > > > + * The bits per pixel value for the specified plane.
>> > > > > > + */
>> > > > > > +int drm_format_plane_bpp(uint32_t format, int plane)
>> > > > > > +{
>> > > > > > +	const struct drm_format_info *info;
>> > > > > > +
>> > > > > > +	info = drm_format_info(format);
>> > > > > > +	if (!info)
>> > > > > > +		return 0;
>> > > > > > +
>> > > > > > +	return drm_format_info_plane_bpp(info, plane);
>> > > > > > +}
>> > > > > > +EXPORT_SYMBOL(drm_format_plane_bpp);
>> > > > > > +
>> > > > > > +/**
>> > > > > > + * drm_format_info_plane_bpp - determine the bits per pixel value
>> > > > > > + *
>> > > > > > + * Convenience function which handles formats with both integer
>> > > > > > + * and non-integer bytes-per-pixel.
>> > > > > > + *
>> > > > > > + * @format: pixel format info structure
>> > > > > > + * @plane: plane index
>> > > > > > + *
>> > > > > > + * Returns:
>> > > > > > + * The bits per pixel value for the specified plane.
>> > > > > > + */
>> > > > > > +int drm_format_info_plane_bpp(const struct drm_format_info *info, int plane)
>> > > > > > +{
>> > > > > > +	if (plane >= info->num_planes)
>> > > > > > +		return 0;
>> > > > > > +
>> > > > > > +	if (info->cpp[0])
>> > > > > > +		return info->cpp[plane] * 8;
>> > > > > > +
>> > > > > > +	return info->bpp[plane];
>> > > > > > +}
>> > > > > > +EXPORT_SYMBOL(drm_format_info_plane_bpp);
>> > > > > > +
>> > > > > >  /**
>> > > > > >   * drm_format_horz_chroma_subsampling - get the horizontal chroma subsampling factor
>> > > > > >   * @format: pixel format (DRM_FORMAT_*)
>> > > > > > diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
>> > > > > > index 8c4d32adcc17..7e00360ff70d 100644
>> > > > > > --- a/drivers/gpu/drm/drm_framebuffer.c
>> > > > > > +++ b/drivers/gpu/drm/drm_framebuffer.c
>> > > > > > @@ -185,20 +185,20 @@ static int framebuffer_check(struct drm_device *dev,
>> > > > > >  	for (i = 0; i < info->num_planes; i++) {
>> > > > > >  		unsigned int width = fb_plane_width(r->width, info, i);
>> > > > > >  		unsigned int height = fb_plane_height(r->height, info, i);
>> > > > > > -		unsigned int cpp = info->cpp[i];
>> > > > > > +		unsigned int bpp = drm_format_info_plane_bpp(info, i);
>> > > > > >
>> > > > > >  		if (!r->handles[i]) {
>> > > > > >  			DRM_DEBUG_KMS("no buffer object handle for plane %d\n", i);
>> > > > > >  			return -EINVAL;
>> > > > > >  		}
>> > > > > >
>> > > > > > -		if ((uint64_t) width * cpp > UINT_MAX)
>> > > > > > +		if ((uint64_t) DIV_ROUND_UP(width * bpp, 8) > UINT_MAX)
>> > > > > >  			return -ERANGE;
>> > > > > >
>> > > > > >  		if ((uint64_t) height * r->pitches[i] + r->offsets[i] > UINT_MAX)
>> > > > > >  			return -ERANGE;
>> > > > > >
>> > > > > > -		if (r->pitches[i] < width * cpp) {
>> > > > > > +		if ((uint64_t) r->pitches[i] * 8 < (uint64_t) width * bpp) {
>> > > > > >  			DRM_DEBUG_KMS("bad pitch %u for plane %d\n", r->pitches[i], i);
>> > > > > >  			return -EINVAL;
>> > > > > >  		}
>> > > > > > @@ -476,7 +476,7 @@ int drm_mode_getfb(struct drm_device *dev,
>> > > > > >  	r->height = fb->height;
>> > > > > >  	r->width = fb->width;
>> > > > > >  	r->depth = fb->format->depth;
>> > > > > > -	r->bpp = fb->format->cpp[0] * 8;
>> > > > > > +	r->bpp = drm_format_info_plane_bpp(fb->format, 0);
>> > > > > >  	r->pitch = fb->pitches[0];
>> > > > > >
>> > > > > >  	/* GET_FB() is an unprivileged ioctl so we must not return a
>> > > > > > diff --git a/drivers/gpu/drm/drm_gem_framebuffer_helper.c b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
>> > > > > > index acfbc0641a06..dfe224ccaeba 100644
>> > > > > > --- a/drivers/gpu/drm/drm_gem_framebuffer_helper.c
>> > > > > > +++ b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
>> > > > > > @@ -161,6 +161,7 @@ drm_gem_fb_create_with_funcs(struct drm_device *dev, struct drm_file *file,
>> > > > > >  		unsigned int width = mode_cmd->width / (i ? info->hsub : 1);
>> > > > > >  		unsigned int height = mode_cmd->height / (i ? info->vsub : 1);
>> > > > > >  		unsigned int min_size;
>> > > > > > +		u8 bpp = drm_format_info_plane_bpp(fb->format, i);
>> > > > > >
>> > > > > >  		objs[i] = drm_gem_object_lookup(file, mode_cmd->handles[i]);
>> > > > > >  		if (!objs[i]) {
>> > > > > > @@ -170,7 +171,7 @@ drm_gem_fb_create_with_funcs(struct drm_device *dev, struct drm_file *file,
>> > > > > >  		}
>> > > > > >
>> > > > > >  		min_size = (height - 1) * mode_cmd->pitches[i]
>> > > > > > -			 + width * info->cpp[i]
>> > > > > > +			 + DIV_ROUND_UP(width * bpp, 8)
>> > > > > >  			 + mode_cmd->offsets[i];
>> > > > > >
>> > > > > >  		if (objs[i]->size < min_size) {
>> > > > > > diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
>> > > > > > index 3e86408dac9f..d4af4dab1623 100644
>> > > > > > --- a/include/drm/drm_fourcc.h
>> > > > > > +++ b/include/drm/drm_fourcc.h
>> > > > > > @@ -36,6 +36,7 @@ struct drm_mode_fb_cmd2;
>> > > > > >   *	use in new code and set to 0 for new formats.
>> > > > > >   * @num_planes: Number of color planes (1 to 3)
>> > > > > >   * @cpp: Number of bytes per pixel (per plane)
>> > > > > > + * @bpp: Number of bits per pixel (per plane), only valid if cpp[0] == 0.
>> > > > > >   * @hsub: Horizontal chroma subsampling factor
>> > > > > >   * @vsub: Vertical chroma subsampling factor
>> > > > > >   * @has_alpha: Does the format embeds an alpha component?
>> > > > > > @@ -45,6 +46,7 @@ struct drm_format_info {
>> > > > > >  	u8 depth;
>> > > > > >  	u8 num_planes;
>> > > > > >  	u8 cpp[3];
>> > > > > > +	u8 bpp[3];
>> > > > > >  	u8 hsub;
>> > > > > >  	u8 vsub;
>> > > > > >  	bool has_alpha;
>> > > > > > @@ -66,6 +68,8 @@ drm_get_format_info(struct drm_device *dev,
>> > > > > >  uint32_t drm_mode_legacy_fb_format(uint32_t bpp, uint32_t depth);
>> > > > > >  int drm_format_num_planes(uint32_t format);
>> > > > > >  int drm_format_plane_cpp(uint32_t format, int plane);
>> > > > > > +int drm_format_plane_bpp(uint32_t format, int plane);
>> > > > > > +int drm_format_info_plane_bpp(const struct drm_format_info *format, int plane);
>> > > > > >  int drm_format_horz_chroma_subsampling(uint32_t format);
>> > > > > >  int drm_format_vert_chroma_subsampling(uint32_t format);
>> > > > > >  int drm_format_plane_width(int width, uint32_t format, int plane);
>> > > > > > --
>> > > > > > 2.16.1
>> > > > > >
>> > > > >
>> > > > > --
>> > > > > Daniel Vetter
>> > > > > Software Engineer, Intel Corporation
>> > > > > http://blog.ffwll.ch
>> > >
>> > > --
>> > > Daniel Vetter
>> > > Software Engineer, Intel Corporation
>> > > http://blog.ffwll.ch
>> > _______________________________________________
>> > dri-devel mailing list
>> > dri-devel@lists.freedesktop.org
>> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
>> --
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> http://blog.ffwll.ch
>
>-- 
>====================
>| I would like to |
>| fix the world,  |
>| but they're not |
>| giving me the   |
> \ source code!  /
>  ---------------
>    ¯\_(ツ)_/¯
