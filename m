Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeBUDf6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 22:35:58 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42709 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeBUDfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 22:35:55 -0500
X-Google-Smtp-Source: AH8x227tDCzcgY/yY1XR4e5gEzK5PmvtR6BlNcLR+wu2YVtO/QRXB0EbXI1rhmoYa5FB4hUbLnPjRw==
Date: Wed, 21 Feb 2018 09:05:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] cpufreq: scpi: invoke frequency-invariance setter
 function
Message-ID: <20180221033551.GN28462@vireshk-i7>
References: <20180220111057.14756-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220111057.14756-1-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-02-18, 11:10, Dietmar Eggemann wrote:
> Commit 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
> changed the cpufreq driver on juno from arm_big_little to scpi.
> 
> The scpi set_target function does not call the frequency-invariance
> setter function arch_set_freq_scale() like the arm_big_little set_target
> function does. As a result the task scheduler load and utilization
> signals are not frequency-invariant on this platform anymore.
> 
> Fix this by adding a call to arch_set_freq_scale() into
> scpi_cpufreq_set_target().
> 
> Fixes: 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/scpi-cpufreq.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
> index c32a833e1b00..3101d4e9c2de 100644
> --- a/drivers/cpufreq/scpi-cpufreq.c
> +++ b/drivers/cpufreq/scpi-cpufreq.c
> @@ -51,13 +51,19 @@ static unsigned int scpi_cpufreq_get_rate(unsigned int cpu)
>  static int
>  scpi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
>  {
> +	unsigned long freq = policy->freq_table[index].frequency;
>  	struct scpi_data *priv = policy->driver_data;
> -	u64 rate = policy->freq_table[index].frequency * 1000;
> +	u64 rate = freq * 1000;
>  	int ret;
>  
>  	ret = clk_set_rate(priv->clk, rate);
> -	if (!ret && (clk_get_rate(priv->clk) != rate))
> -		ret = -EIO;
> +	if (!ret) {
> +		if (clk_get_rate(priv->clk) != rate)
> +			ret = -EIO;
> +
> +		arch_set_freq_scale(policy->related_cpus, freq,
> +				    policy->cpuinfo.max_freq);
> +	}
>  
>  	return ret;
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
