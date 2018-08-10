Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2232AC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2671223BC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2671223BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeHKAIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 20:08:32 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51972 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbeHKAIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 20:08:32 -0400
Received: by mail-wm0-f66.google.com with SMTP id y2-v6so3251438wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 14:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8ldG4f2qnd15PlPf+tIrKFP1Ea/R9IYiINta7pcJQRo=;
        b=mOwc1p/+7a+QUzwy4HNzYF7Qn3LUNYuW26gPfzf76UXgMeiSYNIOukYVlimeOyeK8b
         YwN1p0fh1vJ/hdykdLEuHRgqGA6TVoMKLx1O9kJ2gIpml1sSFFoGa2JLv6YV1FVW1Elc
         slfxyaY2ks33TQF5SWF9VxOImU2HD27oCJNsW4T31ZXTEnSi/WwK9Fz9n//FcqKMn//D
         FnVOYoQ/8QKBNWSwZ3LlZTG2fyzT/nr5pHeFFln6VBVgmtnQyp118jkXRNHHoMdslLki
         KdNS09y11mXTjMwsP6lwYL6nfq7xC0p4nuzHDqHLn9d61LkvT7Q5wWQxWD1f9ks4y/r8
         PcOA==
X-Gm-Message-State: AOUpUlHz+wnQqXIWHzOjc+w5xDRVPNvaChq9qCSSwmTdarl/6iSMdPq8
        I7Gyc7O5KY9NfqPxwSU1KKPG24MDQlINouwILhx8jQ==
X-Google-Smtp-Source: AA+uWPy1exOuCzTiLtw8yfnzWs5Lf4OQ7sjdpSNaMdivhDMlMj8xMhX4sLwAlHsEBzNpxL9I3n8MyAFQAelH0bZ1UoM=
X-Received: by 2002:a1c:5c4:: with SMTP id 187-v6mr2539207wmf.10.1533937013099;
 Fri, 10 Aug 2018 14:36:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:28c2:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 14:36:52
 -0700 (PDT)
In-Reply-To: <20180807203914.2192-8-lyude@redhat.com>
References: <20180807203914.2192-1-lyude@redhat.com> <20180807203914.2192-8-lyude@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 10 Aug 2018 23:36:52 +0200
Message-ID: <CACO55tshwNd0t5+om_MMU70EiuSw3HbLZMttJHGXCPs3Pc6==w@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH v5 07/13] drm/nouveau: Add missing unroll
 functions in nouveau_do_suspend()
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

On Tue, Aug 7, 2018 at 10:39 PM, Lyude Paul <lyude@redhat.com> wrote:
> Currently, it appears that nouveau_do_suspend() forgets to roll back
> suspending fbcon and suspending the device LEDs. We also currently skip
> the entire rollback process if nouveau_display_suspend() fails. So, fix
> that.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: stable@vger.kernel.org
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Karol Herbst <karolherbst@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_drm.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index 5ea8fe992484..db56e9b6b6af 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -674,10 +674,11 @@ nouveau_do_suspend(struct drm_device *dev, bool runtime)
>         if (dev->mode_config.num_crtc) {
>                 NV_DEBUG(drm, "suspending console...\n");
>                 nouveau_fbcon_set_suspend(dev, 1);
> +
>                 NV_DEBUG(drm, "suspending display...\n");
>                 ret = nouveau_display_suspend(dev, runtime);
>                 if (ret)
> -                       return ret;
> +                       goto fail_fbcon;
>         }
>
>         NV_DEBUG(drm, "evicting buffers...\n");
> @@ -719,7 +720,14 @@ nouveau_do_suspend(struct drm_device *dev, bool runtime)
>         if (dev->mode_config.num_crtc) {
>                 NV_DEBUG(drm, "resuming display...\n");
>                 nouveau_display_resume(dev, runtime);
> +
> +fail_fbcon:
> +               NV_DEBUG(drm, "resuming console...\n");
> +               nouveau_fbcon_set_suspend(dev, 0);
>         }
> +
> +       nouveau_led_resume(dev);
> +
>         return ret;
>  }
>
> --
> 2.17.1
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
