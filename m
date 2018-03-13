Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753109AbeCMUUh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 16:20:37 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34163 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751984AbeCMUUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 16:20:34 -0400
X-Google-Smtp-Source: AG47ELv7REyiWqFd9pXeOGx65BZSMABij+/tYBxT/K9+ORHUsdK5kjGoomwf+P+p1a7e3nbR1c6a2w==
Date: Tue, 13 Mar 2018 16:20:27 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/8] gpio: pci-idio-16: Implement get_multiple callback
Message-ID: <20180313202027.GA14944@sophia>
References: <cover.1520886945.git.vilhelm.gray@gmail.com>
 <e6a13288c45f824ba23ee8d1410cf0bf9c55fe60.1520886945.git.vilhelm.gray@gmail.com>
 <CAHp75Vf9+=rie5oqmAp7yW3_AirGuvBtxGS=6y9UBHzjpvD9ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75Vf9+=rie5oqmAp7yW3_AirGuvBtxGS=6y9UBHzjpvD9ww@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 06:04:33PM +0200, Andy Shevchenko wrote:
>On Mon, Mar 12, 2018 at 10:49 PM, William Breathitt Gray
><vilhelm.gray@gmail.com> wrote:
>
>> +static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
>> +       unsigned long *mask, unsigned long *bits)
>> +{
>
>
>> +       /* clear bits array to a clean slate */
>> +       for (i = 0; i < chip->ngpio; i += BITS_PER_LONG)
>> +               bits[i / BITS_PER_LONG] = 0;
>
>bitmap_clear() or bitmap_zero()

bitmap_zero() would be perfect for this situation. I'll submit a version
2 of this patchset with this change for the various drivers herein.

>
>> +       /* get bits are evaluated a gpio register size at a time */
>> +       for (i = 0; i < chip->ngpio; i += gpio_reg_size) {
>> +               bit_word_offset = i % BITS_PER_LONG;
>> +               bits_mask = mask[BIT_WORD(i)] & (reg_mask << bit_word_offset);
>> +               if (!bits_mask) {
>> +                       /* no get bits in this register so skip to next one */
>> +                       continue;
>> +               }
>
>for_each_set_bit() ?
>
>> +               /* store acquired bits */
>> +               bits[BIT_WORD(i)] |= port_state << bit_word_offset;
>
>__set_bit()
>__clear_bit()

I'm not sure for_each_set_bit() and __set_bit()/__clear_bit() would be
good for this particular situation since I'm working with the entire
register word (8 bits for this specific device) at a time.

Since I know each register word is 8-bits, I can make 8-bit jumps and
skips rather than evaluating each bit individually. Similarly, it seems
more efficient to store the input 8 bits at a time rather than breaking
it up to individual bits.

However, I do see how all these inline bitwise operations could make it
difficult to follow the code, so perhaps I can break it up across more
lines so that the logic of the loop becomes easier to read.

William Breathitt Gray

>
>We have bitmap API for *ages*. Is it too hard to check?
>
>-- 
>With Best Regards,
>Andy Shevchenko
