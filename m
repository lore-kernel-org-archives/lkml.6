Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74AFECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689C6208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DAHPGAfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689C6208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbeGPPHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:07:04 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:44431 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbeGPPHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:07:04 -0400
Received: by mail-yb0-f195.google.com with SMTP id b21-v6so1379690yba.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 07:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j1U2p8MyroRxhi7NG/UQ91LVLaDxg/OWCjfHgw/lobw=;
        b=DAHPGAfozspxj/u8IcvQNhqxkbH8vEVefrcYkA/oegr5tz1UODcXJudECPLPrTDxTp
         paKZgz1oFMYEninCG8RjifJ798il5Iz08szX7Il4ZyFGGBkbaFHraE0H21jjAlu/z+jP
         3rL81/LQTzyChMIwGJxr3RqR6Eb51+XQPD/uA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j1U2p8MyroRxhi7NG/UQ91LVLaDxg/OWCjfHgw/lobw=;
        b=IkFQZw3MS99bWq29tEOEP+F315F3xf71aZeu8SsHNrOkhKxHBqFQK7PQErxomnJczZ
         jmovEcV6dlHWMg4UkYe70tPWf2gVPvZ1hQaOWd6b8D6JTNZYzlek405ElQqPXDedYzAc
         MVpJ6h5YdHdUxo7nyHEu1ZCuHhqCBDs5ltgqpzw5mBVFxeZwgLktr0DriZG4ul1L6FW4
         t3k7XKRaMoToXzl4AEM5HQOkhpd+YQDwgFXlzeNxQWkdPXv7KynqEsip1yWQ89NDAbnL
         4qSrn1U9eP8JFj1Si+PQVNp1OfXXTEh0SZV9EiWFkDQKIq53AM+fUGfeotZORNvzkrgF
         rdQA==
X-Gm-Message-State: AOUpUlH5YOcXLPCKHehL3fTbx77J7iUtcKLsahgkIfr+G2zF+v/CepP+
        hN5fj/CunEM5YWCyGOkWw2Y7LA==
X-Google-Smtp-Source: AAOMgpeRrmVCqPVVOE/ieAE+3Qng75mTJmh285JDwKNUAQkc0kPjOE3UD1vXW4AA/QUB2bMYPfWzyA==
X-Received: by 2002:a25:854f:: with SMTP id f15-v6mr8888695ybn.119.1531751960020;
        Mon, 16 Jul 2018 07:39:20 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id r132-v6sm18780834ywb.0.2018.07.16.07.39.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 07:39:19 -0700 (PDT)
Date:   Mon, 16 Jul 2018 10:39:18 -0400
From:   Sean Paul <seanpaul@chromium.org>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: re-enable error handling
Message-ID: <20180716143918.GT20303@art_vandelay>
References: <1531571532-22733-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531571532-22733-1-git-send-email-hofrat@osadl.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 02:32:12PM +0200, Nicholas Mc Guire wrote:
> drm_legacy_ctxbitmap_next() returns idr_alloc() which can return
> -ENOMEM, -EINVAL or -ENOSPC none of which are -1 . but the call sites 
> of drm_legacy_ctxbitmap_next() seem to be assuming that the error case
> would be -1 (original return of drm_ctxbitmap_next() prior to 2.6.23
> was actually -1). Thus reenable error handling by checking for < 0.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Thanks for your patch, I've applied it to drm-misc-fixes.

Sean

> Fixes: 62968144e673 ("drm: convert drm context code to use Linux idr")
> ---
> 
> Problem located with experimental coccinelle script
> 
> The noted Fixes tag is one of the commits that removed the -1 return
> value in 2.6.23 in drm_ctxbitmap_next() but thats not the only change
> that must have taken place to invalidate the error check.
> 
> Patch was compile tested with: x86_64_defconfig
> 
> Patch is against 4.18-rc4 (localversion-next is next-20180713)
> 
>  drivers/gpu/drm/drm_context.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_context.c b/drivers/gpu/drm/drm_context.c
> index 3c4000f..f973d28 100644
> --- a/drivers/gpu/drm/drm_context.c
> +++ b/drivers/gpu/drm/drm_context.c
> @@ -372,7 +372,7 @@ int drm_legacy_addctx(struct drm_device *dev, void *data,
>  		ctx->handle = drm_legacy_ctxbitmap_next(dev);
>  	}
>  	DRM_DEBUG("%d\n", ctx->handle);
> -	if (ctx->handle == -1) {
> +	if (ctx->handle < 0) {
>  		DRM_DEBUG("Not enough free contexts.\n");
>  		/* Should this return -EBUSY instead? */
>  		return -ENOMEM;
> -- 
> 2.1.4
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
