Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751149AbeDSHh2 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 03:37:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750732AbeDSHh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 03:37:26 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4803D21745
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Amit Nischal <anischal@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1524058473-15860-2-git-send-email-anischal@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Nischal <anischal@codeaurora.org>
References: <1524058473-15860-1-git-send-email-anischal@codeaurora.org>
 <1524058473-15860-2-git-send-email-anischal@codeaurora.org>
Message-ID: <152412344454.46528.15443283917197272382@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 1/2] clk: qcom: Configure the RCGs to a safe source as needed
Date: Thu, 19 Apr 2018 00:37:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Nischal (2018-04-18 06:34:32)
> diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
> index 2a7489a..9d9d59d 100644
> --- a/drivers/clk/qcom/clk-rcg.h
> +++ b/drivers/clk/qcom/clk-rcg.h
> @@ -153,8 +155,10 @@ struct clk_rcg2 {
>         u32                     cmd_rcgr;
>         u8                      mnd_width;
>         u8                      hid_width;
> +       const u8                safe_src_index;

Please drop const.

>         const struct parent_map *parent_map;
>         const struct freq_tbl   *freq_tbl;
> +       unsigned long           current_freq;
>         struct clk_regmap       clkr;
>  };
> 
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index 984de9c..4d971bf 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> +
> +static int clk_rcg2_shared_set_rate(struct clk_hw *hw, unsigned long rate,
> +                                   unsigned long parent_rate)
> +{
> +       struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> +       int ret;
> +
> +       /*
> +        * Return if the RCG is currently disabled. This configuration
> +        * update will happen as part of the RCG enable sequence.
> +        */
> +       if (!__clk_is_enabled(hw->clk)) {
> +               rcg->current_freq = rate;

We should probably check that 'rate' can be achieved during
clk_set_rate() though. So I imagine we would need to do all the
rounding, etc. and then cache the frequency at that point. Or cross
fingers that this set rate op is never called without the round_rate op
being called on it too.

> +               return 0;
> +       }
> +
> +       ret = clk_rcg2_shared_force_enable_clear(hw, rate);
> +       if (ret)
> +               return ret;
> +
> +       /* Update current frequency with the requested frequency. */
> +       rcg->current_freq = rate;

Is this even needed? recalc_rate() would be called shortly after and do
this too.

> +
> +       return ret;
> +}
> +
> +static int clk_rcg2_shared_set_rate_and_parent(struct clk_hw *hw,
> +               unsigned long rate, unsigned long parent_rate, u8 index)
> +{
> +       return clk_rcg2_shared_set_rate(hw, rate, parent_rate);

We lost index. I guess that's OK...

> +}
> +
[...]
> +
> +static unsigned long clk_rcg2_get_safe_src_rate(struct clk_hw *hw)
> +{
> +       struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> +       int index;
> +
> +       index = qcom_find_src_index(hw, rcg->parent_map, rcg->safe_src_index);

Why are we finding it though? Can't we just set the bit to be what it's
supposed to be all the time at compile time instead of going through the
parent map to find the register value?

> +       if (index < 0)
> +               index = 0;
> +
> +       return clk_hw_get_rate(clk_hw_get_parent_by_index(hw, index));

I'm still failing to see why the 'rate' is so important for the safe
source.

> +}
> +
> +static int clk_rcg2_shared_enable(struct clk_hw *hw)
> +{
> +       struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> +       struct freq_tbl safe_src_freq_tbl = { 0 };
> +
> +       safe_src_freq_tbl.freq = clk_rcg2_get_safe_src_rate(hw);
> +
> +       if (rcg->current_freq == safe_src_freq_tbl.freq) {

I'd prefer this became a bool condition like rcg->on_safe_src or
something like that, instead of calculating the safe src frequency and
comparing that to whatever recalc_rate saw.

> +               safe_src_freq_tbl.src = rcg->safe_src_index;
> +               /*
> +                * Reconfigure the RCG - Incase if any other sub system updates
> +                * the div or src without the knowledge of application processor
> +                * subsystem and RCG could run at different rate other than
> +                * software cached rate.

This happens? But then if we force enable RCG and the src was changed by
another subsystem and that src isn't enabled anymore we're going to get
a stuck rcg switch. So they really shouldn't be switching it over to a
non-safe src before handing it off to us. I can believe div, so ok we
may need to update div, but then either the 'current_freq' is in the
table that matches the safe src speed, and then we can call
clk_rcg2_shared_force_enable_clear() or the frequency doesn't match safe
src speed and we can still call clk_rcg2_shared_force_enable_clear()
because it's in the freq table. I thought these three lines below in
this if condition were purely there because the frequency table didn't
hold the entry for safe src speed, sometimes.

> +                */
> +               clk_rcg2_set_force_enable(hw);
> +               clk_rcg2_configure(rcg, &safe_src_freq_tbl);

This could be a few more lines to regmap_write() the cfg reg with the
proper index then leave the mnd registers empty, and then call
update_config()? Instead of doing index gymnastics.

> +               clk_rcg2_clear_force_enable(hw);
> +
> +               return 0;
> +       }
> +
> +       /*
> +        * Switch from safe source to the stashed mux selection. The current
> +        * parent has already been prepared and enabled at this point, and
> +        * the safe source is always on while application processor subsystem
> +        * is online. Therefore, the RCG can safely switch its source.
> +        */
> +
> +       return clk_rcg2_shared_force_enable_clear(hw, rcg->current_freq);

Ok maybe it's because we may boot up, rate is safe src speed in
hardware, that entry is not in the freq table, recalc_rate() is called
and that finds safe src speed and assigns it into current_freq. I can
believe that. So in this case, the above if condition is going to catch
it and allow enable to be called before clk_set_rate().

How about changing 'current_freq' to literally a struct freq_table
member, that stores a copy of the frequency table entry to use or
constructs the entry on the fly when the frequency doesn't exist in the
plan? At boot time, that could be populated with the value we read from
hardware, and then otherwise when we call disable() it would just copy
it over into the member and on enable() it would slam it into the
hardware and do update_config().

Or we could even just read the M, N, D, and CFG registers and save them
off at driver probe time or during disable and then restore them on
enable. Make a pointer in clk_rcg2 to some regcache structure and then
assign those statically in the SoC driver to avoid wasting space for
each RCG out there. The recalc_rate() function could fill in the cache
too if there's some special bit set indicating it needs to load it
initially, and then a new recalc_rate() function could be written to
operate on the mini-cache of register values for these clks. We could
even go a step further and have the clk_set_rate() path write into the
cache when the clk is disabled to update the mnd and cfg and bypass the
cache when the clk is enabled.

It would be super nice if regmap could handle all of this too, so we
could enable caching for a few registers, regmap write into them and
skip the update_config() step when clk disabled, and then flush the
cache when we enable, update_config(), and disable caching for the
registers. recalc_rate() would work unchanged then because it would
always hit in the cache when caching is on, or read the hardware when
caching was off. We would need something that lets us bypass the cache
though and write directly when we force the safe src. There's already
some regmap caching code, so it might work with some more APIs added. Or
we could go the custom cache route and see how bad it is.

> +}
> +
> +static void clk_rcg2_shared_disable(struct clk_hw *hw)
> +{
> +       struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> +       struct freq_tbl safe_src_freq_tbl = { 0 };
> +
> +       safe_src_freq_tbl.src = rcg->safe_src_index;
> +       safe_src_freq_tbl.freq = clk_rcg2_get_safe_src_rate(hw);
> +
> +       /*
> +        * Park the RCG at a safe configuration - sourced off from safe source.
> +        * Force enable and disable the RCG while configuring it to safeguard
> +        * against any update signal coming from the downstream clock.
> +        * The current parent is still prepared and enabled at this point, and
> +        * the safe source is always on while application processor subsystem
> +        * is online. Therefore, the RCG can safely switch its parent.
> +        */
> +       clk_rcg2_set_force_enable(hw);
> +       clk_rcg2_configure(rcg, &safe_src_freq_tbl);

Again, slam in index and call update_config() directly.

> +       clk_rcg2_clear_force_enable(hw);
> +}
