Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936353AbeE0J1P (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 05:27:15 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:22497 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934567AbeE0J1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 05:27:13 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w4R9Qx6Q001953
X-Nifty-SrcIP: [209.85.213.50]
X-Google-Smtp-Source: ADUXVKJDGEs2c2KOTHLleTObYXuP85OSCDF219uJEKoKU0/nZYJmfM4dqKY1wpnzex3PT2Qx1oeADGbi3yP4Z6qNcBs=
MIME-Version: 1.0
In-Reply-To: <1527250904-21988-3-git-send-email-absahu@codeaurora.org>
References: <1527250904-21988-1-git-send-email-absahu@codeaurora.org> <1527250904-21988-3-git-send-email-absahu@codeaurora.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 27 May 2018 18:26:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNASbSSM9EpJkYvz65hGUzmdUF9m7PjLg=Xw-Wn+CB1RkTA@mail.gmail.com>
Message-ID: <CAK7LNASbSSM9EpJkYvz65hGUzmdUF9m7PjLg=Xw-Wn+CB1RkTA@mail.gmail.com>
Subject: Re: [PATCH v3 02/16] mtd: rawnand: denali: use helper function for
 ecc setup
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        Archit Taneja <architt@codeaurora.org>,
        Richard Weinberger <richard@nod.at>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Andy Gross <andy.gross@linaro.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-25 21:21 GMT+09:00 Abhishek Sahu <absahu@codeaurora.org>:
> Use the NAND core helper function nand_ecc_choose_conf to tune
> the ECC parameters instead of the function locally defined.
>
> CC: Masahiro Yamada <yamada.masahiro@socionext.com>

You can replace the CC with my

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>



> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
> * Changes from v2:
>
>   1. Changed commit message
>
> * Changes from v1:
>   NEW PATCH
>
>  drivers/mtd/nand/raw/denali.c | 30 ++----------------------------
>  1 file changed, 2 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
> index 2a302a1..a586a1d 100644
> --- a/drivers/mtd/nand/raw/denali.c
> +++ b/drivers/mtd/nand/raw/denali.c
> @@ -1120,33 +1120,6 @@ int denali_calc_ecc_bytes(int step_size, int strength)
>  }
>  EXPORT_SYMBOL(denali_calc_ecc_bytes);
>
> -static int denali_ecc_setup(struct mtd_info *mtd, struct nand_chip *chip,
> -                           struct denali_nand_info *denali)
> -{
> -       int oobavail = mtd->oobsize - denali->oob_skip_bytes;
> -       int ret;
> -
> -       /*
> -        * If .size and .strength are already set (usually by DT),
> -        * check if they are supported by this controller.
> -        */
> -       if (chip->ecc.size && chip->ecc.strength)
> -               return nand_check_ecc_caps(chip, denali->ecc_caps, oobavail);
> -
> -       /*
> -        * We want .size and .strength closest to the chip's requirement
> -        * unless NAND_ECC_MAXIMIZE is requested.
> -        */
> -       if (!(chip->ecc.options & NAND_ECC_MAXIMIZE)) {
> -               ret = nand_match_ecc_req(chip, denali->ecc_caps, oobavail);
> -               if (!ret)
> -                       return 0;
> -       }
> -
> -       /* Max ECC strength is the last thing we can do */
> -       return nand_maximize_ecc(chip, denali->ecc_caps, oobavail);
> -}
> -
>  static int denali_ooblayout_ecc(struct mtd_info *mtd, int section,
>                                 struct mtd_oob_region *oobregion)
>  {
> @@ -1317,7 +1290,8 @@ int denali_init(struct denali_nand_info *denali)
>         chip->ecc.mode = NAND_ECC_HW_SYNDROME;
>         chip->options |= NAND_NO_SUBPAGE_WRITE;
>
> -       ret = denali_ecc_setup(mtd, chip, denali);
> +       ret = nand_ecc_choose_conf(chip, denali->ecc_caps,
> +                                  mtd->oobsize - denali->oob_skip_bytes);
>         if (ret) {
>                 dev_err(denali->dev, "Failed to setup ECC settings.\n");
>                 goto disable_irq;
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
> is a member of Code Aurora Forum, hosted by The Linux Foundation
>
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/



-- 
Best Regards
Masahiro Yamada
