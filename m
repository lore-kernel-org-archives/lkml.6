Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAF5C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82C721901
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390355AbfBMKxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:53:14 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:41435 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfBMKxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:53:14 -0500
X-Originating-IP: 90.53.137.203
Received: from localhost (alyon-652-1-306-203.w90-53.abo.wanadoo.fr [90.53.137.203])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id BEEB21BF20C;
        Wed, 13 Feb 2019 10:53:08 +0000 (UTC)
Date:   Wed, 13 Feb 2019 11:53:08 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Tudor.Ambarus@microchip.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, marek.vasut@gmail.com, richard@nod.at,
        miquel.raynal@bootlin.com, lee.jones@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 02/11] memory: atmel-ebi: add generic name for ebi regmap
Message-ID: <20190213105308.GJ10129@piout.net>
References: <20190213085930.31578-1-tudor.ambarus@microchip.com>
 <20190213085930.31578-3-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213085930.31578-3-tudor.ambarus@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2019 08:59:48+0000, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> The sam9x60 board defines the CCFG_EBICSA register under SFR,
> and not as a MATRIX register, as previous boards do. Add a
> more generic name for the EBI regmap as a prerequisite for
> sam9x60 ebi support.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/memory/atmel-ebi.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
> index c3748b414c27..b45914cfa212 100644
> --- a/drivers/memory/atmel-ebi.c
> +++ b/drivers/memory/atmel-ebi.c
> @@ -36,6 +36,7 @@ struct atmel_ebi_dev {
>  struct atmel_ebi_caps {
>  	unsigned int available_cs;
>  	unsigned int ebi_csa_offs;
> +	const char *regmap_name;
>  	void (*get_config)(struct atmel_ebi_dev *ebid,
>  			   struct atmel_ebi_dev_config *conf);
>  	int (*xlate_config)(struct atmel_ebi_dev *ebid,
> @@ -47,7 +48,7 @@ struct atmel_ebi_caps {
>  
>  struct atmel_ebi {
>  	struct clk *clk;
> -	struct regmap *matrix;
> +	struct regmap *regmap;
>  	struct  {
>  		struct regmap *regmap;
>  		struct clk *clk;
> @@ -357,7 +358,7 @@ static int atmel_ebi_dev_setup(struct atmel_ebi *ebi, struct device_node *np,
>  		 * one "atmel,smc-" property is present.
>  		 */
>  		if (ebi->caps->ebi_csa_offs && apply)
> -			regmap_update_bits(ebi->matrix,
> +			regmap_update_bits(ebi->regmap,
>  					   ebi->caps->ebi_csa_offs,
>  					   BIT(cs), 0);
>  
> @@ -372,6 +373,7 @@ static int atmel_ebi_dev_setup(struct atmel_ebi *ebi, struct device_node *np,
>  static const struct atmel_ebi_caps at91sam9260_ebi_caps = {
>  	.available_cs = 0xff,
>  	.ebi_csa_offs = AT91SAM9260_MATRIX_EBICSA,
> +	.regmap_name = "atmel,matrix",
>  	.get_config = at91sam9_ebi_get_config,
>  	.xlate_config = atmel_ebi_xslate_smc_config,
>  	.apply_config = at91sam9_ebi_apply_config,
> @@ -380,6 +382,7 @@ static const struct atmel_ebi_caps at91sam9260_ebi_caps = {
>  static const struct atmel_ebi_caps at91sam9261_ebi_caps = {
>  	.available_cs = 0xff,
>  	.ebi_csa_offs = AT91SAM9261_MATRIX_EBICSA,
> +	.regmap_name = "atmel,matrix",
>  	.get_config = at91sam9_ebi_get_config,
>  	.xlate_config = atmel_ebi_xslate_smc_config,
>  	.apply_config = at91sam9_ebi_apply_config,
> @@ -388,6 +391,7 @@ static const struct atmel_ebi_caps at91sam9261_ebi_caps = {
>  static const struct atmel_ebi_caps at91sam9263_ebi0_caps = {
>  	.available_cs = 0x3f,
>  	.ebi_csa_offs = AT91SAM9263_MATRIX_EBI0CSA,
> +	.regmap_name = "atmel,matrix",
>  	.get_config = at91sam9_ebi_get_config,
>  	.xlate_config = atmel_ebi_xslate_smc_config,
>  	.apply_config = at91sam9_ebi_apply_config,
> @@ -396,6 +400,7 @@ static const struct atmel_ebi_caps at91sam9263_ebi0_caps = {
>  static const struct atmel_ebi_caps at91sam9263_ebi1_caps = {
>  	.available_cs = 0x7,
>  	.ebi_csa_offs = AT91SAM9263_MATRIX_EBI1CSA,
> +	.regmap_name = "atmel,matrix",
>  	.get_config = at91sam9_ebi_get_config,
>  	.xlate_config = atmel_ebi_xslate_smc_config,
>  	.apply_config = at91sam9_ebi_apply_config,
> @@ -404,6 +409,7 @@ static const struct atmel_ebi_caps at91sam9263_ebi1_caps = {
>  static const struct atmel_ebi_caps at91sam9rl_ebi_caps = {
>  	.available_cs = 0x3f,
>  	.ebi_csa_offs = AT91SAM9RL_MATRIX_EBICSA,
> +	.regmap_name = "atmel,matrix",
>  	.get_config = at91sam9_ebi_get_config,
>  	.xlate_config = atmel_ebi_xslate_smc_config,
>  	.apply_config = at91sam9_ebi_apply_config,
> @@ -412,6 +418,7 @@ static const struct atmel_ebi_caps at91sam9rl_ebi_caps = {
>  static const struct atmel_ebi_caps at91sam9g45_ebi_caps = {
>  	.available_cs = 0x3f,
>  	.ebi_csa_offs = AT91SAM9G45_MATRIX_EBICSA,
> +	.regmap_name = "atmel,matrix",
>  	.get_config = at91sam9_ebi_get_config,
>  	.xlate_config = atmel_ebi_xslate_smc_config,
>  	.apply_config = at91sam9_ebi_apply_config,
> @@ -420,6 +427,7 @@ static const struct atmel_ebi_caps at91sam9g45_ebi_caps = {
>  static const struct atmel_ebi_caps at91sam9x5_ebi_caps = {
>  	.available_cs = 0x3f,
>  	.ebi_csa_offs = AT91SAM9X5_MATRIX_EBICSA,
> +	.regmap_name = "atmel,matrix",
>  	.get_config = at91sam9_ebi_get_config,
>  	.xlate_config = atmel_ebi_xslate_smc_config,
>  	.apply_config = at91sam9_ebi_apply_config,
> @@ -543,13 +551,14 @@ static int atmel_ebi_probe(struct platform_device *pdev)
>  
>  	/*
>  	 * The sama5d3 does not provide an EBICSA register and thus does need
> -	 * to access the matrix registers.
> +	 * to access it.
>  	 */
>  	if (ebi->caps->ebi_csa_offs) {
> -		ebi->matrix =
> -			syscon_regmap_lookup_by_phandle(np, "atmel,matrix");
> -		if (IS_ERR(ebi->matrix))
> -			return PTR_ERR(ebi->matrix);
> +		ebi->regmap =
> +			syscon_regmap_lookup_by_phandle(np,
> +							ebi->caps->regmap_name);
> +		if (IS_ERR(ebi->regmap))
> +			return PTR_ERR(ebi->regmap);
>  	}
>  
>  	ret = of_property_read_u32(np, "#address-cells", &val);
> -- 
> 2.9.5
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
