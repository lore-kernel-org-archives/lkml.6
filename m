Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752410AbeBAPb7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 10:31:59 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35342 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbeBAPb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 10:31:56 -0500
X-Google-Smtp-Source: AH8x224x6t1thTbzKcszUwHfVBgBR1uY2gyQTy0xphvklzOCBEchELEyhZygKY4iMu27M9br1GsesDgH45/z2wjZOGY=
MIME-Version: 1.0
In-Reply-To: <62ceed73b65399099ccd76fe6b7331bcd253b027.1517453569.git.baolin.wang@linaro.org>
References: <2834309f69a1ec37b84a33f153a3d0b90336bcc6.1517453568.git.baolin.wang@linaro.org>
 <62ceed73b65399099ccd76fe6b7331bcd253b027.1517453569.git.baolin.wang@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Feb 2018 17:31:54 +0200
Message-ID: <CAHp75VdYjz6f2wBXsTL1kf5z-jcM68sMhtmkdgJM+TiPZb=gww@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: Add GPIO driver for Spreadtrum SC9860 platform
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 1, 2018 at 5:04 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
> The Spreadtrum SC9860 platform GPIO controller contains 16 groups and
> each group contains 16 GPIOs. Each GPIO can set input/output and has
> the interrupt capability.

Just noticed couple of more improvements you can do.

> +       case IRQ_TYPE_EDGE_RISING:
> +               sprd_gpio_update(chip, offset, SPRD_GPIO_IS, 0);
> +               sprd_gpio_update(chip, offset, SPRD_GPIO_IBE, 0);
> +               sprd_gpio_update(chip, offset, SPRD_GPIO_IEV, 1);
> +               irq_set_handler_locked(data, handle_edge_irq);
> +               break;
> +       case IRQ_TYPE_EDGE_FALLING:
> +               sprd_gpio_update(chip, offset, SPRD_GPIO_IS, 0);
> +               sprd_gpio_update(chip, offset, SPRD_GPIO_IBE, 0);
> +               sprd_gpio_update(chip, offset, SPRD_GPIO_IEV, 0);
> +               irq_set_handler_locked(data, handle_edge_irq);
> +               break;
> +       case IRQ_TYPE_EDGE_BOTH:
> +               sprd_gpio_update(chip, offset, SPRD_GPIO_IS, 0);
> +               sprd_gpio_update(chip, offset, SPRD_GPIO_IBE, 1);
> +               irq_set_handler_locked(data, handle_edge_irq);
> +               break;
> +       case IRQ_TYPE_LEVEL_HIGH:
> +               sprd_gpio_update(chip, offset, SPRD_GPIO_IS, 1);
> +               sprd_gpio_update(chip, offset, SPRD_GPIO_IBE, 0);
> +               sprd_gpio_update(chip, offset, SPRD_GPIO_IEV, 1);
> +               irq_set_handler_locked(data, handle_level_irq);
> +               break;
> +       case IRQ_TYPE_LEVEL_LOW:
> +               sprd_gpio_update(chip, offset, SPRD_GPIO_IS, 1);
> +               sprd_gpio_update(chip, offset, SPRD_GPIO_IBE, 0);
> +               sprd_gpio_update(chip, offset, SPRD_GPIO_IEV, 0);
> +               irq_set_handler_locked(data, handle_level_irq);
> +               break;
> +       default:
> +               return -EINVAL;

I guess you can use fallthrough and reduce some lines, but I have no
strong opinion which will look better.

> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       sprd_gpio->base = devm_ioremap_nocache(&pdev->dev, res->start,
> +                                              resource_size(res));

Didn't notice before, why not to simple call devm_ioremap_resource() ?

-- 
With Best Regards,
Andy Shevchenko
