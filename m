Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751740AbeFAL5r (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:57:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:60307 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751092AbeFAL5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:57:45 -0400
Date: Fri, 1 Jun 2018 14:01:03 +0200
From: Giovanni Gherdovich <ggherdovich@suse.cz>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: lenb@kernel.org, rjw@rjwysocki.net, peterz@infradead.org,
        mgorman@techsingularity.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        viresh.kumar@linaro.org
Subject: Re: [RFC/RFT] [PATCH v3 4/4] cpufreq: intel_pstate: enable boost for
 SKX
Message-ID: <20180601120103.olsxfhj6b5d5tahz@linux-h043>
References: <20180531225143.34270-1-srinivas.pandruvada@linux.intel.com>
 <20180531225143.34270-5-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531225143.34270-5-srinivas.pandruvada@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 03:51:43PM -0700, Srinivas Pandruvada wrote:
> Enable HWP boost on Skylake server platform.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 254e30a6c1e0..75c5a95bc0ac 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1794,6 +1794,11 @@ static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[] = {
>  	{}
>  };
>  
> +static const struct x86_cpu_id intel_pstate_hwp_boost_ids[] __initconst = {
> +	ICPU(INTEL_FAM6_SKYLAKE_X, core_funcs),
> +	{}
> +};
> +
>  static int intel_pstate_init_cpu(unsigned int cpunum)
>  {
>  	struct cpudata *cpu;
> @@ -1824,6 +1829,10 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
>  			intel_pstate_disable_ee(cpunum);
>  
>  		intel_pstate_hwp_enable(cpu);
> +
> +		id = x86_match_cpu(intel_pstate_hwp_boost_ids);
> +		if (id)
> +			hwp_boost = true;
>  	}
>  
>  	intel_pstate_get_cpu_pstates(cpu);
> -- 
> 2.13.6
> 
> 

I have a Skylake server, HWP capable, but it doesn't trigger this bit; I had
to do "echo 1 > /sys/devices/system/cpu/intel_pstate/hwp_dynamic_boost".

Just out of curiosity, do you see reasons for leaving some SKL out of the
default setting? Or maybe I'm missing something.

/proc/cpuinfo says that the model name is "Intel(R) Xeon(R) CPU E3-1240 v5";
the outputs of `cpuid -1` and `cpuid -1 --raw` are in this pastebin:
http://paste.opensuse.org/view/raw/34255499


Giovanni Gherdovich
SUSE Labs
