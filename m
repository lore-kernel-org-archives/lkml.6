Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752502AbeBAM0F (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 07:26:05 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39309 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752249AbeBAM0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 07:26:02 -0500
X-Google-Smtp-Source: AH8x227KYBedVvLguALkCVyFfccuKRyk7zr4Pqre0UA7I4XhBCToQ1aqsYzxBqa04Ry6GLpDBURt/7VGaW+fIC1y6TU=
MIME-Version: 1.0
In-Reply-To: <20180201121753.GB690@gmail.com>
References: <2834309f69a1ec37b84a33f153a3d0b90336bcc6.1517313987.git.baolin.wang@linaro.org>
 <cccc1addb9c0cc541b676dbad005ec341d12d165.1517313987.git.baolin.wang@linaro.org>
 <20180201121753.GB690@gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Thu, 1 Feb 2018 20:26:01 +0800
Message-ID: <CAMz4ku+-R--QKU4FzXt68py-yDMo7Xt98vBLR2MhhdjzxOKOHA@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: Add GPIO driver for Spreadtrum SC9860 platform
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

On 1 February 2018 at 20:17, Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
> Hi Baolin,
>
> On Tue, Jan 30, 2018 at 08:07:43PM +0800, Baolin Wang wrote:
>> The Spreadtrum SC9860 platform GPIO controller contains 16 groups and
>> each group contains 16 GPIOs. Each GPIO can set input/output and has
>> the interrupt capability.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>> diff --git a/drivers/gpio/gpio-sprd.c b/drivers/gpio/gpio-sprd.c
>> new file mode 100644
>> index 0000000..af59b9f
>> --- /dev/null
>> +++ b/drivers/gpio/gpio-sprd.c
>> @@ -0,0 +1,301 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2018 Spreadtrum Communications Inc.
>> + * Copyright (c) 2018 Linaro Ltd.
>> + */
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/gpio/driver.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/spinlock.h>
>> +
>> +/* GPIO registers definition */
>> +#define SPRD_GPIO_DATA               0x0
>> +#define SPRD_GPIO_DMSK               0x4
>> +#define SPRD_GPIO_DIR                0x8
>> +#define SPRD_GPIO_IS         0xc
>> +#define SPRD_GPIO_IBE                0x10
>> +#define SPRD_GPIO_IEV                0x14
>> +#define SPRD_GPIO_IE         0x18
>> +#define SPRD_GPIO_RIS                0x1c
>> +#define SPRD_GPIO_MIS                0x20
>> +#define SPRD_GPIO_IC         0x24
>> +#define SPRD_GPIO_INEN               0x28
>> +
>> +/* We have 16 groups GPIOs and each group contain 16 GPIOs */
>> +#define SPRD_GPIO_GROUP_NR   16
>> +#define SPRD_GPIO_NR         256
>> +#define SPRD_GPIO_GROUP_SIZE 0x80
>> +#define SPRD_GPIO_GROUP_MASK GENMASK(15, 0)
>> +#define SPRD_GPIO_BIT(x)     ((x) & (SPRD_GPIO_GROUP_NR - 1))
>> +
>> +struct sprd_gpio {
>> +     struct gpio_chip chip;
>> +     void __iomem *base;
>> +     spinlock_t lock;
>> +     int irq;
>> +};
>> +
>> +static inline void __iomem *sprd_gpio_group_base(struct sprd_gpio *sprd_gpio,
>> +                                              unsigned int group)
>> +{
>> +     return sprd_gpio->base + SPRD_GPIO_GROUP_SIZE * group;
>> +}
>> +
>> +static void sprd_gpio_update(struct gpio_chip *chip, unsigned int offset,
>> +                          unsigned int reg, unsigned int val)
>> +{
>> +     struct sprd_gpio *sprd_gpio = gpiochip_get_data(chip);
>> +     void __iomem *base = sprd_gpio_group_base(sprd_gpio,
>> +                                               offset / SPRD_GPIO_GROUP_NR);
>> +     u32 shift = SPRD_GPIO_BIT(offset);
>> +     unsigned long flags;
>> +     u32 orig, tmp;
>> +
>> +     spin_lock_irqsave(&sprd_gpio->lock, flags);
>> +     orig = readl_relaxed(base + reg);
>> +
>> +     tmp = (orig & ~BIT(shift)) | (val << shift);
>> +     writel_relaxed(tmp, base + reg);
>> +     spin_unlock_irqrestore(&sprd_gpio->lock, flags);
>> +}
>> +
>> +static int sprd_gpio_read(struct gpio_chip *chip, unsigned int offset,
>> +                       unsigned int reg)
>> +{
>> +     struct sprd_gpio *sprd_gpio = gpiochip_get_data(chip);
>> +     void __iomem *base = sprd_gpio_group_base(sprd_gpio,
>> +                                               offset / SPRD_GPIO_GROUP_NR);
>> +     u32 value = readl_relaxed(base + reg) & SPRD_GPIO_GROUP_MASK;
>> +     u32 shift = SPRD_GPIO_BIT(offset);
>> +
>> +     return !!(value & BIT(shift));
>> +}
>> +
>> +static int sprd_gpio_request(struct gpio_chip *chip, unsigned int offset)
>> +{
>> +     sprd_gpio_update(chip, offset, SPRD_GPIO_DMSK, 1);
>> +     return 0;
>> +}
>
> Better to change the function to void since the return value is not
> valueable.

The function prototype of gpio_chip structure need one return value,
so we need give one returned value though it is no meaningless.

>
>> +
>> +static void sprd_gpio_free(struct gpio_chip *chip, unsigned int offset)
>> +{
>> +     sprd_gpio_update(chip, offset, SPRD_GPIO_DMSK, 0);
>> +}
>> +
>> +static int sprd_gpio_direction_input(struct gpio_chip *chip,
>> +                                  unsigned int offset)
>> +{
>> +     sprd_gpio_update(chip, offset, SPRD_GPIO_DIR, 0);
>> +     sprd_gpio_update(chip, offset, SPRD_GPIO_INEN, 1);
>> +     return 0;
>> +}
>
> Same here
>
>
>> +
>> +static int sprd_gpio_direction_output(struct gpio_chip *chip,
>> +                                   unsigned int offset, int value)
>> +{
>> +     sprd_gpio_update(chip, offset, SPRD_GPIO_DIR, 1);
>> +     sprd_gpio_update(chip, offset, SPRD_GPIO_INEN, 0);
>> +     sprd_gpio_update(chip, offset, SPRD_GPIO_DATA, value);
>> +     return 0;
>> +}
>
> and here.
>
>
> Thanks,
> Marcus Folkesson
>
>
>



-- 
Baolin.wang
Best Regards
