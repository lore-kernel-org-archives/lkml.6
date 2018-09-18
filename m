Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0943FECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA9C214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA9C214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbeIRTbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:31:46 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43958 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728413AbeIRTbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:31:46 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 060EF20734; Tue, 18 Sep 2018 15:59:00 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id A7262206DE;
        Tue, 18 Sep 2018 15:58:49 +0200 (CEST)
Date:   Tue, 18 Sep 2018 15:58:49 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: atmel: Fix potential NULL pointer
 dereference
Message-ID: <20180918155849.178c5f48@bbrezillon>
In-Reply-To: <20180918135555.GA18114@embeddedor.com>
References: <20180918135555.GA18114@embeddedor.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2018 08:55:55 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> There is a potential execution path in which function
> of_find_compatible_node() returns NULL. In such a case,
> we end up having a NULL pointer dereference when accessing
> pointer *nfc_np* in function of_clk_get().
> 
> So, we better don't take any chances and fix this by null
> checking pointer *nfc_np* before calling of_clk_get().
> 
> Addresses-Coverity-ID: 1473052 ("Dereference null return value")
> Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
> Changes in v2:
>  - Add Fixes tag to the commit log.
>  - Remove blank line before null checking nfc_np.
> 
>  drivers/mtd/nand/raw/atmel/nand-controller.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> index a38633a..5bfbe97 100644
> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> @@ -2034,6 +2034,10 @@ atmel_hsmc_nand_controller_legacy_init(struct atmel_hsmc_nand_controller *nc)
>  	nand_np = dev->of_node;
>  	nfc_np = of_find_compatible_node(dev->of_node, NULL,
>  					 "atmel,sama5d3-nfc");
> +	if (!nfc_np) {
> +		dev_err(dev, "Could not find device node for sama5d3-nfc\n");
> +		return -ENODEV;
> +	}
>  
>  	nc->clk = of_clk_get(nfc_np, 0);
>  	if (IS_ERR(nc->clk)) {

