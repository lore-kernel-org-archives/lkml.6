Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87E9C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00CC25370
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="kHT70/2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00CC25370
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbeGBMs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:48:57 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:59320 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751535AbeGBMsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:48:55 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 091385C0228;
        Mon,  2 Jul 2018 14:48:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1530535734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZZuGIuVlk2QgIP99thcp8rZkkz6c+/0sb5071mEUneg=;
        b=kHT70/2e4fT/DnZEX4WZRxsWKkMA5gqENrAo++rwCAh22Vj2BcKwzHSZHnRDA7AqNjmLeP
        3pJ5w5th+C0dAMKKY7yX2HAkT2VzzcWvBlkIK5LLpKuMQ/g3ftrc3g41LTNC8HU7dOaQIp
        pE5RbJh3wbJ0blj5ndOh+uIZ3X13vXA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Mon, 02 Jul 2018 14:48:52 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] spi: spi-fsl-dspi: Fix imprecise abort on VF500 during
 probe
In-Reply-To: <1530271989-9022-1-git-send-email-krzk@kernel.org>
References: <1530271989-9022-1-git-send-email-krzk@kernel.org>
Message-ID: <5e8df85076b005de1214ecb5e5de4927@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.09 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_FIVE(0.00)[6];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-2.99)[99.97%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.06.2018 13:33, Krzysztof Kozlowski wrote:
> Registers of DSPI should not be accessed before enabling its clock.  On
> Toradex Colibri VF50 on Iris carrier board this could be seen during
> bootup as imprecise abort:
> 
>     Unhandled fault: imprecise external abort (0x1c06) at 0x00000000
>     Internal error: : 1c06 [#1] ARM
>     Modules linked in:
>     CPU: 0 PID: 1 Comm: swapper Not tainted 4.14.39-dirty #97
>     Hardware name: Freescale Vybrid VF5xx/VF6xx (Device Tree)
>     Backtrace:
>     [<804166a8>] (regmap_write) from [<80466b5c>] (dspi_probe+0x1f0/0x8dc)
>     [<8046696c>] (dspi_probe) from [<8040107c>] (platform_drv_probe+0x54/0xb8)
>     [<80401028>] (platform_drv_probe) from [<803ff53c>]
> (driver_probe_device+0x280/0x2f8)
>     [<803ff2bc>] (driver_probe_device) from [<803ff674>]
> (__driver_attach+0xc0/0xc4)
>     [<803ff5b4>] (__driver_attach) from [<803fd818>]
> (bus_for_each_dev+0x70/0xa4)
>     [<803fd7a8>] (bus_for_each_dev) from [<803fee74>] (driver_attach+0x24/0x28)
>     [<803fee50>] (driver_attach) from [<803fe980>] (bus_add_driver+0x1a0/0x218)
>     [<803fe7e0>] (bus_add_driver) from [<803fffe8>] (driver_register+0x80/0x100)
>     [<803fff68>] (driver_register) from [<80400fdc>]
> (__platform_driver_register+0x48/0x50)
>     [<80400f94>] (__platform_driver_register) from [<8091cf7c>]
> (fsl_dspi_driver_init+0x1c/0x20)
>     [<8091cf60>] (fsl_dspi_driver_init) from [<8010195c>]
> (do_one_initcall+0x4c/0x174)
>     [<80101910>] (do_one_initcall) from [<80900e8c>]
> (kernel_init_freeable+0x144/0x1d8)
>     [<80900d48>] (kernel_init_freeable) from [<805ff6a8>]
> (kernel_init+0x10/0x114)
>     [<805ff698>] (kernel_init) from [<80107be8>] (ret_from_fork+0x14/0x2c)
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 5ee67b587a2b ("spi: dspi: clear SPI_SR before enable interrupt")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Stefan Agner <stefan@agner.ch>

Up until commit d2233325e5b7 ("spi: spi-fsl-dspi: remove clk reference
when regmap_mmio initialize") regmap with clocks has been used. I guess
an alternative would have been to use this again, but I guess this has
been dropped for good reasons.

--
Stefan


> ---
>  drivers/spi/spi-fsl-dspi.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index ff7456be9d6d..89a1e7a4fe5d 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -1071,30 +1071,30 @@ static int dspi_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	dspi->clk = devm_clk_get(&pdev->dev, "dspi");
> +	if (IS_ERR(dspi->clk)) {
> +		ret = PTR_ERR(dspi->clk);
> +		dev_err(&pdev->dev, "unable to get clock\n");
> +		goto out_master_put;
> +	}
> +	ret = clk_prepare_enable(dspi->clk);
> +	if (ret)
> +		goto out_master_put;
> +
>  	dspi_init(dspi);
>  	dspi->irq = platform_get_irq(pdev, 0);
>  	if (dspi->irq < 0) {
>  		dev_err(&pdev->dev, "can't get platform irq\n");
>  		ret = dspi->irq;
> -		goto out_master_put;
> +		goto out_clk_put;
>  	}
>  
>  	ret = devm_request_irq(&pdev->dev, dspi->irq, dspi_interrupt, 0,
>  			pdev->name, dspi);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "Unable to attach DSPI interrupt\n");
> -		goto out_master_put;
> -	}
> -
> -	dspi->clk = devm_clk_get(&pdev->dev, "dspi");
> -	if (IS_ERR(dspi->clk)) {
> -		ret = PTR_ERR(dspi->clk);
> -		dev_err(&pdev->dev, "unable to get clock\n");
> -		goto out_master_put;
> +		goto out_clk_put;
>  	}
> -	ret = clk_prepare_enable(dspi->clk);
> -	if (ret)
> -		goto out_master_put;
>  
>  	if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
>  		ret = dspi_request_dma(dspi, res->start);
