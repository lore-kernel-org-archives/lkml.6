Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F716C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B365E20779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SMqs93P2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B365E20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeICVG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:06:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38359 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbeICVG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:06:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id h33-v6so1224152edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 09:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PZWEcjQUPbjedvaBmL+F4O7vwzaJLpPPwBu81T+wh3k=;
        b=SMqs93P2qh+yFaMpTi7Rd/22C4ACvDe+xzzqdyTLbnzWuBgi8XpoB0tVLkmEPxy+SG
         94K5mNOCpEYhTUk95mwS+Aat8zo7iUr5Aa5e6CGg9vSLquqO9iK8KZV4kM/67XPMHdhr
         89Fn93f0Hukxlbd0eNwf3KYpWFHwNti/Ugh2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=PZWEcjQUPbjedvaBmL+F4O7vwzaJLpPPwBu81T+wh3k=;
        b=MVktP29YoTicTG1b4NFiQXOB/xKdUxvAXv0wfafybqXxYTpuZR/znSDiS+bSh6x3Jj
         hn6UcWjXapqbwBjIGp2gKWIBUtTXZUO0WvFYb7+gz8hua58oofWMEFIwFRQ/Bw0sv7Cf
         QvY1PB6sRnVS3tE5Kf9ZTNVDaedhHNcImUGtj+0gU1Inn2aRi2t9h5RqKycMuIYM0FUv
         0b8LtnaCbKy7tTeJeRAbZJ5k/HSdOPrXcI3q5UdsxI+e00s6OAB8cuLB5SB+S/724Gf8
         8KPics2RUpVEdcUSgvm7BynHI5B2wpkCXHmqIN+dRhsTbxnlzrUhVrMfEaEzaPrVahA8
         gqXw==
X-Gm-Message-State: APzg51BKrQ92vUX2/QzeqFi6YWj/MbIQjJNW0cqsLiDqribevdJGC3Tp
        //1K9+WBk/Aceyk4ozV+GUr3cg==
X-Google-Smtp-Source: ANB0Vdad5mdPR5wXzMYUHmnhIxTraUGt/kik5kUBKoy8643egI+7KvUIw+H5Hzi3iBO/o0wD9fJXwA==
X-Received: by 2002:a50:b902:: with SMTP id m2-v6mr32577948ede.185.1535993161705;
        Mon, 03 Sep 2018 09:46:01 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-109.fiber7.init7.net. [212.51.149.109])
        by smtp.gmail.com with ESMTPSA id f13-v6sm13151251edf.50.2018.09.03.09.46.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 09:46:00 -0700 (PDT)
Date:   Mon, 3 Sep 2018 18:45:58 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH 3/5] drm: fix drm_mode_addfb() on big endian machines.
Message-ID: <20180903164558.GL21634@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>
References: <20180903105756.24912-1-kraxel@redhat.com>
 <20180903105756.24912-4-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903105756.24912-4-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 12:57:54PM +0200, Gerd Hoffmann wrote:
> Userspace on big endian machhines typically expects the ADDFB ioctl
> returns a big endian framebuffer.  drm_mode_addfb() will call
> drm_mode_addfb2() unconditionally with little endian DRM_FORMAT_*
> values though, which is wrong.  This patch fixes that.
> 
> Drivers (both kernel and xorg) have quirks in place to deal with the
> broken drm_mode_addfb() behavior.  Because of this we can't just change
> drm_mode_addfb() behavior for everybody without breaking things.  So add
> a new driver feature flag DRIVER_PREFER_HOST_BYTE_ORDER, so drivers can
> opt-in.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_drv.h             |  1 +
>  drivers/gpu/drm/drm_framebuffer.c | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index 46a8009784..9cf12596cd 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -57,6 +57,7 @@ struct drm_printer;
>  #define DRIVER_KMS_LEGACY_CONTEXT	0x20000
>  #define DRIVER_SYNCOBJ                  0x40000
>  #define DRIVER_PREFER_XBGR_30BPP        0x80000
> +#define DRIVER_PREFER_HOST_BYTE_ORDER   0x100000

Hm, not a huge fan of using driver_flags for random little quirks. I think
a boolean in sturct drm_mode_config would be much better. Bonus if you
also move the 30bpp hack over to that. Something like
mode_config.quirk_addfb_host_byte_order and
mode_config.quirk_addfb_prefer_xbgr_30bpp or whatever. That has the upside
of giving us a really nice place to put a huge comment about what this is
supposed to do.

I think otherwise this looks overall rather reasonable. I think the only
other driver that ever cared about big endian was radeon/amdgpu. Would be
good to get at least an ack from amd folks, or a "meh, stopped caring".
-Daniel

>  
>  /**
>   * struct drm_driver - DRM driver structure
> diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
> index 88758096d5..ccbda8a2e9 100644
> --- a/drivers/gpu/drm/drm_framebuffer.c
> +++ b/drivers/gpu/drm/drm_framebuffer.c
> @@ -124,6 +124,17 @@ int drm_mode_addfb(struct drm_device *dev, struct drm_mode_fb_cmd *or,
>  	    dev->driver->driver_features & DRIVER_PREFER_XBGR_30BPP)
>  		r.pixel_format = DRM_FORMAT_XBGR2101010;
>  
> +	if (dev->driver->driver_features & DRIVER_PREFER_HOST_BYTE_ORDER) {
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
