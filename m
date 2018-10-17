Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6CAECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0E121477
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zixtee1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B0E121477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeJRDxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:53:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbeJRDxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:53:09 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ED202087A;
        Wed, 17 Oct 2018 19:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539806153;
        bh=sSFO3yRF1qzL71OKneUdoVEKpbzJEfLPDG3LjVCPGWU=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=zixtee1AKNg/P5vM03ZwTNw6RqC1TxZjjNwxGTCMm9OlkHJNqQAjogtxBmnTqorz5
         J2zFC4x/YExcb0LdDN45Ez0cvH3ywTT9DDx/oHb9uHFiEJ3M4P/h2qqFWYrMQggFkP
         oMprCHx28dy3sr7cQw8JaauSmlFjwraOsEXYReLw=
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
In-Reply-To: <1537785597-26499-4-git-send-email-abel.vesa@nxp.com>
Cc:     linux-imx@nxp.com, Abel Vesa <abelvesa@linux.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
References: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
 <1537785597-26499-4-git-send-email-abel.vesa@nxp.com>
Message-ID: <153980615257.5275.13866740376184829057@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v9 3/5] clk: imx: add SCCG PLL type
Date:   Wed, 17 Oct 2018 12:55:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2018-09-24 03:39:55)
> diff --git a/drivers/clk/imx/clk-sccg-pll.c b/drivers/clk/imx/clk-sccg-pl=
l.c
> new file mode 100644
> index 0000000..a9837fa
> --- /dev/null
> +++ b/drivers/clk/imx/clk-sccg-pll.c
> @@ -0,0 +1,237 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2018 NXP.
> + */
> +
> +#include <linux/clk.h>

Is this include used? Otherwise should see clk-provider.h included here.

> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/bitfield.h>
> +
> +#include "clk.h"
> +
> +/* PLL CFGs */
> +#define PLL_CFG0               0x0
> +#define PLL_CFG1               0x4
> +#define PLL_CFG2               0x8
> +
> +#define PLL_DIVF1_MASK         GENMASK(18, 13)
> +#define PLL_DIVF2_MASK         GENMASK(12, 7)
> +#define PLL_DIVR1_MASK         GENMASK(27, 25)
> +#define PLL_DIVR2_MASK         GENMASK(24, 19)
> +#define PLL_REF_MASK           GENMASK(2, 0)
> +
> +#define PLL_LOCK_MASK          BIT(31)
> +#define PLL_PD_MASK            BIT(7)
> +
> +#define OSC_25M                        25000000
> +#define OSC_27M                        27000000
> +
> +#define PLL_SCCG_LOCK_TIMEOUT  70
> +
> +struct clk_sccg_pll {
> +       struct clk_hw   hw;
> +       void __iomem    *base;
> +};
> +
> +#define to_clk_sccg_pll(_hw) container_of(_hw, struct clk_sccg_pll, hw)
> +
> +static int clk_pll_wait_lock(struct clk_sccg_pll *pll)
> +{
> +       u32 val;
> +
> +       return readl_poll_timeout(pll->base, val, val & PLL_LOCK_MASK, 0,
> +                                       PLL_SCCG_LOCK_TIMEOUT);
> +}
> +
> +static int clk_pll1_is_prepared(struct clk_hw *hw)
> +{
> +       struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
> +       u32 val;
> +
> +       val =3D readl_relaxed(pll->base + PLL_CFG0);
> +       return (val & PLL_PD_MASK) ? 0 : 1;
> +}
> +
> +static unsigned long clk_pll1_recalc_rate(struct clk_hw *hw,
> +                                        unsigned long parent_rate)
> +{
> +       struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
> +       u32 val, divf;
> +
> +       val =3D readl_relaxed(pll->base + PLL_CFG2);
> +       divf =3D FIELD_GET(PLL_DIVF1_MASK, val);
> +
> +       return parent_rate * 2 * (divf + 1);
> +}
> +
> +static long clk_pll1_round_rate(struct clk_hw *hw, unsigned long rate,
> +                              unsigned long *prate)
> +{
> +       unsigned long parent_rate =3D *prate;
> +       u32 div;
> +
> +       div =3D rate / (parent_rate * 2);

Can parent_rate be 0?

> +
> +       return parent_rate * div * 2;
> +}
> +
> +static int clk_pll1_set_rate(struct clk_hw *hw, unsigned long rate,
> +                           unsigned long parent_rate)
> +{
> +       struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
> +       u32 val;
> +       u32 divf;
> +
> +       divf =3D rate / (parent_rate * 2);

Can parent_rate be 0?

> +
> +       val =3D readl_relaxed(pll->base + PLL_CFG2);
> +       val &=3D ~PLL_DIVF1_MASK;
> +       val |=3D FIELD_PREP(PLL_DIVF1_MASK, divf - 1);
> +       writel_relaxed(val, pll->base + PLL_CFG2);
> +
> +       return clk_pll_wait_lock(pll);
> +}
> +
> +static int clk_pll1_prepare(struct clk_hw *hw)
> +{
> +       struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
> +       u32 val;
> +
> +       val =3D readl_relaxed(pll->base + PLL_CFG0);
> +       val &=3D ~PLL_PD_MASK;
> +       writel_relaxed(val, pll->base + PLL_CFG0);
> +
> +       return clk_pll_wait_lock(pll);
> +}
> +
> +static void clk_pll1_unprepare(struct clk_hw *hw)
> +{
> +       struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
> +       u32 val;
> +
> +       val =3D readl_relaxed(pll->base + PLL_CFG0);
> +       val |=3D PLL_PD_MASK;
> +       writel_relaxed(val, pll->base + PLL_CFG0);
> +
> +}
> +
> +static unsigned long clk_pll2_recalc_rate(struct clk_hw *hw,
> +                                        unsigned long parent_rate)
> +{
> +       struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
> +       u32 val, ref, divr1, divf1, divr2, divf2;
> +       u64 temp64;
> +
> +       val =3D readl_relaxed(pll->base + PLL_CFG0);
> +       switch (FIELD_GET(PLL_REF_MASK, val)) {
> +       case 0:
> +               ref =3D OSC_25M;
> +               break;
> +       case 1:
> +               ref =3D OSC_27M;
> +               break;
> +       default:
> +               ref =3D OSC_25M;

Does this information not come through 'parent_rate'?

> +               break;
> +       }
> +
> +       val =3D readl_relaxed(pll->base + PLL_CFG2);
> +       divr1 =3D FIELD_GET(PLL_DIVR1_MASK, val);
> +       divr2 =3D FIELD_GET(PLL_DIVR2_MASK, val);
> +       divf1 =3D FIELD_GET(PLL_DIVF1_MASK, val);
> +       divf2 =3D FIELD_GET(PLL_DIVF2_MASK, val);
> +
> +       temp64 =3D ref * 2;
> +       temp64 *=3D (divf1 + 1) * (divf2 + 1);
> +
> +       do_div(temp64, (divr1 + 1) * (divr2 + 1));

Nitpicks: A comment with the equation may be helpful to newcomers.

> +
> +       return (unsigned long)temp64;

Drop useless cast please.

> +}
> +
> +static long clk_pll2_round_rate(struct clk_hw *hw, unsigned long rate,
> +                              unsigned long *prate)
> +{
> +       u32 div;
> +       unsigned long parent_rate =3D *prate;
> +
> +       div =3D rate / (parent_rate);
> +
> +       return parent_rate * div;
> +}
> +
> +static int clk_pll2_set_rate(struct clk_hw *hw, unsigned long rate,
> +                           unsigned long parent_rate)
> +{
> +       u32 val;
> +       u32 divf;
> +       struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
> +
> +       divf =3D rate / (parent_rate);

Drop useless parenthesis please.

> +
> +       val =3D readl_relaxed(pll->base + PLL_CFG2);
> +       val &=3D ~PLL_DIVF2_MASK;
> +       val |=3D FIELD_PREP(PLL_DIVF2_MASK, divf - 1);
> +       writel_relaxed(val, pll->base + PLL_CFG2);
> +
> +       return clk_pll_wait_lock(pll);
> +}
> +
> +static const struct clk_ops clk_sccg_pll1_ops =3D {
> +       .is_prepared    =3D clk_pll1_is_prepared,
> +       .recalc_rate    =3D clk_pll1_recalc_rate,
> +       .round_rate     =3D clk_pll1_round_rate,
> +       .set_rate       =3D clk_pll1_set_rate,
> +};
> +
> +static const struct clk_ops clk_sccg_pll2_ops =3D {
> +       .prepare        =3D clk_pll1_prepare,
> +       .unprepare      =3D clk_pll1_unprepare,
> +       .recalc_rate    =3D clk_pll2_recalc_rate,
> +       .round_rate     =3D clk_pll2_round_rate,
> +       .set_rate       =3D clk_pll2_set_rate,
> +};
> +
> +struct clk *imx_clk_sccg_pll(const char *name,
> +                               const char *parent_name,
> +                               void __iomem *base,
> +                               enum imx_sccg_pll_type pll_type)
> +{
> +       struct clk_sccg_pll *pll;
> +       struct clk *clk;
> +       struct clk_init_data init;
> +
> +       pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);
> +       if (!pll)
> +               return ERR_PTR(-ENOMEM);
> +
> +       pll->base =3D base;
> +       init.name =3D name;
> +       switch (pll_type) {
> +       case SCCG_PLL1:
> +               init.ops =3D &clk_sccg_pll1_ops;
> +               break;
> +       case SCCG_PLL2:
> +               init.ops =3D &clk_sccg_pll2_ops;
> +               break;
> +       default:
> +               kfree(pll);
> +               return ERR_PTR(-EINVAL);

Do this case statement before allocating? So that kfree() isn't required
here?

> +       }
> +
> +       init.flags =3D 0;
> +       init.parent_names =3D &parent_name;
> +       init.num_parents =3D 1;
> +
> +       pll->hw.init =3D &init;
> +
> +       clk =3D clk_register(NULL, &pll->hw);

Any chance to use clk_hw based registration APIs?

> +       if (IS_ERR(clk))
> +               kfree(pll);
> +
> +       return clk;
