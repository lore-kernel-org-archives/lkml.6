Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB493C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C447221738
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbfBRVUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 16:20:12 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:49099 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729382AbfBRVUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 16:20:12 -0500
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id E0EDC240005;
        Mon, 18 Feb 2019 21:20:07 +0000 (UTC)
Date:   Mon, 18 Feb 2019 22:20:07 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu.Beznea@microchip.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, Nicolas.Ferre@microchip.com,
        Ludovic.Desroches@microchip.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] clk: at91: sckc: add support for SAM9X60
Message-ID: <20190218212007.GW10129@piout.net>
References: <1550146447-1441-1-git-send-email-claudiu.beznea@microchip.com>
 <1550146447-1441-3-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550146447-1441-3-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2019 12:14:32+0000, Claudiu.Beznea@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Add support for SAM9X60.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/clk/at91/sckc.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
> index b7163d3a2269..b3075c51d260 100644
> --- a/drivers/clk/at91/sckc.c
> +++ b/drivers/clk/at91/sckc.c
> @@ -459,6 +459,36 @@ static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
>  CLK_OF_DECLARE(at91sam9x5_clk_sckc, "atmel,at91sam9x5-sckc",
>  	       of_at91sam9x5_sckc_setup);
>  
> +static const struct clk_slow_offsets at91sam9x60_offsets = {
> +	.cr_rcen = AT91_SCKC_OFFSET_INVALID,
> +	.cr_osc32en = 1,
> +	.cr_osc32byp = 2,
> +	.cr_oscsel = 24,
> +};
> +
> +static void __init of_at91sam9x60_sckc_setup(struct device_node *np)
> +{
> +	struct device_node *childnp;
> +	void (*clk_setup)(struct device_node *np, void __iomem *io,
> +			  const struct clk_slow_offsets *offsets);
> +	const struct of_device_id *clk_id;
> +	void __iomem *regbase = of_iomap(np, 0);
> +
> +	if (!regbase)
> +		return;
> +
> +	for_each_child_of_node(np, childnp) {
> +		clk_id = of_match_node(sckc_clk_ids, childnp);
> +		if (!clk_id)
> +			continue;
> +		clk_setup = clk_id->data;
> +		clk_setup(childnp, regbase, &at91sam9x60_offsets);
> +	}

You actually need to have new bindings. The sam9x60 registration should
look more like the sama5d4 registration. I have a rework for the sam9x5
sckc that I will send this week to have a proper binding (i.e: no
children).

However, there is a fundamental change in the sam9x60, previously, the
sckc had only one output clock. the sam9x60 has both td_slck and
md_slck. Both need to be accessible because they are input to the PMC.

This means you will have to register the sckc with of_clk_hw_onecell_get
as the get callback.

We could still decide to do the same with sam9x5 even if it has only one
output clock.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
