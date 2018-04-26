Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755255AbeDZKR6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:17:58 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.170]:14249 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754842AbeDZKRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:17:42 -0400
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WisdN1GTaY
X-RZG-CLASS-ID: mo00
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Letux-kernel] [PATCH v3 2/4] gpio: pca953x: add register definitions for pcal6524 and fix address calculation
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAHp75Vdsdc7K1sGO-WASeF0HCTWv1HaYP7vMxU5YZ1viMwyuDQ@mail.gmail.com>
Date: Thu, 26 Apr 2018 12:17:23 +0200
Cc: Mark Rutland <mark.rutland@arm.com>,
        Alexandre Courbot <gnurou@gmail.com>, Pawel Moll <pawel.moll@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>, kernel@pyra-handheld.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>
Message-Id: <C60F920E-6873-4CBF-B34B-F3ED21CF5F0E@goldelico.com>
References: <cover.1523376423.git.hns@goldelico.com> <0e9bea79eae7504e61fabdb4a0311f8fdc2f6b25.1523376423.git.hns@goldelico.com> <CAHp75VfYk1tSJ9PUshDvY2RaYrc+wR+hyrK8Ck1oQSUXPr-0fQ@mail.gmail.com> <EDF7FA02-C79C-4ADF-A10C-F8C4DBFE5158@goldelico.com> <65085C47-CDA8-4F8C-8307-C145F21F7D19@goldelico.com> <CAHp75Vdsdc7K1sGO-WASeF0HCTWv1HaYP7vMxU5YZ1viMwyuDQ@mail.gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3QAI3kH019720

Hi Andy,

> Am 26.04.2018 um 12:06 schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:
> 
> On Wed, Apr 25, 2018 at 9:05 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>>> Am 11.04.2018 um 07:00 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
>>>> Am 10.04.2018 um 20:06 schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:
>>>> On Tue, Apr 10, 2018 at 7:07 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
> 
>>>>> PCAL chips ("L" seems to stand for "latched") have additional
>>>>> registers starting at address 0x40 to control the latches,
>>>>> interrupt mask, pull-up and pull down etc.
>>>>> 
>>>>> The constants are so far defined in a way that they fit for
>>>>> the pcal9555a when shifted by the number of banks, i.e. multiplied
>>>>> by 2.
>>>>> 
>>>>> Now the pcal6524 has 3 banks which means the relative offset
>>>>> must be multiplied by 4 which gives a wrong result if not done
>>>>> carefully, since the base offset is already included in the offset.
>>>>> 
>>>>> For the basic registers shared with all pca93xx/tca64xx chips
>>>>> there is no such offset.
>>>>> 
>>>>> Therefore, we add code to adjust the register number for exended
>>>>> registers to the 24 bit accessor functions.
>>>>> 
>>>>> And we add additional register offset constants (not yet used by
>>>>> the driver code) which are specific to the pcal6524.
> 
>>>> First of all, as I said, please split this to two patches. Don't mix the things.
>>> Ok. Queued for v4.
> 
> I actually think it would be even more patches:
> - move to hex from dec
> - add new definitions for PCAL953x
> - append new code for registers (see below)
> - add definitions for PCAL6524

It is already done in my local git,
just waiting for the address thing...

> 
>>>>> +       /* adjust register address for pcal6524 */
>>>>> +       if (reg >= PCAL953X_OUT_STRENGTH)
>>>>> +               reg -= PCAL953X_OUT_STRENGTH >> 1;
>>>>> +
>>>> 
>>>> Give me some days to think about it.
> 
> So, what about something like:
> 
> --- 8< --- 8< ---
> #define PCAL953X_GPIO_MASK GENMASK(5,0) // this makes sense even for
> your initial solution
> 
> int bank_shift = fls((chip->gpio_chip.ngpio - 1) / BANK_SZ);
> int addr = (reg & PCAL953X_GPIO_MASK) << bank_shift;
> int pinctrl = (reg & ~PCAL953X_GPIO_MASK) << 1;

Ok! Intersting idea.

Basically decomposes register bank number (pinctrl) and register offset (addr)
and shifts them differently.

> 
> return i2c_smbus_write_i2c_block_data(chip->client,
>                                             pinctrl | addr  | REG_ADDR_AI,
>                                             NBANK(chip), val);
> 
> // similar for read.

Looks good. I'll test asap.

BR and thanks,
Nikolaus

> 
> --- 8< --- 8< ---
> 
> Keep in mind your solution has a bug for registers starting from 0x30.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
