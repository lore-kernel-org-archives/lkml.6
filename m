Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967268AbeBNKi2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:38:28 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:35961 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967234AbeBNKiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:38:25 -0500
X-Google-Smtp-Source: AH8x227daXt6gZdcTT2zXZXeAbY0knEl+xOQPBa27juaGs12ubAJIJkIRuKSvrCjHlKckQXFC0d5YTYnJSbqevyJqBI=
MIME-Version: 1.0
In-Reply-To: <1518111705-11122-1-git-send-email-vlvrdv@gmail.com>
References: <1518047981-23958-1-git-send-email-vlvrdv@gmail.com> <1518111705-11122-1-git-send-email-vlvrdv@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 14 Feb 2018 11:38:24 +0100
Message-ID: <CAPDyKFrSdWQNBL+9UKGwRK3QQ3u4vE2qmn4N92yjwVC8E_j_Qg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: optimize mmc_calc_max_discard
To: Sergio Valverde <vlvrdv@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 February 2018 at 18:41, Sergio Valverde <vlvrdv@gmail.com> wrote:
> If the max_discard value is zero, the conditional branch that checks the
> trim capabilities will never update this value with max_trim.
>
> Change the condition statement to also check the max_discard value in order
> to avoid an unnecessary call to mmc_do_calc_max_discard.
>
> Signed-off-by: Sergio Valverde <vlvrdv@gmail.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
> Changes in v2:
> - Evaluate max_discard to avoid unnecessary calls to mmc_can_trim.
>
>  drivers/mmc/core/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 1f0f44f..c32c0f4 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2567,7 +2567,7 @@ unsigned int mmc_calc_max_discard(struct mmc_card *card)
>                 return card->pref_erase;
>
>         max_discard = mmc_do_calc_max_discard(card, MMC_ERASE_ARG);
> -       if (mmc_can_trim(card)) {
> +       if (max_discard && mmc_can_trim(card)) {
>                 max_trim = mmc_do_calc_max_discard(card, MMC_TRIM_ARG);
>                 if (max_trim < max_discard)
>                         max_discard = max_trim;
> --
> 2.7.4
>
