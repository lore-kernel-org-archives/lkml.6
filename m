Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031383AbeBNPa0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:30:26 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36888 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031287AbeBNPaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:30:24 -0500
X-Google-Smtp-Source: AH8x224zcQ0llcpYT8oV+5jgVPL+M2PRdokVQHGuqijdpT96NLkRNaxJucxkDrqWGoHnIrCs+BV79HXT2JmSDg51RFg=
MIME-Version: 1.0
In-Reply-To: <1518100057-23234-4-git-send-email-amelie.delaunay@st.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com> <1518100057-23234-4-git-send-email-amelie.delaunay@st.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Feb 2018 17:30:22 +0200
Message-ID: <CAHp75VfuEd5fgjv40A27hOgj_Nd_LK2Yh=oBR-8qgPc+gSiiQw@mail.gmail.com>
Subject: Re: [PATCH 3/6] gpio: Add GPIO support for the ST Multi-Function eXpander
To: Amelie Delaunay <amelie.delaunay@st.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 8, 2018 at 4:27 PM, Amelie Delaunay <amelie.delaunay@st.com> wrote:
> ST Multi-Function eXpander (MFX) can be used as GPIO expander.
> It has 16 fast GPIOs and can have 8 extra alternate GPIOs
> when other MFX features are not enabled.

> +config GPIO_ST_MFX
> +       bool "ST-MFX GPIOs"
> +       depends on MFD_ST_MFX
> +       depends on OF_GPIO
> +       select GPIOLIB_IRQCHIP
> +       help
> +         GPIO driver for STMicroelectronics Multi-Function eXpander.
> +
> +         This provides GPIO interface supporting inputs and outputs.

> +/*
> + * STMicroelectronics Multi-Function eXpander (ST-MFX) - GPIO expander driver.
> + *
> + * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
> + * Author(s): Amelie Delaunay <amelie.delaunay@st.com> for STMicroelectronics.

> + * License terms: GPL V2.0.
> + *
> + * st-mfx-gpio is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * st-mfx-gpio is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
> + * details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * st-mfx-gpio. If not, see <http://www.gnu.org/licenses/>.

Use SPDX instead.

> + */

> +#include <linux/of_gpio.h>

> +/* MFX has a maximum of 24 gpios, with 8 gpios per bank, so 3 banks maximum */
> +#define NR_MAX_GPIOS           24
> +#define NR_GPIOS_PER_BANK      8
> +#define NR_MAX_BANKS           (NR_MAX_GPIOS / NR_GPIOS_PER_BANK)

> +#define get_bank(offset)       ((u8)((offset) / NR_GPIOS_PER_BANK))
> +#define get_mask(offset)       ((u8)BIT((offset) % NR_GPIOS_PER_BANK))

I would rather keep it consistent, i.e.
get_bank() [as is]
get_mask -> get_shift() [w/o BIT() macro]

> +enum { REG_IRQ_SRC, REG_IRQ_EVT, REG_IRQ_TYPE, NR_CACHE_IRQ_REGS };

Please, do one item per line.

> +/*
> + * This is MFX-specific flags, overloading Linux-specific of_gpio_flags,
> + * needed in of_xlate callback.

> + * on MFX: - if GPIO is output:

Split to two lines.

> + *             * (0) means PUSH_PULL
> + *             * OF_GPIO_SINGLE_ENDED (=2) means OPEN-DRAIN
> + *        - if GPIO is input:
> + *             * (0) means NO_PULL
> + *             * OF_MFX_GPI_PUSH_PULL (=2) means PUSH_PULL
> + *
> + *             * OF_MFX_GPIO_PULL_UP programs pull up resistor on the GPIO,
> + *               whatever its direction, without this flag, depending on
> + *               GPIO type and direction, it programs either no pull or
> + *               pull down resistor.
> + */
> +enum of_mfx_gpio_flags {
> +       OF_MFX_GPI_PUSH_PULL = 0x2,
> +       OF_MFX_GPIO_PULL_UP = 0x4,

These have misleading prefix. OF_ is reserved for general OF stuff.

> +};
> +
> +struct mfx_gpio {
> +       struct gpio_chip gc;
> +       struct mfx *mfx;

> +       struct device *dev;

Don't you have it in gc above as a parent device?

> +       struct mutex irq_lock; /* IRQ bus lock */
> +       u32 flags[NR_MAX_GPIOS];
> +       /* Caches of interrupt control registers for bus_lock */
> +       u8 regs[NR_CACHE_IRQ_REGS][NR_MAX_BANKS];
> +       u8 oldregs[NR_CACHE_IRQ_REGS][NR_MAX_BANKS];
> +};

> +static int mfx_gpio_direction_input(struct gpio_chip *gc,
> +                                   unsigned int offset)
> +{
> +       struct mfx_gpio *mfx_gpio = gpiochip_get_data(gc);
> +       struct mfx *mfx = mfx_gpio->mfx;
> +       u8 reg_type = MFX_REG_GPIO_TYPE + get_bank(offset);
> +       u8 reg_pupd = MFX_REG_GPIO_PUPD + get_bank(offset);
> +       u8 reg_dir = MFX_REG_GPIO_DIR + get_bank(offset);
> +       u8 mask = get_mask(offset);
> +       int ret;
> +
> +       /*
> +        * In case of input direction, there is actually no way to apply some
> +        * configuration in hardware, as it can be done with
> +        * .set_config in case of output direction. That's why we apply
> +        * here the MFX specific-flags.
> +        */
> +       if (mfx_gpio->flags[offset] & OF_MFX_GPI_PUSH_PULL)
> +               ret = mfx_set_bits(mfx, reg_type, mask, mask);
> +       else
> +               ret = mfx_set_bits(mfx, reg_type, mask, 0);

> +

Redundant empty line.

> +       if (ret)
> +               return ret;
> +
> +       if (mfx_gpio->flags[offset] & OF_MFX_GPIO_PULL_UP)
> +               ret = mfx_set_bits(mfx, reg_pupd, mask, mask);
> +       else
> +               ret = mfx_set_bits(mfx, reg_pupd, mask, 0);

> +

Ditto.

> +       if (ret)
> +               return ret;
> +
> +       return mfx_set_bits(mfx, reg_dir, mask, 0);
> +}

> +static void mfx_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
> +{
> +       struct mfx_gpio *mfx_gpio = gpiochip_get_data(gc);
> +       struct mfx *mfx = mfx_gpio->mfx;
> +       u16 i;
> +
> +       for (i = 0; i < gc->ngpio; i++) {
> +               int gpio = i + gc->base;
> +               const char *label = gpiochip_is_requested(gc, i);
> +               int dir = mfx_gpio_get_direction(gc, i);
> +               int val = mfx_gpio_get(gc, i);
> +               u8 mask = get_mask(i);
> +               u8 reg;
> +               int type, pupd;
> +               int irqsrc, irqevt, irqtype, irqpending;

> +               if (!label)
> +                       label = "Unrequested";

I would rather put label = gpiochip_...(); immediately before this
condition for better readability.

> +
> +               seq_printf(s, " gpio-%-3d (%-20.20s) ", gpio, label);
> +

> +               reg = MFX_REG_IRQ_GPI_PENDING + get_bank(i);
> +               irqpending = mfx_reg_read(mfx, reg);
> +               if (irqpending < 0)
> +                       return;
> +               irqpending = !!(irqpending & mask);
> +

> +               if (!dir) {

Why not to use

if (dir) {

?

> +                       seq_printf(s, "out %s ", val ? "high" : "low");
> +                       if (type)
> +                               seq_puts(s, "open drain ");
> +                       else
> +                               seq_puts(s, "push pull ");
> +                       if (pupd && type)
> +                               seq_puts(s, "with internal pull-up ");
> +                       else
> +                               seq_puts(s, "without internal pull-up ");
> +               } else {
> +                       seq_printf(s, "in %s ", val ? "high" : "low");
> +                       if (type)
> +                               seq_printf(s, "with internal pull-%s ",
> +                                          pupd ? "up" : "down");
> +                       else
> +                               seq_printf(s, "%s ",
> +                                          pupd ? "floating" : "analog");
> +               }
> +
> +               if (irqsrc) {
> +                       seq_printf(s, "IRQ generated on %s %s",
> +                                  !irqevt ?
> +                                  (!irqtype ? "Low level" : "High level") :
> +                                  (!irqtype ? "Falling edge" : "Rising edge"),
> +                                  irqpending ? "(pending)" : "");

Why do you use negative conditions? Use positive ones.

> +               }
> +
> +               seq_puts(s, "\n");
> +       }
> +}

> +static void mfx_gpio_irq_toggle_trigger(struct gpio_chip *gc, int offset)
> +{
> +       struct mfx_gpio *mfx_gpio = gpiochip_get_data(gc);
> +       struct mfx *mfx = mfx_gpio->mfx;
> +       u8 bank = get_bank(offset);
> +       u8 mask = get_mask(offset);
> +       int val = mfx_gpio_get(gc, offset);
> +

> +       if (val < 0) {
> +               dev_err(mfx_gpio->dev, "can't get value of gpio%d: ret=%d\n",
> +                       offset, val);

Is it somehow useful on err level?

> +               return;
> +       }

> +}

> +static int mfx_gpio_irq_set_type(struct irq_data *d, unsigned int type)
> +{
> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +       struct mfx_gpio *mfx_gpio = gpiochip_get_data(gc);
> +       int bank = get_bank(d->hwirq);
> +       int mask = get_mask(d->hwirq);
> +

> +       if ((type & IRQ_TYPE_LEVEL_LOW) || (type & IRQ_TYPE_LEVEL_HIGH))

IRQ_TYPE_LEVEL_MASK?

> +               mfx_gpio->regs[REG_IRQ_EVT][bank] &= ~mask;
> +       else
> +               mfx_gpio->regs[REG_IRQ_EVT][bank] |= mask;
> +
> +       if ((type & IRQ_TYPE_EDGE_RISING) || (type & IRQ_TYPE_LEVEL_HIGH))

IRQ_TYPE_EDGE_BOTH ?

> +               mfx_gpio->regs[REG_IRQ_TYPE][bank] |= mask;
> +       else
> +               mfx_gpio->regs[REG_IRQ_TYPE][bank] &= ~mask;
> +

> +}

> +static void mfx_gpio_irq_lock(struct irq_data *d)

Missed annotation that this acquires a lock.

> +static void mfx_gpio_irq_sync_unlock(struct irq_data *d)

Ditto for releasing lock.

> +static irqreturn_t mfx_gpio_irq(int irq, void *dev)
> +{
> +       struct mfx_gpio *mfx_gpio = dev;
> +       struct mfx *mfx = mfx_gpio->mfx;
> +       int num_banks = mfx->num_gpio / 8;
> +       u8 status[num_banks];

> +       int ret;
> +       u8 bank;

Swap lines.

> +
> +       ret = mfx_block_read(mfx, MFX_REG_IRQ_GPI_PENDING, ARRAY_SIZE(status),
> +                            status);
> +       if (ret < 0) {

> +               dev_err(mfx_gpio->dev, "can't get IRQ_GPI_PENDING: %d\n", ret);

In IRQ context on err level? Hmm...

> +               return IRQ_NONE;
> +       }
> +
> +       for (bank = 0; bank < ARRAY_SIZE(status); bank++) {
> +               u8 stat = status[bank];
> +
> +               if (!stat)
> +                       continue;
> +

> +               while (stat) {
> +                       int bit = __ffs(stat);

for_each_set_bit() ?

> +                       int offset = bank * NR_GPIOS_PER_BANK + bit;
> +                       int gpio_irq = irq_find_mapping(mfx_gpio->gc.irq.domain,
> +                                                       offset);
> +                       int irq_trigger = irq_get_trigger_type(gpio_irq);
> +
> +                       handle_nested_irq(gpio_irq);
> +                       stat &= ~(BIT(bit));
> +
> +                       if (irq_trigger & IRQ_TYPE_EDGE_BOTH)
> +                               mfx_gpio_irq_toggle_trigger(&mfx_gpio->gc,
> +                                                           offset);
> +               }
> +
> +               mfx_reg_write(mfx, MFX_REG_IRQ_GPI_ACK + bank, status[bank]);
> +       }
> +
> +       return IRQ_HANDLED;
> +}

-- 
With Best Regards,
Andy Shevchenko
