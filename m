Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeECL5o (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 07:57:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44594 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbeECL5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 07:57:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 03 May 2018 17:27:37 +0530
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
In-Reply-To: <152524713612.138124.1776677011439726084@swboyd.mtv.corp.google.com>
References: <1525105210-8689-1-git-send-email-anischal@codeaurora.org>
 <1525105210-8689-2-git-send-email-anischal@codeaurora.org>
 <152524713612.138124.1776677011439726084@swboyd.mtv.corp.google.com>
Message-ID: <68f6216b3de12d90a54207a6a0110c6b@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-02 13:15, Stephen Boyd wrote:
> Quoting Amit Nischal (2018-04-30 09:20:08)
>> diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
>> index 2a7489a..f795b3e 100644
>> --- a/drivers/clk/qcom/clk-rcg.h
>> +++ b/drivers/clk/qcom/clk-rcg.h
>> @@ -1,5 +1,5 @@
>>  /*
>> - * Copyright (c) 2013, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2013, 2018, The Linux Foundation. All rights 
>> reserved.
> 
> Given that you're updating this, can you move this to SPDX as well? If
> that causes some sort of delay, it's OK to defer, but please send a
> patch to do it sometime soon after this series.
> 

ok sure, I will update the same to SPDX as suggested in the next patch
series.

>>   *
>>   * This software is licensed under the terms of the GNU General 
>> Public
>>   * License version 2, as published by the Free Software Foundation, 
>> and
>> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
>> index e63db10..4a23a7b 100644
>> --- a/drivers/clk/qcom/clk-rcg2.c
>> +++ b/drivers/clk/qcom/clk-rcg2.c
>> @@ -249,7 +249,8 @@ static int clk_rcg2_determine_floor_rate(struct 
>> clk_hw *hw,
>>         return _freq_tbl_determine_rate(hw, rcg->freq_tbl, req, 
>> FLOOR);
>>  }
>> 
>> -static int clk_rcg2_configure(struct clk_rcg2 *rcg, const struct 
>> freq_tbl *f)
>> +static int clk_rcg2_configure(struct clk_rcg2 *rcg, const struct 
>> freq_tbl *f,
>> +                               bool update_rcg_config)
> 
> Please leave clk_rcg2_configure() signature alone. Don't add a flag to
> say "hit the update". Instead, make a __clk_rcg2_configure() that
> doesn't hit the update bit, but does everything else and then have
> clk_rcg2_configure() call that function and also hit the update bit.
> 

Thanks for the suggestion. Will take care of the same in the next
patch series.

>>  {
>>         u32 cfg, mask;
>>         struct clk_hw *hw = &rcg->clkr.hw;
>> @@ -287,6 +288,9 @@ static int clk_rcg2_configure(struct clk_rcg2 
>> *rcg, const struct freq_tbl *f)
>>         if (ret)
>>                 return ret;
>> 
>> +       if (!update_rcg_config)
>> +               return 0;
>> +
> 
> Then this logic doesn't have to exist.

Yes true. Above logic is not required anymore.

> 
>>         return update_config(rcg);
>>  }
>> 
>> @@ -310,7 +314,7 @@ static int __clk_rcg2_set_rate(struct clk_hw *hw, 
>> unsigned long rate,
>>         if (!f)
>>                 return -EINVAL;
>> 
>> -       return clk_rcg2_configure(rcg, f);
>> +       return clk_rcg2_configure(rcg, f, true);
>>  }
>> 
>>  static int clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
>> @@ -419,7 +423,7 @@ static int clk_edp_pixel_set_rate(struct clk_hw 
>> *hw, unsigned long rate,
>>                 f.m = frac->num;
>>                 f.n = frac->den;
>> 
>> -               return clk_rcg2_configure(rcg, &f);
>> +               return clk_rcg2_configure(rcg, &f, true);
>>         }
>> 
>>         return -EINVAL;
>> @@ -523,7 +527,7 @@ static int clk_byte_set_rate(struct clk_hw *hw, 
>> unsigned long rate,
>> 
>>         f.pre_div = div;
>> 
>> -       return clk_rcg2_configure(rcg, &f);
>> +       return clk_rcg2_configure(rcg, &f, true);
>>  }
>> 
>>  static int clk_byte_set_rate_and_parent(struct clk_hw *hw,
>> @@ -589,7 +593,7 @@ static int clk_byte2_set_rate(struct clk_hw *hw, 
>> unsigned long rate,
>>         for (i = 0; i < num_parents; i++) {
>>                 if (cfg == rcg->parent_map[i].cfg) {
>>                         f.src = rcg->parent_map[i].src;
>> -                       return clk_rcg2_configure(rcg, &f);
>> +                       return clk_rcg2_configure(rcg, &f, true);
>>                 }
>>         }
>> 
>> @@ -682,7 +686,7 @@ static int clk_pixel_set_rate(struct clk_hw *hw, 
>> unsigned long rate,
>>                 f.m = frac->num;
>>                 f.n = frac->den;
>> 
>> -               return clk_rcg2_configure(rcg, &f);
>> +               return clk_rcg2_configure(rcg, &f, true);
>>         }
>>         return -EINVAL;
>>  }
> 
> And all those hunks don't happen. Yay!
> 
>> @@ -790,3 +794,194 @@ static int clk_gfx3d_set_rate(struct clk_hw *hw, 
>> unsigned long rate,
>> +
>> +static int
>> +clk_rcg2_shared_force_enable_clear(struct clk_hw *hw, const struct 
>> freq_tbl *f)
>> +{
>> +       struct clk_rcg2 *rcg = to_clk_rcg2(hw);
>> +       int ret;
>> +
>> +       if (!f)
>> +               return -EINVAL;
>> +
>> +       ret = clk_rcg2_set_force_enable(hw);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = clk_rcg2_configure(rcg, f, true);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return clk_rcg2_clear_force_enable(hw);
>> +}
>> +
>> +static int clk_rcg2_shared_set_rate(struct clk_hw *hw, unsigned long 
>> rate,
>> +                                   unsigned long parent_rate)
>> +{
>> +       struct clk_rcg2 *rcg = to_clk_rcg2(hw);
>> +       const struct freq_tbl *f;
>> +
>> +       f = qcom_find_freq(rcg->freq_tbl, rate);
>> +       if (!f)
>> +               return -EINVAL;
>> +
>> +       /*
>> +        * Store freq_tbl corresponding to requested rate in case 
>> disable() op
>> +        * clears the cached registers - disable() gets call after 
>> set_rate().
>> +        */
>> +       rcg->current_freq_tbl = f;
> 
> Shouldn't be needed.
> 

Yes with new implementation it is not required to store freq_tbl.
Please have a look at my last comment where I have explained the
new logic.

>> +
>> +       /*
>> +        * In case clock is disabled, update the CFG, M, N and D 
>> registers
>> +        * and do not hit the update bit of CMD register.
>> +        */
>> +       if (!__clk_is_enabled(hw->clk))
>> +               /* Skip the configuration update */
>> +               return clk_rcg2_configure(rcg, rcg->current_freq_tbl, 
>> false);
>> +
>> +       return clk_rcg2_shared_force_enable_clear(hw, 
>> rcg->current_freq_tbl);
>> +}
>> +
>> +static int clk_rcg2_shared_set_rate_and_parent(struct clk_hw *hw,
>> +               unsigned long rate, unsigned long parent_rate, u8 
>> index)
>> +{
>> +       return clk_rcg2_shared_set_rate(hw, rate, parent_rate);
>> +}
>> +
>> +static unsigned long
>> +clk_rcg2_shared_recalc_rate(struct clk_hw *hw, unsigned long 
>> parent_rate)
>> +{
>> +       struct clk_rcg2 *rcg = to_clk_rcg2(hw);
>> +
>> +       if (!__clk_is_enabled(hw->clk) && rcg->current_freq_tbl)
>> +               return rcg->current_freq_tbl->freq;
> 
> Why can't we read the hardware? The M, N, D registers should always 
> have
> the latest configuration of the frequency when recalc is called
> regardless of the on/off state.
> 

With new implementation, it is not required to make a decision based
on the clk on/off status. Please have a look at my last comment.

>> +
>> +       return clk_rcg2_recalc_rate(hw, parent_rate);
>> +}
>> +
>> +static int clk_rcg2_shared_enable(struct clk_hw *hw)
>> +{
>> +       struct clk_rcg2 *rcg = to_clk_rcg2(hw);
>> +       struct freq_tbl safe_src_tbl = { 0 };
>> +       int ret;
>> +       u32 cfg_src;
>> +
>> +       regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, 
>> &cfg_src);
>> +
>> +       cfg_src = cfg_src & CFG_SRC_SEL_MASK;
>> +       cfg_src >>= CFG_SRC_SEL_SHIFT;
>> +
>> +       if (!rcg->current_freq_tbl) {
>> +               /*
>> +                * In the case where clk_enable() would be called
>> +                * without a clk_set_rate(), check for RCG 
>> configuration
>> +                * if done previously.
>> +                */
>> +
>> +               if (cfg_src)
>> +                       return 0;
>> +
>> +               /*
>> +                * Configure RCG to safe_src, if following conditions
>> +                * holds true:
>> +                * - Bootloader configures the RCG to run from 
>> safe_src.
>> +                * - RCG's frequency table does not hold entry for
>> +                *   safe_src speed.
>> +                */
>> +               safe_src_tbl.src = rcg->safe_src_index;
>> +               return clk_rcg2_shared_force_enable_clear(hw, 
>> &safe_src_tbl);
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
>> +       if (!cfg_src)
>> +               /*
>> +                * Reconfigure the RCG if cached registers are 
>> overwritten
>> +                * by clk_disable() after clk_set_rate().
>> +                */
>> +               return clk_rcg2_shared_force_enable_clear(hw,
>> +                                               
>> rcg->current_freq_tbl);
>> +
>> +       /*
>> +        * Set the update bit only as other required configuration has 
>> been
>> +        * already done inside set_rate().
>> +        */
>> +       ret = clk_rcg2_set_force_enable(hw);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = update_config(rcg);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return clk_rcg2_clear_force_enable(hw);
> 
> This whole function seems overly complicated. Please see my comment
> below.
> 
>> +}
>> +
>> +static void clk_rcg2_shared_disable(struct clk_hw *hw)
>> +{
>> +       struct clk_rcg2 *rcg = to_clk_rcg2(hw);
>> +       struct freq_tbl safe_src_tbl = { 0 };
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
>> +       safe_src_tbl.src = rcg->safe_src_index;
>> +       clk_rcg2_shared_force_enable_clear(hw, &safe_src_tbl);
> 
> This should then re-dirty the config register to have the software
> frequency settings that existed in the hardware when disable was 
> called.
> Given that MND shouldn't be changed here, this should be as simple as
> saving away the CFG register, forcing it to XO speed by changing the 
> src
> and disabling dual edge in the CFG register (please don't call
> force_enable_clear with some frequency pointer, just do this inline
> here), and then rewriting the cfg register with the "real" settings for
> whatever frequency it's supposed to run at and then returning from this
> function.
> 
> I guess we have to do a read cfg from hardware, write cfg, hit update
> config, and then write cfg again each time we disable. For enable, we
> just do an update config (if it's dirty?) inside of a force
> enable/disable pair. And set_rate doesn't really change except it 
> either
> does or doesn't hit the update config bit if the clk is enabled or
> disabled respectively.
> 

We have done the below changes suggested by you and that logic seems to 
be
working fine. But we have one concern about leaving the RCG registers in
dirty state and would like to have a little bit modification as 
explained
below:

Suggested Logic:
1. set_rate()--> Update CFG, M, N and D registers and don't hit the 
update
                  bit if clock is disabled - call new 
__clk_rcg2_configure().
                  Above will make the CFG register as dirty.

2. _disable()--> 2.1 - Store the CFG register configuration in a 
variable.
                  2.2 - Move to the safe source (XO) and hit the update 
bit.
                        It will only touch the CFG register and M, N, D
                        register values will remain as it was.
                  2.3 - Write back the stored CFG value done in step #2.1
                        This will again redirty the CFG register.

3. _enable()--> Just hit the update bit as the configuration write will
                 be taken care in the steps #1 and #2.

It would be great if we don't redirty the CFG register and leave the RCG
CFG register to at safe source(XO) in disable() path.

This would help us to debug the issues where device crashes and we want
to dump the RCG registers to know whether from software, we have 
actually
moved to safe source or not. Otherwise, we would get the dirty register
values in crash dumps.

So instead of writing back the stored CFG(corresponding to real rate
settings) in disable path, we want to restore the stored CFG in enable
path and then hit the update bit.
CFG configuration store can happen at two places - set_rate() and 
disable()
path and above logic will be modified as below:

1. set_rate()--> 1.1 - Update CFG, M, N and D registers and don't hit 
the
                        update bit if clock is disabled.
                  1.2 - Store CFG register value in 'current_cfg' member
                        of 'rcg2' structure.

2. _disable()--> 2.1 - Store the CFG register value in 'current_cfg' 
before
                        switching to the safe source (XO).
                  2.2 - Move to the safe source (XO) and hit the update 
bit.
                        Now RCG configuration wil not be dirty.

3. _enable()--> 3.1 - Check for 'current_cfg' value and if 0 then 
return.
                       This would catch the below one time condition:
                       - when clk_enable() gets call without set_rate().
                 3.2 - Write the CFG value from 'current_cfg' to CFG 
register.
                 3.2 - Hit the update bit as we have already written the 
latest
                       configuration in step #3.2.
                 3.3 - Clear the 'current_cfg' value.

We feel above logic will work as expected and in this way, we don't have 
CFG
registers in dirty state when clock is disabled.
Could you please inform us your thoughts about above implementation and 
based
on that I will send the required changes.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
