Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751769AbeEXE1K (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 00:27:10 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35723 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751385AbeEXE1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 00:27:06 -0400
X-Google-Smtp-Source: AB8JxZplGHWJZoNExGvVsevxn0UAvlzXjEptunQA79qR9F/F5ts0BclvWAxf3j54/2Erw8998Dasew==
Date: Thu, 24 May 2018 09:57:03 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] cpufreq: tegra20: Constify rate value of the
 intermediate clk
Message-ID: <20180524042703.cnxaeqsvcskvbt2s@vireshk-i7>
References: <20180523160020.15291-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523160020.15291-1-digetx@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-05-18, 19:00, Dmitry Osipenko wrote:
> PLL_P is known to be always running at 216MHz, hence there is no need to
> query its rate.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpufreq/tegra20-cpufreq.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
> index 05f57dcd5215..3ad6bded6efc 100644
> --- a/drivers/cpufreq/tegra20-cpufreq.c
> +++ b/drivers/cpufreq/tegra20-cpufreq.c
> @@ -24,6 +24,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/types.h>
>  
> +#define PLL_P_FREQ	216000
> +
>  static struct cpufreq_frequency_table freq_table[] = {
>  	{ .frequency = 216000 },
>  	{ .frequency = 312000 },
> @@ -48,18 +50,15 @@ struct tegra20_cpufreq {
>  static unsigned int tegra_get_intermediate(struct cpufreq_policy *policy,
>  					   unsigned int index)
>  {
> -	struct tegra20_cpufreq *cpufreq = cpufreq_get_driver_data();
> -	unsigned int ifreq = clk_get_rate(cpufreq->pll_p_clk) / 1000;
> -
>  	/*
>  	 * Don't switch to intermediate freq if:
>  	 * - we are already at it, i.e. policy->cur == ifreq
>  	 * - index corresponds to ifreq
>  	 */
> -	if (freq_table[index].frequency == ifreq || policy->cur == ifreq)
> +	if (index == 0 || policy->cur == PLL_P_FREQ)
>  		return 0;
>  
> -	return ifreq;
> +	return PLL_P_FREQ;
>  }
>  
>  static int tegra_target_intermediate(struct cpufreq_policy *policy,
> @@ -93,14 +92,13 @@ static int tegra_target(struct cpufreq_policy *policy, unsigned int index)
>  {
>  	struct tegra20_cpufreq *cpufreq = cpufreq_get_driver_data();
>  	unsigned long rate = freq_table[index].frequency;
> -	unsigned int ifreq = clk_get_rate(cpufreq->pll_p_clk) / 1000;
>  	int ret;
>  
>  	/*
>  	 * target freq == pll_p, don't need to take extra reference to pll_x_clk
>  	 * as it isn't used anymore.
>  	 */
> -	if (rate == ifreq)
> +	if (index == 0)
>  		return clk_set_parent(cpufreq->cpu_clk, cpufreq->pll_p_clk);
>  
>  	ret = clk_set_rate(cpufreq->pll_x_clk, rate * 1000);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
