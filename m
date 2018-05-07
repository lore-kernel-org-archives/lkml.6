Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbeEGKdi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 06:33:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55656 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeEGKde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 06:33:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 07 May 2018 16:03:33 +0530
From: Amit Nischal <anischal@codeaurora.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk-owner@vger.kernel.org
Subject: Re: [PATCH v6 1/3] clk: qcom: Configure the RCGs to a safe source as
 needed
In-Reply-To: <152549069940.138124.10210385659890209429@swboyd.mtv.corp.google.com>
References: <1525105210-8689-1-git-send-email-anischal@codeaurora.org>
 <1525105210-8689-2-git-send-email-anischal@codeaurora.org>
 <152524713612.138124.1776677011439726084@swboyd.mtv.corp.google.com>
 <68f6216b3de12d90a54207a6a0110c6b@codeaurora.org>
 <152549069940.138124.10210385659890209429@swboyd.mtv.corp.google.com>
Message-ID: <f7c41c4d7df95ab093150de1d2c4b4b1@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-05 08:54, Stephen Boyd wrote:
> Quoting Amit Nischal (2018-05-03 04:57:37)
>> On 2018-05-02 13:15, Stephen Boyd wrote:
>> > Quoting Amit Nischal (2018-04-30 09:20:08)
>> >
>> >> +}
>> >> +
>> >> +static void clk_rcg2_shared_disable(struct clk_hw *hw)
>> >> +{
>> >> +       struct clk_rcg2 *rcg = to_clk_rcg2(hw);
>> >> +       struct freq_tbl safe_src_tbl = { 0 };
>> >> +
>> >> +       /*
>> >> +        * Park the RCG at a safe configuration - sourced off from
>> >> safe source.
>> >> +        * Force enable and disable the RCG while configuring it to
>> >> safeguard
>> >> +        * against any update signal coming from the downstream clock.
>> >> +        * The current parent is still prepared and enabled at this
>> >> point, and
>> >> +        * the safe source is always on while application processor
>> >> subsystem
>> >> +        * is online. Therefore, the RCG can safely switch its parent.
>> >> +        */
>> >> +       safe_src_tbl.src = rcg->safe_src_index;
>> >> +       clk_rcg2_shared_force_enable_clear(hw, &safe_src_tbl);
>> >
>> > This should then re-dirty the config register to have the software
>> > frequency settings that existed in the hardware when disable was
>> > called.
>> > Given that MND shouldn't be changed here, this should be as simple as
>> > saving away the CFG register, forcing it to XO speed by changing the
>> > src
>> > and disabling dual edge in the CFG register (please don't call
>> > force_enable_clear with some frequency pointer, just do this inline
>> > here), and then rewriting the cfg register with the "real" settings for
>> > whatever frequency it's supposed to run at and then returning from this
>> > function.
>> >
>> > I guess we have to do a read cfg from hardware, write cfg, hit update
>> > config, and then write cfg again each time we disable. For enable, we
>> > just do an update config (if it's dirty?) inside of a force
>> > enable/disable pair. And set_rate doesn't really change except it
>> > either
>> > does or doesn't hit the update config bit if the clk is enabled or
>> > disabled respectively.
>> >
>> 
>> We have done the below changes suggested by you and that logic seems 
>> to
>> be
>> working fine. But we have one concern about leaving the RCG registers 
>> in
>> dirty state and would like to have a little bit modification as
>> explained
>> below:
>> 
>> Suggested Logic:
>> 1. set_rate()--> Update CFG, M, N and D registers and don't hit the
>> update
>>                   bit if clock is disabled - call new
>> __clk_rcg2_configure().
>>                   Above will make the CFG register as dirty.
>> 
>> 2. _disable()--> 2.1 - Store the CFG register configuration in a
>> variable.
>>                   2.2 - Move to the safe source (XO) and hit the 
>> update
>> bit.
>>                         It will only touch the CFG register and M, N, 
>> D
>>                         register values will remain as it was.
>>                   2.3 - Write back the stored CFG value done in step 
>> #2.1
>>                         This will again redirty the CFG register.
>> 
>> 3. _enable()--> Just hit the update bit as the configuration write 
>> will
>>                  be taken care in the steps #1 and #2.
>> 
>> It would be great if we don't redirty the CFG register and leave the 
>> RCG
>> CFG register to at safe source(XO) in disable() path.
>> 
>> This would help us to debug the issues where device crashes and we 
>> want
>> to dump the RCG registers to know whether from software, we have
>> actually
>> moved to safe source or not. Otherwise, we would get the dirty 
>> register
>> values in crash dumps.
>> 
>> So instead of writing back the stored CFG(corresponding to real rate
>> settings) in disable path, we want to restore the stored CFG in enable
>> path and then hit the update bit.
>> CFG configuration store can happen at two places - set_rate() and
>> disable()
>> path and above logic will be modified as below:
>> 
>> 1. set_rate()--> 1.1 - Update CFG, M, N and D registers and don't hit
>> the
>>                         update bit if clock is disabled.
>>                   1.2 - Store CFG register value in 'current_cfg' 
>> member
>>                         of 'rcg2' structure.
>> 
>> 2. _disable()--> 2.1 - Store the CFG register value in 'current_cfg'
>> before
>>                         switching to the safe source (XO).
>>                   2.2 - Move to the safe source (XO) and hit the 
>> update
>> bit.
>>                         Now RCG configuration wil not be dirty.
>> 
>> 3. _enable()--> 3.1 - Check for 'current_cfg' value and if 0 then
>> return.
>>                        This would catch the below one time condition:
>>                        - when clk_enable() gets call without 
>> set_rate().
> 
> We want clk_enable() to work without set_rate() though. So returning 0
> if the value is 0 is wrong.
> 
>>                  3.2 - Write the CFG value from 'current_cfg' to CFG
>> register.
>>                  3.2 - Hit the update bit as we have already written 
>> the
>> latest
>>                        configuration in step #3.2.
>>                  3.3 - Clear the 'current_cfg' value.
>> 
>> We feel above logic will work as expected and in this way, we don't 
>> have
>> CFG
>> registers in dirty state when clock is disabled.
>> Could you please inform us your thoughts about above implementation 
>> and
>> based
>> on that I will send the required changes.
>> 
> 
> If you want to save away current_cfg in a memory location so you know
> what it was before it was dirty, then perhaps that needs to be a debug
> patch that you stack on top when debugging. In the end, it would just 
> be
> saving the state of the frequency setting that we have in software
> though, and that would be the latest rate of the clk we have configured
> the clk for. There aren't any mux switches going on when the clk is 
> off,
> so you're saying you want to know the rate of the clk that the kernel
> set when we turned the clk off, which we already have with the clk 
> rate.
> I'm confused.

Thanks for the suggestions. We will implement the new ops with the below
logic which you suggested earlier i.e. re-dirtying the RCG in disable() 
path
with real CFG settings and in enable() path, only hit the update bit.

1. set_rate()--> Update CFG, M, N and D registers and don't hit the
                  update bit if clock is disabled - call new
                  __clk_rcg2_configure().
                  Above will make the CFG register as dirty.

2. _disable()--> 2.1 - Store the CFG register configuration in a
                        variable.
                  2.2 - Move to the safe source (XO) and hit the update
                        bit. It will only touch the CFG register and M, 
N, D
                        register values will remain as it was.
                  2.3 - Write back the stored CFG value done in step #2.1
                        This will again redirty the CFG register.

3. _enable()--> Just hit the update bit as the configuration write will
                 be taken care in the steps #1 and #2.
