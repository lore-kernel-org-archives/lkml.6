Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751022AbeFAHZX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 03:25:23 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40374 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbeFAHZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 03:25:19 -0400
X-Google-Smtp-Source: ADUXVKKWI9YR45/qIuziSe2yq46L+b82X6gzpK3toqQM6azArJj0oM1hoek57VuFR7xuD0SiJPxnNw==
Subject: Re: [PATCH] clk: vc5: Fix div-by-0 when rounding a rate of zero
To: Steve Longerbeam <slongerbeam@gmail.com>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
References: <1527791036-11251-1-git-send-email-steve_longerbeam@mentor.com>
 <1084deae-ca55-aba1-ec08-7e1d976de7b7@gmail.com>
 <e6d84bd1-5ad9-1a01-1cdf-0356fea82c16@gmail.com>
 <f7a05f4b-35c4-4900-24bd-44aab1c669cb@gmail.com>
 <59591484-b76d-6764-73c3-637bb4e5178f@mentor.com>
 <06fd7d17-5c31-4ac5-d923-276afee056b3@gmail.com>
 <4f4f8a11-9239-3c24-f136-1ad0617a992a@gmail.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <ff0d61f5-e6a3-dfb9-4cf0-370cb5b7dd9e@gmail.com>
Date: Fri, 1 Jun 2018 08:36:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <4f4f8a11-9239-3c24-f136-1ad0617a992a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2018 03:46 AM, Steve Longerbeam wrote:
> 
> 
> On 05/31/2018 12:37 PM, Marek Vasut wrote:
>> On 05/31/2018 08:52 PM, Steve Longerbeam wrote:
>>>
>>> On 05/31/2018 11:35 AM, Marek Vasut wrote:
>>>> On 05/31/2018 08:32 PM, Steve Longerbeam wrote:
>>>>> Hi Marek,
>>>>>
>>>>>
>>>>> On 05/31/2018 11:25 AM, Marek Vasut wrote:
>>>>>> On 05/31/2018 08:23 PM, Steve Longerbeam wrote:
>>>>>>> Just return zero for a rounded rate if requested rate is zero.
>>>>>>>
>>>>>>> This was caught by CONFIG_UBSAN:
>>>>>>>
>>>>>>> [  192.266748] UBSAN: Undefined behaviour in
>>>>>>> drivers/clk/clk-versaclock5.c:513:17
>>>>>>> [  192.274050] division by zero
>>>>>>> [  192.276976] CPU: 0 PID: 2579 Comm: vsp-unit-test-0 Tainted: G
>>>>>>> B   WC      4.14.17-02752-g13fb96f #1
>>>>>>> [  192.286378] Hardware name: Renesas Salvator-X board based on
>>>>>>> r8a7795 ES2.0+ (DT)
>>>>>>> [  192.293852] Call trace:
>>>>>>> [  192.296343] [<ffff2000080900dc>] dump_backtrace+0x0/0x390
>>>>>>> [  192.301807] [<ffff200008090480>] show_stack+0x14/0x1c
>>>>>>> [  192.306920] [<ffff200008f66574>] dump_stack+0x134/0x1a8
>>>>>>> [  192.312213] [<ffff2000087aaa30>] ubsan_epilogue+0x14/0x60
>>>>>>> [  192.317677] [<ffff2000087ab4d0>]
>>>>>>> __ubsan_handle_divrem_overflow+0x11c/0x170
>>>>>>> [  192.324720] [<ffff200008852120>] vc5_fod_round_rate+0x68/0x148
>>>>>>> [  192.330620] [<ffff20000884567c>] clk_calc_new_rates+0x238/0x3fc
>>>>>>> [  192.336607] [<ffff2000088456e0>] clk_calc_new_rates+0x29c/0x3fc
>>>>>>> [  192.342595] [<ffff2000088483ac>]
>>>>>>> clk_core_set_rate_nolock+0x48/0x11c
>>>>>>> [  192.349019] [<ffff2000088484b4>] clk_set_rate+0x34/0x4c
>>>>>>> [  192.354307] [<ffff20000895e304>] rcar_du_pm_suspend+0x274/0x2f4
>>>>>>> [  192.360297] [<ffff20000898feac>] platform_pm_suspend+0x78/0xb8
>>>>>>> [  192.366198] [<ffff2000089a5604>] dpm_run_callback+0x584/0xa18
>>>>>>> [  192.372010] [<ffff2000089a69e0>] __device_suspend+0x1a8/0x534
>>>>>>> [  192.377822] [<ffff2000089adc48>] dpm_suspend+0x130/0xea0
>>>>>>> [  192.383197] [<ffff2000089b0344>] dpm_suspend_start+0x130/0x138
>>>>>>> [  192.389099] [<ffff20000817f584>]
>>>>>>> suspend_devices_and_enter+0xf0/0x1778
>>>>>>> [  192.395700] [<ffff200008183014>] pm_suspend+0x2408/0x245c
>>>>>>> [  192.401162] [<ffff20000817c0a4>] state_store+0xf0/0x130
>>>>>>> [  192.406451] [<ffff200008f6f19c>] kobj_attr_store+0x5c/0x6c
>>>>>>> [  192.412002] [<ffff2000084f4c94>] sysfs_kf_write+0xe8/0xfc
>>>>>>> [  192.417466] [<ffff2000084f30b0>] kernfs_fop_write+0x22c/0x2e4
>>>>>>> [  192.423281] [<ffff2000083e46d4>] __vfs_write+0x104/0x34c
>>>>>>> [  192.428656] [<ffff2000083e4cc4>] vfs_write+0x134/0x2d8
>>>>>>> [  192.433857] [<ffff2000083e5150>] SyS_write+0xbc/0x12c
>>>>>>> [  192.438967] Exception stack(0xffff8006cd1cfec0 to
>>>>>>> 0xffff8006cd1d0000)
>>>>>>> [  192.445480] fec0: 0000000000000001 000000001e303f00
>>>>>>> 0000000000000004 0000ffff959a5000
>>>>>>> [  192.453397] fee0: 0000000000000000 0000000155510004
>>>>>>> 0000000000000003 000000000000006d
>>>>>>> [  192.461314] ff00: 0000000000000040 0000000000000000
>>>>>>> 0000ffffcc304800 0000000000000020
>>>>>>> [  192.469230] ff20: 0000000000000000 0000000000000000
>>>>>>> 0000000000000001 0000000000000008
>>>>>>> [  192.477148] ff40: 00000000004eb3b8 0000ffff958bb840
>>>>>>> 000000000000003d 0000000000000001
>>>>>>> [  192.485065] ff60: 000000001e303f00 0000ffff959a1508
>>>>>>> 0000000000000004 000000001e303f00
>>>>>>> [  192.492982] ff80: 0000000000000004 00000000004d4c68
>>>>>>> 0000000000000001 0000000000000000
>>>>>>> [  192.500899] ffa0: 000000001e30d5c0 0000ffffcc304820
>>>>>>> 0000ffff958bec64 0000ffffcc304820
>>>>>>> [  192.508816] ffc0: 0000ffff95912898 0000000020000000
>>>>>>> 0000000000000001 0000000000000040
>>>>>>> [  192.516733] ffe0: 0000000000000000 0000000000000000
>>>>>>> 0000000000000000 0000000000000000
>>>>>>> [  192.524650] [<ffff200008083ef0>] el0_svc_naked+0x24/0x28
>>>>>>>
>>>>>>> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
>>>>>>> ---
>>>>>>>     drivers/clk/clk-versaclock5.c | 4 ++++
>>>>>>>     1 file changed, 4 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/clk/clk-versaclock5.c
>>>>>>> b/drivers/clk/clk-versaclock5.c
>>>>>>> index decffb3..113523d 100644
>>>>>>> --- a/drivers/clk/clk-versaclock5.c
>>>>>>> +++ b/drivers/clk/clk-versaclock5.c
>>>>>>> @@ -509,6 +509,10 @@ static long vc5_fod_round_rate(struct clk_hw
>>>>>>> *hw, unsigned long rate,
>>>>>>>         u32 div_int;
>>>>>>>         u64 div_frc;
>>>>>>>     +    /* prevent div-by-0 */
>>>>>>> +    if (rate == 0)
>>>>>>> +        return 0;
>>>>>>> +
>>>>>>>         /* Determine integer part, which is 12 bit wide */
>>>>>>>         div_int = f_in / rate;
>>>>>>>         /*
>>>>>>>
>>>>>> Can this actually happen ?
>>>>> We caught this using the Renesas 3.6.0 BSP release, when performing
>>>>> a suspend of rcar-du driver. The rcar_du_pm_suspend() in 3.6.0 BSP is
>>>>> modified
>>>>> from mainline version, including calling clk_set_rate() on the crtc
>>>>> clocks with a
>>>>> rate of zero. So this is not actually reproducible (yet) in mainline.
>>>> So it sets clock to 0 ?
>>> Yep, see
>>>
>>> https://kernel.googlesource.com/pub/scm/linux/kernel/git/horms/renesas-bsp/+/rcar-3.6.0/drivers/gpu/drm/rcar-du/rcar_du_drv.c#359
>>>
>>>
>>>
>>>>    Anyway, this looks sane, although maybe the
>>>> whole driver could use a once-over to see if there could be more of
>>>> this.
>>> Actually I do see more potential divide-by-zeros due to a passed rate
>>> of zero, including vc5_pfd_round_rate() and vc5_pfd_set_rate().
>>>
>>> I can resubmit this patch fixing all cases in clk-versaclock5.c if you
>>> like (and probably remove the misleading backtrace in the commit
>>> message since it is a Renesas 3.6.0 kernel backtrace not a mainline
>>> backtrace).
>>>
>>> Or perhaps just treat this as a heads-up, I'll leave it up to you.
>> It'd be nice if you resubmitted it fixing all the cases.
>>
> 
> Ok. Please disregard this patch since there won't be a v2, the
> new patch will have a different title.

Thanks!

-- 
Best regards,
Marek Vasut
