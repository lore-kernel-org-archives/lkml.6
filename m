Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D34D13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2497420892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2497420892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeG3MO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 08:14:57 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42827 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbeG3MO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 08:14:57 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1fk5bE-0001YV-Gh; Mon, 30 Jul 2018 12:40:24 +0200
Message-ID: <1532947222.3471.4.camel@pengutronix.de>
Subject: Re: [PATCH 8/9] clk: actions: Add Actions Semi S700 SoC Reset
 Management Unit support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mturquette@baylibre.com, sboyd@kernel.org, afaerber@suse.de,
        robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br, sravanhome@gmail.com
Date:   Mon, 30 Jul 2018 12:40:22 +0200
In-Reply-To: <20180727184527.13287-9-manivannan.sadhasivam@linaro.org>
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
         <20180727184527.13287-9-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-07-28 at 00:15 +0530, Manivannan Sadhasivam wrote:
> Add Reset Management Unit (RMU) support for Actions Semi S700 SoC.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/clk/actions/owl-s700.c | 51 ++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/drivers/clk/actions/owl-s700.c b/drivers/clk/actions/owl-s700.c
> index e7cacd677275..d9c0c7870135 100644
> --- a/drivers/clk/actions/owl-s700.c
> +++ b/drivers/clk/actions/owl-s700.c
> @@ -20,8 +20,10 @@
>  #include "owl-gate.h"
>  #include "owl-mux.h"
>  #include "owl-pll.h"
> +#include "owl-reset.h"
>  
>  #include <dt-bindings/clock/actions,s700-cmu.h>
> +#include <dt-bindings/reset/actions,s700-reset.h>
>  
>  #define CMU_COREPLL		(0x0000)
>  #define CMU_DEVPLL		(0x0004)
> @@ -569,20 +571,69 @@ static struct clk_hw_onecell_data s700_hw_clks = {
>  		.num    = CLK_NR_CLKS,
>  };
>  
> +static struct owl_reset_map s700_resets[] = {

This could be
static const struct owl_reset_map s700_resets[] = {

> +	[RESET_DE]	= { CMU_DEVRST0, BIT(0) },
> +	[RESET_LCD0]	= { CMU_DEVRST0, BIT(1) },
> +	[RESET_DSI]	= { CMU_DEVRST0, BIT(2) },
> +	[RESET_CSI]	= { CMU_DEVRST0, BIT(13) },
> +	[RESET_SI]	= { CMU_DEVRST0, BIT(14) },
> +	[RESET_I2C0]	= { CMU_DEVRST1, BIT(0) },
> +	[RESET_I2C1]	= { CMU_DEVRST1, BIT(1) },
> +	[RESET_I2C2]	= { CMU_DEVRST1, BIT(2) },
> +	[RESET_I2C3]	= { CMU_DEVRST1, BIT(3) },
> +	[RESET_SPI0]	= { CMU_DEVRST1, BIT(4) },
> +	[RESET_SPI1]	= { CMU_DEVRST1, BIT(5) },
> +	[RESET_SPI2]	= { CMU_DEVRST1, BIT(6) },
> +	[RESET_SPI3]	= { CMU_DEVRST1, BIT(7) },
> +	[RESET_UART0]	= { CMU_DEVRST1, BIT(8) },
> +	[RESET_UART1]	= { CMU_DEVRST1, BIT(9) },
> +	[RESET_UART2]	= { CMU_DEVRST1, BIT(10) },
> +	[RESET_UART3]	= { CMU_DEVRST1, BIT(11) },
> +	[RESET_UART4]	= { CMU_DEVRST1, BIT(12) },
> +	[RESET_UART5]	= { CMU_DEVRST1, BIT(13) },
> +	[RESET_UART6]	= { CMU_DEVRST1, BIT(14) },
> +	[RESET_KEY]	= { CMU_DEVRST1, BIT(24) },
> +	[RESET_GPIO]	= { CMU_DEVRST1, BIT(25) },
> +	[RESET_AUDIO]	= { CMU_DEVRST1, BIT(29) },
> +};
> +
>  static struct owl_clk_desc s700_clk_desc = {
>  	.clks       = s700_clks,
>  	.num_clks   = ARRAY_SIZE(s700_clks),
>  
>  	.hw_clks    = &s700_hw_clks,
> +
> +	.resets     = s700_resets,
> +	.num_resets = ARRAY_SIZE(s700_resets),
>  };
>  
>  static int s700_clk_probe(struct platform_device *pdev)
>  {
>  	struct owl_clk_desc *desc;
> +	struct owl_reset *reset;
> +	int ret;
>  
>  	desc = &s700_clk_desc;
>  	owl_clk_regmap_init(pdev, desc);
>  
> +	/*
> +	 * FIXME: Reset controller registration should be moved to
> +	 * common code, once all SoCs of Owl family supports it.
> +	 */
> +	reset = devm_kzalloc(&pdev->dev, sizeof(*reset), GFP_KERNEL);
> +	if (!reset)
> +		return -ENOMEM;
> +
> +	reset->rcdev.of_node = pdev->dev.of_node;
> +	reset->rcdev.ops = &owl_reset_ops;
> +	reset->rcdev.nr_resets = desc->num_resets;
> +	reset->reset_map = desc->resets;
> +	reset->regmap = desc->regmap;
> +
> +	ret = devm_reset_controller_register(&pdev->dev, &reset->rcdev);
> +	if (ret)
> +		dev_err(&pdev->dev, "Failed to register reset controller\n");
> +
>  	return owl_clk_probe(&pdev->dev, desc->hw_clks);
>  }

regards
Philipp
