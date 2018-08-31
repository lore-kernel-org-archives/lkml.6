Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE5EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1262020837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1262020837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeHaNg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:36:29 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12071 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbeHaNg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:36:29 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5b890a8f0000>; Fri, 31 Aug 2018 02:29:51 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 31 Aug 2018 02:29:53 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 31 Aug 2018 02:29:53 -0700
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 31 Aug
 2018 09:29:52 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1002)
        id 1E50DF80902; Fri, 31 Aug 2018 12:29:48 +0300 (EEST)
Date:   Fri, 31 Aug 2018 12:29:48 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] clk: tegra20: Enable lock-status polling for PLLs
Message-ID: <20180831092948.GP1636@tbergstrom-lnx.Nvidia.com>
References: <20180830184210.5369-1-digetx@gmail.com>
 <20180830184210.5369-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180830184210.5369-2-digetx@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:42:10PM +0300, Dmitry Osipenko wrote:
> Currently all PLL's on Tegra20 use a hardcoded delay despite of having
> a lock-status bit. The lock-status polling was disabled ~7 years ago
> because PLLE was failing to lock and was a suspicion that other PLLs
> might be faulty too. Other PLLs are okay, hence enable the lock-status
> polling for them. This reduces delay of any operation that require PLL
> to lock.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> 
> Changelog:
> 
> v2:	Don't enable polling for PLLE as it known to not being able to lock.
> 

This isn't correct. The lock bit of PLLE can declare lock too early, but the
PLL itself does lock.

>  drivers/clk/tegra/clk-tegra20.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
> index cc857d4d4a86..cfde3745a0db 100644
> --- a/drivers/clk/tegra/clk-tegra20.c
> +++ b/drivers/clk/tegra/clk-tegra20.c
> @@ -298,7 +298,8 @@ static struct tegra_clk_pll_params pll_c_params = {
>  	.lock_enable_bit_idx = PLL_MISC_LOCK_ENABLE,
>  	.lock_delay = 300,
>  	.freq_table = pll_c_freq_table,
> -	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE,
> +	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE |
> +		 TEGRA_PLL_USE_LOCK,
>  };
>  
>  static struct tegra_clk_pll_params pll_m_params = {
> @@ -314,7 +315,8 @@ static struct tegra_clk_pll_params pll_m_params = {
>  	.lock_enable_bit_idx = PLL_MISC_LOCK_ENABLE,
>  	.lock_delay = 300,
>  	.freq_table = pll_m_freq_table,
> -	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE,
> +	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE |
> +		 TEGRA_PLL_USE_LOCK,
>  };
>  
>  static struct tegra_clk_pll_params pll_p_params = {
> @@ -331,7 +333,7 @@ static struct tegra_clk_pll_params pll_p_params = {
>  	.lock_delay = 300,
>  	.freq_table = pll_p_freq_table,
>  	.flags = TEGRA_PLL_FIXED | TEGRA_PLL_HAS_CPCON |
> -		 TEGRA_PLL_HAS_LOCK_ENABLE,
> +		 TEGRA_PLL_HAS_LOCK_ENABLE | TEGRA_PLL_USE_LOCK,
>  	.fixed_rate =  216000000,
>  };
>  
> @@ -348,7 +350,8 @@ static struct tegra_clk_pll_params pll_a_params = {
>  	.lock_enable_bit_idx = PLL_MISC_LOCK_ENABLE,
>  	.lock_delay = 300,
>  	.freq_table = pll_a_freq_table,
> -	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE,
> +	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE |
> +		 TEGRA_PLL_USE_LOCK,
>  };
>  
>  static struct tegra_clk_pll_params pll_d_params = {
> @@ -364,7 +367,8 @@ static struct tegra_clk_pll_params pll_d_params = {
>  	.lock_enable_bit_idx = PLLDU_MISC_LOCK_ENABLE,
>  	.lock_delay = 1000,
>  	.freq_table = pll_d_freq_table,
> -	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE,
> +	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE |
> +		 TEGRA_PLL_USE_LOCK,
>  };
>  
>  static const struct pdiv_map pllu_p[] = {
> @@ -387,7 +391,8 @@ static struct tegra_clk_pll_params pll_u_params = {
>  	.lock_delay = 1000,
>  	.pdiv_tohw = pllu_p,
>  	.freq_table = pll_u_freq_table,
> -	.flags = TEGRA_PLLU | TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE,
> +	.flags = TEGRA_PLLU | TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE |
> +		 TEGRA_PLL_USE_LOCK,
>  };
>  
>  static struct tegra_clk_pll_params pll_x_params = {
> @@ -403,7 +408,8 @@ static struct tegra_clk_pll_params pll_x_params = {
>  	.lock_enable_bit_idx = PLL_MISC_LOCK_ENABLE,
>  	.lock_delay = 300,
>  	.freq_table = pll_x_freq_table,
> -	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE,
> +	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE |
> +		 TEGRA_PLL_USE_LOCK,
>  };
>  
>  static struct tegra_clk_pll_params pll_e_params = {
> -- 
> 2.18.0
> 
