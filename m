Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752068AbeDDMpb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:45:31 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:42592 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751813AbeDDMp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:45:26 -0400
Subject: Re: [PATCH v8 25/42] ARM: davinci: dm644x: add new clock init using
 common clock framework
From: Sekhar Nori <nsekhar@ti.com>
To: David Lechner <david@lechnology.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <1521168778-27236-26-git-send-email-david@lechnology.com>
 <333f49c7-bafd-8e2d-65e9-7d1aff4836de@ti.com>
 <43c266b8-c023-a1b4-c751-bd46c2fb910d@lechnology.com>
 <cda6f3bc-7ca9-68e9-80ca-baf6d4860c95@ti.com>
Message-ID: <030ce534-765b-3059-a6a1-fffaaaba307a@ti.com>
Date: Wed, 4 Apr 2018 18:14:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <cda6f3bc-7ca9-68e9-80ca-baf6d4860c95@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 April 2018 12:17 PM, Sekhar Nori wrote:
> On Tuesday 03 April 2018 10:00 PM, David Lechner wrote:
>> On 04/03/2018 05:26 AM, Sekhar Nori wrote:
>>> On Friday 16 March 2018 08:22 AM, David Lechner wrote:
>>>> +static struct resource dm644x_pll1_resources[] = {
>>>> +    {
>>>> +        .start    = DAVINCI_PLL1_BASE,
>>>> +        .end    = DAVINCI_PLL1_BASE + SZ_4K - 1,
>>>
>>> The .end should be DAVINCI_PLL1_BASE + SZ_1K - 1, otherwise it prevents
>>> PLL2 from getting registered.
>>>
>>>> +        .flags    = IORESOURCE_MEM,
>>>> +    },
>>>> +};
>>>> +
>>>> +static struct platform_device dm644x_pll1_device = {
>>>> +    .name        = "dm644x-pll1",
>>>> +    .id        = -1,
>>>> +    .resource    = dm644x_pll1_resources,
>>>> +    .num_resources    = ARRAY_SIZE(dm644x_pll1_resources),
>>>> +};
>>>> +
>>>> +static struct resource dm644x_pll2_resources[] = {
>>>> +    {
>>>> +        .start    = DAVINCI_PLL2_BASE,
>>>> +        .end    = DAVINCI_PLL2_BASE + SZ_4K - 1,
>>>
>>> And this too should be fixed, else it prevents the PSC from getting
>>> registered.
>>>
>>>> +        .flags    = IORESOURCE_MEM,
>>>> +    },
>>>> +};
>>>
>>> With these fixed, I still had to enable 'clk_ignore_unused' on DM644x
>>> EVM to get to NFS boot. I think root of the problem is that pm_runtime()
>>> APIs are not working in the legacy boot mode.
>>>
>>> This can be seen even on the DA850 LCDK in legacy boot. pm_genpd_summary
>>> in debugfs shows all domains are off and there are no devices registered
>>> under the "da850-psc1: emac" domain. NFS mounting still works on the
>>> DA850 LCDK because clk_summary shows enable and prepare count of 4 for
>>> emac. Not sure how that's happening. But on DM644x EVM, the emac clock
>>> enable count is 0.
>>>
>>> Still looking at whats going wrong here. I am testing your v8 branch
>>> with clk-davinci branch from clk-next merged to get the fixes Stephen
>>> made.
>>>
>>
>> In legacy mode, genpd is not being used. I didn't see any mechanism for
> 
> Ah, I got stumped by the genpd related debug entries popping up.
> Probably something should be done to make sure they don't show up in
> legacy boot. And some comments to that effect in psc.c will help.
> 
>> genpd lookup without device tree. So, we are still relying on the
>> matching in arch/arm/mach-davinci/pm_domain.c.
> 
> This is fine. We just need legacy boot to keep working without regressions.
> 
>>
>> I suspect we need to fix the clock lookups in
>> drivers/clk/davinci/psc-dm644x.c.
>>
>> LPSC_CLKDEV2(emac_clkdev,        NULL,        "davinci_emac.1",
>>                     "fck",        "davinci_mdio.0");
>>
>> NULL might need to be changed to "fck" to be picked up by pm matching
>> and "davinci_emac.1" should be verified that it matches the actual EMAC
>> device name.
> 
> NULL con_id matches what we have for DA850 and also what we had for
> DM644x prior to CCF conversion. So, I did not really suspect that. The
> device name does match. I will check what else could be going on based
> on your input.

This issue is because emac platform device is getting registered really
early on dm644x even before the clocks are ready in postcore_initcall().

I will send a patch fixing that.

Thanks,
Sekhar
