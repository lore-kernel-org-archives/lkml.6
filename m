Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751663AbeBROpM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 09:45:12 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:36386 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbeBROpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 09:45:10 -0500
X-Google-Smtp-Source: AH8x226a2WmZ/wpHTqfxEdrBhC0QozaYLwk7In9xuDfBzsgTvWXIN1GL9PEwXbkn4qzceuC9LTm6ZLs5uTVeuppgSWo=
MIME-Version: 1.0
In-Reply-To: <20180217204433.3095-9-manivannan.sadhasivam@linaro.org>
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org> <20180217204433.3095-9-manivannan.sadhasivam@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 18 Feb 2018 16:45:09 +0200
Message-ID: <CAHp75Vcmtq_mpkqx4+Yr24nRQEHJZmcypbOJLukZpdXVYzizNQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] gpio: Add gpio driver for Actions OWL S900 SoC
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?B?5YiY54Kc?= <liuwei@actions-semi.com>, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree <devicetree@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>, amit.kucheria@linaro.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2018 at 10:44 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> Add gpio driver for Actions Semi OWL family S900 SoC. Set of registers
> controlling the gpio shares the same register range with pinctrl block.
>
> GPIO registers are organized as 6 banks and each bank controls the
> maximum of 32 gpios.

> +#include <linux/init.h>

> +#include <linux/module.h>

Choose one of them.

> +       val = readl(gpio_base + GPIO_OUTEN);
> +       val |= BIT(offset);
> +       writel(val, gpio_base + GPIO_OUTEN);

out_en()

> +       val = readl(gpio_base + GPIO_OUTEN);
> +       val &= ~BIT(offset);
> +       writel(val, gpio_base + GPIO_OUTEN);

out_dis()

> +       val = readl(gpio_base + GPIO_INEN);
> +       val &= ~BIT(offset);
> +       writel(val, gpio_base + GPIO_INEN);

in_dis()

> +       val = readl(gpio_base + GPIO_OUTEN);
> +       val &= ~BIT(offset);
> +       writel(val, gpio_base + GPIO_OUTEN);

out_dis()

> +       val = readl(gpio_base + GPIO_INEN);
> +       val |= BIT(offset);
> +       writel(val, gpio_base + GPIO_INEN);

in_en()


> +       val = readl(gpio_base + GPIO_INEN);
> +       val &= ~BIT(pin);
> +       writel(val, gpio_base + GPIO_INEN);

in_dis()

> +       val = readl(gpio_base + GPIO_OUTEN);
> +       val |= BIT(pin);
> +       writel(val, gpio_base + GPIO_OUTEN);

out_en()

Find above code duplication.

> +static int owl_gpio_probe(struct platform_device *pdev)
> +{

> +       gpio->base = of_iomap(pdev->dev.of_node, 0);
> +       if (IS_ERR(gpio->base))
> +               return PTR_ERR(gpio->base);


> +       gpio->gpio.of_node = pdev->dev.of_node;

Isn't this done by GPIO library?

> +static int owl_gpio_remove(struct platform_device *pdev)
> +{
> +       return 0;
> +}

Useless stub.

-- 
With Best Regards,
Andy Shevchenko
