Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6673C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9F924048
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9F924048
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754097AbeGELn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:43:57 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8354 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753848AbeGELny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:43:54 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b3e04750000>; Thu, 05 Jul 2018 04:43:50 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 05 Jul 2018 04:43:53 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 05 Jul 2018 04:43:53 -0700
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 5 Jul
 2018 11:43:51 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1002)
        id CE4C0F808C7; Thu,  5 Jul 2018 14:43:48 +0300 (EEST)
Date:   Thu, 5 Jul 2018 14:43:48 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Aapo Vienamo <avienamo@nvidia.com>
CC:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] clk: tegra: refactor 7.1 div calculation
Message-ID: <20180705114348.GB27696@tbergstrom-lnx.Nvidia.com>
References: <1530699455-27654-1-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1530699455-27654-1-git-send-email-avienamo@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 01:17:33PM +0300, Aapo Vienamo wrote:
> From: Peter De Schrijver <pdeschrijver@nvidia.com>
> 
> Move this to a separate file so it can be used to calculate the sdmmc
> clock dividers.
> 

Series Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>

> Signed-off-by: Peter De-Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  drivers/clk/tegra/Makefile      |  1 +
>  drivers/clk/tegra/clk-divider.c | 30 ++++-------------------
>  drivers/clk/tegra/clk.h         |  3 +++
>  drivers/clk/tegra/div71.c       | 54 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 63 insertions(+), 25 deletions(-)
>  create mode 100644 drivers/clk/tegra/div71.c
> 
> diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
> index b716923..6d4f563 100644
> --- a/drivers/clk/tegra/Makefile
> +++ b/drivers/clk/tegra/Makefile
> @@ -24,3 +24,4 @@ obj-$(CONFIG_ARCH_TEGRA_132_SOC)	+= clk-tegra124.o
>  obj-y					+= cvb.o
>  obj-$(CONFIG_ARCH_TEGRA_210_SOC)	+= clk-tegra210.o
>  obj-$(CONFIG_CLK_TEGRA_BPMP)		+= clk-bpmp.o
> +obj-y					+= div71.o
> diff --git a/drivers/clk/tegra/clk-divider.c b/drivers/clk/tegra/clk-divider.c
> index 16e0aee..ad87858 100644
> --- a/drivers/clk/tegra/clk-divider.c
> +++ b/drivers/clk/tegra/clk-divider.c
> @@ -32,35 +32,15 @@
>  static int get_div(struct tegra_clk_frac_div *divider, unsigned long rate,
>  		   unsigned long parent_rate)
>  {
> -	u64 divider_ux1 = parent_rate;
> -	u8 flags = divider->flags;
> -	int mul;
> -
> -	if (!rate)
> -		return 0;
> -
> -	mul = get_mul(divider);
> -
> -	if (!(flags & TEGRA_DIVIDER_INT))
> -		divider_ux1 *= mul;
> -
> -	if (flags & TEGRA_DIVIDER_ROUND_UP)
> -		divider_ux1 += rate - 1;
> -
> -	do_div(divider_ux1, rate);
> -
> -	if (flags & TEGRA_DIVIDER_INT)
> -		divider_ux1 *= mul;
> +	int div;
>  
> -	divider_ux1 -= mul;
> +	div = div71_get(rate, parent_rate, divider->width, divider->frac_width,
> +			divider->flags);
>  
> -	if ((s64)divider_ux1 < 0)
> +	if (div < 0)
>  		return 0;
>  
> -	if (divider_ux1 > get_max_div(divider))
> -		return get_max_div(divider);
> -
> -	return divider_ux1;
> +	return div;
>  }
>  
>  static unsigned long clk_frac_div_recalc_rate(struct clk_hw *hw,
> diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
> index e1f8846..f14e136 100644
> --- a/drivers/clk/tegra/clk.h
> +++ b/drivers/clk/tegra/clk.h
> @@ -811,6 +811,9 @@ extern tegra_clk_apply_init_table_func tegra_clk_apply_init_table;
>  int tegra_pll_wait_for_lock(struct tegra_clk_pll *pll);
>  u16 tegra_pll_get_fixed_mdiv(struct clk_hw *hw, unsigned long input_rate);
>  int tegra_pll_p_div_to_hw(struct tegra_clk_pll *pll, u8 p_div);
> +int div71_get(unsigned long rate, unsigned parent_rate, u8 width,
> +	      u8 frac_width, u8 flags);
> +
>  
>  /* Combined read fence with delay */
>  #define fence_udelay(delay, reg)	\
> diff --git a/drivers/clk/tegra/div71.c b/drivers/clk/tegra/div71.c
> new file mode 100644
> index 0000000..1a5e04c
> --- /dev/null
> +++ b/drivers/clk/tegra/div71.c
> @@ -0,0 +1,54 @@
> +/*
> + * Copyright (c) 2018, NVIDIA CORPORATION.  All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/kernel.h>
> +
> +#include "clk.h"
> +
> +#define div_mask(w) ((1 << (w)) - 1)
> +
> +int div71_get(unsigned long rate, unsigned parent_rate, u8 width,
> +	      u8 frac_width, u8 flags)
> +{
> +	u64 divider_ux1 = parent_rate;
> +	int mul;
> +
> +	if (!rate)
> +		return 0;
> +
> +	mul = 1 << frac_width;
> +
> +	if (!(flags & TEGRA_DIVIDER_INT))
> +		divider_ux1 *= mul;
> +
> +	if (flags & TEGRA_DIVIDER_ROUND_UP)
> +		divider_ux1 += rate - 1;
> +
> +	do_div(divider_ux1, rate);
> +
> +	if (flags & TEGRA_DIVIDER_INT)
> +		divider_ux1 *= mul;
> +
> +	if (divider_ux1 < mul)
> +		return 0;
> +
> +	divider_ux1 -= mul;
> +
> +	if (divider_ux1 > div_mask(width))
> +		return div_mask(width);
> +
> +	return divider_ux1;
> +}
> -- 
> 2.7.4
> 
