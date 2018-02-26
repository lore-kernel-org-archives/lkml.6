Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751857AbeBZRvF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:51:05 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:51861 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbeBZRvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:51:02 -0500
X-Google-Smtp-Source: AH8x2268aRIvsHZphJIauyOJhSCu5cZ+TH7QNfDBFhBEX8wTyAYxFU+Vn+Rjo4KL082yg2fPEAv0yJS+0Jql/vOcC6U=
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8ZAt43km=mANa9Ehx1Evbj8cLB5vFsFwji9x6ARvD-sw@mail.gmail.com>
References: <20180222191647.4727-1-ard.biesheuvel@linaro.org>
 <20180222191647.4727-3-ard.biesheuvel@linaro.org> <CAHp75Vc1AGzdgTB281XVo=FmZerkU1vijLih3JUO=_wNPjxgfA@mail.gmail.com>
 <CAKv+Gu9XkmSPHZf+jVKOm-SX1GCWJUc7y3zTCuaHBwk8O3OC3Q@mail.gmail.com>
 <CAHp75VfFKDkQQ9-vdjzDfE2Cdk2Cb93+kdceYQgEqt3hti=Wkg@mail.gmail.com>
 <CAKv+Gu__HiajW5fWvRnDft3+ef+gOowijxEd8wrF4U5Vu=3o0Q@mail.gmail.com>
 <CAHp75VcjUey4K1xOkjKjn_ppPKC0bktcBK2p9NjcPYG1ed7X0g@mail.gmail.com>
 <CAKv+Gu-y3GG+McAK2b8SCmMf60fo_XSHFBAWsKGw3OBvD04ggg@mail.gmail.com>
 <CAHp75Vco1wUR7cUu-zuaP-TVMnm+m7X+CctnRC0cgvpuo5S2vg@mail.gmail.com> <CAKv+Gu8ZAt43km=mANa9Ehx1Evbj8cLB5vFsFwji9x6ARvD-sw@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 26 Feb 2018 17:51:00 +0000
Message-ID: <CAKv+Gu9qc=h1mC=6CHiu5aX0NSjLgzahyQ1xdRWo5ZYwcDir1Q@mail.gmail.com>
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
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1QHp9Jk011068

On 26 February 2018 at 17:16, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 26 February 2018 at 17:05, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>> On Mon, Feb 26, 2018 at 4:58 PM, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>> On 26 February 2018 at 11:35, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>>> On Mon, Feb 26, 2018 at 11:59 AM, Ard Biesheuvel
>>>> <ard.biesheuvel@linaro.org> wrote:
>>>>> On 23 February 2018 at 13:12, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>>>>> On Fri, Feb 23, 2018 at 2:40 PM, Ard Biesheuvel
>>>>>> <ard.biesheuvel@linaro.org> wrote:
>>
>>>>>> Replace 'baudclk' with 'pclk' and p->uartclk with i2c->clkrate in
>>>>>> above and you are almost done.
>>
>>>>> I don't think this is better.
>>>>
>>>> It's a pattern over ACPI vs. clk cases at least for now.
>>>> But hold on. We have already an example of dealing with ACPI /
>>>> non-ACPI cases for I2C controllers — i2c-designware-platdrv.c.
>>>> Check how it's done there.
>>>>
>>>> I actually totally forgot about ACPI slaves described in the table. We
>>>> need to take into account the ones with lowest bus speed.
>>>>
>>>
>>> Wow, that code is absolutely terrible.
>>
>> To some degree I may say yes it is.
>>
>>> So even while _DSD device properties require vendor prefixes, which
>>> are lacking in this case,
>>
>> What kind? clock-frequency? Does it require prefix?
>>
>
> What I remember from the _DSD discussions is that we should vendor
> prefixes for per-device properties, and only use unprefixed names for
> generic properties. However, looking more closely, I understand that
> this undermines the idea of having parity between DT and ACPI, because
> DT did not require vendor prefixes in the past (but it does now)
>
> I guess 'clock-frequency' is one that would not require such a vendor prefix.
>
>>> and the fact that the ACPI flavor of the
>>> Designware I2C controller now provides two different ways to get the
>>> timing parameters (using device properties or using SSCN/FMCN/etc ACPI
>>> methods), you think this is a shining example of how this should be
>>> implemented?
>>
>> No, those methods because of windows driver and existed ACPI tables at
>> that time.
>> You are not supposed to uglify your case.
>>
>
> OK, in that case, can you please spell out what you think is
> mandatory? Because handwavy references to existing UART and I2C
> drivers are not helping me here.
>
>>> Also, I still think implementing a clock device using rate X just to
>>> interrogate it for its rate (returning X) is absolutely pointless.
>>
>> OTOH the deviation in the driver is what I absolutely against of.
>> Driver must not know the resource provider (ideally at all).
>>
>
> There is no 'resource provider'. There is only a single number, which
> is the clock rate, and is only used to calculate some internal
> dividers of the I2C IP block.
>
>>> So what I can do is invent an ACPI method that returns the PCLK rate.
>>> Would that work for you?
>>
>> Again, looking into existing examples (UART, I2C, etc) we better to
>> create a generic helper in clock framework that would provide us a
>> clock based on property value.
>> But doing different paths for different resource providers is not what
>> we are looking for.
>>
>> P.S. To move this somehow forward I may propose to submit an OF
>> driver, and discuss ACPI part after.
>>
>
> Thanks, but that does not really work for me. What I can do is split
> it into an initial DT only driver, and a followup ACPI patch.
>
> Can you point me to an example of such a clock provider?

Perhaps we could agree on the binding first? Currently, I have the following

    Device (I2C0) {
      Name (_HID, "SCX0003")
      Name (_UID, Zero)
      Name (_CRS, ResourceTemplate () {
        Memory32Fixed (ReadWrite, SYNQUACER_I2C1_BASE, SYNQUACER_I2C1_SIZE)
        Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { 197 }
      })

      Name (_DSD, Package ()  // _DSD: Device-Specific Data
      {
        ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
        Package () {
          Package (2) { "socionext,pclk-rate", 62500000 },
        }
      })

and I don't intend to add 'clock-frequency' here because it would be
redundant anyway.

Does this look sane?
