Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C016C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83FA2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfBGWVU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:21:20 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:58597 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfBGWVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:21:19 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 1B7DD1BF206;
        Thu,  7 Feb 2019 22:21:14 +0000 (UTC)
Date:   Thu, 7 Feb 2019 23:21:13 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Wen Yang <yellowriver2010@hotmail.com>
Cc:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
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
Subject: Re: [PATCH v5 1/3] mtd: rawnand: atmel: fix possible object
 reference leak
Message-ID: <20190207232113.5dc026af@xps13>
In-Reply-To: <HK0PR02MB3634B38A3D04DCFFC09BDCB0B2680@HK0PR02MB3634.apcprd02.prod.outlook.com>
References: <HK0PR02MB3634B38A3D04DCFFC09BDCB0B2680@HK0PR02MB3634.apcprd02.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wen,

Wen Yang <yellowriver2010@hotmail.com> wrote on Thu, 7 Feb 2019
11:56:48 +0000:

> of_find_device_by_node() takes a reference to the struct device
> when it finds a match via get_device, there is no need to call
> get_device() twice.
> We also should make sure to drop the reference to the device
> taken by of_find_device_by_node() on driver unbind.
> 
> Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
> Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
> ---
> v5->v4: Add new line, add people in Cc and remove all Cc lines.
> v4->v3: Avoid two times of calling grtform_get_drvdata()
> v3->v2: Change the commit message.
> v2->v1: Add missing Fixes tag.
> 
>  drivers/mtd/nand/raw/atmel/pmecc.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
> index 555a74e..97e47ea 100644
> --- a/drivers/mtd/nand/raw/atmel/pmecc.c
> +++ b/drivers/mtd/nand/raw/atmel/pmecc.c
> @@ -876,23 +876,33 @@ static struct atmel_pmecc *atmel_pmecc_get_by_node(struct device *userdev,
>  {
>  	struct platform_device *pdev;
>  	struct atmel_pmecc *pmecc, **ptr;
> +	int ret;
>  
>  	pdev = of_find_device_by_node(np);
> -	if (!pdev || !platform_get_drvdata(pdev))
> +	if (!pdev)
>  		return ERR_PTR(-EPROBE_DEFER);
>  
> -	ptr = devres_alloc(devm_atmel_pmecc_put, sizeof(*ptr), GFP_KERNEL);
> -	if (!ptr)
> -		return ERR_PTR(-ENOMEM);
> -
> -	get_device(&pdev->dev);
>  	pmecc = platform_get_drvdata(pdev);
> +	if (!pmecc) {
> +		ret = -EPROBE_DEFER;
> +		goto err_put_device;
> +	}
> +
> +	ptr = devres_alloc(devm_atmel_pmecc_put, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr) {
> +		ret = -ENOMEM;
> +		goto err_put_device;
> +	}
>  
>  	*ptr = pmecc;
>  
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

Series applied to nand/next.


Thanks,
Miquèl
