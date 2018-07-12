Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D338C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29AFA20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29AFA20BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeGLLla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:41:30 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19150 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeGLLl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:41:29 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b473c3d0000>; Thu, 12 Jul 2018 04:32:13 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 12 Jul 2018 04:32:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 12 Jul 2018 04:32:18 -0700
Received: from [10.21.132.122] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 12 Jul
 2018 11:32:16 +0000
Subject: Re: [PATCH v5 3/4] clk: tegra: Add sdmmc mux divider clock
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
CC:     Aapo Vienamo <avienamo@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
References: <1531319965-19689-1-git-send-email-avienamo@nvidia.com>
 <1531319965-19689-4-git-send-email-avienamo@nvidia.com>
 <606a5a54-7674-0cca-9040-f8cb93b3cf8f@nvidia.com>
 <20180712112042.GF1636@tbergstrom-lnx.Nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <27861604-8d9a-eddf-9d5e-1b6742e01720@nvidia.com>
Date:   Thu, 12 Jul 2018 12:32:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180712112042.GF1636@tbergstrom-lnx.Nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/07/18 12:20, Peter De Schrijver wrote:
> On Thu, Jul 12, 2018 at 11:52:31AM +0100, Jon Hunter wrote:
>>
>> On 11/07/18 15:39, Aapo Vienamo wrote:
>>> From: Peter De-Schrijver <pdeschrijver@nvidia.com>
>>>
>>> Add a clock type to model the sdmmc switch divider clocks which have paths
>>> to source clocks bypassing the divider (Low Jitter paths). These
>>> are handled by selecting the lj path when the divider is 1 (ie the
>>> rate is the parent rate), otherwise the normal path with divider
>>> will be selected. Otherwise this clock behaves as a normal peripheral
>>> clock.
>>>
>>> Signed-off-by: Peter De-Schrijver <pdeschrijver@nvidia.com>
>>> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
>>> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>>> ---
>>>  drivers/clk/tegra/Makefile        |   1 +
>>>  drivers/clk/tegra/clk-sdmmc-mux.c | 249 ++++++++++++++++++++++++++++++++++++++
>>>  drivers/clk/tegra/clk.h           |  26 ++++
>>>  3 files changed, 276 insertions(+)
>>>  create mode 100644 drivers/clk/tegra/clk-sdmmc-mux.c
>>>
>>> diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
>>> index c79319d..8975f88 100644
>>> --- a/drivers/clk/tegra/Makefile
>>> +++ b/drivers/clk/tegra/Makefile
>>> @@ -8,6 +8,7 @@ obj-y					+= clk-periph-fixed.o
>>>  obj-y					+= clk-periph-gate.o
>>>  obj-y					+= clk-pll.o
>>>  obj-y					+= clk-pll-out.o
>>> +obj-y					+= clk-sdmmc-mux.o
>>>  obj-y					+= clk-super.o
>>>  obj-y					+= clk-tegra-audio.o
>>>  obj-y					+= clk-tegra-periph.o
>>> diff --git a/drivers/clk/tegra/clk-sdmmc-mux.c b/drivers/clk/tegra/clk-sdmmc-mux.c
>>> new file mode 100644
>>> index 0000000..9566754
>>> --- /dev/null
>>> +++ b/drivers/clk/tegra/clk-sdmmc-mux.c
>>> @@ -0,0 +1,249 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (c) 2018 NVIDIA CORPORATION.  All rights reserved.
>>> + *
>>> + * based on clk-mux.c
>>> + *
>>> + * Copyright (C) 2011 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
>>> + * Copyright (C) 2011 Richard Zhao, Linaro <richard.zhao@linaro.org>
>>> + * Copyright (C) 2011-2012 Mike Turquette, Linaro Ltd <mturquette@linaro.org>
>>> + *
>>> + */
>>> +
>>> +#include <linux/clk-provider.h>
>>> +#include <linux/err.h>
>>> +#include <linux/types.h>
>>> +
>>> +#include "clk.h"
>>> +
>>> +#define DIV_MASK GENMASK(7, 0)
>>> +#define MUX_SHIFT 29
>>> +#define MUX_MASK GENMASK(MUX_SHIFT + 2, MUX_SHIFT)
>>> +
>>> +#define get_max_div(d) DIV_MASK
>>> +#define get_div_field(val) ((val) & DIV_MASK)
>>> +#define get_mux_field(val) (((val) & MUX_MASK) >> MUX_SHIFT)
>>> +
>>> +static const char * const mux_sdmmc_parents[] = {
>>> +	"pll_p", "pll_c4_out2", "pll_c4_out0", "pll_c4_out1", "clk_m"
>>> +};
>>> +
>>> +static const u8 mux_lj_idx[] = {
>>> +	[0] = 0, [1] = 1, [2] = 2, [3] = 5, [4] = 6
>>> +};
>>> +
>>> +static const u8 mux_non_lj_idx[] = {
>>> +	[0] = 0, [1] = 3, [2] = 7, [3] = 4, [4] = 6
>>> +};
>>> +
>>> +static u8 clk_sdmmc_mux_get_parent(struct clk_hw *hw)
>>> +{
>>> +	struct tegra_sdmmc_mux *sdmmc_mux = to_clk_sdmmc_mux(hw);
>>> +	int num_parents, i;
>>> +	u32 src, val;
>>> +	const u8 *mux_idx;
>>> +
>>> +	num_parents = clk_hw_get_num_parents(hw);
>>> +
>>> +	val = readl_relaxed(sdmmc_mux->reg);
>>> +	src = get_mux_field(val);
>>> +	if (get_div_field(val))
>>> +		mux_idx = mux_non_lj_idx;
>>> +	else
>>> +		mux_idx = mux_lj_idx;
>>> +
>>> +	for (i = 0; i < num_parents; i++) {
>>> +		if (mux_idx[i] == src)
>>> +			return i;
>>> +	}
>>> +
>>> +	WARN(1, "Unknown parent selector %d\n", src);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int clk_sdmmc_mux_set_parent(struct clk_hw *hw, u8 index)
>>> +{
>>> +	struct tegra_sdmmc_mux *sdmmc_mux = to_clk_sdmmc_mux(hw);
>>> +	u32 val;
>>> +
>>> +
>>> +	val = readl_relaxed(sdmmc_mux->reg);
>>> +	if (get_div_field(val))
>>> +		index = mux_non_lj_idx[index];
>>> +	else
>>> +		index = mux_lj_idx[index];
>>> +
>>> +	val &= ~MUX_MASK;
>>> +	val |= index << MUX_SHIFT;
>>> +
>>> +	writel(val, sdmmc_mux->reg);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static unsigned long clk_sdmmc_mux_recalc_rate(struct clk_hw *hw,
>>> +					       unsigned long parent_rate)
>>> +{
>>> +	struct tegra_sdmmc_mux *sdmmc_mux = to_clk_sdmmc_mux(hw);
>>> +	u32 val;
>>> +	int div, mul;
>>> +	u64 rate = parent_rate;
>>> +
>>> +	val = readl_relaxed(sdmmc_mux->reg);
>>> +	div = get_div_field(val);
>>> +
>>> +	mul = 2;
>>> +	div += mul;
>>> +
>>> +	rate *= mul;
>>> +	rate += div - 1;
>>> +	do_div(rate, div);
>>> +
>>> +	return rate;
>>> +}
>>> +
>>> +static int clk_sdmmc_mux_determine_rate(struct clk_hw *hw,
>>> +					struct clk_rate_request *req)
>>> +{
>>> +	struct tegra_sdmmc_mux *sdmmc_mux = to_clk_sdmmc_mux(hw);
>>> +	int div, mul;
>>> +	unsigned long output_rate = req->best_parent_rate;
>>> +
>>> +	req->rate = max(req->rate, req->min_rate);
>>> +	req->rate = min(req->rate, req->max_rate);
>>> +
>>> +	if (!req->rate)
>>> +		return output_rate;
>>> +
>>> +	div = div_frac_get(req->rate, output_rate, 8, 1, sdmmc_mux->div_flags);
>>> +	if (div < 0)
>>> +		div = 0;
>>> +
>>> +	mul = 2;
>>
>> This multiplier never changes and so maybe more appropriate to add a 
>> #define TEGRA_SDMMC_MULT or something for this function and the above.
>>
>>> +	if (sdmmc_mux->div_flags & TEGRA_DIVIDER_ROUND_UP)
>>> +		req->rate =  DIV_ROUND_UP(output_rate * mul, div + mul);
>>> +	else
>>> +		req->rate =  output_rate * mul / (div + mul);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int clk_sdmmc_mux_set_rate(struct clk_hw *hw, unsigned long rate,
>>> +				  unsigned long parent_rate)
>>> +{
>>> +	struct tegra_sdmmc_mux *sdmmc_mux = to_clk_sdmmc_mux(hw);
>>> +	int div;
>>> +	unsigned long flags = 0;
>>> +	u32 val;
>>> +	u8 src;
>>> +
>>> +	div = div_frac_get(rate, parent_rate, 8, 1, sdmmc_mux->div_flags);
>>> +	if (div < 0)
>>> +		return div;
>>> +
>>> +	if (sdmmc_mux->lock)
>>> +		spin_lock_irqsave(sdmmc_mux->lock, flags);
>>> +
>>> +	src = clk_sdmmc_mux_get_parent(hw);
>>> +	if (div)
>>> +		src = mux_non_lj_idx[src];
>>> +	else
>>> +		src = mux_lj_idx[src];
>>> +
>>> +	val = src << MUX_SHIFT;
>>> +	val |= div;
>>> +	writel(val, sdmmc_mux->reg);
>>> +	fence_udelay(2, sdmmc_mux->reg);
>>> +
>>> +	if (sdmmc_mux->lock)
>>> +		spin_unlock_irqrestore(sdmmc_mux->lock, flags);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int clk_sdmmc_mux_is_enabled(struct clk_hw *hw)
>>> +{
>>> +	struct tegra_sdmmc_mux *sdmmc_mux = to_clk_sdmmc_mux(hw);
>>> +	const struct clk_ops *gate_ops = sdmmc_mux->gate_ops;
>>> +	struct clk_hw *gate_hw = &sdmmc_mux->gate.hw;
>>> +
>>> +	__clk_hw_set_clk(gate_hw, hw);
>>> +
>>> +	return gate_ops->is_enabled(gate_hw);
>>> +}
>>> +
>>> +static int clk_sdmmc_mux_enable(struct clk_hw *hw)
>>> +{
>>> +	struct tegra_sdmmc_mux *sdmmc_mux = to_clk_sdmmc_mux(hw);
>>> +	const struct clk_ops *gate_ops = sdmmc_mux->gate_ops;
>>> +	struct clk_hw *gate_hw = &sdmmc_mux->gate.hw;
>>> +
>>> +	__clk_hw_set_clk(gate_hw, hw);
>>> +
>>> +	return  gate_ops->enable(gate_hw);
>>
>> Nit-pick ... extra space.
>>
>>> +}
>>> +
>>> +static void clk_sdmmc_mux_disable(struct clk_hw *hw)
>>> +{
>>> +	struct tegra_sdmmc_mux *sdmmc_mux = to_clk_sdmmc_mux(hw);
>>> +	const struct clk_ops *gate_ops = sdmmc_mux->gate_ops;
>>> +	struct clk_hw *gate_hw = &sdmmc_mux->gate.hw;
>>> +
>>> +	gate_ops->disable(gate_hw);
>>> +}
>>> +
>>> +static const struct clk_ops tegra_clk_sdmmc_mux_ops = {
>>> +	.get_parent = clk_sdmmc_mux_get_parent,
>>> +	.set_parent = clk_sdmmc_mux_set_parent,
>>> +	.determine_rate = clk_sdmmc_mux_determine_rate,
>>> +	.recalc_rate = clk_sdmmc_mux_recalc_rate,
>>> +	.set_rate = clk_sdmmc_mux_set_rate,
>>> +	.is_enabled = clk_sdmmc_mux_is_enabled,
>>> +	.enable = clk_sdmmc_mux_enable,
>>> +	.disable = clk_sdmmc_mux_disable,
>>> +};
>>> +
>>> +struct clk *tegra_clk_register_sdmmc_mux_div(const char *name,
>>> +	void __iomem *clk_base, u32 offset, u32 clk_num, u8 div_flags,
>>> +	unsigned long flags, void *lock)
>>> +{
>>> +	struct clk *clk;
>>> +	struct clk_init_data init;
>>> +	const struct tegra_clk_periph_regs *bank;
>>> +	struct tegra_sdmmc_mux *sdmmc_mux;
>>> +
>>> +	init.ops = &tegra_clk_sdmmc_mux_ops;
>>> +	init.name = name;
>>> +	init.flags = flags;
>>
>> Flags do not appear to be passed by the callers currently. Do we need
>> to pass these or could we set to 0 here?
>>
> 
> This is what we do for all other peripheral clocks. I don't think it makes
> much sense to deviate from that pattern for this case.
> 
>>> +	init.parent_names = mux_sdmmc_parents;
>>> +	init.num_parents = ARRAY_SIZE(mux_sdmmc_parents);
>>> +
>>> +	bank = get_reg_bank(clk_num);
>>> +	if (!bank)
>>> +		return ERR_PTR(-EINVAL);
>>> +
>>> +	sdmmc_mux = kzalloc(sizeof(*sdmmc_mux), GFP_KERNEL);
>>> +	if (!sdmmc_mux)
>>> +		return ERR_PTR(-ENOMEM);
>>> +
>>> +	/* Data in .init is copied by clk_register(), so stack variable OK */
>>> +	sdmmc_mux->hw.init = &init;
>>> +	sdmmc_mux->reg = clk_base + offset;
>>> +	sdmmc_mux->lock = lock;
>>
>> Does not look like this lock is never used. The callers pass NULL.
>> Do we have plans to use this?
>>
> 
> Same here. This is inline with what we do for other peripheral clocks even
> though the vast majority never needs this.
> 
>>> +	sdmmc_mux->gate.clk_base = clk_base;
>>> +	sdmmc_mux->gate.regs = bank;
>>> +	sdmmc_mux->gate.enable_refcnt = periph_clk_enb_refcnt;
>>> +	sdmmc_mux->gate.clk_num = clk_num;
>>> +	sdmmc_mux->gate.flags = TEGRA_PERIPH_ON_APB;
>>> +	sdmmc_mux->div_flags = div_flags;
>>
>> Callers set div_flags to TEGRA_DIVIDER_ROUND_UP. Does this need to
>> be passed?
>>
> 
> Not sure if this will always be the case.

OK, the above is fine with me.

Cheers
Jon

-- 
nvpublic
