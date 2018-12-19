Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D407C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7C32133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="XxzFB35z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbeLSNNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:13:12 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36025 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbeLSNNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:13:12 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so16921643edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 05:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PaI8DzhmPN9dNs/dA6kaWjN+Sd43OVNvbTuboP5TM7A=;
        b=XxzFB35z/TUQXB5q/w0fKnotPwxK6mpYQ4jaSqr27jQjI+s/Cpl9XDQkArutye9XfG
         Owo5dPiXOOHdQT1FXAptG+lFVL5zfI9wrc4RMbI3vD1FseDye2pTx3RMfdGe7Rxh+nm6
         RBwDNSAQhTV2TqKARmzp4C41szVT46AcMZs3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=PaI8DzhmPN9dNs/dA6kaWjN+Sd43OVNvbTuboP5TM7A=;
        b=LdkxggTWrw4uSeD+Z1QV5f1fv5UWU/jkdu3IWXCfcaroUBCujAEtaM5r6uFwMIIceD
         ZtKvADNsdcw0ytilOPa74VAKWYeAcAa7T63KCGB8lc9bV6z5TDcjYs1bfc0d7nLvOokq
         KZpyN1GqjyA/uNTNaAH4deQe5YBZ3hUW7z2ndpW2g50Rs6wja+++BVTWcdoPV4PpW2Hn
         eSHPhwIg9cGEHnkSR5IL6PaYCYc8ZXFQHaSqGZwA8rUPXD3//s8++xieM3brEYgft9rk
         HbipBi8W5ufei72oqLHb9se9mk3mrYEOLJIhAOH3wSfZ4a3xh6jH6VkOE8v80Wol2Xgx
         I0Xg==
X-Gm-Message-State: AA+aEWaY8vc/HtzNcS9D2q8JXnDcneTnqCm8a0Gxvvnx/u9UOBYHGmt9
        BlG0sNOoIckdIXPZIET780YWgQ==
X-Google-Smtp-Source: AFSGD/UEUw/xzX3ZVyyd1ue6yQEetALzZkePcOtgGQdpHftV9iuOvtz+SdaNiMInt0gxq77vetxCMQ==
X-Received: by 2002:a50:d6c5:: with SMTP id l5mr20123532edj.145.1545225190044;
        Wed, 19 Dec 2018 05:13:10 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id e7-v6sm2727760ejt.23.2018.12.19.05.13.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 05:13:09 -0800 (PST)
Date:   Wed, 19 Dec 2018 14:13:07 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Shayenne Moura <shayenneluzmoura@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 5/7] drm: sti: Delete base.id prints
Message-ID: <20181219131307.GS21184@phenom.ffwll.local>
Mail-Followup-To: Shayenne Moura <shayenneluzmoura@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20181218133825.rdqanhqozsnqp2fy@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218133825.rdqanhqozsnqp2fy@smtp.gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 11:38:25AM -0200, Shayenne Moura wrote:
> This patch removes base.id prints from drm_display_mode                         
> objects in sti files. It removes dependency from drm_mode_object.
> 
> Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/sti/sti_crtc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sti/sti_crtc.c b/drivers/gpu/drm/sti/sti_crtc.c
> index ed76e52eb213..ab7989bc8fa0 100644
> --- a/drivers/gpu/drm/sti/sti_crtc.c
> +++ b/drivers/gpu/drm/sti/sti_crtc.c
> @@ -53,9 +53,9 @@ sti_crtc_mode_set(struct drm_crtc *crtc, struct drm_display_mode *mode)
>  	struct clk *compo_clk, *pix_clk;
>  	int rate = mode->clock * 1000;
>  
> -	DRM_DEBUG_KMS("CRTC:%d (%s) mode:%d (%s)\n",
> +	DRM_DEBUG_KMS("CRTC:%d (%s) mode: (%s)\n",
>  		      crtc->base.id, sti_mixer_to_str(mixer),
> -		      mode->base.id, mode->name);
> +		      mode->name);
>  
>  	DRM_DEBUG_KMS("%d %d %d %d %d %d %d %d %d %d 0x%x 0x%x\n",
>  		      mode->vrefresh, mode->clock,
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
