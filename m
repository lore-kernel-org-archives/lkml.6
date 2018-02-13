Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934886AbeBMLz1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 06:55:27 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50427 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934231AbeBMLzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 06:55:25 -0500
X-Google-Smtp-Source: AH8x226XZPqAnCSYXjGVjVpMjIFJ65h/+t+krbd1CSlJei69R5gflgXNUpQRM4ewuV7C7/cfJNVXSg==
MIME-Version: 1.0
In-Reply-To: <9f7123d1-a14b-c51a-d7a8-63c58a3f83dd@gmail.com>
References: <e155f7fc-9c22-d8ac-d142-805812aa9988@gmail.com>
 <b421fae7-b807-5ed8-669d-6ba773ac3eca@gmail.com> <CAGb2v65qNOLRfQXMOoYzH1y-t+YDDhK_wAe1QUKs74Pzu8D84A@mail.gmail.com>
 <9f7123d1-a14b-c51a-d7a8-63c58a3f83dd@gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 13 Feb 2018 19:55:02 +0800
X-Gmail-Original-Message-ID: <CAGb2v67WNfx1p8o=no2uC6Z4hdxoXV2uVVdenxwudBTWKFsbRQ@mail.gmail.com>
Message-ID: <CAGb2v67WNfx1p8o=no2uC6Z4hdxoXV2uVVdenxwudBTWKFsbRQ@mail.gmail.com>
Subject: Re: BUG: A31s Not booting anymore
To: Philipp Rossak <embed3d@gmail.com>
Cc: linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 7:32 PM, Philipp Rossak <embed3d@gmail.com> wrote:
>
>
> On 13.02.2018 03:59, Chen-Yu Tsai wrote:
>>
>> On Tue, Feb 13, 2018 at 9:25 AM, Philipp Rossak <embed3d@gmail.com> wrote:
>>>
>>>
>>>
>>> On 12.02.2018 19:21, Philipp Rossak wrote:
>>>>
>>>>
>>>> Hey,
>>>>
>>>> When I try to boot my A31s (Bananapi M2) u-boot is showing only Starting
>>>> kernel ... . After enabling the earlyprintk I could capture this log:
>>>> [1].
>>>>
>>>> After reverting those 5 commits from Chen-Yu I was able to boot again:
>>>>
>>>>
>>>> clk: sunxi-ng: Support fixed post-dividers on NM style clocks
>>>> 7d333ef1cc1b8c8951f3a2c41f6406e2295d8be9
>>>>
>>>> clk: sunxi-ng: sun8i: a83t: Add /2 fixed post divider to audio PLL
>>>> 10e6eb4f2c5b35ae71c9bc0db83d74238719b453
>>>>
>>>> clk: sunxi-ng: sun8i: a83t: Use sigma-delta modulation for audio PLL
>>>> e952ca3c6b2ffdfbf9618e4bd3e9aad1ff3f5eb4
>>>>
>>>> clk: sunxi-ng: Support fixed post-dividers on MP style clocks
>>>> 946797aa3f08e2f6f5992f3ec2be44791e9b9260
>>>>
>>>> clk: sunxi-ng: sun50i: a64: Add 2x fixed post-divider to MMC module
>>>> clocks
>>>> 83fe3be4d1974f5f50c5e2039a1609f4960e8579
>>>>
>>>>
>>>> I allready tried to fix it with making them save against zero:
>>>>
>>>> if (cmp->common.features & CCU_FEATURE_FIXED_POSTDIV && \
>>>>           cmp->fixed_post_div with)
>>>>                  rate *= cmp->fixed_post_div;
>>>>
>>>> But that didn't help.
>>>>
>>>> Any ideas?
>>>>
>>>> Regards,
>>>> Philipp
>>>>
>>>> [1]: https://pastebin.com/64Fzzqvg
>>>
>>>
>>>
>>> It took me some time, but I have now a few more infos:
>>>
>>> Right now the code breaks at this point here [1], with this clock [2].
>>> If we have a look now at the clock config [3], we see here a table which
>>> is
>>> an u8 array and also a fixed_predivs struct.
>>
>>
>> The u8 array is for mapping the parents from the index in the parents
>> array to the actual register value you listed below.
>>
>> How are you figuring out which clock is triggering this? Because that
>> is not even the right type of clock. The backtrace you posted shows
>> the error occurring in a DIV or M type clock, not the MP type you
>> are pointing to.
>>
>> Could you add some noisy printk calls to the sunxi_ccu_probe()
>> function in drivers/clk/sunxi-ng/ccu_common.c so it's much clearer
>> which clock is failing?
>
>
> Thats what I basically did to find out which clock is failing. This here are
> the changes I'm doing [1]  and thats the dirty log [2]. It fails at clock NR
> 155 which is this one [3] mentioned before.
>
>>
>>
>>>
>>> If we have a look at the function call where it breaks [4], shouldn't the
>>> table be a clk_div_table struct instead of an u8?
>>
>>
>> The table argument is an option. Did you go through how the sunxi-ng
>> driver
>> calls this function? As mentioned above, you are looking at the wrong
>> thing.
>>
>> Thanks
>> ChenYu
>
>
> I followed the failing call to this function (through the clock driver). As
> you can see I added an additional printk statement to see where it fails.

I found the problem... wrong ops for the clock type. Likely a copy-paste
error on my part. I'll send a patch later.

Sorry for being so harsh on you.

ChenYu

> Regards,
> Philipp
>
>>
>>>
>>> The a31s is the only board where we have this combination of a
>>> fixed_predivs
>>> and a table.
>>>
>>> Philipp
>>>
>>>
>>> Related Clock source register A31s:
>>>
>>> 0000: OSC24MHz/750=32KHz
>>> 0001: LOSC
>>> 0010: OSC24MHz
>>> 0011: /
>>> 0100: /
>>> 0101: /
>>> 0110: /
>>> 0111: /
>>> 1000: /
>>> 1001: /
>>> 1010: /
>>> 1011: AXICLK/4
>>> 1100: /
>>> 1101: AHB1CLK/4
>>> 1110: /
>>> 1111: /
>>>
>>>
>>> [1]:
>>>
>>> http://lxr.bootlin.com/linux/v4.16-rc1/source/drivers/clk/clk-divider.c#L89
>>>
>>> [2]:
>>>
>>> http://lxr.bootlin.com/linux/v4.16-rc1/source/drivers/clk/sunxi-ng/ccu-sun6i-a31.c#L1137
>>>
>>> [3]:
>>>
>>> http://lxr.bootlin.com/linux/v4.16-rc1/source/drivers/clk/sunxi-ng/ccu-sun6i-a31.c#L749
>>>
>>> [4]:
>>>
>>> http://lxr.bootlin.com/linux/v4.16-rc1/source/drivers/clk/clk-divider.c#L93
>>>
>
> [1]: https://pastebin.com/tvDunAWq
> [2]: https://pastebin.com/SBn2VQLu
> [3]:
> http://lxr.bootlin.com/linux/v4.16-rc1/source/include/dt-bindings/clock/sun6i-a31-ccu.h#L187
