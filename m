Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967487AbeBPMtl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:49:41 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40245 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966411AbeBPMtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:49:39 -0500
X-Google-Smtp-Source: AH8x224pfw8W9z4YdBlZWeeoWO/egYIotYlWfe/ep9SzGobKEdbxxfJ1FeSIPO75a0Gno6Ixf+aowQ==
Subject: Re: [PATCH v3] rtc: ac100: Fix ac100 determine rate bug
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>, alexandre.belloni@bootlin.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>, linux-rtc@vger.kernel.org,
        linux-clk@vger.kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180214135612.21356-1-embed3d@gmail.com>
 <20180215141154.monvwx25awwetqrc@flea.lan>
 <00ece3d8-52ac-c51d-1867-97f7fd84dadf@gmail.com>
 <CAGb2v67fP4-xxAAPWAa0+YtWY3xvQX=5XX7koq-h8USvT+YA-A@mail.gmail.com>
From: Philipp Rossak <embed3d@gmail.com>
Message-ID: <0af79515-ed4f-a4c6-6358-2053e8fd1745@gmail.com>
Date: Fri, 16 Feb 2018 13:49:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGb2v67fP4-xxAAPWAa0+YtWY3xvQX=5XX7koq-h8USvT+YA-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.02.2018 05:10, Chen-Yu Tsai wrote:
> On Fri, Feb 16, 2018 at 1:53 AM, Philipp Rossak <embed3d@gmail.com> wrote:
>>
>>
>> On 15.02.2018 15:11, Maxime Ripard wrote:
>>>
>>> On Wed, Feb 14, 2018 at 02:56:12PM +0100, Philipp Rossak wrote:
>>>>
>>>> This patch fixes a bug, that prevents the Allwinner A83T and the A80
>>>> from a successful boot.
>>>>
>>>> The bug is there since v4.16-rc1 and appeared after the clk branch was
>>>> merged.
>>>
>>>
>>> Out of curiosity, which patch has introduced this? I couldn't find any
>>> obvious match.
>>>
>>
>> I wasn't also n
> 
> To be honest, I'm not sure why this is hitting you and not me.
> I have both A83T boards that have assigned-clock-rates set for
> the ac100 clock outputs for WiFi. I have them running 4.16-rc1
> and have not seen this. The device tree patches that add these
> are in 4.15.
> 

Now it is getting curious ... .
I already mentioned that bug in the sunxi-irc and someone else was 
hitting that problem also...
I tested it also with the same toolchain you are using (gcc 7.3.0-1 
Debian), but that didn't made any difference.

I don't think that issue is related with the Hardware, but to be on the 
save side: Which Hardware version of the BPI-M3 do you have? I have 
version 1.2.

Can someone else can confirm this bug?

>>
>>>> You can find the shortend trace below:
>>>>
>>>> Unable to handle kernel NULL pointer dereference at virtual address
>>>> 00000000
>>>> pgd = (ptrval)
>>>> [00000000] *pgd=00000000
>>>> Internal error: Oops: 5 [#1] SMP ARM
>>>> Modules linked in:
>>>> CPU: 0 PID: 49 Comm: kworker/0:1 Not tainted 4.15.0-10190-gb89e32ccd1be
>>>> #2
>>>> Hardware name: Allwinner sun8i Family
>>>> Workqueue: events deferred_probe_work_func
>>>> PC is at clk_hw_get_rate+0x0/0x34
>>>> LR is at ac100_clkout_determine_rate+0x48/0x19c
>>>>
>>>> [ ... ]
>>>>
>>>> (clk_hw_get_rate) from (ac100_clkout_determine_rate+0x48/0x19c)
>>>> (ac100_clkout_determine_rate) from  (clk_core_set_rate_nolock+0x3c/0x1a0)
>>>> (clk_core_set_rate_nolock) from (clk_set_rate+0x30/0x88)
>>>> (clk_set_rate) from (of_clk_set_defaults+0x200/0x364)
>>>> (of_clk_set_defaults) from (platform_drv_probe+0x18/0xb0)
>>>>
>>>> To fix that bug, we first check if the return of the
>>>> clk_hw_get_parent_by_index is non zero. If it is zero we skip that
>>>> clock parent.
>>>>
>>>> The BUG report could be found here: https://lkml.org/lkml/2018/2/10/198
>>>>
>>>> Fixes: 04940631b8d2 ("rtc: ac100: Add clk output support")
>>>>
>>>> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
>>>> ---
>>>>
>>>> Changes in v3:
>>>>          * add information when the bug appeared
>>>>          * make the comment more clear
>>>> Changes in v2:
>>>>          * add tag Fixes: ... to commit message
>>>>          * add comment to if statement why we are doing this check
>>>>
>>>>    drivers/rtc/rtc-ac100.c | 19 ++++++++++++++++++-
>>>>    1 file changed, 18 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/rtc/rtc-ac100.c b/drivers/rtc/rtc-ac100.c
>>>> index 8ff9dc3fe5bf..2412aa2e8399 100644
>>>> --- a/drivers/rtc/rtc-ac100.c
>>>> +++ b/drivers/rtc/rtc-ac100.c
>>>> @@ -183,7 +183,24 @@ static int ac100_clkout_determine_rate(struct clk_hw
>>>> *hw,
>>>>          for (i = 0; i < num_parents; i++) {
>>>>                  struct clk_hw *parent = clk_hw_get_parent_by_index(hw,
>>>> i);
>>>> -               unsigned long tmp, prate = clk_hw_get_rate(parent);
>>>> +               unsigned long tmp, prate;
>>>> +
>>>> +               /*
>>>> +                * The clock has two parents, one is a fixed clock which
>>>> is
>>>> +                * internally registered by the ac100 driver. The other
>>>> parent
>>>> +                * is a clock from the codec side of the chip, which we
>>>> +                * properly declare and reference in the devicetree and
>>>> is
>>>> +                * not implemented in any driver right now.
>>>> +                * If the clock core looks for the parent of that second
>>>> +                * missing clock, it can't one that is registered and
>>>> +                * returns NULL.
>>>> +                * Thus we need to check if the parent exists before
>>>> +                * we get the parent rate.
>>>> +                */
>>>> +               if (!parent)
>>>> +                       continue;
>>>
>>>
>>> I'm sorry, but I still don't get it. When you register that clock, you
>>> will give it two parents. Why would that change during the life of the
>>> clock?
>>>
>>> This really looks like a workaround rather than an actual fix.
>>>
>>> Maxime
>>>
>> I agree this is more a workaround!
>> A proper solution/fix would be to define the devicetree correct like this:
>>
>> diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
>> b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
>> index 6550bf0e594b..6f56d429f17e 100644
>> --- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
>> +++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
>> @@ -175,11 +175,18 @@
>>                          compatible = "x-powers,ac100-rtc";
>>                          interrupt-parent = <&r_intc>;
>>                          interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>> -                       clocks = <&ac100_codec>;
>> +                       clocks = <&ac100_rtc_32k>;
>>                          #clock-cells = <1>;
>>                          clock-output-names = "cko1_rtc",
>>                                               "cko2_rtc",
>>                                               "cko3_rtc";
>> +
>> +                       ac100_rtc_32k: rtc-32k-oscillator {
>> +                               compatible = "fixed-clock";
>> +                               #clock-cells = <0>;
>> +                               clock-frequency  = <32768>;
>> +                               clock-output-names = "ac100-rtc-32k";
>> +                       };
>>                  };
>>          };
>>   };
>>
>> What do you think about that solution?
> 
> That's not quite right either. As I mentioned before, the
> RTC block has two clock inputs, one 4MHz signal from the
> codec block, and one 32.768 kHz signal from an external
> crystal. The original device tree binding describes the
> first one, and the 32.768 kHz clock was registered by
> the RTC driver internally.
> 
> If you're going to add the crystal clock, you still need
> to keep the codec one. Note that this does not fix what
> Maxime is asking you. I've already provided an explanation:
> 
> The clock core allows registering clocks with not-yet-existing
> clock parents. Parents are matches by string names. If no
> clock by that name is registered yet, the clock core simply
> orphans the new clock if the unregistered parent is its
> current parent or simply ignores that parent if its not the
> current parent. This is entirely valid and is what we are
> counting on here, as we haven't implemented the codec-side
> driver.
> 
> Note we also sort of depend on this behavior for sunxi-ng
> clocks, where in some cases we get circular dependencies
> between clock blocks.
> 
> BTW, since this is mostly related to the clk subsystem,
> please CC the clk maintainers as well.
> 

Ok, I added also now the clk mailing list and maintainers.
As reference this here is the boot log [1].

Im not sure if this in relation to this bug:
But, already with the 4.15 kernel I get from time to time some oops 
during runtime on the a31s (bpi-m2) and all are clock related and causes 
a crash of the system.

Philipp



[1]: https://pastebin.com/5c7hxjsS
