Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C685CC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8251520864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8251520864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030537AbeFRIjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:39:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53675 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030504AbeFRIjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:39:10 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F332A207A5; Mon, 18 Jun 2018 10:39:08 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-37-30.w90-88.abo.wanadoo.fr [90.88.156.30])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9A13220012;
        Mon, 18 Jun 2018 10:39:08 +0200 (CEST)
Date:   Mon, 18 Jun 2018 10:39:08 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
Message-ID: <20180618103908.17a04679@bbrezillon>
In-Reply-To: <20180329131054.22506-1-peda@axentia.se>
References: <20180329131054.22506-1-peda@axentia.se>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2018 15:10:54 +0200
Peter Rosin <peda@axentia.se> wrote:

> On a sama5d31 with a Full-HD dual LVDS panel (132MHz pixel clock) NAND
> flash accesses have a tendency to cause display disturbances. Add a
> module param to disable DMA from the NAND controller, since that fixes
> the display problem for me.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

Miquel, can you queue this one to nand/next.

> ---
>  drivers/mtd/nand/raw/atmel/nand-controller.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> index b2f00b398490..2ff7a77c7b8e 100644
> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> @@ -129,6 +129,11 @@
>  #define DEFAULT_TIMEOUT_MS			1000
>  #define MIN_DMA_LEN				128
>  
> +static bool atmel_nand_avoid_dma __read_mostly;
> +
> +MODULE_PARM_DESC(avoiddma, "Avoid using DMA");
> +module_param_named(avoiddma, atmel_nand_avoid_dma, bool, 0400);
> +
>  enum atmel_nand_rb_type {
>  	ATMEL_NAND_NO_RB,
>  	ATMEL_NAND_NATIVE_RB,
> @@ -1977,7 +1982,7 @@ static int atmel_nand_controller_init(struct atmel_nand_controller *nc,
>  		return ret;
>  	}
>  
> -	if (nc->caps->has_dma) {
> +	if (nc->caps->has_dma && !atmel_nand_avoid_dma) {
>  		dma_cap_mask_t mask;
>  
>  		dma_cap_zero(mask);

