Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeBZRGC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:06:02 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:43661 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbeBZRGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:06:00 -0500
X-Google-Smtp-Source: AG47ELvMDfwi77zvep9o7v/kwEf6AvT/DOR2xSbNxyT7BM5+r/TFV2tZBuVipjbWwPkfBtKP6ssa+Lg7sIwHHGJ12V4=
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-y3GG+McAK2b8SCmMf60fo_XSHFBAWsKGw3OBvD04ggg@mail.gmail.com>
References: <20180222191647.4727-1-ard.biesheuvel@linaro.org>
 <20180222191647.4727-3-ard.biesheuvel@linaro.org> <CAHp75Vc1AGzdgTB281XVo=FmZerkU1vijLih3JUO=_wNPjxgfA@mail.gmail.com>
 <CAKv+Gu9XkmSPHZf+jVKOm-SX1GCWJUc7y3zTCuaHBwk8O3OC3Q@mail.gmail.com>
 <CAHp75VfFKDkQQ9-vdjzDfE2Cdk2Cb93+kdceYQgEqt3hti=Wkg@mail.gmail.com>
 <CAKv+Gu__HiajW5fWvRnDft3+ef+gOowijxEd8wrF4U5Vu=3o0Q@mail.gmail.com>
 <CAHp75VcjUey4K1xOkjKjn_ppPKC0bktcBK2p9NjcPYG1ed7X0g@mail.gmail.com> <CAKv+Gu-y3GG+McAK2b8SCmMf60fo_XSHFBAWsKGw3OBvD04ggg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Feb 2018 19:05:59 +0200
Message-ID: <CAHp75Vco1wUR7cUu-zuaP-TVMnm+m7X+CctnRC0cgvpuo5S2vg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] i2c: add support for Socionext SynQuacer I2C controller
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1QH67ht025893

On Mon, Feb 26, 2018 at 4:58 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 26 February 2018 at 11:35, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>> On Mon, Feb 26, 2018 at 11:59 AM, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>> On 23 February 2018 at 13:12, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>>> On Fri, Feb 23, 2018 at 2:40 PM, Ard Biesheuvel
>>>> <ard.biesheuvel@linaro.org> wrote:

>>>> Replace 'baudclk' with 'pclk' and p->uartclk with i2c->clkrate in
>>>> above and you are almost done.

>>> I don't think this is better.
>>
>> It's a pattern over ACPI vs. clk cases at least for now.
>> But hold on. We have already an example of dealing with ACPI /
>> non-ACPI cases for I2C controllers — i2c-designware-platdrv.c.
>> Check how it's done there.
>>
>> I actually totally forgot about ACPI slaves described in the table. We
>> need to take into account the ones with lowest bus speed.
>>
>
> Wow, that code is absolutely terrible.

To some degree I may say yes it is.

> So even while _DSD device properties require vendor prefixes, which
> are lacking in this case,

What kind? clock-frequency? Does it require prefix?

> and the fact that the ACPI flavor of the
> Designware I2C controller now provides two different ways to get the
> timing parameters (using device properties or using SSCN/FMCN/etc ACPI
> methods), you think this is a shining example of how this should be
> implemented?

No, those methods because of windows driver and existed ACPI tables at
that time.
You are not supposed to uglify your case.

> Also, I still think implementing a clock device using rate X just to
> interrogate it for its rate (returning X) is absolutely pointless.

OTOH the deviation in the driver is what I absolutely against of.
Driver must not know the resource provider (ideally at all).

> So what I can do is invent an ACPI method that returns the PCLK rate.
> Would that work for you?

Again, looking into existing examples (UART, I2C, etc) we better to
create a generic helper in clock framework that would provide us a
clock based on property value.
But doing different paths for different resource providers is not what
we are looking for.

P.S. To move this somehow forward I may propose to submit an OF
driver, and discuss ACPI part after.

-- 
With Best Regards,
Andy Shevchenko
