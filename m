Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751908AbeEGDln (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 23:41:43 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:47233 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbeEGDlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 23:41:40 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w473fKiW029600
X-Nifty-SrcIP: [209.85.217.170]
X-Google-Smtp-Source: AB8JxZrsc38oJ+N8QdQqP1vn10+vZ05g7mkhWiwyLMCANGEWNB2JIGNKMdKOzSZhs0/9j3cpaE0S8XuOIV2eslAXiJI=
MIME-Version: 1.0
In-Reply-To: <1525350041-22995-2-git-send-email-absahu@codeaurora.org>
References: <1525350041-22995-1-git-send-email-absahu@codeaurora.org> <1525350041-22995-2-git-send-email-absahu@codeaurora.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 7 May 2018 12:40:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNASWErFrvW+_6Lsw-aqO4T3=iyRZLXG21ML+ebOX=po2Zw@mail.gmail.com>
Message-ID: <CAK7LNASWErFrvW+_6Lsw-aqO4T3=iyRZLXG21ML+ebOX=po2Zw@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] mtd: rawnand: helper function for setting up ECC parameters
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        Archit Taneja <architt@codeaurora.org>,
        Richard Weinberger <richard@nod.at>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Andy Gross <andy.gross@linaro.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-03 21:20 GMT+09:00 Abhishek Sahu <absahu@codeaurora.org>:
> commit 2c8f8afa7f92 ("mtd: nand: add generic helpers to check,
> match, maximize ECC settings") provides generic helpers which
> drivers can use for setting up ECC parameters.
>
> Since same board can have different ECC strength nand chips so
> following is the logic for setting up ECC strength and ECC step
> size, which can be used by most of the drivers.
>
> 1. If both ECC step size and ECC strength are already set
>    (usually by DT) then just check whether this setting
>    is supported by NAND controller.
> 2. If NAND_ECC_MAXIMIZE is set, then select maximum ECC strength
>    supported by NAND controller.
> 3. Otherwise, try to match the ECC step size and ECC strength closest
>    to the chip's requirement. If available OOB size can't fit the chip
>    requirement then select maximum ECC strength which can be fit with
>    available OOB size with warning.
>
> This patch introduces nand_ecc_param_setup function which calls the
> required helper functions for the above logic. The drivers can use
> this single function instead of calling the 3 helper functions
> individually.
>
> CC: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
> * Changes from v1:
>
>   NEW PATCH
>
>  drivers/mtd/nand/raw/nand_base.c | 42 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/mtd/rawnand.h      |  3 +++
>  2 files changed, 45 insertions(+)
>
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 72f3a89..dd7a984 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -6249,6 +6249,48 @@ int nand_maximize_ecc(struct nand_chip *chip,
>  }
>  EXPORT_SYMBOL_GPL(nand_maximize_ecc);
>
> +/**
> + * nand_ecc_param_setup - Set the ECC strength and ECC step size
> + * @chip: nand chip info structure
> + * @caps: ECC engine caps info structure
> + * @oobavail: OOB size that the ECC engine can use
> + *
> + * Choose the ECC strength according to following logic
> + *
> + * 1. If both ECC step size and ECC strength are already set (usually by DT)
> + *    then check if it is supported by this controller.
> + * 2. If NAND_ECC_MAXIMIZE is set, then select maximum ECC strength.
> + * 3. Otherwise, try to match the ECC step size and ECC strength closest
> + *    to the chip's requirement. If available OOB size can't fit the chip
> + *    requirement then fallback to the maximum ECC step size and ECC strength
> + *    and print the warning.
> + *
> + * On success, the chosen ECC settings are set.
> + */
> +int nand_ecc_param_setup(struct nand_chip *chip,
> +                        const struct nand_ecc_caps *caps, int oobavail)
> +{
> +       int ret;
> +
> +       if (chip->ecc.size && chip->ecc.strength)
> +               return nand_check_ecc_caps(chip, caps, oobavail);
> +
> +       if (chip->ecc.options & NAND_ECC_MAXIMIZE)
> +               return nand_maximize_ecc(chip, caps, oobavail);
> +
> +       if (!nand_match_ecc_req(chip, caps, oobavail))
> +               return 0;
> +
> +       ret = nand_maximize_ecc(chip, caps, oobavail);


Why two calls for nand_maximize_ecc()?

My code is simpler, and does not display
false-positive warning.


> +       if (!ret)
> +               pr_warn("ECC (step, strength) = (%d, %d) not supported on this controller. Fallback to (%d, %d)\n",
> +                       chip->ecc_step_ds, chip->ecc_strength_ds,
> +                       chip->ecc.size, chip->ecc.strength);


This is annoying.

{ecc_step_ds, ecc_strength_ds} are not provided by Non-ONFi devices.

So,
  ECC (step, strength) = (0, 0) not supported on this controller.

will be always displayed.


The strength will be checked by nand_ecc_strength_good() anyway.






> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(nand_ecc_param_setup);



-- 
Best Regards
Masahiro Yamada
