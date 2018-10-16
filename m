Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D124C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3185B20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="IydcrGro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3185B20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbeJPU0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:26:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43072 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeJPU0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:26:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id y20-v6so21131473eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 05:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=qkUlqqN/2EN3sJhhOWGZ5ggrb6sDzZi/YHhQxShfJUM=;
        b=IydcrGro8vLDQyJ9GZODZg2kHELJuJEKy+7+lmwme3uGDdm+RcUFZxtFokoBXORUMZ
         OV0otJNFQfdKgrs+lnDzvhqr2dgOLW2mRXzEDkutLTLAjmauI1/GBdUfmjWSXvXdStea
         9Up8KxmXRmRzYJ3vLLNm+/u7rSDN8u82rqoVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=qkUlqqN/2EN3sJhhOWGZ5ggrb6sDzZi/YHhQxShfJUM=;
        b=uCPk2BX7ao75kkL3uUpg69tCFBjWrIf0Glvq/zGcRRH1/0IqXT887Vnrx+Zx2osOcn
         ZpGR8Cgqoh82jtrgjuxW2lsziffGKLPYP8GgcPNhtwYnBd7SWbR3763VNVCj/R5NHUOF
         57u6ibT4BLqdJmcOLQuPyuo8fNiGFU2eigaOok/TQ//q9M/66MiOHspELJLELCneZpks
         guV468dxnfX+zFU1HZ/q7QGsNqYfnffdb/003jWj/O3eM3VNsDO7uBc3barlC5ij8nzj
         5MKIt1YG/+bTEuJSE8elQk3DlSUYtp93yseTHbDfR5uyFTL4TI2MCch1Ha9ekd1TEFRI
         +GEg==
X-Gm-Message-State: ABuFfojfJBf7SWD9ovuCzoG4YRf1vZyuryRsWilg6L+xC2DwsbHFdgPe
        Zq5es2gHhenlgeoiOWNebW5gAQ==
X-Google-Smtp-Source: ACcGV61gJ9Z0MYsX8/bFNlw25clu0mvvLkmJy31YHkPpOa3CySv0AsUUZk07Cvt/5uWLshFI46GAJw==
X-Received: by 2002:a50:9949:: with SMTP id l9-v6mr28804983edb.277.1539693343822;
        Tue, 16 Oct 2018 05:35:43 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id g13-v6sm5274604edv.48.2018.10.16.05.35.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 05:35:43 -0700 (PDT)
Date:   Tue, 16 Oct 2018 14:35:41 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] drm/drm_vblank: Change EINVAL by the correct errno
Message-ID: <20181016123541.GW31561@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20181015170529.dgzpbm37hbuvqatc@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181015170529.dgzpbm37hbuvqatc@smtp.gmail.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 02:05:29PM -0300, Rodrigo Siqueira wrote:
> For historical reason, the function drm_wait_vblank_ioctl always return
> -EINVAL if something gets wrong. This scenario limits the flexibility
> for the userspace make detailed verification of the problem and take
> some action. In particular, the validation of “if (!dev->irq_enabled)”
> in the drm_wait_vblank_ioctl is responsible for checking if the driver
> support vblank or not. If the driver does not support VBlank, the
> function drm_wait_vblank_ioctl returns EINVAL which does not represent
> the real issue; this patch changes this behavior by return EOPNOTSUPP.
> Additionally, some operations are unsupported by this function, and
> returns EINVAL; this patch also changes the return value to EOPNOTSUPP
> in this case. Lastly, the function drm_wait_vblank_ioctl is invoked by
> libdrm, which is used by many compositors; because of this, it is
> important to check if this change breaks any compositor. In this sense,
> the following projects were examined:
> 
> * Drm-hwcomposer
> * Kwin
> * Sway
> * Wlroots
> * Wayland-core
> * Weston
> * Xorg (67 different drivers)
> 
> For each repository the verification happened in three steps:
> 
> * Update the main branch
> * Look for any occurrence "drmWaitVBlank" with the command:
>   git grep -n "drmWaitVBlank"
> * Look in the git history of the project with the command:
>   git log -SdrmWaitVBlank
> 
> Finally, none of the above projects validate the use of EINVAL which
> make safe, at least for these projects, to change the return values.
> 
> Change since V1:
>  Daniel Vetter and Chris Wilson
>  - Replace ENOTTY by EOPNOTSUPP
>  - Return EINVAL if the parameters are wrong
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Can you pls also let intel-gfx-ci test this patch? You just need to
include intel-gfx@lists.freedesktop.org in your recipient list.

For merging, since you plan to stick around doing kms stuff a bit: Want
commit rights for drm-misc?

https://drm.pages.freedesktop.org/maintainer-tools/getting-started.html

Cheers, Daniel

> ---
>  drivers/gpu/drm/drm_vblank.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 98e091175921..80f5a3bb427e 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -1533,10 +1533,10 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
>  	unsigned int flags, pipe, high_pipe;
>  
>  	if (!dev->irq_enabled)
> -		return -EINVAL;
> +		return -EOPNOTSUPP;
>  
>  	if (vblwait->request.type & _DRM_VBLANK_SIGNAL)
> -		return -EINVAL;
> +		return -EOPNOTSUPP;
>  
>  	if (vblwait->request.type &
>  	    ~(_DRM_VBLANK_TYPES_MASK | _DRM_VBLANK_FLAGS_MASK |
> -- 
> 2.19.1

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
