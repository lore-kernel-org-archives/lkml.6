Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F20AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC1020855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CCLvtfjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC1020855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbeIHAaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:30:11 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:45088 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeIHAaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:30:10 -0400
Received: by mail-ed1-f54.google.com with SMTP id p52-v6so12285417eda.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 12:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xmPmO1BbD/DE0Tz5pk1/CvsETOI/FdT4enDG11NQeAg=;
        b=CCLvtfjsH2/PCXCLgTHcELDeUKanO6GbGeJZt1f6GT/IRAIQ0P68cmNr+rJ/sVmOG2
         zBkCfL+H/JAiFM4jv/BOB17MvgsoJVH3hDNvrVqiNlzQnYjUxcStZpIKL2ecDmRqp+/T
         8xscXcygizXxt3NS8TwORqKz+YbioamC0r0W0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=xmPmO1BbD/DE0Tz5pk1/CvsETOI/FdT4enDG11NQeAg=;
        b=ktGmVMzjI/TZfZhbT51lfmrgBsuClS7DyOlG8f7EHkQ+8OK6mkHCSIaMhLpModrC9X
         yP7rYDyEcA8N9e/0biHDReW+wtSTCvpeDzc5xQUgOYlyCBtmWJS6fAJwpRNcpjs9pKEm
         PTmB5vfswwWqqXNNZ29FqRd/5Jy8mCtTHc4BhGSC3wXPPMtM5b2Bf7UFQOyJJQRwxeXM
         UbIFYvRV17o4lPTHbs3Evpi/3NrnZ4Q1kTz1s/O2QprgT+jnx6hcxCbSzwUAQwlDCHXc
         mlvPGB7kkSuskvy523uryXTB1RUQf3PcB394oN+jxz5qpht2j1lXqC7XD+1hnftWZkj1
         lvhw==
X-Gm-Message-State: APzg51DhPhKd65NttPbMqSLK1Ye3wx8S30s2tfCx86nytPOcosrqVZHv
        I52/CEhWgiuORR3jntup6braKQ==
X-Google-Smtp-Source: ANB0VdYccW7VWUqjMtbXgTVFcQO2DCn4OaUJhi2EE0LFwq5oZZGq/mDFketN18Vho/tqWEtEhvUX9Q==
X-Received: by 2002:a50:b1d1:: with SMTP id n17-v6mr10450931edd.52.1536349662283;
        Fri, 07 Sep 2018 12:47:42 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id o22-v6sm9505974edc.90.2018.09.07.12.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 12:47:41 -0700 (PDT)
Date:   Fri, 7 Sep 2018 21:47:39 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v2] drm: refuse ADDFB2 ioctl for broken bigendian drivers
Message-ID: <20180907194739.GD7176@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>
References: <20180907073213.20410-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907073213.20410-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.17.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 09:32:13AM +0200, Gerd Hoffmann wrote:
> Drivers must set the quirk_addfb_prefer_host_byte_order quirk to make
> the drm_mode_addfb() compat code work correctly on bigendian machines.
> 
> If they don't they interpret pixel_format values incorrectly for bug
> compatibility, which in turn implies the ADDFB2 ioctl does not work
> correctly then.  So block it to make userspace fallback to ADDFB.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/drm_crtc_internal.h |  6 ++++--
>  drivers/gpu/drm/drm_framebuffer.c   | 24 ++++++++++++++++++++++++
>  drivers/gpu/drm/drm_ioctl.c         |  2 +-
>  3 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
> index b613227633..6719e1c8df 100644
> --- a/drivers/gpu/drm/drm_crtc_internal.h
> +++ b/drivers/gpu/drm/drm_crtc_internal.h
> @@ -174,6 +174,8 @@ void drm_fb_release(struct drm_file *file_priv);
>  
>  int drm_mode_addfb(struct drm_device *dev, struct drm_mode_fb_cmd *or,
>  		   struct drm_file *file_priv);
> +int drm_mode_addfb2(struct drm_device *dev,
> +		    void *data, struct drm_file *file_priv);
>  int drm_mode_rmfb(struct drm_device *dev, u32 fb_id,
>  		  struct drm_file *file_priv);
>  
> @@ -181,8 +183,8 @@ int drm_mode_rmfb(struct drm_device *dev, u32 fb_id,
>  /* IOCTL */
>  int drm_mode_addfb_ioctl(struct drm_device *dev,
>  			 void *data, struct drm_file *file_priv);
> -int drm_mode_addfb2(struct drm_device *dev,
> -		    void *data, struct drm_file *file_priv);
> +int drm_mode_addfb2_ioctl(struct drm_device *dev,
> +			  void *data, struct drm_file *file_priv);
>  int drm_mode_rmfb_ioctl(struct drm_device *dev,
>  			void *data, struct drm_file *file_priv);
>  int drm_mode_getfb(struct drm_device *dev,
> diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
> index f863f8a20f..fb7528444c 100644
> --- a/drivers/gpu/drm/drm_framebuffer.c
> +++ b/drivers/gpu/drm/drm_framebuffer.c
> @@ -363,6 +363,30 @@ int drm_mode_addfb2(struct drm_device *dev,
>  	return 0;
>  }
>  
> +int drm_mode_addfb2_ioctl(struct drm_device *dev,
> +			  void *data, struct drm_file *file_priv)
> +{
> +#ifdef __BIG_ENDIAN
> +	if (!dev->mode_config.quirk_addfb_prefer_host_byte_order) {
> +		/*
> +		 * Drivers must set the
> +		 * quirk_addfb_prefer_host_byte_order quirk to make
> +		 * the drm_mode_addfb() compat code work correctly on
> +		 * bigendian machines.
> +		 *
> +		 * If they don't they interpret pixel_format values
> +		 * incorrectly for bug compatibility, which in turn
> +		 * implies the ADDFB2 ioctl does not work correctly
> +		 * then.  So block it to make userspace fallback to
> +		 * ADDFB.
> +		 */
> +		DRM_DEBUG_KMS("addfb2 broken on bigendian");
> +		return -EINVAL;
> +	}
> +#endif
> +	return drm_mode_addfb2(dev, data, file_priv);
> +}
> +
>  struct drm_mode_rmfb_work {
>  	struct work_struct work;
>  	struct list_head fbs;
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index ea10e9a26a..6b4a633b42 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -645,7 +645,7 @@ static const struct drm_ioctl_desc drm_ioctls[] = {
>  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_GETPROPBLOB, drm_mode_getblob_ioctl, DRM_UNLOCKED),
>  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_GETFB, drm_mode_getfb, DRM_UNLOCKED),
>  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_ADDFB, drm_mode_addfb_ioctl, DRM_UNLOCKED),
> -	DRM_IOCTL_DEF(DRM_IOCTL_MODE_ADDFB2, drm_mode_addfb2, DRM_UNLOCKED),
> +	DRM_IOCTL_DEF(DRM_IOCTL_MODE_ADDFB2, drm_mode_addfb2_ioctl, DRM_UNLOCKED),
>  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_RMFB, drm_mode_rmfb_ioctl, DRM_UNLOCKED),
>  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_PAGE_FLIP, drm_mode_page_flip_ioctl, DRM_MASTER|DRM_UNLOCKED),
>  	DRM_IOCTL_DEF(DRM_IOCTL_MODE_DIRTYFB, drm_mode_dirtyfb_ioctl, DRM_MASTER|DRM_UNLOCKED),
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
