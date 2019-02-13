Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ADCC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604A32070C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390401AbfBMKyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:54:16 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:36241 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfBMKyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:54:16 -0500
X-Originating-IP: 90.53.137.203
Received: from localhost (alyon-652-1-306-203.w90-53.abo.wanadoo.fr [90.53.137.203])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id DC4591C0011;
        Wed, 13 Feb 2019 10:54:10 +0000 (UTC)
Date:   Wed, 13 Feb 2019 11:54:10 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Tudor.Ambarus@microchip.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, marek.vasut@gmail.com, richard@nod.at,
        miquel.raynal@bootlin.com, lee.jones@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 04/11] memory: atmel-ebi: add sam9x60 EBI support
Message-ID: <20190213105410.GL10129@piout.net>
References: <20190213085930.31578-1-tudor.ambarus@microchip.com>
 <20190213085930.31578-5-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213085930.31578-5-tudor.ambarus@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2019 08:59:55+0000, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> The sam9x60 board defines the CCFG_EBICSA register under SFR,
> and not as a MATRIX register, as previous boards do.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/memory/atmel-ebi.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
> index b45914cfa212..0322df9dc249 100644
> --- a/drivers/memory/atmel-ebi.c
> +++ b/drivers/memory/atmel-ebi.c
> @@ -17,6 +17,7 @@
>  #include <linux/init.h>
>  #include <linux/of_device.h>
>  #include <linux/regmap.h>
> +#include <soc/at91/atmel-sfr.h>
>  
>  struct atmel_ebi_dev_config {
>  	int cs;
> @@ -440,6 +441,15 @@ static const struct atmel_ebi_caps sama5d3_ebi_caps = {
>  	.apply_config = sama5_ebi_apply_config,
>  };
>  
> +static const struct atmel_ebi_caps sam9x60_ebi_caps = {
> +	.available_cs = 0x3f,
> +	.ebi_csa_offs = AT91_SFR_CCFG_EBICSA,
> +	.regmap_name = "microchip,sfr",
> +	.get_config = at91sam9_ebi_get_config,
> +	.xlate_config = atmel_ebi_xslate_smc_config,
> +	.apply_config = at91sam9_ebi_apply_config,
> +};
> +
>  static const struct of_device_id atmel_ebi_id_table[] = {
>  	{
>  		.compatible = "atmel,at91sam9260-ebi",
> @@ -473,6 +483,10 @@ static const struct of_device_id atmel_ebi_id_table[] = {
>  		.compatible = "atmel,sama5d3-ebi",
>  		.data = &sama5d3_ebi_caps,
>  	},
> +	{
> +		.compatible = "microchip,sam9x60-ebi",
> +		.data = &sam9x60_ebi_caps,
> +	},
>  	{ /* sentinel */ }
>  };
>  
> -- 
> 2.9.5
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
