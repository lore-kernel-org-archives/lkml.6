Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756454AbeDZNxA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 09:53:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44870 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755998AbeDZNwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 09:52:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 26 Apr 2018 19:22:50 +0530
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] clk: qcom: Configure the RCGs to a safe source as
 needed
In-Reply-To: <152412344454.46528.15443283917197272382@swboyd.mtv.corp.google.com>
References: <1524058473-15860-1-git-send-email-anischal@codeaurora.org>
 <1524058473-15860-2-git-send-email-anischal@codeaurora.org>
 <152412344454.46528.15443283917197272382@swboyd.mtv.corp.google.com>
Message-ID: <c1ddb19142f475e50352e4ef2034ed4f@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-19 13:07, Stephen Boyd wrote:
> Quoting Amit Nischal (2018-04-18 06:34:32)
>> diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
>> index 2a7489a..9d9d59d 100644
>> --- a/drivers/clk/qcom/clk-rcg.h
>> +++ b/drivers/clk/qcom/clk-rcg.h
>> @@ -153,8 +155,10 @@ struct clk_rcg2 {
>>         u32                     cmd_rcgr;
>>         u8                      mnd_width;
>>         u8                      hid_width;
>> +       const u8                safe_src_index;
> 
> Please drop const.

Thanks for the review. Will remove the const.

> 
>>         const struct parent_map *parent_map;
>>         const struct freq_tbl   *freq_tbl;
>> +       unsigned long           current_freq;
>>         struct clk_regmap       clkr;
>>  };
>> 
>> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
>> index 984de9c..4d971bf 100644
>> --- a/drivers/clk/qcom/clk-rcg2.c
>> +++ b/drivers/clk/qcom/clk-rcg2.c
>> +
>> +static int clk_rcg2_shared_set_rate(struct clk_hw *hw, unsigned long 
>> rate,
>> +                                   unsigned long parent_rate)
>> +{
>> +       struct clk_rcg2 *rcg = to_clk_rcg2(hw);
>> +       int ret;
>> +
>> +       /*
>> +        * Return if the RCG is currently disabled. This configuration
>> +        * update will happen as part of the RCG enable sequence.
>> +        */
>> +       if (!__clk_is_enabled(hw->clk)) {
>> +               rcg->current_freq = rate;
> 
> We should probably check that 'rate' can be achieved during
> clk_set_rate() though. So I imagine we would need to do all the
> rounding, etc. and then cache the frequency at that point. Or cross
> fingers that this set rate op is never called without the round_rate op
> being called on it too.

Yes set_rate() op would not be called without 
round_rate/determine_rate().

> 
>> +               return 0;
>> +       }
>> +
>> +       ret = clk_rcg2_shared_force_enable_clear(hw, rate);
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* Update current frequency with the requested frequency. */
>> +       rcg->current_freq = rate;
> 
> Is this even needed? recalc_rate() would be called shortly after and do
> this too.

Here updating of current_freq with the new requested rate is required as
recalc_rate() op is using the current_freq and returning the cached rate
(current_freq) when the clock is in disabled state.

> 
>> +
>> +       return ret;
>> +}
>> +
>> +static int clk_rcg2_shared_set_rate_and_parent(struct clk_hw *hw,
>> +               unsigned long rate, unsigned long parent_rate, u8 
>> index)
>> +{
>> +       return clk_rcg2_shared_set_rate(hw, rate, parent_rate);
> 
> We lost index. I guess that's OK...
> 
>> +}
>> +
> [...]
>> +
>> +static unsigned long clk_rcg2_get_safe_src_rate(struct clk_hw *hw)
>> +{
>> +       struct clk_rcg2 *rcg = to_clk_rcg2(hw);
>> +       int index;
>> +
>> +       index = qcom_find_src_index(hw, rcg->parent_map, 
>> rcg->safe_src_index);
> 
> Why are we finding it though? Can't we just set the bit to be what it's
> supposed to be all the time at compile time instead of going through 
> the
> parent map to find the register value?

This is to find the safe source rate from the safe_src_index value. As 
suggested
in v2 series, we are constructing the safe source frequency table on the 
fly
from the safe_src_index value.

> 
>> +       if (index < 0)
>> +               index = 0;
>> +
>> +       return clk_hw_get_rate(clk_hw_get_parent_by_index(hw, index));
> 
> I'm still failing to see why the 'rate' is so important for the safe
> source.

Safe source's rate is getting used in the clk_rcg2_shared_enable() op.
Please have a look at next comment which explains about the need of
safe source's rate.

> 
>> +}
>> +
>> +static int clk_rcg2_shared_enable(struct clk_hw *hw)
>> +{
>> +       struct clk_rcg2 *rcg = to_clk_rcg2(hw);
>> +       struct freq_tbl safe_src_freq_tbl = { 0 };
>> +
>> +       safe_src_freq_tbl.freq = clk_rcg2_get_safe_src_rate(hw);
>> +
>> +       if (rcg->current_freq == safe_src_freq_tbl.freq) {
> 
> I'd prefer this became a bool condition like rcg->on_safe_src or
> something like that, instead of calculating the safe src frequency and
> comparing that to whatever recalc_rate saw.
> 
>> +               safe_src_freq_tbl.src = rcg->safe_src_index;
>> +               /*
>> +                * Reconfigure the RCG - Incase if any other sub 
>> system updates
>> +                * the div or src without the knowledge of application 
>> processor
>> +                * subsystem and RCG could run at different rate other 
>> than
>> +                * software cached rate.
> 
> This happens? But then if we force enable RCG and the src was changed 
> by
> another subsystem and that src isn't enabled anymore we're going to get
> a stuck rcg switch. So they really shouldn't be switching it over to a
> non-safe src before handing it off to us. I can believe div, so ok we
> may need to update div, but then either the 'current_freq' is in the
> table that matches the safe src speed, and then we can call
> clk_rcg2_shared_force_enable_clear() or the frequency doesn't match 
> safe
> src speed and we can still call clk_rcg2_shared_force_enable_clear()
> because it's in the freq table. I thought these three lines below in
> this if condition were purely there because the frequency table didn't
> hold the entry for safe src speed, sometimes.

Yes, your understanding is right. Above lines are there to catch the 
below:
1. When pre-boot entity configures the clock to run from safe_src.
2. RCG frequency table does not hold the entry for safe_src speed.
3. The clock_enable() gets call without the set_rate().

If all the above three conditions will be true then, enable op would 
configure
the RCG at safe_src speed otherwise, enable() would configure the RCG
with the first frequency entry in the frequency table and RCG will get 
enable
at a rate which BOOT has not configured and the old configuration will 
be
lost.

> 
>> +                */
>> +               clk_rcg2_set_force_enable(hw);
>> +               clk_rcg2_configure(rcg, &safe_src_freq_tbl);
> 
> This could be a few more lines to regmap_write() the cfg reg with the
> proper index then leave the mnd registers empty, and then call
> update_config()? Instead of doing index gymnastics.
> 
>> +               clk_rcg2_clear_force_enable(hw);
>> +
>> +               return 0;
>> +       }
>> +
>> +       /*
>> +        * Switch from safe source to the stashed mux selection. The 
>> current
>> +        * parent has already been prepared and enabled at this point, 
>> and
>> +        * the safe source is always on while application processor 
>> subsystem
>> +        * is online. Therefore, the RCG can safely switch its source.
>> +        */
>> +
>> +       return clk_rcg2_shared_force_enable_clear(hw, 
>> rcg->current_freq);
> 
> Ok maybe it's because we may boot up, rate is safe src speed in
> hardware, that entry is not in the freq table, recalc_rate() is called
> and that finds safe src speed and assigns it into current_freq. I can
> believe that. So in this case, the above if condition is going to catch
> it and allow enable to be called before clk_set_rate().
> 
> How about changing 'current_freq' to literally a struct freq_table
> member, that stores a copy of the frequency table entry to use or
> constructs the entry on the fly when the frequency doesn't exist in the
> plan? At boot time, that could be populated with the value we read from
> hardware, and then otherwise when we call disable() it would just copy
> it over into the member and on enable() it would slam it into the
> hardware and do update_config().
> 
> Or we could even just read the M, N, D, and CFG registers and save them
> off at driver probe time or during disable and then restore them on
> enable. Make a pointer in clk_rcg2 to some regcache structure and then
> assign those statically in the SoC driver to avoid wasting space for
> each RCG out there. The recalc_rate() function could fill in the cache
> too if there's some special bit set indicating it needs to load it
> initially, and then a new recalc_rate() function could be written to
> operate on the mini-cache of register values for these clks. We could
> even go a step further and have the clk_set_rate() path write into the
> cache when the clk is disabled to update the mnd and cfg and bypass the
> cache when the clk is enabled.
> 
> It would be super nice if regmap could handle all of this too, so we
> could enable caching for a few registers, regmap write into them and
> skip the update_config() step when clk disabled, and then flush the
> cache when we enable, update_config(), and disable caching for the
> registers. recalc_rate() would work unchanged then because it would
> always hit in the cache when caching is on, or read the hardware when
> caching was off. We would need something that lets us bypass the cache
> though and write directly when we force the safe src. There's already
> some regmap caching code, so it might work with some more APIs added. 
> Or
> we could go the custom cache route and see how bad it is.

Thanks for your valuable suggestions. We would like to revisit this 
feature
to construct a frequency table entry on the fly when boot configures the 
RCG
to a different frequency which is not present in the freq_tbl at a later 
point
of time.

As of now, it's expected that any pre-boot entity should follow the 
frequency
plan and configure the RCG accordingly.

The main intention of this patch is to switch the RCG to the safe 
source(XO)
in disable path and switch back to stashed mux source from the safe 
source(XO)
in enable path.

> 
>> +}
>> +
>> +static void clk_rcg2_shared_disable(struct clk_hw *hw)
>> +{
>> +       struct clk_rcg2 *rcg = to_clk_rcg2(hw);
>> +       struct freq_tbl safe_src_freq_tbl = { 0 };
>> +
>> +       safe_src_freq_tbl.src = rcg->safe_src_index;
>> +       safe_src_freq_tbl.freq = clk_rcg2_get_safe_src_rate(hw);
>> +
>> +       /*
>> +        * Park the RCG at a safe configuration - sourced off from 
>> safe source.
>> +        * Force enable and disable the RCG while configuring it to 
>> safeguard
>> +        * against any update signal coming from the downstream clock.
>> +        * The current parent is still prepared and enabled at this 
>> point, and
>> +        * the safe source is always on while application processor 
>> subsystem
>> +        * is online. Therefore, the RCG can safely switch its parent.
>> +        */
>> +       clk_rcg2_set_force_enable(hw);
>> +       clk_rcg2_configure(rcg, &safe_src_freq_tbl);
> 
> Again, slam in index and call update_config() directly.
> 
>> +       clk_rcg2_clear_force_enable(hw);
>> +}
