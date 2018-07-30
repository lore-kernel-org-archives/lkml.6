Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475CD13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F4A20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b26sFZGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F4A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731831AbeG3PI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:08:58 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:40120 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbeG3PI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:08:58 -0400
Received: by mail-yb0-f194.google.com with SMTP id y11-v6so4728544ybm.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 06:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yPpaGxGtKTuWGQzWGyHOv2mrQenCB1T7lhvxE4adx5M=;
        b=b26sFZGjIl10Ijgl5mAsqZ7oTaE4m+Zq7KeAThafMCqqn08CvYRGp6gsuE/dZeGYh/
         pL9d7+MpHFpgSkRz+qjEPa8k3eretYk+raPdq8s5CvKUTzWQXi9KpXVqoumi5XfXz0B+
         gM+uSkNl5mVmy2o42sxS1BW2AwpRQgHEdeiEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yPpaGxGtKTuWGQzWGyHOv2mrQenCB1T7lhvxE4adx5M=;
        b=YPZoInhoLlpEEqp2pvJBWNPyHs1PcjpmOd4bqHp3TC9RVr3oyn9UBtooSaS9bM3MVj
         KL2KrQiBE9RmYKO0LwV6S7DfQDC7eC2iy9DI5GsYQOm35118hbifPtnjn36HX7aNL+lR
         FXDhSuLyVwpOwPozC9/piEd1KM+dy3UgM1pVRbvggmJYWIv1A/up2Cnl+FArQWkLqedR
         FAb17DQI8R84baX8PVWW6F103ofkprRoCHOIL0O+nn+b1m78wImlOUcTGqapPJ9zJGuQ
         mb6rGGEQlCEbcEHfrNpBkhFlmsmWg9onFUM9gEEE9uxbNy89zLKTB4haJEW/yrwdqsdF
         OJGA==
X-Gm-Message-State: AOUpUlFsvOKQmbGR+94ZYNS2AvXHOFilOr4bScqHo0HYAkL7I+sGVPVI
        xEot3pjLKWf+SOlVAQAV0hDO4A==
X-Google-Smtp-Source: AAOMgpdOsMkxvdxWlT+5exGZ+zGYhPFTkhGUCGUgcLYrKGcW0hNXLQ2ZxZ8jUK1fVcva4VcbcVdmhw==
X-Received: by 2002:a25:ac08:: with SMTP id w8-v6mr9227880ybi.245.1532957636621;
        Mon, 30 Jul 2018 06:33:56 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id w8-v6sm5086161ywa.12.2018.07.30.06.33.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 06:33:55 -0700 (PDT)
Date:   Mon, 30 Jul 2018 09:33:55 -0400
From:   Sean Paul <seanpaul@chromium.org>
To:     Satendra Singh Thakur <satendra.t@samsung.com>
Cc:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        vineet.j@samsung.com, hemanshu.s@samsung.com,
        nishant.y08@samsung.com, sst2005@gmail.com
Subject: Re: [PATCH] drm/kms/crtc: Saving crtc->primary into a drm_plane
 pointer instead of dereferencing it every time.
Message-ID: <20180730133355.GB20303@art_vandelay>
References: <CGME20180730060607epcas5p18565ae86e1c88e82469554aa3c0e1664@epcas5p1.samsung.com>
 <20180730060607epcas5p18565ae86e1c88e82469554aa3c0e1664~GEGlfPEp_2913429134epcas5p1v@epcas5p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730060607epcas5p18565ae86e1c88e82469554aa3c0e1664~GEGlfPEp_2913429134epcas5p1v@epcas5p1.samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 11:35:58AM +0530, Satendra Singh Thakur wrote:
> In the func __drm_mode_set_config_internal,
> objects (fb, old_fb, crtc) of crtc->primary are used at many places.
> To access the objects of primary, it is dereferenced from crtc every
> time. It's better to save it into drm_plane pointer.
> This will make the code look simple.

Maybe this is simpler, but not overwhelmingly so.

To be honest, I'm a bit concerned with the volume of no-op patches you're
sending to the list. I so appreciate and encourage your participation,
but perhaps we could redirect your efforts. 

A lot of the patches you send (not necessarily this one, it's pretty
straightforward), are changing core pieces of commit validation which have
already been proven to work. These types of changes require a lot of
context and scrutinization on the part of the reviewer, which takes time that
most of us don't have. If you introduce a bug with a no-op change, people are
not going to be happy.

So, in order to make everyone more productive, may I suggest the following:

- Every change you make sure have a purpose greater than "this code snippet
  is marginally more readable".
- If you want to make readability changes, do them in one patch series with
  a common theme (for example, the drm_crtc.h refactors).
- Spend your time on bug fixes, performance improvements, and features as
  opposed to readability.
- Make sure you test your code.

Again, *thank you* for your patches, it's great to have you here.

Sean


> 
> Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
> ---
>  drivers/gpu/drm/drm_crtc.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> index 98a36e6..9644f5b 100644
> --- a/drivers/gpu/drm/drm_crtc.c
> +++ b/drivers/gpu/drm/drm_crtc.c
> @@ -462,6 +462,7 @@ static int __drm_mode_set_config_internal(struct drm_mode_set *set,
>  	struct drm_crtc *crtc = set->crtc;
>  	struct drm_framebuffer *fb;
>  	struct drm_crtc *tmp;
> +	struct drm_plane *plane;
>  	int ret;
>  
>  	/*
> @@ -469,23 +470,27 @@ static int __drm_mode_set_config_internal(struct drm_mode_set *set,
>  	 * connectors from it), hence we need to refcount the fbs across all
>  	 * crtcs. Atomic modeset will have saner semantics ...
>  	 */
> -	drm_for_each_crtc(tmp, crtc->dev)
> -		tmp->primary->old_fb = tmp->primary->fb;
> +	drm_for_each_crtc(tmp, crtc->dev) {
> +		plane = tmp->primary;
> +		plane->old_fb = plane->fb;
> +	}
>  
>  	fb = set->fb;
> -
>  	ret = crtc->funcs->set_config(set, ctx);
>  	if (ret == 0) {
> -		crtc->primary->crtc = fb ? crtc : NULL;
> -		crtc->primary->fb = fb;
> +		plane = crtc->primary;
> +		plane->crtc = fb ? crtc : NULL;
> +		plane->fb = fb;
>  	}
>  
>  	drm_for_each_crtc(tmp, crtc->dev) {
> -		if (tmp->primary->fb)
> -			drm_framebuffer_get(tmp->primary->fb);
> -		if (tmp->primary->old_fb)
> -			drm_framebuffer_put(tmp->primary->old_fb);
> -		tmp->primary->old_fb = NULL;
> +		plane = tmp->primary;
> +		if (plane->fb)
> +			drm_framebuffer_get(plane->fb);
> +		if (plane->old_fb) {
> +			drm_framebuffer_put(plane->old_fb);
> +			plane->old_fb = NULL;
> +		}
>  	}
>  
>  	return ret;
> -- 
> 2.7.4
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
