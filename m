Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CD9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6F12146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfBTLGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:06:49 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:43761 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfBTLGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:06:48 -0500
Received: from localhost (alyon-652-1-153-126.w109-212.abo.wanadoo.fr [109.212.12.126])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 57F0E240020;
        Wed, 20 Feb 2019 11:06:43 +0000 (UTC)
Date:   Wed, 20 Feb 2019 12:06:43 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu.Beznea@microchip.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, Nicolas.Ferre@microchip.com,
        Ludovic.Desroches@microchip.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] clk: at91: sckc: add support for SAM9X60
Message-ID: <20190220110643.GI11432@piout.net>
References: <1550146447-1441-1-git-send-email-claudiu.beznea@microchip.com>
 <1550146447-1441-3-git-send-email-claudiu.beznea@microchip.com>
 <20190218212007.GW10129@piout.net>
 <c00fb195-1688-6ac4-a606-5e08509a2c39@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c00fb195-1688-6ac4-a606-5e08509a2c39@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2019 09:17:43+0000, Claudiu.Beznea@microchip.com wrote:
> 
> 
> On 18.02.2019 23:20, Alexandre Belloni wrote:
> > On 14/02/2019 12:14:32+0000, Claudiu.Beznea@microchip.com wrote:
> >> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> >>
> >> Add support for SAM9X60.
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> >> ---
> >>  drivers/clk/at91/sckc.c | 30 ++++++++++++++++++++++++++++++
> >>  1 file changed, 30 insertions(+)
> >>
> >> diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
> >> index b7163d3a2269..b3075c51d260 100644
> >> --- a/drivers/clk/at91/sckc.c
> >> +++ b/drivers/clk/at91/sckc.c
> >> @@ -459,6 +459,36 @@ static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
> >>  CLK_OF_DECLARE(at91sam9x5_clk_sckc, "atmel,at91sam9x5-sckc",
> >>  	       of_at91sam9x5_sckc_setup);
> >>  
> >> +static const struct clk_slow_offsets at91sam9x60_offsets = {
> >> +	.cr_rcen = AT91_SCKC_OFFSET_INVALID,
> >> +	.cr_osc32en = 1,
> >> +	.cr_osc32byp = 2,
> >> +	.cr_oscsel = 24,
> >> +};
> >> +
> >> +static void __init of_at91sam9x60_sckc_setup(struct device_node *np)
> >> +{
> >> +	struct device_node *childnp;
> >> +	void (*clk_setup)(struct device_node *np, void __iomem *io,
> >> +			  const struct clk_slow_offsets *offsets);
> >> +	const struct of_device_id *clk_id;
> >> +	void __iomem *regbase = of_iomap(np, 0);
> >> +
> >> +	if (!regbase)
> >> +		return;
> >> +
> >> +	for_each_child_of_node(np, childnp) {
> >> +		clk_id = of_match_node(sckc_clk_ids, childnp);
> >> +		if (!clk_id)
> >> +			continue;
> >> +		clk_setup = clk_id->data;
> >> +		clk_setup(childnp, regbase, &at91sam9x60_offsets);
> >> +	}
> > 
> > You actually need to have new bindings. The sam9x60 registration should
> > look more like the sama5d4 registration. I have a rework for the sam9x5
> > sckc that I will send this week to have a proper binding (i.e: no
> > children).
> 
> Does this means that this would also solve the problem I tried to address
> with this patch?
> 

I've sent the series now. It doesn't solve this particular issue.

> > 
> > However, there is a fundamental change in the sam9x60, previously, the
> > sckc had only one output clock. the sam9x60 has both td_slck and
> > md_slck. Both need to be accessible because they are input to the PMC.
> 
> I was guided by the fact that md_slck is generated by the always on slow RC
> oscillator (part of slow clock controller) and since there is no control
> for it on slow clock controller there is no need to be described by this
> driver.
> 

Well, then it would need to be added as an input to the sckc which would
mean that you still need to change the binding. This doesn't matter too
much but else your clock tree would be wrong.

> > 
> > This means you will have to register the sckc with of_clk_hw_onecell_get
> > as the get callback.
> 
> Ok, I'll look into it.
> 
> > 
> > We could still decide to do the same with sam9x5 even if it has only one
> > output clock.
> > 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
