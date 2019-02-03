Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0168C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 07:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959F22082E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 07:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549179136;
	bh=E1li+sR43opcyj9fXWSnngJTEKssSfRWXqVMq/94hrA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TCiEDOFl+QgvX+13acjt2QG3dNCD09MtyD+1IVspbva/fAXFy+K2hUiyJJo53XYLu
	 UqSp3Zo3Sy71/njNf7m1Asuc2jsp9kV22U3J6UQ1yposSrEdljRnE9iOqUo/y7XHxq
	 DZVy7QBOsenrn1cIU7uYUY629RLZRLDlVXyWbjAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfBCHcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 02:32:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:57824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbfBCHcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 02:32:05 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03C4C2082E;
        Sun,  3 Feb 2019 07:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549179124;
        bh=E1li+sR43opcyj9fXWSnngJTEKssSfRWXqVMq/94hrA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pv0fyfydRWJCTqbCNBXLb5JBvoL9a93TiOt/pVlh+uE+FaWJvV6qLsQMn9y0t0P2T
         kIMDMYJEAsyd0ubChCV34LvyqUR2ZW18LbG6AkPS4B+uUBIR9Gj+73RMhHmugkJspE
         Eybybs0Xzfbe4NHgfZaDHILE8KceCr60A8Y7Ug3k=
Date:   Sun, 3 Feb 2019 08:31:51 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] mtd: rawnand: jz4780: Add support for the JZ4740
Message-ID: <20190203083151.4fc29c5b@bbrezillon>
In-Reply-To: <20190202231926.2444-5-paul@crapouillou.net>
References: <20190202231926.2444-1-paul@crapouillou.net>
        <20190202231926.2444-5-paul@crapouillou.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  2 Feb 2019 20:19:21 -0300
Paul Cercueil <paul@crapouillou.net> wrote:

> Add support for probing the jz4780-nand driver on the JZ4740 SoC from
> Ingenic.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Changes:
> 
> v2: - Add support for the JZ4740 and not the JZ4725B: they behave the
>       same, and JZ4740 is fully upstream while JZ4725B is not. The
>       JZ4725B devicetree will then simply use the "ingenic,jz4740-nand"
>       compatible string.
>     - Fix the number of bytes for the ECC when the ECC strength is 4.
>       This is needed for the JZ4740, which uses Reed-Solomon instead of
>       BCH.
> 
>  drivers/mtd/nand/raw/ingenic/jz4780_nand.c | 48 +++++++++++++++++-----

If we're going to make the driver compatible with jz4740 and jz4725b
maybe we should rename the source files jz47xx_{nand,bch}.{c,h}.

>  1 file changed, 37 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/ingenic/jz4780_nand.c b/drivers/mtd/nand/raw/ingenic/jz4780_nand.c
> index 7f55358b860f..c0855fef7735 100644
> --- a/drivers/mtd/nand/raw/ingenic/jz4780_nand.c
> +++ b/drivers/mtd/nand/raw/ingenic/jz4780_nand.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/of_device.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> @@ -26,13 +27,15 @@
>  
>  #define DRV_NAME	"jz4780-nand"
>  
> -#define OFFSET_DATA	0x00000000
> -#define OFFSET_CMD	0x00400000
> -#define OFFSET_ADDR	0x00800000
> -
>  /* Command delay when there is no R/B pin. */
>  #define RB_DELAY_US	100
>  
> +struct jz_soc_info {
> +	unsigned long data_offset;
> +	unsigned long addr_offset;
> +	unsigned long cmd_offset;
> +};
> +
>  struct jz4780_nand_cs {
>  	unsigned int bank;
>  	void __iomem *base;
> @@ -40,6 +43,7 @@ struct jz4780_nand_cs {
>  
>  struct jz4780_nand_controller {
>  	struct device *dev;
> +	const struct jz_soc_info *soc_info;
>  	struct jz4780_bch *bch;
>  	struct nand_controller controller;
>  	unsigned int num_banks;
> @@ -101,9 +105,9 @@ static void jz4780_nand_cmd_ctrl(struct nand_chip *chip, int cmd,
>  		return;
>  
>  	if (ctrl & NAND_ALE)
> -		writeb(cmd, cs->base + OFFSET_ADDR);
> +		writeb(cmd, cs->base + nfc->soc_info->addr_offset);
>  	else if (ctrl & NAND_CLE)
> -		writeb(cmd, cs->base + OFFSET_CMD);
> +		writeb(cmd, cs->base + nfc->soc_info->cmd_offset);
>  }
>  
>  static int jz4780_nand_dev_ready(struct nand_chip *chip)
> @@ -161,8 +165,13 @@ static int jz4780_nand_attach_chip(struct nand_chip *chip)
>  	struct jz4780_nand_controller *nfc = to_jz4780_nand_controller(chip->controller);
>  	int eccbytes;
>  
> -	chip->ecc.bytes = fls((1 + 8) * chip->ecc.size)	*
> -				(chip->ecc.strength / 8);
> +	if (chip->ecc.strength == 4) {
> +		/* JZ4740 uses 9 bytes of ECC to correct maximum 4 errors */
> +		chip->ecc.bytes = 9;
> +	} else {
> +		chip->ecc.bytes = fls((1 + 8) * chip->ecc.size)	*
> +				  (chip->ecc.strength / 8);
> +	}
>  
>  	switch (chip->ecc.mode) {
>  	case NAND_ECC_HW:
> @@ -272,8 +281,8 @@ static int jz4780_nand_init_chip(struct platform_device *pdev,
>  		return -ENOMEM;
>  	mtd->dev.parent = dev;
>  
> -	chip->legacy.IO_ADDR_R = cs->base + OFFSET_DATA;
> -	chip->legacy.IO_ADDR_W = cs->base + OFFSET_DATA;
> +	chip->legacy.IO_ADDR_R = cs->base + nfc->soc_info->data_offset;
> +	chip->legacy.IO_ADDR_W = cs->base + nfc->soc_info->data_offset;
>  	chip->legacy.chip_delay = RB_DELAY_US;
>  	chip->options = NAND_NO_SUBPAGE_WRITE;
>  	chip->legacy.select_chip = jz4780_nand_select_chip;
> @@ -353,6 +362,10 @@ static int jz4780_nand_probe(struct platform_device *pdev)
>  	if (!nfc)
>  		return -ENOMEM;
>  
> +	nfc->soc_info = device_get_match_data(dev);
> +	if (!nfc->soc_info)
> +		return -EINVAL;
> +
>  	/*
>  	 * Check for BCH HW before we call nand_scan_ident, to prevent us from
>  	 * having to call it again if the BCH driver returns -EPROBE_DEFER.
> @@ -390,8 +403,21 @@ static int jz4780_nand_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct jz_soc_info jz4740_soc_info = {
> +	.data_offset = 0x00000000,
> +	.cmd_offset  = 0x00008000,
> +	.addr_offset = 0x00010000,
> +};
> +
> +static const struct jz_soc_info jz4780_soc_info = {
> +	.data_offset = 0x00000000,
> +	.cmd_offset  = 0x00400000,
> +	.addr_offset = 0x00800000,
> +};
> +
>  static const struct of_device_id jz4780_nand_dt_match[] = {
> -	{ .compatible = "ingenic,jz4780-nand" },
> +	{ .compatible = "ingenic,jz4740-nand", .data = &jz4740_soc_info },
> +	{ .compatible = "ingenic,jz4780-nand",  .data = &jz4780_soc_info  },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, jz4780_nand_dt_match);

