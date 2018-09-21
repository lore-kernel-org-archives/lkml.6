Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB28ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3565920C0A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HCDvPQ+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3565920C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389610AbeIUP1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:27:14 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35445 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389434AbeIUP1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:27:13 -0400
Received: by mail-ed1-f68.google.com with SMTP id y20-v6so10222276edq.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 02:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oSAHoG/a6415PxtuE+QzDq5QP9XDfyoeGZ6LrJoVhfY=;
        b=HCDvPQ+lvHVLcIG7H8CorWa6iSpijUHJsbx1d/9PMIutM88mKFEHgPUO8CfG40zvp0
         4BOiZhbHVICXTRaI/OC/iIcJ337oJtn0al78PZd31+uSJfcnkOLarulRqe2q+ZOIeuTL
         MzPgyWJAYQtKIj7Sj8Kczbng75YhHaIhTsr6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=oSAHoG/a6415PxtuE+QzDq5QP9XDfyoeGZ6LrJoVhfY=;
        b=ES7zhjzReeAexE9EDzVXQ+IuLoWzOlEXWp1ETRP8Rm/bEYnFJcUSEKJBEB+BuEd2KU
         elZErok1S0cb4GRTuSuXYU8hTF2l3LgIcQVVnG/Qcv04lOlhzjcYu2O0NcxMrOm/XUfw
         1fG+6zYx1XQdAo7ajLYOE8hq3LY8PDOuFCYY4c4OSEkBHXXMNz3Qbn839JkwYBZaaLCG
         pdW/OEUjP0bShkjDS7kC7rYZEl/SpG8pW1eDahptn+c4+EZijJaX810jsw5tTJzSIEn+
         sD0UmoqAPS4MWnDxXUhrzuo7kwgg/Vroh00uOEdbYzNEdV7mkRtoHeI0ACQCYdBQwgNd
         S1AA==
X-Gm-Message-State: APzg51AhRZwPYKeNPYx+PCuPCoJBxXDHFmuMiqKum5MxCX90v6eqod2/
        bTUmxpPlvuc/J/UQKLX6IE/ubg==
X-Google-Smtp-Source: ANB0VdZ2KKGa7pRlgMqZYL7NDfTsAPbLZABcD4x9ECb/c9w3pt+ErQ80J2D4/H81UW93QL0PWnsjTQ==
X-Received: by 2002:a50:90c5:: with SMTP id d5-v6mr3113498eda.76.1537522750532;
        Fri, 21 Sep 2018 02:39:10 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id w2-v6sm2082113edw.83.2018.09.21.02.39.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 02:39:09 -0700 (PDT)
Date:   Fri, 21 Sep 2018 11:39:07 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        michel@daenzer.net, open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v3 1/5] drm: move native byte order quirk to new
 drm_mode_legacy_fb_format2 function
Message-ID: <20180921093907.GE11082@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        michel@daenzer.net, open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>
References: <20180919111252.7932-1-kraxel@redhat.com>
 <20180919111252.7932-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919111252.7932-2-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 01:12:48PM +0200, Gerd Hoffmann wrote:
> Turns out we need the pixel format fixup not only for the addfb ioctl,
> but also for fbdev emulation code.
> 
> Ideally we would place it in drm_mode_legacy_fb_format().  That would
> create alot of churn though, and most drivers don't care because they
> never ever run on a big endian platform.  So add a new
> drm_mode_legacy_fb_format2() function instead.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_fourcc.h          |  2 ++
>  drivers/gpu/drm/drm_fourcc.c      | 28 ++++++++++++++++++++++++++++
>  drivers/gpu/drm/drm_framebuffer.c | 15 +++------------
>  3 files changed, 33 insertions(+), 12 deletions(-)
> 
> diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
> index fac831c401..4b82bb6576 100644
> --- a/include/drm/drm_fourcc.h
> +++ b/include/drm/drm_fourcc.h
> @@ -88,6 +88,8 @@ const struct drm_format_info *
>  drm_get_format_info(struct drm_device *dev,
>  		    const struct drm_mode_fb_cmd2 *mode_cmd);
>  uint32_t drm_mode_legacy_fb_format(uint32_t bpp, uint32_t depth);
> +uint32_t drm_mode_legacy_fb_format2(uint32_t bpp, uint32_t depth,
> +				    bool native);
>  int drm_format_num_planes(uint32_t format);
>  int drm_format_plane_cpp(uint32_t format, int plane);
>  int drm_format_horz_chroma_subsampling(uint32_t format);
> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> index be1d6aaef6..1c1aaa8b23 100644
> --- a/drivers/gpu/drm/drm_fourcc.c
> +++ b/drivers/gpu/drm/drm_fourcc.c
> @@ -96,6 +96,34 @@ uint32_t drm_mode_legacy_fb_format(uint32_t bpp, uint32_t depth)
>  EXPORT_SYMBOL(drm_mode_legacy_fb_format);
>  
>  /**
> + * drm_mode_legacy_fb_format2 - compute drm fourcc code from legacy description
> + * @bpp: bits per pixels
> + * @depth: bit depth per pixel
> + * @native: use host native byte order
> + *
> + * Computes a drm fourcc pixel format code for the given @bpp/@depth values.
> + * Useful in fbdev emulation code, since that deals in those values.
> + */
> +uint32_t drm_mode_legacy_fb_format2(uint32_t bpp, uint32_t depth,
> +				    bool native)

A _2 function is a bit meh imo. What about legacy_fb_format_native()
instead, which unconditionally gives you the native format, and then
pulling the if (native) out?

Or slightly more future proof (given that we have the nouveau hack too):

drm_device_legacy_fb_format(drm_device *dev, bpp, depth);

to make it clear that this is the device-specific conversion function.
-Daniel

> +{
> +	uint32_t fmt = drm_mode_legacy_fb_format(bpp, depth);
> +
> +	if (native) {
> +		if (fmt == DRM_FORMAT_XRGB8888)
> +			fmt = DRM_FORMAT_HOST_XRGB8888;
> +		if (fmt == DRM_FORMAT_ARGB8888)
> +			fmt = DRM_FORMAT_HOST_ARGB8888;
> +		if (fmt == DRM_FORMAT_RGB565)
> +			fmt = DRM_FORMAT_HOST_RGB565;
> +		if (fmt == DRM_FORMAT_XRGB1555)
> +			fmt = DRM_FORMAT_HOST_XRGB1555;
> +	}
> +	return fmt;
> +}
> +EXPORT_SYMBOL(drm_mode_legacy_fb_format2);
> +
> +/**
>   * drm_get_format_name - fill a string with a drm fourcc format's name
>   * @format: format to compute name of
>   * @buf: caller-supplied buffer
> diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
> index 1ee3d6b442..f72e3dffc7 100644
> --- a/drivers/gpu/drm/drm_framebuffer.c
> +++ b/drivers/gpu/drm/drm_framebuffer.c
> @@ -111,12 +111,14 @@ int drm_mode_addfb(struct drm_device *dev, struct drm_mode_fb_cmd *or,
>  		   struct drm_file *file_priv)
>  {
>  	struct drm_mode_fb_cmd2 r = {};
> +	bool native = dev->mode_config.quirk_addfb_prefer_host_byte_order;
>  	int ret;
>  
>  	if (!drm_core_check_feature(dev, DRIVER_MODESET))
>  		return -EOPNOTSUPP;
>  
> -	r.pixel_format = drm_mode_legacy_fb_format(or->bpp, or->depth);
> +	r.pixel_format = drm_mode_legacy_fb_format2(or->bpp, or->depth,
> +						    native);
>  	if (r.pixel_format == DRM_FORMAT_INVALID) {
>  		DRM_DEBUG("bad {bpp:%d, depth:%d}\n", or->bpp, or->depth);
>  		return -EINVAL;
> @@ -133,17 +135,6 @@ int drm_mode_addfb(struct drm_device *dev, struct drm_mode_fb_cmd *or,
>  	    r.pixel_format == DRM_FORMAT_XRGB2101010)
>  		r.pixel_format = DRM_FORMAT_XBGR2101010;
>  
> -	if (dev->mode_config.quirk_addfb_prefer_host_byte_order) {
> -		if (r.pixel_format == DRM_FORMAT_XRGB8888)
> -			r.pixel_format = DRM_FORMAT_HOST_XRGB8888;
> -		if (r.pixel_format == DRM_FORMAT_ARGB8888)
> -			r.pixel_format = DRM_FORMAT_HOST_ARGB8888;
> -		if (r.pixel_format == DRM_FORMAT_RGB565)
> -			r.pixel_format = DRM_FORMAT_HOST_RGB565;
> -		if (r.pixel_format == DRM_FORMAT_XRGB1555)
> -			r.pixel_format = DRM_FORMAT_HOST_XRGB1555;
> -	}
> -
>  	ret = drm_mode_addfb2(dev, &r, file_priv);
>  	if (ret)
>  		return ret;
> -- 
> 2.9.3
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
