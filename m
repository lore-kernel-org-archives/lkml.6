Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754058AbeBZO6Z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:58:25 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:35156 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753863AbeBZO6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:58:21 -0500
X-Google-Smtp-Source: AG47ELsuzjRZ8N7NKaAs4P8DaVSQKPYtZv57H9E1SLVQKVuKhHge/j2toHxjQfQeXgD5LLHE7W7RsJMxZanUzCku524=
MIME-Version: 1.0
In-Reply-To: <CAHp75VcjUey4K1xOkjKjn_ppPKC0bktcBK2p9NjcPYG1ed7X0g@mail.gmail.com>
References: <20180222191647.4727-1-ard.biesheuvel@linaro.org>
 <20180222191647.4727-3-ard.biesheuvel@linaro.org> <CAHp75Vc1AGzdgTB281XVo=FmZerkU1vijLih3JUO=_wNPjxgfA@mail.gmail.com>
 <CAKv+Gu9XkmSPHZf+jVKOm-SX1GCWJUc7y3zTCuaHBwk8O3OC3Q@mail.gmail.com>
 <CAHp75VfFKDkQQ9-vdjzDfE2Cdk2Cb93+kdceYQgEqt3hti=Wkg@mail.gmail.com>
 <CAKv+Gu__HiajW5fWvRnDft3+ef+gOowijxEd8wrF4U5Vu=3o0Q@mail.gmail.com> <CAHp75VcjUey4K1xOkjKjn_ppPKC0bktcBK2p9NjcPYG1ed7X0g@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 26 Feb 2018 14:58:19 +0000
Message-ID: <CAKv+Gu-y3GG+McAK2b8SCmMf60fo_XSHFBAWsKGw3OBvD04ggg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] i2c: add support for Socionext SynQuacer I2C controller
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Jassi Brar <jassisinghbrar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1QEwUXA009513

On 26 February 2018 at 11:35, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Mon, Feb 26, 2018 at 11:59 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> On 23 February 2018 at 13:12, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>> On Fri, Feb 23, 2018 at 2:40 PM, Ard Biesheuvel
>>> <ard.biesheuvel@linaro.org> wrote:
>>>> On 23 February 2018 at 12:27, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>>>> On Thu, Feb 22, 2018 at 9:16 PM, Ard Biesheuvel
>>>>> <ard.biesheuvel@linaro.org> wrote:
>> ...
>>>>>> +       ret = device_property_read_u32(&pdev->dev, "clock-frequency",
>>>>>> +                                      &speed_khz);
>>>>>> +       if (ret) {
>>>>>> +               dev_err(&pdev->dev,
>>>>>> +                       "Missing clock-frequency property\n");
>>>>>> +               return -EINVAL;
>>>>>> +       }
>>>>>> +       speed_khz /= 1000;
>>>
>>>>>> +       if (dev_of_node(&pdev->dev)) {
>>>>>> +               i2c->clk = devm_clk_get(&pdev->dev, "pclk");
>>>>>> +               if (IS_ERR(i2c->clk)) {
>>>>>> +                       dev_err(&pdev->dev, "cannot get clock\n");
>>>>>> +                       return PTR_ERR(i2c->clk);
>>>>>> +               }
>>>>>> +               dev_dbg(&pdev->dev, "clock source %p\n", i2c->clk);
>>>>>> +
>>>>>> +               i2c->clkrate = clk_get_rate(i2c->clk);
>>>>>> +               dev_dbg(&pdev->dev, "clock rate %d\n", i2c->clkrate);
>>>>>> +               clk_prepare_enable(i2c->clk);
>>>>>> +       } else {
>>>>>> +               ret = device_property_read_u32(&pdev->dev,
>>>>>> +                                              "socionext,pclk-rate",
>>>>>> +                                              &i2c->clkrate);
>>>>>> +               if (ret)
>>>>>> +                       return ret;
>>>>>> +       }
>>>>>
>>>>> Okay, I got this case. It's more likely the one in 8250_dw.c.
>>>>>
>>>>> Can you do the similar way?
>>>
>>>> Could you elaborate?
>>>
>>> --- 8< --- 8< --- 8< ---
>>>         device_property_read_u32(dev, "clock-frequency", &p->uartclk);
>>>
>>>        /* If there is separate baudclk, get the rate from it. */
>>>        data->clk = devm_clk_get(dev, "baudclk");
>>> ...
>>>        if (IS_ERR(data->clk) && PTR_ERR(data->clk) == -EPROBE_DEFER)
>>>                return -EPROBE_DEFER;
>>>        if (!IS_ERR_OR_NULL(data->clk)) {
>>>                err = clk_prepare_enable(data->clk);
>>>                if (err)
>>>                        dev_warn(dev, "could not enable optional baudclk: %d\n",
>>>                                 err);
>>>                else
>>>                        p->uartclk = clk_get_rate(data->clk);
>>>        }
>>>
>>>        /* If no clock rate is defined, fail. */
>>>        if (!p->uartclk) {
>>>                dev_err(dev, "clock rate not defined\n");
>>>                err = -EINVAL;
>>>                goto err_clk;
>>> --- 8< --- 8< --- 8< ---
>>>
>>> Replace 'baudclk' with 'pclk' and p->uartclk with i2c->clkrate in
>>> above and you are almost done.
>>>
>>
>> I don't think this is better.
>
> It's a pattern over ACPI vs. clk cases at least for now.
> But hold on. We have already an example of dealing with ACPI /
> non-ACPI cases for I2C controllers — i2c-designware-platdrv.c.
> Check how it's done there.
>
> I actually totally forgot about ACPI slaves described in the table. We
> need to take into account the ones with lowest bus speed.
>

Wow, that code is absolutely terrible.

So even while _DSD device properties require vendor prefixes, which
are lacking in this case, and the fact that the ACPI flavor of the
Designware I2C controller now provides two different ways to get the
timing parameters (using device properties or using SSCN/FMCN/etc ACPI
methods), you think this is a shining example of how this should be
implemented?

Also, I still think implementing a clock device using rate X just to
interrogate it for its rate (returning X) is absolutely pointless.

So what I can do is invent an ACPI method that returns the PCLK rate.
Would that work for you?

As for the max I2C speed: I think that looks sane, so I can
incorporate that as well.

>>  The generic DT I2C 'clock-frequency'
>> property denotes the bus clock rate not the rate of the clock that
>> feeds the IP block. This is rather different from the UART bindings.
>
>> Also, I don't want to support 'socionext,pclk-rate' for DT platforms,
>> only for ACPI platforms.
>
> Unfortunately, we are strong against deviations between DT and ACPI in
> case of device properties.
> You may provide a clock and use devm_clk_get() without any concerns
> from where this comes from.
>
> You won't find any deviation in DW I2C driver since there is none,
> while driver works for non-ACPI platforms as well.
>
> --
> With Best Regards,
> Andy Shevchenko
