Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1DFC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EB421721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="B16ElxWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfBGX1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 18:27:23 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40521 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfBGX1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 18:27:22 -0500
Received: by mail-ed1-f66.google.com with SMTP id g22so1313398edr.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 15:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LdMoHHLvnbLkkA3ozqnBMO7BjIN/gQnINih51z3iCCc=;
        b=B16ElxWd9FOlhY/K+xGdA5UKaL8iCel7mmmLHd3ZaD+2FvwipXKuLagl5KIna4cee3
         RqCIUo4WuPqUbpCg56qgM2NwgYeAJJZVHAxHqehyVq8kV1oWD1sPgqJAYsAKJNbq37p+
         NcizTRJ5CQmLrWX4C+YXH6G1xO5ZGqeoarxtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=LdMoHHLvnbLkkA3ozqnBMO7BjIN/gQnINih51z3iCCc=;
        b=C1o4WXji553YPPI2AOXUSaKCVFxSBK50PssCPsa23sRWx1f/BlC/YA41AxS1gh6KhF
         Z9dEn+zcnkHib/Jh+nNDOTEGOwgnMF86D5w4t9g0ZGU1LOmQi12Vl5F1CWcmMFY/rS3G
         IeZTAVWY77ZeiySaLGLRFAGsk6SqrKQfUU8FsmfupBtjBVjd3kMGS3Vq7TNzieAj38k0
         wnUQVDhOC+98il6FxFD2YKREeDpqwaH191+tDsGrhtt883mfFJRBJpD4C2RpzIqXlPaH
         o7gyydDL3I1I6skNUxgQ5cnAMjMamiLQvOK89u58oT2fEDN6vrArXCDB9j/k6Xfaxnr6
         5mbw==
X-Gm-Message-State: AHQUAuadXFixiqomT0iPS3o/vtmtBA+4BLkti0UZvN7Iq8UzIP+wFWs9
        9Sr7ENQ0Uo9Sl2eQqiCSF7a8iw==
X-Google-Smtp-Source: AHgI3IYO5ylTqY1XCCyQebe+WvapLQpi5W8qt4VJTC3iR/NNqLf7d+jTPyrMPqXWhVoz6L6dORCLyQ==
X-Received: by 2002:aa7:d749:: with SMTP id a9mr14102324eds.223.1549582040902;
        Thu, 07 Feb 2019 15:27:20 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id a29sm49005edc.90.2019.02.07.15.27.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 15:27:19 -0800 (PST)
Date:   Fri, 8 Feb 2019 00:27:17 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, david.emett@broadcom.com,
        thomas.spurden@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/v3d: Fix BO stats accounting for dma-buf-imported
 buffers.
Message-ID: <20190207232717.GG23159@phenom.ffwll.local>
Mail-Followup-To: Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org, david.emett@broadcom.com,
        thomas.spurden@broadcom.com, linux-kernel@vger.kernel.org
References: <20190207232613.24981-1-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207232613.24981-1-eric@anholt.net>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 03:26:13PM -0800, Eric Anholt wrote:
> We always decrement at GEM free, so make sure we increment at GEM
> creation for dma-bufs.

Indeed. Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/gpu/drm/v3d/v3d_bo.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
> index a08766d39eab..b1766f096c4b 100644
> --- a/drivers/gpu/drm/v3d/v3d_bo.c
> +++ b/drivers/gpu/drm/v3d/v3d_bo.c
> @@ -282,6 +282,7 @@ v3d_prime_import_sg_table(struct drm_device *dev,
>  			  struct dma_buf_attachment *attach,
>  			  struct sg_table *sgt)
>  {
> +	struct v3d_dev *v3d = to_v3d_dev(dev);
>  	struct drm_gem_object *obj;
>  	struct v3d_bo *bo;
>  
> @@ -296,6 +297,11 @@ v3d_prime_import_sg_table(struct drm_device *dev,
>  	obj->import_attach = attach;
>  	v3d_bo_get_pages(bo);
>  
> +	mutex_lock(&v3d->bo_lock);
> +	v3d->bo_stats.num_allocated++;
> +	v3d->bo_stats.pages_allocated += obj->size >> PAGE_SHIFT;
> +	mutex_unlock(&v3d->bo_lock);
> +
>  	v3d_mmu_insert_ptes(bo);
>  
>  	return obj;
> -- 
> 2.20.0.rc1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
