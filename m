Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752797AbeC3VEP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 17:04:15 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45126 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752568AbeC3VEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 17:04:12 -0400
X-Google-Smtp-Source: AIpwx4913PCauwTunoM77s6SdcjCpcxAXP2jxURqFYekuFZV4RIiusDI1awMRApPhtc/w9UjXDiDyZFdOLOuTf29Dl4=
MIME-Version: 1.0
In-Reply-To: <20180328174703.19778-8-manivannan.sadhasivam@linaro.org>
References: <20180328174703.19778-1-manivannan.sadhasivam@linaro.org> <20180328174703.19778-8-manivannan.sadhasivam@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 31 Mar 2018 00:04:11 +0300
Message-ID: <CAHp75VeGv04CA3f1pRDi35DsbRgrdj86TBUBZ3J+27T822cOqw@mail.gmail.com>
Subject: Re: [PATCH v6 7/9] gpio: Add gpio driver for Actions OWL S900 SoC
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
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        Mani Sadhasivam <manivannanece23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 8:47 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> Add gpio driver for Actions Semi OWL family S900 SoC. Set of registers
> controlling the gpio shares the same register range with pinctrl block.
>
> GPIO registers are organized as 6 banks and each bank controls the
> maximum of 32 gpios.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> +static void owl_gpio_update_reg(void __iomem *base, unsigned int pin, int flag)
> +{
> +       u32 val;
> +
> +       val = readl_relaxed(base);
> +
> +       if (flag)
> +               val |= BIT(pin);
> +       else
> +               val &= ~BIT(pin);
> +
> +       writel_relaxed(val, base);
> +}

Hmm... Just realized that this driver misses locking.

Something like
owl_gpio_update_reg_locked()
{
 spin_lock();
 owl_gpio_update_reg();
 spin_unlock();
}

> +
> +static int owl_gpio_request(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct owl_gpio *gpio = gpiochip_get_data(chip);
> +
> +       /*
> +        * GPIOs have higher priority over other modules, so either setting
> +        * them as OUT or IN is sufficient
> +        */
> +       owl_gpio_update_reg(gpio->base + GPIO_OUTEN, offset, true);

...to use in such cases.

> +
> +       return 0;
> +}
> +
> +static void owl_gpio_free(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct owl_gpio *gpio = gpiochip_get_data(chip);
> +
> +       /* disable gpio output */
> +       owl_gpio_update_reg(gpio->base + GPIO_OUTEN, offset, false);
> +
> +       /* disable gpio input */
> +       owl_gpio_update_reg(gpio->base + GPIO_INEN, offset, false);

...or

spin_lock();
owl_gpio_update_reg();
owl_gpio_update_reg();
spin_unlock();

...in this and similar cases.

> +}


-- 
With Best Regards,
Andy Shevchenko
