Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbeCUPcN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:32:13 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:36221 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752833AbeCUPcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:32:04 -0400
X-Google-Smtp-Source: AG47ELuk8Zbo89FTj7XBObZHgXb+cwj8iVgZq0ScaZPRbrBYMCrkfJ6TiM0Yi9JUbIV7DvNHXRhx3l+aA/28fzZAm2Q=
MIME-Version: 1.0
In-Reply-To: <486eb9bad0440ed305a78d9fc990728cbeb7d43e.1521301345.git.vilhelm.gray@gmail.com>
References: <cover.1521301345.git.vilhelm.gray@gmail.com> <486eb9bad0440ed305a78d9fc990728cbeb7d43e.1521301345.git.vilhelm.gray@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Mar 2018 17:32:03 +0200
Message-ID: <CAHp75VcdimgN3u5O5zye2=pXvCkWuZzCf3e0wOQozQoKz7W8yA@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] gpio: 104-idio-16: Implement get_multiple callback
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
> The ACCES I/O 104-IDIO-16 series of devices provides 16
> optically-isolated digital inputs accessed via two 8-bit ports. Since
> eight input lines are acquired on a single port input read, the
> 104-IDIO-16 GPIO driver may improve multiple input reads by utilizing a
> get_multiple callback. This patch implements the
> idio_16_gpio_get_multiple function which serves as the respective
> get_multiple callback.

> +static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
> +       unsigned long *mask, unsigned long *bits)
> +{
> +       struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
> +
> +       *bits = 0;

> +       if (*mask & 0xFF0000)

GENMASK(23, 16) ?

> +               *bits |= (unsigned long)inb(idio16gpio->base + 1) << 16;

Do you need casting?

> +       if (*mask & 0xFF000000)

GENMASK(31, 24) ?

Alternative (and for above):

(*mask >> 24) & 0xff

(*mask >> 16) & 0xff


> +               *bits |= (unsigned long)inb(idio16gpio->base + 5) << 24;

Do you need casting?

> +
> +       return 0;
> +}
> +
>  static void idio_16_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
>  {
>         struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
> @@ -244,6 +258,7 @@ static int idio_16_probe(struct device *dev, unsigned int id)
>         idio16gpio->chip.direction_input = idio_16_gpio_direction_input;
>         idio16gpio->chip.direction_output = idio_16_gpio_direction_output;
>         idio16gpio->chip.get = idio_16_gpio_get;
> +       idio16gpio->chip.get_multiple = idio_16_gpio_get_multiple;
>         idio16gpio->chip.set = idio_16_gpio_set;
>         idio16gpio->chip.set_multiple = idio_16_gpio_set_multiple;
>         idio16gpio->base = base[id];
> --
> 2.16.2
>



-- 
With Best Regards,
Andy Shevchenko
