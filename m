Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751273AbeEPPTc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:19:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37341 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeEPPTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:19:30 -0400
X-Google-Smtp-Source: AB8JxZp3cI/FbuM+mEq7cHsre2T1+zpI2snMKt0a2iNCbqYjgHWBWRo4zZP3+CAMiU4860FaSIpNRQ==
Date: Wed, 16 May 2018 17:19:25 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org, bp@suse.de,
        lenb@kernel.org, rjw@rjwysocki.net, mgorman@techsingularity.net,
        x86@kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT] [PATCH 02/10] cpufreq: intel_pstate: Conditional
 frequency invariant accounting
Message-ID: <20180516151925.GO28366@localhost.localdomain>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
 <20180516044911.28797-3-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516044911.28797-3-srinivas.pandruvada@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/18 21:49, Srinivas Pandruvada wrote:
> intel_pstate has two operating modes: active and passive. In "active"
> mode, the in-built scaling governor is used and in "passive" mode,
> the driver can be used with any governor like "schedutil". In "active"
> mode the utilization values from schedutil is not used and there is
> a requirement from high performance computing use cases, not to read
> any APERF/MPERF MSRs. In this case no need to use CPU cycles for
> frequency invariant accounting by reading APERF/MPERF MSRs.
> With this change frequency invariant account is only enabled in
> "passive" mode.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> [Note: The tick will be enabled later in the series when hwp dynamic
> boost is enabled]
> 
>  drivers/cpufreq/intel_pstate.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 17e566af..f686bbe 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2040,6 +2040,8 @@ static int intel_pstate_register_driver(struct cpufreq_driver *driver)
>  {
>  	int ret;
>  
> +	x86_arch_scale_freq_tick_disable();
> +
>  	memset(&global, 0, sizeof(global));
>  	global.max_perf_pct = 100;
>  
> @@ -2052,6 +2054,9 @@ static int intel_pstate_register_driver(struct cpufreq_driver *driver)
>  
>  	global.min_perf_pct = min_perf_pct_min();
>  
> +	if (driver == &intel_cpufreq)
> +		x86_arch_scale_freq_tick_enable();

This will unconditionally trigger the reading/calculation at each tick
even though information is not actually consumed (e.g., running
performance or any other governor), right? Do we want that?

Anyway, FWIW I started testing this on a E5-2609 v3 and I'm not seeing
hackbench regressions so far (running with schedutil governor).

Best,

- Juri
