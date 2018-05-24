Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751720AbeEXEar (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 00:30:47 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46568 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbeEXEan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 00:30:43 -0400
X-Google-Smtp-Source: AB8JxZo+nOmSJHwz6ZVUgrf/ogNoBEAuFT51zOT1gEcPELJqNtY721gEatyz9uL50JJK1aq6S/V2OA==
Date: Thu, 24 May 2018 10:00:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] cpufreq: tegra20: Use PLL_C as intermediate clock
 source
Message-ID: <20180524043040.25pld3ezs4lpabro@vireshk-i7>
References: <20180523160020.15291-1-digetx@gmail.com>
 <20180523160020.15291-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523160020.15291-2-digetx@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-05-18, 19:00, Dmitry Osipenko wrote:
> PLL_C is running at 600MHz which is significantly higher than the 216MHz
> of the PLL_P and it is known that PLL_C is always-ON because AHB BUS is
> running on that PLL. Let's use PLL_C as intermediate clock source, making
> CPU snappier a tad during of the frequency transition.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpufreq/tegra20-cpufreq.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
> index 3ad6bded6efc..4bf5ba7da40b 100644
> --- a/drivers/cpufreq/tegra20-cpufreq.c
> +++ b/drivers/cpufreq/tegra20-cpufreq.c
> @@ -25,12 +25,13 @@
>  #include <linux/types.h>
>  
>  #define PLL_P_FREQ	216000
> +#define PLL_C_FREQ	600000
>  
>  static struct cpufreq_frequency_table freq_table[] = {
>  	{ .frequency = 216000 },
>  	{ .frequency = 312000 },
>  	{ .frequency = 456000 },
> -	{ .frequency = 608000 },
> +	{ .frequency = 600000 },
>  	{ .frequency = 760000 },
>  	{ .frequency = 816000 },
>  	{ .frequency = 912000 },
> @@ -44,6 +45,7 @@ struct tegra20_cpufreq {
>  	struct clk *cpu_clk;
>  	struct clk *pll_x_clk;
>  	struct clk *pll_p_clk;
> +	struct clk *pll_c_clk;
>  	bool pll_x_prepared;
>  };
>  
> @@ -58,7 +60,10 @@ static unsigned int tegra_get_intermediate(struct cpufreq_policy *policy,
>  	if (index == 0 || policy->cur == PLL_P_FREQ)
>  		return 0;
>  
> -	return PLL_P_FREQ;
> +	if (index == 3 || policy->cur == PLL_C_FREQ)
> +		return 0;

So we can choose between two different intermediate frequencies ? And
I didn't like the way magic number 3 is used here. Its prone to errors
and we better use a macro or something else here.

Like instead of doing index == 3, what about freq_table[index].freq ==
PLL_C_FREQ ? Same for the previous patch as well.

-- 
viresh
