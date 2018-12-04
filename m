Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D757C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4B52146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Yr+JSd/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4B52146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeLDLx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:53:59 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34298 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeLDLx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:53:59 -0500
Received: by mail-io1-f65.google.com with SMTP id r9so5912391ioa.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 03:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=11zYls2YFOKJJrykkBynHm3qlAQiGahfjD0of+KF8mU=;
        b=Yr+JSd/990S1gBhnUJ7aTyyxsdT+5zRRTn4z2ER4xOK9GLuEWVLVBCz93mbC7+xKAJ
         t7h85fDprRBfoGh2sq6u/2t7c2WYQT9pi9zpi/wy8p7zsDJBts9lbgQLecAuZJcoNxSE
         3aZ/u3fkPuiUdiDilmPIsi3xtZcXQFUurA1us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=11zYls2YFOKJJrykkBynHm3qlAQiGahfjD0of+KF8mU=;
        b=pK81tfXNMgmjjEV2vSb3rZofWMH3uyc7TUTGWCYUEwEXAF/Dx1jtvidfpSVgtQtQG3
         Yp30MmaFUAjcQIaKTk2hHUgxWTHh4K3+1riVPDtCy8+NK3Ng6Zq+PXq6IQqNtHnVmytE
         NtULnT/0jvXjy2eIOgq4xOr6r7RnL7pNyECLFygMoayKm+5ueM5AMUlD4KqUUJJFaCMJ
         ZbNbfSpUcRarpyBpjqYdfztXlkd5UI6kPuz/xMhELcX6rTTaCZ5lKVmOU/7ttzE+QWi8
         U8KpXQAQ9w8LC6Rb6KV79wT3R7/NYqIEXIi/QDgNnxbu7uygEzULQlKf0nZkpGbV6VLZ
         MDoQ==
X-Gm-Message-State: AA+aEWb5GiHbyn1DKf9cSD8GybPRNM4HI0f4fJ7MbA0EJfzKniwXe3YK
        C6284Q/lw4lV705KJgd2pd6+ESkvX2bNE6thcPkdrg==
X-Google-Smtp-Source: AFSGD/X1WuzBpwzjnXH9NIlSfgwgycfowFp5ExWdq2thg0DLsTdOjdoBVs4hoCfGmvKbSr7uh1qD7ymdkV1Z3r5YWXk=
X-Received: by 2002:a6b:8e16:: with SMTP id q22mr16706662iod.84.1543924438266;
 Tue, 04 Dec 2018 03:53:58 -0800 (PST)
MIME-Version: 1.0
References: <20181203222438.25417-1-eric@anholt.net> <20181203222438.25417-4-eric@anholt.net>
In-Reply-To: <20181203222438.25417-4-eric@anholt.net>
From:   Dave Emett <david.emett@broadcom.com>
Date:   Tue, 4 Dec 2018 11:53:47 +0000
Message-ID: <CAApk1dV+AhYZ2vf+thJ9ZghGA8VNg-wc=490dpngRu5PS8Ev4w@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] drm/v3d: Drop the wait for L2T flush to complete.
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
> According to Dave, once you've started an L2T flush, all L2T accesses
> will be blocked until the flush completes.  This fixes a consistent
> 3-4ms stall between the ioctl and running the job, and 3DMMES Taiji
> goes from 27fps to 110fps.
>
> v2: Leave a note about why we don't need to wait for completion.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>

Reviewed-by: Dave Emett <david.emett@broadcom.com>

> Fixes: 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")
> Reviewed-by: Dave Emett <david.emett@broadcom.com> (v1, comment requested)
> ---
>  drivers/gpu/drm/v3d/v3d_gem.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
> index 01e879c71cad..c268c7c79566 100644
> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> @@ -143,13 +143,13 @@ v3d_invalidate_l2(struct v3d_dev *v3d, int core)
>  static void
>  v3d_flush_l2t(struct v3d_dev *v3d, int core)
>  {
> +       /* While there is a busy bit (V3D_L2TCACTL_L2TFLS), we don't
> +        * need to wait for completion before dispatching the job --
> +        * L2T accesses will be stalled until the flush has completed.
> +        */
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
