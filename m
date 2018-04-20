Return-Path: <kernel-hardening-return-13069-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48LwmjWrfSiqfLvnjHraS+zIJMp8opdKPQmH9BVBSVU69dfONM1K5zNc8JLdUzXcqzY9VvX
ARC-Seal: i=1; a=rsa-sha256; t=1524214945; cv=none;
        d=google.com; s=arc-20160816;
        b=ifH1auDkJB8Gz9r80jNgfylPv+8yFRfEd9WJTBJxNpxmhTXDWA4ryuOvjG9e3XYw4Q
         RsxOwhLkCR0DTCvBe8ikTGYpSy1hH0O8EeHELoU6FXy9db4Sf0UvDCEyoukkTZvZk6FB
         dDhRHl1fBC74kAAIl7tEidzwHXxNZPRbrxNz3ToAia0X4FaKqI/n+a1th7oCSYcUKnHc
         KNiFYM8p9Ilofi11+C6g1zAaRA3dxTx2blyw0VB3IsEUB1VcIeMB7dHVfaE2ONjCluHK
         90sLARZnro3VQzFxypCxETFMQE+zifif+nOr5f6lJYqCpgRCPxjalZBhQgKMiX2ElGu8
         j3jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=y8wsMgBcdIDpkVm9NllLhcZSuOJfWpKxemFUpKGlJWE=;
        b=hPgv/zcWmQJgHvDwx930hfqRHIAkDcsbW4m+xz3Ijl1bHEiJm2nPxihv0WlJ+juX2C
         HNDzd5uCQxtgZf4VKuoRIIb7GttWJHF24muV1VHqhqvTz+8+GjuJN2rwEQqefrXBekYL
         OXoV+zzaunNhC8e+x/a3ziBZtIwb4K/PJYQ2k7Xu/A0JOlFAXA1MHQJg82hli5mKOI5q
         E9MimRAusuLhu6+2XwA/fwxkhRunCthNxmN9mThxRdd5mNhLFJPBf2xoOkJJclrgnTyS
         0F0hws0Ej/LEEorjDqa8BjgOIB/RQDcmJ3skPxZhM0VUfV5LAfdQgtV9UA2P3YAJlQxP
         l46w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FsVogQFQ;
       spf=pass (google.com: domain of kernel-hardening-return-13069-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13069-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FsVogQFQ;
       spf=pass (google.com: domain of kernel-hardening-return-13069-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13069-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180413212427.18261-1-labbott@redhat.com>
References: <20180413212427.18261-1-labbott@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Apr 2018 11:02:04 +0200
X-Google-Sender-Auth: hq-dpDU4cKcuJiNdN5KTct7Ks8Y
Message-ID: <CAMuHMdWDysLemM3PNNjC-Aircpu=Y-z=e79zgG8LPzvGCSEetg@mail.gmail.com>
Subject: Re: [PATCHv5] gpio: Remove VLA from gpiolib
To: Laura Abbott <labbott@redhat.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kees Cook <keescook@chromium.org>,
	Lukas Wunner <lukas@wunner.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597409764349726473?=
X-GMAIL-MSGID: =?utf-8?q?1598255209992557305?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Laura,

Thanks for your patch!

On Fri, Apr 13, 2018 at 11:24 PM, Laura Abbott <labbott@redhat.com> wrote:
> The new challenge is to remove VLAs from the kernel
> (see https://lkml.org/lkml/2018/3/7/621) to eventually
> turn on -Wvla.
>
> Using a kmalloc array is the easy way to fix this but kmalloc is still
> more expensive than stack allocation. Introduce a fast path with a
> fixed size stack array to cover most chip with gpios below some fixed
> amount. The slow path dynamically allocates an array to cover those
> chips with a large number of gpios.

Blindly replacing VLAs by allocated arrays is IMHO not such a good solution.
On the largest systems, NR_GPIOS is 2048, so that makes 2 arrays of 256
bytes. That's an uppper limit, and assumes they are all on the same gpiochip,
which they probably aren't.

Still, 2 x 256 bytes is a lot, so I agree it should be fixed.

So, wouldn't it make more sense to not allocate memory, but just process
the request in chunks (say, at most 128 gpios per chunk, i.e. 2 x
16 bytes)? The code already caters for handling chunks due to not all gpios
belonging to the same gpiochip. That will probably also be faster than
allocating memory, which is the main idea behind this API.

> Reviewed-and-tested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Laura Abbott <labbott@redhat.com>

> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c

> @@ -1192,6 +1196,10 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
>                 goto err_free_descs;
>         }
>
> +       if (chip->ngpio > FASTPATH_NGPIO)
> +               chip_warn(chip, "line cnt %d is greater than fast path cnt %d\n",
> +               chip->ngpio, FASTPATH_NGPIO);

FWIW, can this warning be triggered from userspace?

> @@ -2662,16 +2670,28 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
>
>         while (i < array_size) {
>                 struct gpio_chip *chip = desc_array[i]->gdev->chip;
> -               unsigned long mask[BITS_TO_LONGS(chip->ngpio)];
> -               unsigned long bits[BITS_TO_LONGS(chip->ngpio)];

Hence just use a fixed size here...

> +               unsigned long fastpath[2 * BITS_TO_LONGS(FASTPATH_NGPIO)];
> +               unsigned long *mask, *bits;
>                 int first, j, ret;
>
> +               if (likely(chip->ngpio <= FASTPATH_NGPIO)) {
> +                       memset(fastpath, 0, sizeof(fastpath));
> +                       mask = fastpath;
> +                       bits = fastpath + BITS_TO_LONGS(FASTPATH_NGPIO);
> +               } else {
> +                       mask = kcalloc(2 * BITS_TO_LONGS(chip->ngpio),
> +                                          sizeof(*mask),
> +                                          can_sleep ? GFP_KERNEL : GFP_ATOMIC);
> +                       if (!mask)
> +                               return -ENOMEM;
> +                       bits = mask + BITS_TO_LONGS(chip->ngpio);
> +               }
> +
>                 if (!can_sleep)
>                         WARN_ON(chip->can_sleep);
>
>                 /* collect all inputs belonging to the same chip */
>                 first = i;
> -               memset(mask, 0, sizeof(mask));
>                 do {
>                         const struct gpio_desc *desc = desc_array[i];
>                         int hwgpio = gpio_chip_hwgpio(desc);

Out-of-context, the code does:

|                       __set_bit(hwgpio, mask);
|                       i++;
|                 } while ((i < array_size) &&

... and change this limit to "(i < min(array_size, first +
ARRAY_SIZE(mask) * BITS_PER_BYTE))"

|                         (desc_array[i]->gdev->chip == chip));

... and you're done?

> @@ -2878,7 +2904,7 @@ static void gpio_chip_set_multiple(struct gpio_chip *chip,
>         }
>  }
>
> -void gpiod_set_array_value_complex(bool raw, bool can_sleep,
> +int gpiod_set_array_value_complex(bool raw, bool can_sleep,

Same here.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
