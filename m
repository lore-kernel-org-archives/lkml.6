Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F875C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F162086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F162086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbeLKKqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:46:50 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:58447 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbeLKKqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:46:49 -0500
Received: from 79.184.252.35.ipv4.supernova.orange.pl (79.184.252.35) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id b0a1c4ebf1536e1a; Tue, 11 Dec 2018 11:46:47 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     lenb@kernel.org, viresh.kumar@linaro.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, yu.c.chen@intel.com
Subject: Re: [PATCH 1/2] cpufreq: intel_pstate: Force HWP min perf before offline
Date:   Tue, 11 Dec 2018 11:46:29 +0100
Message-ID: <1570245.TxyEhuTLgx@aspire.rjw.lan>
In-Reply-To: <20181116222420.24260-1-srinivas.pandruvada@linux.intel.com>
References: <20181116222420.24260-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, November 16, 2018 11:24:19 PM CET Srinivas Pandruvada wrote:
> Force HWP Request MAX = HWP Request MIN = HWP Capability MIN and EPP to
> 0xFF. In this way the performance limits on the offlined CPU will not
> influence performance limits on its sibling CPU, which is still online.
> 
> If the sibling CPU is calling for higher performance, it will impact the
> max core performance. Here core performance will follow higher of the
> performance requests from each sibling.
> 
> Reported-and-tested-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 14f551a3d36e..501ab9f4489a 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -830,6 +830,28 @@ static void intel_pstate_hwp_set(unsigned int cpu)
>  	wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
>  }
>  
> +static void intel_pstate_hwp_force_min_perf(int cpu)
> +{
> +	u64 value;
> +	int min_perf;
> +
> +	value = all_cpu_data[cpu]->hwp_req_cached;
> +	value &= ~GENMASK_ULL(31, 0);
> +	min_perf = HWP_LOWEST_PERF(all_cpu_data[cpu]->hwp_cap_cached);
> +
> +	/* Set hwp_max = hwp_min */
> +	value |= HWP_MAX_PERF(min_perf);
> +	value |= HWP_MIN_PERF(min_perf);
> +
> +	/* Set EPP/EPB to min */
> +	if (static_cpu_has(X86_FEATURE_HWP_EPP))
> +		value |= HWP_ENERGY_PERF_PREFERENCE(HWP_EPP_POWERSAVE);
> +	else
> +		intel_pstate_set_epb(cpu, HWP_EPP_BALANCE_POWERSAVE);
> +
> +	wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
> +}
> +
>  static int intel_pstate_hwp_save_state(struct cpufreq_policy *policy)
>  {
>  	struct cpudata *cpu_data = all_cpu_data[policy->cpu];
> @@ -2093,10 +2115,12 @@ static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
>  	pr_debug("CPU %d exiting\n", policy->cpu);
>  
>  	intel_pstate_clear_update_util_hook(policy->cpu);
> -	if (hwp_active)
> +	if (hwp_active) {
>  		intel_pstate_hwp_save_state(policy);
> -	else
> +		intel_pstate_hwp_force_min_perf(policy->cpu);
> +	} else {
>  		intel_cpufreq_stop_cpu(policy);
> +	}
>  }
>  
>  static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
> 

Both this one and the [2/2] applied, thanks!

