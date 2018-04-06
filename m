Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbeDFFHG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 01:07:06 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36689 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeDFFHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 01:07:04 -0400
X-Google-Smtp-Source: AIpwx4+fFbEgdMv0cuCNuP4nI2Dl2i0Wxhc1So26M3ZT5GPMEaZtGq0dsdwf5Z05ElITgqwhw/pSUQ==
Date: Fri, 6 Apr 2018 10:37:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shunyong Yang <shunyong.yang@hxt-semitech.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: Re: [PATCH v3] cpufreq: cppc_cpufreq: Initialize shared cpu's perf
 capabilities
Message-ID: <20180406050700.GR3572@vireshk-i7>
References: <1522982629-7557-1-git-send-email-shunyong.yang@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522982629-7557-1-git-send-email-shunyong.yang@hxt-semitech.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-04-18, 10:43, Shunyong Yang wrote:
> When multiple cpus are related in one cpufreq policy, the first online
> cpu will be chosen by default to handle cpufreq operations. Let's take
> cpu0 and cpu1 as an example.
> 
> When cpu0 is offline, policy->cpu will be shifted to cpu1. Cpu1's perf
> capabilities should be initialized. Otherwise, perf capabilities are 0s
> and speed change can not take effect.
> 
> This patch copies perf capabilities of the first online cpu to other
> shared cpus when policy shared type is CPUFREQ_SHARED_TYPE_ANY.
> 
> Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> ---
> 
> Changes in v3:
>   -Remove unnecessary wrap per Kumar's comments.
> 
> Changes in v2:
>   -Add unlikely in cpu comparison per Kumar's comments.
>   -Fix coding style per Kumar's comments.
> 
> Changes in v1:
>   -Drop RFC tag,
>      The original RFC link,
>      https://patchwork.kernel.org/patch/10299055/.
> 
>      This patch solves same issue as RFC above.
> 
>      Patch name is changed as code is too much different with RFC above.
> 
>   -Remove extra init() per Viresh Kumar's comments and only handle
>    CPPC CPUFREQ_SHARED_TYPE_ANY case.
> 
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 8300a9fcb80c..8b432d6e846d 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -167,9 +167,19 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  		NSEC_PER_USEC;
>  	policy->shared_type = cpu->shared_type;
>  
> -	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
> +	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY) {
> +		int i;
> +
>  		cpumask_copy(policy->cpus, cpu->shared_cpu_map);
> -	else if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL) {
> +
> +		for_each_cpu(i, policy->cpus) {
> +			if (unlikely(i == policy->cpu))
> +				continue;
> +
> +			memcpy(&all_cpu_data[i]->perf_caps, &cpu->perf_caps,
> +			       sizeof(cpu->perf_caps));
> +		}
> +	} else if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL) {
>  		/* Support only SW_ANY for now. */
>  		pr_debug("Unsupported CPU co-ord type\n");
>  		return -EFAULT;

LGTM. Thanks.

-- 
viresh
