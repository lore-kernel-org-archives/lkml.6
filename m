Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CDFC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D203121738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MaJ0AoeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbfAIKKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:10:50 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45057 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729281AbfAIKKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:10:49 -0500
Received: by mail-ed1-f65.google.com with SMTP id d39so6777855edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 02:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uJbJ4UP1+2isnhipetsVHXrLnq1QpwTD0XItJlhIzU8=;
        b=MaJ0AoeCi/lkfhayt30FgT/qApqZYMm8n5E2slCGrrCan/or34+k36aOiX/70XxTB9
         6dMIaxTsmLlOz3NJH11LGu1JGvXicdjMjhHzIRPWJ4WF5zOlg7zArIzdHyqW4jpSDU6z
         gGAI6MDtyXxA0nbTdUstUleujzHxDKh16EaJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=uJbJ4UP1+2isnhipetsVHXrLnq1QpwTD0XItJlhIzU8=;
        b=jfXDhbTYw8AGrzKcRdgVOzUhEmQ7qiq/J9XGo5CYlYzV242DKtjwvfh91al04a6jq+
         WQtb9vXN01JVp5inthUTEvXqA1Mvs0RZC3nO1O2Y/ffP9AAcRpuGgtI3EH0ua3ocCCQH
         rukAQ3b8L1aJBjrJ/WLagA+3jvDJbGINxcqRzQ4/za3CjN+0UrGHIqeBqbAFCvVzhbc0
         3ODdz9o4ihbik4hkOxj24NugWsYT6NoC1C2qBmTQa3Yhmu25Jv8jKGe6Og4h3D4UPly9
         5R/xutYNoNXecaNEcFsveWy9OOR9JO2kMjpay9e8RbuvH80as5U1ZL2IiatHAhgN5FXy
         Ts5A==
X-Gm-Message-State: AJcUukf+9oTGKU43ckrEDUWgcniq0oD3CpYxxe8zi7Jk4DzQlgaRkega
        JhDcqZ9yBmqhnXaz2MinM3lsBg==
X-Google-Smtp-Source: ALg8bN5HIE6LG/qEaIdcYsjtoVUz1nvPMLx9DJ7BFyczpaYNCjegLFiF3NUy6z5sW2s9h+kcA23LaQ==
X-Received: by 2002:a50:aa31:: with SMTP id o46mr5378174edc.23.1547028647347;
        Wed, 09 Jan 2019 02:10:47 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id cd6-v6sm699316ejb.14.2019.01.09.02.10.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 02:10:46 -0800 (PST)
Date:   Wed, 9 Jan 2019 11:10:44 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
        andr2000@gmail.com, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v2 15/15] drm/bochs: reserve bo for pin/unpin
Message-ID: <20190109101044.GS21184@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
        andr2000@gmail.com, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
References: <20190108112519.27473-1-kraxel@redhat.com>
 <20190108112519.27473-16-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108112519.27473-16-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 12:25:19PM +0100, Gerd Hoffmann wrote:
> The buffer object must be reserved before calling
> ttm_bo_validate for pinning/unpinning.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Seems a bit a bisect fumble in your series here: legacy kms code reserved
the ttm bo before calling boch_bo_pin/unpin, your atomic code doesn't. I
think pushing this into bochs_bo_pin/unpin makes sense for atomic, but to
avoid bisect fail I think you need to have these temporarily in your
cleanup/prepare_plane functions too.

Looked through the entire series, this here is the only issue I think
should be fixed before merging (making atomic_enable optional can be done
as a follow-up if you feel like it). With that addressed on the series:

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/bochs/bochs_mm.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
> index cfe061c25f..970a591908 100644
> --- a/drivers/gpu/drm/bochs/bochs_mm.c
> +++ b/drivers/gpu/drm/bochs/bochs_mm.c
> @@ -223,7 +223,11 @@ int bochs_bo_pin(struct bochs_bo *bo, u32 pl_flag)
>  	bochs_ttm_placement(bo, pl_flag);
>  	for (i = 0; i < bo->placement.num_placement; i++)
>  		bo->placements[i].flags |= TTM_PL_FLAG_NO_EVICT;
> +	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
> +	if (ret)
> +		return ret;
>  	ret = ttm_bo_validate(&bo->bo, &bo->placement, &ctx);
> +	ttm_bo_unreserve(&bo->bo);
>  	if (ret)
>  		return ret;
>  
> @@ -247,7 +251,11 @@ int bochs_bo_unpin(struct bochs_bo *bo)
>  
>  	for (i = 0; i < bo->placement.num_placement; i++)
>  		bo->placements[i].flags &= ~TTM_PL_FLAG_NO_EVICT;
> +	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
> +	if (ret)
> +		return ret;
>  	ret = ttm_bo_validate(&bo->bo, &bo->placement, &ctx);
> +	ttm_bo_unreserve(&bo->bo);
>  	if (ret)
>  		return ret;
>  
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
