Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2C8C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E73320890
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E73320890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754447AbeGIIAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:00:18 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3785 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbeGIIAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:00:16 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b43160e0000>; Mon, 09 Jul 2018 01:00:14 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 09 Jul 2018 01:00:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 09 Jul 2018 01:00:16 -0700
Received: from tbergstrom-lnx.Nvidia.com (172.20.13.39) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1347.2; Mon, 9 Jul 2018 08:00:15 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1002)
        id 4AA14F8012A; Mon,  9 Jul 2018 11:00:12 +0300 (EEST)
Date:   Mon, 9 Jul 2018 11:00:12 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Aapo Vienamo <avienamo@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] clk: tegra: Add sdmmc mux divider clock
Message-ID: <20180709080012.GE27696@tbergstrom-lnx.Nvidia.com>
References: <1530699455-27654-1-git-send-email-avienamo@nvidia.com>
 <1530699455-27654-2-git-send-email-avienamo@nvidia.com>
 <153090111049.143105.9486166124584607061@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <153090111049.143105.9486166124584607061@swboyd.mtv.corp.google.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 11:18:30AM -0700, Stephen Boyd wrote:
> Quoting Aapo Vienamo (2018-07-04 03:17:34)
> > diff --git a/drivers/clk/tegra/clk-sdmmc-mux.c b/drivers/clk/tegra/clk-sdmmc-mux.c
> > new file mode 100644
> > index 0000000..8e19cb3
> > --- /dev/null
> > +++ b/drivers/clk/tegra/clk-sdmmc-mux.c
> > @@ -0,0 +1,254 @@
> > +/*
> > + * Copyright (c) 2018 NVIDIA CORPORATION.  All rights reserved.
> > + *
> > + * based on clk-mux.c
> > +
> > + * Copyright (C) 2011 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
> > + * Copyright (C) 2011 Richard Zhao, Linaro <richard.zhao@linaro.org>
> > + * Copyright (C) 2011-2012 Mike Turquette, Linaro Ltd <mturquette@linaro.org>
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> 
> Any chance we can get SPDX tags here instead of all the boiler plate?
> 
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/err.h>
> > +#include <linux/types.h>
> > +
> > +#include "clk.h"
> > +
> > +#define DIV_MASK GENMASK(7, 0)
> > +#define MUX_SHIFT 29
> > +#define MUX_MASK GENMASK(MUX_SHIFT + 2, MUX_SHIFT)
> > +
> > +#define get_max_div(d) DIV_MASK
> > +#define get_div_field(val) ((val) & DIV_MASK)
> > +#define get_mux_field(val) (((val) & MUX_MASK) >> MUX_SHIFT)
> > +
> > +static const char * const mux_sdmmc_parents[] = { "pll_p", "pll_c4_out2",
> > +                                                 "pll_c4_out0", "pll_c4_out1",
> > +                                                  "clk_m" };
> > +static u8 mux_lj_idx[] = { [0] = 0, [1] = 1, [2] = 2, [3] = 5, [4] = 6 };
> > +static u8 mux_non_lj_idx[] = { [0] = 0, [1] = 3, [2] = 7, [3] = 4, [4] = 6 };
> 
> These can be const?
> 
> > +
> > +static u8 clk_sdmmc_mux_get_parent(struct clk_hw *hw)
> > +{
> [...]
> > +static int clk_sdmmc_mux_set_rate(struct clk_hw *hw, unsigned long rate,
> > +                                 unsigned long parent_rate)
> > +{
> > +       struct tegra_sdmmc_mux *sdmmc_mux = to_clk_sdmmc_mux(hw);
> > +       int div;
> > +       unsigned long flags = 0;
> > +       u32 val;
> > +       u8 src;
> > +
> > +       div = div71_get(rate, parent_rate, 8, 1, sdmmc_mux->div_flags);
> > +       if (div < 0)
> > +               return div;
> > +
> > +       if (sdmmc_mux->lock)
> > +               spin_lock_irqsave(sdmmc_mux->lock, flags);
> > +
> > +       src = clk_sdmmc_mux_get_parent(hw);
> > +       if (div)
> > +               src = mux_non_lj_idx[src];
> > +       else
> > +               src = mux_lj_idx[src];
> > +
> > +       val = src << MUX_SHIFT;
> > +       val |= div;
> > +       writel(val, sdmmc_mux->reg);
> > +       fence_udelay(2, sdmmc_mux->reg);
> > +
> > +       if (sdmmc_mux->lock)
> > +               spin_unlock_irqrestore(sdmmc_mux->lock, flags);
> 
> This conditional locking will give sparse a headache. O well.
> 
> > +
> > +       return 0;
> > +}
> > +
> > +static int clk_sdmmc_mux_is_enabled(struct clk_hw *hw)
> > +{
> > +       struct tegra_sdmmc_mux *sdmmc_mux = to_clk_sdmmc_mux(hw);
> > +       const struct clk_ops *gate_ops = sdmmc_mux->gate_ops;
> > +       struct clk_hw *gate_hw = &sdmmc_mux->gate.hw;
> > +
> > +       __clk_hw_set_clk(gate_hw, hw);
> > +
> > +       return gate_ops->is_enabled(gate_hw);
> > +}
> > +
> > +static int clk_sdmmc_mux_enable(struct clk_hw *hw)
> > +{
> > +       struct tegra_sdmmc_mux *sdmmc_mux = to_clk_sdmmc_mux(hw);
> > +       const struct clk_ops *gate_ops = sdmmc_mux->gate_ops;
> > +       struct clk_hw *gate_hw = &sdmmc_mux->gate.hw;
> > +
> > +       __clk_hw_set_clk(gate_hw, hw);
> > +
> > +       return  gate_ops->enable(gate_hw);
> > +}
> > +
> > +static void clk_sdmmc_mux_disable(struct clk_hw *hw)
> > +{
> > +       struct tegra_sdmmc_mux *sdmmc_mux = to_clk_sdmmc_mux(hw);
> > +       const struct clk_ops *gate_ops = sdmmc_mux->gate_ops;
> > +       struct clk_hw *gate_hw = &sdmmc_mux->gate.hw;
> > +
> > +       gate_ops->disable(gate_hw);
> > +}
> > +
> > +const struct clk_ops tegra_clk_sdmmc_mux_ops = {
> 
> static?
> 
> > +       .get_parent = clk_sdmmc_mux_get_parent,
> > +       .set_parent = clk_sdmmc_mux_set_parent,
> > +       .determine_rate = clk_sdmmc_mux_determine_rate,
> > +       .recalc_rate = clk_sdmmc_mux_recalc_rate,
> > +       .set_rate = clk_sdmmc_mux_set_rate,
> > +       .is_enabled = clk_sdmmc_mux_is_enabled,
> > +       .enable = clk_sdmmc_mux_enable,
> > +       .disable = clk_sdmmc_mux_disable,
> > +};
> > +
> > diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
> > index f14e136..4c3d0f5 100644
> > --- a/drivers/clk/tegra/clk.h
> > +++ b/drivers/clk/tegra/clk.h
> > @@ -19,6 +19,7 @@
> >  
> >  #include <linux/clk-provider.h>
> >  #include <linux/clkdev.h>
> > +#include <linux/delay.h>
> 
> Why? Include this in the C file that cares please.
> 

The fence_udelay macro uses udelay and is used in clk-sdmmc-mux.c. However it
seems more appropriate to include delay.h here rather than in every single
user of the macro.

Peter.
