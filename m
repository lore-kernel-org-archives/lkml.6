Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbeFEN6q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:58:46 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39195 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeFEN6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:58:44 -0400
X-Google-Smtp-Source: ADUXVKLVjQeZlrPrNjzH6h/kWga1vAyXa8OryikS8ugWtPTS+7D3lmTQRoGGPnx1a/+61hSB8ABBjvFGOxOkXF6SRZw=
MIME-Version: 1.0
In-Reply-To: <68b0cf2c7ab5578eef2f71a33315bc8ab9a68a39.1527587295.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1527587295.git.matti.vaittinen@fi.rohmeurope.com> <68b0cf2c7ab5578eef2f71a33315bc8ab9a68a39.1527587295.git.matti.vaittinen@fi.rohmeurope.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Jun 2018 16:58:43 +0300
Message-ID: <CAHp75VeVSbZd12vXew9f0z2m1=BFz+cOKomga3SZEzg=kx9CFw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] regulator: bd71837: BD71837 PMIC regulator driver
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        mazziesaccount@gmail.com, linux-clk@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 1:02 PM, Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:
> Support for controlling the 8 bucks and 7 LDOs the PMIC contains.

> +#include <linux/kernel.h>

> +#include <linux/module.h>
> +#include <linux/init.h>

One of these is redundant.

> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/gpio.h>
> +#include <linux/mfd/bd71837.h>
> +#include <linux/regulator/of_regulator.h>

Can you keep the list ordered?

> +       dev_dbg(&(pmic->pdev->dev), "Buck[%d] Set Ramp = %d\n", id + 1,
> +               ramp_delay);

Redundant parens.

> +static int bd71837_regulator_set_regmap(struct regulator_dev *rdev, int set)
> +{

> +       int ret = -EINVAL;

Redundant assignment.

> +       if (!set)
> +               ret = regulator_disable_regmap(rdev);
> +       else
> +               ret = regulator_enable_regmap(rdev);

> +       return ret;
> +}

> +static int bd71837_probe(struct platform_device *pdev)
> +{

> +       pmic = devm_kzalloc(&pdev->dev, sizeof(struct bd71837_pmic),
> +                           GFP_KERNEL);

sizeof(*pmic) and one line as result?

> +       if (!pmic)
> +               return -ENOMEM;

> +       if (!pmic->mfd) {
> +               dev_err(&pdev->dev, "No MFD driver data\n");

> +               err = -EINVAL;
> +               goto err;

Plain return?

> +       }

> +               dev_dbg(&pmic->pdev->dev, "%s: Unlocked lock register 0x%x\n",
> +                       __func__, BD71837_REG_REGLOCK);

__func__ part is redundant.

> +       for (i = 0; i < ARRAY_SIZE(pmic_regulator_inits); i++) {

> +

Redundant blank line.

> +               rdev = devm_regulator_register(&pdev->dev, desc, &config);
> +               if (IS_ERR(rdev)) {
> +                       dev_err(pmic->mfd->dev,
> +                               "failed to register %s regulator\n",
> +                               desc->name);

> +                       err = PTR_ERR(rdev);
> +                       goto err;

Plain return ...

> +err:
> +       return err;

Redundant.

> +}

> +static struct platform_driver bd71837_regulator = {
> +       .driver = {
> +                  .name = "bd71837-pmic",

> +                  .owner = THIS_MODULE,

This done by macro you are using below. Thus, redundant.

> +                  },
> +       .probe = bd71837_probe,
> +};
> +
> +module_platform_driver(bd71837_regulator);

-- 
With Best Regards,
Andy Shevchenko
