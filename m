Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B29C282DB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 10:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7583217D6
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 10:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549189888;
	bh=SjK88TvLdzOJBa9K/8vtx9sSV/IoeN/fyPFyvUXlTU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=0W4lUKYFpzPDcgUZHf/z0kd0tUD0X8wvzEwxpn8mryhMK5hMNsSrJirteYScjfpHZ
	 g15dXayKvAyteBxOAmx6+kBicaj4DoyLiLsQxv9k9NdO0nJ5RA/lJBSo2ZjO/ejBFq
	 NGTZpcYBiKQsO7qOzMv0r4MaFrIqsc8IWYSRhpec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfBCKZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 05:25:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:39960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727586AbfBCKZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 05:25:44 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8258920855;
        Sun,  3 Feb 2019 10:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549189543;
        bh=SjK88TvLdzOJBa9K/8vtx9sSV/IoeN/fyPFyvUXlTU4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k/cVNsSYxiIvsUdzT/F34wCUabYYexl9v6FYmerncKRFQ+OtdjCykp2Z/r3POpKgG
         RmP6ICJynQkvCJe6bu+APAupWXUdznrCMk69BGnpX6H9D8B24vF0zrcwWb3pPPYCD6
         0xghyzeqwmLfF9tdu5tb3xHjf/ly/pylo+SdrcHk=
Date:   Sun, 3 Feb 2019 11:25:31 +0100
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
Message-ID: <20190203112531.080c15a7@bbrezillon>
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

Missing Fixes tag.

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
>  
> -	get_device(&pdev->dev);
>  	pmecc = platform_get_drvdata(pdev);
>  
>  	*ptr = pmecc;

