Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6980C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1212083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="YR/w3Cfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1212083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbeHaMX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:23:57 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45282 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeHaMXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:23:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id p52-v6so8411979eda.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 01:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mRtPTQYJgZhS7zaHnrfjv01XM0VrGxtJGydDcnhy69M=;
        b=YR/w3Cfofs9DVyLyHtGzMs2HSxjICKt0jrKpP1RcQg4Kr+mhnAH3FDJJkhcWNslRQQ
         ruxaBF5Oj+Ej35S6eMY9aMg2B1UOHzNTChHIn57cq3Hf41n+qEPlFLrqgtIG6detlPRR
         p5r0ZKMxVRi86bMQKRpubgpvLicwc9Ajc0N4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=mRtPTQYJgZhS7zaHnrfjv01XM0VrGxtJGydDcnhy69M=;
        b=BEFbpgJU5Bkv5NRjkcYMuRlywUP3FsnhMvwmeke3oulK6VCrNro0ivqA5sg5j6Zzd/
         1bWvH2+ZgY9EfNXpCWSdC6Zh3UkK/rkoj7iraM8zSMaXCkiFu8gVVT11Z+aBOi6thLRy
         gK41ARWcDR9rqd2Ur/+8rx2UCsXQcKzPuUTLakaKFqC6VMiwKfvXXEczULG+htlAFJH5
         TJm6mzlKWvMXjqv3N051L8vVkknUc01ozkT0VSmRCJwQIjBWuuuL9+AR9qo98sI86rnS
         ZtUAPn6s8b1O2BcYjSpkWtlNTtYo6CaBJY3Qb8Fw7dXJwHy2U6/rJ+3PB1QMASqbKiFG
         /Q6w==
X-Gm-Message-State: APzg51BZaeCN/BTnci5CRoXgqj6k0cdm3w5T5JyIZRq2mQBgt+a0kLqw
        dDdTqQSwY89B8o3H8SKc8osu1w==
X-Google-Smtp-Source: ANB0VdZoeqzzb1UGo9w+fo/EiUEm+oPEs9SA4SzOQk6lGu9AYKDuMfjv33vjZsQ/bqRjKc3fcgPZ8g==
X-Received: by 2002:a05:6402:1348:: with SMTP id y8mr16710351edw.222.1535703453418;
        Fri, 31 Aug 2018 01:17:33 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-109.fiber7.init7.net. [212.51.149.109])
        by smtp.gmail.com with ESMTPSA id f26-v6sm3997296edb.28.2018.08.31.01.17.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 01:17:32 -0700 (PDT)
Date:   Fri, 31 Aug 2018 10:17:30 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Brian Starkey <brian.starkey@arm.com>
Cc:     dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        daniel@fooishbar.org, airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        linux-kernel@vger.kernel.org, alexandru-cosmin.gheorghe@arm.com,
        liviu.dudau@arm.com, ayan.halder@arm.com, tfiga@chromium.org,
        hoegsberg@chromium.org
Subject: Re: [RFC PATCH v2 1/3] drm/fourcc: Add 'bpp' field for formats with
 non-integer bytes-per-pixel
Message-ID: <20180831081730.GM21634@phenom.ffwll.local>
Mail-Followup-To: Brian Starkey <brian.starkey@arm.com>,
        dri-devel@lists.freedesktop.org, daniel@fooishbar.org,
        airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        linux-kernel@vger.kernel.org, alexandru-cosmin.gheorghe@arm.com,
        liviu.dudau@arm.com, ayan.halder@arm.com, tfiga@chromium.org,
        hoegsberg@chromium.org
References: <20180823152343.6474-1-brian.starkey@arm.com>
 <20180823152343.6474-2-brian.starkey@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823152343.6474-2-brian.starkey@arm.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 04:23:41PM +0100, Brian Starkey wrote:
> Some formats have a non-integer number of bytes per pixel, which can't
> be handled with the existing 'cpp' field in drm_format_info. To handle
> these formats, add a 'bpp' field, which is only used if cpp[0] == 0.
> 
> This updates all the users of format->cpp in the core DRM code,
> converting them to use a new function to get the bits-per-pixel for any
> format.
> 
> It's assumed that drivers will use the 'bpp' field when they add support
> for pixel formats with non-integer bytes-per-pixel.
> 
> Signed-off-by: Brian Starkey <brian.starkey@arm.com>

I assume you still require that stuff is eventually aligned to bytes? In
that case, can we subsume this into the tile work Alex is doing? It's
essentially just another special case of having storage-size units
measured in bytes which span more than 1x1 pixel. And I kinda don't want a
metric pile of special cases here in the format code, because that just
means every driver handles a different subset, with different bugs.
-Daniel

> ---
>  drivers/gpu/drm/drm_fb_cma_helper.c          |  6 +++-
>  drivers/gpu/drm/drm_fb_helper.c              |  8 +++--
>  drivers/gpu/drm/drm_fourcc.c                 | 50 ++++++++++++++++++++++++++++
>  drivers/gpu/drm/drm_framebuffer.c            |  8 ++---
>  drivers/gpu/drm/drm_gem_framebuffer_helper.c |  3 +-
>  include/drm/drm_fourcc.h                     |  4 +++
>  6 files changed, 70 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb_cma_helper.c
> index 186d00adfb5f..e279d70d3e60 100644
> --- a/drivers/gpu/drm/drm_fb_cma_helper.c
> +++ b/drivers/gpu/drm/drm_fb_cma_helper.c
> @@ -118,13 +118,17 @@ dma_addr_t drm_fb_cma_get_gem_addr(struct drm_framebuffer *fb,
>  {
>  	struct drm_gem_cma_object *obj;
>  	dma_addr_t paddr;
> +	u8 bpp = drm_format_info_plane_bpp(fb->format, plane);
> +
> +	/* This can't work for non-integer bytes-per-pixel */
> +	WARN_ON(bpp % 8);
>  
>  	obj = drm_fb_cma_get_gem_obj(fb, plane);
>  	if (!obj)
>  		return 0;
>  
>  	paddr = obj->paddr + fb->offsets[plane];
> -	paddr += fb->format->cpp[plane] * (state->src_x >> 16);
> +	paddr += (bpp / 8) * (state->src_x >> 16);
>  	paddr += fb->pitches[plane] * (state->src_y >> 16);
>  
>  	return paddr;
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index 0646b108030b..ab369f250af4 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -1572,6 +1572,7 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
>  	struct drm_fb_helper *fb_helper = info->par;
>  	struct drm_framebuffer *fb = fb_helper->fb;
>  	int depth;
> +	u8 bpp = drm_format_info_plane_bpp(fb->format, 0);
>  
>  	if (var->pixclock != 0 || in_dbg_master())
>  		return -EINVAL;
> @@ -1580,14 +1581,14 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
>  	 * Changes struct fb_var_screeninfo are currently not pushed back
>  	 * to KMS, hence fail if different settings are requested.
>  	 */
> -	if (var->bits_per_pixel != fb->format->cpp[0] * 8 ||
> +	if (var->bits_per_pixel != bpp ||
>  	    var->xres > fb->width || var->yres > fb->height ||
>  	    var->xres_virtual > fb->width || var->yres_virtual > fb->height) {
>  		DRM_DEBUG("fb requested width/height/bpp can't fit in current fb "
>  			  "request %dx%d-%d (virtual %dx%d) > %dx%d-%d\n",
>  			  var->xres, var->yres, var->bits_per_pixel,
>  			  var->xres_virtual, var->yres_virtual,
> -			  fb->width, fb->height, fb->format->cpp[0] * 8);
> +			  fb->width, fb->height, bpp);
>  		return -EINVAL;
>  	}
>  
> @@ -1949,11 +1950,12 @@ void drm_fb_helper_fill_var(struct fb_info *info, struct drm_fb_helper *fb_helpe
>  			    uint32_t fb_width, uint32_t fb_height)
>  {
>  	struct drm_framebuffer *fb = fb_helper->fb;
> +	u8 bpp = drm_format_info_plane_bpp(fb->format, 0);
>  
>  	info->pseudo_palette = fb_helper->pseudo_palette;
>  	info->var.xres_virtual = fb->width;
>  	info->var.yres_virtual = fb->height;
> -	info->var.bits_per_pixel = fb->format->cpp[0] * 8;
> +	info->var.bits_per_pixel = bpp;
>  	info->var.accel_flags = FB_ACCELF_TEXT;
>  	info->var.xoffset = 0;
>  	info->var.yoffset = 0;
> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> index 3b42c25bd58d..bb28919c32f3 100644
> --- a/drivers/gpu/drm/drm_fourcc.c
> +++ b/drivers/gpu/drm/drm_fourcc.c
> @@ -272,10 +272,60 @@ int drm_format_plane_cpp(uint32_t format, int plane)
>  	if (!info || plane >= info->num_planes)
>  		return 0;
>  
> +	/*
> +	 * Not valid for formats with non-integer cpp,
> +	 * use drm_format{_info}_plane_bpp instead
> +	 */
> +	WARN_ON(!info->cpp[0]);
> +
>  	return info->cpp[plane];
>  }
>  EXPORT_SYMBOL(drm_format_plane_cpp);
>  
> +/**
> + * drm_format_plane_bpp - determine the bits per pixel value
> + * @format: pixel format (DRM_FORMAT_*)
> + * @plane: plane index
> + *
> + * Returns:
> + * The bits per pixel value for the specified plane.
> + */
> +int drm_format_plane_bpp(uint32_t format, int plane)
> +{
> +	const struct drm_format_info *info;
> +
> +	info = drm_format_info(format);
> +	if (!info)
> +		return 0;
> +
> +	return drm_format_info_plane_bpp(info, plane);
> +}
> +EXPORT_SYMBOL(drm_format_plane_bpp);
> +
> +/**
> + * drm_format_info_plane_bpp - determine the bits per pixel value
> + *
> + * Convenience function which handles formats with both integer
> + * and non-integer bytes-per-pixel.
> + *
> + * @format: pixel format info structure
> + * @plane: plane index
> + *
> + * Returns:
> + * The bits per pixel value for the specified plane.
> + */
> +int drm_format_info_plane_bpp(const struct drm_format_info *info, int plane)
> +{
> +	if (plane >= info->num_planes)
> +		return 0;
> +
> +	if (info->cpp[0])
> +		return info->cpp[plane] * 8;
> +
> +	return info->bpp[plane];
> +}
> +EXPORT_SYMBOL(drm_format_info_plane_bpp);
> +
>  /**
>   * drm_format_horz_chroma_subsampling - get the horizontal chroma subsampling factor
>   * @format: pixel format (DRM_FORMAT_*)
> diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
> index 8c4d32adcc17..7e00360ff70d 100644
> --- a/drivers/gpu/drm/drm_framebuffer.c
> +++ b/drivers/gpu/drm/drm_framebuffer.c
> @@ -185,20 +185,20 @@ static int framebuffer_check(struct drm_device *dev,
>  	for (i = 0; i < info->num_planes; i++) {
>  		unsigned int width = fb_plane_width(r->width, info, i);
>  		unsigned int height = fb_plane_height(r->height, info, i);
> -		unsigned int cpp = info->cpp[i];
> +		unsigned int bpp = drm_format_info_plane_bpp(info, i);
>  
>  		if (!r->handles[i]) {
>  			DRM_DEBUG_KMS("no buffer object handle for plane %d\n", i);
>  			return -EINVAL;
>  		}
>  
> -		if ((uint64_t) width * cpp > UINT_MAX)
> +		if ((uint64_t) DIV_ROUND_UP(width * bpp, 8) > UINT_MAX)
>  			return -ERANGE;
>  
>  		if ((uint64_t) height * r->pitches[i] + r->offsets[i] > UINT_MAX)
>  			return -ERANGE;
>  
> -		if (r->pitches[i] < width * cpp) {
> +		if ((uint64_t) r->pitches[i] * 8 < (uint64_t) width * bpp) {
>  			DRM_DEBUG_KMS("bad pitch %u for plane %d\n", r->pitches[i], i);
>  			return -EINVAL;
>  		}
> @@ -476,7 +476,7 @@ int drm_mode_getfb(struct drm_device *dev,
>  	r->height = fb->height;
>  	r->width = fb->width;
>  	r->depth = fb->format->depth;
> -	r->bpp = fb->format->cpp[0] * 8;
> +	r->bpp = drm_format_info_plane_bpp(fb->format, 0);
>  	r->pitch = fb->pitches[0];
>  
>  	/* GET_FB() is an unprivileged ioctl so we must not return a
> diff --git a/drivers/gpu/drm/drm_gem_framebuffer_helper.c b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
> index acfbc0641a06..dfe224ccaeba 100644
> --- a/drivers/gpu/drm/drm_gem_framebuffer_helper.c
> +++ b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
> @@ -161,6 +161,7 @@ drm_gem_fb_create_with_funcs(struct drm_device *dev, struct drm_file *file,
>  		unsigned int width = mode_cmd->width / (i ? info->hsub : 1);
>  		unsigned int height = mode_cmd->height / (i ? info->vsub : 1);
>  		unsigned int min_size;
> +		u8 bpp = drm_format_info_plane_bpp(fb->format, i);
>  
>  		objs[i] = drm_gem_object_lookup(file, mode_cmd->handles[i]);
>  		if (!objs[i]) {
> @@ -170,7 +171,7 @@ drm_gem_fb_create_with_funcs(struct drm_device *dev, struct drm_file *file,
>  		}
>  
>  		min_size = (height - 1) * mode_cmd->pitches[i]
> -			 + width * info->cpp[i]
> +			 + DIV_ROUND_UP(width * bpp, 8)
>  			 + mode_cmd->offsets[i];
>  
>  		if (objs[i]->size < min_size) {
> diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
> index 3e86408dac9f..d4af4dab1623 100644
> --- a/include/drm/drm_fourcc.h
> +++ b/include/drm/drm_fourcc.h
> @@ -36,6 +36,7 @@ struct drm_mode_fb_cmd2;
>   *	use in new code and set to 0 for new formats.
>   * @num_planes: Number of color planes (1 to 3)
>   * @cpp: Number of bytes per pixel (per plane)
> + * @bpp: Number of bits per pixel (per plane), only valid if cpp[0] == 0.
>   * @hsub: Horizontal chroma subsampling factor
>   * @vsub: Vertical chroma subsampling factor
>   * @has_alpha: Does the format embeds an alpha component?
> @@ -45,6 +46,7 @@ struct drm_format_info {
>  	u8 depth;
>  	u8 num_planes;
>  	u8 cpp[3];
> +	u8 bpp[3];
>  	u8 hsub;
>  	u8 vsub;
>  	bool has_alpha;
> @@ -66,6 +68,8 @@ drm_get_format_info(struct drm_device *dev,
>  uint32_t drm_mode_legacy_fb_format(uint32_t bpp, uint32_t depth);
>  int drm_format_num_planes(uint32_t format);
>  int drm_format_plane_cpp(uint32_t format, int plane);
> +int drm_format_plane_bpp(uint32_t format, int plane);
> +int drm_format_info_plane_bpp(const struct drm_format_info *format, int plane);
>  int drm_format_horz_chroma_subsampling(uint32_t format);
>  int drm_format_vert_chroma_subsampling(uint32_t format);
>  int drm_format_plane_width(int width, uint32_t format, int plane);
> -- 
> 2.16.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
