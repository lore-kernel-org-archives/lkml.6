Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15D0C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3309D21770
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="c9aYAKc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3309D21770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390197AbeHGSzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 14:55:52 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35129 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389292AbeHGSzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 14:55:52 -0400
Received: by mail-ed1-f68.google.com with SMTP id e6-v6so7232479edr.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 09:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xciXkd+1WZtNTFePPSNWwpKAyrXJ3K39DZZnyxAHywE=;
        b=c9aYAKc0RbZn5WkCFDhxzepEJK14bm02dIDcnmd0jmMqVYeSJm4T0NvWwKtLLnz+8N
         jg5Aeqc3nJnsi2G7iYJ/DihPJXieG9W+PXNnUSHIEZlcCHqslBSblctfu5uAbpFC7Rwv
         hrzd6vHnjbBh8vredtayPI8RSJYlLkCIZbGxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=xciXkd+1WZtNTFePPSNWwpKAyrXJ3K39DZZnyxAHywE=;
        b=ruW5TnWwxgRkbHWRUoVVuDVZ+PO212fWac5ARpGDeO8kOV8i4ASYpk/B0Ckmxt5I+u
         47D8TkGU75qdXVgDEObS8FWF70sk09z2y9wenbyqxNsPk51SV9kNo9X2VMmq0l9rYiBn
         GulzmPuydbpR2IGUzzIlBPqLraAm7Cfzcy3tRs135t0W6vI52GJvu4Czout006dpUVmf
         eNwK/ofyoUSSTVt8pbXJpvwjVn3JN9xXqZUIl9O6FetUQByo5MC2RWms3udx8eWhk1eo
         F81MRJrRb5hOYgItRziw6Iy5kWTweiEZizvkayYtmSQGGSv0uT40CzYHULJ03xJv1TVc
         //TA==
X-Gm-Message-State: AOUpUlFa53/8ueZv7TXPcecdsmLYPlgL2In4gpYs7TknklSejoE19AoP
        lo5yZVfrwFoLAVE6whXMoMOyPQ==
X-Google-Smtp-Source: AAOMgpfRJ3z7tAYI1x3qhb81jjwrVm/h6vf03+DycS+U21c+mnr0b9t3WRVAKWj6hCT2v5sncueFGA==
X-Received: by 2002:aa7:d5d6:: with SMTP id d22-v6mr22998762eds.161.1533660042483;
        Tue, 07 Aug 2018 09:40:42 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:56fc:0:d707:d7d8:b180:96e5])
        by smtp.gmail.com with ESMTPSA id y57-v6sm1062492edb.49.2018.08.07.09.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 09:40:41 -0700 (PDT)
Date:   Tue, 7 Aug 2018 18:40:39 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     David Airlie <airlied@linux.ie>, dnicoara@chromium.org,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@google.com>,
        Sean Paul <seanpaul@google.com>,
        alexandros.frantzis@collabora.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, tomasz Figa <tfiga@chromium.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        kernel@collabora.com
Subject: Re: [PATCH] drm/atomic: add ATOMIC_AMEND flag to the Atomic IOCTL.
Message-ID: <20180807164039.GB3008@phenom.ffwll.local>
Mail-Followup-To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        David Airlie <airlied@linux.ie>, dnicoara@chromium.org,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@google.com>,
        Sean Paul <seanpaul@google.com>, alexandros.frantzis@collabora.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        tomasz Figa <tfiga@chromium.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        kernel@collabora.com
References: <20180806160102.11877-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806160102.11877-1-enric.balletbo@collabora.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 06:01:02PM +0200, Enric Balletbo i Serra wrote:
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
> user will notice it. Note that for now it's only enabled for cursor
> planes.
> 
> DRM_MODE_ATOMIC_AMEND should be passed to the Atomic IOCTL to use this
> feature.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> Hi,
> 
> This is an attempt to introduce the new ATOMIC_AMEND flag for atomic
> operations, see the commit message for a more detailed description.
> 
> This was tested using a small program that exercises the uAPI for easy
> sanity testing. The program created by Alexandros can be found here
> [2]. To test, just build the program and use the --atomic flag to use the
> cursor plane in normal (blocking mode), and --atomic-async to use the cursor
> plane with the ATOMIC_AMEND flag. E.g.
> 
>   drm_cursor --atomic
> 
> or
> 
>   drm_cursor --atomic-async

Would be really lovely to bake these into igt-based regression tests. i915
doesn't yet have async update support, but I hope we'll eventually gain
that, and then our CI could make sure this keeps working.

> The test worked on a Samsung Chromebook Plus on top of mainline plus
> the patch to update cursors asynchronously through atomic for the
> drm/rockchip driver.
> 
> Alexandros also did a proof-of-concept to use this flag and draw cursors
> using atomic if possible on ozone [1].
> 
> Best regards,
>  Enric
> 
> [1] https://chromium-review.googlesource.com/c/chromium/src/+/1092711
> [2] https://gitlab.collabora.com/alf/drm-cursor
> 
> 
> Changes in v1:
> - Only enable it if userspace requests it.
> - Only allow async update for cursor type planes.
> - Rename ASYNC_UPDATE for ATOMIC_AMEND.
> 
>  drivers/gpu/drm/drm_atomic.c        |  5 +++++
>  drivers/gpu/drm/drm_atomic_helper.c | 10 +++++++++-
>  include/uapi/drm/drm_mode.h         |  4 +++-
>  3 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 895741e9cd7d..7b3e4aa2874d 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -2338,6 +2338,10 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
>  			(arg->flags & DRM_MODE_PAGE_FLIP_EVENT))
>  		return -EINVAL;
>  
> +	if ((arg->flags & DRM_MODE_ATOMIC_ALLOW_MODESET) &&
> +			(arg->flags & DRM_MODE_ATOMIC_AMEND))
> +		return -EINVAL;
> +
>  	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
>  
>  	state = drm_atomic_state_alloc(dev);
> @@ -2346,6 +2350,7 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
>  
>  	state->acquire_ctx = &ctx;
>  	state->allow_modeset = !!(arg->flags & DRM_MODE_ATOMIC_ALLOW_MODESET);
> +	state->async_update = !!(arg->flags & DRM_MODE_ATOMIC_AMEND);
>  
>  retry:
>  	plane_mask = 0;
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 81e32199d3ef..59495f61c583 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -902,7 +902,7 @@ int drm_atomic_helper_check(struct drm_device *dev,
>  	if (ret)
>  		return ret;
>  
> -	if (state->legacy_cursor_update)
> +	if (state->async_update || state->legacy_cursor_update)

Hm, it would be really cool if we could rip out the legacy_cursor_update
hack and also use async_update in the cursor compat helpers. At least if
available.

>  		state->async_update = !drm_atomic_helper_async_check(dev, state);
>  
>  	return ret;
> @@ -1539,6 +1539,14 @@ int drm_atomic_helper_async_check(struct drm_device *dev,
>  	if (new_plane_state->fence)
>  		return -EINVAL;
>  
> +	/* Only allow async update for cursor type planes. */
> +	if (plane->type != DRM_PLANE_TYPE_CURSOR)
> +		return -EINVAL;

Why limit to cursor planes? The async_update hooks are per-plane.

> +
> +	/* Don't do an async update if there isn't a pending commit. */
> +	if (!old_plane_state->commit)
> +		return -EINVAL;

Hm, why this? Won't this break legacy cursor updates now for drivers which
implement this using async_update?

If userspace wants to avoid this, they can do so by properly tracking
their non-AMEND updates and making sure they've waited until those all
completed.

Also, how is userspace supposed to figure out async_update exists/works?
Usual approach is a getparam.

Another semantics questions: Should this fail if we fall back to a
non-async update? I think that would be best, since userspace can the
decide on its own whether it wants to fall back to a normal commit or do
something else. And the cursor compat code could do the same, i.e. try
first with AMEND, then a normal commit?

Cheers, Daniel

> +
>  	/*
>  	 * Don't do an async update if there is an outstanding commit modifying
>  	 * the plane.  This prevents our async update's changes from getting
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index 4b3a1bb58e68..6dae18428123 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -724,13 +724,15 @@ struct drm_mode_destroy_dumb {
>  #define DRM_MODE_ATOMIC_TEST_ONLY 0x0100
>  #define DRM_MODE_ATOMIC_NONBLOCK  0x0200
>  #define DRM_MODE_ATOMIC_ALLOW_MODESET 0x0400
> +#define DRM_MODE_ATOMIC_AMEND 0x0800
>  
>  #define DRM_MODE_ATOMIC_FLAGS (\
>  		DRM_MODE_PAGE_FLIP_EVENT |\
>  		DRM_MODE_PAGE_FLIP_ASYNC |\
>  		DRM_MODE_ATOMIC_TEST_ONLY |\
>  		DRM_MODE_ATOMIC_NONBLOCK |\
> -		DRM_MODE_ATOMIC_ALLOW_MODESET)
> +		DRM_MODE_ATOMIC_ALLOW_MODESET |\
> +		DRM_MODE_ATOMIC_AMEND)
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
