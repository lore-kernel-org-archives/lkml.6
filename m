Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753659AbeBZOMK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:12:10 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:45423 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753521AbeBZOLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:11:14 -0500
X-Google-Smtp-Source: AG47ELuQuSSqIlXWbmpCswYGobg2w0KkQMdoLu1p8h7h1kzTp4/Fd03rk9UJJV7Cza6G6AC7uDhdyE018nsHIquYXqc=
MIME-Version: 1.0
In-Reply-To: <20180226130558.7634-4-rf@opensource.cirrus.com>
References: <20180226130558.7634-1-rf@opensource.cirrus.com> <20180226130558.7634-4-rf@opensource.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Feb 2018 16:11:13 +0200
Message-ID: <CAHp75VdQtLKfSR5fhxxGJfa0j8h-vKT3YLDRTt0Khxe1UKzknw@mail.gmail.com>
Subject: Re: [PATCH v8 3/9] mfd: madera: Add common support for Cirrus Logic
 Madera codecs
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, patches@opensource.cirrus.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 3:05 PM, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
> This adds the generic core support for Cirrus Logic "Madera" class codecs.
> These are complex audio codec SoCs with a variety of digital and analogue
> I/O, onboard audio processing and DSPs, and other features.
>
> These codecs are all based off a common set of hardware IP so can be
> supported by a core of common code (with a few minor device-to-device
> variations).


> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; version 2.

This is redundant.

> +static void madera_enable_hard_reset(struct madera *madera)
> +{
> +       if (madera->reset_gpio)

if (!...)
 return

> +               gpiod_set_value_cansleep(madera->reset_gpio, 0);
> +}
> +
> +static void madera_disable_hard_reset(struct madera *madera)
> +{
> +       if (madera->reset_gpio) {

Ditto.

> +               gpiod_set_value_cansleep(madera->reset_gpio, 1);
> +               usleep_range(1000, 2000);
> +       }
> +}
> +

> +#ifdef CONFIG_PM

__maybe_unused


> +const struct dev_pm_ops madera_pm_ops = {
> +       SET_RUNTIME_PM_OPS(madera_runtime_suspend,
> +                          madera_runtime_resume,
> +                          NULL)
> +};

There is a macro helper for this I believe.

> +const struct of_device_id madera_of_match[] = {
> +       { .compatible = "cirrus,cs47l35", .data = (void *)CS47L35 },
> +       { .compatible = "cirrus,cs47l85", .data = (void *)CS47L85 },
> +       { .compatible = "cirrus,cs47l90", .data = (void *)CS47L90 },
> +       { .compatible = "cirrus,cs47l91", .data = (void *)CS47L91 },
> +       { .compatible = "cirrus,wm1840", .data = (void *)WM1840 },

> +       {},

No comma.

> +};


> +               ret = devm_gpio_request_one(madera->dev,
> +                                           madera->pdata.reset,
> +                                           GPIOF_DIR_OUT | GPIOF_INIT_LOW,
> +                                           "madera reset");
> +               if (!ret)
> +                       madera->reset_gpio = gpio_to_desc(madera->pdata.reset);

Why? What's wrong with descriptors?

> +       dev_set_drvdata(madera->dev, madera);
...
> +       if (dev_get_platdata(madera->dev))

What this dance for?

> +       ret = mfd_add_devices(madera->dev, PLATFORM_DEVID_NONE,
> +                             mfd_devs, n_devs,
> +                             NULL, 0, NULL);

devm_?

> +       if (i2c->dev.of_node) {
> +               of_id = of_match_device(madera_of_match, &i2c->dev);
> +               if (of_id)
> +                       type = (unsigned long)of_id->data;
> +       } else {
> +               type = id->driver_data;
> +       }

> +       if (spi->dev.of_node) {
> +               of_id = of_match_device(madera_of_match, &spi->dev);
> +               if (of_id)
> +                       type = (unsigned long)of_id->data;

There is a helper to get match data.

> +       } else {
> +               type = id->driver_data;
> +       }

> +struct madera_irqchip_pdata;
> +struct madera_codec_pdata;


Why do you need platform data in new code?

> + * @reset:         GPIO controlling /RESET (0 = none)

Shouldn't be descriptor?

-- 
With Best Regards,
Andy Shevchenko
