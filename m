Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbeCERq0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 12:46:26 -0500
Received: from vern.gendns.com ([206.190.152.46]:34062 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751723AbeCERqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 12:46:24 -0500
Subject: Re: [PATCH v7 10/42] clk: davinci: New driver for davinci PSC clocks
From: David Lechner <david@lechnology.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-clk@vger.kernel.org,
        linux-devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>, Adam Ford <aford173@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <1519071723-31790-1-git-send-email-david@lechnology.com>
 <1519071723-31790-11-git-send-email-david@lechnology.com>
 <CAMpxmJVxfGtO=kh63KF-5Uqew3yy97DsK4FSd14CyyRQTOhrTA@mail.gmail.com>
 <93696fc8-bb93-aa20-3506-3d7216c17cd2@lechnology.com>
 <CAMpxmJVpMgikNfB4HgNCs+ep+EOHqH5bthiW82LsnDqzLfE5mg@mail.gmail.com>
 <6bbe9bf3-24c1-acd9-200d-513520d34558@lechnology.com>
 <CAMRc=Mdhi=byn4gPY6tVxgGjn9cgvc3smUkjV=Ku9i3euaZZtQ@mail.gmail.com>
 <d1b91c10-fe11-452e-2c68-86e95fb58266@lechnology.com>
Message-ID: <919e6c76-0818-b330-b0f0-71c3c3f4518d@lechnology.com>
Date: Mon, 5 Mar 2018 11:46:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <d1b91c10-fe11-452e-2c68-86e95fb58266@lechnology.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2018 10:23 AM, David Lechner wrote:
> On 03/05/2018 07:02 AM, Bartosz Golaszewski wrote:
>> 2018-03-01 17:44 GMT+01:00 David Lechner <david@lechnology.com>:
>>> On 03/01/2018 02:36 AM, Bartosz Golaszewski wrote:
>>>>
>>>> 2018-02-28 22:40 GMT+01:00 David Lechner <david@lechnology.com>:
>>>>>
>>>>> On 02/28/2018 06:38 AM, Bartosz Golaszewski wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> I think I found the reason for the strange crashes we were
>>>>>> experiencing (emac core->name being NULL) thanks to Sekhar who pointed
>>>>>> me in the right direction.
>>>>>>
>>>>>> The mdio driver fails to probe with v7 due to the supplied clock rate
>>>>>> being wrong. Before failing we register the emac clock with
>>>>>> pm_clk_add_clk(). When clock_ops puts the clock, it decreases the
>>>>>> reference count of the clock, but we never actually increased it in
>>>>>> the first place in the line above. The core clock code then destroys
>>>>>> the associated clk_core structure. When the next user comes around (in
>>>>>> our case the clk debug functions) the system crashes.
>>>>>>
>>>>>> I believe there to be two issues: one is with v7 - we need to increase
>>>>>> the clock reference count in davinci_psc_genpd_attach_dev().
>>>>>>
>>>>>> Second is the error path in the clock framework - we should remove the
>>>>>> destroyed clk_core from the debug list, which is not being done now.
>>>>>>
>>>>>> Why we even need to track the refcount of clk_core is a mistery for me
>>>>>> though. Stephen, Mike?
>>>>>>
>>>>>> Best regards,
>>>>>> Bartosz Golaszewski
>>>>>
>>>>>
>>>>>
>>>>> Great find. I figured it had to be something like this, but I wasn't
>>>>> able to reproduce the problem yet.
>>>>>
>>>>> I suppose it is time to spin up a v8 with some fixes.
>>>>
>>>>
>>>> I still don't know why the mdio clock rate is much lower than in
>>>> mainline though. Any ideas?
>>>>
>>>> Thanks,
>>>> Bart
>>>>
>>>
>>> Now that you have fixed the crash, can you answer the questions I have
>>> asked earlier?
>>>
>>>> Can you post the output of this command so that I can see how your
>>>
>>> clocks are setup:
>>>
>>> cat /sys/kernel/debug/clk/clk_summary
>>>
>>>> Using your workaround, can you run:
>>>
>>>
>>> cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
>>>
>>> If you see:
>>>    1e27000.clock-controller: emac  off-0
>>>
>>> then genpd is not working like it is supposed to. You should see something
>>> like this for device that are working:
>>>            1e27000.clock-controller: uart2  on
>>>      /devices/platform/soc@1c00000/1d0d000.serial        active
>>
>> Hi David, Sekhar,
>>
>> I tried booting the board today over tftp but didn't succeed. I then
>> switched to a normal boot from SD card and the boot process froze at
>> the same moment (right after the DHCP config, or after rtc config if I
>> disabled DHCP in bootargs). I then realized that the emac clock can't
>> be the culprit. After some digging I found out that the late_initcall
>> to clk_disable_unused() disables sysclk6 - the parent of the arm
>> clock, which of course freezes the device.
>>
>> If I remove the call to clk_disable_unused(), I can boot just fine.
>>
>> The following other clocks are disabled before pll0_sysclk6:
>> pll1_sysclk3
>> pll0_obsclk
>> pll0_sysclk7
>>
>> davinci_lpsc_clk_enable() is never called for these clocks - in fact
>> it's not called for any parent that's not explicitly defined in
>> psc-da850.c - I believe this may be one of the reasons. I will get
>> back to debugging it tomorrow.
>>
>> Best regards,
>> Bartosz Golaszewski
>>
> 
> Thanks for continuing to dig into this. I think I know what needs to
> be done now. I think I don't have the dependencies quite right where
> the PSC clocks are being registered before the PLL clocks, in which
> case they aren't getting the correct parent clock.
> 

Bartosz,

One more thing to check: I think I had some typos in da850.dtsi where
I wrote clock_names instead of clock-names. Please make sure this is
fixed in your working branch.
