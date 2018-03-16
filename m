Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbeCPWQg convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 18:16:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751233AbeCPWQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 18:16:34 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F5120685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Mike Looijmans <mike.looijmans@topic.nl>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1520930639-11642-1-git-send-email-mike.looijmans@topic.nl>
Cc: linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Mike Looijmans <mike.looijmans@topic.nl>
References: <1520930639-11642-1-git-send-email-mike.looijmans@topic.nl>
Message-ID: <152123859352.242365.3408932790685699097@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: Add driver for the si544 clock generator chip
Date: Fri, 16 Mar 2018 15:16:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Looijmans (2018-03-13 01:43:59)
> diff --git a/Documentation/devicetree/bindings/clock/silabs,si544.txt b/Documentation/devicetree/bindings/clock/silabs,si544.txt
> new file mode 100644
> index 0000000..eec1787
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/silabs,si544.txt
> @@ -0,0 +1,25 @@
> +Binding for Silicon Labs 544 programmable I2C clock generator.
> +
> +Reference
> +This binding uses the common clock binding[1]. Details about the device can be
> +found in the datasheet[2].
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +[2] Si544 datasheet
> +    https://www.silabs.com/documents/public/data-sheets/si544-datasheet.pdf

Can this reference stuff go to the bottom of this document?

> +
> +Required properties:
> + - compatible: One of "silabs,si514a", "silabs,si514b" "silabs,si514c" according
> +               to the speed grade of the chip.
> + - reg: I2C device address.
> + - #clock-cells: From common clock bindings: Shall be 0.
> +
> +Optional properties:
> + - clock-output-names: From common clock bindings. Recommended to be "si544".
> +
> +Example:
> +       si544: clock-generator@55 {

I'm not sure clock-generator is in the list of node names, but we have
some of these already so alright.

> +               reg = <0x55>;
> +               #clock-cells = <0>;
> +               compatible = "silabs,si544b";
> +       };
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 98ce9fc..5c7dc8e 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -91,6 +91,16 @@ config COMMON_CLK_SI514
>           This driver supports the Silicon Labs 514 programmable clock
>           generator.
>  
> +config COMMON_CLK_SI544
> +       tristate "Clock driver for SiLabs 544 devices"
> +       depends on I2C
> +       depends on OF

Does it depend on anything in OF to build?

> +       select REGMAP_I2C
> +       help
> +       ---help---
> +         This driver supports the Silicon Labs 544 programmable clock
> +         generator.
> +
>  config COMMON_CLK_SI570
>         tristate "Clock driver for SiLabs 570 and compatible devices"
>         depends on I2C
> diff --git a/drivers/clk/clk-si544.c b/drivers/clk/clk-si544.c
> new file mode 100644
> index 0000000..1947e48
> --- /dev/null
> +++ b/drivers/clk/clk-si544.c
> @@ -0,0 +1,421 @@
> +/*
> + * Driver for Silicon Labs Si544 Programmable Oscillator
> + *
> + * Copyright (C) 2018 Topic Embedded Products
> + *
> + * Author: Mike Looijmans <mike.looijmans@topic.nl>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

Can we have SPDX style license here?

> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +/* I2C registers (decimal as in datasheet) */

Heh.

> +#define SI544_REG_CONTROL      7
> +#define SI544_REG_OE_STATE     17
> +#define SI544_REG_HS_DIV       23
> +#define SI544_REG_LS_HS_DIV    24
> +#define SI544_REG_FBDIV0       26
> +#define SI544_REG_FBDIV8       27
> +#define SI544_REG_FBDIV16      28
> +#define SI544_REG_FBDIV24      29
> +#define SI544_REG_FBDIV32      30
> +#define SI544_REG_FBDIV40      31
> +#define SI544_REG_FCAL_OVR     69
> +#define SI544_REG_ADPLL_DELTA_M0       231
> +#define SI544_REG_ADPLL_DELTA_M8       232
> +#define SI544_REG_ADPLL_DELTA_M16      233
> +#define SI544_REG_PAGE_SELECT  255
> +
> +/* Register values */
> +#define SI544_CONTROL_RESET    BIT(7)
> +#define SI544_CONTROL_MS_ICAL2 BIT(3)
> +
> +#define SI544_OE_STATE_ODC_OE  BIT(0)
> +
> +/* Max freq depends on speed grade */
> +#define SI544_MIN_FREQ     200000U
> +
> +/* Si544 Internal oscilator runs at 55.05 MHz */
> +#define FXO              55050000U
> +
> +/* VCO range is 10.8 .. 12.1 GHz, max depends on speed grade */
> +#define FVCO_MIN       10800000000ULL
> +
> +#define HS_DIV_MAX     2046
> +#define HS_DIV_MAX_ODD 33
> +
> +enum si544_speed_grade {
> +       si544a,
> +       si544b,
> +       si544c,
> +};
> +
> +struct clk_si544 {
> +       struct clk_hw hw;
> +       struct regmap *regmap;
> +       struct i2c_client *i2c_client;
> +       enum si544_speed_grade speed_grade;
> +};
> +#define to_clk_si544(_hw)      container_of(_hw, struct clk_si544, hw)
> +
> +/* Multiplier/divider settings */
> +struct clk_si544_muldiv {
> +       u32 fb_div_frac;  /* Integer part of feedback divider (32 bits) */
> +       u16 fb_div_int;  /* Fractional part of feedback divider (11 bits) */
> +       u16 hs_div; /* 1st divider, 5..2046, must be even when >33 */
> +       u8 ls_div_bits; /* 2nd divider, as 2^x, range 0..5 */
> +};

Can you use kernel-doc style instead of inline comments please.

> +
> +static bool is_valid_frequency(const struct clk_si544 *data,
> +       unsigned long frequency)
> +{
> +       unsigned long max_freq;
> +
> +       if (frequency < SI544_MIN_FREQ)
> +               return false;
> +
> +       switch (data->speed_grade) {
> +       case si544a:
> +               max_freq = 1500000000;
> +               break;
> +       case si544b:
> +               max_freq = 800000000;
> +               break;
> +       case si544c:
> +               max_freq = 350000000;
> +               break;
> +       default:
> +               return false;

Drop this default case and let the compiler complain if we get a new
enum to handle.

> +       }
> +
> +       if (frequency > max_freq)
> +               return false;
> +
> +       return true;

Replace with 'return frequency <= max_freq'?

> +}
> +
> +/* Calculate divider settings for a given frequency */
> +static int si544_calc_muldiv(struct clk_si544_muldiv *settings,
> +       unsigned long frequency)
> +{
> +       u64 vco;
> +       u32 ls_freq;
> +       u32 tmp;
> +       u8 res;
> +
> +       /* Determine the minimum value of LS_DIV and resulting target freq. */
> +       ls_freq = frequency;
> +       settings->ls_div_bits = 0;
> +
> +       if (frequency >= (FVCO_MIN / HS_DIV_MAX))

Maybe FVCO_MIN/HS_DIV_MAX has a name that can be defined? MIN_DIV_FREQ?

> +               settings->ls_div_bits = 0;
> +       else {

Style: Please add braces on the if arm too.

> +               res = 1;
> +               tmp = 2 * HS_DIV_MAX;
> +               while (tmp <= (HS_DIV_MAX * 32)) {
> +                       if ((frequency * tmp) >= FVCO_MIN)
> +                               break;
> +                       ++res;
> +                       tmp <<= 1;
> +               }
> +               settings->ls_div_bits = res;
> +               ls_freq = frequency << res;
> +       }
> +
> +       /* Determine minimum HS_DIV by rounding up */
> +       vco = FVCO_MIN + ls_freq - 1;
> +       do_div(vco, ls_freq);
> +       settings->hs_div = vco;
> +       /* round up to even number if needed */
> +       if ((settings->hs_div > HS_DIV_MAX_ODD) && (settings->hs_div & 1))

Drop useless parenthesis please.

> +               ++settings->hs_div;
> +       /* Calculate VCO frequency (in 10..12GHz range) */
> +       vco = (u64)ls_freq * settings->hs_div;
> +       /* Calculate the integer part of the feedback divider */
> +       tmp = do_div(vco, FXO);
> +       settings->fb_div_int = vco;
> +       /* And the fractional bits using the remainder */
> +       vco = (u64)tmp << 32;
> +       do_div(vco, FXO);
> +       settings->fb_div_frac = vco;

This is all packed together. Please add a newline before each comment to
make it easier to read.

> +
> +       return 0;
> +}
> +
> +/* Calculate resulting frequency given the register settings */
> +static unsigned long si544_calc_rate(struct clk_si544_muldiv *settings)
> +{
> +       u32 d = settings->hs_div * BIT(settings->ls_div_bits);
> +       u64 vco;
> +
> +       /* Calculate VCO while preventing overflow */
> +       vco = (u64)settings->fb_div_int * FXO;
> +       vco += (((u64)settings->fb_div_frac * FXO) + (FXO / 2)) >> 32;

Yay for the smatch checking stuff on the list! Try to put things on more
lines to keep stuff easier to follow.

> +
> +       do_div(vco, d);
> +
> +       return vco;
> +}
> +
> +static unsigned long si544_recalc_rate(struct clk_hw *hw,
> +               unsigned long parent_rate)
> +{
> +       struct clk_si544 *data = to_clk_si544(hw);
> +       struct clk_si544_muldiv settings;
> +       int err;
> +
> +       err = si544_get_muldiv(data, &settings);
> +       if (err) {
> +               dev_err(&data->i2c_client->dev, "unable to retrieve settings\n");

This error message could become quite spammy given that we typically
call recalc_rate() many times.

> +               return 0;
> +       }
> +
> +       return si544_calc_rate(&settings);
> +}
> +
> +static long si544_round_rate(struct clk_hw *hw, unsigned long rate,
> +               unsigned long *parent_rate)
> +{
> +       struct clk_si544 *data = to_clk_si544(hw);
> +       struct clk_si544_muldiv settings;
> +       int err;
> +
> +       if (!rate)
> +               return 0;

Why? Do certain drivers call round_rate() with 0 and we want to ignore
those cases and not return an error?

> +
> +       if (!is_valid_frequency(data, rate))
> +               return -EINVAL;
> +
> +       err = si544_calc_muldiv(&settings, rate);
> +       if (err)
> +               return err;
> +
> +       return si544_calc_rate(&settings);
> +}
> +
> +
[...]
> +
> +static int si544_probe(struct i2c_client *client,
> +               const struct i2c_device_id *id)
> +{
> +       struct clk_si544 *data;
> +       struct clk_init_data init;
> +       int err;
> +
> +       data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       init.ops = &si544_clk_ops;
> +       init.flags = 0;
> +       init.num_parents = 0;
> +       data->hw.init = &init;
> +       data->i2c_client = client;
> +       data->speed_grade = id->driver_data;
> +
> +       if (of_property_read_string(client->dev.of_node, "clock-output-names",
> +                       &init.name))
> +               init.name = client->dev.of_node->name;
> +
> +       data->regmap = devm_regmap_init_i2c(client, &si544_regmap_config);
> +       if (IS_ERR(data->regmap)) {
> +               dev_err(&client->dev, "failed to allocate register map\n");

Do we need another allocation failure message?

> +               return PTR_ERR(data->regmap);
> +       }
> +
> +       i2c_set_clientdata(client, data);
> +
> +       /* Select page 0, just to be sure, there appear to be no more */
> +       err = regmap_write(data->regmap, SI544_REG_PAGE_SELECT, 0);
> +       if (err < 0)
> +               return err;
> +
> +       err = devm_clk_hw_register(&client->dev, &data->hw);
> +       if (err) {
> +               dev_err(&client->dev, "clock registration failed\n");
> +               return err;
> +       }
> +       err = of_clk_add_hw_provider(client->dev.of_node, of_clk_hw_simple_get,

devm_of_clk_add_hw_provider()?

> +                                    &data->hw);
> +       if (err) {
> +               dev_err(&client->dev, "unable to add clk provider\n");
> +               return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static int si544_remove(struct i2c_client *client)
> +{
> +       of_clk_del_provider(client->dev.of_node);
> +       return 0;
> +}

Drop?
