Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751381AbeBUWUr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 17:20:47 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44069 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbeBUWUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 17:20:44 -0500
X-Google-Smtp-Source: AH8x226BBBEcvWLeaU3yODW0d8cphtx7DTajkyCP4Nx35BQGt55fSuTeYABD7iTuBM81GXJzV8AfKp8u3l6bR3LCAQg=
MIME-Version: 1.0
In-Reply-To: <20180221214654.3306-3-florian.vaussard@gmail.com>
References: <20180221214654.3306-1-florian.vaussard@gmail.com> <20180221214654.3306-3-florian.vaussard@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 22 Feb 2018 00:20:43 +0200
Message-ID: <CAHp75VfYA-nnPd=MFPV1kUKfVmqzSrKqYUrFeoe=UuWShzN2wA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] leds: Add driver for NCP5623 3-channel I2C LED driver
To: Florian Vaussard <florian.vaussard@gmail.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 11:46 PM, Florian Vaussard
<florian.vaussard@gmail.com> wrote:
> The NCP5623 is a 3-channel LED driver from On Semiconductor controlled
> through I2C. The PWM of each channel can be independently set with 32
> distinct levels. In addition, the intensity of the current source can be
> globally set using an external bias resistor fixing the reference
> current (Iref) and a dedicated register (ILED), following the
> relationship:
>
> I = 2400*Iref/(31-ILED)
>
> with Iref = Vref/Rbias, and Vref = 0.6V.

First of all, why it's rebased on top of v4.15 while we have v4.16-rc2 already?

> +/*
> + * Copyright 2018 Florian Vaussard <florian.vaussard@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0
> + */

Check license-rules.rst.


> +#define NCP5623_CMD_SHIFT      5
> +#define CMD_SHUTDOWN           (0x00 << NCP5623_CMD_SHIFT)
> +#define CMD_ILED               (0x01 << NCP5623_CMD_SHIFT)
> +#define CMD_PWM1               (0x02 << NCP5623_CMD_SHIFT)
> +#define CMD_PWM2               (0x03 << NCP5623_CMD_SHIFT)
> +#define CMD_PWM3               (0x04 << NCP5623_CMD_SHIFT)
> +#define CMD_UPWARD_DIM         (0x05 << NCP5623_CMD_SHIFT)
> +#define CMD_DOWNWARD_DIM       (0x06 << NCP5623_CMD_SHIFT)
> +#define CMD_DIM_STEP           (0x07 << NCP5623_CMD_SHIFT)

Just put 5 instead. My eyes hurts by above.

> +#define LED_TO_PWM_CMD(led)    ((0x02 + led - 1) << NCP5623_CMD_SHIFT)

led -> (led)

> +
> +#define NCP5623_DATA_MASK      GENMASK(NCP5623_CMD_SHIFT - 1, 0)

While here is OK.

> +static struct ncp5623_led *ldev_to_led(struct led_classdev *ldev)

More usual pattern is
to_ncp5623_led()

> +       return (err < 0 ? err : 0);

Where this style comes from?
I mean redundant parens.

> +       err = of_property_read_u32(np, "onnn,led-iref-microamp",
> +                                  &priv->led_iref);

Don't we have some generic property for iref:s?

> +static int ncp5623_probe(struct i2c_client *client,
> +                        const struct i2c_device_id *id)
> +{
> +       struct device *dev = &client->dev;
> +       struct device_node *np = dev->of_node;
> +       struct ncp5623_priv *priv;
> +       int err;
> +
> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->client = client;
> +       i2c_set_clientdata(client, priv);
> +
> +       err = ncp5623_parse_dt(priv, np);
> +       if (err)
> +               return err;
> +

> +       return ncp5623_configure(dev, priv);

This sounds wrong.
You call configure while it does two unrelated things: configure + registration.

Name it properly and move closer to ->probe().

> +static const struct i2c_device_id ncp5623_id[] = {
> +       { "ncp5623" },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(i2c, ncp5623_id);

Do you really need this?
Consider to switch to ->probe_new().

> +               .of_match_table = of_match_ptr(ncp5623_of_match),

Here you will get a compiler warning.
Remove this pointless of_match_ptr().

-- 
With Best Regards,
Andy Shevchenko
