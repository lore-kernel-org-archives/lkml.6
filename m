Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26388C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95AE208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lbpKRzFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C95AE208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbeH1CuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 22:50:09 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:43370 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbeH1CuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 22:50:09 -0400
Received: by mail-vk0-f67.google.com with SMTP id s17-v6so325841vke.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VP19BeSsxVX+KQPrmmA1n265la882H4XYhA3Krh5bZ4=;
        b=lbpKRzFHHz6uSjUIE9wqFBtGu6vWkcITgqXMn+ElEDnLZVwlYOkuoEs1xU81RnpHPU
         /4JEziB6eTRBn/OnsmnS5ZUKQlDDdBe8SX1YWExm0MTKuhdMfL47abpBLM0O8LPU2iho
         FLj/A1lgSOiGzlIzz23XShslr9RdgN7aMiKoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VP19BeSsxVX+KQPrmmA1n265la882H4XYhA3Krh5bZ4=;
        b=GafYDhoEIkD//eWCo/76QfH/MusQIWKo/vU/Oa2MmbT7FMPXAXDGmBhCFttoMRQYtc
         tm+sSFLcTxgLdsHuhyQeDlWl/kEGUo+VpYDdDkIxgurHeJZNpHr7HuOujkH/vE2MxPRd
         6oSDXnCtyAF5iU0xWfRXNlnTJB0fMxHHdz9ZB5aVrKdUHB0Q+OfF7pth1anpo17smIJ4
         ToAAEjxyACLDrWjMuPqRsvyaOMdsx913jhH0PuneBfdiSEoW8US3Vlbs55X9havcEiD7
         +Hf7M6aekAYRO9VLqjv7ymInVgwDavSZaIoeFqKB2lVCnc5uQHjeAtC5yW9eMSSr1jmD
         pS5A==
X-Gm-Message-State: APzg51A8sxLJyik0pmJh8y+lC+eGqt0Igu81M/UfnyzXYYwmwGOt1g1a
        GtrAXztYi5SGhzpp7u4Kmx9N5VWbdQAt6Q==
X-Google-Smtp-Source: ANB0VdaloJk2rdgO5eO5xaTI1TsIIVWNliF/CKmQAg3t5+zPeGULP/PhQmrfIKuTxgapKVM3z8YBig==
X-Received: by 2002:a1f:9004:: with SMTP id s4-v6mr9273533vkd.10.1535410886160;
        Mon, 27 Aug 2018 16:01:26 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id f60-v6sm144222uaf.10.2018.08.27.16.01.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 16:01:25 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id q7-v6so403052uam.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:01:24 -0700 (PDT)
X-Received: by 2002:ab0:d8a:: with SMTP id i10-v6mr9234257uak.67.1535410884429;
 Mon, 27 Aug 2018 16:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <1534834795-18494-1-git-send-email-akshu.agrawal@amd.com>
In-Reply-To: <1534834795-18494-1-git-send-email-akshu.agrawal@amd.com>
From:   Daniel Kurtz <djkurtz@chromium.org>
Date:   Mon, 27 Aug 2018 17:01:13 -0600
X-Gmail-Original-Message-ID: <CAGS+omDrETEz8jvAfwLu1wo1MwPpG8EY7RN0oNLQM8EX-yQYtg@mail.gmail.com>
Message-ID: <CAGS+omDrETEz8jvAfwLu1wo1MwPpG8EY7RN0oNLQM8EX-yQYtg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: AMD: Change MCLK to 48Mhz
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, perex@perex.cz,
        tiwai@suse.com, Vijendar.Mukunda@amd.com,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        weiyongjun1@huawei.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 1:00 AM Akshu Agrawal <akshu.agrawal@amd.com> wrote:
>
> 25Mhz MCLK which was earlier used was of spread type.
> Thus, we were not getting accurate rate. The 48Mhz system
> clk is of non-spread type and we are changing to it to get
> accurate rate.
>
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

> ---
>  sound/soc/amd/acp-da7219-max98357a.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
> index cf2f648..55d7f61 100644
> --- a/sound/soc/amd/acp-da7219-max98357a.c
> +++ b/sound/soc/amd/acp-da7219-max98357a.c
> @@ -42,7 +42,7 @@
>  #include "../codecs/da7219.h"
>  #include "../codecs/da7219-aad.h"
>
> -#define CZ_PLAT_CLK 25000000
> +#define CZ_PLAT_CLK 48000000
>  #define DUAL_CHANNEL           2
>
>  static struct snd_soc_jack cz_jack;
> --
> 1.9.1
>
