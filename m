Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EF9C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 10:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFD32083B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 10:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549189888;
	bh=OlPivz3jh9XIX9845oGVBQc9wnYVWskV0PrC7azoYAo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=XDz97cQHdKC9sFrQFnLUTKVkAppp+3Zu0nhXfuO7HKktsIolYW3USBtZJTPpF9oiZ
	 WCDbinWTzaAalDqtTuT5TEN72oSmskiMTLg7/Xr5vkNnkReEbS6G3yBO2med4pwxmU
	 ADMU/ToguWi3ex7t1KHHMlCN3rH4uyO15TEKcbeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfBCKZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 05:25:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbfBCKZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 05:25:04 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 987EF20855;
        Sun,  3 Feb 2019 10:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549189503;
        bh=OlPivz3jh9XIX9845oGVBQc9wnYVWskV0PrC7azoYAo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fxfEwvgStMGlo8q/+lMybtJmsyDXcqC4XF5h645rkmOCdUi/PCdGxGcbblKZ4Bpci
         Z/JLcqLc8kf5YCqDad2hYQvwhr3bmZxQXPWc7/i4/Xr60lHSEqdHYSIkt8A1l/57Ln
         e4EVIC99xzkEgvncFLk+plGFhoeCVvUClhVI3VRE=
Date:   Sun, 3 Feb 2019 11:24:52 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     wen yang <yellowriver2010@hotmail.com>
Cc:     "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] mtd: nand: fix object reference leaks in
 atmel_pmecc_get_by_node
Message-ID: <20190203112452.2784ef5b@bbrezillon>
In-Reply-To: <HK0PR02MB363421DE59A282A65E86E589B26C0@HK0PR02MB3634.apcprd02.prod.outlook.com>
References: <HK0PR02MB363421DE59A282A65E86E589B26C0@HK0PR02MB3634.apcprd02.prod.outlook.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Feb 2019 09:37:31 +0000
wen yang <yellowriver2010@hotmail.com> wrote:

> of_find_device_by_node() takes a reference to the struct device
> when it finds a match via get_device, there is no need to call
> get_device() twice.
> We also should make sure to drop the reference to the device
> taken by of_find_device_by_node() on driver unbind.
> 
> Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
> Cc: Boris Brezillon <bbrezillon@kernel.org>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/mtd/nand/raw/atmel/pmecc.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
> index 555a74e..bee6551 100644
> --- a/drivers/mtd/nand/raw/atmel/pmecc.c
> +++ b/drivers/mtd/nand/raw/atmel/pmecc.c
> @@ -878,14 +878,17 @@ static struct atmel_pmecc *atmel_pmecc_get_by_node(struct device *userdev,
>  	struct atmel_pmecc *pmecc, **ptr;
>  
>  	pdev = of_find_device_by_node(np);
> -	if (!pdev || !platform_get_drvdata(pdev))
> +	if (!pdev)
>  		return ERR_PTR(-EPROBE_DEFER);
> +	if (!platform_get_drvdata(pdev)) {
> +		put_device(&pdev->dev);
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}
>  
>  	ptr = devres_alloc(devm_atmel_pmecc_put, sizeof(*ptr), GFP_KERNEL);
>  	if (!ptr)
>  		return ERR_PTR(-ENOMEM);

You forgot to call put_device() here. I'd suggest adding an
err_put_device label which calls put_device() before returning
ERR_PTR(ret).

>  
> -	get_device(&pdev->dev);
>  	pmecc = platform_get_drvdata(pdev);
>  
>  	*ptr = pmecc;

