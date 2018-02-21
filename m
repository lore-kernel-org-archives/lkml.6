Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbeBUTN5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:13:57 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:43084 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbeBUTNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:13:54 -0500
X-Google-Smtp-Source: AH8x2262A3+hrTaaOoaEbT7+Wqrkfnu9jIznLzfHVd1k2eFNKHAcq/i0gKUxgO3oq6+Cuzz1pjVVw9erGG9AA0iXzcA=
MIME-Version: 1.0
In-Reply-To: <20180221160044.15089-9-manivannan.sadhasivam@linaro.org>
References: <20180221160044.15089-1-manivannan.sadhasivam@linaro.org> <20180221160044.15089-9-manivannan.sadhasivam@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Feb 2018 21:13:53 +0200
Message-ID: <CAHp75VfLkmZp7HwX-du4EYdtJ8h=y59OrSbu53Ltf-_kFfpczg@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] gpio: Add gpio driver for Actions OWL S900 SoC
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?B?5YiY54Kc?= <liuwei@actions-semi.com>, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree <devicetree@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>, amit.kucheria@linaro.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 6:00 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> Add gpio driver for Actions Semi OWL family S900 SoC. Set of registers
> controlling the gpio shares the same register range with pinctrl block.
>
> GPIO registers are organized as 6 banks and each bank controls the
> maximum of 32 gpios.

> +static void owl_gpio_set_reg(void __iomem *base, unsigned int pin, int flag)
> +{
> +       u32 val;
> +
> +       if (flag) {
> +               val = readl(base);
> +               val |= BIT(pin);
> +               writel(val, base);
> +       } else {
> +               val = readl(base);
> +               val &= ~BIT(pin);
> +               writel(val, base);
> +       }
> +}

Why not to use the same pattern as below?

readl()
if ()
 ...
else
...
writel()

?

> +static void owl_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
> +{
> +       struct owl_gpio *gpio = gpiochip_get_data(chip);
> +       const struct owl_gpio_port *port = gpio->port;
> +       void __iomem *gpio_base = gpio->base + port->offset;
> +       u32 val;
> +
> +       val = readl(gpio_base + GPIO_DAT);
> +
> +       if (value)
> +               val |= BIT(offset);
> +       else
> +               val &= ~BIT(offset);
> +
> +       writel(val, gpio_base + GPIO_DAT);
> +}


-- 
With Best Regards,
Andy Shevchenko
