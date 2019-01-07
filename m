Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5CCC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6AC42087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="KXHXZ6CL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfAGK07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:26:59 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38508 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfAGK07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:26:59 -0500
Received: by mail-ed1-f68.google.com with SMTP id h50so361012ede.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 02:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2xFCvj/neizsBAHsdlvNCXMdbJLzn+66OrggDDOMhXU=;
        b=KXHXZ6CLUnC37uxBpCGvO8zvt0iwsbF3lk+pqCEECkzAcIAQgeFHK5k2wYM+veIz0Y
         Xh08910a7RoA2Qi10fEHuCy8QQ7Ikx/Mm5yUpbTqlt6pA0djoORFIDi8LeiSJiv9Smx3
         InIzGZ+9YUa6EKM7dhhANrWGUYHFR6Q+hLH90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=2xFCvj/neizsBAHsdlvNCXMdbJLzn+66OrggDDOMhXU=;
        b=ZN9MVz0UPj7Zi5L8be2CZIS44u1YaeG7RtUk4al7i+ZxhrKE86o01Mws7b8tQkqFgr
         WGsUdsqSzxxBxCXou0NEno/lxH/0RoZwqKFy+I2CZ1o9Y+VT0b/xob+WeA7MAYokxzMo
         jL6pMehUabEySykC4E1vVG8If+Iij4pK6cHAm3IyBNyJu6h9P7NjcvmWLeo20wu5JnV6
         AFSsrRvGnRpvpX47/xYU5R29DMfPPiA/H2CAOnwcD4VqSwqugTwKjxvCK6TB+3cacSeb
         yq/ecqEu2IIYlszL/oSJcG9oAYDL2HZPFedbZ/Gz4IAZg8yDGqIOiGvEkNeb9y51nZcq
         k1Kg==
X-Gm-Message-State: AA+aEWY6tJo1BTGXEIYXl1iHFt9zYn+JEeJYS06mBZBWtqrnW8tKc/G7
        rmzHNOk0KvtkeTdyUWyYOngmig==
X-Google-Smtp-Source: AFSGD/UJM7TehAf5CcRINQxLdeilw9C6VquUPUHQWrbao551zMG3HHwCW9FuV872abQTGCyEgXCS+A==
X-Received: by 2002:aa7:da57:: with SMTP id w23mr55809013eds.7.1546856817827;
        Mon, 07 Jan 2019 02:26:57 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id m44sm31219997edm.54.2019.01.07.02.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 02:26:57 -0800 (PST)
Date:   Mon, 7 Jan 2019 11:26:55 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH -next] drm: Fix error handling in drm_legacy_addctx
Message-ID: <20190107102655.GD21184@phenom.ffwll.local>
Mail-Followup-To: YueHaibing <yuehaibing@huawei.com>,
        maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        sean@poorly.run, airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20181229024907.12852-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181229024907.12852-1-yuehaibing@huawei.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 10:49:07AM +0800, YueHaibing wrote:
> 'ctx->handle' is unsigned, it never less than zero.
> This patch use int 'tmp_handle' to handle the err condition.
> 
> Fixes: 62968144e673 ("drm: convert drm context code to use Linux idr")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Queue for 5.1 (since this is essentially dead legacy code there's no
really a need to backport this).
-Daniel

> ---
>  drivers/gpu/drm/drm_context.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_context.c b/drivers/gpu/drm/drm_context.c
> index 506663c..8e73fab 100644
> --- a/drivers/gpu/drm/drm_context.c
> +++ b/drivers/gpu/drm/drm_context.c
> @@ -361,23 +361,26 @@ int drm_legacy_addctx(struct drm_device *dev, void *data,
>  {
>  	struct drm_ctx_list *ctx_entry;
>  	struct drm_ctx *ctx = data;
> +	int tmp_handle;
>  
>  	if (!drm_core_check_feature(dev, DRIVER_KMS_LEGACY_CONTEXT) &&
>  	    !drm_core_check_feature(dev, DRIVER_LEGACY))
>  		return -EOPNOTSUPP;
>  
> -	ctx->handle = drm_legacy_ctxbitmap_next(dev);
> -	if (ctx->handle == DRM_KERNEL_CONTEXT) {
> +	tmp_handle = drm_legacy_ctxbitmap_next(dev);
> +	if (tmp_handle == DRM_KERNEL_CONTEXT) {
>  		/* Skip kernel's context and get a new one. */
> -		ctx->handle = drm_legacy_ctxbitmap_next(dev);
> +		tmp_handle = drm_legacy_ctxbitmap_next(dev);
>  	}
> -	DRM_DEBUG("%d\n", ctx->handle);
> -	if (ctx->handle < 0) {
> +	DRM_DEBUG("%d\n", tmp_handle);
> +	if (tmp_handle < 0) {
>  		DRM_DEBUG("Not enough free contexts.\n");
>  		/* Should this return -EBUSY instead? */
> -		return -ENOMEM;
> +		return tmp_handle;
>  	}
>  
> +	ctx->handle = tmp_handle;
> +
>  	ctx_entry = kmalloc(sizeof(*ctx_entry), GFP_KERNEL);
>  	if (!ctx_entry) {
>  		DRM_DEBUG("out of memory\n");
> -- 
> 2.7.0
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
