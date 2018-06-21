Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FFBC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BAAE20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BAAE20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933095AbeFULGI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 07:06:08 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50560 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932844AbeFULGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 07:06:06 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CE52B2073D; Thu, 21 Jun 2018 13:06:04 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 79DC02072B;
        Thu, 21 Jun 2018 13:05:54 +0200 (CEST)
Date:   Thu, 21 Jun 2018 13:05:54 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     miquel.raynal@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v4 3/6] mtd: rawnand: add defines for ONFI version bits
Message-ID: <20180621130554.43900e2f@bbrezillon>
In-Reply-To: <20180621103328.28206-4-chris.packham@alliedtelesis.co.nz>
References: <20180621103328.28206-1-chris.packham@alliedtelesis.co.nz>
        <20180621103328.28206-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018 22:33:25 +1200
Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> Add defines for the ONFI version bits and use them in
> nand_flash_detect_onfi().
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
> Changes in v4:
> - New
> 
>  drivers/mtd/nand/raw/nand_base.c | 10 +++++-----
>  include/linux/mtd/rawnand.h      | 11 +++++++++++
>  2 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 65250308c82d..36048e0cf1f5 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -5178,15 +5178,15 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
>  
>  	/* Check version */
>  	val = le16_to_cpu(p->revision);
> -	if (val & (1 << 5))
> +	if (val & ONFI_VERSION_2_3)
>  		chip->parameters.onfi.version = 23;
> -	else if (val & (1 << 4))
> +	else if (val & ONFI_VERSION_2_2)
>  		chip->parameters.onfi.version = 22;
> -	else if (val & (1 << 3))
> +	else if (val & ONFI_VERSION_2_1)
>  		chip->parameters.onfi.version = 21;
> -	else if (val & (1 << 2))
> +	else if (val & ONFI_VERSION_2_0)
>  		chip->parameters.onfi.version = 20;
> -	else if (val & (1 << 1))
> +	else if (val & ONFI_VERSION_1_0)
>  		chip->parameters.onfi.version = 10;
>  
>  	if (!chip->parameters.onfi.version) {
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index ef7e3b4e91ea..015bc3f2fc13 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -230,6 +230,17 @@ enum nand_ecc_algo {
>  /* Keep gcc happy */
>  struct nand_chip;
>  
> +/* ONFI version bits */
> +#define ONFI_VERSION_1_0		BIT(1)
> +#define ONFI_VERSION_2_0		BIT(2)
> +#define ONFI_VERSION_2_1		BIT(3)
> +#define ONFI_VERSION_2_2		BIT(4)
> +#define ONFI_VERSION_2_3		BIT(5)
> +#define ONFI_VERSION_3_0		BIT(6)
> +#define ONFI_VERSION_3_1		BIT(7)
> +#define ONFI_VERSION_3_2		BIT(8)
> +#define ONFI_VERSION_4_0		BIT(9)
> +
>  /* ONFI features */
>  #define ONFI_FEATURE_16_BIT_BUS		(1 << 0)
>  #define ONFI_FEATURE_EXT_PARAM_PAGE	(1 << 7)

