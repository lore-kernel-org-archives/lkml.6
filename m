Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59758C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B49120870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="DBmHbzHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B49120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeLJK1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:27:06 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44938 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbeLJK1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:27:06 -0500
Received: by mail-ed1-f65.google.com with SMTP id y56so8968400edd.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 02:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YvEiIPdGs1H4UNwUr5kXxKhGDM8LgMBdM2br7i3LoLw=;
        b=DBmHbzHNGmRUOzkZ6hbbt422zoOmdhF7Mpg7D1xy2Tau2IX3WQkUhEcOQKoUe0BHEr
         2W1QJhGVqeE/PFBsTtR2Cgc1vjvyhW3K8MfTBhUrZwWoOeT2zFvKPltQrx5brB7taWaU
         R4zkcjtyllNMYdVKI1Ks437gPPKnSI7lvVrvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=YvEiIPdGs1H4UNwUr5kXxKhGDM8LgMBdM2br7i3LoLw=;
        b=cbUrj74Sc3kZqwuoe+jS6giByrZ2o1R2DNlB87JI2+ySyxfzt8KrFZp9L59Cp0/Rmz
         XmWM2sOyRjj6fr4ujtddvuvXMmMzJFBXwr/1wpMyQMr0VsrDYUB+XqUiDkeUQ3vxDS1K
         fgZAlBEM9lNeh7UO/tuvPZrRS0tyvU/xrPL0Op1nyj76xsPsfGI8ZXG8DfRjctgZvMRJ
         HhhHHABeEbAATxUZO9PZ3BPoT1ScEmZA/4dDJvw3m7LvzgO9kT12zDbgXWjTEW37QKC/
         Y1kDOGNf8Owp5doBw2vAPFf8x7uZmxj/IU8v4kyP+eT+0uKHUNpsPdGEIZ8LxADznMOD
         19uw==
X-Gm-Message-State: AA+aEWaTMrd/0tWgiskKlSbpWaDX/FSewAWI5SHAQ8oN1y84iiXkzxrg
        YE9bp082e7aKnIl5o4RB9E2vxQ==
X-Google-Smtp-Source: AFSGD/UAQJgwMfBHZZmnESmHf2MqKl6psny8cuUNXxE4118UDXSGrA9Ui8Wk9r8A07FSiRpkjBdHzQ==
X-Received: by 2002:a05:6402:758:: with SMTP id p24mr6854492edy.92.1544437623976;
        Mon, 10 Dec 2018 02:27:03 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t26sm3320934eda.22.2018.12.10.02.27.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 02:27:03 -0800 (PST)
Date:   Mon, 10 Dec 2018 11:27:01 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] drm/ast: Remove set but not used variable 'bo'
Message-ID: <20181210102701.GP21184@phenom.ffwll.local>
Mail-Followup-To: YueHaibing <yuehaibing@huawei.com>,
        Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <1544258185-50430-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544258185-50430-1-git-send-email-yuehaibing@huawei.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 08:36:25AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/ast/ast_fb.c: In function 'astfb_create':
> drivers/gpu/drm/ast/ast_fb.c:194:17: warning:
>  variable 'bo' set but not used [-Wunused-but-set-variable]
> 
> It never used since introduction in commit 312fec1405dd ("drm: Initial KMS
> driver for AST (ASpeed Technologies) 2000 series (v2)")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thanks.
-Daniel

> ---
>  drivers/gpu/drm/ast/ast_fb.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_fb.c b/drivers/gpu/drm/ast/ast_fb.c
> index de26df0..c2e4136 100644
> --- a/drivers/gpu/drm/ast/ast_fb.c
> +++ b/drivers/gpu/drm/ast/ast_fb.c
> @@ -191,7 +191,6 @@ static int astfb_create(struct drm_fb_helper *helper,
>  	int size, ret;
>  	void *sysram;
>  	struct drm_gem_object *gobj = NULL;
> -	struct ast_bo *bo = NULL;
>  	mode_cmd.width = sizes->surface_width;
>  	mode_cmd.height = sizes->surface_height;
>  	mode_cmd.pitches[0] = mode_cmd.width * ((sizes->surface_bpp + 7)/8);
> @@ -206,7 +205,6 @@ static int astfb_create(struct drm_fb_helper *helper,
>  		DRM_ERROR("failed to create fbcon backing object %d\n", ret);
>  		return ret;
>  	}
> -	bo = gem_to_ast_bo(gobj);
>  
>  	sysram = vmalloc(size);
>  	if (!sysram)
> 
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
