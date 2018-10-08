Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D9BC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162C020858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162C020858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeJHWMT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:12:19 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:64832 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726078AbeJHWMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:12:19 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 14032428-1500050 
        for multiple; Mon, 08 Oct 2018 16:00:03 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Sean Paul <sean@poorly.run>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20181008145220.p34dllgsiw6rlpod@smtp.gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20181008145220.p34dllgsiw6rlpod@smtp.gmail.com>
Message-ID: <153901080237.31254.10116385737520796385@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] drm/drm_vblank: Change EINVAL by the correct errno
Date:   Mon, 08 Oct 2018 16:00:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rodrigo Siqueira (2018-10-08 15:52:20)
> For historical reason, the function drm_wait_vblank_ioctl always return
> -EINVAL if something gets wrong. This scenario limits the flexibility
> for the userspace make detailed verification of the problem and take
> some action. In particular, the validation of “if (!dev->irq_enabled)”
> in the drm_wait_vblank_ioctl is responsible for checking if the driver
> support vblank or not. If the driver does not support VBlank, the
> function drm_wait_vblank_ioctl returns EINVAL which does not represent
> the real issue; this patch changes this behavior by return ENOTTY
> (Inappropriate ioctl for device). Additionally, some operations are
> unsupported by this function, and returns EINVAL; this patch changes the
> return value to EOPNOTSUPP (Operation not supported). Lastly, the
> function drm_wait_vblank_ioctl is invoked by libdrm, which is used by
> many compositors; because of this, it is important to check if this
> change breaks any compositor. In this sense, the following projects were
> examined:
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
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> ---
>  drivers/gpu/drm/drm_vblank.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 98e091175921..88ec6fb49afb 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -1533,10 +1533,10 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
>         unsigned int flags, pipe, high_pipe;
>  
>         if (!dev->irq_enabled)
> -               return -EINVAL;
> +               return -ENOTTY;

Arguable.

>  
>         if (vblwait->request.type & _DRM_VBLANK_SIGNAL)
> -               return -EINVAL;

User error -> einval.

> +               return -EOPNOTSUPP;
>  
>         if (vblwait->request.type &
>             ~(_DRM_VBLANK_TYPES_MASK | _DRM_VBLANK_FLAGS_MASK |
> @@ -1545,7 +1545,7 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
>                           vblwait->request.type,
>                           (_DRM_VBLANK_TYPES_MASK | _DRM_VBLANK_FLAGS_MASK |
>                            _DRM_VBLANK_HIGH_CRTC_MASK));
> -               return -EINVAL;
> +               return -EOPNOTSUPP;

User error -> einval.
-Chris
