Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA662C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 10:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A305C2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 10:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="a6Pb/AwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbeLXKxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 05:53:23 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45659 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbeLXKxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 05:53:23 -0500
Received: by mail-ed1-f66.google.com with SMTP id d39so9786539edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 02:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=79REX5h0sIpW7jzF4+vTzE6KwVFoWwLAdDLIOrCt8sY=;
        b=a6Pb/AwFAHUuFsS9h+qp/J1tzkxsDT6/Wbq0jZ0SMvIyw2ZQ/WCpXzcgqnpJzFYvL7
         CYVW+akkTawSEqegFAaNEDS3E/3HmdjSn3QQ36bT68d6HuqCM7NTZipxglKDf+FJxEXa
         7uM+LEbUEfIz8iEgqcgTfgHi2yyNeypHkYsFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=79REX5h0sIpW7jzF4+vTzE6KwVFoWwLAdDLIOrCt8sY=;
        b=lNl9tVm1VFjiTMxOxtgO/w1YZ62g41aGu84i/74R5/O0BDlsvISvJWzYnTJSkedShd
         gCttbgxOemK5dVJ4XYSiKtCg+KeXfRFbxp7qQb8LszfyQK3TMVfZfEVL1932sNUt8wG3
         8m3oIjKHQCIne/MxctizE6OswjMDFofxnUQ27l9oUqJ/oOY7AsBjf5BO46CiUbeLu/cn
         IdlKh0VsPGxcCcfjWf5q4a2mvRxGV+WeTv1VT1da6nNURhMsXHQt19z0b6BnEDDPrz+x
         OtbTOOj39E0biYQ1BuX/P6dSHhvHPavrad4X2Pi9ODt+Ka1VcUSHBl2nuY/mdbE+w7Dq
         al3g==
X-Gm-Message-State: AA+aEWY2DuVRgUlbtuE8+ZvjfJCMV7BoTCSIhCKPrmPNMIQZqZbACrrM
        qli09RZglNN/PiUqe3PnBVN77w==
X-Google-Smtp-Source: AFSGD/Uq+QyjQoGVIKT1/F+QjM7F7+GcH/01pWeBrVEY/4l8zv329SCrHzcXvLnCEgIk1qlun/fgog==
X-Received: by 2002:a17:906:5118:: with SMTP id w24-v6mr8588068ejk.215.1545648801711;
        Mon, 24 Dec 2018 02:53:21 -0800 (PST)
Received: from dvetter-linux.ger.corp.intel.com ([194.230.159.220])
        by smtp.gmail.com with ESMTPSA id t15-v6sm4712025ejt.0.2018.12.24.02.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 02:53:20 -0800 (PST)
Date:   Mon, 24 Dec 2018 11:53:18 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Colin King <colin.king@canonical.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm: fix null pointer dereference on null state
 pointer
Message-ID: <20181224105317.GC30772@dvetter-linux.ger.corp.intel.com>
Mail-Followup-To: Colin King <colin.king@canonical.com>,
        Rob Clark <robdclark@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181222130046.14083-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181222130046.14083-1-colin.king@canonical.com>
X-Operating-System: Linux dvetter-linux.ger.corp.intel.com
 4.18.17-200.fc28.x86_64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 01:00:46PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the case where state cannot be allocated, the current exit path via
> label 'out' will dereference the null state pointer when calling
> drm_atomic_state_put. Fix this by adding a new error exit label and
> jumping to this to avoid the drm_atomic_state_put.
> 
> Detected by CoverityScan, CID#1476034 ("Dereference after null check")
> 
> Fixes: b9fc5e01d1ce ("drm: Add helper to implement legacy dirtyfb")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Looks correct to me, merged into drm-misc-next-fixes for 4.21.

Thanks, Daniel

> ---
>  drivers/gpu/drm/drm_damage_helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_damage_helper.c
> index d2a1c7372f36..31032407254d 100644
> --- a/drivers/gpu/drm/drm_damage_helper.c
> +++ b/drivers/gpu/drm/drm_damage_helper.c
> @@ -178,7 +178,7 @@ int drm_atomic_helper_dirtyfb(struct drm_framebuffer *fb,
>  	state = drm_atomic_state_alloc(fb->dev);
>  	if (!state) {
>  		ret = -ENOMEM;
> -		goto out;
> +		goto out_drop_locks;
>  	}
>  	state->acquire_ctx = &ctx;
>  
> @@ -238,6 +238,7 @@ int drm_atomic_helper_dirtyfb(struct drm_framebuffer *fb,
>  	kfree(rects);
>  	drm_atomic_state_put(state);
>  
> +out_drop_locks:
>  	drm_modeset_drop_locks(&ctx);
>  	drm_modeset_acquire_fini(&ctx);
>  
> -- 
> 2.19.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
