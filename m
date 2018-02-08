Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeBHKNu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 05:13:50 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:60946 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbeBHKNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 05:13:49 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Yu Chen <yu.c.chen@intel.com>
Cc: Len Brown <lenb@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cpufreq: intel_pstate: enable HWP after resumed
Date: Thu, 08 Feb 2018 11:12:05 +0100
Message-ID: <5530967.sVKap31zK9@aspire.rjw.lan>
In-Reply-To: <7ddf56d88ed43701cd498fd42d1ae75e4eea1340.1517192577.git.yu.c.chen@intel.com>
References: <d71a6cf7352de5595ac1419000bd72b6d068cce1.1517192577.git.yu.c.chen@intel.com> <7ddf56d88ed43701cd498fd42d1ae75e4eea1340.1517192577.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, January 29, 2018 3:27:57 AM CET Yu Chen wrote:
> When maxcpus=1 is appended the BP is responsible
> for re-enabling the HWP - because currently only
> the APs invoke intel_pstate_hwp_enable() during
> their online process - which might put the system
> into unstable state after resume.
> 
> Fix this by enabling the HWP explicitly on BP during
> resume.
> 
> Reported-by: Doug Smythies <dsmythies@telus.net>
> Suggested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Signed-off-by: Yu Chen <yu.c.chen@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 93a0e88bef76..89f637e8439c 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -779,6 +779,8 @@ static int intel_pstate_hwp_save_state(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> +static void intel_pstate_hwp_enable(struct cpudata *cpudata);
> +
>  static int intel_pstate_resume(struct cpufreq_policy *policy)
>  {
>  	if (!hwp_active)
> @@ -786,6 +788,8 @@ static int intel_pstate_resume(struct cpufreq_policy *policy)
>  
>  	mutex_lock(&intel_pstate_limits_lock);
>  
> +	if (!policy->cpu)
> +		intel_pstate_hwp_enable(all_cpu_data[policy->cpu]);
>  	all_cpu_data[policy->cpu]->epp_policy = 0;
>  	intel_pstate_hwp_set(policy->cpu);
>  
> 

I've applied this one (with minor modifications) as a temporary measure, but
it is based on the CPU0=BP assumption which may not be the case.
