Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB11C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DBB20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CpJk+rx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfAOMGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:06:24 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35825 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbfAOMGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:06:24 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so2359535edx.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 04:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=D7vlcoyUllA9eQct930F/KkGGFJ9+BIhtUvTMKgo/sE=;
        b=CpJk+rx94mRjufv/Ma/whdLZEya+BR6is3bhPJwROLhksCVE7UA/w89cON96mmPuCM
         JL2ofrrhbukgdOcRcsC/EEjcMfTAvV4CLeldgTaa7sHPYjaisOYiQ0uoIjMpnCb9NdxU
         3i3WeQs8YzdUOHK+qyn27oPQqcOlyDzfamnWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=D7vlcoyUllA9eQct930F/KkGGFJ9+BIhtUvTMKgo/sE=;
        b=X1X+MoXNStnFDOxRIiDIc86UL0gU8W3ebS1OLFui46mDPpj8jd4T1BnybsKMFKOY79
         GanJUa+XBveoSl3XEsGyz4lcfNF9P6Sq4WZJVyIpJS9NGIq7pg7/9lFPq7hyd8fnm6eg
         yqas18eUYLybeqxyAmEml5FhRQMskp3FY35+2ER9JjYJXghl1i3FkeNWfcnNpfJ2z7Tm
         3ZROcAaNUkMb5WLK7Mu8H6Z2WjTOhi5gWj3n892+z2I52Sn2EpUHw/K1O4LYzpe2fxed
         tozW/KMb7z8dWP3uGiLKKsb7ei3mJo0T+46/t5LiyvTd504waEk/BF+IGyNiIW6DIYeG
         IxnQ==
X-Gm-Message-State: AJcUukcsi6Vm2Z/+9stjFUyykFViaUsY3VirotBld7lgdPGV9Znnc7Uf
        pGMm2vTzYFO1ZPObQCkrPri5Qg==
X-Google-Smtp-Source: ALg8bN4ejPU8lMEYgxVh7LnxB9yjcS0RZt76rfn7YQpjt4uxuS9P6Q6j74WWqBHEfK31oQ+pWaLmFg==
X-Received: by 2002:a17:906:2cd3:: with SMTP id r19-v6mr2912773ejr.38.1547553981673;
        Tue, 15 Jan 2019 04:06:21 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id r7-v6sm2676274ejs.36.2019.01.15.04.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 04:06:20 -0800 (PST)
Date:   Tue, 15 Jan 2019 13:06:18 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tony McKahan <tonymckahan@gmail.com>
Subject: Re: [PATCH v2] drm/meson: Fix atomic mode switching regression
Message-ID: <20190115120618.GM10517@phenom.ffwll.local>
Mail-Followup-To: Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tony McKahan <tonymckahan@gmail.com>
References: <20190114153118.8024-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114153118.8024-1-narmstrong@baylibre.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 04:31:18PM +0100, Neil Armstrong wrote:
> Since commit 2bcd3ecab773 when switching mode from X11 (ubuntu mate for
> example) the display gets blurry, looking like an invalid framebuffer width.
> 
> This commit fixed atomic crtc modesetting in a totally wrong way and
> introduced a local unnecessary ->enabled crtc state.
> 
> This commit reverts the crctc _begin() and _enable() changes and simply
> adds drm_atomic_helper_commit_tail_rpm as helper.
> 
> Reported-by: Tony McKahan <tonymckahan@gmail.com>
> Suggested-by: Daniel Vetter <daniel@ffwll.ch>
> Fixes: 2bcd3ecab773 ("drm/meson: Fixes for drm_crtc_vblank_on/off support")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

For the record (I already acked this on irc):

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/meson/meson_crtc.c | 23 ++---------------------
>  drivers/gpu/drm/meson/meson_drv.c  |  6 ++++++
>  2 files changed, 8 insertions(+), 21 deletions(-)
> 
> Changes since v1:
> - drop the unecessary local ->enabled logic
> - use drm_atomic_helper_commit_tail_rpm as atomic_commit_tail helper
> 
> diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
> index 75d97f1b2e8f..4f5c67f70c4d 100644
> --- a/drivers/gpu/drm/meson/meson_crtc.c
> +++ b/drivers/gpu/drm/meson/meson_crtc.c
> @@ -46,7 +46,6 @@ struct meson_crtc {
>  	struct drm_crtc base;
>  	struct drm_pending_vblank_event *event;
>  	struct meson_drm *priv;
> -	bool enabled;
>  };
>  #define to_meson_crtc(x) container_of(x, struct meson_crtc, base)
>  
> @@ -82,7 +81,8 @@ static const struct drm_crtc_funcs meson_crtc_funcs = {
>  
>  };
>  
> -static void meson_crtc_enable(struct drm_crtc *crtc)
> +static void meson_crtc_atomic_enable(struct drm_crtc *crtc,
> +				     struct drm_crtc_state *old_state)
>  {
>  	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
>  	struct drm_crtc_state *crtc_state = crtc->state;
> @@ -108,20 +108,6 @@ static void meson_crtc_enable(struct drm_crtc *crtc)
>  
>  	drm_crtc_vblank_on(crtc);
>  
> -	meson_crtc->enabled = true;
> -}
> -
> -static void meson_crtc_atomic_enable(struct drm_crtc *crtc,
> -				     struct drm_crtc_state *old_state)
> -{
> -	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
> -	struct meson_drm *priv = meson_crtc->priv;
> -
> -	DRM_DEBUG_DRIVER("\n");
> -
> -	if (!meson_crtc->enabled)
> -		meson_crtc_enable(crtc);
> -
>  	priv->viu.osd1_enabled = true;
>  }
>  
> @@ -153,8 +139,6 @@ static void meson_crtc_atomic_disable(struct drm_crtc *crtc,
>  
>  		crtc->state->event = NULL;
>  	}
> -
> -	meson_crtc->enabled = false;
>  }
>  
>  static void meson_crtc_atomic_begin(struct drm_crtc *crtc,
> @@ -163,9 +147,6 @@ static void meson_crtc_atomic_begin(struct drm_crtc *crtc,
>  	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
>  	unsigned long flags;
>  
> -	if (crtc->state->enable && !meson_crtc->enabled)
> -		meson_crtc_enable(crtc);
> -
>  	if (crtc->state->event) {
>  		WARN_ON(drm_crtc_vblank_get(crtc) != 0);
>  
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index 3ee4d4a4ecba..a74d861ddceb 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -75,6 +75,11 @@ static const struct drm_mode_config_funcs meson_mode_config_funcs = {
>  	.fb_create           = drm_gem_fb_create,
>  };
>  
> +
> +static const struct drm_mode_config_helper_funcs meson_mode_config_helpers = {
> +	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
> +};
> +
>  static irqreturn_t meson_irq(int irq, void *arg)
>  {
>  	struct drm_device *dev = arg;
> @@ -266,6 +271,7 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>  	drm->mode_config.max_width = 3840;
>  	drm->mode_config.max_height = 2160;
>  	drm->mode_config.funcs = &meson_mode_config_funcs;
> +	drm->mode_config.helper_private	= &meson_mode_config_helpers;
>  
>  	/* Hardware Initialization */
>  
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
