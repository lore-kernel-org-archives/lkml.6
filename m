Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116E1C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B2A2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cSjiWjIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B2A2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeLCRgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:36:44 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37093 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeLCRgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:36:44 -0500
Received: by mail-io1-f66.google.com with SMTP id f14so5721886iol.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 09:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aJByGiHI+RzUysGTZNqib4yObRx5kjhaz522l9pDvpQ=;
        b=cSjiWjIkEJ20GAAgk5/MtwvMw8s6potu/QLcDRbTcClwa7JBk4KESjdSvejh/zTgJU
         5p3wiCJP+5I9m8IZGisJv6xgoDJ13fgMnvMfnHhdeJQOsnZhHBWparsrDoASNTr96KvX
         LewuLufwCd1ozxFLVGCjnnnCKoRh89SqrdVX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aJByGiHI+RzUysGTZNqib4yObRx5kjhaz522l9pDvpQ=;
        b=KjjS5/zzQhzxTx5+fDpWJVTtGPF1TSWjvPz+tf5UqAMbJaZ7xSwGmjYyaHDMONZUOT
         UHumBb6ux/pVVId3Oiw6gkYkcl5VHs4ehdAt3jcKCc2Hx3BqcqQcPHE6EM+UXS4jwFHe
         I0r7PAHx10xtTMCJ3gxppLgHRqp8CdWHgq5hPS0W96FksZEVjRkR4MEJTMwHQiwB58hI
         cQ8Kl9JtIdSQ0BAYJ5MiQ+Xlx3N0RYRQQBhhp0nE5AhnECUxs75w2yVc/89RCYfSajWc
         6UHwI+x4B7QGQmgF/CRp1dSC/Bn5m4F7U5TQtADqAgM+e6l2u+00O6D4D29vkAWeCPVP
         Zv1Q==
X-Gm-Message-State: AA+aEWYtVO0mZtvuawZuNqmIaBa/Z/0h2PL6xMaIfG2MU/s7aoaPWxRn
        +pSc/qLRYGKP/4126ttWj4kzlAl3vfG8J7t/SaVKmw==
X-Google-Smtp-Source: AFSGD/VSLPNdOBsxIL/8TIdPPy1iSOq/UF2P5V/Utg3/2wDxiymy4lItlEKtLmRUSPVi7ZIvYLgQ1yXYONz4NuOwKNw=
X-Received: by 2002:a6b:ce06:: with SMTP id p6mr13467753iob.189.1543858596588;
 Mon, 03 Dec 2018 09:36:36 -0800 (PST)
MIME-Version: 1.0
References: <20181201005759.28093-1-eric@anholt.net> <20181201005759.28093-3-eric@anholt.net>
In-Reply-To: <20181201005759.28093-3-eric@anholt.net>
From:   Dave Emett <david.emett@broadcom.com>
Date:   Mon, 3 Dec 2018 17:36:25 +0000
Message-ID: <CAApk1dXSg2dxxjiDrPc90UKfiPKh2NX62aQFPktPMUO96Z4H+g@mail.gmail.com>
Subject: Re: [PATCH 3/6] drm/v3d: Don't bother flushing L1TD at job start.
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Spurden <thomas.spurden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Dec 2018 at 00:58, Eric Anholt <eric@anholt.net> wrote:
>
> This is the write combiner for TMU writes.  You're supposed to flush
> that at job end if you had dirtied any cachelines.  Flushing it at job
> start then doesn't make any sense.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>

Reviewed-by: Dave Emett <david.emett@broadcom.com>

> Fixes: 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")
> ---
>  drivers/gpu/drm/v3d/v3d_gem.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
> index 34103205b7cb..cc4d025b01e0 100644
> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> @@ -139,22 +139,10 @@ v3d_invalidate_l2(struct v3d_dev *v3d, int core)
>                        V3D_L2CACTL_L2CENA);
>  }
>
> -static void
> -v3d_invalidate_l1td(struct v3d_dev *v3d, int core)
> -{
> -       V3D_CORE_WRITE(core, V3D_CTL_L2TCACTL, V3D_L2TCACTL_TMUWCF);
> -       if (wait_for(!(V3D_CORE_READ(core, V3D_CTL_L2TCACTL) &
> -                      V3D_L2TCACTL_L2TFLS), 100)) {
> -               DRM_ERROR("Timeout waiting for L1T write combiner flush\n");
> -       }
> -}
> -
>  /* Invalidates texture L2 cachelines */
>  static void
>  v3d_flush_l2t(struct v3d_dev *v3d, int core)
>  {
> -       v3d_invalidate_l1td(v3d, core);
> -
>         V3D_CORE_WRITE(core, V3D_CTL_L2TCACTL,
>                        V3D_L2TCACTL_L2TFLS |
>                        V3D_SET_FIELD(V3D_L2TCACTL_FLM_FLUSH, V3D_L2TCACTL_FLM));
> --
> 2.20.0.rc1
>
