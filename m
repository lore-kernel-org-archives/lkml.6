Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA389C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57CC21902
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfBGMx7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:53:59 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:35019 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfBGMx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:53:58 -0500
Received: from xps13 (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id D404020000E;
        Thu,  7 Feb 2019 12:53:55 +0000 (UTC)
Date:   Thu, 7 Feb 2019 13:53:55 +0100
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
Subject: Re: [PATCH v4 3/3] mtd: rawnand: mtk: fix possible object reference
 leak
Message-ID: <20190207135355.19fa523f@xps13>
In-Reply-To: <HK0PR02MB36348C5317C4DDC7C3262FF5B2680@HK0PR02MB3634.apcprd02.prod.outlook.com>
References: <1549540786-12196-1-git-send-email-yellowriver2010@hotmail.com>
        <HK0PR02MB36348C5317C4DDC7C3262FF5B2680@HK0PR02MB3634.apcprd02.prod.outlook.com>
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
12:02:52 +0000:

> of_find_device_by_node() takes a reference to the struct device
> when it finds a match via get_device, there is no need to call
> get_device() twice.
> We also should make sure to drop the reference to the device
> taken by of_find_device_by_node() on driver unbind.
> 
> Fixes: 1d6b1e464950 ("mtd: mediatek: driver for MTK Smart Device")
> Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
> ---
> v4->v3: Add people in Cc and remove all lines.
> v3->v2: Avoid two times of calling grtform_get_drvdata()
> v2->v1: Since there is the only one user, let's remove the err_put_device label.
> 
>  drivers/mtd/nand/raw/mtk_ecc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/mtk_ecc.c b/drivers/mtd/nand/raw/mtk_ecc.c
> index 6432bd7..db804fe 100644
> --- a/drivers/mtd/nand/raw/mtk_ecc.c
> +++ b/drivers/mtd/nand/raw/mtk_ecc.c
> @@ -267,11 +267,14 @@ static struct mtk_ecc *mtk_ecc_get(struct device_node *np)
>  	struct mtk_ecc *ecc;
>  
>  	pdev = of_find_device_by_node(np);
> -	if (!pdev || !platform_get_drvdata(pdev))
> +	if (!pdev)
>  		return ERR_PTR(-EPROBE_DEFER);
> -

Please keep this blank line.

> -	get_device(&pdev->dev);
>  	ecc = platform_get_drvdata(pdev);
> +	if (!ecc) {
> +		put_device(&pdev->dev);
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
>  	clk_prepare_enable(ecc->clk);
>  	mtk_ecc_hw_init(ecc);
>  


Thanks,
Miquèl
