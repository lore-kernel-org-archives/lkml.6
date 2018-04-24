Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756776AbeDXL1z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 07:27:55 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:44872 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752947AbeDXL1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 07:27:52 -0400
X-Google-Smtp-Source: AIpwx4+/1W88D7STGIStU4fFbQtiZJbuYI3im+DKMWQpQ6hygIokk7OZHtdIhDniWiZQRvUC7n6g57YlnsbJ9fxQiOk=
MIME-Version: 1.0
In-Reply-To: <1523974819-8711-1-git-send-email-abel.vesa@nxp.com>
References: <1523974819-8711-1-git-send-email-abel.vesa@nxp.com>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Tue, 24 Apr 2018 13:27:50 +0200
Message-ID: <CAFqH_53sRoti07Tfc5V+F9ojSOUgi4+Q-JaJRFe3uirDQfbmDA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mfd: pf1550: add pf1550 mfd driver
To: Abel Vesa <abel.vesa@nxp.com>
Cc: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>,
        Robin Gong <yibin.gong@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>, linux-imx@nxp.com,
        Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

Thanks for the patch. I am not the maintainer nor an official reviewer
but I submitted some patches in the mfd system and below is a review
based on some comments I received when I posted a driver. So hope will
be helpful for you.

2018-04-17 16:20 GMT+02:00 Abel Vesa <abel.vesa@nxp.com>:
> From: Robin Gong <b38343@freescale.com>
>
> Add basic pf1550 mfd driver.
>

For new drivers a better explanation of what the chip is and what
supports is appreciable ;)

> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/mfd/Kconfig        |  14 +++
>  drivers/mfd/Makefile       |   2 +
>  drivers/mfd/pf1550.c       | 282 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/pf1550.h | 241 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 539 insertions(+)
>  create mode 100644 drivers/mfd/pf1550.c
>  create mode 100644 include/linux/mfd/pf1550.h
>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index b860eb5..5acd239 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -404,6 +404,20 @@ config MFD_MX25_TSADC
>           i.MX25 processors. They consist of a conversion queue for general
>           purpose ADC and a queue for Touchscreens.
>
> +config MFD_PF1550
> +       tristate "Freescale Semiconductor PF1550 PMIC Support"
> +       depends on I2C=y
> +       select MFD_CORE
> +       select REGMAP_I2C
> +       select REGMAP_IRQ
> +       help
> +         Say yes here to add support for Freescale Semiconductor PF1550.
> +         This is a companion Power Management IC with regulators, ONKEY,
> +         and charger control on chip.
> +         This driver provides common support for accessing the device;
> +         additional drivers must be enabled in order to use the functionality
> +         of the device.
> +
>  config MFD_HI6421_PMIC
>         tristate "HiSilicon Hi6421 PMU/Codec IC"
>         depends on OF
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index e9fd20d..b8ac19b 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -97,6 +97,8 @@ obj-$(CONFIG_MFD_MC13XXX)     += mc13xxx-core.o
>  obj-$(CONFIG_MFD_MC13XXX_SPI)  += mc13xxx-spi.o
>  obj-$(CONFIG_MFD_MC13XXX_I2C)  += mc13xxx-i2c.o
>
> +obj-$(CONFIG_MFD_PF1550)       += pf1550.o
> +
>  obj-$(CONFIG_MFD_CORE)         += mfd-core.o
>
>  obj-$(CONFIG_EZX_PCAP)         += ezx-pcap.o
> diff --git a/drivers/mfd/pf1550.c b/drivers/mfd/pf1550.c
> new file mode 100644
> index 0000000..70817ef
> --- /dev/null
> +++ b/drivers/mfd/pf1550.c
> @@ -0,0 +1,282 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * pf1550.c - mfd core driver for the PF1550
> + *
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Robin Gong <yibin.gong@freescale.com>
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
> + *

I think that the general consensus is to remove the GPL notice once
you have added the SPDX License Identifier. So this notice is not
required.

> + * This driver is based on max77693.c
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/pf1550.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +
> +static const struct mfd_cell pf1550_devs[] = {
> +       {
> +               .name = "pf1550-regulator",
> +               .of_compatible = "fsl,pf1550-regulator",
> +       },

Is the pf1550-regulator submitted to upstream? I did not find it, I
think that is better introduce this compatible when the driver and the
documentation is in place.

> +       {
> +               .name = "pf1550-onkey",
> +               .of_compatible = "fsl,pf1550-onkey",
> +       },

Same here.

> +       {
> +               .name = "pf1550-charger",
> +               .of_compatible = "fsl,pf1550-charger",
> +       },
> +};
> +

Ok, I see that you submitted the driver in this series, the
documentation is also missing.

> +static const struct regmap_config pf1550_regmap_config = {
> +       .reg_bits = 8,
> +       .val_bits = 8,
> +       .max_register = PF1550_PMIC_REG_END,
> +};
> +
> +static const struct regmap_irq pf1550_regulator_irqs[] = {
> +       { .reg_offset = 0, .mask = PMIC_IRQ_SW1_LS,             },
> +       { .reg_offset = 0, .mask = PMIC_IRQ_SW2_LS,             },
> +       { .reg_offset = 0, .mask = PMIC_IRQ_SW3_LS,             },
> +
> +       { .reg_offset = 3, .mask = PMIC_IRQ_SW1_HS,             },
> +       { .reg_offset = 3, .mask = PMIC_IRQ_SW2_HS,             },
> +       { .reg_offset = 3, .mask = PMIC_IRQ_SW3_HS,             },
> +
> +       { .reg_offset = 16, .mask = PMIC_IRQ_LDO1_FAULT,        },
> +       { .reg_offset = 16, .mask = PMIC_IRQ_LDO2_FAULT,        },
> +       { .reg_offset = 16, .mask = PMIC_IRQ_LDO3_FAULT,        },
> +
> +       { .reg_offset = 22, .mask = PMIC_IRQ_TEMP_110,  },
> +       { .reg_offset = 22, .mask = PMIC_IRQ_TEMP_125,  },
> +};
> +
> +static const struct regmap_irq_chip pf1550_regulator_irq_chip = {
> +       .name                   = "pf1550-regulator",
> +       .status_base            = PF1550_PMIC_REG_SW_INT_STAT0,
> +       .mask_base              = PF1550_PMIC_REG_SW_INT_MASK0,
> +       .mask_invert            = false,
> +       .num_regs               = 4,
> +       .irqs                   = pf1550_regulator_irqs,
> +       .num_irqs               = ARRAY_SIZE(pf1550_regulator_irqs),
> +};
> +
> +static const struct regmap_irq pf1550_onkey_irqs[] = {
> +       { .reg_offset = 0, .mask = ONKEY_IRQ_PUSHI,             },
> +       { .reg_offset = 0, .mask = ONKEY_IRQ_1SI,               },
> +       { .reg_offset = 0, .mask = ONKEY_IRQ_2SI,               },
> +       { .reg_offset = 0, .mask = ONKEY_IRQ_3SI,               },
> +       { .reg_offset = 0, .mask = ONKEY_IRQ_4SI,               },
> +       { .reg_offset = 0, .mask = ONKEY_IRQ_8SI,               },
> +};
> +
> +static const struct regmap_irq_chip pf1550_onkey_irq_chip = {
> +       .name                   = "pf1550-onkey",
> +       .status_base            = PF1550_PMIC_REG_ONKEY_INT_STAT0,
> +       .mask_base              = PF1550_PMIC_REG_ONKEY_INT_MASK0,
> +       .mask_invert            = false,
> +       .num_regs               = 1,
> +       .irqs                   = pf1550_onkey_irqs,
> +       .num_irqs               = ARRAY_SIZE(pf1550_onkey_irqs),
> +};
> +
> +static const struct regmap_irq pf1550_charger_irqs[] = {
> +       { .reg_offset = 0, .mask = CHARG_IRQ_BAT2SOCI,          },
> +       { .reg_offset = 0, .mask = CHARG_IRQ_BATI,              },
> +       { .reg_offset = 0, .mask = CHARG_IRQ_CHGI,              },
> +       { .reg_offset = 0, .mask = CHARG_IRQ_VBUSI,             },
> +       { .reg_offset = 0, .mask = CHARG_IRQ_DPMI,              },
> +       { .reg_offset = 0, .mask = CHARG_IRQ_THMI,              },
> +};
> +

nit: In general, the latest field and the latest element do not should
have the comma.

> +static const struct regmap_irq_chip pf1550_charger_irq_chip = {
> +       .name                   = "pf1550-charger",
> +       .status_base            = PF1550_CHARG_REG_CHG_INT,
> +       .mask_base              = PF1550_CHARG_REG_CHG_INT_MASK,
> +       .mask_invert            = false,
> +       .num_regs               = 1,
> +       .irqs                   = pf1550_charger_irqs,
> +       .num_irqs               = ARRAY_SIZE(pf1550_charger_irqs),
> +};
> +
> +static int pf1550_i2c_probe(struct i2c_client *i2c,
> +                           const struct i2c_device_id *id)

nit: Here and in other places alignment should match open parenthesis

> +{
> +       struct pf1550_dev *pf1550;
> +       unsigned int reg_data = 0;
> +       int ret = 0;
> +
> +       pf1550 = devm_kzalloc(&i2c->dev,
> +                       sizeof(struct pf1550_dev), GFP_KERNEL);

Alignment should match open parenthesis again.

IMHO is a good idea running checkpatch with --strict, you will catch
these things.

> +       if (!pf1550)
> +               return -ENOMEM;
> +
> +       i2c_set_clientdata(i2c, pf1550);
> +       pf1550->dev = &i2c->dev;
> +       pf1550->i2c = i2c;
> +       pf1550->irq = i2c->irq;
> +
> +       pf1550->regmap = devm_regmap_init_i2c(i2c, &pf1550_regmap_config);
> +       if (IS_ERR(pf1550->regmap)) {
> +               ret = PTR_ERR(pf1550->regmap);
> +               dev_err(pf1550->dev, "failed to allocate register map: %d\n",
> +                               ret);
> +               return ret;
> +       }
> +
> +       ret = regmap_read(pf1550->regmap, PF1550_PMIC_REG_DEVICE_ID, &reg_data);
> +       if (ret < 0 || reg_data != 0x7c) {
> +               dev_err(pf1550->dev, "device not found!\n");
> +               return ret;
> +       }
> +
> +       pf1550->type = PF1550;
> +       dev_info(pf1550->dev, "pf1550 found.\n");
> +
> +       ret = regmap_add_irq_chip(pf1550->regmap, pf1550->irq,
> +                               IRQF_ONESHOT | IRQF_SHARED |
> +                               IRQF_TRIGGER_FALLING, 0,
> +                               &pf1550_regulator_irq_chip,
> +                               &pf1550->irq_data_regulator);
> +       if (ret) {
> +               dev_err(pf1550->dev, "failed to add irq1 chip: %d\n", ret);
> +               goto err_regulator_irq;
> +       }
> +
> +       ret = regmap_add_irq_chip(pf1550->regmap, pf1550->irq,
> +                               IRQF_ONESHOT | IRQF_SHARED |
> +                               IRQF_TRIGGER_FALLING, 0,
> +                               &pf1550_onkey_irq_chip,
> +                               &pf1550->irq_data_onkey);

Use the device managed version devm_regmap_add_irq_chip

> +       if (ret) {
> +               dev_err(pf1550->dev, "failed to add irq3 chip: %d\n", ret);
> +               goto err_onkey_irq;
> +       }
> +
> +       ret = regmap_add_irq_chip(pf1550->regmap, pf1550->irq,
> +                               IRQF_ONESHOT | IRQF_SHARED |
> +                               IRQF_TRIGGER_FALLING, 0,
> +                               &pf1550_charger_irq_chip,
> +                               &pf1550->irq_data_charger);

Use the device managed version devm_regmap_add_irq_chip

> +       if (ret) {
> +               dev_err(pf1550->dev, "failed to add irq4 chip: %d\n", ret);
> +               goto err_charger_irq;
> +       }
> +
> +       ret = mfd_add_devices(pf1550->dev, -1, pf1550_devs,
> +                             ARRAY_SIZE(pf1550_devs), NULL, 0, NULL);

You can use the managed version devm_mfd_add_devices.

Also, -1 has his own define which is PLATFORM_DEVID_NONE, use that instead.


> +       if (ret < 0)
> +               goto err_mfd;
> +
> +       return ret;
> +
> +err_mfd:
> +       mfd_remove_devices(pf1550->dev);
> +err_charger_irq:
> +       regmap_del_irq_chip(pf1550->irq, pf1550->irq_data_charger);
> +err_onkey_irq:
> +       regmap_del_irq_chip(pf1550->irq, pf1550->irq_data_regulator);
> +err_regulator_irq:
> +       return ret;

All this error handling can be simplified using the device managed versions.

> +}
> +
> +static int pf1550_i2c_remove(struct i2c_client *i2c)
> +{
> +       struct pf1550_dev *pf1550 = i2c_get_clientdata(i2c);
> +
> +       mfd_remove_devices(pf1550->dev);
> +
> +       regmap_del_irq_chip(pf1550->irq, pf1550->irq_data_regulator);
> +       regmap_del_irq_chip(pf1550->irq, pf1550->irq_data_onkey);
> +       regmap_del_irq_chip(pf1550->irq, pf1550->irq_data_charger);
> +
> +       return 0;
> +}
> +

The full function can be remove after move to device managed version
of these functions.


> +static const struct i2c_device_id pf1550_i2c_id[] = {
> +       { "pf1550", PF1550 },
> +       { }

Adding sentinel is a good practice

{ /* sentinel */ }

> +};
> +MODULE_DEVICE_TABLE(i2c, pf1550_i2c_id);
> +
> +static int pf1550_suspend(struct device *dev)
> +{
> +       struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
> +       struct pf1550_dev *pf1550 = i2c_get_clientdata(i2c);
> +
> +       if (device_may_wakeup(dev)) {
> +               enable_irq_wake(pf1550->irq);
> +               disable_irq(pf1550->irq);
> +       }
> +
> +       return 0;
> +}
> +
> +static int pf1550_resume(struct device *dev)
> +{
> +       struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
> +       struct pf1550_dev *pf1550 = i2c_get_clientdata(i2c);
> +
> +       if (device_may_wakeup(dev)) {
> +               disable_irq_wake(pf1550->irq);
> +               enable_irq(pf1550->irq);
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops pf1550_pm = {
> +       .suspend = pf1550_suspend,
> +       .resume = pf1550_resume,
> +};
> +

Replace this with SIMPLE_DEV_PM_OPS helper macro.

> +#ifdef CONFIG_OF
> +static const struct of_device_id pf1550_dt_match[] = {
> +       { .compatible = "fsl,pf1550" },

"fsl,pf1550" appears un-documented. You need to add the documentation
binding for this.

> +       {},

Add sentinel and remove the comma.

{ /* sentinel */ }

> +};

Guess you are missing the module device table here.

MODULE_DEVICE_TABLE(of, pf1550_dt_match);

> +#endif
> +
> +static struct i2c_driver pf1550_i2c_driver = {
> +       .driver = {
> +                  .name = "pf1550",
> +                  .owner = THIS_MODULE,

An i2c driver does not need the owner, the core does it for you, so
you can remove this field.

> +                  .pm = &pf1550_pm,
> +                  .of_match_table = of_match_ptr(pf1550_dt_match),
> +       },
> +       .probe = pf1550_i2c_probe,
> +       .remove = pf1550_i2c_remove,
> +       .id_table = pf1550_i2c_id,
> +};
> +
> +static int __init pf1550_i2c_init(void)
> +{
> +       return i2c_add_driver(&pf1550_i2c_driver);
> +}
> +/* init early so consumer devices can complete system boot */
> +subsys_initcall(pf1550_i2c_init);
> +
> +static void __exit pf1550_i2c_exit(void)
> +{
> +       i2c_del_driver(&pf1550_i2c_driver);
> +}
> +module_exit(pf1550_i2c_exit);
> +

If I am not wrong subsys_initcall is guaranteed to be executed before
the procedure declared as module_init, but this only makes sense when
the driver is built-in. Your driver can be built as a module and I
think that should be possible as module, so I am wondering if you
really need to use the subsys_initcall here or if you can simply use
the helper macro for registering a modular I2C driver and remove the
__init and __exit functions.

module_i2c_driver(pf1550_i2c_driver);

> +MODULE_DESCRIPTION("Freescale PF1550 multi-function core driver");
> +MODULE_AUTHOR("Robin Gong <yibin.gong@freescale.com>");
> +MODULE_LICENSE("GPL");
> +
> diff --git a/include/linux/mfd/pf1550.h b/include/linux/mfd/pf1550.h
> new file mode 100644
> index 0000000..9721929
> --- /dev/null
> +++ b/include/linux/mfd/pf1550.h
> @@ -0,0 +1,241 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * pf1550.h - mfd head file for PF1550
> + *
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Robin Gong <yibin.gong@freescale.com>
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

Remove the GPL notice as you have already added the SPDX License Identifier.

> + */
> +
> +#ifndef __LINUX_MFD_PF1550_H
> +#define __LINUX_MFD_PF1550_H
> +
> +#include <linux/i2c.h>
> +
> +enum chips { PF1550 = 1, };
> +
> +enum pf1550_pmic_reg {
> +       /* PMIC regulator part */
> +       PF1550_PMIC_REG_DEVICE_ID               = 0x00,
> +       PF1550_PMIC_REG_OTP_FLAVOR              = 0x01,
> +       PF1550_PMIC_REG_SILICON_REV             = 0x02,
> +
> +       PF1550_PMIC_REG_INT_CATEGORY            = 0x06,
> +       PF1550_PMIC_REG_SW_INT_STAT0            = 0x08,
> +       PF1550_PMIC_REG_SW_INT_MASK0            = 0x09,
> +       PF1550_PMIC_REG_SW_INT_SENSE0           = 0x0A,
> +       PF1550_PMIC_REG_SW_INT_STAT1            = 0x0B,
> +       PF1550_PMIC_REG_SW_INT_MASK1            = 0x0C,
> +       PF1550_PMIC_REG_SW_INT_SENSE1           = 0x0D,
> +       PF1550_PMIC_REG_SW_INT_STAT2            = 0x0E,
> +       PF1550_PMIC_REG_SW_INT_MASK2            = 0x0F,
> +       PF1550_PMIC_REG_SW_INT_SENSE2           = 0x10,
> +       PF1550_PMIC_REG_LDO_INT_STAT0           = 0x18,
> +       PF1550_PMIC_REG_LDO_INT_MASK0           = 0x19,
> +       PF1550_PMIC_REG_LDO_INT_SENSE0          = 0x1A,
> +       PF1550_PMIC_REG_TEMP_INT_STAT0          = 0x20,
> +       PF1550_PMIC_REG_TEMP_INT_MASK0          = 0x21,
> +       PF1550_PMIC_REG_TEMP_INT_SENSE0         = 0x22,
> +       PF1550_PMIC_REG_ONKEY_INT_STAT0         = 0x24,
> +       PF1550_PMIC_REG_ONKEY_INT_MASK0         = 0x25,
> +       PF1550_PMIC_REG_ONKEY_INT_SENSE0        = 0x26,
> +       PF1550_PMIC_REG_MISC_INT_STAT0          = 0x28,
> +       PF1550_PMIC_REG_MISC_INT_MASK0          = 0x29,
> +       PF1550_PMIC_REG_MISC_INT_SENSE0         = 0x2A,
> +
> +       PF1550_PMIC_REG_COINCELL_CONTROL        = 0x30,
> +
> +       PF1550_PMIC_REG_SW1_VOLT                = 0x32,
> +       PF1550_PMIC_REG_SW1_STBY_VOLT           = 0x33,
> +       PF1550_PMIC_REG_SW1_SLP_VOLT            = 0x34,
> +       PF1550_PMIC_REG_SW1_CTRL                = 0x35,
> +       PF1550_PMIC_REG_SW1_CTRL1               = 0x36,
> +       PF1550_PMIC_REG_SW2_VOLT                = 0x38,
> +       PF1550_PMIC_REG_SW2_STBY_VOLT           = 0x39,
> +       PF1550_PMIC_REG_SW2_SLP_VOLT            = 0x3A,
> +       PF1550_PMIC_REG_SW2_CTRL                = 0x3B,
> +       PF1550_PMIC_REG_SW2_CTRL1               = 0x3C,
> +       PF1550_PMIC_REG_SW3_VOLT                = 0x3E,
> +       PF1550_PMIC_REG_SW3_STBY_VOLT           = 0x3F,
> +       PF1550_PMIC_REG_SW3_SLP_VOLT            = 0x40,
> +       PF1550_PMIC_REG_SW3_CTRL                = 0x41,
> +       PF1550_PMIC_REG_SW3_CTRL1               = 0x42,
> +       PF1550_PMIC_REG_VSNVS_CTRL              = 0x48,
> +       PF1550_PMIC_REG_VREFDDR_CTRL            = 0x4A,
> +       PF1550_PMIC_REG_LDO1_VOLT               = 0x4C,
> +       PF1550_PMIC_REG_LDO1_CTRL               = 0x4D,
> +       PF1550_PMIC_REG_LDO2_VOLT               = 0x4F,
> +       PF1550_PMIC_REG_LDO2_CTRL               = 0x50,
> +       PF1550_PMIC_REG_LDO3_VOLT               = 0x52,
> +       PF1550_PMIC_REG_LDO3_CTRL               = 0x53,
> +       PF1550_PMIC_REG_PWRCTRL0                = 0x58,
> +       PF1550_PMIC_REG_PWRCTRL1                = 0x59,
> +       PF1550_PMIC_REG_PWRCTRL2                = 0x5A,
> +       PF1550_PMIC_REG_PWRCTRL3                = 0x5B,
> +       PF1550_PMIC_REG_SW1_PWRDN_SEQ           = 0x5F,
> +       PF1550_PMIC_REG_SW2_PWRDN_SEQ           = 0x60,
> +       PF1550_PMIC_REG_SW3_PWRDN_SEQ           = 0x61,
> +       PF1550_PMIC_REG_LDO1_PWRDN_SEQ          = 0x62,
> +       PF1550_PMIC_REG_LDO2_PWRDN_SEQ          = 0x63,
> +       PF1550_PMIC_REG_LDO3_PWRDN_SEQ          = 0x64,
> +       PF1550_PMIC_REG_VREFDDR_PWRDN_SEQ       = 0x65,
> +
> +       PF1550_PMIC_REG_STATE_INFO              = 0x67,
> +       PF1550_PMIC_REG_I2C_ADDR                = 0x68,
> +       PF1550_PMIC_REG_IO_DRV0                 = 0x69,
> +       PF1550_PMIC_REG_IO_DRV1                 = 0x6A,
> +       PF1550_PMIC_REG_RC_16MHZ                = 0x6B,
> +       PF1550_PMIC_REG_KEY                     = 0x6F,
> +
> +       /* charger part */
> +       PF1550_CHARG_REG_CHG_INT                = 0x80,
> +       PF1550_CHARG_REG_CHG_INT_MASK           = 0x82,
> +       PF1550_CHARG_REG_CHG_INT_OK             = 0x84,
> +       PF1550_CHARG_REG_VBUS_SNS               = 0x86,
> +       PF1550_CHARG_REG_CHG_SNS                = 0x87,
> +       PF1550_CHARG_REG_BATT_SNS               = 0x88,
> +       PF1550_CHARG_REG_CHG_OPER               = 0x89,
> +       PF1550_CHARG_REG_CHG_TMR                = 0x8A,
> +       PF1550_CHARG_REG_CHG_EOC_CNFG           = 0x8D,
> +       PF1550_CHARG_REG_CHG_CURR_CNFG          = 0x8E,
> +       PF1550_CHARG_REG_BATT_REG               = 0x8F,
> +       PF1550_CHARG_REG_BATFET_CNFG            = 0x91,
> +       PF1550_CHARG_REG_THM_REG_CNFG           = 0x92,
> +       PF1550_CHARG_REG_VBUS_INLIM_CNFG        = 0x94,
> +       PF1550_CHARG_REG_VBUS_LIN_DPM           = 0x95,
> +       PF1550_CHARG_REG_USB_PHY_LDO_CNFG       = 0x96,
> +       PF1550_CHARG_REG_DBNC_DELAY_TIME        = 0x98,
> +       PF1550_CHARG_REG_CHG_INT_CNFG           = 0x99,
> +       PF1550_CHARG_REG_THM_ADJ_SETTING        = 0x9A,
> +       PF1550_CHARG_REG_VBUS2SYS_CNFG          = 0x9B,
> +       PF1550_CHARG_REG_LED_PWM                = 0x9C,
> +       PF1550_CHARG_REG_FAULT_BATFET_CNFG      = 0x9D,
> +       PF1550_CHARG_REG_LED_CNFG               = 0x9E,
> +       PF1550_CHARG_REG_CHGR_KEY2              = 0x9F,
> +
> +       PF1550_PMIC_REG_END                     = 0xff,
> +};
> +
> +#define PF1550_CHG_PRECHARGE           0
> +#define PF1550_CHG_CONSTANT_CURRENT    1
> +#define PF1550_CHG_CONSTANT_VOL                2
> +#define PF1550_CHG_EOC                 3
> +#define PF1550_CHG_DONE                        4
> +#define PF1550_CHG_TIMER_FAULT         6
> +#define PF1550_CHG_SUSPEND             7
> +#define PF1550_CHG_OFF_INV             8
> +#define PF1550_CHG_BAT_OVER            9
> +#define PF1550_CHG_OFF_TEMP            10
> +#define PF1550_CHG_LINEAR_ONLY         12
> +#define PF1550_CHG_SNS_MASK            0xf
> +
> +#define PF1550_BAT_NO_VBUS             0
> +#define PF1550_BAT_LOW_THAN_PRECHARG   1
> +#define PF1550_BAT_CHARG_FAIL          2
> +#define PF1550_BAT_HIGH_THAN_PRECHARG  4
> +#define PF1550_BAT_OVER_VOL            5
> +#define        PF1550_BAT_NO_DETECT            6
> +#define PF1550_BAT_SNS_MASK            0x7
> +
> +#define PF1550_VBUS_UVLO               BIT(2)
> +#define PF1550_VBUS_IN2SYS             BIT(3)
> +#define PF1550_VBUS_OVLO               BIT(4)
> +#define PF1550_VBUS_VALID              BIT(5)
> +
> +#define PF1550_CHARG_REG_BATT_REG_CHGCV_MASK           0x3f
> +#define PF1550_CHARG_REG_BATT_REG_VMINSYS_SHIFT                6
> +#define PF1550_CHARG_REG_BATT_REG_VMINSYS_MASK         0x3
> +#define PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_SHIFT    2
> +#define PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_MASK     0x3
> +
> +#define PMIC_IRQ_SW1_LS                BIT(0)
> +#define PMIC_IRQ_SW2_LS                BIT(1)
> +#define PMIC_IRQ_SW3_LS                BIT(2)
> +#define PMIC_IRQ_SW1_HS                BIT(0)
> +#define PMIC_IRQ_SW2_HS                BIT(1)
> +#define PMIC_IRQ_SW3_HS                BIT(2)
> +#define PMIC_IRQ_LDO1_FAULT    BIT(0)
> +#define PMIC_IRQ_LDO2_FAULT    BIT(1)
> +#define PMIC_IRQ_LDO3_FAULT    BIT(2)
> +#define PMIC_IRQ_TEMP_110      BIT(0)
> +#define PMIC_IRQ_TEMP_125      BIT(1)
> +
> +#define ONKEY_IRQ_PUSHI                BIT(0)
> +#define ONKEY_IRQ_1SI          BIT(1)
> +#define ONKEY_IRQ_2SI          BIT(2)
> +#define ONKEY_IRQ_3SI          BIT(3)
> +#define ONKEY_IRQ_4SI          BIT(4)
> +#define ONKEY_IRQ_8SI          BIT(5)
> +
> +#define CHARG_IRQ_BAT2SOCI     BIT(1)
> +#define CHARG_IRQ_BATI         BIT(2)
> +#define CHARG_IRQ_CHGI         BIT(3)
> +#define CHARG_IRQ_VBUSI                BIT(5)
> +#define CHARG_IRQ_DPMI         BIT(6)
> +#define CHARG_IRQ_THMI         BIT(7)
> +
> +enum pf1550_irq {
> +       PF1550_PMIC_IRQ_SW1_LS,
> +       PF1550_PMIC_IRQ_SW2_LS,
> +       PF1550_PMIC_IRQ_SW3_LS,
> +       PF1550_PMIC_IRQ_SW1_HS,
> +       PF1550_PMIC_IRQ_SW2_HS,
> +       PF1550_PMIC_IRQ_SW3_HS,
> +       PF1550_PMIC_IRQ_LDO1_FAULT,
> +       PF1550_PMIC_IRQ_LDO2_FAULT,
> +       PF1550_PMIC_IRQ_LDO3_FAULT,
> +       PF1550_PMIC_IRQ_TEMP_110,
> +       PF1550_PMIC_IRQ_TEMP_125,
> +
> +       PF1550_ONKEY_IRQ_PUSHI,
> +       PF1550_ONKEY_IRQ_1SI,
> +       PF1550_ONKEY_IRQ_2SI,
> +       PF1550_ONKEY_IRQ_3SI,
> +       PF1550_ONKEY_IRQ_4SI,
> +       PF1550_ONKEY_IRQ_8SI,
> +
> +       PF1550_CHARG_IRQ_BAT2SOCI,
> +       PF1550_CHARG_IRQ_BATI,
> +       PF1550_CHARG_IRQ_CHGI,
> +       PF1550_CHARG_IRQ_VBUSI,
> +       PF1550_CHARG_IRQ_DPMI,
> +       PF1550_CHARG_IRQ_THMI,
> +};
> +
> +enum pf1550_regulators {
> +       PF1550_SW1,
> +       PF1550_SW2,
> +       PF1550_SW3,
> +       PF1550_VREFDDR,
> +       PF1550_LDO1,
> +       PF1550_LDO2,
> +       PF1550_LDO3,
> +};
> +
> +struct pf1550_irq_info {
> +       unsigned int irq;
> +       const char *name;
> +       unsigned int virq;
> +};
> +
> +struct pf1550_dev {
> +       struct device *dev;
> +       struct i2c_client *i2c;
> +       int type;
> +       struct regmap *regmap;
> +       struct regmap_irq_chip_data *irq_data_regulator;
> +       struct regmap_irq_chip_data *irq_data_onkey;
> +       struct regmap_irq_chip_data *irq_data_charger;
> +       int irq;
> +};
> +
> +#endif /* __LINUX_MFD_PF1550_H */
> --
> 2.7.4
>
