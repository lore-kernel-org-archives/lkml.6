Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934366AbeCTBKI convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 21:10:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932939AbeCTBKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 21:10:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71EC021736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        afaerber@suse.de, mark.rutland@arm.com, mturquette@baylibre.com,
        robh+dt@kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180317100952.28538-10-manivannan.sadhasivam@linaro.org>
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        davem@davemloft.net, mchehab@kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, viresh.kumar@linaro.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20180317100952.28538-1-manivannan.sadhasivam@linaro.org>
 <20180317100952.28538-10-manivannan.sadhasivam@linaro.org>
Message-ID: <152150820384.254778.6585368643028088392@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 09/12] clk: actions: Add fixed factor clock support
Date: Mon, 19 Mar 2018 18:10:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2018-03-17 03:09:49)
> Add support for Actions Semi fixed factor clock together with
> helper functions to be used in composite clock.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/clk/actions/Makefile           |  1 +
>  drivers/clk/actions/owl-fixed-factor.c | 81 ++++++++++++++++++++++++++++++++++
>  drivers/clk/actions/owl-fixed-factor.h | 62 ++++++++++++++++++++++++++
>  3 files changed, 144 insertions(+)
>  create mode 100644 drivers/clk/actions/owl-fixed-factor.c
>  create mode 100644 drivers/clk/actions/owl-fixed-factor.h
> 
> diff --git a/drivers/clk/actions/Makefile b/drivers/clk/actions/Makefile
> index 994357fa560b..b618696ba54e 100644
> --- a/drivers/clk/actions/Makefile
> +++ b/drivers/clk/actions/Makefile
> @@ -5,3 +5,4 @@ clk-owl-y                       += owl-gate.o
>  clk-owl-y                      += owl-mux.o
>  clk-owl-y                      += owl-divider.o
>  clk-owl-y                      += owl-factor.o
> +clk-owl-y                      += owl-fixed-factor.o
> diff --git a/drivers/clk/actions/owl-fixed-factor.c b/drivers/clk/actions/owl-fixed-factor.c
> new file mode 100644
> index 000000000000..f1281565129c
> --- /dev/null
> +++ b/drivers/clk/actions/owl-fixed-factor.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// OWL fixed factor clock driver
> +//
> +// Copyright (c) 2014 Actions Semi Inc.
> +// Author: David Liu <liuwei@actions-semi.com>
> +//
> +// Copyright (c) 2018 Linaro Ltd.
> +// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +
> +#include <linux/clk-provider.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#include "owl-fixed-factor.h"
> +
> +long owl_fix_fact_helper_round_rate(struct owl_clk_common *common,
> +                               const struct owl_fix_fact_hw *fix_fact_hw,
> +                               unsigned long rate,
> +                               unsigned long *parent_rate)
> +{
> +       if (clk_hw_get_flags(&common->hw) & CLK_SET_RATE_PARENT) {
> +               unsigned long best_parent;
> +
> +               best_parent = (rate / fix_fact_hw->mul) * fix_fact_hw->div;
> +               *parent_rate = clk_hw_round_rate(clk_hw_get_parent(&common->hw),
> +                                                       best_parent);
> +       }
> +
> +       return (*parent_rate / fix_fact_hw->div) * fix_fact_hw->mul;
> +}
> +
> +static long owl_fix_fact_round_rate(struct clk_hw *hw, unsigned long rate,
> +                       unsigned long *parent_rate)
> +{
> +       struct owl_fix_fact *fix_fact = hw_to_owl_fix_fact(hw);
> +       struct owl_fix_fact_hw *fix_fact_hw = &fix_fact->fix_fact_hw;
> +
> +       return owl_fix_fact_helper_round_rate(&fix_fact->common, fix_fact_hw,
> +                                                       rate, parent_rate);
> +}
> +
> +unsigned long owl_fix_fact_helper_recalc_rate(struct owl_clk_common *common,
> +                       const struct owl_fix_fact_hw *fix_fact_hw,
> +                       unsigned long parent_rate)
> +{
> +       unsigned long long int rate;
> +
> +       rate = (unsigned long long int)parent_rate * fix_fact_hw->mul;
> +       do_div(rate, fix_fact_hw->div);
> +
> +       return (unsigned long)rate;

You can drop the cast.

> +}
> +
> +static unsigned long owl_fix_fact_recalc_rate(struct clk_hw *hw,
> +                       unsigned long parent_rate)
> +{
> +       struct owl_fix_fact *fix_fact = hw_to_owl_fix_fact(hw);
> +       struct owl_fix_fact_hw *fix_fact_hw = &fix_fact->fix_fact_hw;
> +
> +       return owl_fix_fact_helper_recalc_rate(&fix_fact->common, fix_fact_hw,
> +                                                       parent_rate);
> +}
> +
> +static int owl_fix_fact_set_rate(struct clk_hw *hw, unsigned long rate,
> +                              unsigned long parent_rate)
> +{
> +       /*
> +        * We must report success but we can do so unconditionally because
> +        * clk_fix_fact_round_rate returns values that ensure this call is a

What function is that?

> +        * nop.
> +        */
> +
> +       return 0;
> +}
> +
> +const struct clk_ops owl_fix_fact_ops = {
> +       .round_rate     = owl_fix_fact_round_rate,
> +       .recalc_rate    = owl_fix_fact_recalc_rate,
> +       .set_rate       = owl_fix_fact_set_rate,
> +};

Why can't you use the regular fixed factor clk code and ops?
