Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902EEC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C4220844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfBENa2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:30:28 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:59999 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfBENa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:30:28 -0500
X-Originating-IP: 90.88.22.177
Received: from xps13 (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id D9DE620008;
        Tue,  5 Feb 2019 13:30:23 +0000 (UTC)
Date:   Tue, 5 Feb 2019 14:30:23 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     wen yang <yellowriver2010@hotmail.com>
Cc:     "harveyhuntnexus@gmail.com" <harveyhuntnexus@gmail.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: rawnand: jz4780: fix object reference leaks in
 jz4780_bch_get
Message-ID: <20190205143023.307207b6@xps13>
In-Reply-To: <HK0PR02MB36349BDCE693F67F150B0172B26E0@HK0PR02MB3634.apcprd02.prod.outlook.com>
References: <HK0PR02MB36349BDCE693F67F150B0172B26E0@HK0PR02MB3634.apcprd02.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi wen,

wen yang <yellowriver2010@hotmail.com> wrote on Tue, 5 Feb 2019
09:36:48 +0000:

> of_find_device_by_node() takes a reference to the struct device
> when it finds a match via get_device, there is no need to call
> get_device() twice.
> We also should make sure to drop the reference to the device
> taken by of_find_device_by_node() on driver unbind.
> 
> Fixes: ae02ab00aa3c ("mtd: nand: jz4780: driver for NAND devices on JZ4780 SoCs")
> Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
> Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
> Cc: Harvey Hunt <harveyhuntnexus@gmail.com>
> Cc: Boris Brezillon <bbrezillon@kernel.org>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/mtd/nand/raw/jz4780_bch.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/jz4780_bch.c b/drivers/mtd/nand/raw/jz4780_bch.c
> index 7201827..d0ce5de 100644
> --- a/drivers/mtd/nand/raw/jz4780_bch.c
> +++ b/drivers/mtd/nand/raw/jz4780_bch.c
> @@ -279,17 +279,24 @@ static struct jz4780_bch *jz4780_bch_get(struct device_node *np)
>  {
>  	struct platform_device *pdev;
>  	struct jz4780_bch *bch;
> +	int ret;
>  
>  	pdev = of_find_device_by_node(np);
> -	if (!pdev || !platform_get_drvdata(pdev))
> +	if (!pdev)
>  		return ERR_PTR(-EPROBE_DEFER);
> -
> -	get_device(&pdev->dev);
> +	if (!platform_get_drvdata(pdev)) {
> +		ret = -EPROBE_DEFER;
> +		goto err_put_device;
> +	}
>  
>  	bch = platform_get_drvdata(pdev);
>  	clk_prepare_enable(bch->clk);
>  
>  	return bch;
> +
> +err_put_device:
> +	put_device(&pdev->dev);
> +	return ERR_PTR(ret);

While there is only one user of this label, I think we don't want it.

Thanks,
Miquèl
