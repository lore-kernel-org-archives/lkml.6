Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966648AbeBNCtC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 21:49:02 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:40677 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966497AbeBNCtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 21:49:00 -0500
X-Google-Smtp-Source: AH8x225ZZia+YmhzrnTDFUpqi3/gOX+fcmMfFaEGwvNHW3Q0zr1x5daLcXAYilUKMwu+cfQjYYDOyDQcEnVBNho1ixY=
MIME-Version: 1.0
In-Reply-To: <CACRpkdYYmHLfozshnQcH+CR0N1zFtiLARRtUbXvJiLG+Bv+R9w@mail.gmail.com>
References: <2834309f69a1ec37b84a33f153a3d0b90336bcc6.1517795460.git.baolin.wang@linaro.org>
 <e6da9398355648fc72dc3f674a7c11e114c37d61.1517795461.git.baolin.wang@linaro.org>
 <CACRpkdYYmHLfozshnQcH+CR0N1zFtiLARRtUbXvJiLG+Bv+R9w@mail.gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 14 Feb 2018 10:48:58 +0800
Message-ID: <CAMz4kuJvVQewoJqamVB8rjbUA+fNcGN9p5U3nnnApqSZS8m9+g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] gpio: Add GPIO driver for Spreadtrum SC9860 platform
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 13 February 2018 at 16:13, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Feb 5, 2018 at 2:55 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>
>> The Spreadtrum SC9860 platform GPIO controller contains 16 groups and
>> each group contains 16 GPIOs. Each GPIO can set input/output and has
>> the interrupt capability.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> ---
>> Changes since v2:
>
> Hi Baolin,
>
> sorry for taking so long to review :(
>
> I think you need to add
>
> depends on OF_GPIO to the dependencies. Else the build
> will break on compile test on things like Usermode Linux
> that doesn't have IOMEM.

OK.

>
>> +/* GPIO registers definition */
>> +#define SPRD_GPIO_DATA         0x0
>> +#define SPRD_GPIO_DMSK         0x4
>> +#define SPRD_GPIO_DIR          0x8
>> +#define SPRD_GPIO_IS           0xc
>> +#define SPRD_GPIO_IBE          0x10
>> +#define SPRD_GPIO_IEV          0x14
>> +#define SPRD_GPIO_IE           0x18
>> +#define SPRD_GPIO_RIS          0x1c
>> +#define SPRD_GPIO_MIS          0x20
>> +#define SPRD_GPIO_IC           0x24
>> +#define SPRD_GPIO_INEN         0x28
>
> So this is very simple. And the only reason we cannot use
> GPIO_GENERIC is that we have these groups inside the controller
> and a shared interrupt line :/
>
> Hm yeah I cannot think of anything better anyway.
>
> Have you contemplated just putting them into the device tree
> like this:
>
> ap_gpio0: gpio@40280000 {
>         compatible = "sprd,sc9860-gpio";
>         reg = <0 0x40280000 0 0x80>;
>         gpio-controller;
>         #gpio-cells = <2>;
>         interrupt-controller;
>         #interrupt-cells = <2>;
>         interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> };
>
> ap_gpio1: gpio@40280080 {
>         compatible = "sprd,sc9860-gpio";
>         reg = <0 0x40280080 0 0x80>;
>         gpio-controller;
>         #gpio-cells = <2>;
>         interrupt-controller;
>         #interrupt-cells = <2>;
>         interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> };
>
> ap_gpio2: gpio@40280100 {
>         compatible = "sprd,sc9860-gpio";
>         reg = <0 0x40280100 0 0x80>;
>         gpio-controller;
>         #gpio-cells = <2>;
>         interrupt-controller;
>         #interrupt-cells = <2>;
>         interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> };
>
> (...)
>
> ?
>
> It is fine to have 16 driver instances if you grab the interrupt
> with IRQF_SHARED and really just handle the IRQ if it is for
> "your" instance. The upside is that you could then use
> GPIO_GENERIC and get a very small and simple driver.
>
> I understand that the current approach is also appealing though
> and I see why. I'm not gonna say no to it, so if you strongly
> prefer this approach we can go for it. Just wanted to point out
> alternatives.

Thanks for pointing out another approach. But we only have one
controller with multiple banks, so I think it is not easy to maintain
if we split one GPIO controller into multiple ones. Moreover if we
have more banks in future, there will be more device node to maintain.
So I still would like to use one device node to describe the only one
GPIO device.

>
>> +/* We have 16 groups GPIOs and each group contain 16 GPIOs */
>> +#define SPRD_GPIO_GROUP_NR     16
>> +#define SPRD_GPIO_NR           256
>> +#define SPRD_GPIO_GROUP_SIZE   0x80
>> +#define SPRD_GPIO_GROUP_MASK   GENMASK(15, 0)
>> +#define SPRD_GPIO_BIT(x)       ((x) & (SPRD_GPIO_GROUP_NR - 1))
>
> Please rename this from "groups" to "banks" because in the GPIO
> subsystem everyone talks about "banks" not "groups".

Sure.

>
> This last thing many drivers do like this:
>
> bit = x % 15;
>
> but it is up to you, either way works (and probably result in the
> same assembly).

OK.

>
>> +static inline void __iomem *sprd_gpio_group_base(struct sprd_gpio *sprd_gpio,
>> +                                                unsigned int group)
>> +{
>> +       return sprd_gpio->base + SPRD_GPIO_GROUP_SIZE * group;
>> +}
>
> Since you're always using this like this:
>
> void __iomem *base = sprd_gpio_group_base(sprd_gpio,
>                                             offset / SPRD_GPIO_GROUP_NR);
>
> Why not simply have the offset as parameter to the function
> instead of group number and do the division inside this
> static inline?

In sprd_gpio_irq_handler() function, we should pass the group number
as parameter, so to consistent with them, I use group number as
parameter.

>
>> +static void sprd_gpio_update(struct gpio_chip *chip, unsigned int offset,
>> +                            unsigned int reg, unsigned int val)
>
> I would use u16 reg.

Sure.

>
>> +{
>> +       struct sprd_gpio *sprd_gpio = gpiochip_get_data(chip);
>> +       void __iomem *base = sprd_gpio_group_base(sprd_gpio,
>> +                                                 offset / SPRD_GPIO_GROUP_NR);
>> +       u32 shift = SPRD_GPIO_BIT(offset);
>> +       unsigned long flags;
>> +       u32 orig, tmp;
>> +
>> +       spin_lock_irqsave(&sprd_gpio->lock, flags);
>> +       orig = readl_relaxed(base + reg);
>> +
>> +       tmp = (orig & ~BIT(shift)) | (val << shift);
>> +       writel_relaxed(tmp, base + reg);
>> +       spin_unlock_irqrestore(&sprd_gpio->lock, flags);
>> +}
>
> You don't need shift, orig and tmp variables here, I think it
> gets hard to read.
>
> I would do it like this:
>
> u32 tmp;
>
> tmp = readl_relaxed(base + reg);
> if (val)
>     tmp |= BIT(SPRD_GPIO_BIT(offset));
> else
>     tmp &= ~BIT(SPRD_GPIO_BIT(offset));
> writel_relaxed(tmp, base + reg);

OK. This seems more simpler and clearer.

>
> I don't know if the macros really help much. Maybe just inline it:
>
> tmp = readl_relaxed(base + reg);
> if (val)
>     tmp |= BIT(offset % 15);
> else
>     tmp &= ~BIT(offset % 15);
> writel_relaxed(tmp, base + reg);
>
> It depends on taste. Just consider my options.
> (I'll go with what you feel is easiest to read.)

OK.

>
>> +static int sprd_gpio_read(struct gpio_chip *chip, unsigned int offset,
>> +                         unsigned int reg)
>> +{
>> +       struct sprd_gpio *sprd_gpio = gpiochip_get_data(chip);
>> +       void __iomem *base = sprd_gpio_group_base(sprd_gpio,
>> +                                                 offset / SPRD_GPIO_GROUP_NR);
>> +       u32 value = readl_relaxed(base + reg) & SPRD_GPIO_GROUP_MASK;
>> +       u32 shift = SPRD_GPIO_BIT(offset);
>> +
>> +       return !!(value & BIT(shift));
>
> I would just
>
> return !!(readl_relaxed(base + reg) & BIT(offset % 15)):
>
> But again it is a matter of taste.

OK. Thanks for your useful comments.

-- 
Baolin.wang
Best Regards
