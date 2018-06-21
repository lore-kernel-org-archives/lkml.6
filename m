Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEBBC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD93208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD93208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754342AbeFULU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 07:20:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50722 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754259AbeFULUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 07:20:55 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 65C0820834; Thu, 21 Jun 2018 13:20:53 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1B76C206D8;
        Thu, 21 Jun 2018 13:20:43 +0200 (CEST)
Date:   Thu, 21 Jun 2018 13:20:43 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     miquel.raynal@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v4 6/6] mtd: rawnand: micron: detect forced on-die ECC
Message-ID: <20180621132043.53b4677a@bbrezillon>
In-Reply-To: <20180621103328.28206-7-chris.packham@alliedtelesis.co.nz>
References: <20180621103328.28206-1-chris.packham@alliedtelesis.co.nz>
        <20180621103328.28206-7-chris.packham@alliedtelesis.co.nz>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018 22:33:28 +1200
Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> Some Micron NAND chips have on-die ECC forceably enabled. The detect
> these based on chip ID as there seems to be no other way of
> distinguishing these chips from those that have optional support for
> on-die ECC.
> 
> When a chip with mandatory on-die ECC is detected change the current ECC
> mode to on-die.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> I'm not convinced that just changing chip->ecc.mode is sensible. An
> alternative I considered was only proceeding if the ecc.mode is set to
> ON_DIE.
> 
> Changes in v4:
> - New
> 
>  drivers/mtd/nand/raw/nand_micron.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
> index f1ecd4986b50..9ba9007a9a06 100644
> --- a/drivers/mtd/nand/raw/nand_micron.c
> +++ b/drivers/mtd/nand/raw/nand_micron.c
> @@ -227,6 +227,14 @@ enum {
>  	MICRON_ON_DIE_MANDATORY,
>  };
>  
> +/*
> + * These parts are known to have on-die ECC forceably enabled
> + */
> +static u8 micron_on_die_ecc[] = {
> +	0xd1, /* MT29F1G08ABAFA */
> +	0xa1, /* MT29F1G08ABBFA */
> +};
> +
>  /*
>   * Try to detect if the NAND support on-die ECC. To do this, we enable
>   * the feature, and read back if it has been enabled as expected. We
> @@ -241,6 +249,11 @@ static int micron_supports_on_die_ecc(struct nand_chip *chip)
>  {
>  	u8 feature[ONFI_SUBFEATURE_PARAM_LEN] = { 0, };
>  	int ret;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(micron_on_die_ecc); i++)
> +		if (chip->id.data[1] == micron_on_die_ecc[i])
> +			return MICRON_ON_DIE_MANDATORY;
>  
>  	if (!chip->parameters.onfi.version)
>  		return MICRON_ON_DIE_UNSUPPORTED;
> @@ -289,8 +302,8 @@ static int micron_nand_init(struct nand_chip *chip)
>  	ondie = micron_supports_on_die_ecc(chip);
>  
>  	if (ondie == MICRON_ON_DIE_MANDATORY) {
> -		pr_err("On-die ECC forcefully enabled, not supported\n");
> -		return -EINVAL;
> +		pr_info("On-die ECC forcefully enabled\n");
> +		chip->ecc.mode = NAND_ECC_ON_DIE;

No, you can't do that, because most NAND drivers simply don't support
NAND_ECC_ON_DIE, and will override chip->ecc.mode without even checking
its value. You should just fail if chip->ecc.mode != NAND_ECC_ON_DIE.

		if (chip->ecc.mode != NAND_ECC_ON_DIE) {
			pr_err("On-die ECC can't be disabled\n");
			return -EINVAL;
		}
>  	}
>  
>  	if (chip->ecc.mode == NAND_ECC_ON_DIE) {

