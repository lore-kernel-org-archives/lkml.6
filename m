Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752137AbeBZDBX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 22:01:23 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46672 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751945AbeBZDBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 22:01:18 -0500
X-Google-Smtp-Source: AG47ELtSTKCMHs11xfiHdGkBNqGL/ndy989Vf5LkEcma2w+EbfVII3q7RWT5g/o6shU9aSTdFty0+XlUQu5wFIkrVf0=
MIME-Version: 1.0
In-Reply-To: <CAHp75VdvLDEmNs-YUFYf+Og18kaU6j6zAxXc1w31X2vw26ACHQ@mail.gmail.com>
References: <334505d3a13a73ad347427b408ed581832434289.1519468782.git.baolin.wang@linaro.org>
 <f4a2fefb4c3179e7598dbc8141a661833200b922.1519468782.git.baolin.wang@linaro.org>
 <CAHp75VdvLDEmNs-YUFYf+Og18kaU6j6zAxXc1w31X2vw26ACHQ@mail.gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Mon, 26 Feb 2018 11:01:17 +0800
Message-ID: <CAMz4kuJ+BmWnSFFvE91Ric-Wm6tzxs_a5UWMx82tPj_ZVvC4tw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] gpio: Add Spreadtrum PMIC EIC driver support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 25 February 2018 at 20:19, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Sat, Feb 24, 2018 at 12:44 PM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> The Spreadtrum PMIC EIC controller contains only one bank of debounce EIC,
>> and this bank contains 16 EICs. Each EIC can only be used as input mode,
>> as well as supporting the debounce and the capability to trigger interrupts
>> when detecting input signals.
>
>> +/*
>> + * These registers are modified under the irq bus lock and cached to avoid
>> + * unnecessary writes in bus_sync_unlock.
>> + */
>> +enum { REG_IEV, REG_IE, REG_TRIG, CACHE_NR_REGS };
>
> One item per line.

Sure.

>
>> +static int sprd_pmic_eic_direction_input(struct gpio_chip *chip,
>> +                                        unsigned int offset)
>> +{
>> +       /* EICs are always input, nothing need to do here. */
>> +       return 0;
>> +}
>> +
>> +static void sprd_pmic_eic_set(struct gpio_chip *chip, unsigned int offset,
>> +                             int value)
>> +{
>> +       /* EICs are always input, nothing need to do here. */
>> +}
>
> Remove both.
>
> Look at what GPIO core does.

I've checked the GPIO core, we need the
sprd_pmic_eic_direction_input() returns 0, since user can set GPIOD_IN
flag when requesting one GPIO, otherwise it will return errors.
We also need one dummy sprd_pmic_eic_set() when setting debounce for
one GPIO, otherwise it will return errors.

>
>> +       value |= debounce / 1000;
>
> Possible overflow.

OK. I should & SPRD_PMIC_EIC_DBC_MASK.

>
>> +       for (n = 0; n < chip->ngpio; n++) {
>> +               if (!(BIT(n) & val))
>
> for_each_set_bit().
>
> At some point you may need just to go across lib/ in the kernel and
> see what we have there.

I've considered the for_each_set_bit(), it need one 'unsigned long'
type parameter, but we get the value from regmap is 'u32' type. So we
need one extra conversion from 'u32' to 'unsigned long' like:

unsigned long reg = val;

for_each_set_bit(n, &reg, chip->ngpio) {
        .......
}

If you like this conversion, then I can change to use
for_each_set_bit(). Thanks.

-- 
Baolin.wang
Best Regards
