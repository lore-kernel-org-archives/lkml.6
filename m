Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbeERUHH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 16:07:07 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39590 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeERUHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 16:07:05 -0400
X-Google-Smtp-Source: AB8JxZr4NXlPMYS1j6EXehJPnB2rQMPWLN2/4+9oE+UDcXYXtu/xT9Ro9aC/jk2fmSJ6byJCG1GOYot3qgiA8uX9mzM=
MIME-Version: 1.0
In-Reply-To: <20180518175304.20414-1-labbott@redhat.com>
References: <20180518175304.20414-1-labbott@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 18 May 2018 23:07:04 +0300
Message-ID: <CAHp75VciKgqYV_DB=h+zaVkk2+dmKJDhT02M4K8T1VGJA6KM0g@mail.gmail.com>
Subject: Re: [PATCHv8] gpio: Remove VLA from gpiolib
To: Laura Abbott <labbott@redhat.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>, Lukas Wunner <lukas@wunner.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com,
        Phil Reid <preid@electromag.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 8:53 PM, Laura Abbott <labbott@redhat.com> wrote:
> The new challenge is to remove VLAs from the kernel
> (see https://lkml.org/lkml/2018/3/7/621) to eventually
> turn on -Wvla.
>
> Using a kmalloc array is the easy way to fix this but kmalloc is still
> more expensive than stack allocation. Introduce a fast path with a
> fixed size stack array to cover most chip with gpios below some fixed
> amount. The slow path dynamically allocates an array to cover those
> chips with a large number of gpios.

> +               unsigned long fastpath[2 * BITS_TO_LONGS(FASTPATH_NGPIO)];
> +               unsigned long *mask, *bits;
>                 int first, j, ret;
>
> +               if (likely(chip->ngpio <= FASTPATH_NGPIO)) {
> +                       mask = fastpath;
> +               } else {
> +                       mask = kmalloc_array(2 * BITS_TO_LONGS(chip->ngpio),
> +                                          sizeof(*mask),
> +                                          can_sleep ? GFP_KERNEL : GFP_ATOMIC);
> +                       if (!mask)
> +                               return -ENOMEM;
> +               }
> +
> +               bits = mask + BITS_TO_LONGS(chip->ngpio);
> +               memset(mask, 0, BITS_TO_LONGS(chip->ngpio) * sizeof(*mask));

Wouldn't be better

bitmap_zero(mask, chip->ngpio);

?

> +               bits = mask + BITS_TO_LONGS(chip->ngpio);
> +               memset(mask, 0, BITS_TO_LONGS(chip->ngpio) * sizeof(*mask));

Ditto.

-- 
With Best Regards,
Andy Shevchenko
