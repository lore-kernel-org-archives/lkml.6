Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9367C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E82520848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DQxY93Qi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E82520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeLCR7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:59:23 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35933 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeLCR7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:59:22 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so9965571itj.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 09:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tg51AoWSqFICnv/a09JiIf3Iy5MjdU5ikBkWJ/TTxLs=;
        b=DQxY93QiJHAw1Yv4ZpThVkV4WSZdoQCRMw0xXUp1fHU782vErdOJ8wHa7c3t6AnVIh
         /fGBR8KY3U79BltbVSBpYigwpZkgLlnTKOgOkD9TiuqPFA5I+otkowr2+VvQWiZQE0w4
         zYSbwRHG/2ej4cWiIs4idknAzcIN/esOSyhf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tg51AoWSqFICnv/a09JiIf3Iy5MjdU5ikBkWJ/TTxLs=;
        b=BviNEX1Ejvqrb84ULpJzWyDaehis8s8k1xVJ8HFoOFpDI4ChuMWEgY1JFod++jSb4W
         UiAa6hQBkaaKAdGjtBvLyaQb9/wi2CPInPrMZHDB1lAR/Zi1BweNNoHnNkn6JixpPPCF
         /UHVWQ81c1DkJjAAYD/PmNKFBQGiPXFOpBAHbazsLu43zxcgNMi7hT2FMNR9+Ft8Mzmy
         YGeGiVcnP1sZGrvihOp7MKCVA4kYp/gAV9B0zzKPvTmb+FG6l0YPGZLrt7lV8HmgAZt/
         ZpfXuSwIARv5wfIYUQFqtFNYRfScxB9nl3Bad0XksQJFwrE1sIj7Hs6BRkhgPO0D6UeN
         ygFg==
X-Gm-Message-State: AA+aEWbAYtzGGOtNfDVjWJ/ol4Fgfi5kUzapIkGnOss0t4sOFAkrrCN+
        1iCyoeUEnE0CYdfzDLYEnfgCIjJULdCvr+wYJ8zKrqQ2U4c=
X-Google-Smtp-Source: AFSGD/VA5XdDGw/NuaGMbNd/ykSmvI79A4XNReLHNa1OcDg5AdH7sttzV8pEq6KUroMM2hiM6XGBQJDNbzD3VFmQ6xM=
X-Received: by 2002:a24:fe41:: with SMTP id w62mr9207016ith.23.1543859957006;
 Mon, 03 Dec 2018 09:59:17 -0800 (PST)
MIME-Version: 1.0
References: <20181201005759.28093-1-eric@anholt.net> <20181201005759.28093-4-eric@anholt.net>
In-Reply-To: <20181201005759.28093-4-eric@anholt.net>
From:   Dave Emett <david.emett@broadcom.com>
Date:   Mon, 3 Dec 2018 17:59:05 +0000
Message-ID: <CAApk1dXC5knQ7_JuknCjm4vc2Y_OfLK0Y+ci52WjCN3sFnDHdA@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/v3d: Drop the wait for L2T flush to complete.
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Spurden <thomas.spurden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm surprised this made such a big difference. It should not take a
long time to flush the L2T -- no memory access should be involved, it
should just be a matter of the L2T iterating over its lines clearing
the tags. This should take thousands of V3D cycles, not milliseconds.
So the 3-4ms stall seems worthy of more investigation to me.

A comment describing why no waits are necessary would be good.

On Sat, 1 Dec 2018 at 00:58, Eric Anholt <eric@anholt.net> wrote:
>
> According to Dave, once you've started an L2T flush, all L2T accesses
> will be blocked until the flush completes.  This fixes a consistent
> 3-4ms stall between the ioctl and running the job, and 3DMMES Taiji
> goes from 27fps to 110fps.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>

Reviewed-by: Dave Emett <david.emett@broadcom.com>

> Fixes: 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")
> ---
>  drivers/gpu/drm/v3d/v3d_gem.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
> index cc4d025b01e0..0bd6892e3044 100644
> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> @@ -146,10 +146,6 @@ v3d_flush_l2t(struct v3d_dev *v3d, int core)
>         V3D_CORE_WRITE(core, V3D_CTL_L2TCACTL,
>                        V3D_L2TCACTL_L2TFLS |
>                        V3D_SET_FIELD(V3D_L2TCACTL_FLM_FLUSH, V3D_L2TCACTL_FLM));
> -       if (wait_for(!(V3D_CORE_READ(core, V3D_CTL_L2TCACTL) &
> -                      V3D_L2TCACTL_L2TFLS), 100)) {
> -               DRM_ERROR("Timeout waiting for L2T flush\n");
> -       }
>  }
>
>  /* Invalidates the slice caches.  These are read-only caches. */
> --
> 2.20.0.rc1
>
