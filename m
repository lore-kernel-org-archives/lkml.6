Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137CEECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 08:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB5521523
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 08:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="KDAzcudv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB5521523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeIVOvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 10:51:12 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:46856 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbeIVOvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 10:51:12 -0400
Received: by mail-wr1-f53.google.com with SMTP id z3-v6so3130534wrr.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 01:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=26rwNgUdO7KfvXSDhX7g9TmXDuFzFGCZNOz/SMd/06U=;
        b=KDAzcudvUCNcJE0VpgoOlh4c+qeHrhZzU/ojIsbkgpvL4CZngiHmLH4Ds0ET4DSOvN
         B3KWufJ5zvWzXZSI8Tu0Cf8DBkTeuC4xqX3agROS/Q+bHw5YwQ0hQo2ldRUYoLJDz8w/
         OoVKKLIAyxzqQlPOfjJV+ARoxrTAQ76SGwvLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=26rwNgUdO7KfvXSDhX7g9TmXDuFzFGCZNOz/SMd/06U=;
        b=B4jePFNCB28CfW0VkYDMn7Q0JCsNOG5VwYta2B6nMMsVgbPyiyKOllj73puHjbA1AL
         ae/br5dE7JL0Bbtt42sNUk4XhPykAmkhn6biEXh6qN7eqAwQTzK8Mcq4JhwAXAxNQA2X
         rP+rPE8a25rC/fMHpVgV38draS2SvfD4cvsY2fklgzQfwI2R4lxPzT25dvkq+bfJBrky
         BE6A6+6sIl0wZ0M5yDJ3UkkXAQ0y07X+gvWRzzqsLkgAFDeCbqTVw+4Zw1K7EYSbIoQa
         cDaFhO+9IcwciHyqllvcupHg6Auyb7+YI1bjTkiCopCS1JuUcJUzHVXGWv9IngQBB1cX
         kxEQ==
X-Gm-Message-State: ABuFfogrtAEVaedapToalQGuLW8zujdIq15eaO/3O9yfwryQrCBRgUxM
        huJEN7t5Mh2+IhVP7DR3nwn3gQ==
X-Google-Smtp-Source: ACcGV62vGKwYBHkfdpFzY6d9FiPd/nAcOJyYqWNw5PfLjOfW4ztm4ULKE+M2jaLjDh9ckc/+2yNZJA==
X-Received: by 2002:adf:8324:: with SMTP id 33-v6mr1285171wrd.130.1537606702253;
        Sat, 22 Sep 2018 01:58:22 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 88-v6sm27691552wrf.95.2018.09.22.01.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Sep 2018 01:58:21 -0700 (PDT)
Date:   Sat, 22 Sep 2018 10:58:19 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        michel@daenzer.net, imirkin@alum.mit.edu,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 6/6] drm: move quirk_addfb_prefer_xbgr_30bpp handling
 to drm_driver_legacy_fb_format too
Message-ID: <20180922085819.GM11082@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, michel@daenzer.net,
        imirkin@alum.mit.edu, Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20180921134704.12826-1-kraxel@redhat.com>
 <20180921134704.12826-7-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921134704.12826-7-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 03:47:04PM +0200, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/drm_fourcc.c      | 5 +++++
>  drivers/gpu/drm/drm_framebuffer.c | 4 ----
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> index 7c6d3922ed..90a1c846fc 100644
> --- a/drivers/gpu/drm/drm_fourcc.c
> +++ b/drivers/gpu/drm/drm_fourcc.c
> @@ -121,6 +121,11 @@ uint32_t drm_driver_legacy_fb_format(struct drm_device *dev,
>  		if (fmt == DRM_FORMAT_XRGB1555)
>  			fmt = DRM_FORMAT_HOST_XRGB1555;
>  	}
> +
> +	if (dev->mode_config.quirk_addfb_prefer_xbgr_30bpp &&
> +	    fmt == DRM_FORMAT_XRGB2101010)
> +		fmt = DRM_FORMAT_XBGR2101010;
> +
>  	return fmt;
>  }
>  EXPORT_SYMBOL(drm_driver_legacy_fb_format);
> diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
> index 1e2126101c..3bf729d0aa 100644
> --- a/drivers/gpu/drm/drm_framebuffer.c
> +++ b/drivers/gpu/drm/drm_framebuffer.c
> @@ -129,10 +129,6 @@ int drm_mode_addfb(struct drm_device *dev, struct drm_mode_fb_cmd *or,
>  	r.pitches[0] = or->pitch;
>  	r.handles[0] = or->handle;
>  
> -	if (dev->mode_config.quirk_addfb_prefer_xbgr_30bpp &&
> -	    r.pixel_format == DRM_FORMAT_XRGB2101010)
> -		r.pixel_format = DRM_FORMAT_XBGR2101010;
> -
>  	ret = drm_mode_addfb2(dev, &r, file_priv);
>  	if (ret)
>  		return ret;
> -- 
> 2.9.3
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
