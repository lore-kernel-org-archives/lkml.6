Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815E3C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E022408F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E022408F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934352AbeGDInf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:43:35 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:9523 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932548AbeGDIma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:42:30 -0400
X-IronPort-AV: E=Sophos;i="5.51,306,1526367600"; 
   d="scan'208";a="15957126"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 Jul 2018 01:42:29 -0700
Received: from localhost.localdomain (10.10.76.4) by
 chn-sv-exch06.mchp-main.com (10.10.76.107) with Microsoft SMTP Server id
 14.3.352.0; Wed, 4 Jul 2018 01:42:28 -0700
Subject: Re: [PATCH v2] mtd: atmel-quadspi: add suspend/resume hooks
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>,
        <richard@nod.at>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1528101993-4772-1-git-send-email-claudiu.beznea@microchip.com>
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
Message-ID: <d2264ba9-78db-a3e8-fe4d-5c04f241468c@microchip.com>
Date:   Wed, 4 Jul 2018 11:42:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1528101993-4772-1-git-send-email-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Claudiu,

On 06/04/2018 11:46 AM, Claudiu Beznea wrote:
> Implement suspend/resume hooks.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
> 
> Changes in v2:
> - use __maybe_unused instead of #ifdef CONFIG_PM_SLEEP
> 
>  drivers/mtd/spi-nor/atmel-quadspi.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/atmel-quadspi.c b/drivers/mtd/spi-nor/atmel-quadspi.c
> index 6c5708bacad8..ceaaef47f02e 100644
> --- a/drivers/mtd/spi-nor/atmel-quadspi.c
> +++ b/drivers/mtd/spi-nor/atmel-quadspi.c
> @@ -737,6 +737,26 @@ static int atmel_qspi_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int __maybe_unused atmel_qspi_suspend(struct device *dev)
> +{
> +	struct atmel_qspi *aq = dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(aq->clk);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused atmel_qspi_resume(struct device *dev)
> +{
> +	struct atmel_qspi *aq = dev_get_drvdata(dev);
> +
> +	clk_prepare_enable(aq->clk);

You missed to verify the return value of clk_prepare_enable. Otherwise looks
good. I've also looked over the test with suspending while copying on a ubifs
mounted on QSPI NOR, looks good too.

After checking the return value, please add:
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Best,
ta

> +
> +	return atmel_qspi_init(aq);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(atmel_qspi_pm_ops, atmel_qspi_suspend,
> +			 atmel_qspi_resume);
>  
>  static const struct of_device_id atmel_qspi_dt_ids[] = {
>  	{ .compatible = "atmel,sama5d2-qspi" },
> @@ -749,6 +769,7 @@ static struct platform_driver atmel_qspi_driver = {
>  	.driver = {
>  		.name	= "atmel_qspi",
>  		.of_match_table	= atmel_qspi_dt_ids,
> +		.pm	= &atmel_qspi_pm_ops,
>  	},
>  	.probe		= atmel_qspi_probe,
>  	.remove		= atmel_qspi_remove,
> 
