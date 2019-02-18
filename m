Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05CFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB66214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RG9e6sXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfBRI5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:57:06 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44945 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbfBRI5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:57:05 -0500
Received: by mail-ed1-f66.google.com with SMTP id b20so13110189edw.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 00:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ncFE0M7ZU73v8qcno5FggSq45D9O0+oDNn2HoG2smmg=;
        b=RG9e6sXhFxhjMSJMufiWvYxpn40QvEDSdyN04RIXVq1gtbkO8neyEyX5I33BnC3uFS
         3kUXgpuEdfn5cjzJjPsRZIks/o9ZWurHrJ5DP+4foTHVhKjVgTaQaNetcUJeHaZsVPB8
         t824ymj2ldAMkWsAc/hRF8iJb4+6ang2AMcUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ncFE0M7ZU73v8qcno5FggSq45D9O0+oDNn2HoG2smmg=;
        b=eLigGsZU0Zx12t1SuFjd6bq27vgxTuwbaSuQmxl2WJveKm3fjr7RQZWKZB7C70tQfB
         9skcu0JQ+Cx41sv4IzRPTKdzv9QQxXiYZyuEQ4YD+/J6FGKFyB6NA69okR1qtD23c3Xn
         rcMqpRHtykgauAjLntpR/c+XgppN9U3D4kmbhfLn0+mz43+7DXyI4ta3SJoW29xpYlgf
         lmXQgiBJOqY1jkTnEJtB391Ybo8B9Ls7DoAyr50Zmd2ojlVdf/o4xt0xeO48f/x79+vz
         pUDN6BpauhfGDmyjalXUMEvdXjxso8P9gFsS2FlumqG3aMFVI3JEgQoXLKyfRJM3pxdx
         6jEA==
X-Gm-Message-State: AHQUAuaIdkW3flo/w2sET2QkNr0U+UbyD0S3auftDGVp2ehDlii5C+zy
        oC69CNM9ae1vRZ0xA5AZ3jT81w==
X-Google-Smtp-Source: AHgI3IYQ3OTV/+cB1xN50cs09b+dozWw8TaNTcX22cjaPjjJaYm7AvW6kJ/c82UAwQ/b2EfH96Eg6Q==
X-Received: by 2002:a50:9ea1:: with SMTP id a30mr17680325edf.104.1550480223957;
        Mon, 18 Feb 2019 00:57:03 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id j24-v6sm2858711ejd.53.2019.02.18.00.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 00:57:03 -0800 (PST)
Date:   Mon, 18 Feb 2019 09:57:01 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] drm/drm_vm: Mark expected switch fall-throughs
Message-ID: <20190218085701.GR2665@phenom.ffwll.local>
Mail-Followup-To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20190215170546.GA30950@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215170546.GA30950@embeddedor>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 11:05:46AM -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> Notice that, in this particular case, the code comment is modified
> in accordance with what GCC is expecting to find.
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Queued for 5.2, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/drm_vm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
> index c3301046dfaa..8987501f53b2 100644
> --- a/drivers/gpu/drm/drm_vm.c
> +++ b/drivers/gpu/drm/drm_vm.c
> @@ -584,8 +584,8 @@ static int drm_mmap_locked(struct file *filp, struct vm_area_struct *vma)
>  			vma->vm_ops = &drm_vm_ops;
>  			break;
>  		}
> -		/* fall through to _DRM_FRAME_BUFFER... */
>  #endif
> +		/* fall through - to _DRM_FRAME_BUFFER... */
>  	case _DRM_FRAME_BUFFER:
>  	case _DRM_REGISTERS:
>  		offset = drm_core_get_reg_ofs(dev);
> @@ -610,7 +610,7 @@ static int drm_mmap_locked(struct file *filp, struct vm_area_struct *vma)
>  		    vma->vm_end - vma->vm_start, vma->vm_page_prot))
>  			return -EAGAIN;
>  		vma->vm_page_prot = drm_dma_prot(map->type, vma);
> -	/* fall through to _DRM_SHM */
> +		/* fall through - to _DRM_SHM */
>  	case _DRM_SHM:
>  		vma->vm_ops = &drm_vm_shm_ops;
>  		vma->vm_private_data = (void *)map;
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
