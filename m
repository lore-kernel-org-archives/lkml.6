Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965035AbeBMPXF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:23:05 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43500 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964913AbeBMPXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:23:04 -0500
X-Google-Smtp-Source: AH8x225YYFrdLnveYVvBFhBZzEK1aZozwr0gyHwnqnViGh1aSQ/68efbl7pXpg2zFNsKh31R8qH1UQ==
Subject: Re: [linux-sunxi] [PATCH v2] rtc: ac100: Fix ac100 determine rate bug
To: Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>, linux-rtc@vger.kernel.org
References: <20180213121414.7000-1-embed3d@gmail.com>
 <20180213133201.kwq4aatpts7nerc2@flea.lan>
 <CAGb2v64tOCeD38gGR_fboC6PJCCD8L-EPu196MGrGgHLenkQXw@mail.gmail.com>
From: Philipp Rossak <embed3d@gmail.com>
Message-ID: <8142b42d-bf8d-0903-e26e-1499f95e51d5@gmail.com>
Date: Tue, 13 Feb 2018 16:23:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGb2v64tOCeD38gGR_fboC6PJCCD8L-EPu196MGrGgHLenkQXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.02.2018 14:44, Chen-Yu Tsai wrote:
> On Tue, Feb 13, 2018 at 9:32 PM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
>> On Tue, Feb 13, 2018 at 01:14:14PM +0100, Philipp Rossak wrote:
>>> This patch fixes a bug, that prevents the Allwinner A83T and the A80
>>> from a successful boot. You can find the shortend trace below:
>>
>> Since when is it there?
>>
The bug is there since v4.16-rc1 and appeared after the clk branch was 
merged.

^^ Should I add this info also in the commit message?

>>> Unable to handle kernel NULL pointer dereference at virtual address
>>> 00000000
>>> pgd = (ptrval)
>>> [00000000] *pgd=00000000
>>> Internal error: Oops: 5 [#1] SMP ARM
>>> Modules linked in:
>>> CPU: 0 PID: 49 Comm: kworker/0:1 Not tainted 4.15.0-10190-gb89e32ccd1be #2
>>> Hardware name: Allwinner sun8i Family
>>> Workqueue: events deferred_probe_work_func
>>> PC is at clk_hw_get_rate+0x0/0x34
>>> LR is at ac100_clkout_determine_rate+0x48/0x19c
>>>
>>> [ ... ]
>>>
>>> (clk_hw_get_rate) from (ac100_clkout_determine_rate+0x48/0x19c)
>>> (ac100_clkout_determine_rate) from  (clk_core_set_rate_nolock+0x3c/0x1a0)
>>> (clk_core_set_rate_nolock) from (clk_set_rate+0x30/0x88)
>>> (clk_set_rate) from (of_clk_set_defaults+0x200/0x364)
>>> (of_clk_set_defaults) from (platform_drv_probe+0x18/0xb0)
>>>
>>> To fix that bug, we first check if the return of the
>>> clk_hw_get_parent_by_index is non zero. If it is zero we skip that
>>> clock parent.
>>>
>>> The BUG report could be found here: https://lkml.org/lkml/2018/2/10/198
>>>
>>> Fixes: 04940631b8d2 ("rtc: ac100: Add clk output support")
>>
>> Should it be sent to stable?
>>
>>> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
>>> ---
>>>
>>> Changes in v2:
>>>        * add tag Fixes: ... to commit message
>>>        * add comment to if statement why we are doing this check
>>>
>>>   drivers/rtc/rtc-ac100.c | 12 +++++++++++-
>>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/rtc/rtc-ac100.c b/drivers/rtc/rtc-ac100.c
>>> index 8ff9dc3fe5bf..ba73201d8cc1 100644
>>> --- a/drivers/rtc/rtc-ac100.c
>>> +++ b/drivers/rtc/rtc-ac100.c
>>> @@ -183,7 +183,17 @@ static int ac100_clkout_determine_rate(struct clk_hw *hw,
>>>
>>>        for (i = 0; i < num_parents; i++) {
>>>                struct clk_hw *parent = clk_hw_get_parent_by_index(hw, i);
>>> -             unsigned long tmp, prate = clk_hw_get_rate(parent);
>>> +             unsigned long tmp, prate;
>>> +
>>> +             /*
>>> +              * We purposefully left open the possibility to use the clock
>>> +              * from the codec side but it is not implemented right now.
>>> +              * Thus we need to check if the parent exists.
>>> +              */
>>> +             if (!parent)
>>> +                     continue;
>>> +
>>> +             prate = clk_hw_get_rate(parent);
>>
>> clk_hw_get_num_parents should return the exact number of parents,
>> which is going to be 1 if you only have one parent, like all DTS seems
>> to have.
>>
>> If not, then it should be explained in the comment and / or fixed
>> properly.
> 
> The clock has two parents. One is a fixed clock internally registered
> by the driver. This is actually an external crystal, and we should
> probably add a device node and the works for it. The other parent
> is a clock from the codec side, which we properly declare and
> reference in the device tree. This clock, though defined, is not
> implemented in any driver (because we don't have any ATM).
> 
> This second missing clock is what's causing issues here. The clk core
> looks for the parent by name, can't find one that is registered, and
> returns NULL.
> 
> I guess the comment above is still not clear enough?

I can get more detailed in the comment. I thought about this:

The clock has two parents, one is a fixed clock which is internally 
registered by the ac100 driver. The other parent is a clock from the 
codec side of the chip, which we properly declare and reference in the 
devicetree and is not implemented in any driver right now.
If the clock core looks for the parent of that second missing clock, it 
can't one that is registered and returns NULL.
Thus we need to check if the parent exists before we get the parent rate.

Is that ok for you?

Philipp

> 
> ChenYu
> 
>> Maxime
>>
>> --
>> Maxime Ripard, Bootlin (formerly Free Electrons)
>> Embedded Linux and Kernel engineering
>> http://bootlin.com
