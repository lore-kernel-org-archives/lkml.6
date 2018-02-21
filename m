Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933315AbeBURqc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:46:32 -0500
Received: from mail-oi0-f47.google.com ([209.85.218.47]:37853 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932301AbeBURq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:46:29 -0500
X-Google-Smtp-Source: AH8x226hpvvGw2YJewZgGtGSx9WAnhShv6+KIbUjsR33aOXsRChYA+PwZvVHIaueAVMbvm2nGSlXM7hGU9TozXnFidg=
MIME-Version: 1.0
In-Reply-To: <ebc57f3b-4f5d-612f-5b63-ddda4dd25031@lechnology.com>
References: <1519071723-31790-1-git-send-email-david@lechnology.com>
 <CAMRc=MdT5Vd68eoWfJGv=5_uzD0L5m3Y+wi6r7N6O8y6HZrQSg@mail.gmail.com>
 <6142ab0d-85b1-84da-3a35-bdd8733bebd9@lechnology.com> <CAMRc=Mf_pumyTZPn9T=sG7Ab95YS3KqKc2bT0evhESTRRFeiuQ@mail.gmail.com>
 <ebc57f3b-4f5d-612f-5b63-ddda4dd25031@lechnology.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 21 Feb 2018 18:46:28 +0100
Message-ID: <CAMRc=MdQy-Y3mDh++sfFPhV3o544J-K_P9DMuzWZq9XCfESH5A@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v7_00=2F42=5D_ARM=3A_davinci=3A_convert_to_common?=
        =?UTF-8?Q?_clock_framework=E2=80=8B?=
To: David Lechner <david@lechnology.com>
Cc: linux-clk@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-21 18:05 GMT+01:00 David Lechner <david@lechnology.com>:
> On 02/21/2018 06:01 AM, Bartosz Golaszewski wrote:
>>
>> 2018-02-20 19:39 GMT+01:00 David Lechner <david@lechnology.com>:
>>>
>>> On 02/20/2018 07:33 AM, Bartosz Golaszewski wrote:
>>>>
>>>>
>>>> 2018-02-19 21:21 GMT+01:00 David Lechner <david@lechnology.com>:
>>>>>
>>>>>
>>>>> This series converts mach-davinci to use the common clock framework.
>>>>>
>>>>>
>>>>
>>>> Hi David,
>>>>
>>>> just some quick results from today's playing with v7.
>>>>
>>>> I started out with da850-lcdk with my standard rootfs over NFS. I was
>>>> not able to boot to console so far. The first problem is that mdio
>>>> fails to probe:
>>>>
>>>> libphy: Fixed MDIO Bus: probed
>>>> davinci_mdio 1e24000.mdio: davinci mdio revision 1.5, bus freq 2200000
>>>> davinci_mdio 1e24000.mdio: no live phy, scanning all
>>>> davinci_mdio: probe of 1e24000.mdio failed with error -5> After some
>>>> digging I noticed that the supplied clock rate differs
>>>> between mainline (114000000Hz) vs common-clock-v7 (18000000). Since
>>>> we're not setting the rate in mdio, using LPSC_SET_RATE_PARENT would
>>>> not help like with lcdc.
>>>
>>>
>>>
>>> Can you post the output of this command so that I can see how your
>>> clocks are setup:
>>>
>>> cat /sys/kernel/debug/clk/clk_summary
>>>
>>>
>>>>
>>>> After that, the boot just hangs without ever getting to emac's probe.
>>>
>>>
>>>
>>> Using your workaround, can you run:
>>>
>>> cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
>>>
>>> If you see:
>>>    1e27000.clock-controller: emac  off-0
>>>
>>> then genpd is not working like it is supposed to. You should see
>>> something
>>> like this for device that are working:
>>>            1e27000.clock-controller: uart2  on
>>>      /devices/platform/soc@1c00000/1d0d000.serial        active
>>>
>>>
>>>>
>>>> Once I set the emac clock to always enabled (a workaround that was
>>>> necessary with v6, but could be dropped with my first
>>>> genpd-in-a-separate-driver attempt), I'm getting a rather strange NULL
>>>> pointer dereference:
>>>
>>>
>>>
>>> I noticed this too when adding the power-domains property to some device
>>> tree nodes. This is part of the reason why I didn't add it everywhere.
>>> I wasn't able to figure out the cause of this yet. As a work around
>>> though, please try removing the power-domains property from the emac
>>> and mdio nodes and use your previous workaround of having an always
>>> enabled clock.
>>>
>>>
>>
>> When I use any of the workarounds I just keep getting more problems
>> (e.g. [1] from blk and pinctrl). I only had a couple hours today to
>> play with it but it seems to me we have some memory corruption
>> somewhere. I'll check the initialization order of all the frameworks
>> involved tomorrow.
>>
>> Best regards,
>> Bartosz
>>
>> [1] https://pastebin.com/75mkkuJL
>>
>
> I wonder if we need to delete all of the __init and __initconst attributes
> now that this has been converted to platform devices.
>

Duh... Of course we do. IIRC everything in the init section gets
removed after late_initcall. I'll test that tomorrow.

Bart
