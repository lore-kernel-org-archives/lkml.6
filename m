Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033914AbeEXQuk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 12:50:40 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34524 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967998AbeEXQuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 12:50:37 -0400
X-Google-Smtp-Source: AB8JxZo/MgemKYl4RXK2iiWtjEzsTVTzi40q4QiIS69C/C53cVTJITaVvQNP5NIMKcxJpFxMg5q3OQ==
Date: Thu, 24 May 2018 09:50:33 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh@kernel.org, viresh.kumar@linaro.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux@arm.linux.org.uk
Subject: Re: [PATCH v9 02/15] clk: mux: Split out register accessors for reuse
Message-ID: <20180524165033.GB14924@minitux>
References: <1520347148-27852-1-git-send-email-sricharan@codeaurora.org>
 <1520347148-27852-3-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520347148-27852-3-git-send-email-sricharan@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06 Mar 06:38 PST 2018, Sricharan R wrote:

> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> We want to reuse the logic in clk-mux.c for other clock drivers
> that don't use readl as register accessors. Fortunately, there
> really isn't much to the mux code besides the table indirection
> and quirk flags if you assume any bit shifting and masking has
> been done already. Pull that logic out into reusable functions
> that operate on an optional table and some flags so that other
> drivers can use the same logic.
> 
> [Sricharan: Rebased for mainline]
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

This should read as a log, where the first entry is Stephen stating that
he acquired or wrote the code and can release it according to the
license requirements. Then you state that you acquired it, changed it
and are releasing it according to the license requirements.


PS. Please expand your last name.

Regards,
Bjorn

> ---
>  drivers/clk/clk-mux.c         | 74 +++++++++++++++++++++++++++----------------
>  drivers/clk/nxp/clk-lpc32xx.c | 21 +++---------
>  include/linux/clk-provider.h  |  6 ++++
>  3 files changed, 57 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
> index 39cabe1..28223fa 100644
> --- a/drivers/clk/clk-mux.c
> +++ b/drivers/clk/clk-mux.c
> @@ -26,35 +26,25 @@
>   * parent - parent is adjustable through clk_set_parent
>   */
>  
> -static u8 clk_mux_get_parent(struct clk_hw *hw)
> +unsigned int clk_mux_get_parent(struct clk_hw *hw, unsigned int val,
> +				unsigned int *table,
> +				unsigned long flags)
>  {
> -	struct clk_mux *mux = to_clk_mux(hw);
>  	int num_parents = clk_hw_get_num_parents(hw);
> -	u32 val;
> -
> -	/*
> -	 * FIXME need a mux-specific flag to determine if val is bitwise or numeric
> -	 * e.g. sys_clkin_ck's clksel field is 3 bits wide, but ranges from 0x1
> -	 * to 0x7 (index starts at one)
> -	 * OTOH, pmd_trace_clk_mux_ck uses a separate bit for each clock, so
> -	 * val = 0x4 really means "bit 2, index starts at bit 0"
> -	 */
> -	val = clk_readl(mux->reg) >> mux->shift;
> -	val &= mux->mask;
>  
> -	if (mux->table) {
> +	if (table) {
>  		int i;
>  
>  		for (i = 0; i < num_parents; i++)
> -			if (mux->table[i] == val)
> +			if (table[i] == val)
>  				return i;
>  		return -EINVAL;
>  	}
>  
> -	if (val && (mux->flags & CLK_MUX_INDEX_BIT))
> +	if (val && (flags & CLK_MUX_INDEX_BIT))
>  		val = ffs(val) - 1;
>  
> -	if (val && (mux->flags & CLK_MUX_INDEX_ONE))
> +	if (val && (flags & CLK_MUX_INDEX_ONE))
>  		val--;
>  
>  	if (val >= num_parents)
> @@ -62,23 +52,53 @@ static u8 clk_mux_get_parent(struct clk_hw *hw)
>  
>  	return val;
>  }
> +EXPORT_SYMBOL_GPL(clk_mux_get_parent);
>  
> -static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
> +static u8 _clk_mux_get_parent(struct clk_hw *hw)
>  {
>  	struct clk_mux *mux = to_clk_mux(hw);
>  	u32 val;
> -	unsigned long flags = 0;
>  
> -	if (mux->table) {
> -		index = mux->table[index];
> +	/*
> +	 * FIXME need a mux-specific flag to determine if val is bitwise or
> +	 * numeric e.g. sys_clkin_ck's clksel field is 3 bits wide,
> +	 * but ranges from 0x1 to 0x7 (index starts at one)
> +	 * OTOH, pmd_trace_clk_mux_ck uses a separate bit for each clock, so
> +	 * val = 0x4 really means "bit 2, index starts at bit 0"
> +	 */
> +	val = clk_readl(mux->reg) >> mux->shift;
> +	val &= mux->mask;
> +
> +	return clk_mux_get_parent(hw, val, mux->table, mux->flags);
> +}
> +
> +unsigned int clk_mux_reindex(u8 index, unsigned int *table,
> +			     unsigned long flags)
> +{
> +	unsigned int val = index;
> +
> +	if (table) {
> +		val = table[val];
>  	} else {
> -		if (mux->flags & CLK_MUX_INDEX_BIT)
> -			index = 1 << index;
> +		if (flags & CLK_MUX_INDEX_BIT)
> +			val = 1 << index;
>  
> -		if (mux->flags & CLK_MUX_INDEX_ONE)
> -			index++;
> +		if (flags & CLK_MUX_INDEX_ONE)
> +			val++;
>  	}
>  
> +	return val;
> +}
> +EXPORT_SYMBOL_GPL(clk_mux_reindex);
> +
> +static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
> +{
> +	struct clk_mux *mux = to_clk_mux(hw);
> +	u32 val;
> +	unsigned long flags = 0;
> +
> +	index = clk_mux_reindex(index, mux->table, mux->flags);
> +
>  	if (mux->lock)
>  		spin_lock_irqsave(mux->lock, flags);
>  	else
> @@ -102,14 +122,14 @@ static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
>  }
>  
>  const struct clk_ops clk_mux_ops = {
> -	.get_parent = clk_mux_get_parent,
> +	.get_parent = _clk_mux_get_parent,
>  	.set_parent = clk_mux_set_parent,
>  	.determine_rate = __clk_mux_determine_rate,
>  };
>  EXPORT_SYMBOL_GPL(clk_mux_ops);
>  
>  const struct clk_ops clk_mux_ro_ops = {
> -	.get_parent = clk_mux_get_parent,
> +	.get_parent = _clk_mux_get_parent,
>  };
>  EXPORT_SYMBOL_GPL(clk_mux_ro_ops);
>  
> diff --git a/drivers/clk/nxp/clk-lpc32xx.c b/drivers/clk/nxp/clk-lpc32xx.c
> index f5d815f..9b34150 100644
> --- a/drivers/clk/nxp/clk-lpc32xx.c
> +++ b/drivers/clk/nxp/clk-lpc32xx.c
> @@ -999,29 +999,16 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
>  	.set_rate = clk_divider_set_rate,
>  };
>  
> -static u8 clk_mux_get_parent(struct clk_hw *hw)
> +static u8 _clk_mux_get_parent(struct clk_hw *hw)
>  {
>  	struct lpc32xx_clk_mux *mux = to_lpc32xx_mux(hw);
> -	u32 num_parents = clk_hw_get_num_parents(hw);
>  	u32 val;
>  
>  	regmap_read(clk_regmap, mux->reg, &val);
>  	val >>= mux->shift;
>  	val &= mux->mask;
>  
> -	if (mux->table) {
> -		u32 i;
> -
> -		for (i = 0; i < num_parents; i++)
> -			if (mux->table[i] == val)
> -				return i;
> -		return -EINVAL;
> -	}
> -
> -	if (val >= num_parents)
> -		return -EINVAL;
> -
> -	return val;
> +	return clk_mux_get_parent(hw, val, mux->table, 0);
>  }
>  
>  static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
> @@ -1036,11 +1023,11 @@ static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
>  }
>  
>  static const struct clk_ops lpc32xx_clk_mux_ro_ops = {
> -	.get_parent = clk_mux_get_parent,
> +	.get_parent = _clk_mux_get_parent,
>  };
>  
>  static const struct clk_ops lpc32xx_clk_mux_ops = {
> -	.get_parent = clk_mux_get_parent,
> +	.get_parent = _clk_mux_get_parent,
>  	.set_parent = clk_mux_set_parent,
>  	.determine_rate = __clk_mux_determine_rate,
>  };
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index f711be6..344ad92 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -488,6 +488,12 @@ struct clk_mux {
>  extern const struct clk_ops clk_mux_ops;
>  extern const struct clk_ops clk_mux_ro_ops;
>  
> +unsigned int clk_mux_get_parent(struct clk_hw *hw, unsigned int val,
> +				unsigned int *table,
> +				unsigned long flags);
> +unsigned int clk_mux_reindex(u8 index, unsigned int *table,
> +			     unsigned long flags);
> +
>  struct clk *clk_register_mux(struct device *dev, const char *name,
>  		const char * const *parent_names, u8 num_parents,
>  		unsigned long flags,
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
> 
