Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751772AbeDYKJ7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 06:09:59 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:44220 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751328AbeDYKJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 06:09:56 -0400
X-Google-Smtp-Source: AB8JxZrpBhdR8op1rpWhZG9dGvGAnY1YJCEPlMwYKNTbBLzW9QRnO2wbyvHPSU06NljyEtu+YTiN09d+yToxli8YVCo=
MIME-Version: 1.0
In-Reply-To: <acce5103-6b72-ed67-7ac1-ffbbed268e9a@ti.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-13-git-send-email-david@lechnology.com> <CAMRc=MfQuqTK+mDT0Gawa6J-3d1z6djLutaHREKfVm+3hATEqQ@mail.gmail.com>
 <CAEG3pND6Cu0P_t3y_VM9Sm-GCb3yW0Pa8q4cRUOXYxa5=2nWUQ@mail.gmail.com>
 <a4d84be0-e3d3-4e39-40f9-cae9006cb6ee@ti.com> <CAMRc=Mc228JAxxBXcObmokh2h-toojG8OHrmbunm_ORqbGWUnA@mail.gmail.com>
 <69bc0848-0698-b936-96a3-2257a5e27809@ti.com> <CAMRc=MenWp=2dtOs1yafnHVkCxfT7SDS0fS2UxUd+U0s_UDwVw@mail.gmail.com>
 <57f2182e-09b4-2cab-5602-9d0e029495be@ti.com> <152303318048.143116.2883441215887455211@swboyd.mtv.corp.google.com>
 <48c8531f-8cd9-a9f8-9c38-cbc4c921c4c9@lechnology.com> <aa1c2e6f-793c-1d9e-366a-3496f500f946@ti.com>
 <d32a4cd5-4344-6e20-fdca-1ed830a52466@lechnology.com> <acce5103-6b72-ed67-7ac1-ffbbed268e9a@ti.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 25 Apr 2018 12:09:55 +0200
Message-ID: <CAMRc=McpzVXy5BggV9t8UHJi4oO9_69_WKca+MzfsM-a+vCpPg@mail.gmail.com>
Subject: Re: [PATCH v5 12/44] clk: davinci: Add platform information for TI
 DA850 PSC
To: Sekhar Nori <nsekhar@ti.com>
Cc: David Lechner <david@lechnology.com>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-25 8:07 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
> On Tuesday 24 April 2018 09:41 PM, David Lechner wrote:
>> On 04/24/2018 03:28 AM, Sekhar Nori wrote:
>>> On Monday 23 April 2018 08:29 PM, David Lechner wrote:
>>>> On 04/06/2018 11:46 AM, Stephen Boyd wrote:
>>>>> Quoting Sekhar Nori (2018-04-06 02:37:03)
>>>>>>
>>>>>> Can you please check that and confirm there is no issue with genpd and
>>>>>> using CLK_OF_DECLARE() to initialize clocks?
>>>>>>
>>>>>> Unless you report an issue back, or Mike and Stephen have ideas about
>>>>>> how to handle the dependency between PSC/PLL derived timer clock
>>>>>> initialization and and timer_probe(), I think we need to move back to
>>>>>> using CLK_OF_DECLARE().
>>>>>
>>>>> In such a case, please use the hybrid approach where the clks required
>>>>> for the clockevent and/or clocksource are registered in the early
>>>>> CLK_OF_DECLARE path but the rest of the clks get registered with a
>>>>> proper platform device and driver. There are examples of this approach
>>>>> on other platforms already.
>>>>>
>>>>
>>>> I looked at this a bit last week, but I didn't come up with any approach
>>>> that I was happy with. It seems like it would be nice to just register
>>>> the absolute minimum clocks needed. On DA8XX, that would just be the
>>>> PLL0
>>>> AUXCLK. On most of the other SoCs, it would be the PLL AUXCLK plus one
>>>> LPSC clock. The AUXCLKs are easy because they are just a simple gate
>>>> from the oscillator. The LPSC clocks are a bit more tricky because they
>>>> have a complex sequence for turning on. Furthermore, on DM646X, we need
>>>> the whole PLL up to SYSCLK3 plus one LPSC clock, so things get a bit
>>>> messy there.
>>>
>>> Things might change in the context of work being done here by Bartosz
>>> for converting clocks to early platform devices.
>>>
>>> But, keeping that development aside for a moment: I think this means the
>>> PLLs and PSCs need to be CLK_OF_DECLARE(). What we can have as platform
>>> devices are clocks that are not in the path to get timer clock working
>>> (like CFGCHIP clocks).
>>
>> CLK_OF_DECLARE() only matters on DA850. None of the other SoCs use device
>
> Thats true today, but lets not make the assumption that none of the
> other DaVinci SoCs will gain DT support ever. We don't want churn in CCF
> support once someone tries to add DT support for other platforms.
>
> I already have people using DM365 in mainline, for example.
>
>> tree. And on DA850, the timer0 clock is just the PLL0 AUXCLK, so PSCs can> still be platform devices there. And in fact, one of the PSC clocks on
>> DA850 depends on async3, which is a CFGCHIP clock, so if we made the PSCs
>> CLK_OF_DECLARE(), then we also have to make at least the async3 CFGCHIP
>> clock CLK_OF_DECLARE(). But, like I said, I think that can be avoided by
>> leaving the PSC clocks as a platform device on DA850 (and DA830).
>
> Okay, I did not realize that there is a dependency between CFGCHIP clk
> and PSC too.
>
>> For everything else, we need the legacy board file equivalent of
>> CLK_OF_DECLARE(), which is basically what I had here in v5 of the
>> series.
>
> Yeah. I did not realize the dependency with timer when platform devices
> were suggested. Sorry.
>
>>
>> So, if we want this to keep moving before the if/when of Bartosz's
>> early platform device stuff, I'm thinking that I will make the PLL
>
> After looking at feedback to Bartosz's series, and the fact that
> previous attempts at doing the same thing were rejected, I think there
> is benefit in keeping CCF support moving independent Bartosz's work.
> Otherwise, we have no chance of getting anything merged for v4.18.
>

It's true, that the feedback was not very positive, but I'm still
thinking I can come up with something that would get accepted. Last
time someone came up with the idea, the problem it was supposed to
solve was different (dependencies between devices) and was eventually
fixed with introduction of probe deferral.

This time around we really want these devices probed early. The main
concern was using a device tree compatible. If I can instead just
early probe all devices whose drivers are registered as early without
touching the device tree (as Frank Rowand suggested) then maybe the
response of the community would be better.

Thanks,
Bart

> Early initialization of clocks and dependency with timer is a pretty
> common theme across SoCs. As and when a better way to support is found,
> I am sure DaVinci can be converted over along with rest of the devices.
>
>> and PSC drivers loadable with or without a platform device and let
>> each SoC pick which one it should use.
>
> This sounds flexible. We have to see how the patches look. But I would
> caution against adding a lot of dead code. If there is no way some of
> the clocks will be useful as platform device, I see no point of
> supporting them as such just in anticipation.
>
> Thanks,
> Sekhar
