Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbeB0CfD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 21:35:03 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:44120 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751831AbeB0CfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 21:35:01 -0500
X-Google-Smtp-Source: AG47ELt9mIFOqF1W1+u3LWvp03l2y7niEH0B5s2deQAg14m/RKNYOPHSPk6N5eoKVjNRlrludM1jRuJ7r3YQ259Qumc=
MIME-Version: 1.0
In-Reply-To: <CAHp75VeJiqp74LrsETHTwxd5iaOObRX5bdYXz=rYeHm-4KbgHA@mail.gmail.com>
References: <334505d3a13a73ad347427b408ed581832434289.1519468782.git.baolin.wang@linaro.org>
 <f4a2fefb4c3179e7598dbc8141a661833200b922.1519468782.git.baolin.wang@linaro.org>
 <CAHp75VdvLDEmNs-YUFYf+Og18kaU6j6zAxXc1w31X2vw26ACHQ@mail.gmail.com>
 <CAMz4kuJ+BmWnSFFvE91Ric-Wm6tzxs_a5UWMx82tPj_ZVvC4tw@mail.gmail.com> <CAHp75VeJiqp74LrsETHTwxd5iaOObRX5bdYXz=rYeHm-4KbgHA@mail.gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Tue, 27 Feb 2018 10:35:00 +0800
Message-ID: <CAMz4kuJYEfwLHexq-KA6d9+u4+Cx2M9TAeEkHbbU4GJ-Sz50gg@mail.gmail.com>
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

On 26 February 2018 at 20:02, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Mon, Feb 26, 2018 at 5:01 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> On 25 February 2018 at 20:19, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>> On Sat, Feb 24, 2018 at 12:44 PM, Baolin Wang <baolin.wang@linaro.org> wrote:
>
>>>> +static int sprd_pmic_eic_direction_input(struct gpio_chip *chip,
>>>> +                                        unsigned int offset)
>>>> +{
>>>> +       /* EICs are always input, nothing need to do here. */
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static void sprd_pmic_eic_set(struct gpio_chip *chip, unsigned int offset,
>>>> +                             int value)
>>>> +{
>>>> +       /* EICs are always input, nothing need to do here. */
>>>> +}
>>>
>>> Remove both.
>>>
>>> Look at what GPIO core does.
>>
>> I've checked the GPIO core, we need the
>> sprd_pmic_eic_direction_input() returns 0, since user can set GPIOD_IN
>> flag when requesting one GPIO, otherwise it will return errors.
>
> Right. I thought it depends on presence of direction_output().
>
>> We also need one dummy sprd_pmic_eic_set() when setting debounce for
>> one GPIO, otherwise it will return errors.
>
> This is pretty much a "feature" of GPIO framework. It shouldn't
> require ->set() by logic if there is no output facility.
> OK.
>
>>>> +       for (n = 0; n < chip->ngpio; n++) {
>>>> +               if (!(BIT(n) & val))
>>>
>>> for_each_set_bit().
>>>
>>> At some point you may need just to go across lib/ in the kernel and
>>> see what we have there.
>>
>> I've considered the for_each_set_bit(), it need one 'unsigned long'
>> type parameter, but we get the value from regmap is 'u32' type. So we
>> need one extra conversion from 'u32' to 'unsigned long' like:
>>
>> unsigned long reg = val;
>>
>> for_each_set_bit(n, &reg, chip->ngpio) {
>>         .......
>> }
>>
>> If you like this conversion, then I can change to use
>> for_each_set_bit(). Thanks.
>
> Wouldn't it work like
>
> unsigned long val;
>
> ...regmap_read(..., &val);
>
> ?

It can not work, regmap_read() expects 'unsigned int *'. But I can
convert it like this:

for_each_set_bit(n, (unsigned long *)&val, chip->ngpio) {
         .......
}

-- 
Baolin.wang
Best Regards
