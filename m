Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752248AbeFEPhZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:37:25 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:38917 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751747AbeFEPhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:37:23 -0400
X-Google-Smtp-Source: ADUXVKL90S+UGXjp+1OY3NaovxFwYBtsSTK/8QAqmbhtslzVqsrbnnaBOeMLIuO3ugOmM0HWAq6NZqAZsmIz3FgabWE=
MIME-Version: 1.0
In-Reply-To: <20180523140635.GB27215@amd>
References: <cover.1526533188.git.hns@goldelico.com> <e70e83f07aebaf702fef90a9fac61e41d8b558b0.1526533188.git.hns@goldelico.com>
 <20180523140635.GB27215@amd>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Jun 2018 18:37:21 +0300
Message-ID: <CAHp75VfxN1RZBFRK6oJ5AzCe_2ej9eYdwt96X+fJZgFy65eaFg@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] gpio: pca953x: fix address calculation for pcal6524
To: Pavel Machek <pavel@ucw.cz>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>,
        Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>,
        kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 5:06 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Thu 2018-05-17 06:59:49, H. Nikolaus Schaller wrote:
>> The register constants are so far defined in a way that they fit
>> for the pcal9555a when shifted by the number of banks, i.e. are
>> multiplied by 2 in the accessor function.
>>
>> Now, the pcal6524 has 3 banks which means the relative offset
>> is multiplied by 4 for the standard registers.
>>
>> Simply applying the bit shift to the extended registers gives
>> a wrong result, since the base offset is already included in
>> the offset.
>>
>> Therefore, we have to add code to the 24 bit accessor functions
>> that adjusts the register number for these exended registers.
>>
>> The formula finally used was developed and proposed by
>> Andy Shevchenko <andy.shevchenko@gmail.com>.

>>       int bank_shift = fls((chip->gpio_chip.ngpio - 1) / BANK_SZ);
>> +     int addr = (reg & PCAL_GPIO_MASK) << bank_shift;
>> +     int pinctrl = (reg & PCAL_PINCTRL_MASK) << 1;

> Is this reasonable to do on each register access? Compiler will not be
> able to optimize out fls and shifts, right?

On modern CPUs fls() is one assembly command. OTOH, any proposal to do
this better?

What I can see is that bank_shift is invariant to the function, and
maybe cached.

-- 
With Best Regards,
Andy Shevchenko
