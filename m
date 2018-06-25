Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49112C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 02:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E45253CF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 02:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="dnl4pJA2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E45253CF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeFYCYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 22:24:41 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:25687 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752463AbeFYCYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 22:24:40 -0400
Received: from mail-ua0-f181.google.com (mail-ua0-f181.google.com [209.85.217.181]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w5P2OTU4007425;
        Mon, 25 Jun 2018 11:24:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w5P2OTU4007425
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529893470;
        bh=t2Y74zEX3dLuJH/g7aqTd97EUrNN2fFqQlDw5QLQtqs=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=dnl4pJA2OolU+7q+XtnOBsKetEkTv2PPQZ+CyB4caqV9fAOjLXEPIIMR8TUcfJXuk
         W64glB6EtikZQKR7mGKyMgzeRua0wAtaO9Izm+eGkVQ7xPAnVYpeiPYzq2uNytnktx
         L3PW8FBjssxhdIypZ5XXG8X3PDfHIwtcqLt0t3c1sQnQxkqJvmP2cv3q0wKR2MVbaN
         lCezqprwwiW/CaUCcr8IOqfpcZ8LUIGMHdq8fc448vLMoEdFvzQDkWmo1qAbzt7b5U
         9OBU3nRxvxyUOXZdUBlyzBHP7jyg/zEbnBCJ1BW4eKdrJCNh1tqgaF7e2r0pe2bXlv
         ShD1pPeHxNtvQ==
X-Nifty-SrcIP: [209.85.217.181]
Received: by mail-ua0-f181.google.com with SMTP id z16-v6so7635838uaz.10;
        Sun, 24 Jun 2018 19:24:29 -0700 (PDT)
X-Gm-Message-State: APt69E3IfqU2zVHVLUsiGNMp/mNQGNsIPqvHsxNqGsqFbXWZUKHAjMOh
        n93E8tTAQRUeEum/SfDEESrdxMj57ngIDMtnIvQ=
X-Google-Smtp-Source: ADUXVKKfNdFOn9aSTU1dQOZqHjCrji0E8gkB3WhYxUZRQ7r+WNTHEsdnHfGuk7yJL2CnagJa3s4/s86ppuXGa9I/eYA=
X-Received: by 2002:a9f:3d6b:: with SMTP id m43-v6mr6799654uai.17.1529893468530;
 Sun, 24 Jun 2018 19:24:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Sun, 24 Jun 2018 19:23:48
 -0700 (PDT)
In-Reply-To: <1529479662-4026-2-git-send-email-absahu@codeaurora.org>
References: <1529479662-4026-1-git-send-email-absahu@codeaurora.org> <1529479662-4026-2-git-send-email-absahu@codeaurora.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 25 Jun 2018 11:23:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQirQO7MCsVa-MeSCj2J2_jW_2fV5HUAhss9pWHHAPNVg@mail.gmail.com>
Message-ID: <CAK7LNAQirQO7MCsVa-MeSCj2J2_jW_2fV5HUAhss9pWHHAPNVg@mail.gmail.com>
Subject: Re: [PATCH v4 01/15] mtd: rawnand: helper function for setting up ECC configuration
To:     Abhishek Sahu <absahu@codeaurora.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Andy Gross <andy.gross@linaro.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-20 16:27 GMT+09:00 Abhishek Sahu <absahu@codeaurora.org>:
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
>    available OOB size.
>
> This patch introduces nand_ecc_choose_conf function which calls the
> required helper functions for the above logic. The drivers can use
> this single function instead of calling the 3 helper functions
> individually.
>
> CC: Masahiro Yamada <yamada.masahiro@socionext.com>

You can replace the CC with my

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks.


> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
> * Changes from v3:
>   1. call nand_maximize_ecc() 2 times to make code more clear.
>
> * Changes from v2:
>
>   1. Renamed function to nand_ecc_choose_conf.
>   2. Minor code reorganization to remove warning and 2 function calls
>      for nand_maximize_ecc.
>
> * Changes from v1:
>   NEW PATCH
>
>  drivers/mtd/nand/raw/nand_base.c | 33 +++++++++++++++++++++++++++++++++
>  include/linux/mtd/rawnand.h      |  3 +++
>  2 files changed, 36 insertions(+)
>
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 10c4f991..c64e3fc 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -6287,6 +6287,39 @@ int nand_maximize_ecc(struct nand_chip *chip,
>  }
>  EXPORT_SYMBOL_GPL(nand_maximize_ecc);
>
> +/**
> + * nand_ecc_choose_conf - Set the ECC strength and ECC step size
> + * @chip: nand chip info structure
> + * @caps: ECC engine caps info structure
> + * @oobavail: OOB size that the ECC engine can use
> + *
> + * Choose the ECC configuration according to following logic
> + *
> + * 1. If both ECC step size and ECC strength are already set (usually by DT)
> + *    then check if it is supported by this controller.
> + * 2. If NAND_ECC_MAXIMIZE is set, then select maximum ECC strength.
> + * 3. Otherwise, try to match the ECC step size and ECC strength closest
> + *    to the chip's requirement. If available OOB size can't fit the chip
> + *    requirement then fallback to the maximum ECC step size and ECC strength.
> + *
> + * On success, the chosen ECC settings are set.
> + */
> +int nand_ecc_choose_conf(struct nand_chip *chip,
> +                        const struct nand_ecc_caps *caps, int oobavail)
> +{
> +       if (chip->ecc.size && chip->ecc.strength)
> +               return nand_check_ecc_caps(chip, caps, oobavail);
> +
> +       if (chip->ecc.options & NAND_ECC_MAXIMIZE)
> +               return nand_maximize_ecc(chip, caps, oobavail);
> +
> +       if (!nand_match_ecc_req(chip, caps, oobavail))
> +               return 0;
> +
> +       return nand_maximize_ecc(chip, caps, oobavail);
> +}
> +EXPORT_SYMBOL_GPL(nand_ecc_choose_conf);
> +
>  /*
>   * Check if the chip configuration meet the datasheet requirements.
>
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index 3e8ec3b..03a0061 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -1650,6 +1650,9 @@ int nand_match_ecc_req(struct nand_chip *chip,
>  int nand_maximize_ecc(struct nand_chip *chip,
>                       const struct nand_ecc_caps *caps, int oobavail);
>
> +int nand_ecc_choose_conf(struct nand_chip *chip,
> +                        const struct nand_ecc_caps *caps, int oobavail);
> +
>  /* Default write_oob implementation */
>  int nand_write_oob_std(struct mtd_info *mtd, struct nand_chip *chip, int page);
>
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
