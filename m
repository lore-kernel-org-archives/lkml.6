Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51ADC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5798620864
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnHkXH+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5798620864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934119AbeGFSSd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:18:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933740AbeGFSSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:18:31 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30D5F20864;
        Fri,  6 Jul 2018 18:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530901111;
        bh=VP/YqPxoXEb3JEcj+NOhaDy4VJe7atclRtFwGd+Xf6s=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=pnHkXH+qKFXoRfj+peJFFiPgKfTsC406nYn1zAICe+/ismCBx9XoK2n3HBS40OkoN
         qNM6r+TRnUCk0mJ/w1Kq6oXfkTcvLkMDOdoR6quEav8CifhC8hzzIUbPuIezEKKdDx
         akOIs+7yspWGZO42BKr8lIlJop0djTXcYBsqetl0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Aapo Vienamo <avienamo@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1530699455-27654-2-git-send-email-avienamo@nvidia.com>
Cc:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
References: <1530699455-27654-1-git-send-email-avienamo@nvidia.com>
 <1530699455-27654-2-git-send-email-avienamo@nvidia.com>
Message-ID: <153090111049.143105.9486166124584607061@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 2/3] clk: tegra: Add sdmmc mux divider clock
Date:   Fri, 06 Jul 2018 11:18:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aapo Vienamo (2018-07-04 03:17:34)
> diff --git a/drivers/clk/tegra/clk-sdmmc-mux.c b/drivers/clk/tegra/clk-sd=
mmc-mux.c
> new file mode 100644
> index 0000000..8e19cb3
> --- /dev/null
> +++ b/drivers/clk/tegra/clk-sdmmc-mux.c
> @@ -0,0 +1,254 @@
> +/*
> + * Copyright (c) 2018 NVIDIA CORPORATION.  All rights reserved.
> + *
> + * based on clk-mux.c
> +
> + * Copyright (C) 2011 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
> + * Copyright (C) 2011 Richard Zhao, Linaro <richard.zhao@linaro.org>
> + * Copyright (C) 2011-2012 Mike Turquette, Linaro Ltd <mturquette@linaro=
.org>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.

Any chance we can get SPDX tags here instead of all the boiler plate?

> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/types.h>
> +
> +#include "clk.h"
> +
> +#define DIV_MASK GENMASK(7, 0)
> +#define MUX_SHIFT 29
> +#define MUX_MASK GENMASK(MUX_SHIFT + 2, MUX_SHIFT)
> +
> +#define get_max_div(d) DIV_MASK
> +#define get_div_field(val) ((val) & DIV_MASK)
> +#define get_mux_field(val) (((val) & MUX_MASK) >> MUX_SHIFT)
> +
> +static const char * const mux_sdmmc_parents[] =3D { "pll_p", "pll_c4_out=
2",
> +                                                 "pll_c4_out0", "pll_c4_=
out1",
> +                                                  "clk_m" };
> +static u8 mux_lj_idx[] =3D { [0] =3D 0, [1] =3D 1, [2] =3D 2, [3] =3D 5,=
 [4] =3D 6 };
> +static u8 mux_non_lj_idx[] =3D { [0] =3D 0, [1] =3D 3, [2] =3D 7, [3] =
=3D 4, [4] =3D 6 };

These can be const?

> +
> +static u8 clk_sdmmc_mux_get_parent(struct clk_hw *hw)
> +{
[...]
> +static int clk_sdmmc_mux_set_rate(struct clk_hw *hw, unsigned long rate,
> +                                 unsigned long parent_rate)
> +{
> +       struct tegra_sdmmc_mux *sdmmc_mux =3D to_clk_sdmmc_mux(hw);
> +       int div;
> +       unsigned long flags =3D 0;
> +       u32 val;
> +       u8 src;
> +
> +       div =3D div71_get(rate, parent_rate, 8, 1, sdmmc_mux->div_flags);
> +       if (div < 0)
> +               return div;
> +
> +       if (sdmmc_mux->lock)
> +               spin_lock_irqsave(sdmmc_mux->lock, flags);
> +
> +       src =3D clk_sdmmc_mux_get_parent(hw);
> +       if (div)
> +               src =3D mux_non_lj_idx[src];
> +       else
> +               src =3D mux_lj_idx[src];
> +
> +       val =3D src << MUX_SHIFT;
> +       val |=3D div;
> +       writel(val, sdmmc_mux->reg);
> +       fence_udelay(2, sdmmc_mux->reg);
> +
> +       if (sdmmc_mux->lock)
> +               spin_unlock_irqrestore(sdmmc_mux->lock, flags);

This conditional locking will give sparse a headache. O well.

> +
> +       return 0;
> +}
> +
> +static int clk_sdmmc_mux_is_enabled(struct clk_hw *hw)
> +{
> +       struct tegra_sdmmc_mux *sdmmc_mux =3D to_clk_sdmmc_mux(hw);
> +       const struct clk_ops *gate_ops =3D sdmmc_mux->gate_ops;
> +       struct clk_hw *gate_hw =3D &sdmmc_mux->gate.hw;
> +
> +       __clk_hw_set_clk(gate_hw, hw);
> +
> +       return gate_ops->is_enabled(gate_hw);
> +}
> +
> +static int clk_sdmmc_mux_enable(struct clk_hw *hw)
> +{
> +       struct tegra_sdmmc_mux *sdmmc_mux =3D to_clk_sdmmc_mux(hw);
> +       const struct clk_ops *gate_ops =3D sdmmc_mux->gate_ops;
> +       struct clk_hw *gate_hw =3D &sdmmc_mux->gate.hw;
> +
> +       __clk_hw_set_clk(gate_hw, hw);
> +
> +       return  gate_ops->enable(gate_hw);
> +}
> +
> +static void clk_sdmmc_mux_disable(struct clk_hw *hw)
> +{
> +       struct tegra_sdmmc_mux *sdmmc_mux =3D to_clk_sdmmc_mux(hw);
> +       const struct clk_ops *gate_ops =3D sdmmc_mux->gate_ops;
> +       struct clk_hw *gate_hw =3D &sdmmc_mux->gate.hw;
> +
> +       gate_ops->disable(gate_hw);
> +}
> +
> +const struct clk_ops tegra_clk_sdmmc_mux_ops =3D {

static?

> +       .get_parent =3D clk_sdmmc_mux_get_parent,
> +       .set_parent =3D clk_sdmmc_mux_set_parent,
> +       .determine_rate =3D clk_sdmmc_mux_determine_rate,
> +       .recalc_rate =3D clk_sdmmc_mux_recalc_rate,
> +       .set_rate =3D clk_sdmmc_mux_set_rate,
> +       .is_enabled =3D clk_sdmmc_mux_is_enabled,
> +       .enable =3D clk_sdmmc_mux_enable,
> +       .disable =3D clk_sdmmc_mux_disable,
> +};
> +
> diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
> index f14e136..4c3d0f5 100644
> --- a/drivers/clk/tegra/clk.h
> +++ b/drivers/clk/tegra/clk.h
> @@ -19,6 +19,7 @@
>  =

>  #include <linux/clk-provider.h>
>  #include <linux/clkdev.h>
> +#include <linux/delay.h>

Why? Include this in the C file that cares please.

>  =

>  /**
>   * struct tegra_clk_sync_source - external clock source from codec
