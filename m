Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FEBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916342086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vRJ2/iB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916342086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbeK2H34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 02:29:56 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51448 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbeK2H34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 02:29:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id s14so12052wmh.1;
        Wed, 28 Nov 2018 12:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bXQ5mo472NTaWAXtx2daZ7fe6IXxPQASrQ4uv5YF9gY=;
        b=vRJ2/iB09y8fcwsLwVJ6GuuTFPnNAh78MJhCx8G0jun8UZOSyLHt2ocTmxwqcUupnF
         XHYtN4oSe4LEoLpfHyAJqGkg1Y+K0hlsE/5N6M3l9Xud2by4ZachjQC+hoTcPBME+qI6
         kha20S+zlTCSmqah7rKROHT+14n7+COtkwQmrXNAkzyTSOHZA4ONPg/fUvoWSaqS0qBF
         q8m6JGfd5kSHD7xfnoEm0TgixK4RZITfI93Qn4yrM9+LMncv/kI9aDezQAJIMcoiUHtv
         mgKwSpjXw8571gt75ix/AzFjaTsOTiF0fJbk3V6nuAi6IYX10Wlx/d98O8L2/QQ8tIcC
         A32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bXQ5mo472NTaWAXtx2daZ7fe6IXxPQASrQ4uv5YF9gY=;
        b=evtRfNMLmSYbLxne09oHs6Bj41OkMAlUUyQmB8Rx3qBPRqV0A8N0YStJAeydLHKGpP
         K7Ufy9glti2taud+HqWxdsD74+/a0Xv7duhMVDuQK1vzD6qG4txpnBvYzvMHZI0zwpmE
         X5fBE56PkDIHDe15eBi9az4dyhVylYlZkT0OHVxGI+Jc+KZDR2QBCbbXeYbIpZWE1txM
         zxq6YQHZBzFgJGevuCgil4/jTjKpfXZINqfG8R1cmsTmkQITe1m48Uw63RzOGVo3b4Zt
         9x+8c7o32rYpJMe0KN+XEq5kbwl57f0SfiOfHHgL6z4F1Eet4z+MQVR+JVGqYKYHnq7e
         Y2eg==
X-Gm-Message-State: AA+aEWbu8NPkJ+ucL12JDMdkwAzJ4MOfs9ZBf3WCzP/KZW9UjJ8dAwC5
        Hh5UOxcFq9C78wGdRSaNqZ2mOoQJzMmKMXI5Bnw=
X-Google-Smtp-Source: AFSGD/XA98StA3ofmicAmYgkjFT54zEUSJp4BTmwieejRkT6ExkxADglb4afGzHovorWCgQNfMy/lPkUYTqLLYWYnzg=
X-Received: by 2002:a1c:47:: with SMTP id 68mr3892282wma.89.1543436822127;
 Wed, 28 Nov 2018 12:27:02 -0800 (PST)
MIME-Version: 1.0
References: <20181127141943.27110-1-colin.king@canonical.com>
In-Reply-To: <20181127141943.27110-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 28 Nov 2018 15:26:48 -0500
Message-ID: <CADnq5_Nxz3o2ttyAkN=+Ti+N8RMkWx5bQHqM+bsbZ53=bNF3-A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pp: fix spelling mistake "dependancy" -> "dependency"
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Rex Zhu <rex.zhu@amd.com>, "Quan, Evan" <evan.quan@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 9:19 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There are spelling mistakes in PP_ASSERT_WITH_CODE messages, fix these.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> index 88f6b35ea6fe..5dcd21d29dbf 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> @@ -269,7 +269,7 @@ static int smu7_construct_voltage_tables(struct pp_hwmgr *hwmgr)
>                                         hwmgr->dyn_state.mvdd_dependency_on_mclk);
>
>                 PP_ASSERT_WITH_CODE((0 == result),
> -                               "Failed to retrieve SVI2 MVDD table from dependancy table.",
> +                               "Failed to retrieve SVI2 MVDD table from dependency table.",
>                                 return result;);
>         }
>
> @@ -288,7 +288,7 @@ static int smu7_construct_voltage_tables(struct pp_hwmgr *hwmgr)
>                         result = phm_get_svi2_voltage_table_v0(&(data->vddci_voltage_table),
>                                         hwmgr->dyn_state.vddci_dependency_on_mclk);
>                 PP_ASSERT_WITH_CODE((0 == result),
> -                               "Failed to retrieve SVI2 VDDCI table from dependancy table.",
> +                               "Failed to retrieve SVI2 VDDCI table from dependency table.",
>                                 return result);
>         }
>
> @@ -317,7 +317,7 @@ static int smu7_construct_voltage_tables(struct pp_hwmgr *hwmgr)
>                                 table_info->vddc_lookup_table);
>
>                 PP_ASSERT_WITH_CODE((0 == result),
> -                       "Failed to retrieve SVI2 VDDC table from dependancy table.", return result;);
> +                       "Failed to retrieve SVI2 VDDC table from dependency table.", return result;);
>         }
>
>         tmp = smum_get_mac_definition(hwmgr, SMU_MAX_LEVELS_VDDC);
> --
> 2.19.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
