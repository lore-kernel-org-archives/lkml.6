Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752559AbeCTJEN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 05:04:13 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35843 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbeCTJEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 05:04:08 -0400
X-Google-Smtp-Source: AIpwx4/zJE5HgTX2eMgdGyPAuTdcUZ9ZpeAW+5rabTInlFdr2Cw4K8teUJUcNj+yDL4WRWHaR3I0MA==
Date: Tue, 20 Mar 2018 14:34:00 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: afaerber@suse.de, mark.rutland@arm.com, mturquette@baylibre.com,
        robh+dt@kernel.org, liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        davem@davemloft.net, mchehab@kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, viresh.kumar@linaro.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, manivannanece23@gmail.com
Subject: Re: [PATCH v5 09/12] clk: actions: Add fixed factor clock support
Message-ID: <20180320090400.6bgugy6fgze3ohsd@linaro.org>
References: <20180317100952.28538-1-manivannan.sadhasivam@linaro.org>
 <20180317100952.28538-10-manivannan.sadhasivam@linaro.org>
 <152150820384.254778.6585368643028088392@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152150820384.254778.6585368643028088392@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, Mar 19, 2018 at 06:10:03PM -0700, Stephen Boyd wrote:
> Quoting Manivannan Sadhasivam (2018-03-17 03:09:49)
> > Add support for Actions Semi fixed factor clock together with
> > helper functions to be used in composite clock.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/clk/actions/Makefile           |  1 +
> >  drivers/clk/actions/owl-fixed-factor.c | 81 ++++++++++++++++++++++++++++++++++
> >  drivers/clk/actions/owl-fixed-factor.h | 62 ++++++++++++++++++++++++++
> >  3 files changed, 144 insertions(+)
> >  create mode 100644 drivers/clk/actions/owl-fixed-factor.c
> >  create mode 100644 drivers/clk/actions/owl-fixed-factor.h
> > 
> > diff --git a/drivers/clk/actions/Makefile b/drivers/clk/actions/Makefile
> > index 994357fa560b..b618696ba54e 100644
> > --- a/drivers/clk/actions/Makefile
> > +++ b/drivers/clk/actions/Makefile
> > @@ -5,3 +5,4 @@ clk-owl-y                       += owl-gate.o
> >  clk-owl-y                      += owl-mux.o
> >  clk-owl-y                      += owl-divider.o
> >  clk-owl-y                      += owl-factor.o
> > +clk-owl-y                      += owl-fixed-factor.o
> > diff --git a/drivers/clk/actions/owl-fixed-factor.c b/drivers/clk/actions/owl-fixed-factor.c
> > new file mode 100644
> > index 000000000000..f1281565129c
> > --- /dev/null
> > +++ b/drivers/clk/actions/owl-fixed-factor.c
> > @@ -0,0 +1,81 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +//
> > +// OWL fixed factor clock driver
> > +//
> > +// Copyright (c) 2014 Actions Semi Inc.
> > +// Author: David Liu <liuwei@actions-semi.com>
> > +//
> > +// Copyright (c) 2018 Linaro Ltd.
> > +// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/regmap.h>
> > +#include <linux/slab.h>
> > +
> > +#include "owl-fixed-factor.h"
> > +
> > +long owl_fix_fact_helper_round_rate(struct owl_clk_common *common,
> > +                               const struct owl_fix_fact_hw *fix_fact_hw,
> > +                               unsigned long rate,
> > +                               unsigned long *parent_rate)
> > +{
> > +       if (clk_hw_get_flags(&common->hw) & CLK_SET_RATE_PARENT) {
> > +               unsigned long best_parent;
> > +
> > +               best_parent = (rate / fix_fact_hw->mul) * fix_fact_hw->div;
> > +               *parent_rate = clk_hw_round_rate(clk_hw_get_parent(&common->hw),
> > +                                                       best_parent);
> > +       }
> > +
> > +       return (*parent_rate / fix_fact_hw->div) * fix_fact_hw->mul;
> > +}
> > +
> > +static long owl_fix_fact_round_rate(struct clk_hw *hw, unsigned long rate,
> > +                       unsigned long *parent_rate)
> > +{
> > +       struct owl_fix_fact *fix_fact = hw_to_owl_fix_fact(hw);
> > +       struct owl_fix_fact_hw *fix_fact_hw = &fix_fact->fix_fact_hw;
> > +
> > +       return owl_fix_fact_helper_round_rate(&fix_fact->common, fix_fact_hw,
> > +                                                       rate, parent_rate);
> > +}
> > +
> > +unsigned long owl_fix_fact_helper_recalc_rate(struct owl_clk_common *common,
> > +                       const struct owl_fix_fact_hw *fix_fact_hw,
> > +                       unsigned long parent_rate)
> > +{
> > +       unsigned long long int rate;
> > +
> > +       rate = (unsigned long long int)parent_rate * fix_fact_hw->mul;
> > +       do_div(rate, fix_fact_hw->div);
> > +
> > +       return (unsigned long)rate;
> 
> You can drop the cast.
> 

Okay.

> > +}
> > +
> > +static unsigned long owl_fix_fact_recalc_rate(struct clk_hw *hw,
> > +                       unsigned long parent_rate)
> > +{
> > +       struct owl_fix_fact *fix_fact = hw_to_owl_fix_fact(hw);
> > +       struct owl_fix_fact_hw *fix_fact_hw = &fix_fact->fix_fact_hw;
> > +
> > +       return owl_fix_fact_helper_recalc_rate(&fix_fact->common, fix_fact_hw,
> > +                                                       parent_rate);
> > +}
> > +
> > +static int owl_fix_fact_set_rate(struct clk_hw *hw, unsigned long rate,
> > +                              unsigned long parent_rate)
> > +{
> > +       /*
> > +        * We must report success but we can do so unconditionally because
> > +        * clk_fix_fact_round_rate returns values that ensure this call is a
> 
> What function is that?
>

It should be owl_fix_fact_round_rate.

> > +        * nop.
> > +        */
> > +
> > +       return 0;
> > +}
> > +
> > +const struct clk_ops owl_fix_fact_ops = {
> > +       .round_rate     = owl_fix_fact_round_rate,
> > +       .recalc_rate    = owl_fix_fact_recalc_rate,
> > +       .set_rate       = owl_fix_fact_set_rate,
> > +};
> 
> Why can't you use the regular fixed factor clk code and ops?
>

That's going to be really messy. Since I'm having the clk_hw embedded inside
owl_clk_common and using it for registering all the clocks, using generic
fixed factor functions will be a different approach _only_ for this clock and
it won't look good I guess. Also, it may become complicated with composite
clocks.

If you still want to use the generic fixed factor code, I can do that in
next revision.

Your views?

Thanks,
Mani
