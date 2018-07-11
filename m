Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B030FC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A46F20883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A46F20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387752AbeGKNJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:09:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51594 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732411AbeGKNJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:09:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3431120775; Wed, 11 Jul 2018 15:04:50 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id D77AA206F3;
        Wed, 11 Jul 2018 15:04:49 +0200 (CEST)
Date:   Wed, 11 Jul 2018 15:04:49 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Abhishek Sahu <absahu@codeaurora.org>,
        Archit Taneja <architt@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nand: ranw: qcom_nand: stop using phys_to_dma()
Message-ID: <20180711150449.4152333c@bbrezillon>
In-Reply-To: <20180711122709.358159-1-arnd@arndb.de>
References: <20180711122709.358159-1-arnd@arndb.de>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 14:26:58 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> Compile-testing this driver on x86 caused a link error:
> 
> ERROR: "__phys_to_dma" [drivers/mtd/nand/raw/qcom_nandc.ko] undefined!
> 
> The problem here is that the driver attempts to convert the physical
> address into the DMA controller as a dma_addr_t and calls phys_to_dma()
> to do the conversion.
> 
> However, there is no generic way to convert a phys_addr_t into a dma_addr_t
> for anything other than RAM (which should use the dma-mapping API instead).
> The only correct use of phys_to_dma() instead is inside of the dma-mapping
> implementation.

Should we use dma_map_resource() to do the phys_addr_t to dma_addr_t
conversion?

> 
> In all other drivers that deal with DMA FIFO addresses, we just pass the
> physical address directly and have the DMA controller deal with that
> if necessary, so let's do the same thing here.
> 
> Fixes: c76b78d8ec05 ("mtd: nand: Qualcomm NAND controller driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index 994f980c6d86..f047e2819041 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -338,7 +338,6 @@ struct nandc_regs {
>   * @dev:			parent device
>   * @base:			MMIO base
>   * @base_phys:			physical base address of controller registers
> - * @base_dma:			dma base address of controller registers
>   * @core_clk:			controller clock
>   * @aon_clk:			another controller clock
>   *
> @@ -372,7 +371,6 @@ struct qcom_nand_controller {
>  
>  	void __iomem *base;
>  	phys_addr_t base_phys;
> -	dma_addr_t base_dma;
>  
>  	struct clk *core_clk;
>  	struct clk *aon_clk;
> @@ -935,11 +933,11 @@ static int prep_adm_dma_desc(struct qcom_nand_controller *nandc, bool read,
>  	slave_conf.device_fc = flow_control;
>  	if (read) {
>  		slave_conf.src_maxburst = 16;
> -		slave_conf.src_addr = nandc->base_dma + reg_off;
> +		slave_conf.src_addr = (dma_addr_t)nandc->base_phys + reg_off;
>  		slave_conf.slave_id = nandc->data_crci;
>  	} else {
>  		slave_conf.dst_maxburst = 16;
> -		slave_conf.dst_addr = nandc->base_dma + reg_off;
> +		slave_conf.dst_addr = (dma_addr_t)nandc->base_phys + reg_off;
>  		slave_conf.slave_id = nandc->cmd_crci;
>  	}
>  
> @@ -2963,7 +2961,6 @@ static int qcom_nandc_probe(struct platform_device *pdev)
>  		return PTR_ERR(nandc->base);
>  
>  	nandc->base_phys = res->start;
> -	nandc->base_dma = phys_to_dma(dev, (phys_addr_t)res->start);
>  
>  	nandc->core_clk = devm_clk_get(dev, "core");
>  	if (IS_ERR(nandc->core_clk))

