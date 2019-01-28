Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9D9C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DE52175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="AyZXgeeD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfA1VDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:03:44 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37463 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfA1VDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 16:03:44 -0500
Received: by mail-yb1-f196.google.com with SMTP id 2so7291007ybw.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 13:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AeYGKegqDIzCvSD4A84Dthd2QTd0+Cki5Q4rb/PhdBk=;
        b=AyZXgeeDQ/No2hszEFvSgo3HAe8tppQLmxxpIpU/CQk0XeqRuUoToVlikGTikHRY0b
         BS670fAn8H7nHOZW493uNa0h7RlOcDDA3YndaUZRyl8vPT+O2JdGIbx7Wt01i6J7uz9Q
         LED6+Gqiop0+ST1Fxx8lrJSStbVLkheyoOs7yvLO+Dalk0BwAK5MpQmvxOb3JUvnUTVS
         X0O8mGskY7zp9/jt5m1lGEr+YYhyjtEoJLKIlTjRCVcZLUo6uDsaM6a83fbhiBADdnLj
         ANi4Zd/Q5cn8FDiO9AAj4D4/spZoXXtgz7b8lAFoEpTQXhkQZUCjL8eOHly5wRGzjZmi
         oP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AeYGKegqDIzCvSD4A84Dthd2QTd0+Cki5Q4rb/PhdBk=;
        b=uBEJxCEYsQJX9zdaaV2JjynkXOKBbMVGP6NDB7KRjKQd6e6jcNXzAaB/UMcmeC6XJF
         Vk+bDikgNFq4Yphu3fCUDADJW+FdkuNU1cDPiB/CiSGXk8pEIzhMCznglJpuPX8H+744
         ryROBNPIbOin6zmoVtbt0BM4WfESR1B4UQT9b/wnbtLolFOmmgJZcpHnA2yClLzcG0DR
         L7wISfA1rndghiWlDP3Xyc91Y0y2/IOMra4VxTcDL+OQka5P/JKSCa38Uy0qFET1xoBP
         WRZSLu//ZyUHlorDrMd5vqv1vmuGPf0vPlWzCZNfK/FgZ0pzL40TBmtSHi7mapCJj79O
         mnMQ==
X-Gm-Message-State: AJcUukeCD4ocQqFBat+Jif53qkzRCieci9/WxMKQmC6hTCWbD03tLZNa
        2Kg7DHT7RuTPPI0kighLCR76Iw==
X-Google-Smtp-Source: ALg8bN4PxJxdnpqIS6J77S+Hx0aplRSQL1fVJhGDk6pLw2iv3QYYVJ+zUg9iy2XR9dvu3+zTo7xXJw==
X-Received: by 2002:a25:ba0a:: with SMTP id t10mr16891333ybg.442.1548709422973;
        Mon, 28 Jan 2019 13:03:42 -0800 (PST)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id s35sm36221664ywa.19.2019.01.28.13.03.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 13:03:42 -0800 (PST)
Date:   Mon, 28 Jan 2019 16:03:41 -0500
From:   Sean Paul <sean@poorly.run>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH AUTOSEL 4.19 083/258] drm: Move drm_mode_setcrtc() local
 re-init to failure path
Message-ID: <20190128210341.GT114153@art_vandelay>
References: <20190128155924.51521-1-sashal@kernel.org>
 <20190128155924.51521-83-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128155924.51521-83-sashal@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 10:56:29AM -0500, Sasha Levin wrote:
> From: Sean Paul <seanpaul@chromium.org>
> 
> [ Upstream commit c232e9f41b136c141df9938024e521191a7b910d ]
> 
> Instead of always re-initializing the variables we need to clean up on
> out, move the re-initialization into the branch that goes back to retry
> label.
> 
> This is a lateral move right now, but will allow us to pull out the
> modeset locking into common code. I kept this change separate to make
> things easier to review.
> 
> Changes in v2:
> - None
> 
> Reviewed-by: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Link: https://patchwork.freedesktop.org/patch/msgid/20181129150423.239081-2-sean@poorly.run
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This probably doesn't need to get pulled back to stable. It was a pre-cursor for
some new helper macros that also don't need to be pulled back.

(Same comment for the 4.20 version)

Sean

> ---
>  drivers/gpu/drm/drm_crtc.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> index 9cbe8f5c9aca..ed9d7fc4cb2c 100644
> --- a/drivers/gpu/drm/drm_crtc.c
> +++ b/drivers/gpu/drm/drm_crtc.c
> @@ -567,9 +567,9 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
>  	struct drm_mode_crtc *crtc_req = data;
>  	struct drm_crtc *crtc;
>  	struct drm_plane *plane;
> -	struct drm_connector **connector_set, *connector;
> -	struct drm_framebuffer *fb;
> -	struct drm_display_mode *mode;
> +	struct drm_connector **connector_set = NULL, *connector;
> +	struct drm_framebuffer *fb = NULL;
> +	struct drm_display_mode *mode = NULL;
>  	struct drm_mode_set set;
>  	uint32_t __user *set_connectors_ptr;
>  	struct drm_modeset_acquire_ctx ctx;
> @@ -598,10 +598,6 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
>  	mutex_lock(&crtc->dev->mode_config.mutex);
>  	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
>  retry:
> -	connector_set = NULL;
> -	fb = NULL;
> -	mode = NULL;
> -
>  	ret = drm_modeset_lock_all_ctx(crtc->dev, &ctx);
>  	if (ret)
>  		goto out;
> @@ -763,6 +759,12 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
>  	}
>  	kfree(connector_set);
>  	drm_mode_destroy(dev, mode);
> +
> +	/* In case we need to retry... */
> +	connector_set = NULL;
> +	fb = NULL;
> +	mode = NULL;
> +
>  	if (ret == -EDEADLK) {
>  		ret = drm_modeset_backoff(&ctx);
>  		if (!ret)
> -- 
> 2.19.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
