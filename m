Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A89C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 11:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F4B214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 11:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="lxefvhKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbeL0Lr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 06:47:29 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42766 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbeL0Lr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 06:47:29 -0500
Received: by mail-ed1-f67.google.com with SMTP id y20so15032626edw.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 03:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=T9EQeQqyXSQT9eLYZlJGFkV2DHt4b7iWeFMtPC8nNSo=;
        b=lxefvhKZ1BoMkP0htwWXNy/hM1RjYF0mfn6ZTCewqX9m6AfXWNIEhPtoZnh27UteKR
         LyZetsee8ZM9+wCnUsKZy0IDGZg/KSkf3kHmTYFIScWY5Lb7BnQH97cUUBS0rT64eegr
         hn5zlGPR19Rlmwn936QZrcvHjMVtxslBkfTp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=T9EQeQqyXSQT9eLYZlJGFkV2DHt4b7iWeFMtPC8nNSo=;
        b=L9nFiL8SenPdK1fOH9tBYKCI0iS8tzRqiO92v+spVKtWFogvBthXhj2y7rCVAAjQaV
         s+6v1ulRK2K5JvXgxFzSTUpKJ4qQy6ZO3hO64qer6TfgkZNmGwncJM04k6DXFaUSLq1B
         YZ/09+iFFATlcpsTBkligJ+7a3Z/P2U07pRsvkdMBuo4vO5EE21RYkDijUQwpDo6TNLG
         TGC1PXnAw79nJ/2uy3B8ESMllMLjJSQJVH66GlzDebyl6SIw86aOCl9VazhrabzdhTiv
         LeH+9nK+84Oyjfir36X7/60ACFg01DXAtpfHLLK/TuqjzQ/VGsV0QNNe4mlOw+9qYpl1
         F20w==
X-Gm-Message-State: AA+aEWYZezM+sABzpaSbfXJ2Yvgf2bgKDhbNDdOtKAhW/mR0Ok5TmY5T
        d/5YyqD1GuL+oka0V6/hihJ51Q==
X-Google-Smtp-Source: AFSGD/WOLgfSxsy65glmPVaOMu2EPDs2+Ca1NBgMKUtQwmfgbgR3mbooRoArNj5ShwYiYHyeymsLEg==
X-Received: by 2002:a17:906:495:: with SMTP id f21-v6mr15474764eja.95.1545911247044;
        Thu, 27 Dec 2018 03:47:27 -0800 (PST)
Received: from dvetter-linux.ger.corp.intel.com ([194.230.159.220])
        by smtp.gmail.com with ESMTPSA id r23-v6sm4600171eji.64.2018.12.27.03.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 03:47:26 -0800 (PST)
Date:   Thu, 27 Dec 2018 12:47:15 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        sean@poorly.run, airlied@linux.ie, sabyasachi.linux@gmail.com,
        jrdr.linux@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/drm_drv.c: Remove duplicate header
Message-ID: <20181227114704.GA9058@dvetter-linux.ger.corp.intel.com>
Mail-Followup-To: Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        sean@poorly.run, airlied@linux.ie, sabyasachi.linux@gmail.com,
        jrdr.linux@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20181224143636.GA3237@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181224143636.GA3237@hp-pavilion-15-notebook-pc-brajeswar>
X-Operating-System: Linux dvetter-linux.ger.corp.intel.com
 4.19.10-200.fc28.x86_64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 08:06:36PM +0530, Brajeswar Ghosh wrote:
> Remove drm_crtc_internal.h which is included more than once
> 
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Applied, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/drm_drv.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 4126bb6e1a4a..75f4e6bf67ca 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -41,7 +41,6 @@
>  #include "drm_crtc_internal.h"
>  #include "drm_legacy.h"
>  #include "drm_internal.h"
> -#include "drm_crtc_internal.h"
>  
>  /*
>   * drm_debug: Enable debug output.
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
