Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbeCURpd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 13:45:33 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:33388 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752416AbeCURpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 13:45:30 -0400
X-Google-Smtp-Source: AG47ELvF5C8ZvxWdDfBkCx3camtu+Pwey4iZaH1DENpl4RZv7PUtxpFt5y0MO2Xpta9Q9ro3bIwPqm1NO0Rf249bvtU=
MIME-Version: 1.0
In-Reply-To: <6ca4bf0ed930c057bdbcd07bab34ed0a474dd78d.1521301345.git.vilhelm.gray@gmail.com>
References: <cover.1521301345.git.vilhelm.gray@gmail.com> <6ca4bf0ed930c057bdbcd07bab34ed0a474dd78d.1521301345.git.vilhelm.gray@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Mar 2018 19:45:29 +0200
Message-ID: <CAHp75Vfhe4qV73+A+X98bo-cpV0du5pwDERwEc0kPLGB612vmw@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] gpio: pci-idio-16: Implement get_multiple callback
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 17, 2018 at 5:50 PM, William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
> The ACCES I/O PCI-IDIO-16 series of devices provides 16
> optically-isolated digital inputs accessed via two 8-bit ports. Since
> eight input lines are acquired on a single port input read, the
> PCI-IDIO-16 GPIO driver may improve multiple input reads by utilizing a
> get_multiple callback. This patch implements the
> idio_16_gpio_get_multiple function which serves as the respective
> get_multiple callback.

> +static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
> +       unsigned long *mask, unsigned long *bits)
> +{
> +       struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
> +       size_t i;
> +       const unsigned int gpio_reg_size = 8;
> +       unsigned int bits_offset;
> +       size_t word_index;
> +       unsigned int word_offset;
> +       unsigned long word_mask;

> +       const unsigned long port_mask = GENMASK(gpio_reg_size, 0);

gpio_reg_size - 1?
Though I would prefer not to have that variable at all, just use 8 or
7 respectively.

> +       unsigned long port_state;

> +       u8 __iomem ports[] = {
> +               idio16gpio->reg->out0_7, idio16gpio->reg->out8_15,

> +               idio16gpio->reg->in0_7, idio16gpio->reg->in8_15

I would leave comma even here.

> +       };

> +       /* get bits are evaluated a gpio port register at a time */
> +       for (i = 0; i < ARRAY_SIZE(ports); i++) {
> +               /* gpio offset in bits array */
> +               bits_offset = i * gpio_reg_size;
> +
> +               /* word index for bits array */
> +               word_index = BIT_WORD(bits_offset);
> +
> +               /* gpio offset within current word of bits array */
> +               word_offset = bits_offset % BITS_PER_LONG;
> +
> +               /* mask of get bits for current gpio within current word */
> +               word_mask = mask[word_index] & (port_mask << word_offset);
> +               if (!word_mask) {
> +                       /* no get bits in this port so skip to next one */
> +                       continue;
> +               }
> +
> +               /* read bits from current gpio port */
> +               port_state = ioread8(ports + i);
> +
> +               /* store acquired bits at respective bits array offset */
> +               bits[word_index] |= port_state << word_offset;
> +       }

I would propose to do other way around, i.e.
read all ports to the bitmap array and call bitmap_and() after.

Further optimization can be something like introduction of generic

bitmap_copy_uXX_off(unsigned long *dst, u8 src, unsigned int offset);

It can be done using macros, though it's another story not quite
related to the topic.

> +}

-- 
With Best Regards,
Andy Shevchenko
