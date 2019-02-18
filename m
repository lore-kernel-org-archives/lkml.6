Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F14CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350D0217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbfBRVIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 16:08:20 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:40613 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729084AbfBRVIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 16:08:17 -0500
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 15EDA100003;
        Mon, 18 Feb 2019 21:08:11 +0000 (UTC)
Date:   Mon, 18 Feb 2019 22:08:11 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu.Beznea@microchip.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, Nicolas.Ferre@microchip.com,
        Ludovic.Desroches@microchip.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] clk: at91: sckc: add support to specify registers
 bit offsets
Message-ID: <20190218210811.GV10129@piout.net>
References: <1550146447-1441-1-git-send-email-claudiu.beznea@microchip.com>
 <1550146447-1441-2-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550146447-1441-2-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/02/2019 12:14:28+0000, Claudiu.Beznea@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Different IPs uses different offsets in registers for the same
> functionality, thus adapt the driver to support this.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/clk/at91/sckc.c | 112 +++++++++++++++++++++++++++++++++---------------
>  1 file changed, 77 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
> index ab6ecefc49ad..b7163d3a2269 100644
> --- a/drivers/clk/at91/sckc.c
> +++ b/drivers/clk/at91/sckc.c
> @@ -22,15 +22,25 @@
>  #define SLOWCK_SW_TIME_USEC	((SLOWCK_SW_CYCLES * USEC_PER_SEC) / \
>  				 SLOW_CLOCK_FREQ)
>  
> -#define	AT91_SCKC_CR			0x00
> -#define		AT91_SCKC_RCEN		(1 << 0)
> -#define		AT91_SCKC_OSC32EN	(1 << 1)
> -#define		AT91_SCKC_OSC32BYP	(1 << 2)
> -#define		AT91_SCKC_OSCSEL	(1 << 3)
> +#define	AT91_SCKC_CR		0x00
> +#define		AT91_SCKC_RCEN(off)	(1 << (off)->cr_rcen)
> +#define		AT91_SCKC_OSC32EN(off)	(1 << (off)->cr_osc32en)
> +#define		AT91_SCKC_OSC32BYP(off)	(1 << (off)->cr_osc32byp)
> +#define		AT91_SCKC_OSCSEL(off)	(1 << (off)->cr_oscsel)

You don't need those macros if you store BIT(off) instead of off in the
members of clk_slow_offsets.

> +
> +#define AT91_SCKC_OFFSET_INVALID        (32)
> +

This would also remove the need for that define as 0 would mean that the
bit doesn't exist.

> +struct clk_slow_offsets {
> +	u8 cr_rcen;
> +	u8 cr_osc32en;
> +	u8 cr_osc32byp;
> +	u8 cr_oscsel;
> +};
>  
>  struct clk_slow_osc {
>  	struct clk_hw hw;
>  	void __iomem *sckcr;
> +	const struct clk_slow_offsets *offsets;
>  	unsigned long startup_usec;
>  };
>  
> @@ -39,6 +49,7 @@ struct clk_slow_osc {
>  struct clk_sama5d4_slow_osc {
>  	struct clk_hw hw;
>  	void __iomem *sckcr;
> +	const struct clk_slow_offsets *offsets;
>  	unsigned long startup_usec;
>  	bool prepared;
>  };
> @@ -48,6 +59,7 @@ struct clk_sama5d4_slow_osc {
>  struct clk_slow_rc_osc {
>  	struct clk_hw hw;
>  	void __iomem *sckcr;
> +	const struct clk_slow_offsets *offsets;
>  	unsigned long frequency;
>  	unsigned long accuracy;
>  	unsigned long startup_usec;
> @@ -58,6 +70,7 @@ struct clk_slow_rc_osc {
>  struct clk_sam9x5_slow {
>  	struct clk_hw hw;
>  	void __iomem *sckcr;
> +	const struct clk_slow_offsets *offsets;
>  	u8 parent;
>  };
>  
> @@ -69,10 +82,11 @@ static int clk_slow_osc_prepare(struct clk_hw *hw)
>  	void __iomem *sckcr = osc->sckcr;
>  	u32 tmp = readl(sckcr);
>  
> -	if (tmp & (AT91_SCKC_OSC32BYP | AT91_SCKC_OSC32EN))
> +	if (tmp & (AT91_SCKC_OSC32BYP(osc->offsets) |
> +		   AT91_SCKC_OSC32EN(osc->offsets)))
>  		return 0;
>  
> -	writel(tmp | AT91_SCKC_OSC32EN, sckcr);
> +	writel(tmp | AT91_SCKC_OSC32EN(osc->offsets), sckcr);
>  
>  	usleep_range(osc->startup_usec, osc->startup_usec + 1);
>  
> @@ -85,10 +99,10 @@ static void clk_slow_osc_unprepare(struct clk_hw *hw)
>  	void __iomem *sckcr = osc->sckcr;
>  	u32 tmp = readl(sckcr);
>  
> -	if (tmp & AT91_SCKC_OSC32BYP)
> +	if (tmp & AT91_SCKC_OSC32BYP(osc->offsets))
>  		return;
>  
> -	writel(tmp & ~AT91_SCKC_OSC32EN, sckcr);
> +	writel(tmp & ~AT91_SCKC_OSC32EN(osc->offsets), sckcr);
>  }
>  
>  static int clk_slow_osc_is_prepared(struct clk_hw *hw)
> @@ -97,10 +111,10 @@ static int clk_slow_osc_is_prepared(struct clk_hw *hw)
>  	void __iomem *sckcr = osc->sckcr;
>  	u32 tmp = readl(sckcr);
>  
> -	if (tmp & AT91_SCKC_OSC32BYP)
> +	if (tmp & AT91_SCKC_OSC32BYP(osc->offsets))
>  		return 1;
>  
> -	return !!(tmp & AT91_SCKC_OSC32EN);
> +	return !!(tmp & AT91_SCKC_OSC32EN(osc->offsets));
>  }
>  
>  static const struct clk_ops slow_osc_ops = {
> @@ -114,7 +128,8 @@ at91_clk_register_slow_osc(void __iomem *sckcr,
>  			   const char *name,
>  			   const char *parent_name,
>  			   unsigned long startup,
> -			   bool bypass)
> +			   bool bypass,
> +			   const struct clk_slow_offsets *offsets)
>  {
>  	struct clk_slow_osc *osc;
>  	struct clk_hw *hw;
> @@ -137,9 +152,11 @@ at91_clk_register_slow_osc(void __iomem *sckcr,
>  	osc->hw.init = &init;
>  	osc->sckcr = sckcr;
>  	osc->startup_usec = startup;
> +	osc->offsets = offsets;
>  
>  	if (bypass)
> -		writel((readl(sckcr) & ~AT91_SCKC_OSC32EN) | AT91_SCKC_OSC32BYP,
> +		writel((readl(sckcr) & ~AT91_SCKC_OSC32EN(osc->offsets)) |
> +					AT91_SCKC_OSC32BYP(osc->offsets),
>  		       sckcr);
>  
>  	hw = &osc->hw;
> @@ -153,7 +170,8 @@ at91_clk_register_slow_osc(void __iomem *sckcr,
>  }
>  
>  static void __init
> -of_at91sam9x5_clk_slow_osc_setup(struct device_node *np, void __iomem *sckcr)
> +of_at91sam9x5_clk_slow_osc_setup(struct device_node *np, void __iomem *sckcr,
> +				 const struct clk_slow_offsets *offsets)
>  {
>  	struct clk_hw *hw;
>  	const char *parent_name;
> @@ -167,7 +185,7 @@ of_at91sam9x5_clk_slow_osc_setup(struct device_node *np, void __iomem *sckcr)
>  	bypass = of_property_read_bool(np, "atmel,osc-bypass");
>  
>  	hw = at91_clk_register_slow_osc(sckcr, name, parent_name, startup,
> -					 bypass);
> +					bypass, offsets);
>  	if (IS_ERR(hw))
>  		return;
>  
> @@ -195,7 +213,7 @@ static int clk_slow_rc_osc_prepare(struct clk_hw *hw)
>  	struct clk_slow_rc_osc *osc = to_clk_slow_rc_osc(hw);
>  	void __iomem *sckcr = osc->sckcr;
>  
> -	writel(readl(sckcr) | AT91_SCKC_RCEN, sckcr);
> +	writel(readl(sckcr) | AT91_SCKC_RCEN(osc->offsets), sckcr);
>  
>  	usleep_range(osc->startup_usec, osc->startup_usec + 1);
>  
> @@ -207,14 +225,14 @@ static void clk_slow_rc_osc_unprepare(struct clk_hw *hw)
>  	struct clk_slow_rc_osc *osc = to_clk_slow_rc_osc(hw);
>  	void __iomem *sckcr = osc->sckcr;
>  
> -	writel(readl(sckcr) & ~AT91_SCKC_RCEN, sckcr);
> +	writel(readl(sckcr) & ~AT91_SCKC_RCEN(osc->offsets), sckcr);
>  }
>  
>  static int clk_slow_rc_osc_is_prepared(struct clk_hw *hw)
>  {
>  	struct clk_slow_rc_osc *osc = to_clk_slow_rc_osc(hw);
>  
> -	return !!(readl(osc->sckcr) & AT91_SCKC_RCEN);
> +	return !!(readl(osc->sckcr) & AT91_SCKC_RCEN(osc->offsets));
>  }
>  
>  static const struct clk_ops slow_rc_osc_ops = {
> @@ -230,7 +248,8 @@ at91_clk_register_slow_rc_osc(void __iomem *sckcr,
>  			      const char *name,
>  			      unsigned long frequency,
>  			      unsigned long accuracy,
> -			      unsigned long startup)
> +			      unsigned long startup,
> +			      const struct clk_slow_offsets *offsets)
>  {
>  	struct clk_slow_rc_osc *osc;
>  	struct clk_hw *hw;
> @@ -252,6 +271,7 @@ at91_clk_register_slow_rc_osc(void __iomem *sckcr,
>  
>  	osc->hw.init = &init;
>  	osc->sckcr = sckcr;
> +	osc->offsets = offsets;
>  	osc->frequency = frequency;
>  	osc->accuracy = accuracy;
>  	osc->startup_usec = startup;
> @@ -267,7 +287,8 @@ at91_clk_register_slow_rc_osc(void __iomem *sckcr,
>  }
>  
>  static void __init
> -of_at91sam9x5_clk_slow_rc_osc_setup(struct device_node *np, void __iomem *sckcr)
> +of_at91sam9x5_clk_slow_rc_osc_setup(struct device_node *np, void __iomem *sckcr,
> +				    const struct clk_slow_offsets *offsets)
>  {
>  	struct clk_hw *hw;
>  	u32 frequency = 0;
> @@ -281,7 +302,7 @@ of_at91sam9x5_clk_slow_rc_osc_setup(struct device_node *np, void __iomem *sckcr)
>  	of_property_read_u32(np, "atmel,startup-time-usec", &startup);
>  
>  	hw = at91_clk_register_slow_rc_osc(sckcr, name, frequency, accuracy,
> -					    startup);
> +					   startup, offsets);
>  	if (IS_ERR(hw))
>  		return;
>  
> @@ -299,14 +320,14 @@ static int clk_sam9x5_slow_set_parent(struct clk_hw *hw, u8 index)
>  
>  	tmp = readl(sckcr);
>  
> -	if ((!index && !(tmp & AT91_SCKC_OSCSEL)) ||
> -	    (index && (tmp & AT91_SCKC_OSCSEL)))
> +	if ((!index && !(tmp & AT91_SCKC_OSCSEL(slowck->offsets))) ||
> +	    (index && (tmp & AT91_SCKC_OSCSEL(slowck->offsets))))
>  		return 0;
>  
>  	if (index)
> -		tmp |= AT91_SCKC_OSCSEL;
> +		tmp |= AT91_SCKC_OSCSEL(slowck->offsets);
>  	else
> -		tmp &= ~AT91_SCKC_OSCSEL;
> +		tmp &= ~AT91_SCKC_OSCSEL(slowck->offsets);
>  
>  	writel(tmp, sckcr);
>  
> @@ -319,7 +340,7 @@ static u8 clk_sam9x5_slow_get_parent(struct clk_hw *hw)
>  {
>  	struct clk_sam9x5_slow *slowck = to_clk_sam9x5_slow(hw);
>  
> -	return !!(readl(slowck->sckcr) & AT91_SCKC_OSCSEL);
> +	return !!(readl(slowck->sckcr) & AT91_SCKC_OSCSEL(slowck->offsets));
>  }
>  
>  static const struct clk_ops sam9x5_slow_ops = {
> @@ -331,7 +352,8 @@ static struct clk_hw * __init
>  at91_clk_register_sam9x5_slow(void __iomem *sckcr,
>  			      const char *name,
>  			      const char **parent_names,
> -			      int num_parents)
> +			      int num_parents,
> +			      const struct clk_slow_offsets *offsets)
>  {
>  	struct clk_sam9x5_slow *slowck;
>  	struct clk_hw *hw;
> @@ -353,7 +375,8 @@ at91_clk_register_sam9x5_slow(void __iomem *sckcr,
>  
>  	slowck->hw.init = &init;
>  	slowck->sckcr = sckcr;
> -	slowck->parent = !!(readl(sckcr) & AT91_SCKC_OSCSEL);
> +	slowck->offsets = offsets;
> +	slowck->parent = !!(readl(sckcr) & AT91_SCKC_OSCSEL(slowck->offsets));
>  
>  	hw = &slowck->hw;
>  	ret = clk_hw_register(NULL, &slowck->hw);
> @@ -366,7 +389,8 @@ at91_clk_register_sam9x5_slow(void __iomem *sckcr,
>  }
>  
>  static void __init
> -of_at91sam9x5_clk_slow_setup(struct device_node *np, void __iomem *sckcr)
> +of_at91sam9x5_clk_slow_setup(struct device_node *np, void __iomem *sckcr,
> +			     const struct clk_slow_offsets *offsets)
>  {
>  	struct clk_hw *hw;
>  	const char *parent_names[2];
> @@ -382,7 +406,7 @@ of_at91sam9x5_clk_slow_setup(struct device_node *np, void __iomem *sckcr)
>  	of_property_read_string(np, "clock-output-names", &name);
>  
>  	hw = at91_clk_register_sam9x5_slow(sckcr, name, parent_names,
> -					    num_parents);
> +					   num_parents, offsets);
>  	if (IS_ERR(hw))
>  		return;
>  
> @@ -406,10 +430,18 @@ static const struct of_device_id sckc_clk_ids[] __initconst = {
>  	{ /*sentinel*/ }
>  };
>  
> +static const struct clk_slow_offsets at91sam9x5_offsets = {
> +	.cr_rcen = 0,
> +	.cr_osc32en = 1,
> +	.cr_osc32byp = 2,
> +	.cr_oscsel = 3,
> +};
> +
>  static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
>  {
>  	struct device_node *childnp;
> -	void (*clk_setup)(struct device_node *, void __iomem *);
> +	void (*clk_setup)(struct device_node *np, void __iomem *io,
> +			  const struct clk_slow_offsets *offsets);
>  	const struct of_device_id *clk_id;
>  	void __iomem *regbase = of_iomap(np, 0);
>  
> @@ -421,7 +453,7 @@ static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
>  		if (!clk_id)
>  			continue;
>  		clk_setup = clk_id->data;
> -		clk_setup(childnp, regbase);
> +		clk_setup(childnp, regbase, &at91sam9x5_offsets);
>  	}
>  }
>  CLK_OF_DECLARE(at91sam9x5_clk_sckc, "atmel,at91sam9x5-sckc",
> @@ -438,7 +470,7 @@ static int clk_sama5d4_slow_osc_prepare(struct clk_hw *hw)
>  	 * Assume that if it has already been selected (for example by the
>  	 * bootloader), enough time has aready passed.
>  	 */
> -	if ((readl(osc->sckcr) & AT91_SCKC_OSCSEL)) {
> +	if ((readl(osc->sckcr) & AT91_SCKC_OSCSEL(osc->offsets))) {
>  		osc->prepared = true;
>  		return 0;
>  	}
> @@ -461,6 +493,13 @@ static const struct clk_ops sama5d4_slow_osc_ops = {
>  	.is_prepared = clk_sama5d4_slow_osc_is_prepared,
>  };
>  
> +static const struct clk_slow_offsets at91sama5d4_offsets = {
> +	.cr_rcen = AT91_SCKC_OFFSET_INVALID,
> +	.cr_osc32en = AT91_SCKC_OFFSET_INVALID,
> +	.cr_osc32byp = AT91_SCKC_OFFSET_INVALID,
> +	.cr_oscsel = 3,
> +};
> +

I don't think you need to change the sama5d4 part as it is not affected
by any change in the sam9x5 part.

>  static void __init of_sama5d4_sckc_setup(struct device_node *np)
>  {
>  	void __iomem *regbase = of_iomap(np, 0);
> @@ -498,9 +537,11 @@ static void __init of_sama5d4_sckc_setup(struct device_node *np)
>  	osc->hw.init = &init;
>  	osc->sckcr = regbase;
>  	osc->startup_usec = 1200000;
> +	osc->offsets = &at91sama5d4_offsets;
>  
>  	if (bypass)
> -		writel((readl(regbase) | AT91_SCKC_OSC32BYP), regbase);
> +		writel((readl(regbase) | AT91_SCKC_OSC32BYP(osc->offsets)),
> +		       regbase);
>  
>  	hw = &osc->hw;
>  	ret = clk_hw_register(NULL, &osc->hw);
> @@ -509,7 +550,8 @@ static void __init of_sama5d4_sckc_setup(struct device_node *np)
>  		return;
>  	}
>  
> -	hw = at91_clk_register_sam9x5_slow(regbase, "slowck", parent_names, 2);
> +	hw = at91_clk_register_sam9x5_slow(regbase, "slowck", parent_names, 2,
> +					   &at91sama5d4_offsets);
>  	if (IS_ERR(hw))
>  		return;
>  
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
