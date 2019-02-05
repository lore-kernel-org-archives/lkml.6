Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA737C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A393A217FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549383708;
	bh=Av3aH/8ZR4Ux6m6lYUfKR7n3sD1IG70okAvKsiDB3Ew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QvzxA4HiZGlvGZ5r+4LgVnt6yDPlCaub/x1E1x0glcpnt1beF/qleQ1wHFeD+iP7V
	 oXoM/RYmichGUk8UvFKFLlsscIT7Aa834wFVXVtexF0tK+3L7aBSNgk+RE838fyT++
	 u3u83vFFprSkPwiEOCQ/fU5XouXsivl1UePlF8TI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbfBEQVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:21:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:34778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbfBEQVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:21:46 -0500
Received: from localhost (unknown [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE2D220844;
        Tue,  5 Feb 2019 16:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549383705;
        bh=Av3aH/8ZR4Ux6m6lYUfKR7n3sD1IG70okAvKsiDB3Ew=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zwirwUqre7/jkP47KEeyqGsWWzcmys0/xFFT7Ks69UXJLEMAdw0CI7f3mzEYyb5YG
         lsDx5yvyVT9hyuacO6GJBPSVov0hfoKnwpAYXiCYr1AlkMZxKj9QLFJYk335F7nnOR
         oJ3w9LwmyiNsg1WjqPHj4baf4YIHwqETDFkfHt0c=
Date:   Tue, 5 Feb 2019 17:21:23 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Wen Yang <yellowriver2010@hotmail.com>,
        "harveyhuntnexus@gmail.com" <harveyhuntnexus@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: rawnand: jz4780: fix possible object reference
 leak
Message-ID: <20190205172123.13ed9469@kernel.org>
In-Reply-To: <20190205165502.2b8be890@xps13>
References: <HK0PR02MB3634AB4C3584FD37B3335075B26E0@HK0PR02MB3634.apcprd02.prod.outlook.com>
        <20190205165502.2b8be890@xps13>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Feb 2019 16:55:02 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Wen,
> 
> Wen Yang <yellowriver2010@hotmail.com> wrote on Tue, 5 Feb 2019
> 15:07:21 +0000:
> 
> > of_find_device_by_node() takes a reference to the struct device
> > when it finds a match via get_device, there is no need to call
> > get_device() twice.
> > We also should make sure to drop the reference to the device
> > taken by of_find_device_by_node() on driver unbind.
> > 
> > Fixes: ae02ab00aa3c ("mtd: nand: jz4780: driver for NAND devices on
> > JZ4780 SoCs") Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
> > Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > Cc: Harvey Hunt <harveyhuntnexus@gmail.com>
> > Cc: Boris Brezillon <bbrezillon@kernel.org>
> > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > Cc: Richard Weinberger <richard@nod.at>
> > Cc: David Woodhouse <dwmw2@infradead.org>
> > Cc: Brian Norris <computersforpeace@gmail.com>
> > Cc: Marek Vasut <marek.vasut@gmail.com>
> > Cc: linux-mtd@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> > v2->v1: Since there is the only one user, let's remove the
> > err_put_device label.
> > 
> >  drivers/mtd/nand/raw/jz4780_bch.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/jz4780_bch.c
> > b/drivers/mtd/nand/raw/jz4780_bch.c index 7201827..363465c 100644
> > --- a/drivers/mtd/nand/raw/jz4780_bch.c
> > +++ b/drivers/mtd/nand/raw/jz4780_bch.c
> > @@ -281,10 +281,12 @@ static struct jz4780_bch
> > *jz4780_bch_get(struct device_node *np) struct jz4780_bch *bch;
> >  
> >  	pdev = of_find_device_by_node(np);
> > -	if (!pdev || !platform_get_drvdata(pdev))
> > +	if (!pdev)
> >  		return ERR_PTR(-EPROBE_DEFER);
> > -
> > -	get_device(&pdev->dev);
> > +	if (!platform_get_drvdata(pdev)) {
> > +		put_device(&pdev->dev);
> > +		return ERR_PTR(-EPROBE_DEFER);
> > +	}
> >  
> >  	bch = platform_get_drvdata(pdev);
> >  	clk_prepare_enable(bch->clk);  
> 
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Don't plan to take that one (or any other ref leak fix) in the mtd/fixes
branch, feel free to queue it to nand/next.
