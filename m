Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C04C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993C4208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993C4208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934514AbeGJQRM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:17:12 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9809 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934265AbeGJQRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:17:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b44dc000000>; Tue, 10 Jul 2018 09:17:04 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 10 Jul 2018 09:17:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 10 Jul 2018 09:17:09 -0700
Received: from [10.21.132.122] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 10 Jul
 2018 16:17:06 +0000
Subject: Re: [PATCH v4 2/4] clk: tegra: refactor 7.1 div calculation
To:     Aapo Vienamo <avienamo@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
CC:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
References: <1531154338-3998-1-git-send-email-avienamo@nvidia.com>
 <1531154338-3998-3-git-send-email-avienamo@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <5805047f-4099-db34-0759-42e4a9e11629@nvidia.com>
Date:   Tue, 10 Jul 2018 17:17:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1531154338-3998-3-git-send-email-avienamo@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/07/18 17:38, Aapo Vienamo wrote:
> From: Peter De Schrijver <pdeschrijver@nvidia.com>
> 
> Move this to a separate file so it can be used to calculate the sdmmc
> clock dividers.

Sorry for not commenting sooner, but what is the motivation for moving
this to its own file? I don't see why we need to do this in order to use
elsewhere. Furthermore, the original file is quite aptly named 'clk-divider.c'
and now we have a div71.c which seems quite specific.
> Signed-off-by: Peter De-Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  drivers/clk/tegra/Makefile      |  1 +
>  drivers/clk/tegra/clk-divider.c | 30 +++++-----------------------
>  drivers/clk/tegra/clk.h         |  3 +++
>  drivers/clk/tegra/div71.c       | 43 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 52 insertions(+), 25 deletions(-)
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
> index e3b9c22..149cc70 100644
> --- a/drivers/clk/tegra/clk.h
> +++ b/drivers/clk/tegra/clk.h
> @@ -812,6 +812,9 @@ extern tegra_clk_apply_init_table_func tegra_clk_apply_init_table;
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
> index 0000000..1eecc84
> --- /dev/null
> +++ b/drivers/clk/tegra/div71.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, NVIDIA CORPORATION.  All rights reserved.
> + */
> +
> +#include <asm/div64.h>
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

I don't see anything in the above that makes this 7.1? It seems that the
fractional width is being passed meaning it could be m.n unless I am missing
something.

Cheers
Jon

-- 
nvpublic
