Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76747C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD37208A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD37208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeH1NHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 09:07:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37109 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727091AbeH1NHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 09:07:40 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 177D720789; Tue, 28 Aug 2018 11:16:56 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-53-19.w90-88.abo.wanadoo.fr [90.88.170.19])
        by mail.bootlin.com (Postfix) with ESMTPSA id BA0A720711;
        Tue, 28 Aug 2018 11:16:55 +0200 (CEST)
Date:   Tue, 28 Aug 2018 11:16:54 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: rawnand: Convert to using %pOFn instead of
 device_node.name
Message-ID: <20180828111654.79fe4755@bbrezillon>
In-Reply-To: <20180828015252.28511-33-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
        <20180828015252.28511-33-robh@kernel.org>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2018 20:52:34 -0500
Rob Herring <robh@kernel.org> wrote:

> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Boris Brezillon <boris.brezillon@bootlin.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/nand/raw/fsl_upm.c | 4 ++--
>  drivers/mtd/nand/raw/ndfc.c    | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/fsl_upm.c b/drivers/mtd/nand/raw/fsl_upm.c
> index a88e2cf66e0f..ca82727eca94 100644
> --- a/drivers/mtd/nand/raw/fsl_upm.c
> +++ b/drivers/mtd/nand/raw/fsl_upm.c
> @@ -184,8 +184,8 @@ static int fun_chip_init(struct fsl_upm_nand *fun,
>  		return -ENODEV;
>  
>  	nand_set_flash_node(&fun->chip, flash_np);
> -	mtd->name = kasprintf(GFP_KERNEL, "0x%llx.%s", (u64)io_res->start,
> -			      flash_np->name);
> +	mtd->name = kasprintf(GFP_KERNEL, "0x%llx.%pOFn", (u64)io_res->start,
> +			      flash_np);
>  	if (!mtd->name) {
>  		ret = -ENOMEM;
>  		goto err;
> diff --git a/drivers/mtd/nand/raw/ndfc.c b/drivers/mtd/nand/raw/ndfc.c
> index 540fa1a0ea24..b193f373f235 100644
> --- a/drivers/mtd/nand/raw/ndfc.c
> +++ b/drivers/mtd/nand/raw/ndfc.c
> @@ -174,8 +174,8 @@ static int ndfc_chip_init(struct ndfc_controller *ndfc,
>  		return -ENODEV;
>  	nand_set_flash_node(chip, flash_np);
>  
> -	mtd->name = kasprintf(GFP_KERNEL, "%s.%s", dev_name(&ndfc->ofdev->dev),
> -			      flash_np->name);
> +	mtd->name = kasprintf(GFP_KERNEL, "%s.%pOFn", dev_name(&ndfc->ofdev->dev),
> +			      flash_np);
>  	if (!mtd->name) {
>  		ret = -ENOMEM;
>  		goto err;

