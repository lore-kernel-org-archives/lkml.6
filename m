Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D82BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704CF2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RFhBogEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfARPtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:49:50 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43251 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfARPtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:49:50 -0500
Received: by mail-ed1-f67.google.com with SMTP id f9so11450971eds.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 07:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rgTxmlMSyHnluttuc05ssLLj+B545sn7EqCNp+Qi0sU=;
        b=RFhBogEEddfzLsMIXlgNPuZXt5KsVcRapklqs4asQJfkET4BI2HOBkXwsluGQ+zE8d
         2pLM8ARFDiEOKaL5bevKAFDhbYwq1lvLMNVSBvVt9DCdyhZv1KW/XsPjc1kXScJHKtcy
         VUGPYXx6aJKyxzzjCiPm3cFSMEdSMidqHDLpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=rgTxmlMSyHnluttuc05ssLLj+B545sn7EqCNp+Qi0sU=;
        b=Wp2H3wBUcxsfJByKTELhsBKCFNBzq4ovgNHTza/r+Duttvow+gPD2i5WJ55Fr+h2YD
         4feUNIA+rKMenjbfjJJCMomfxDIvix9BLRB+NJLIOrUNewKI+X15tWsuMYs/3s82UzqB
         0CqvIU2zWUgxIGynlx1Ed2ONv6Tqaql0XXoqAbZrtJ53NLjmPg6/V6HEqT+QfO93NQ9K
         3+FXHU4VSeoaUZ7+OBxK8h5EojhvFmUXVAK6wVAosetApHyTPM/H/+8TxwJRStqBk4fT
         7mZOLli4/bFxpRkT39R54uOk53HZGtHh99MOZi6OKW8ixlcYb575PRg9n1WuzgotQA9F
         78sw==
X-Gm-Message-State: AJcUukcqA1aC3VSqim0QX9tMFG0wZKDg5cdyF459tziYFu+5mFfCNWAp
        Sd4eUEv2d+NAHkKiES39G532aQ==
X-Google-Smtp-Source: ALg8bN4/y6s5P5TJ6PYKxPftbCK3h5A7x+3obvEJnfN2h834rDlcmONwRxTsHF1pzEZwfyOVbgUJSw==
X-Received: by 2002:a50:e045:: with SMTP id g5mr16737411edl.152.1547826587777;
        Fri, 18 Jan 2019 07:49:47 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id v20sm7194012edm.29.2019.01.18.07.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 07:49:46 -0800 (PST)
Date:   Fri, 18 Jan 2019 16:49:44 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 23/23] drm/qxl: add overflow checks to
 qxl_mode_dumb_create()
Message-ID: <20190118154944.GH3271@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190118122020.27596-1-kraxel@redhat.com>
 <20190118122020.27596-24-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118122020.27596-24-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 01:20:20PM +0100, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

We already do all reasonable overflow checks in drm_mode_create_dumb(). If
you don't trust them I think would be better time spent typing an igt to
test this than adding redundant check in all drivers.

You're also missing one check for bpp underflows :-)
-Daniel

> ---
>  drivers/gpu/drm/qxl/qxl_dumb.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_dumb.c b/drivers/gpu/drm/qxl/qxl_dumb.c
> index 272d19b677..bed6d06ee4 100644
> --- a/drivers/gpu/drm/qxl/qxl_dumb.c
> +++ b/drivers/gpu/drm/qxl/qxl_dumb.c
> @@ -37,11 +37,13 @@ int qxl_mode_dumb_create(struct drm_file *file_priv,
>  	uint32_t handle;
>  	int r;
>  	struct qxl_surface surf;
> -	uint32_t pitch, format;
> +	uint32_t pitch, size, format;
>  
> -	pitch = args->width * ((args->bpp + 1) / 8);
> -	args->size = pitch * args->height;
> -	args->size = ALIGN(args->size, PAGE_SIZE);
> +	if (check_mul_overflow(args->width, ((args->bpp + 1) / 8), &pitch))
> +		return -EINVAL;
> +	if (check_mul_overflow(pitch, args->height, &size))
> +		return -EINVAL;
> +	args->size = ALIGN(size, PAGE_SIZE);
>  
>  	switch (args->bpp) {
>  	case 16:
> -- 
> 2.9.3
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
