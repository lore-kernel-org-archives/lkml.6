Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA52C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D90120878
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="N3A1++Pv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D90120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbeLDLyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:54:43 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:37601 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbeLDLyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:54:43 -0500
Received: by mail-it1-f196.google.com with SMTP id b5so13952587iti.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 03:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G/LXfaOLRExA09Y5qetRKXiuktkyybGcINorPLumcng=;
        b=N3A1++PvVMeZKe5rIpy9IrN0wL37R65ZXua/jAHnOUQOkjqIPxe4aSqyzUSyZnfjcI
         9vfJ9ejElBiEj9heqwI/5a7lkp/W3bc7Gai//teQod4edPVyW2BT6x4qtMq+rCmdyhoy
         RJUmN3QzRSPerW9GGkukBQqfLbHVrHAvbJv80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G/LXfaOLRExA09Y5qetRKXiuktkyybGcINorPLumcng=;
        b=mLLM7UjAsJuxxYnqfmmwdIh0dzKbkBqlSKyiUl/4MTucKMnEmXiPl1f/vw7zn7ivNQ
         UV05UbbgfdCxTBvuqGfPiYk8SlX2dJ+3+783YCXO6D4qiIY/YNU/ZQ2ZStV2OgBIlL3k
         8vroL2yM1SmivR/nEwjRdVquqyR65W4Ov0p+Uujukf2GrSt2JY1XutrL/C4qFfgHHT8L
         o6LA0AUU/6Xu3gw82Cqioj8lE8S/9Ghvf7B3D+XEKEem9NhsiAcBM2erOouh0lHPGVRF
         zqRA6f7mVlgee6chHuYXbYZl/iG4gtS/ogX6sLFeX55yY6+uTRC4jDaSGF1O84BKn0+4
         iYmA==
X-Gm-Message-State: AA+aEWYAqe/lnbxtwu3e1iCQPrR6tEWbBcp4MuETo6aI5ZUQx5JwzJUz
        Hkv98NKYAADWK1y3FdqbdxZdVvmKSfiFOyuJsIkh7A==
X-Google-Smtp-Source: AFSGD/XR8FYaBK6rjONIYjuxEmc7toDd4Dos6kRiqeFEoQspIqqC2qDVh/ztTIuXpDrd6Sf4/h78/hqMUrCuBdAijwE=
X-Received: by 2002:a02:9c53:: with SMTP id h19mr18456723jal.31.1543924482342;
 Tue, 04 Dec 2018 03:54:42 -0800 (PST)
MIME-Version: 1.0
References: <20181203222438.25417-1-eric@anholt.net> <20181203222438.25417-5-eric@anholt.net>
In-Reply-To: <20181203222438.25417-5-eric@anholt.net>
From:   Dave Emett <david.emett@broadcom.com>
Date:   Tue, 4 Dec 2018 11:54:31 +0000
Message-ID: <CAApk1dU5Yfaz0-goS7voFPnwCJa=utedFF4hCLUvVLf=U0nk9Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] drm/v3d: Stop trying to flush L2C on V3D 3.3+
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Spurden <thomas.spurden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Dec 2018 at 22:24, Eric Anholt <eric@anholt.net> wrote:
>
> This cache was replaced with the slice accessing the L2T in the newer
> generations.  Noted by Dave during review.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>

Reviewed-by: Dave Emett <david.emett@broadcom.com>

> ---
>  drivers/gpu/drm/v3d/v3d_gem.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
> index c268c7c79566..8a4be9515179 100644
> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> @@ -130,10 +130,15 @@ v3d_flush_l3(struct v3d_dev *v3d)
>         }
>  }
>
> -/* Invalidates the (read-only) L2 cache. */
> +/* Invalidates the (read-only) L2C cache.  This was the L2 cache for
> + * uniforms and instructions on V3D 3.2.
> + */
>  static void
> -v3d_invalidate_l2(struct v3d_dev *v3d, int core)
> +v3d_invalidate_l2c(struct v3d_dev *v3d, int core)
>  {
> +       if (v3d->ver > 32)
> +               return;
> +
>         V3D_CORE_WRITE(core, V3D_CTL_L2CACTL,
>                        V3D_L2CACTL_L2CCLR |
>                        V3D_L2CACTL_L2CENA);
> @@ -168,7 +173,7 @@ v3d_invalidate_caches(struct v3d_dev *v3d)
>  {
>         v3d_flush_l3(v3d);
>
> -       v3d_invalidate_l2(v3d, 0);
> +       v3d_invalidate_l2c(v3d, 0);
>         v3d_invalidate_slices(v3d, 0);
>         v3d_flush_l2t(v3d, 0);
>  }
> --
> 2.20.0.rc1
>
