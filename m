Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752878AbeCUSuA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 14:50:00 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36621 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752527AbeCUSt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 14:49:57 -0400
X-Google-Smtp-Source: AG47ELu6JFZibDhet9V/qgy/VtfyVSd4eg1yy+u6sI1NWnTD0pTh2pgqAvLCesw/bvSTaxupgh9iRQ==
Date: Wed, 21 Mar 2018 14:49:43 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 3/8] gpio: pci-idio-16: Implement get_multiple callback
Message-ID: <20180321184943.GA24015@sophia>
References: <cover.1521301345.git.vilhelm.gray@gmail.com>
 <6ca4bf0ed930c057bdbcd07bab34ed0a474dd78d.1521301345.git.vilhelm.gray@gmail.com>
 <CAHp75Vfhe4qV73+A+X98bo-cpV0du5pwDERwEc0kPLGB612vmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75Vfhe4qV73+A+X98bo-cpV0du5pwDERwEc0kPLGB612vmw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 07:45:29PM +0200, Andy Shevchenko wrote:
>On Sat, Mar 17, 2018 at 5:50 PM, William Breathitt Gray
><vilhelm.gray@gmail.com> wrote:
>> The ACCES I/O PCI-IDIO-16 series of devices provides 16
>> optically-isolated digital inputs accessed via two 8-bit ports. Since
>> eight input lines are acquired on a single port input read, the
>> PCI-IDIO-16 GPIO driver may improve multiple input reads by utilizing a
>> get_multiple callback. This patch implements the
>> idio_16_gpio_get_multiple function which serves as the respective
>> get_multiple callback.
>
>> +static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
>> +       unsigned long *mask, unsigned long *bits)
>> +{
>> +       struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
>> +       size_t i;
>> +       const unsigned int gpio_reg_size = 8;
>> +       unsigned int bits_offset;
>> +       size_t word_index;
>> +       unsigned int word_offset;
>> +       unsigned long word_mask;
>
>> +       const unsigned long port_mask = GENMASK(gpio_reg_size, 0);
>
>gpio_reg_size - 1?

Oops, looks like I made an off-by-one error here so I'll make sure to
fix that up.

>Though I would prefer not to have that variable at all, just use 8 or
>7 respectively.

This device is simple enough that throughout this function I could
inline gpio_reg_size and port_mask to 8 and 0xFF respectively, but I
would like to keep the code generic enough for reuse in other drivers.
In addition, I believe the variable names help keep the intention of the
code clear, so I'll stick with dedicated const variables for now if
there are no other objections.

>
>> +       unsigned long port_state;
>
>> +       u8 __iomem ports[] = {
>> +               idio16gpio->reg->out0_7, idio16gpio->reg->out8_15,
>
>> +               idio16gpio->reg->in0_7, idio16gpio->reg->in8_15
>
>I would leave comma even here.

Will do.

>
>> +       };
>
>> +       /* get bits are evaluated a gpio port register at a time */
>> +       for (i = 0; i < ARRAY_SIZE(ports); i++) {
>> +               /* gpio offset in bits array */
>> +               bits_offset = i * gpio_reg_size;
>> +
>> +               /* word index for bits array */
>> +               word_index = BIT_WORD(bits_offset);
>> +
>> +               /* gpio offset within current word of bits array */
>> +               word_offset = bits_offset % BITS_PER_LONG;
>> +
>> +               /* mask of get bits for current gpio within current word */
>> +               word_mask = mask[word_index] & (port_mask << word_offset);
>> +               if (!word_mask) {
>> +                       /* no get bits in this port so skip to next one */
>> +                       continue;
>> +               }
>> +
>> +               /* read bits from current gpio port */
>> +               port_state = ioread8(ports + i);
>> +
>> +               /* store acquired bits at respective bits array offset */
>> +               bits[word_index] |= port_state << word_offset;
>> +       }
>
>I would propose to do other way around, i.e.
>read all ports to the bitmap array and call bitmap_and() after.
>
>Further optimization can be something like introduction of generic
>
>bitmap_copy_uXX_off(unsigned long *dst, u8 src, unsigned int offset);
>
>It can be done using macros, though it's another story not quite
>related to the topic.

Port I/O is significantly more costly to perform than the bitmask
evaluations for each port. Despite the increased complexity of the loop
logic, I believe the latency improvements of skipping unnecessary I/O
port reads are worth the trouble.

I do like the idea of a bitmap_copy_uXX_off macro as that could be quite
useful in general. Even if not for this particular patchset, I would be
interested in seeing that functionality added to the bitmap API. Perhaps
I might implement it as a standlone patch when I have some free time.

William Breathitt Gray

>
>> +}
>
>-- 
>With Best Regards,
>Andy Shevchenko
