Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460BEC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1016A20881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cgW51nDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387859AbfAaP6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:58:44 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46132 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733105AbfAaP6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:58:44 -0500
Received: by mail-vs1-f66.google.com with SMTP id n10so2209600vso.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 07:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nH5mNWtP0x8UXx0oXeOP2TvPQWq72kKSDM0AQ5R9WoI=;
        b=cgW51nDDcvuE3NyqlCfSqKlnKnW9lujHHDCIhEqlQIC2Aul5RbAzOIiTw908gytMZB
         V1g036lzhSCjtibG0HpH3e/7KgxRTdjqwoL8ZUJoIZHkl/Rp1A1sehHn0XeadudESJZW
         qk3H1YHBUXRMBVcg0rACrkyag28hBBSEFCR9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nH5mNWtP0x8UXx0oXeOP2TvPQWq72kKSDM0AQ5R9WoI=;
        b=c/SStwcoU1M/Wj0s8ctgGmDX8Hz0pjuGZMMQS2hb+sWw3de2ubKz+SkO9H6f40fG0V
         tuKzY9onabOjpz+NjrHKWWHHWcxZyZe3tWDIQYPx378NHY9ao52f7d0hisDDXLkOij7U
         CxPiABFeRoiqwmPm9cdhZZT+MZJsTi6PZz8AYE5NbZmQCSycEA9cjsferHZHIlBhVk1/
         y9qCXyfBbVpNZY/LEtxP802KOIYl2d7VQRWCJgvCGpVFEUnNYATJ4uyjVnYho2C8CtIt
         9GOGJ3052wNd/8AQAVt5UUTXPCGIWVQlcb2MLMeE6AqaPlSxygIxel0QRAN/og6Jhvyt
         qeyQ==
X-Gm-Message-State: AJcUukcJAsjSWrClmff7nWULPvHNvDQ71YqKhvWxct4rHPCpejU0QpVp
        7XqEpG2wThApd59EJcRJRc4yFrdj2pH9kQdW9AC6ZA==
X-Google-Smtp-Source: ALg8bN4oUHLL/CKdDkMhaSMKFdZ7r88yO/jlXHahRR2GQxANK1q8wQW2xyvCl3eZiHMmLMV41kKo6IDE7jne56P4/0E=
X-Received: by 2002:a67:b245:: with SMTP id s5mr14618120vsh.200.1548950322316;
 Thu, 31 Jan 2019 07:58:42 -0800 (PST)
MIME-Version: 1.0
References: <1548921212-5219-1-git-send-email-chaotian.jing@mediatek.com>
In-Reply-To: <1548921212-5219-1-git-send-email-chaotian.jing@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 31 Jan 2019 16:58:06 +0100
Message-ID: <CAPDyKFruCCs_un1oR-gd1P=ZGryyHwKuY0SkvLO2=Jm1bGV6sQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc: Fix HS setting in mmc_hs400_to_hs200()
To:     Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Hongjie Fang <hongjiefang@asrmicro.com>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019 at 08:53, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> mmc_hs400_to_hs200() begins with the card and host in HS400 mode.
> Therefore, any commands sent to the card should use HS400 timing.
> It is incorrect to reduce frequency to 50Mhz before sending the switch
> command, in this case, only reduce clock frequency to 50Mhz but without
> host timming change, host is still in hs400 mode but clock changed from
> 200Mhz to 50Mhz, which makes the tuning result unsuitable and cause
> the switch command gets response CRC error.

According the eMMC spec there is no violation by decreasing the clock
frequency like this. We can use whatever value <=200MHz.

However, perhaps in practice this becomes an issue, due to the tuning
for HS400 has been done on the "current" frequency.

As as start, I think you need to clarify this in the changelog.

>
> this patch refers to mmc_select_hs400(), make the reduce clock frequency
> after card timing change.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/core/mmc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index da892a5..21b811e 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1239,10 +1239,6 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
>         int err;
>         u8 val;
>
> -       /* Reduce frequency to HS */
> -       max_dtr = card->ext_csd.hs_max_dtr;
> -       mmc_set_clock(host, max_dtr);
> -

As far as I can tell, the reason to why we change the clock frequency
*before* the call to __mmc_switch() below, is probably to try to be on
the safe side and conform to the spec.

However, I think you have a point, as the call to __mmc_switch(),
passes the "send_status" parameter as false, no other command than the
CMD6 is sent to the card.

>         /* Switch HS400 to HS DDR */
>         val = EXT_CSD_TIMING_HS;
>         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
> @@ -1253,6 +1249,10 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
>
>         mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
>
> +       /* Reduce frequency to HS */
> +       max_dtr = card->ext_csd.hs_max_dtr;
> +       mmc_set_clock(host, max_dtr);
> +

Perhaps it's even more correct to change the clock frequency before
the call to mmc_set_timing(host, MMC_TIMING_MMC_DDR52). Otherwise you
will be using the DDR52 timing in the controller, but with a too high
frequency.

>         err = mmc_switch_status(card);
>         if (err)
>                 goto out_err;
> --
> 1.8.1.1.dirty
>

Finally, it sounds like you are trying to fix a real problem, can you
please provide some more information what is happening when the
problem occurs at your side?

Kind regards
Uffe
