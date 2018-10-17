Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC29ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA606214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9kyHWvo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA606214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbeJRB7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:59:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbeJRB7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:59:05 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B7A42148E;
        Wed, 17 Oct 2018 18:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539799336;
        bh=skJIHrcxwIinSy0LPrgYNpnhVxCVxFaYd73POcoqs3o=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=r9kyHWvokKimX1BJrGh8qUr9bXgfFjDvG4hjRwYjCbbUHUoOjh2dh0uyEYtyQYeSb
         EHngimXRDKylN/ZhC2kmnuxdSEYxwQr4aPo8YBS1PS/qIOlr/r3uCitkwWKI0IRijF
         8Kedf5YUmVFmgdqDd4FLlV2nY1HmHulRm4klK8yA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Abel Vesa <abel.vesa@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1539157520-25081-5-git-send-email-abel.vesa@nxp.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
References: <1539157520-25081-1-git-send-email-abel.vesa@nxp.com>
 <1539157520-25081-5-git-send-email-abel.vesa@nxp.com>
Message-ID: <153979933548.5275.10155260505209370069@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v11 4/5] clk: imx: add imx composite clock
Date:   Wed, 17 Oct 2018 11:02:15 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2018-10-10 00:45:19)
> diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-com=
posite-8m.c
> new file mode 100644
> index 0000000..e214812
> --- /dev/null
> +++ b/drivers/clk/imx/clk-composite-8m.c
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

Is this include used? Same comment applies to all the building block
patches in this series.

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
> +static unsigned long imx8m_clk_composite_divider_recalc_rate(struct clk_=
hw *hw,
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
> +static int imx8m_clk_composite_compute_dividers(unsigned long rate,
> +                                               unsigned long parent_rate,
> +                                               int *prediv, int *postdiv)
> +{
> +       int div1, div2;
> +       int error =3D INT_MAX;
> +       int ret =3D -EINVAL;
> +
> +       /* default values */

Nitpick alert: Useless comment?

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
> +static long imx8m_clk_composite_divider_round_rate(struct clk_hw *hw,
> +                                               unsigned long rate,
> +                                               unsigned long *prate)
> +{
> +       int prediv_value;
> +       int div_value;
> +
> +       imx8m_clk_composite_compute_dividers(rate, *prate,
> +                                               &prediv_value, &div_value=
);
> +
> +       rate =3D DIV_ROUND_UP(*prate, prediv_value);
> +       rate =3D DIV_ROUND_UP(rate, div_value);
> +
> +       return rate;

So just =


	return DIV_ROUND_UP(rate, div_value);

> +}
> +
> +static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
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
> +       ret =3D imx8m_clk_composite_compute_dividers(rate, parent_rate,
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

Please don't use clk_readl and clk_writel() unless you absolutely must
do so.

> +
> +       spin_unlock_irqrestore(divider->lock, flags);
> +
> +       return ret;
> +}
> +
> +static const struct clk_ops imx8m_clk_composite_divider_ops =3D {
> +       .recalc_rate =3D imx8m_clk_composite_divider_recalc_rate,
> +       .round_rate =3D imx8m_clk_composite_divider_round_rate,
> +       .set_rate =3D imx8m_clk_composite_divider_set_rate,
> +};
> +
> +struct clk *imx8m_clk_composite_flags(const char *name,
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
> +                                       &imx8m_clk_composite_divider_ops,
> +                                       gate_hw, &clk_gate_ops, flags);

Can new imx driver code start using the clk_hw based registration
functions? If it's too hard to fix all call-sites, it's fine to pull the
struct clk pointer out of the hw structure and return that for now, but
eventually I'd like to get rid of clk based registration APIs. It's an
ongoing saga.

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
