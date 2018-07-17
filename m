Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07AAECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14FE206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14FE206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbeGQVFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:05:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55788 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729657AbeGQVFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:05:51 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E4B05207AB; Tue, 17 Jul 2018 22:31:29 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7401A206F6;
        Tue, 17 Jul 2018 22:31:29 +0200 (CEST)
Date:   Tue, 17 Jul 2018 22:31:29 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH RESEND v3] mtd: rawnand: ams-delta: use GPIO lookup
 table
Message-ID: <20180717223129.5e999c50@bbrezillon>
In-Reply-To: <20180717170552.17735-1-jmkrzyszt@gmail.com>
References: <20180709193850.20191-1-jmkrzyszt@gmail.com>
        <20180717170552.17735-1-jmkrzyszt@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Tony

On Tue, 17 Jul 2018 19:05:52 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Now as Amstrad Delta board - the only user of this driver - provides
> GPIO lookup tables, switch from GPIO numbers to GPIO descriptors and
> use the table to locate required GPIO pins.
> 
> Declare static variables for storing GPIO descriptors and replace
> gpio_ function calls with their gpiod_ equivalents.
> 
> Pin naming used by the driver should be followed while respective GPIO
> lookup table is initialized by a board init code.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>

Just a minor comment below (nothing important, just a coding style
preference).

Also, if it goes through the omap tree (I guess it will target 4.20),
I'll need an immutable tag, because I have changes touching this driver
in the pipe (that's more a request for Tony).


> @@ -230,9 +205,42 @@ static int ams_delta_init(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, io_base);
>  
>  	/* Set chip enabled, but  */
> -	err = gpio_request_array(_mandatory_gpio, ARRAY_SIZE(_mandatory_gpio));
> -	if (err)
> -		goto out_gpio;
> +	gpiod_nwp = devm_gpiod_get(&pdev->dev, "nwp", GPIOD_OUT_HIGH);
> +	if (IS_ERR(gpiod_nwp)) {
> +		err = PTR_ERR(gpiod_nwp);
> +		dev_err(&pdev->dev, "NWP GPIO request failed (%d)\n", err);
> +		goto out_mtd;
> +	}

Can you add a blank line after each if (IS_ERR(gpiod_nwp)) { } block.

> +	gpiod_nce = devm_gpiod_get(&pdev->dev, "nce", GPIOD_OUT_HIGH);
> +	if (IS_ERR(gpiod_nce)) {
> +		err = PTR_ERR(gpiod_nce);
> +		dev_err(&pdev->dev, "NCE GPIO request failed (%d)\n", err);
> +		goto out_mtd;
> +	}
> +	gpiod_nre = devm_gpiod_get(&pdev->dev, "nre", GPIOD_OUT_HIGH);
> +	if (IS_ERR(gpiod_nre)) {
> +		err = PTR_ERR(gpiod_nre);
> +		dev_err(&pdev->dev, "NRE GPIO request failed (%d)\n", err);
> +		goto out_mtd;
> +	}
> +	gpiod_nwe = devm_gpiod_get(&pdev->dev, "nwe", GPIOD_OUT_HIGH);
> +	if (IS_ERR(gpiod_nwe)) {
> +		err = PTR_ERR(gpiod_nwe);
> +		dev_err(&pdev->dev, "NWE GPIO request failed (%d)\n", err);
> +		goto out_mtd;
> +	}
> +	gpiod_ale = devm_gpiod_get(&pdev->dev, "ale", GPIOD_OUT_LOW);
> +	if (IS_ERR(gpiod_ale)) {
> +		err = PTR_ERR(gpiod_ale);
> +		dev_err(&pdev->dev, "ALE GPIO request failed (%d)\n", err);
> +		goto out_mtd;
> +	}
> +	gpiod_cle = devm_gpiod_get(&pdev->dev, "cle", GPIOD_OUT_LOW);
> +	if (IS_ERR(gpiod_cle)) {
> +		err = PTR_ERR(gpiod_cle);
> +		dev_err(&pdev->dev, "CLE GPIO request failed (%d)\n", err);
> +		goto out_mtd;
> +	}
>  
>  	/* Scan to find existence of the device */
>  	err = nand_scan(ams_delta_mtd, 1);
