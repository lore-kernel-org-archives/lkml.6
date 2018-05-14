Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752585AbeENLtj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:49:39 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:45636 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752148AbeENLte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:49:34 -0400
X-Google-Smtp-Source: AB8JxZpF9m+X6Mu4lgIY++dPAO89ZlwCVlhQLyeXvFrSB/YlJSaZ/mtLbdbydTVtlPsLAv4VxsUUbOfKokC8D4IeNjQ=
MIME-Version: 1.0
In-Reply-To: <20180514080640.12515-2-linus.walleij@linaro.org>
References: <20180514080640.12515-1-linus.walleij@linaro.org> <20180514080640.12515-2-linus.walleij@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 May 2018 13:49:33 +0200
X-Google-Sender-Auth: A-aKbW5c1W_i83GMfO733YD3qJA
Message-ID: <CAMuHMdUa8Hp-FP8iqKAEKbeEvbd34NjaDyxpNedV_QjvV+mivg@mail.gmail.com>
Subject: Re: [PATCH 01/19 v3] regulator: fixed: Convert to use GPIO descriptor only
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Daniel Mack <zonque@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Jacopo Mondi <jacopo@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, May 14, 2018 at 10:06 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> As we augmented the regulator core to accept a GPIO descriptor instead
> of a GPIO number, we can augment the fixed GPIO regulator to look up
> and pass that descriptor directly from device tree or board GPIO
> descriptor look up tables.
>
> Some boards just auto-enumerate their fixed regulator platform devices
> and I have assumed they get names like "fixed-regulator.0" but it's
> pretty hard to guess this. I need some testing from board maintainers to
> be sure. Other boards are straight forward, using just plain
> "fixed-regulator" (ID -1) or "fixed-regulator.1" hammering down the
> device ID.
>
> The OMAP didn't have proper label names on its GPIO chips so I have fixed
> this with a separate patch to the GPIO tree, see
> commit 088413bc0bd5f5fb66ca22a19d66a49d7154ba4c
> "gpio: omap: Give unique labels to each GPIO bank/chip"
>
> It seems the da9055 and da9211 has never got around to actually passing
> any enable gpio into its platform data (not the in-tree code anyway) so we
> can just decide to simply pass a descriptor instead.
>
> The fixed GPIO-controlled regulator in mach-pxa/ezx.c was confusingly named
> "*_dummy_supply_device" while it is a very real device backed by a GPIO
> line. There is nothing dummy about it at all, so I renamed it with the
> infix *_regulator_* as part of this patch set.
>
> For the patch hunk hitting arch/blackfin I would say I do not expect
> testing, review or ACKs anymore so if it works, it works.
>
> The hunk hitting the x86 BCM43xx driver is especially tricky as the number
> comes out of SFI which is a mystery to me. I definately need someone to
> look at this. (Hi Andy.)

Thanks for your patch!

> Cc: Geert Uytterhoeven <geert+renesas@glider.be> # SuperH pinctrl/GPIO maintainer

IIRC, Jacopo (CC) has an Ecovec24.

> --- a/arch/sh/boards/mach-ecovec24/setup.c
> +++ b/arch/sh/boards/mach-ecovec24/setup.c
> @@ -633,7 +633,6 @@ static struct regulator_init_data cn12_power_init_data = {
>  static struct fixed_voltage_config cn12_power_info = {
>         .supply_name = "CN12 SD/MMC Vdd",
>         .microvolts = 3300000,
> -       .gpio = GPIO_PTB7,
>         .enable_high = 1,
>         .init_data = &cn12_power_init_data,
>  };
> @@ -646,6 +645,16 @@ static struct platform_device cn12_power = {
>         },
>  };
>
> +static struct gpiod_lookup_table cn12_power_gpiod_table = {
> +       .dev_id = "reg-fixed-voltage.0",
> +       .table = {
> +               /* Offset 7 on port B */
> +               GPIO_LOOKUP("sh7724_pfc", GPIO_PTB7,
> +                           "enable", GPIO_ACTIVE_HIGH),
> +               { },
> +       },
> +};
> +
>  #if defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
>  /* SDHI0 */
>  static struct regulator_consumer_supply sdhi0_power_consumers[] =
> @@ -665,7 +674,6 @@ static struct regulator_init_data sdhi0_power_init_data = {
>  static struct fixed_voltage_config sdhi0_power_info = {
>         .supply_name = "CN11 SD/MMC Vdd",
>         .microvolts = 3300000,
> -       .gpio = GPIO_PTB6,
>         .enable_high = 1,
>         .init_data = &sdhi0_power_init_data,
>  };
> @@ -678,6 +686,16 @@ static struct platform_device sdhi0_power = {
>         },
>  };
>
> +static struct gpiod_lookup_table sdhi0_power_gpiod_table = {
> +       .dev_id = "reg-fixed-voltage.1",
> +       .table = {
> +               /* Offset 6 on port B */
> +               GPIO_LOOKUP("sh7724_pfc", GPIO_PTB6,
> +                           "enable", GPIO_ACTIVE_HIGH),
> +               { },
> +       },
> +};
> +
>  static struct tmio_mmc_data sdhi0_info = {
>         .chan_priv_tx   = (void *)SHDMA_SLAVE_SDHI0_TX,
>         .chan_priv_rx   = (void *)SHDMA_SLAVE_SDHI0_RX,

No calls to gpiod_add_lookup_table() to add to arch_setup()?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
