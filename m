Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F55C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1A120844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbfBENbL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:31:11 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:56073 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfBENbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:31:11 -0500
X-Originating-IP: 90.88.22.177
Received: from xps13 (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 8DD0D1C0016;
        Tue,  5 Feb 2019 13:31:07 +0000 (UTC)
Date:   Tue, 5 Feb 2019 14:31:06 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     wen yang <yellowriver2010@hotmail.com>
Cc:     "xiaolei.li@mediatek.com" <xiaolei.li@mediatek.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: rawnand: mtk: fix object reference leaks in
 mtk_ecc_get
Message-ID: <20190205143106.751554e0@xps13>
In-Reply-To: <HK0PR02MB36345BDC344D1A6FE77B4576B26E0@HK0PR02MB3634.apcprd02.prod.outlook.com>
References: <HK0PR02MB36345BDC344D1A6FE77B4576B26E0@HK0PR02MB3634.apcprd02.prod.outlook.com>
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
10:05:46 +0000:

> of_find_device_by_node() takes a reference to the struct device
> when it finds a match via get_device, there is no need to call
> get_device() twice.
> We also should make sure to drop the reference to the device
> taken by of_find_device_by_node() on driver unbind.
> 
> Fixes: 1d6b1e464950 ("mtd: mediatek: driver for MTK Smart Device")
> Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
> Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
> Cc: Xiaolei Li <xiaolei.li@mediatek.com>
> Cc: Boris Brezillon <bbrezillon@kernel.org>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/mtd/nand/raw/mtk_ecc.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/mtk_ecc.c b/drivers/mtd/nand/raw/mtk_ecc.c
> index 6432bd7..25bdc15 100644
> --- a/drivers/mtd/nand/raw/mtk_ecc.c
> +++ b/drivers/mtd/nand/raw/mtk_ecc.c
> @@ -265,17 +265,25 @@ static struct mtk_ecc *mtk_ecc_get(struct device_node *np)
>  {
>  	struct platform_device *pdev;
>  	struct mtk_ecc *ecc;
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
> -	get_device(&pdev->dev);
>  	ecc = platform_get_drvdata(pdev);
>  	clk_prepare_enable(ecc->clk);
>  	mtk_ecc_hw_init(ecc);
>  
>  	return ecc;
> +
> +err_put_device:
> +	put_device(&pdev->dev);
> +	return ERR_PTR(ret);

Same as before, I don't think a label is useful in this situation.


Thanks,
Miquèl
