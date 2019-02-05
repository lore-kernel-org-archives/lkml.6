Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F261C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C17206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbfBENRQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:17:16 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:46385 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfBENRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:17:15 -0500
X-Originating-IP: 90.88.22.177
Received: from xps13 (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 8B836240011;
        Tue,  5 Feb 2019 13:17:10 +0000 (UTC)
Date:   Tue, 5 Feb 2019 14:17:09 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     wen yang <yellowriver2010@hotmail.com>
Cc:     "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: nand: fix object reference leaks in
 atmel_pmecc_get_by_node
Message-ID: <20190205141709.5a8b80d1@xps13>
In-Reply-To: <HK0PR02MB36342EEC848C39F479D0063CB26C0@HK0PR02MB3634.apcprd02.prod.outlook.com>
References: <HK0PR02MB36342EEC848C39F479D0063CB26C0@HK0PR02MB3634.apcprd02.prod.outlook.com>
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

Can you change the commit message:

"mtd: rawnand: atmel: fix possible object reference leak"

wen yang <yellowriver2010@hotmail.com> wrote on Sun, 3 Feb 2019
12:41:44 +0000:

> of_find_device_by_node() takes a reference to the struct device
> when it finds a match via get_device, there is no need to call
> get_device() twice.
> We also should make sure to drop the reference to the device
> taken by of_find_device_by_node() on driver unbind.
> 
> Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
> Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
> Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
> Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

Unless I am missing something, Boris didn't gave his R-b yet.

[...]
 
> diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
> index 555a74e..1477368 100644
> --- a/drivers/mtd/nand/raw/atmel/pmecc.c
> +++ b/drivers/mtd/nand/raw/atmel/pmecc.c
> @@ -876,16 +876,22 @@ static struct atmel_pmecc *atmel_pmecc_get_by_node(struct device *userdev,
>  {
>  	struct platform_device *pdev;
>  	struct atmel_pmecc *pmecc, **ptr;
> +	int ret;
>  
>  	pdev = of_find_device_by_node(np);
> -	if (!pdev || !platform_get_drvdata(pdev))
> +	if (!pdev)
>  		return ERR_PTR(-EPROBE_DEFER);
> +	if (!platform_get_drvdata(pdev)) {
> +		ret = -EPROBE_DEFER;
> +		goto err_put_device;
> +	}
>  
>  	ptr = devres_alloc(devm_atmel_pmecc_put, sizeof(*ptr), GFP_KERNEL);
> -	if (!ptr)
> -		return ERR_PTR(-ENOMEM);
> +	if (!ptr) {
> +		ret = -ENOMEM;
> +		goto err_put_device;
> +	}
>  
> -	get_device(&pdev->dev);
>  	pmecc = platform_get_drvdata(pdev);
>  
>  	*ptr = pmecc;
> @@ -893,6 +899,10 @@ static struct atmel_pmecc *atmel_pmecc_get_by_node(struct device *userdev,
>  	devres_add(userdev, ptr);
>  
>  	return pmecc;
> +
> +err_put_device:
> +	put_device(&pdev->dev);
> +	return ERR_PTR(ret);
>  }
>  
>  static const int atmel_pmecc_strengths[] = { 2, 4, 8, 12, 24, 32 };

With the commit title changed, you can add my

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miquèl
