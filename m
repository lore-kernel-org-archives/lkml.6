Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E27C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D9E2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqC5nMYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D9E2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbeJZC7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:59:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37322 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeJZC7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:59:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id g9-v6so10322041wrq.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 11:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bFyIVhS1TAjrbNxkCDq8K5hHnjiHT8CLdCBzxz+SOLE=;
        b=TqC5nMYGUawD+2yNAPGcstdN82MSnOzOl2MF+fvJeM/qKbcZmrFevhIjdxpx5octnh
         ybuhOWzuKncDwFTL9KXMc2wFKqM6Ct/9H69fkco6QgtJQay2ukeY+XSJHJ9AklIK7UoR
         amT+flWi8p4vi+/Y0zd0QLbJ4c+i6KO80ybgEJH7hGd4muRtEhP3MAgSNjUVo/enuH/l
         ihHKUk7wQ0dPm8Oww75c1i2geR9phI4lykChLRh2MDHh4rlke0ti13wazhuW+8Kfnpnb
         fGCAWm+Y+oiojvcgoScrzMAbFmVenvCJdf//iEjWDeZTn6j4LL/lTciOL9xKa733vNY6
         i1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bFyIVhS1TAjrbNxkCDq8K5hHnjiHT8CLdCBzxz+SOLE=;
        b=cybk9STOS27JNa4wzKrxMGOQVeAJQxrc3QgWiz5AwfeNTLYJq8t3tftaZ+bLQWCsSH
         sDbwpHnpmzPMS8JlW/MFOy+W7L68IH37a4GhmPCiknSFDz0cvoFxKcythosLkha+a09R
         kIKH9AmzwPuU9au4KbI9/KQXAPLpxDoG+hotBLb3IfqdBBjvbQqwzEsgvXsg/ArPYIFh
         oAihUpHsOcmX68m5Py+zJ168qNLjvsHOPPlfgnW4EmXi5mdzHH+AmDf5rDokAiVFyLZZ
         77y//lEro6pEUYKeZy5WEB+RKbB8oJIxpP+g+dhuJ4H3DHH5YTJoTFssA67TNyM58AnO
         4J/Q==
X-Gm-Message-State: AGRZ1gKGcND89ft8ndxZEFiT5wlctJa9Y/gAcui+uzgmxSXmppJ0WRs2
        FsVKbQ6CTFFGdHmwEpE6DHsJ5UdP8q+j/aq4xRXuaQ==
X-Google-Smtp-Source: AJdET5eJF4zdzSAfk17Tvc3OmXgAYcgVEjHVChDfNlbimKuZhX+yR/s7yIZrhcub/F4OSv+yu6HhgR+gjY9EAuCo8wE=
X-Received: by 2002:adf:f852:: with SMTP id d18-v6mr2931194wrq.125.1540491950577;
 Thu, 25 Oct 2018 11:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20181021103958.12892-1-yuehaibing@huawei.com>
In-Reply-To: <20181021103958.12892-1-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 25 Oct 2018 14:25:36 -0400
Message-ID: <CADnq5_P=0yUepxenN8NbdCGZhe6S2g+RsZnbLDFpzysB01_mEA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/powerplay: remove duplicated includes
To:     yuehaibing@huawei.com
Cc:     Rex Zhu <rex.zhu@amd.com>, "Quan, Evan" <evan.quan@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 11:32 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Remove some duplicated include.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/inc/hwmgr.h               | 1 -
>  drivers/gpu/drm/amd/powerplay/inc/smu7_common.h         | 4 ----
>  drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c | 1 -
>  drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c     | 1 -
>  drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c     | 1 -
>  5 files changed, 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> index e5a60aa..07d180ce 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> @@ -28,7 +28,6 @@
>  #include "hardwaremanager.h"
>  #include "hwmgr_ppt.h"
>  #include "ppatomctrl.h"
> -#include "hwmgr_ppt.h"
>  #include "power_state.h"
>  #include "smu_helper.h"
>
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu7_common.h b/drivers/gpu/drm/amd/powerplay/inc/smu7_common.h
> index 65eb630..94bf7b6 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smu7_common.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smu7_common.h
> @@ -40,10 +40,6 @@
>  #include "bif/bif_5_0_d.h"
>  #include "bif/bif_5_0_sh_mask.h"
>
> -
> -#include "bif/bif_5_0_d.h"
> -#include "bif/bif_5_0_sh_mask.h"
> -
>  #include "dce/dce_10_0_d.h"
>  #include "dce/dce_10_0_sh_mask.h"
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> index 872d382..2b2c266 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> @@ -44,7 +44,6 @@
>
>  #include "smu7_hwmgr.h"
>  #include "hardwaremanager.h"
> -#include "ppatomctrl.h"
>  #include "atombios.h"
>  #include "pppcielanes.h"
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
> index d0eb8ab..d111dd4 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
> @@ -29,7 +29,6 @@
>  #include "rv_ppsmc.h"
>  #include "smu10_driver_if.h"
>  #include "smu10.h"
> -#include "ppatomctrl.h"
>  #include "pp_debug.h"
>
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> index 9f71512..1e69300 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> @@ -40,7 +40,6 @@
>
>  #include "smu7_hwmgr.h"
>  #include "hardwaremanager.h"
> -#include "ppatomctrl.h"
>  #include "atombios.h"
>  #include "pppcielanes.h"
>
> --
> 1.8.3.1
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
