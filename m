Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753439AbeBSRUY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:20:24 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33865 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753272AbeBSRUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 12:20:21 -0500
X-Google-Smtp-Source: AH8x225J898lZ9R/HvLhrJIew2a8n6iJe1NXAO57WyyFg6YKLssczyBp/QmZDp8EB3auGYge2uoPww==
Date: Mon, 19 Feb 2018 22:50:10 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        =?utf-8?B?5YiY54Kc?= <liuwei@actions-semi.com>, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree <devicetree@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>, amit.kucheria@linaro.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/10] gpio: Add gpio driver for Actions OWL S900 SoC
Message-ID: <20180219172010.ph34dvpdhhkmemdg@linaro.org>
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
 <20180217204433.3095-9-manivannan.sadhasivam@linaro.org>
 <CAHp75Vcmtq_mpkqx4+Yr24nRQEHJZmcypbOJLukZpdXVYzizNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vcmtq_mpkqx4+Yr24nRQEHJZmcypbOJLukZpdXVYzizNQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,
On Sun, Feb 18, 2018 at 04:45:09PM +0200, Andy Shevchenko wrote:
> On Sat, Feb 17, 2018 at 10:44 PM, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> > Add gpio driver for Actions Semi OWL family S900 SoC. Set of registers
> > controlling the gpio shares the same register range with pinctrl block.
> >
> > GPIO registers are organized as 6 banks and each bank controls the
> > maximum of 32 gpios.
> 
> > +#include <linux/init.h>
> 
> > +#include <linux/module.h>
> 
> Choose one of them.
> 
Will drop <linux/init.h>
> > +       val = readl(gpio_base + GPIO_OUTEN);
> > +       val |= BIT(offset);
> > +       writel(val, gpio_base + GPIO_OUTEN);
> 
> out_en()
> 
> > +       val = readl(gpio_base + GPIO_OUTEN);
> > +       val &= ~BIT(offset);
> > +       writel(val, gpio_base + GPIO_OUTEN);
> 
> out_dis()
> 
> > +       val = readl(gpio_base + GPIO_INEN);
> > +       val &= ~BIT(offset);
> > +       writel(val, gpio_base + GPIO_INEN);
> 
> in_dis()
> 
> > +       val = readl(gpio_base + GPIO_OUTEN);
> > +       val &= ~BIT(offset);
> > +       writel(val, gpio_base + GPIO_OUTEN);
> 
> out_dis()
> 
> > +       val = readl(gpio_base + GPIO_INEN);
> > +       val |= BIT(offset);
> > +       writel(val, gpio_base + GPIO_INEN);
> 
> in_en()
> 
> 
> > +       val = readl(gpio_base + GPIO_INEN);
> > +       val &= ~BIT(pin);
> > +       writel(val, gpio_base + GPIO_INEN);
> 
> in_dis()
> 
> > +       val = readl(gpio_base + GPIO_OUTEN);
> > +       val |= BIT(pin);
> > +       writel(val, gpio_base + GPIO_OUTEN);
> 
> out_en()
> 
> Find above code duplication.
> 
Sure. Will add a common function like owl_gpio_set_reg for setting register
values.
> > +static int owl_gpio_probe(struct platform_device *pdev)
> > +{
> 
> > +       gpio->base = of_iomap(pdev->dev.of_node, 0);
> > +       if (IS_ERR(gpio->base))
> > +               return PTR_ERR(gpio->base);
> 
> 
> > +       gpio->gpio.of_node = pdev->dev.of_node;
> 
> Isn't this done by GPIO library?
> 
Yes. Will drop this.
> > +static int owl_gpio_remove(struct platform_device *pdev)
> > +{
> > +       return 0;
> > +}
> 
> Useless stub.
> 
Okay.

Also, in the next revision of the driver I will be making all the banks
as its own gpio-controller as opposed to the single controller since all
have their own interrupt domain.

For this case, MMIO can't be used because the banks have irregular number
of gpios.

Thanks,
Mani
> -- 
> With Best Regards,
> Andy Shevchenko
