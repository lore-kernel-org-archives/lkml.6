Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9738DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 06:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F3942075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 06:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IuVG+N6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3942075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbeKTRQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 12:16:00 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:41714 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728703AbeKTRQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 12:16:00 -0500
Received: by mail-yb1-f193.google.com with SMTP id t13-v6so339204ybb.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 22:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gUxFpUYEQktP/1FBNSlzoKnn7tpa+wdzK0RvSJWKafg=;
        b=IuVG+N6tl9Z3jjJMPShgh7WCi3pYQHF9BPCDilF3MhvJavT0u9GSDQGNPzYLIdcqmt
         IW6HfpHBMmnpobCKN3Ejme3hfoltzuLIju81nbAv5YBh2OZV+7iAPkcYfxVjgxMbk2b7
         Gi9MmLJOlzBSC5XJp8N8BKQNNd+uYaiKRZDe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gUxFpUYEQktP/1FBNSlzoKnn7tpa+wdzK0RvSJWKafg=;
        b=MIPW5uWbxcssI0N4NMDg+bmwJ46j5Us6Y1BljTa1H1k//YkyW5rLXebXsRx7ELnzl0
         SgX56Uks22MMEC48hPzQ0HkgmKGOCKcn3klg9GZzV2MKrKv5m75klm3MYm/cPyRksUEk
         mwekwRzxxivfC21dHgZEsrPhLJiv2VkTe5UYrft/rU6fCtdQYpuIETHGOqfClVFYa2jD
         akXGSt9xOpYYYo5mrJvcYDjKrHxkNG7KiT2Rggs0wUx3fklIREc7JOlPI+H0NdkYAoNG
         cfYZZO0OQEvq6imqji+kfr8JbElGQt/e4v2ZpLRHr7L5hZ1g1PCicmVfQSA/RIGf/Eb+
         csGw==
X-Gm-Message-State: AA+aEWZlObNVDqsygNPi8uIdL1vkEiKNABu1AZS4yk1Zrz1gPVn6eQtg
        fZyP95MGGsiTGwuiHLwmehXfkgHbIFWO7A==
X-Google-Smtp-Source: AFSGD/VJ+oQVM65aarGPyMjwEqDFBLCI1IxaCNn8LlMdMKd5V1LTdFW/Fm9PWm/mn+NPxNK+TPc1pA==
X-Received: by 2002:a25:3cc4:: with SMTP id j187-v6mr654130yba.399.1542696507808;
        Mon, 19 Nov 2018 22:48:27 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id o186sm5146206ywd.58.2018.11.19.22.48.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 22:48:26 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id i17-v6so329799ybp.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 22:48:26 -0800 (PST)
X-Received: by 2002:a25:7ec4:: with SMTP id z187-v6mr625631ybc.373.1542696505974;
 Mon, 19 Nov 2018 22:48:25 -0800 (PST)
MIME-Version: 1.0
References: <20181119190805.19139-1-helen.koike@collabora.com>
In-Reply-To: <20181119190805.19139-1-helen.koike@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 20 Nov 2018 15:48:14 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DDZwhdMDbrHthQwm2bQ3+NoZNcemAktVTxkR3=LfnnTg@mail.gmail.com>
Message-ID: <CAAFQd5DDZwhdMDbrHthQwm2bQ3+NoZNcemAktVTxkR3=LfnnTg@mail.gmail.com>
Subject: Re: [PATCH v3] drm/rockchip: update cursors asynchronously through atomic.
To:     helen.koike@collabora.com
Cc:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helen,

On Tue, Nov 20, 2018 at 4:08 AM Helen Koike <helen.koike@collabora.com> wrote:
>
> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
> Add support to async updates of cursors by using the new atomic
> interface for that.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> [updated for upstream]
> Signed-off-by: Helen Koike <helen.koike@collabora.com>
>
> ---
> Hello,
>
> This is the third version of the async-plane update suport to the
> Rockchip driver.
>

Thanks for a quick respin. Please see my comments inline. (I'll try to
be better at responding from now on...)

> I tested running igt kms_cursor_legacy and kms_atomic tests using a 96Boards Ficus.
>
> Note that before the patch, the following igt tests failed:
>
>         basic-flip-before-cursor-atomic
>         basic-flip-before-cursor-legacy
>         cursor-vs-flip-atomic
>         cursor-vs-flip-legacy
>         cursor-vs-flip-toggle
>         flip-vs-cursor-atomic
>         flip-vs-cursor-busy-crc-atomic
>         flip-vs-cursor-busy-crc-legacy
>         flip-vs-cursor-crc-atomic
>         flip-vs-cursor-crc-legacy
>         flip-vs-cursor-legacy
>
> Full log: https://people.collabora.com/~koike/results-4.20/html/
>
> Now with the patch applied the following were fixed:
>         basic-flip-before-cursor-atomic
>         basic-flip-before-cursor-legacy
>         flip-vs-cursor-atomic
>         flip-vs-cursor-legacy
>
> Full log: https://people.collabora.com/~koike/results-4.20-async/html/

Could you also test modetest, with the -C switch to test the legacy
cursor API? I remember it triggering crashes due to synchronization
issues easily.

>
> Tomasz, as you mentined in v2 about waiting the hardware before updating
> the framebuffer, now I call the loop you pointed out in the async path,
> was that what you had in mind? Or do you think I would make sense to
> call the vop_crtc_atomic_flush() instead of just exposing that loop?
>
> Thanks
> Helen
>
> Changes in v3:
> - Rebased on top of drm-misc
> - Fix missing include in rockchip_drm_vop.c
> - New function vop_crtc_atomic_commit_flush
>
> Changes in v2:
> - v2: https://patchwork.freedesktop.org/patch/254180/
> - Change the framebuffer as well to cover jumpy cursor when hovering
>   text boxes or hyperlink. (Tomasz)
> - Use the PSR inhibit mechanism when accessing VOP hardware instead of
>   PSR flushing (Tomasz)
>
> Changes in v1:
> - Rebased on top of drm-misc
> - In async_check call drm_atomic_helper_check_plane_state to check that
>   the desired plane is valid and update various bits of derived state
>   (clipped coordinates etc.)
> - In async_check allow to configure new scaling in the fast path.
> - In async_update force to flush all registered PSR encoders.
> - In async_update call atomic_update directly.
> - In async_update call vop_cfg_done needed to set the vop registers and take effect.
>
>  drivers/gpu/drm/rockchip/rockchip_drm_fb.c  |  36 -------
>  drivers/gpu/drm/rockchip/rockchip_drm_psr.c |  37 +++++++
>  drivers/gpu/drm/rockchip/rockchip_drm_psr.h |   3 +
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 108 +++++++++++++++++---
>  4 files changed, 131 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> index ea18cb2a76c0..08bec50d9c5d 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> @@ -127,42 +127,6 @@ rockchip_user_fb_create(struct drm_device *dev, struct drm_file *file_priv,
>         return ERR_PTR(ret);
>  }
>
> -static void
> -rockchip_drm_psr_inhibit_get_state(struct drm_atomic_state *state)
> -{
> -       struct drm_crtc *crtc;
> -       struct drm_crtc_state *crtc_state;
> -       struct drm_encoder *encoder;
> -       u32 encoder_mask = 0;
> -       int i;
> -
> -       for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
> -               encoder_mask |= crtc_state->encoder_mask;
> -               encoder_mask |= crtc->state->encoder_mask;
> -       }
> -
> -       drm_for_each_encoder_mask(encoder, state->dev, encoder_mask)
> -               rockchip_drm_psr_inhibit_get(encoder);
> -}
> -
> -static void
> -rockchip_drm_psr_inhibit_put_state(struct drm_atomic_state *state)
> -{
> -       struct drm_crtc *crtc;
> -       struct drm_crtc_state *crtc_state;
> -       struct drm_encoder *encoder;
> -       u32 encoder_mask = 0;
> -       int i;
> -
> -       for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
> -               encoder_mask |= crtc_state->encoder_mask;
> -               encoder_mask |= crtc->state->encoder_mask;
> -       }
> -
> -       drm_for_each_encoder_mask(encoder, state->dev, encoder_mask)
> -               rockchip_drm_psr_inhibit_put(encoder);
> -}
> -
>  static void
>  rockchip_atomic_helper_commit_tail_rpm(struct drm_atomic_state *old_state)
>  {
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> index 01ff3c858875..22a70ab6e214 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> @@ -13,6 +13,7 @@
>   */
>
>  #include <drm/drmP.h>
> +#include <drm/drm_atomic.h>
>  #include <drm/drm_crtc_helper.h>
>
>  #include "rockchip_drm_drv.h"
> @@ -109,6 +110,42 @@ int rockchip_drm_psr_inhibit_put(struct drm_encoder *encoder)
>  }
>  EXPORT_SYMBOL(rockchip_drm_psr_inhibit_put);
>
> +void rockchip_drm_psr_inhibit_get_state(struct drm_atomic_state *state)
> +{
> +       struct drm_crtc *crtc;
> +       struct drm_crtc_state *crtc_state;
> +       struct drm_encoder *encoder;
> +       u32 encoder_mask = 0;
> +       int i;
> +
> +       for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
> +               encoder_mask |= crtc_state->encoder_mask;
> +               encoder_mask |= crtc->state->encoder_mask;
> +       }
> +
> +       drm_for_each_encoder_mask(encoder, state->dev, encoder_mask)
> +               rockchip_drm_psr_inhibit_get(encoder);
> +}
> +EXPORT_SYMBOL(rockchip_drm_psr_inhibit_get_state);
> +
> +void rockchip_drm_psr_inhibit_put_state(struct drm_atomic_state *state)
> +{
> +       struct drm_crtc *crtc;
> +       struct drm_crtc_state *crtc_state;
> +       struct drm_encoder *encoder;
> +       u32 encoder_mask = 0;
> +       int i;
> +
> +       for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
> +               encoder_mask |= crtc_state->encoder_mask;
> +               encoder_mask |= crtc->state->encoder_mask;
> +       }
> +
> +       drm_for_each_encoder_mask(encoder, state->dev, encoder_mask)
> +               rockchip_drm_psr_inhibit_put(encoder);
> +}
> +EXPORT_SYMBOL(rockchip_drm_psr_inhibit_put_state);
> +
>  /**
>   * rockchip_drm_psr_inhibit_get - acquire PSR inhibit on given encoder
>   * @encoder: encoder to obtain the PSR encoder
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
> index 860c62494496..25350ba3237b 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
> @@ -20,6 +20,9 @@ void rockchip_drm_psr_flush_all(struct drm_device *dev);
>  int rockchip_drm_psr_inhibit_put(struct drm_encoder *encoder);
>  int rockchip_drm_psr_inhibit_get(struct drm_encoder *encoder);
>
> +void rockchip_drm_psr_inhibit_get_state(struct drm_atomic_state *state);
> +void rockchip_drm_psr_inhibit_put_state(struct drm_atomic_state *state);
> +
>  int rockchip_drm_psr_register(struct drm_encoder *encoder,
>                         int (*psr_set)(struct drm_encoder *, bool enable));
>  void rockchip_drm_psr_unregister(struct drm_encoder *encoder);
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index fb70fb486fbf..176d6e8207ed 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -15,6 +15,7 @@
>  #include <drm/drm.h>
>  #include <drm/drmP.h>
>  #include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_uapi.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_flip_work.h>
> @@ -819,10 +820,99 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
>         spin_unlock(&vop->reg_lock);
>  }
>
> +static int vop_plane_atomic_async_check(struct drm_plane *plane,
> +                                       struct drm_plane_state *state)
> +{
> +       struct vop_win *vop_win = to_vop_win(plane);
> +       const struct vop_win_data *win = vop_win->data;
> +       int min_scale = win->phy->scl ? FRAC_16_16(1, 8) :
> +                                       DRM_PLANE_HELPER_NO_SCALING;
> +       int max_scale = win->phy->scl ? FRAC_16_16(8, 1) :
> +                                       DRM_PLANE_HELPER_NO_SCALING;
> +       struct drm_crtc_state *crtc_state;
> +       int ret;
> +
> +       if (plane != state->crtc->cursor)
> +               return -EINVAL;
> +
> +       if (!plane->state)
> +               return -EINVAL;
> +
> +       if (!plane->state->fb)
> +               return -EINVAL;
> +
> +       if (state->state)
> +               crtc_state = drm_atomic_get_existing_crtc_state(state->state,
> +                                                               state->crtc);
> +       else /* Special case for asynchronous cursor updates. */
> +               crtc_state = plane->crtc->state;
> +
> +       ret = drm_atomic_helper_check_plane_state(plane->state,
> +                                                 crtc_state,
> +                                                 min_scale, max_scale,
> +                                                 true, true);
> +       return ret;
> +}
> +
> +static void vop_crtc_atomic_commit_flush(struct drm_crtc *crtc,
> +                                        struct drm_crtc_state *old_crtc_state)
> +{
> +       struct drm_atomic_state *old_state = old_crtc_state->state;
> +       struct drm_plane_state *old_plane_state, *new_plane_state;
> +       struct vop *vop = to_vop(crtc);
> +       struct drm_plane *plane;
> +       int i;
> +
> +       for_each_oldnew_plane_in_state(old_state, plane, old_plane_state,
> +                                      new_plane_state, i) {

Hmm, from what I can see, we're not going through the full atomic
commit sequence, with state flip, so I'm not sure where we would get
the new state here from.

> +               if (!old_plane_state->fb)
> +                       continue;
> +
> +               if (old_plane_state->fb == new_plane_state->fb)
> +                       continue;
> +
> +               drm_framebuffer_get(old_plane_state->fb);
> +               WARN_ON(drm_crtc_vblank_get(crtc) != 0);
> +               drm_flip_work_queue(&vop->fb_unref_work, old_plane_state->fb);
> +               set_bit(VOP_PENDING_FB_UNREF, &vop->pending);
> +       }
> +}
> +
> +static void vop_plane_atomic_async_update(struct drm_plane *plane,
> +                                         struct drm_plane_state *new_state)
> +{
> +       struct vop *vop = to_vop(plane->state->crtc);
> +
> +       if (vop->crtc.state->state)
> +               vop_crtc_atomic_commit_flush(&vop->crtc, vop->crtc.state);

Since we just operate on one plane here, we could just do like this:

if (plane->state->fb && plane->state->fb != new_state->fb) {
               drm_framebuffer_get(plane->state->fb);
               WARN_ON(drm_crtc_vblank_get(crtc) != 0);
               drm_flip_work_queue(&vop->fb_unref_work, plane->state->fb);
               set_bit(VOP_PENDING_FB_UNREF, &vop->pending);
}

However, we cannot simply to this here, because it races with the
vblank interrupt. We need to program the hw plane with the new fb
first and trigger the update. This needs all the careful handling that
is done in vop_crtc_atomic_flush() and so my original suggestion to
just call it.

Of course to call it in its current shape, one needs to have a full
atomic state from a commit, after a flip, but we only have the new
plane state here. Perhaps you could duplicate existing state, update
the desired plane state, flip and then call vop_crtc_atomic_flush()?

Best regards,
Tomasz
