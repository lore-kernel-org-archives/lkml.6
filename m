Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AE6C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C0523EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C0523EA1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbeFVIhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:37:19 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45879 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751187AbeFVIhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:37:17 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4CA9420799; Fri, 22 Jun 2018 10:37:15 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 023CE203EC;
        Fri, 22 Jun 2018 10:37:14 +0200 (CEST)
Date:   Fri, 22 Jun 2018 10:37:15 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     miquel.raynal@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v5 6/6] mtd: rawnand: micron: detect forced on-die ECC
Message-ID: <20180622103715.0ec496d9@bbrezillon>
In-Reply-To: <20180622012835.17874-7-chris.packham@alliedtelesis.co.nz>
References: <20180622012835.17874-1-chris.packham@alliedtelesis.co.nz>
        <20180622012835.17874-7-chris.packham@alliedtelesis.co.nz>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018 13:28:35 +1200
Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> Some Micron NAND chips have on-die ECC forceably enabled. The detect

							    ^ Detect ?

> these based on chip ID as there seems to be no other way of
> distinguishing these chips from those that have optional support for
> on-die ECC.
> 
> When a chip with mandatory on-die ECC is detected change the current ECC
> mode to on-die.

That part is no longer true.

> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

With the commit message fixed:

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
> 
> Notes:
>     Changes in v4:
>     - New
>     Changes in v5:
>     - fail if on-die ECC is mandatory and the current ecc.mode is not
>       NAND_ECC_ON_DIE.
> 
>  drivers/mtd/nand/raw/nand_micron.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
> index f83053562925..35fa6880a799 100644
> --- a/drivers/mtd/nand/raw/nand_micron.c
> +++ b/drivers/mtd/nand/raw/nand_micron.c
> @@ -255,6 +255,14 @@ enum {
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
> @@ -269,6 +277,11 @@ static int micron_supports_on_die_ecc(struct nand_chip *chip)
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
> @@ -322,7 +335,8 @@ static int micron_nand_init(struct nand_chip *chip)
>  
>  	ondie = micron_supports_on_die_ecc(chip);
>  
> -	if (ondie == MICRON_ON_DIE_MANDATORY) {
> +	if (ondie == MICRON_ON_DIE_MANDATORY &&
> +	    chip->ecc.mode != NAND_ECC_ON_DIE) {
>  		pr_err("On-die ECC forcefully enabled, not supported\n");
>  		return -EINVAL;
>  	}

