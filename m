Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934606AbeCMQEk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:04:40 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:46214 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934047AbeCMQEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:04:34 -0400
X-Google-Smtp-Source: AG47ELv4rvh06ca7tBMCkJCXpA4OeXn+xz5cXKF2OVQcASHAZVB+0Edhaqj61BjGp05X3IeV1EAwahNsxwKqAbNZlMU=
MIME-Version: 1.0
In-Reply-To: <e6a13288c45f824ba23ee8d1410cf0bf9c55fe60.1520886945.git.vilhelm.gray@gmail.com>
References: <cover.1520886945.git.vilhelm.gray@gmail.com> <e6a13288c45f824ba23ee8d1410cf0bf9c55fe60.1520886945.git.vilhelm.gray@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Mar 2018 18:04:33 +0200
Message-ID: <CAHp75Vf9+=rie5oqmAp7yW3_AirGuvBtxGS=6y9UBHzjpvD9ww@mail.gmail.com>
Subject: Re: [PATCH 3/8] gpio: pci-idio-16: Implement get_multiple callback
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 10:49 PM, William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:

> +static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
> +       unsigned long *mask, unsigned long *bits)
> +{


> +       /* clear bits array to a clean slate */
> +       for (i = 0; i < chip->ngpio; i += BITS_PER_LONG)
> +               bits[i / BITS_PER_LONG] = 0;

bitmap_clear() or bitmap_zero()

> +       /* get bits are evaluated a gpio register size at a time */
> +       for (i = 0; i < chip->ngpio; i += gpio_reg_size) {
> +               bit_word_offset = i % BITS_PER_LONG;
> +               bits_mask = mask[BIT_WORD(i)] & (reg_mask << bit_word_offset);
> +               if (!bits_mask) {
> +                       /* no get bits in this register so skip to next one */
> +                       continue;
> +               }

for_each_set_bit() ?

> +               /* store acquired bits */
> +               bits[BIT_WORD(i)] |= port_state << bit_word_offset;

__set_bit()
__clear_bit()

We have bitmap API for *ages*. Is it too hard to check?

-- 
With Best Regards,
Andy Shevchenko
