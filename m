Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE98BECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F62620693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FoDh8Rx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F62620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbeGQUse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:48:34 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:39149 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729728AbeGQUsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:48:33 -0400
Received: by mail-yw0-f195.google.com with SMTP id r184-v6so864690ywg.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 13:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mu99MLzTa/RgV55rKC/mAxnmvv4YfuC72J29XjCEt4k=;
        b=FoDh8Rx08ow3FLXrHwNyIhp6eWuJUal7Py73YGVhhglnAV7Fk9uC9TLq67AujdNklO
         HxUTTVaBdeYe+GGDvbAOd75GEXImdVPkarg4DKVkTUmUN+XuFJkoXRTt73GYRPwIryV1
         F4kwpXlrZcV/g7dOmi4/XpI7wbmW6+LhGrXC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mu99MLzTa/RgV55rKC/mAxnmvv4YfuC72J29XjCEt4k=;
        b=Ey4+0XzDfEEPv2IjIw1anjhDVM+8h+3VWRpnRp3H8LR+ERgoSbFqenZG7W7FG5UkZa
         mQ4mKZx1Q3ZhqycFfked4zF0ohEEABT7l0zKvWbSuazTNlW5wRV5wPRQzdvwcniahcE4
         qNxV83DfsPJi2v3d2b66wd+63Fc0swOyrTtzeUrcip5QUJ4SwYbCYfC3jP4i5b29Sp/r
         kk/ZiNvlFttrEMZxj1THwIRn31tOSmtez2xf1UFWVTHsHxFCwflAMIf9k/QNo/JtCOB3
         gLVMmp/F0yAV9y+6mu/61rj01GSZypwFC/qHWCx2qqcgszz+rpxpbIsbC3TgCuOc6YP4
         ZPAQ==
X-Gm-Message-State: AOUpUlFrJr5TpWd+tPQ2bqzv0dNf7OFBpwPJLq41CfzPYXUk0sCwk8Or
        QHAtWlZjaLVNRAjwuIn8tWwKNA==
X-Google-Smtp-Source: AAOMgpdxsXmtkU1zNdpi/tcDR2+SYd66orr2lUg2gJ6TBwi818M373DN6qiyRm7oAPebbrBmPHkFuA==
X-Received: by 2002:a0d:cac5:: with SMTP id m188-v6mr1603195ywd.307.1531858457418;
        Tue, 17 Jul 2018 13:14:17 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id u64-v6sm2346171ywu.107.2018.07.17.13.14.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 13:14:16 -0700 (PDT)
Date:   Tue, 17 Jul 2018 16:14:16 -0400
From:   Sean Paul <seanpaul@chromium.org>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Gustavo Padovan <gustavo@padovan.org>,
        Li Philip <philip.li@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] drm: handle error values properly
Message-ID: <20180717201416.GZ20303@art_vandelay>
References: <1531834101-6018-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531834101-6018-1-git-send-email-hofrat@osadl.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 03:28:21PM +0200, Nicholas Mc Guire wrote:
> drm_legacy_ctxbitmap_next() returns idr_alloc() which can return
> -ENOMEM, -EINVAL or -ENOSPC none of which are -1. since drm_context_t
> is an unsigned int an intermediate variable is used to handle the
> error cases, and then cast to drm_context_t after ensuring that the
> value is >= 0. The explicit cast is to mark the type conversion as
> intentional.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: d530b5f1ca0b ("drm: re-enable error handling")
> Fixes: 62968144e673 ("drm: convert drm context code to use Linux idr")
> ---
> 
> kbuild test robot reported:
> <snip>
> tree:   git://anongit.freedesktop.org/drm/drm-misc for-linux-next-fixes
> head:   d530b5f1ca0bb66958a2b714bebe40a1248b9c15
> commit: d530b5f1ca0bb66958a2b714bebe40a1248b9c15 [2/2] drm: re-enable error
> +handling
> 
> smatch warnings:
> drivers/gpu/drm/drm_context.c:375 drm_legacy_addctx() warn: unsigned
> +'ctx->handle' is never less than zero.
> <snip>
> 
> V2: The proposed fix in d530b5f1ca0b ("drm: re-enable error handling")
>     actually was ineffective as the negative return value check was 
>     against a unsigned int and thus always false as reported by
>     kbuild test robot <lkp@intel.com>. The below patch removes that
>     warning and fixes the original problem of missed error handling.
> 
> drm_context_t is actually just used in a few placed so the type could be
> changed but it is also exported via tools/include/uapi/drm/drm.h so
> changing the typedef of drm_context_t could break applications and thus
> this is not an option.
> 
> Patch was compile tested with: x86_64_defconfig
> 
> Patch is against 4.18-rc4 (localversion-next is next-20180717)
> 
>  drivers/gpu/drm/drm_context.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_context.c b/drivers/gpu/drm/drm_context.c
> index 3c4000f..78f32a3 100644
> --- a/drivers/gpu/drm/drm_context.c
> +++ b/drivers/gpu/drm/drm_context.c
> @@ -361,22 +361,26 @@ int drm_legacy_addctx(struct drm_device *dev, void *data,
>  {
>  	struct drm_ctx_list *ctx_entry;
>  	struct drm_ctx *ctx = data;
> +	int ret;
>  
>  	if (!drm_core_check_feature(dev, DRIVER_KMS_LEGACY_CONTEXT) &&
>  	    !drm_core_check_feature(dev, DRIVER_LEGACY))
>  		return -EINVAL;
>  
>  	ctx->handle = drm_legacy_ctxbitmap_next(dev);

Remove this call?

Sean

> -	if (ctx->handle == DRM_KERNEL_CONTEXT) {
> +	ret = drm_legacy_ctxbitmap_next(dev);
> +	if (ret == DRM_KERNEL_CONTEXT) {
>  		/* Skip kernel's context and get a new one. */
> -		ctx->handle = drm_legacy_ctxbitmap_next(dev);
> +		ret = drm_legacy_ctxbitmap_next(dev);
>  	}
> -	DRM_DEBUG("%d\n", ctx->handle);
> -	if (ctx->handle < 0) {
> +	DRM_DEBUG("ctxbitmap is error code %d\n", ret);
> +	if (ret < 0) {
>  		DRM_DEBUG("Not enough free contexts.\n");
>  		/* Should this return -EBUSY instead? */
>  		return -ENOMEM;
>  	}
> +	/* valid context is >= 0 */
> +	ctx->handle = (drm_context_t)ret;
>  
>  	ctx_entry = kmalloc(sizeof(*ctx_entry), GFP_KERNEL);
>  	if (!ctx_entry) {
> -- 
> 2.1.4
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
