Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31BAECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F9321477
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJM0tjbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F9321477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeJRDsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:48:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727186AbeJRDsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:48:50 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E446C2145D;
        Wed, 17 Oct 2018 19:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539805896;
        bh=3cZWgSbJz6QOo4+sKFC0BRwcUF6DXysyiT5nPE3u/i0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=gJM0tjbMj79fVZ/H7x7HtewXyBWLsKJyQuYblIkhZEA5fb0AKxYMfbfOXy/yZVeoy
         xxYTXz5lo5z7ydpxa3tciEwhjawAvc/VEvluuhjj7T/6ZOkNML/fUTsBf5KDW9s3wK
         fs4WmNoU9oYg4kQKa/8m6jZMXFBjX4r7Vwx/tfEA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Abel Vesa <abel.vesa@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1537785597-26499-5-git-send-email-abel.vesa@nxp.com>
Cc:     linux-imx@nxp.com, Abel Vesa <abelvesa@linux.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
References: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
 <1537785597-26499-5-git-send-email-abel.vesa@nxp.com>
Message-ID: <153980589525.5275.9065338436630625817@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v9 4/5] clk: imx: add imx composite clock
Date:   Wed, 17 Oct 2018 12:51:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2018-09-24 03:39:56)
> diff --git a/drivers/clk/imx/clk-composite.c b/drivers/clk/imx/clk-compos=
ite.c
> new file mode 100644
> index 0000000..4b03107
> --- /dev/null
> +++ b/drivers/clk/imx/clk-composite.c
> @@ -0,0 +1,181 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2018 NXP
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/slab.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clk.h>

Is this include used?

> +
> +#include "clk.h"
> +
> +#define PCG_PREDIV_SHIFT       16
> +#define PCG_PREDIV_WIDTH       3
> +#define PCG_PREDIV_MAX         8
> +
> +#define PCG_DIV_SHIFT          0
> +#define PCG_DIV_WIDTH          6
> +#define PCG_DIV_MAX            64
> +
> +#define PCG_PCS_SHIFT          24
> +#define PCG_PCS_MASK           0x7
> +
> +#define PCG_CGC_SHIFT          28
> +
> +static unsigned long imx_clk_composite_divider_recalc_rate(struct clk_hw=
 *hw,
> +                                               unsigned long parent_rate)
> +{
> +       struct clk_divider *divider =3D to_clk_divider(hw);
> +       unsigned long prediv_rate;
> +       unsigned int prediv_value;
> +       unsigned int div_value;
> +
> +       prediv_value =3D clk_readl(divider->reg) >> divider->shift;
> +       prediv_value &=3D clk_div_mask(divider->width);
> +
> +       prediv_rate =3D divider_recalc_rate(hw, parent_rate, prediv_value,
> +                                               NULL, divider->flags,
> +                                               divider->width);
> +
> +       div_value =3D clk_readl(divider->reg) >> PCG_DIV_SHIFT;
> +       div_value &=3D clk_div_mask(PCG_DIV_WIDTH);
> +
> +       return divider_recalc_rate(hw, prediv_rate, div_value, NULL,
> +                                  divider->flags, PCG_DIV_WIDTH);
> +}
> +
> +static int imx_clk_composite_compute_dividers(unsigned long rate,
> +                                               unsigned long parent_rate,
> +                                               int *prediv, int *postdiv)
> +{
> +       int div1, div2;
> +       int error =3D INT_MAX;
> +       int ret =3D -EINVAL;
> +
> +       /* default values */
> +       *prediv =3D 1;
> +       *postdiv =3D 1;
> +
> +       for (div1 =3D 1; div1 <=3D PCG_PREDIV_MAX; div1++) {
> +               for (div2 =3D 1; div2 <=3D PCG_DIV_MAX; div2++) {
> +                       int new_error =3D ((parent_rate / div1) / div2) -=
 rate;
> +
> +                       if (abs(new_error) < abs(error)) {
> +                               *prediv =3D div1;
> +                               *postdiv =3D div2;
> +                               error =3D new_error;
> +                               ret =3D 0;
> +                       }
> +               }
> +       }
> +       return ret;
> +}
> +
> +static long imx_clk_composite_divider_round_rate(struct clk_hw *hw,
> +                                               unsigned long rate,
> +                                               unsigned long *prate)
> +{
> +       int prediv_value;
> +       int div_value;
> +
> +       imx_clk_composite_compute_dividers(rate, *prate,
> +                                               &prediv_value, &div_value=
);
> +
> +       rate =3D DIV_ROUND_UP_ULL((u64)*prate, prediv_value);
> +       rate =3D DIV_ROUND_UP_ULL((u64)rate, div_value);
> +
> +       return rate;

Looks the same as another patch, maybe it is?

Anyway, same nitpick about returning the DIV_ROUND_UP_ULL() result.

> +}
> +
> +static int imx_clk_composite_divider_set_rate(struct clk_hw *hw,
> +                                       unsigned long rate,
> +                                       unsigned long parent_rate)
> +{
> +       struct clk_divider *divider =3D to_clk_divider(hw);
> +       unsigned long flags =3D 0;
> +       int prediv_value;
> +       int div_value;
> +       int ret =3D 0;
> +       u32 val;
> +
> +       ret =3D imx_clk_composite_compute_dividers(rate, parent_rate,
> +                                               &prediv_value, &div_value=
);
> +       if (ret)
> +               return -EINVAL;
> +
> +       spin_lock_irqsave(divider->lock, flags);
> +
> +       val =3D clk_readl(divider->reg);
> +       val &=3D ~((clk_div_mask(divider->width) << divider->shift) |
> +                       (clk_div_mask(PCG_DIV_WIDTH) << PCG_DIV_SHIFT));
> +
> +       val |=3D (u32)(prediv_value  - 1) << divider->shift;
> +       val |=3D (u32)(div_value - 1) << PCG_DIV_SHIFT;
> +       clk_writel(val, divider->reg);

Please don't use clk_writel().

> +
> +       spin_unlock_irqrestore(divider->lock, flags);
> +
> +       return ret;
> +}
> +
> +static const struct clk_ops imx_clk_composite_divider_ops =3D {
> +       .recalc_rate =3D imx_clk_composite_divider_recalc_rate,
> +       .round_rate =3D imx_clk_composite_divider_round_rate,
> +       .set_rate =3D imx_clk_composite_divider_set_rate,
> +};
> +
> +struct clk *imx_clk_composite_flags(const char *name,
> +                                       const char **parent_names,
> +                                       int num_parents, void __iomem *re=
g,
> +                                       unsigned long flags)
> +{
> +       struct clk_hw *mux_hw =3D NULL, *div_hw =3D NULL, *gate_hw =3D NU=
LL;
> +       struct clk_divider *div =3D NULL;
> +       struct clk_gate *gate =3D NULL;
> +       struct clk_mux *mux =3D NULL;
> +       struct clk *clk =3D ERR_PTR(-ENOMEM);
> +
> +       mux =3D kzalloc(sizeof(*mux), GFP_KERNEL);
> +       if (!mux)
> +               goto fail;
> +
> +       mux_hw =3D &mux->hw;
> +       mux->reg =3D reg;
> +       mux->shift =3D PCG_PCS_SHIFT;
> +       mux->mask =3D PCG_PCS_MASK;
> +
> +       div =3D kzalloc(sizeof(*div), GFP_KERNEL);
> +       if (!div)
> +               goto fail;
> +
> +       div_hw =3D &div->hw;
> +       div->reg =3D reg;
> +       div->shift =3D PCG_PREDIV_SHIFT;
> +       div->width =3D PCG_PREDIV_WIDTH;
> +       div->lock =3D &imx_ccm_lock;
> +       div->flags =3D CLK_DIVIDER_ROUND_CLOSEST;
> +
> +       gate =3D kzalloc(sizeof(*gate), GFP_KERNEL);
> +       if (!gate)
> +               goto fail;
> +
> +       gate_hw =3D &gate->hw;
> +       gate->reg =3D reg;
> +       gate->bit_idx =3D PCG_CGC_SHIFT;
> +
> +       clk =3D clk_register_composite(NULL, name, parent_names, num_pare=
nts,
> +                                       mux_hw, &clk_mux_ops, div_hw,
> +                                       &imx_clk_composite_divider_ops, g=
ate_hw,
> +                                       &clk_gate_ops, flags);

Didn't I already review this? I'd prefer we move this to using clk_hw
based APIs and then return the clk pointer if needed.

> +       if (IS_ERR(clk))
> +               goto fail;
> +
> +       return clk;
> +
> +fail:
> +       kfree(gate);
> +       kfree(div);
> +       kfree(mux);
> +       return clk;
> +}
