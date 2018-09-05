Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F97C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9FE2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CjS6Pl9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9FE2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeIEWuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 18:50:44 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45056 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbeIEWun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 18:50:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id p52-v6so6808944eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 11:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BGcrGQF7CXxFBAuskCH43KnwnQ+Qc//MGZYcxbh9DZU=;
        b=CjS6Pl9UjNKJ/zQTyuAf7nLIiiyMT0Lr7aqVqzHjvJWcgMEA3zB3n5X+cPgNxERwFQ
         IaaA3gNMgYwD5TFLUuZwxZ6sptcTaz4jpAIXOwu/GvSniQpgdEhTgnr5MiEYgPiuHKWT
         m7dVhnConeXyaIurn7yVhp1/BV3Xqtwd8Eiuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=BGcrGQF7CXxFBAuskCH43KnwnQ+Qc//MGZYcxbh9DZU=;
        b=e1NDCdbEPAMDHgklXagMQe0wxbQt970IawtoARAd2DsrXFXD/Zr2yG2bXWnd8H48mQ
         ScWw9Ee5N64/sdJ28Wp+i0GJFRgvmBr1lNZlIIej04AZndE1ibXXfR6Wzma77np2uA3F
         4Jny7bZX4ihuabisylm06c7peU3FTN5GeB0G6jAzJZhdFBqtaGTHaiSgtcJL8n/PD0zb
         NYJkppq0pn1QCPc8AQyiIe0y11pBg7tdWBDINBDM7RsAdF/tPWgJdFHBY7ETu6wAFjNy
         COvbni4hfhIUCnDqDcdG5CY+FMY24QzNNpA5nRDkJorX95XoXgmqSkikLz0xB86U85jn
         FL9Q==
X-Gm-Message-State: APzg51CCa0jbzWjq6lBNysrIWD8ugkComT1HNSlH1tTghPZso7NyRPhA
        JXQ3nSIOtHtRWYkCL7MfZ/EIWA==
X-Google-Smtp-Source: ANB0VdYPeaCuHxiV8WsL/eTYNX6gZEQSYCVSL0seJkBnrSypK/GWNEmbWB3aGRmF7+y7s+NL3VuQ5g==
X-Received: by 2002:a50:9622:: with SMTP id y31-v6mr43127048eda.141.1536171562460;
        Wed, 05 Sep 2018 11:19:22 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id w22-v6sm1617994eda.34.2018.09.05.11.19.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 11:19:21 -0700 (PDT)
Date:   Wed, 5 Sep 2018 20:19:19 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        michel@daenzer.net, open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v2 4/6] drm: fix drm_mode_addfb() on big endian machines.
Message-ID: <20180905181919.GH4929@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        michel@daenzer.net, open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>
References: <20180905060445.15008-1-kraxel@redhat.com>
 <20180905060445.15008-5-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905060445.15008-5-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.17.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 08:04:43AM +0200, Gerd Hoffmann wrote:
> Userspace on big endian machhines typically expects the ADDFB ioctl
> returns a big endian framebuffer.  drm_mode_addfb() will call
> drm_mode_addfb2() unconditionally with little endian DRM_FORMAT_*
> values though, which is wrong.  This patch fixes that.
> 
> Drivers (both kernel and xorg) have quirks in place to deal with the
> broken drm_mode_addfb() behavior.  Because of this we can't just change
> drm_mode_addfb() behavior for everybody without breaking things.  Add
> the quirk_addfb_prefer_host_byte_order field to mode_config, so drivers
> can opt-in.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_mode_config.h     | 14 ++++++++++++++
>  drivers/gpu/drm/drm_framebuffer.c | 11 +++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> index 5d29f4ba6f..65020086c9 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -811,6 +811,20 @@ struct drm_mode_config {
>  	uint32_t preferred_depth, prefer_shadow;
>  	bool quirk_addfb_prefer_xbgr_30bpp;
>  
> +	/*

This doesn't parse, needs /**

$ make htmldocs

to check it.

> +	 * @quirk_addfb_prefer_host_byte_order:
> +	 *
> +	 * When set to true drm_mode_addfb() will pick host byte order
> +	 * pixel_format when calling drm_mode_addfb2().  This is how
> +	 * drm_mode_addfb() should have worked from day one.  It
> +	 * didn't though, so we ended up with quirks in both kernel
> +	 * and userspace drivers to deal with the broken behavior.
> +	 * Simply fixing drm_mode_addfb() unconditionally would break
> +	 * these drivers, so add a quirk bit here to allow drivers
> +	 * opt-in.
> +	 */
> +	bool quirk_addfb_prefer_host_byte_order;

I wonder whether we should reject addFB2 on big endian hosts if this isn't
set. Otherwise we need addfb3, aka will never be able to fix this. Anyway,
that might be good work for a follow-up ...

Up to this patch series (with the kerneldoc fixed):

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> +
>  	/**
>  	 * @async_page_flip: Does this device support async flips on the primary
>  	 * plane?
> diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
> index 888c4d53cf..f863f8a20f 100644
> --- a/drivers/gpu/drm/drm_framebuffer.c
> +++ b/drivers/gpu/drm/drm_framebuffer.c
> @@ -124,6 +124,17 @@ int drm_mode_addfb(struct drm_device *dev, struct drm_mode_fb_cmd *or,
>  	    r.pixel_format == DRM_FORMAT_XRGB2101010)
>  		r.pixel_format = DRM_FORMAT_XBGR2101010;
>  
> +	if (dev->mode_config.quirk_addfb_prefer_host_byte_order) {
> +		if (r.pixel_format == DRM_FORMAT_XRGB8888)
> +			r.pixel_format = DRM_FORMAT_HOST_XRGB8888;
> +		if (r.pixel_format == DRM_FORMAT_ARGB8888)
> +			r.pixel_format = DRM_FORMAT_HOST_ARGB8888;
> +		if (r.pixel_format == DRM_FORMAT_RGB565)
> +			r.pixel_format = DRM_FORMAT_HOST_RGB565;
> +		if (r.pixel_format == DRM_FORMAT_XRGB1555)
> +			r.pixel_format = DRM_FORMAT_HOST_XRGB1555;
> +	}
> +
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
