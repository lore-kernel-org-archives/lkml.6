Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71B4C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75CAA20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YMXNNONm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75CAA20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbeLMHoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 02:44:12 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:32992 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbeLMHoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 02:44:11 -0500
Received: by mail-yb1-f195.google.com with SMTP id c67so448061ybf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 23:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N2z45zySSpBNWTDX9P/10CqNrMQHhWpVlI8K95yLzwY=;
        b=YMXNNONmk4JrLlqqm/kJiz5LH4lAQDf+71RPNtfeozTLyXzPocx+QWhmlQ6XkolQCs
         YwngJhk/AaE83nP5E0DwOInhjWg4jtRg8ROPnUhshtQUb1uX6gq0huj4liydOXEjegX1
         eSuvF8nVibxQklx54q0GZNHHklQLq6DGK/3vA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N2z45zySSpBNWTDX9P/10CqNrMQHhWpVlI8K95yLzwY=;
        b=oLtuKB3FPhOuvNx1hV5n4IPRIw6BEiD7GpdpdebY9DvdmUuzm0euZBoxMGQ+H5jeED
         3kTNvcPl8kuCQmw93cu4J7oK0b5XfdT2Kdsbf1ogYRV9v1plHPVboWHWqCtt/5mtF7kw
         9G/vVdJIvQ5M04eYWNraytBjJu+uOxirJE7a+FquHvmcFMMe/oBOIcRiyxx4N9ngeiIN
         ZKoslGD1P/q7X3bF818k/Kcwtl633xvF6HhRNnfXuqHbjRk4WaXEc/KdqEmTjAPyXume
         Ho+JvmqlDOzUcXyIzubecjV/phhkN2uSn+bTlT+UbL33qz1Cy7YqvqScSnr9ngL6mWnR
         ybTQ==
X-Gm-Message-State: AA+aEWauK84pyyT6aQt0CdsFylijBiVzj3lDNDPsuP2pD76rPp2zTXLf
        jCm/5YZPi0a4O7tmI6CM0O0/8Y2hDvY=
X-Google-Smtp-Source: AFSGD/WqpIoCw94WMtJsJAQZHAyBIm7/HgzVYI4Hl26bWd8htNzaa+o4hEf74OAYyhar8Xhi70dGuA==
X-Received: by 2002:a25:a1aa:: with SMTP id a39-v6mr22907811ybi.381.1544687050380;
        Wed, 12 Dec 2018 23:44:10 -0800 (PST)
Received: from mail-yw1-f54.google.com (mail-yw1-f54.google.com. [209.85.161.54])
        by smtp.gmail.com with ESMTPSA id v78sm414051ywa.103.2018.12.12.23.44.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 23:44:09 -0800 (PST)
Received: by mail-yw1-f54.google.com with SMTP id y194so451594ywg.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 23:44:08 -0800 (PST)
X-Received: by 2002:a0d:eb06:: with SMTP id u6mr23356312ywe.443.1544687048496;
 Wed, 12 Dec 2018 23:44:08 -0800 (PST)
MIME-Version: 1.0
References: <20181123215354.14540-1-helen.koike@collabora.com>
In-Reply-To: <20181123215354.14540-1-helen.koike@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 13 Dec 2018 16:43:57 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BHPjode=KqEHs=eNqqCe-xvsqx1ko9hQn29djFxuSWUA@mail.gmail.com>
Message-ID: <CAAFQd5BHPjode=KqEHs=eNqqCe-xvsqx1ko9hQn29djFxuSWUA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/atomic: add ATOMIC_AMEND flag to the Atomic IOCTL.
To:     helen.koike@collabora.com
Cc:     David Airlie <airlied@linux.ie>, dnicoara@chromium.org,
        Alexandros Frantzis <alexandros.frantzis@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helen,

On Sat, Nov 24, 2018 at 6:54 AM Helen Koike <helen.koike@collabora.com> wrote:
>
> This flag tells core to jump ahead the queued update if the conditions
> in drm_atomic_async_check() are met. That means we are only able to do an
> async update if no modeset is pending and update for the same plane is
> not queued.

First of all, thanks for the patch. Please see my comments below.

If the description above applies (and AFAICT that's what the existing
code does indeed), then this doesn't sound like "amend" to me. It
sounds exactly as the kernel code calls it - "async update" or perhaps
"instantaneous commit" could better describe it?

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
> [updated for upstream]
> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> ---
> Hi,
>
> This is the second attempt to introduce the new ATOMIC_AMEND flag for atomic
> operations, see the commit message for a more detailed description.
>
> This was tested using a small program that exercises the uAPI for easy
> sanity testing. The program was created by Alexandros and modified by
> Enric to test the capability flag [2].
>
> To test, just build the program and use the --atomic flag to use the cursor
> plane with the ATOMIC_AMEND flag. E.g.
>
>   drm_cursor --atomic
>
> The test worked on a rockchip Ficus v1.1 board on top of mainline plus
> the patch to update cursors asynchronously through atomic for the
> drm/rockchip driver plus the DRM_CAP_ASYNC_UPDATE patch.
>
> Alexandros also did a proof-of-concept to use this flag and draw cursors
> using atomic if possible on ozone [1].
>
> Thanks
> Helen
>
> [1] https://chromium-review.googlesource.com/c/chromium/src/+/1092711
> [2] https://gitlab.collabora.com/eballetbo/drm-cursor/commits/async-capability
>
>
> Changes in v2:
> - rebase tree
> - do not fall back to a non-async update if if there isn't any
> pending commit to amend
>
> Changes in v1:
> - https://patchwork.freedesktop.org/patch/243088/
> - Only enable it if userspace requests it.
> - Only allow async update for cursor type planes.
> - Rename ASYNC_UPDATE for ATOMIC_AMEND.
>
>  drivers/gpu/drm/drm_atomic_helper.c | 6 +++++-
>  drivers/gpu/drm/drm_atomic_uapi.c   | 6 ++++++
>  include/uapi/drm/drm_mode.h         | 4 +++-
>  3 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 269f1a74de38..333190c6a0a4 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -934,7 +934,7 @@ int drm_atomic_helper_check(struct drm_device *dev,
>         if (ret)
>                 return ret;
>
> -       if (state->legacy_cursor_update)
> +       if (state->async_update || state->legacy_cursor_update)
>                 state->async_update = !drm_atomic_helper_async_check(dev, state);
>
>         return ret;
> @@ -1602,6 +1602,10 @@ int drm_atomic_helper_async_check(struct drm_device *dev,
>         if (new_plane_state->fence)
>                 return -EINVAL;
>
> +       /* Only allow async update for cursor type planes. */
> +       if (plane->type != DRM_PLANE_TYPE_CURSOR)
> +               return -EINVAL;
> +

So the existing upstream code already allowed this for any planes and
we're restricting this to cursor planes only. Is this expected? No
potential users that already started using this for other plane types?

Best regards,
Tomasz
