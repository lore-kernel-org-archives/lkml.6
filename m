Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751590AbeBRR4I (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 12:56:08 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45002 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbeBRR4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 12:56:06 -0500
X-Google-Smtp-Source: AH8x2272UKnQgVLj2NndrTivnO7GmD23R2RnD1eF0n2GM4JV02CPt10PsZNx8kO8TNaHH48iRIfX9A==
Subject: Re: [PATCH v3] rtc: ac100: Fix ac100 determine rate bug
To: Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, alexandre.belloni@bootlin.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>, linux-rtc@vger.kernel.org,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
References: <20180214135612.21356-1-embed3d@gmail.com>
 <20180215141154.monvwx25awwetqrc@flea.lan>
 <00ece3d8-52ac-c51d-1867-97f7fd84dadf@gmail.com>
 <CAGb2v67fP4-xxAAPWAa0+YtWY3xvQX=5XX7koq-h8USvT+YA-A@mail.gmail.com>
 <20180216130741.jjtjwbnjcmsnz3ds@flea.lan>
 <CAGb2v64xzVO0n8vTx9TfaoPPXv-85OoDk9y4k5KgLfkz70w2FA@mail.gmail.com>
From: Philipp Rossak <embed3d@gmail.com>
Message-ID: <aae613df-f7d8-d9dd-306b-fcda2bbb770f@gmail.com>
Date: Sun, 18 Feb 2018 18:55:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGb2v64xzVO0n8vTx9TfaoPPXv-85OoDk9y4k5KgLfkz70w2FA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.02.2018 14:15, Chen-Yu Tsai wrote:
> On Fri, Feb 16, 2018 at 9:07 PM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
>> On Fri, Feb 16, 2018 at 12:10:18PM +0800, Chen-Yu Tsai wrote:
>>>> diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
>>>> b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
>>>> index 6550bf0e594b..6f56d429f17e 100644
>>>> --- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
>>>> +++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
>>>> @@ -175,11 +175,18 @@
>>>>                          compatible = "x-powers,ac100-rtc";
>>>>                          interrupt-parent = <&r_intc>;
>>>>                          interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>>>> -                       clocks = <&ac100_codec>;
>>>> +                       clocks = <&ac100_rtc_32k>;
>>>>                          #clock-cells = <1>;
>>>>                          clock-output-names = "cko1_rtc",
>>>>                                               "cko2_rtc",
>>>>                                               "cko3_rtc";
>>>> +
>>>> +                       ac100_rtc_32k: rtc-32k-oscillator {
>>>> +                               compatible = "fixed-clock";
>>>> +                               #clock-cells = <0>;
>>>> +                               clock-frequency  = <32768>;
>>>> +                               clock-output-names = "ac100-rtc-32k";
>>>> +                       };
>>>>                  };
>>>>          };
>>>>   };
>>>>
>>>> What do you think about that solution?
>>>
>>> That's not quite right either. As I mentioned before, the
>>> RTC block has two clock inputs, one 4MHz signal from the
>>> codec block, and one 32.768 kHz signal from an external
>>> crystal. The original device tree binding describes the
>>> first one, and the 32.768 kHz clock was registered by
>>> the RTC driver internally.
>>>
>>> If you're going to add the crystal clock, you still need
>>> to keep the codec one. Note that this does not fix what
>>> Maxime is asking you. I've already provided an explanation:
>>>
>>> The clock core allows registering clocks with not-yet-existing
>>> clock parents. Parents are matches by string names. If no
>>> clock by that name is registered yet, the clock core simply
>>> orphans the new clock if the unregistered parent is its
>>> current parent or simply ignores that parent if its not the
>>> current parent. This is entirely valid and is what we are
>>> counting on here, as we haven't implemented the codec-side
>>> driver.
>>
>> So, we end up in a situation where clk_hw_get_num_parents returns the
>> amount of clocks we can be parented to (orphans or not), but
>> clk_hw_get_parent_by_index will not return the orphan clocks?
> 
> There is no placeholder for missing parents, unlike the regulator
> subsystem that has a dummy regulator for this purpose.
> 
>> That's pretty bad :/
> 
> Yeah. I didn't expect this to happen. But to be fair, I should
> have done the check on clk_hw_get_parent_by_index.
> 
>> Is there a way to test before registering that all our parents are
>> actually there? clk_get?
> 
> That's probably the way to do it. However in the AC100 RTC case,
> I left it open to be missing on purpose, so we could use the RTC
> without waiting for the codec to be supported.
> 
> ChenYu
> 

So how should we proceed with this issue?

Should I send a new version with a fixed comment or should I implement 
the check in clk_get function?

For the second option I will need about 3 weeks to submit a proper patch 
since I have the next two weeks some other stuff to do.
If a proper fix is required earlier, it might be better if someone else 
is taking care about a fix.

Philipp
