Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E53EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DED20865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HcHEXw7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58DED20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393424AbeKVTq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:46:26 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37966 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730412AbeKVTqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:46:25 -0500
Received: by mail-ed1-f67.google.com with SMTP id h50so7080058ede.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 01:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Q6RDoYKBqQDuCgVgXNYzUjuR7GzxWMvw/p+UeiHTio=;
        b=HcHEXw7Ei38bYwxC0luNqX6pdjE+eraMg17LkjwLbZk0ChBOdN+SD3JaQwQnFMtb7z
         8tiva+KsG9yZSVFEUlHO+4sHPOIzDMHhjbFz74YVq2nMq9FxkykzCRnE15xI5ov9Ny5e
         +E9E6njhuaocKdufOcLWUa9nWVsh2LEcG9F4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=9Q6RDoYKBqQDuCgVgXNYzUjuR7GzxWMvw/p+UeiHTio=;
        b=NOUjsMle6baUhr+U3jKYsHZ2ryYAng7dGkYuRARHeG11LOoLZ0FhWFyLtAxCB5xDGz
         fPMcIhth4qSS+yEt6BFRZCM2FDwqMXtWAUeGnqZvZCiZt8eRHnqx0iWeJaygjKeU91cW
         E/gafHa+JkZkR0z/KOXEZmn/0LoqsnTO4PAuFOkJpp/JHERQo30LV4MSr2VXzFfLE5V6
         ajX8Jujghcgy/X0fTwQNwnTx50ZhRaOjX1J81nPFuNihXthOwPu+oyTaE08NlMT+U05d
         OZJ/ObyznITIlv7PRD5pv+QTbi/n4iHmRXeoWbDJcCnOQ1NnyiJzZhi1TRLhentXOjTW
         bzjg==
X-Gm-Message-State: AGRZ1gI5F9vdeQ2QkGlhn5G8UOQFFR71NQq/Wb1RFsD4rbEFHdKe69NX
        iVwYBe8L60uO4AeP2utoGAHdVg==
X-Google-Smtp-Source: AJdET5cctO8YaYPFeqKXq5JiYvqXmD7QeM8i15TSZFLX2fFQQ5HHnDKFwB5ChovLleH52ziywtJ4KQ==
X-Received: by 2002:a17:906:a44:: with SMTP id x4-v6mr7453107ejf.177.1542877669944;
        Thu, 22 Nov 2018 01:07:49 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id r18-v6sm8068973eja.19.2018.11.22.01.07.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 01:07:49 -0800 (PST)
Date:   Thu, 22 Nov 2018 10:07:47 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Qiang Yu <yuq825@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH] drm/sun4i: wait on implicit fence before display
Message-ID: <20181122090747.GB4266@phenom.ffwll.local>
Mail-Followup-To: Qiang Yu <yuq825@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>
References: <20181122014417.23285-1-yuq825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122014417.23285-1-yuq825@gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 09:44:17AM +0800, Qiang Yu wrote:
> Render like lima will attach a fence to the framebuffer
> dma_buf, display like sun4i should wait it finish before
> show the framebuffer. Otherwise tearing will be observed.
> 
> Signed-off-by: Qiang Yu <yuq825@gmail.com>

Thanks for submitting this fix, applied to drm-misc-next.
-Daniel

> ---
>  drivers/gpu/drm/sun4i/sun4i_layer.c    | 2 ++
>  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 2 ++
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 2 ++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
> index 750ad24de1d7..d68e663df9a0 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
> @@ -12,6 +12,7 @@
>  
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_plane_helper.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drmP.h>
>  
>  #include "sun4i_backend.h"
> @@ -114,6 +115,7 @@ static void sun4i_backend_layer_atomic_update(struct drm_plane *plane,
>  }
>  
>  static const struct drm_plane_helper_funcs sun4i_backend_layer_helper_funcs = {
> +	.prepare_fb	= drm_gem_fb_prepare_fb,
>  	.atomic_disable	= sun4i_backend_layer_atomic_disable,
>  	.atomic_update	= sun4i_backend_layer_atomic_update,
>  };
> diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> index 28c15c6ef1ef..7bc2ca2bd0c3 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> @@ -19,6 +19,7 @@
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_fb_cma_helper.h>
>  #include <drm/drm_gem_cma_helper.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_plane_helper.h>
>  #include <drm/drmP.h>
>  
> @@ -287,6 +288,7 @@ static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
>  }
>  
>  static struct drm_plane_helper_funcs sun8i_ui_layer_helper_funcs = {
> +	.prepare_fb	= drm_gem_fb_prepare_fb,
>  	.atomic_check	= sun8i_ui_layer_atomic_check,
>  	.atomic_disable	= sun8i_ui_layer_atomic_disable,
>  	.atomic_update	= sun8i_ui_layer_atomic_update,
> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> index f4fe97813f94..815895795afd 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> @@ -13,6 +13,7 @@
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_fb_cma_helper.h>
>  #include <drm/drm_gem_cma_helper.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_plane_helper.h>
>  #include <drm/drmP.h>
>  
> @@ -315,6 +316,7 @@ static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
>  }
>  
>  static struct drm_plane_helper_funcs sun8i_vi_layer_helper_funcs = {
> +	.prepare_fb	= drm_gem_fb_prepare_fb,
>  	.atomic_check	= sun8i_vi_layer_atomic_check,
>  	.atomic_disable	= sun8i_vi_layer_atomic_disable,
>  	.atomic_update	= sun8i_vi_layer_atomic_update,
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
