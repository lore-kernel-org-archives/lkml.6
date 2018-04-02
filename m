Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754254AbeDBHIH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 03:08:07 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35720 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754155AbeDBHIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 03:08:06 -0400
X-Google-Smtp-Source: AIpwx494t7uNkic0RkW/rlaIZtsZInC5OZpNY8JyOGc/+NYA7Mf8PIaxSvDXO3rClFzjr/f7kUqjVw==
Date: Mon, 2 Apr 2018 12:38:02 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shunyong Yang <shunyong.yang@hxt-semitech.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: Re: [PATCH] cpufreq: cppc_cpufreq: Initialize shared cpu's perf
 capabilities
Message-ID: <20180402070802.GE4714@vireshk-i7>
References: <1522229514-14377-1-git-send-email-shunyong.yang@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522229514-14377-1-git-send-email-shunyong.yang@hxt-semitech.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-03-18, 17:31, Shunyong Yang wrote:
> When multiple cpus are related in one cpufreq policy, the first online
> cpu will be chosen by default to handle cpufreq operations. Let's take
> cpu0 and cpu1 as an example.
> 
> When cpu0 is offline, policy->cpu will be shifted to cpu1. Cpu1's should
> be initialized. Otherwise, perf capabilities are 0s and speed change can
> not take effect.
> 
> This patch copies perf capabilities of the first online cpu to other
> shared cpus when policy shared type is CPUFREQ_SHARED_TYPE_ANY.
> 
> Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
> Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> ---
> 
> The original RFC link,
>   https://patchwork.kernel.org/patch/10299055/.
> 
> This patch solves same issue as RFC above.
> 
> Patch name is changed as code is too much different with RFC above.
> 
> Remove extra init() per Viresh Kumar's comments and only handle
> CPPC CPUFREQ_SHARED_TYPE_ANY case.
> 
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 8f7b21a4d537..dc625a93a58e 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -164,8 +164,18 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	policy->cpuinfo.transition_latency = cppc_get_transition_latency(cpu_num);
>  	policy->shared_type = cpu->shared_type;
>  
> -	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
> +	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY) {
> +		int i;
> +
>  		cpumask_copy(policy->cpus, cpu->shared_cpu_map);
> +
> +		for_each_cpu(i, policy->cpus) {
> +			if (i != policy->cpu)

I would rather do:

                        if (unlikely(i == policy->cpu))
                                continue;

> +				memcpy(&all_cpu_data[i]->perf_caps,
> +				       &cpu->perf_caps,
> +				       sizeof(cpu->perf_caps));
> +		}
> +	}
>  	else if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL) {

It should be:

  	} else if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL) {

>  		/* Support only SW_ANY for now. */
>  		pr_debug("Unsupported CPU co-ord type\n");

And thanks for making it work this way.

-- 
viresh
