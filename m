Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55EAC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA3120663
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CEoSp0E1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389001AbfA1QVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:21:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55894 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388990AbfA1QVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:21:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so14516352wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 08:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:cc:references:to:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FK7XeOHjZJsxMByGKUeslW6ht2a+IEkVeRhUmEjKcho=;
        b=CEoSp0E1CHVA2I5/q9DQuQlZyZ6umix6L2N2EU2Bih9qYGJ5t8jnQflAfCvTmdUIdA
         0XpW9aJXNYUyBRojpfvfZvGq8D5ku1psb5U6ffQOvZQGNqnGQoGp+Z59/TyIseD8AcJT
         3KWVIHo3d3aZBIu6Oas7nvODWOzwO232WjDkNOa3Zb8v1AORlPvRFW56sPGU1WUZMpdc
         ed+EyraMsUtfdM3WG4BTrJriupWXMn9cVCPmchQsDl5iPncL0RwQ6jrhYi7lS4sQjBBw
         7ZLQY+Z0CS67/1//WjH9wXVhwfls+OgclIq3MAm1SHKpjAfjeWdNlykovciFcaASBGoK
         b9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:to:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FK7XeOHjZJsxMByGKUeslW6ht2a+IEkVeRhUmEjKcho=;
        b=XT9n/tvoHjL5oj5e6ioe/VdMiKivx5I1p2bE2y20/vDxv6UNbaOE55MuowGGRpv22p
         YfjjoGg7eLQFSR7DTmjVkJkREc5fodMGZX9rbA18Np5ytMlbiVS1L893XDliE2C3X9ys
         CJPLFjw20iaPkz8g69QVGqOdOjtOBjWil6F2vjEPR2S/bAntk2c+dFLKBPmsTcPGdQ6Y
         txjBzj5odqpHLmqRhL6cYmdS/ZHUmEiWzr6tIITQbkmyZoa6EkvOGs1XdcGTT6YgQPrh
         u4Of2tVyjl92h/FAJg3TVapVJFSuway3VMvOMg9Cd61thZEYqLH4lugSZgYV+Xu2/ZmS
         LYSQ==
X-Gm-Message-State: AJcUukeSUHkIyrvkodQX0Ot2LN4h5eEsmkaiMZJXAsTXKCxcj8YE6ieT
        dCddThBoVtzca5UU/LF8/PCLRw==
X-Google-Smtp-Source: ALg8bN4KwIFgLc0LS971QEQ9tRSEOgGA22d+G7DxYo2GLgA980R9hcA/2Uy3HFP9NZ5Qwen5nXK9gA==
X-Received: by 2002:a1c:f71a:: with SMTP id v26mr16770253wmh.131.1548692473466;
        Mon, 28 Jan 2019 08:21:13 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j14sm93433922wrv.96.2019.01.28.08.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 08:21:12 -0800 (PST)
Subject: Re: [PATCH v2] drm/meson: Fix atomic mode switching regression
Cc:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tony McKahan <tonymckahan@gmail.com>
References: <20190114153118.8024-1-narmstrong@baylibre.com>
To:     stable@vger.kernel.org
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <2148dfd9-3263-2049-8fd8-d7a4cec97655@baylibre.com>
Date:   Mon, 28 Jan 2019 17:21:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114153118.8024-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stable kernel team,

On 14/01/2019 16:31, Neil Armstrong wrote:
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

This fix has landed in linus master with id ce0210c12433031aba3bbacd75f4c02ab77f2004

could it be applied to 4.19 and 4.20 stable trees ?

Thanks,
Neil

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
> 

