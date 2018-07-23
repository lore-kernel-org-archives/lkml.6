Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCCAECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4DE20779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UCGef+kS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4DE20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388477AbeGWPiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:38:09 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:38253 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387877AbeGWPiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:38:08 -0400
Received: by mail-yb0-f195.google.com with SMTP id i9-v6so319320ybo.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 07:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DUf2r8EyJM/SRwqxersBzu6cymZcjLmFoB6gYIYzErA=;
        b=UCGef+kScFAw19A2Ek0QrjGh5rv7XKWjc7dP/QYEjMK6Ojo1Zn2nt/fnvo3aLRSR6K
         Y+aqMzEp25puUwQ0Bz9wSOyptXH4jAip7wB6UG/Oo05+ULK9X8gOAFiPH7DFQMUkyaM8
         MDwY6zOLHir9zWzwXvLBWmg+hmssCOfH+Mi2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DUf2r8EyJM/SRwqxersBzu6cymZcjLmFoB6gYIYzErA=;
        b=EZ2FARqk9faUNcyDs733GLD09ywmlz4PtY7POfGBPbC/q6n5eabkiOewTrf1EjigSG
         pNb3HEvoF2uDZ+iUDIOXn9cpDHhjXdlt+QZTSMeN57yENLEdFgJuMdBYTwY5Ird0vHml
         FNtpe5S9OmOKxHqbhzg8KGSySZYrEn2JjB7EtPrD+6NkNKy1SXKg856/x+R0MtjPhYUC
         PqRfpowvVhJIa8mpJJx9Iot4cEQ6rnycJqOVGfPKALHqC5rwvYSm3+nFB3Gp7XPK6w2e
         yjESoP46NRY3aV2Ov/g9qYc8h6w/7ECVjSEtflBPJHYuE8QYuscV78qjQwTGC/iMiXuR
         7Tmg==
X-Gm-Message-State: AOUpUlGu93P/+0phSdD37EIxla8sycj8hH0eaUBP3wZqGpBkZIkZd3cg
        pMQOO1ae8rkyZgExBT1n9NBbzg==
X-Google-Smtp-Source: AAOMgpcMygQRNZkZUCydor88AbxVyPuNwILZMYUUcWUkiaURxhE6sr0KH9YCvcNHDr0ZYeJqntWiwQ==
X-Received: by 2002:a25:c4c6:: with SMTP id u189-v6mr7119395ybf.45.1532356595572;
        Mon, 23 Jul 2018 07:36:35 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id d6-v6sm986507ywa.85.2018.07.23.07.36.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 07:36:34 -0700 (PDT)
Date:   Mon, 23 Jul 2018 10:36:34 -0400
From:   Sean Paul <seanpaul@chromium.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@google.com>
Subject: Re: [RFC RESEND PATCH] drm/rockchip: update cursors asynchronously
 through atomic.
Message-ID: <20180723143634.GJ20359@art_vandelay>
References: <20180627211447.20927-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627211447.20927-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 11:14:47PM +0200, Enric Balletbo i Serra wrote:
> Add support to async updates of cursors by using the new atomic
> interface for that.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

LGTM. Given rockchip hasn't weighed in on the patch, and that you've tested it
on real hardware, let's land it.

Reviewed-by: Sean Paul <seanpaul@chromium.org>


> ---
> I am sending this as RFC because I still don't have a deep knowledge of
> the hw and I am not sure if the vop_plane_update function can be reused
> in both cases, atomic_updates and atomic_async_updates. I think that
> someone with more knowledge should take a look. The patch was tested on
> a Samsung Chromebook Plus in two ways.
> 
> 1. Running all igt kms_cursor_legacy and kms_atomic@plane_cursor_legacy
> tests and see that there is no regression after the patch.
> 
> 2. Running weston using the atomic API.
> 
> Best regards,
>   Enric
> 
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 80 ++++++++++++++++-----
>  1 file changed, 64 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 53d4afe15278..1eb6bda924af 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -688,8 +688,7 @@ static void vop_plane_atomic_disable(struct drm_plane *plane,
>  	spin_unlock(&vop->reg_lock);
>  }
>  
> -static void vop_plane_atomic_update(struct drm_plane *plane,
> -		struct drm_plane_state *old_state)
> +static void vop_plane_update(struct drm_plane *plane)
>  {
>  	struct drm_plane_state *state = plane->state;
>  	struct drm_crtc *crtc = state->crtc;
> @@ -710,20 +709,6 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
>  	bool rb_swap;
>  	int format;
>  
> -	/*
> -	 * can't update plane when vop is disabled.
> -	 */
> -	if (WARN_ON(!crtc))
> -		return;
> -
> -	if (WARN_ON(!vop->is_enabled))
> -		return;
> -
> -	if (!state->visible) {
> -		vop_plane_atomic_disable(plane, old_state);
> -		return;
> -	}
> -
>  	obj = rockchip_fb_get_gem_obj(fb, 0);
>  	rk_obj = to_rockchip_obj(obj);
>  
> @@ -794,10 +779,73 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
>  	spin_unlock(&vop->reg_lock);
>  }
>  
> +static void vop_plane_atomic_update(struct drm_plane *plane,
> +				    struct drm_plane_state *old_state)
> +{
> +	struct drm_plane_state *state = plane->state;
> +	struct vop *vop = to_vop(state->crtc);
> +
> +	/*
> +	 * can't update plane when vop is disabled.
> +	 */
> +	if (WARN_ON(!state->crtc))
> +		return;
> +
> +	if (WARN_ON(!vop->is_enabled))
> +		return;
> +
> +	if (!state->visible) {
> +		vop_plane_atomic_disable(plane, old_state);
> +		return;
> +	}
> +
> +	vop_plane_update(plane);
> +}
> +
> +static int vop_plane_atomic_async_check(struct drm_plane *plane,
> +					struct drm_plane_state *state)
> +{
> +	struct drm_crtc_state *crtc_state;
> +
> +	crtc_state = drm_atomic_get_existing_crtc_state(state->state,
> +							state->crtc);
> +	if (WARN_ON(!crtc_state))
> +		return -EINVAL;
> +
> +	if (!crtc_state->active)
> +		return -EINVAL;
> +
> +	if (plane->state->crtc != state->crtc ||
> +	    plane->state->src_w != state->src_w ||
> +	    plane->state->src_h != state->src_h ||
> +	    plane->state->crtc_w != state->crtc_w ||
> +	    plane->state->crtc_h != state->crtc_h ||
> +	    !plane->state->fb ||
> +	    plane->state->fb != state->fb)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static void vop_plane_atomic_async_update(struct drm_plane *plane,
> +					  struct drm_plane_state *new_state)
> +{
> +	plane->state->src_x = new_state->src_x;
> +	plane->state->src_y = new_state->src_y;
> +	plane->state->crtc_x = new_state->crtc_x;
> +	plane->state->crtc_y = new_state->crtc_y;
> +	plane->state->fb = new_state->fb;
> +	*plane->state = *new_state;
> +
> +	vop_plane_update(plane);
> +}
> +
>  static const struct drm_plane_helper_funcs plane_helper_funcs = {
>  	.atomic_check = vop_plane_atomic_check,
>  	.atomic_update = vop_plane_atomic_update,
>  	.atomic_disable = vop_plane_atomic_disable,
> +	.atomic_async_check = vop_plane_atomic_async_check,
> +	.atomic_async_update = vop_plane_atomic_async_update,
>  };
>  
>  static const struct drm_plane_funcs vop_plane_funcs = {
> -- 
> 2.18.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
