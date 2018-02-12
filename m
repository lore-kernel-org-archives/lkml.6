Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbeBLPNk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 10:13:40 -0500
Received: from mga11.intel.com ([192.55.52.93]:22211 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751176AbeBLPNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 10:13:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,501,1511856000";
   d="scan'208";a="203430329"
Message-ID: <1518448411.22495.286.camel@linux.intel.com>
Subject: Re: [PATCH 02/21] regulator: fixed: Convert to use GPIO descriptor
 only
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <mike@compulab.co.il>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Daniel Mack <zonque@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 12 Feb 2018 17:13:31 +0200
In-Reply-To: <20180212131717.27193-3-linus.walleij@linaro.org>
References: <20180212131717.27193-1-linus.walleij@linaro.org>
         <20180212131717.27193-3-linus.walleij@linaro.org>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-02-12 at 14:16 +0100, Linus Walleij wrote:
> As we augmented the regulator core to accept a GPIO descriptor instead
> of a GPIO number, we can augment the fixed GPIO regulator to look up
> and pass that descriptor directly from device tree or board GPIO
> descriptor look up tables.
> 
> Some boards just auto-enumerate their fixed regulator platform devices
> and I have assumed they get names like "fixed-regulator.0" but it's
> pretty hard to guess this. I need some testing from board maintainers
> to
> be sure. Other boards are straight forward, using just plain
> "fixed-regulator" (ID -1) or "fixed-regulator.1" hammering down the
> device ID.
> 
> The OMAP didn't have proper label names on its GPIO chips so I have
> fixed
> this with a separate patch to the GPIO tree.
> 
> It seems the da9055 and da9211 has never got around to actually
> passing
> any enable gpio into its platform data (not the in-tree code anyway)
> so we
> can just decide to simply pass a descriptor instead.
> 
> The fixed GPIO-controlled regulator in mach-pxa/ezx.c was confusingly
> named
> "*_dummy_supply_device" while it is a very real device backed by a
> GPIO
> line. There is nothing dummy about it at all, so I renamed it with the
> infix *_regulator_* as part of this patch set.
> 
> For the patch hunk hitting arch/blackfin I would say I do not expect
> testing, review or ACKs anymore so if it works, it works.
> 
> The hunk hitting the x86 BCM43xx driver is especially tricky as the
> number
> comes out of SFI which is a mystery to me. I definately need someone
> to
> look at this. (Hi Andy.)

Hi, Linus!

Nice patch, though I have comments below.

> --- a/arch/x86/platform/intel-mid/device_libs/platform_bcm43xx.c
> +++ b/arch/x86/platform/intel-mid/device_libs/platform_bcm43xx.c

> @@ -43,7 +43,6 @@ static struct fixed_voltage_config bcm43xx_vmmc = {
>  	 * real voltage and signaling are still 1.8V.
>  	 */
>  	.microvolts		= 2000000,		/* 1.8V
> */
> -	.gpio			= -EINVAL,
>  	.startup_delay		= 250 * 1000,		/*
> 250ms */
>  	.enable_high		= 1,			/*
> active high */
>  	.enabled_at_boot	= 0,			/*
> disabled at boot */
> @@ -58,11 +57,25 @@ static struct platform_device
> bcm43xx_vmmc_regulator = {
>  	},
>  };
>  
> +static struct gpiod_lookup_table bcm43xx_vmmc_gpio_table = {
> +	.dev_id	= "reg-fixed-voltage.0",

I'm not sure this will be always like this.
We have DEVID_AUTO, which theoretically can be anything.

Okay, it looks like we have only one static regulator for now for Intel
MID. Though it's fragile if anything will change in the future (quite
unlikely).

> +	.table	= {

> +		/* CHECKME: is this the correct PCI address for the
> GPIO controller? */

Yes.

> +		GPIO_LOOKUP("0000:00:0c.0", -1, "enable",
> GPIO_ACTIVE_LOW),

> +		{ },

Terminator should terminate even at compile time, right?

Simple

{}

looks better to me.

> +	},
> +};
> +
>  static int __init bcm43xx_regulator_register(void)
>  {
> +	struct gpiod_lookup_table *table = &bcm43xx_vmmc_gpio_table;
> +	struct gpiod_lookup *lookup = table->table;
>  	int ret;
>  
> -	bcm43xx_vmmc.gpio =
> get_gpio_by_name(WLAN_SFI_GPIO_ENABLE_NAME);

> +	/* FIXME: convert SFI layer to use GPIO descriptors
> internally */

We already discussed this few years ago and decide not to do anything
WRT SFI. It should just die.

> +	lookup[0].chip_hwnum =
> get_gpio_by_name(WLAN_SFI_GPIO_ENABLE_NAME);
> +	gpiod_add_lookup_table(table);



> --- a/drivers/regulator/fixed.c
> +++ b/drivers/regulator/fixed.c


>  	cfg.ena_gpio_invert = !config->enable_high;

>  	if (config->enabled_at_boot) {
>  		if (config->enable_high)
> -			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_HIGH;
> +			gflags = GPIOD_OUT_HIGH;
>  		else
> -			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_LOW;
> +			gflags = GPIOD_OUT_LOW;
>  	} else {
>  		if (config->enable_high)
> -			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_LOW;
> +			gflags = GPIOD_OUT_LOW;
>  		else
> -			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_HIGH;
> +			gflags = GPIOD_OUT_HIGH;
>  	}

Just a side note: It might make sense to split this to some kind of
generic helper, like:

static inline enum gpiod_flags gpiod_flags_output(bool value, bool
invert)
{
...
}

> +	if (config->gpio_is_open_drain) {
> +		if (gflags == GPIOD_OUT_HIGH)
> +			gflags = GPIOD_OUT_HIGH_OPEN_DRAIN;
> +		else
> +			gflags = GPIOD_OUT_LOW_OPEN_DRAIN;
> +	}
> +

> +	cfg.ena_gpiod = devm_gpiod_get_optional(&pdev->dev, NULL,
> gflags);

Shouldn't we be a little bit more stricter here, i.e. require "enable"
name?

> +	if (IS_ERR(cfg.ena_gpiod))
> +		return PTR_ERR(cfg.ena_gpiod);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
