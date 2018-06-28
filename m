Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CADC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A102700A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Eiv9MIQY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A102700A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934886AbeF1Iae (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 04:30:34 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45413 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933589AbeF1Iab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 04:30:31 -0400
Received: by mail-ed1-f68.google.com with SMTP id g15-v6so257879edr.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 01:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rKHiMvMqXLg5QaXUUYHD99YRrfmfVZW7gr9P4LZNzuE=;
        b=Eiv9MIQYew8++1cpjds3PyyfhzGv+IHQowbOvIk52axFbt5D092rEKXFKEnxmg/opx
         R1tprW+nKLE33Xtk2OHdL3QCdLlaxl6mXMksmOHxY6IUSmRyNiudJZvY7nTpCYw8AHDO
         jWSciy/keFwWnJp32+HBa0t+Cuad+rCpcWt3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=rKHiMvMqXLg5QaXUUYHD99YRrfmfVZW7gr9P4LZNzuE=;
        b=sDQX23jirbZTvRq/c8dAwkDIhENK1Euom8nqz9dka2pb8jWimCYNHkOaUA+s6alvbk
         0QEm1IMKVMjt+qnpMexXz5NmQezOCB7ok4C7bN9UEfREOs3yHtSMXCJQmS0i2dFBJTwl
         TDQaUKqrnOW/apO+3ylKCDY/FEtKA31Yz5Pfrb+M+mhPbKftfJVKUee/ko77vmbVbuLc
         lOfCp3bay6eHhZeS7udH5FfS5mEUJ+rPZzLRC2p9REZ5gT2zzOq9MuTBtGMlwtjXNliP
         hsjBj8uuGuAy7YMlPn4LCJprmLFSxcYDNmRUrll3S2oYnI2D0v+YvNOB6iK3N0uAvyN7
         bHtg==
X-Gm-Message-State: APt69E3HxuZXdRpYYsI/bkeiS1lWuntCn6dzk367Lf6ng5OtwSoYx7J6
        sLx12N4Dp+bdVFhG5NxWhgk09Q==
X-Google-Smtp-Source: AAOMgpcf2pQaSjSyoE86MKN9NHnaiuCFoOeklHFIejPFqYIxr+Jp5h95e854vdnlYqlXKMw9KStCLg==
X-Received: by 2002:a50:cb0d:: with SMTP id g13-v6mr8220651edi.81.1530174630512;
        Thu, 28 Jun 2018 01:30:30 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5635:0:ee51:c8a0:8c68:b779])
        by smtp.gmail.com with ESMTPSA id y32-v6sm2662523eda.38.2018.06.28.01.30.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 01:30:29 -0700 (PDT)
Date:   Thu, 28 Jun 2018 10:30:27 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     David Airlie <airlied@linux.ie>, dnicoara@chromium.org,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@google.com>,
        Sean Paul <seanpaul@google.com>,
        alexandros.frantzis@collabora.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, tomasz Figa <tfiga@chromium.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        kernel@collabora.com
Subject: Re: [RFC PATCH] drm/atomic: add ASYNC_UPDATE flag to the Atomic
 IOCTL.
Message-ID: <20180628083027.GS13978@phenom.ffwll.local>
Mail-Followup-To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        David Airlie <airlied@linux.ie>, dnicoara@chromium.org,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@google.com>,
        Sean Paul <seanpaul@google.com>, alexandros.frantzis@collabora.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        tomasz Figa <tfiga@chromium.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        kernel@collabora.com
References: <20180627212506.24061-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627212506.24061-1-enric.balletbo@collabora.com>
X-Operating-System: Linux phenom 4.16.0-2-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 11:25:06PM +0200, Enric Balletbo i Serra wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.com>
> 
> This flag tells core to jump ahead the queued update if the conditions
> in drm_atomic_async_check() are met. That means we are only able to do an
> async update if no modeset is pending and update for the same plane is
> not queued.
> 
> It uses the already in place infrastructure for async updates.
> 
> It is useful for cursor updates and async PageFlips over the atomic
> ioctl, otherwise in some cases updates may be delayed to the point the
> user will notice it.
> 
> DRM_MODE_ATOMIC_ASYNC_UPDATE should be passed to the Atomic IOCTL to use
> this feature.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

I think this should also be used to emulate async updates for legacy
page_flip ioctls. That would even avoid the need for userspace, at least
for the internal stuff :-)
-Daniel

> ---
> Hi,
> 
> This is an attempt to introduce the new ASYNC_UPDATE flag for atomic
> operations, see the commit message for a more detailed description.
> 
> To test this patch we have created an IGT test that we plan to send to
> the ML but also was tested using a small program that exercises the uAPI
> for easy sanity testing. The program created by Alexandros can be found here
> [2]. To test, just build the program and use the --atomic flag to use the
> cursor plane in normal (blocking mode), and --atomic-async to use the cursor
> plane with the ASYNC_UPDATE flag.E.g.
> 
>   drm_cursor --atomic
> 
> or
> 
>   drm_cursor --atomic-async
> 
> The test worked on a Samsung Chromebook Plus on top of mainline plus
> the patch to update cursors asynchronously through atomic for the
> drm/rockchip driver [3].
> 
> Alexandros also did a proof-of-concept to use this flag and draw cursors
> using atomic if possible on ozone [1].
> 
> Best regards,
>  Enric
> 
> [1] https://chromium-review.googlesource.com/c/chromium/src/+/1092711
> [2] https://gitlab.collabora.com/alf/drm-cursor
> [3] https://patchwork.kernel.org/patch/10492693/
> 
> 
>  drivers/gpu/drm/drm_atomic.c        | 6 ++++++
>  drivers/gpu/drm/drm_atomic_helper.c | 9 ++++++---
>  include/uapi/drm/drm_mode.h         | 4 +++-
>  3 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index c825c76edc1d..15b799f46982 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -80,6 +80,7 @@ drm_atomic_state_init(struct drm_device *dev, struct drm_atomic_state *state)
>  	 * setting this appropriately?
>  	 */
>  	state->allow_modeset = true;
> +	state->async_update = true;
>  
>  	state->crtcs = kcalloc(dev->mode_config.num_crtc,
>  			       sizeof(*state->crtcs), GFP_KERNEL);
> @@ -2320,6 +2321,10 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
>  			(arg->flags & DRM_MODE_PAGE_FLIP_EVENT))
>  		return -EINVAL;
>  
> +	if ((arg->flags & DRM_MODE_ATOMIC_ALLOW_MODESET) &&
> +			(arg->flags & DRM_MODE_ATOMIC_ASYNC_UPDATE))
> +		return -EINVAL;
> +
>  	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
>  
>  	state = drm_atomic_state_alloc(dev);
> @@ -2328,6 +2333,7 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
>  
>  	state->acquire_ctx = &ctx;
>  	state->allow_modeset = !!(arg->flags & DRM_MODE_ATOMIC_ALLOW_MODESET);
> +	state->async_update = !!(arg->flags & DRM_MODE_ATOMIC_ASYNC_UPDATE);
>  
>  retry:
>  	plane_mask = 0;
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index c35654591c12..aeb0523d3bcf 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -891,7 +891,7 @@ int drm_atomic_helper_check(struct drm_device *dev,
>  	if (ret)
>  		return ret;
>  
> -	if (state->legacy_cursor_update)
> +	if (state->async_update || state->legacy_cursor_update)
>  		state->async_update = !drm_atomic_helper_async_check(dev, state);
>  
>  	return ret;
> @@ -1526,13 +1526,16 @@ int drm_atomic_helper_async_check(struct drm_device *dev,
>  	if (new_plane_state->fence)
>  		return -EINVAL;
>  
> +	/* Only do an async update if there is a pending commit. */
> +	if (!old_plane_state->commit)
> +		return -EINVAL;
> +
>  	/*
>  	 * Don't do an async update if there is an outstanding commit modifying
>  	 * the plane.  This prevents our async update's changes from getting
>  	 * overridden by a previous synchronous update's state.
>  	 */
> -	if (old_plane_state->commit &&
> -	    !try_wait_for_completion(&old_plane_state->commit->hw_done))
> +	if (!try_wait_for_completion(&old_plane_state->commit->hw_done))
>  		return -EBUSY;
>  
>  	return funcs->atomic_async_check(plane, new_plane_state);
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index 50bcf4214ff9..772e84f0edeb 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -718,13 +718,15 @@ struct drm_mode_destroy_dumb {
>  #define DRM_MODE_ATOMIC_TEST_ONLY 0x0100
>  #define DRM_MODE_ATOMIC_NONBLOCK  0x0200
>  #define DRM_MODE_ATOMIC_ALLOW_MODESET 0x0400
> +#define DRM_MODE_ATOMIC_ASYNC_UPDATE  0x0800
>  
>  #define DRM_MODE_ATOMIC_FLAGS (\
>  		DRM_MODE_PAGE_FLIP_EVENT |\
>  		DRM_MODE_PAGE_FLIP_ASYNC |\
>  		DRM_MODE_ATOMIC_TEST_ONLY |\
>  		DRM_MODE_ATOMIC_NONBLOCK |\
> -		DRM_MODE_ATOMIC_ALLOW_MODESET)
> +		DRM_MODE_ATOMIC_ALLOW_MODESET |\
> +		DRM_MODE_ATOMIC_ASYNC_UPDATE)
>  
>  struct drm_mode_atomic {
>  	__u32 flags;
> -- 
> 2.18.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
