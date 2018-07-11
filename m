Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC991C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE4020875
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE4020875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbeGKID2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:03:28 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16896 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeGKID2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:03:28 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b45b9150000>; Wed, 11 Jul 2018 01:00:21 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 11 Jul 2018 01:00:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 11 Jul 2018 01:00:23 -0700
Received: from tbergstrom-lnx.Nvidia.com (172.20.13.39) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1347.2; Wed, 11 Jul 2018 08:00:25 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1002)
        id 8A9A8F8009D; Wed, 11 Jul 2018 11:00:22 +0300 (EEST)
Date:   Wed, 11 Jul 2018 11:00:22 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Jon Hunter <jonathanh@nvidia.com>
CC:     Aapo Vienamo <avienamo@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v4 2/4] clk: tegra: refactor 7.1 div calculation
Message-ID: <20180711080022.GB1636@tbergstrom-lnx.Nvidia.com>
References: <1531154338-3998-1-git-send-email-avienamo@nvidia.com>
 <1531154338-3998-3-git-send-email-avienamo@nvidia.com>
 <5805047f-4099-db34-0759-42e4a9e11629@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5805047f-4099-db34-0759-42e4a9e11629@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 05:17:05PM +0100, Jon Hunter wrote:
> 
> On 09/07/18 17:38, Aapo Vienamo wrote:
> > From: Peter De Schrijver <pdeschrijver@nvidia.com>
> > 
> > Move this to a separate file so it can be used to calculate the sdmmc
> > clock dividers.
> 
> Sorry for not commenting sooner, but what is the motivation for moving
> this to its own file? I don't see why we need to do this in order to use
> elsewhere. Furthermore, the original file is quite aptly named 'clk-divider.c'
> and now we have a div71.c which seems quite specific.

How else would you do it?

Peter.

> > Signed-off-by: Peter De-Schrijver <pdeschrijver@nvidia.com>
> > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > ---
> >  drivers/clk/tegra/Makefile      |  1 +
> >  drivers/clk/tegra/clk-divider.c | 30 +++++-----------------------
> >  drivers/clk/tegra/clk.h         |  3 +++
> >  drivers/clk/tegra/div71.c       | 43 +++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 52 insertions(+), 25 deletions(-)
> >  create mode 100644 drivers/clk/tegra/div71.c
> > 
> > diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
> > index b716923..6d4f563 100644
> > --- a/drivers/clk/tegra/Makefile
> > +++ b/drivers/clk/tegra/Makefile
> > @@ -24,3 +24,4 @@ obj-$(CONFIG_ARCH_TEGRA_132_SOC)	+= clk-tegra124.o
> >  obj-y					+= cvb.o
> >  obj-$(CONFIG_ARCH_TEGRA_210_SOC)	+= clk-tegra210.o
> >  obj-$(CONFIG_CLK_TEGRA_BPMP)		+= clk-bpmp.o
> > +obj-y					+= div71.o
> > diff --git a/drivers/clk/tegra/clk-divider.c b/drivers/clk/tegra/clk-divider.c
> > index 16e0aee..ad87858 100644
> > --- a/drivers/clk/tegra/clk-divider.c
> > +++ b/drivers/clk/tegra/clk-divider.c
> > @@ -32,35 +32,15 @@
> >  static int get_div(struct tegra_clk_frac_div *divider, unsigned long rate,
> >  		   unsigned long parent_rate)
> >  {
> > -	u64 divider_ux1 = parent_rate;
> > -	u8 flags = divider->flags;
> > -	int mul;
> > -
> > -	if (!rate)
> > -		return 0;
> > -
> > -	mul = get_mul(divider);
> > -
> > -	if (!(flags & TEGRA_DIVIDER_INT))
> > -		divider_ux1 *= mul;
> > -
> > -	if (flags & TEGRA_DIVIDER_ROUND_UP)
> > -		divider_ux1 += rate - 1;
> > -
> > -	do_div(divider_ux1, rate);
> > -
> > -	if (flags & TEGRA_DIVIDER_INT)
> > -		divider_ux1 *= mul;
> > +	int div;
> >  
> > -	divider_ux1 -= mul;
> > +	div = div71_get(rate, parent_rate, divider->width, divider->frac_width,
> > +			divider->flags);
> >  
> > -	if ((s64)divider_ux1 < 0)
> > +	if (div < 0)
> >  		return 0;
> >  
> > -	if (divider_ux1 > get_max_div(divider))
> > -		return get_max_div(divider);
> > -
> > -	return divider_ux1;
> > +	return div;
> >  }
> >  
> >  static unsigned long clk_frac_div_recalc_rate(struct clk_hw *hw,
> > diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
> > index e3b9c22..149cc70 100644
> > --- a/drivers/clk/tegra/clk.h
> > +++ b/drivers/clk/tegra/clk.h
> > @@ -812,6 +812,9 @@ extern tegra_clk_apply_init_table_func tegra_clk_apply_init_table;
> >  int tegra_pll_wait_for_lock(struct tegra_clk_pll *pll);
> >  u16 tegra_pll_get_fixed_mdiv(struct clk_hw *hw, unsigned long input_rate);
> >  int tegra_pll_p_div_to_hw(struct tegra_clk_pll *pll, u8 p_div);
> > +int div71_get(unsigned long rate, unsigned parent_rate, u8 width,
> > +	      u8 frac_width, u8 flags);
> > +
> >  
> >  /* Combined read fence with delay */
> >  #define fence_udelay(delay, reg)	\
> > diff --git a/drivers/clk/tegra/div71.c b/drivers/clk/tegra/div71.c
> > new file mode 100644
> > index 0000000..1eecc84
> > --- /dev/null
> > +++ b/drivers/clk/tegra/div71.c
> > @@ -0,0 +1,43 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2018, NVIDIA CORPORATION.  All rights reserved.
> > + */
> > +
> > +#include <asm/div64.h>
> > +
> > +#include "clk.h"
> > +
> > +#define div_mask(w) ((1 << (w)) - 1)
> > +
> > +int div71_get(unsigned long rate, unsigned parent_rate, u8 width,
> > +	      u8 frac_width, u8 flags)
> > +{
> > +	u64 divider_ux1 = parent_rate;
> > +	int mul;
> > +
> > +	if (!rate)
> > +		return 0;
> > +
> > +	mul = 1 << frac_width;
> > +
> > +	if (!(flags & TEGRA_DIVIDER_INT))
> > +		divider_ux1 *= mul;
> > +
> > +	if (flags & TEGRA_DIVIDER_ROUND_UP)
> > +		divider_ux1 += rate - 1;
> > +
> > +	do_div(divider_ux1, rate);
> > +
> > +	if (flags & TEGRA_DIVIDER_INT)
> > +		divider_ux1 *= mul;
> > +
> > +	if (divider_ux1 < mul)
> > +		return 0;
> > +
> > +	divider_ux1 -= mul;
> > +
> > +	if (divider_ux1 > div_mask(width))
> > +		return div_mask(width);
> > +
> > +	return divider_ux1;
> > +}
> 
> I don't see anything in the above that makes this 7.1? It seems that the
> fractional width is being passed meaning it could be m.n unless I am missing
> something.
> 
> Cheers
> Jon
> 
> -- 
> nvpublic
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
