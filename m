Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755382AbeDCIww (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 04:52:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54546 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755154AbeDCIwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 04:52:49 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 03 Apr 2018 14:22:47 +0530
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
        linux-kernel@vger.kernel.org, linux-clk-owner@vger.kernel.org
Subject: Re: [PATCH v2 2/4] clk: qcom: Configure the RCGs to a safe source as
 needed
In-Reply-To: <152150582284.254778.15552235408861080239@swboyd.mtv.corp.google.com>
References: <1520493495-3084-1-git-send-email-anischal@codeaurora.org>
 <1520493495-3084-3-git-send-email-anischal@codeaurora.org>
 <152150582284.254778.15552235408861080239@swboyd.mtv.corp.google.com>
Message-ID: <07dbf890975c1178bc4cc2360c25526a@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-20 06:00, Stephen Boyd wrote:
> Quoting Amit Nischal (2018-03-07 23:18:13)
>> For some root clock generators, there could be child branches which 
>> are
>> controlled by an entity other than application processor subsystem. 
>> For
>> such RCGs, as per application processor subsystem clock driver, all of 
>> its
>> downstream clocks are disabled and RCG is in disabled state but in 
>> actual
>> downstream clocks can be left enabled before.
> 
> s/actual/reality?
Thanks for the review. I will address this in next patch series.

> 
>> 
>> So in this scenario, when RCG is disabled as per clock driver's point 
>> of
>> view and when rate scaling request comes before downstream clock 
>> enable
>> request, then RCG fails to update its configuration because in actual 
>> RCG
> 
> s/actual/reality?
> 
I will address this in next patch series.

>> is on and it expects its new source to alredy in enable state  but in
> 
> s/alredy/already be/
I will address this in next patch series.

> 
>> reality new source is in off state. In order to avoid letting the RCG 
>> to
> 
> s/is in off state/is off/
> s/letting/having/
I will address this in next patch series.

> 
>> go into an invalid state, add support to just cache the rate of RCG 
>> during
> 
> s/just//
I will address this in next patch series.

> 
>> set_rate(), defer actual RCG configuration update to be done during
>> clk_enable() as at this point of time, both its new parent and safe 
>> source
>> will be already enabled and RCG can safely switch to new parent.
>> 
>> During clk_disable() request, configure it to safe source as both
>> its parents, safe source and current parent will be enabled and RCG 
>> can
>> safely execute a switch. Also add support to have safe configuration
>> frequency table structure for each shared RCG.
>> 
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
>> ---
>> diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
>> index 2a7489a..205fa34 100644
>> --- a/drivers/clk/qcom/clk-rcg.h
>> +++ b/drivers/clk/qcom/clk-rcg.h
>> @@ -146,6 +146,9 @@ struct clk_dyn_rcg {
>>   * @hid_width: number of bits in half integer divider
>>   * @parent_map: map from software's parent index to hardware's 
>> src_sel field
>>   * @freq_tbl: frequency table
>> + * @current_freq: last cached frequency when using branches with 
>> shared RCGs
>> + * @safe_src_freq_tbl : frequency table of safe source when using 
>> branches
>> + *                     with shared RCGs
>>   * @clkr: regmap clock handle
>>   *
>>   */
>> @@ -155,6 +158,8 @@ struct clk_rcg2 {
>>         u8                      hid_width;
>>         const struct parent_map *parent_map;
>>         const struct freq_tbl   *freq_tbl;
>> +       unsigned long           current_freq;
>> +       const struct freq_tbl   *safe_src_freq_tbl;
> 
> Can we store safe_src index instead? And then construct the frequency
> table entry on the fly at the call site? I think it would greatly
> clarify that we don't really care about the rate of the clk at all.
> Instead, all we care about is making sure the mux is set to whatever
> source selection can provide an always on signal.
> 
We will address the above in the V3 series of the patch set. We will be
generating the safe frequency table on the fly taking the safe source
frequency index input from the RCG clock.

>>         struct clk_regmap       clkr;
>>  };
>> 
>> @@ -167,5 +172,6 @@ struct clk_rcg2 {
>>  extern const struct clk_ops clk_byte2_ops;
>>  extern const struct clk_ops clk_pixel_ops;
>>  extern const struct clk_ops clk_gfx3d_ops;
>> +extern const struct clk_ops clk_rcg2_shared_ops;
>> 
>>  #endif
>> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
>> index e63db10..a52de54 100644
>> --- a/drivers/clk/qcom/clk-rcg2.c
>> +++ b/drivers/clk/qcom/clk-rcg2.c
>> @@ -790,3 +790,158 @@ static int clk_gfx3d_set_rate(struct clk_hw *hw, 
>> unsigned long rate,
>>         .determine_rate = clk_gfx3d_determine_rate,
>>  };
>> +
>> +static unsigned long
>> +clk_rcg2_shared_recalc_rate(struct clk_hw *hw, unsigned long 
>> parent_rate)
>> +{
>> +       struct clk_rcg2 *rcg = to_clk_rcg2(hw);
>> +
>> +       if (!__clk_is_enabled(hw->clk)) {
>> +               if (!rcg->current_freq) {
>> +                       if (!clk_rcg2_get_parent(hw))
> 
> This is checking for 0 source selection of parent? So basically if
> source is XO selected then return what we know is the XO speed? We
> should be able to do that by returning parent_rate though?
> 
>> +                               rcg->current_freq =
>> +                                       rcg->safe_src_freq_tbl->freq;
>> +                       else
>> +                               rcg->current_freq =
>> +                                       clk_rcg2_recalc_rate(hw, 
>> parent_rate);
>> +               }
>> +
>> +               return rcg->current_freq;
>> +       }
>> +
>> +       return rcg->current_freq = clk_rcg2_recalc_rate(hw, 
>> parent_rate);
> 
> I don't get this function.
> 
> To simplify just return cached rate if it's set and clk is off,
> otherwise read the hardware?
> 
> 	if (!__clk_is_enabled(hw->clk) && rcg->current_freq)
> 		return rcg->current_freq;
> 
> 	return clk_rcg2_recalc_rate(hw, parent_rate);
> 
> I would also rename current_freq to something like cached_freq and then
> *only* assign it when someone calls clk_set_rate() (and save around the
> frequency table pointer instead of raw frequency). Out of boot, we will
> return the right frequency and clk_set_rate() called before enable will
> cache the rate to what we want.

Thanks for your valuable suggestion. We will fix this in the next patch
series. But we would like to have one modification i.e. to update the
current_freq value with the clk_rcg2_recalc_rate(). Reason for the same
is given below. So the final logic would be:

static unsigned long
clk_rcg2_shared_recalc_rate(struct clk_hw *hw, unsigned long 
parent_rate)
{
    ...
    if (!__clk_is_enabled(hw->clk) && rcg->current_freq)
       return rcg->current_freq;

    return rcg->current_freq = clk_rcg2_recalc_rate(hw, parent_rate);
}

Updation of current_freq is required in recalc_rate() because in a
case where clk_enable() is called before the set_rate()[which actually
updates the current_freq] then inside the clk_rcg2_shared_enable(),
current_freq value will be 0 and clk_rcg2_shared_force_enable_clear()
will configure the RCG with the first frequency entry in the frequency
table and RCG will get enable at rate which BOOT has not configured.

> 
>> +}
>> +
>> +static int clk_rcg2_shared_enable(struct clk_hw *hw)
>> +{
>> +       struct clk_rcg2 *rcg = to_clk_rcg2(hw);
>> +
>> +       if (rcg->current_freq == rcg->safe_src_freq_tbl->freq) {
>> +               clk_rcg2_set_force_enable(hw);
>> +               clk_rcg2_configure(rcg, rcg->safe_src_freq_tbl);
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
> Not much is different between clk_rcg2_shared_force_enable_clear() and
> the three lines above inside that if condition. The only difference is
> we don't search for a rate in the frequency table. Ugh, but we can't
> change the frequency table because of hw clk control stuff that relies
> on the table in software matching the table in hardware? Sad.
> 
> Can we at least change the if condition above to be something like:
> 
> 	if (rcg->force_safe_src) {
> 		clk_rcg2_set_force_enable(...
> 
> And then set the force_safe_src bool when we want enable to skip normal
> rate restoration behavior? We should be able to use that flag in other
> places too, like where we check for the clk being enabled in software 
> or
> not.

As per the new implementation in V3 series, we think there is no need to
have one new flag.

> 
>> +}
>> +
>> +static void clk_rcg2_shared_disable(struct clk_hw *hw)
>> +{
>> +       struct clk_rcg2 *rcg = to_clk_rcg2(hw);
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
>> +       clk_rcg2_configure(rcg, rcg->safe_src_freq_tbl);
>> +       clk_rcg2_clear_force_enable(hw);
>> +}
>> +
> 
> Yeah, all this stuff would get simpler if we stopped using frequencies.
> Hopefully I made sense!
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
