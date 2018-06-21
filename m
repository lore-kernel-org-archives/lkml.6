Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99927C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1A420883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E1A420883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933179AbeFUNXG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:23:06 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59210 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932742AbeFUNXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:23:04 -0400
Received: from 79.184.254.22.ipv4.supernova.orange.pl (79.184.254.22) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 98adbc9861dbb006; Thu, 21 Jun 2018 15:23:02 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     lenb@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Fix scaling max/min limits with Turbo 3.0
Date:   Thu, 21 Jun 2018 15:21:51 +0200
Message-ID: <41349680.t5lbGTspq2@aspire.rjw.lan>
In-Reply-To: <20180618194745.36879-1-srinivas.pandruvada@linux.intel.com>
References: <20180618194745.36879-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, June 18, 2018 9:47:45 PM CEST Srinivas Pandruvada wrote:
> When scaling max/min settings are changed, internally they are converted
> to a ratio using the max turbo 1 core turbo frequency. This works fine
> when 1 core max is same irrespective of the core. But under Turbo 3.0,
> this will not be the case. For example:
> Core 0: max turbo pstate: 43 (4.3GHz)
> Core 1: max turbo pstate: 45 (4.5GHz)
> In this case 1 core turbo ratio will be maximum of all, so it will be
> 45 (4.5GHz). Suppose scaling max is set to 4GHz (ratio 40) for all cores
> ,then on core one it will be
>  = max_state * policy->max / max_freq;
>  = 43 * (4000000/4500000) = 38 (3.8GHz)
>  = 38
> which is 200MHz less than the desired.
> On core2, it will be correctly set to ratio 40 (4GHz). Same holds true
> for scaling min frequency limit. So this requires usage of correct turbo
> max frequency for core one, which in this case is 4.3GHz. So we need to
> adjust per CPU cpu->pstate.turbo_freq using the maximum HWP ratio of that
> core.
> 
> This change uses the HWP capability of a core to adjust max turbo
> frequency. But since Broadwell HWP doesn't use ratios in the HWP
> capabilities, we have use legacy max 1 core turbo ratio. This is not a
> problem as the HWP capabilities don't differ among cores in Broadwell.
> So we need to check for non Broadwell CPU model for applying this change.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: 4.6+ <stable@vger.kernel.org> # 4.6+
> ---
> v2
> Backport friendly without any dependency on recent features.
> 
>  drivers/cpufreq/intel_pstate.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 1de5ec8d5ea3..ece120da3353 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -294,6 +294,7 @@ struct pstate_funcs {
>  static struct pstate_funcs pstate_funcs __read_mostly;
>  
>  static int hwp_active __read_mostly;
> +static int hwp_mode_bdw __read_mostly;
>  static bool per_cpu_limits __read_mostly;
>  static bool hwp_boost __read_mostly;
>  
> @@ -1413,7 +1414,15 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
>  	cpu->pstate.turbo_pstate = pstate_funcs.get_turbo();
>  	cpu->pstate.scaling = pstate_funcs.get_scaling();
>  	cpu->pstate.max_freq = cpu->pstate.max_pstate * cpu->pstate.scaling;
> -	cpu->pstate.turbo_freq = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
> +
> +	if (hwp_active && !hwp_mode_bdw) {
> +		unsigned int phy_max, current_max;
> +
> +		intel_pstate_get_hwp_max(cpu->cpu, &phy_max, &current_max);
> +		cpu->pstate.turbo_freq = phy_max * cpu->pstate.scaling;
> +	} else {
> +		cpu->pstate.turbo_freq = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
> +	}
>  
>  	if (pstate_funcs.get_aperf_mperf_shift)
>  		cpu->aperf_mperf_shift = pstate_funcs.get_aperf_mperf_shift();
> @@ -2467,28 +2476,36 @@ static inline bool intel_pstate_has_acpi_ppc(void) { return false; }
>  static inline void intel_pstate_request_control_from_smm(void) {}
>  #endif /* CONFIG_ACPI */
>  
> +#define INTEL_PSTATE_HWP_BROADWELL	0x01
> +
> +#define ICPU_HWP(model, hwp_mode) \
> +	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_HWP, hwp_mode }
> +
>  static const struct x86_cpu_id hwp_support_ids[] __initconst = {
> -	{ X86_VENDOR_INTEL, 6, X86_MODEL_ANY, X86_FEATURE_HWP },
> +	ICPU_HWP(INTEL_FAM6_BROADWELL_X, INTEL_PSTATE_HWP_BROADWELL),
> +	ICPU_HWP(INTEL_FAM6_BROADWELL_XEON_D, INTEL_PSTATE_HWP_BROADWELL),
> +	ICPU_HWP(X86_MODEL_ANY, 0),
>  	{}
>  };
>  
>  static int __init intel_pstate_init(void)
>  {
> +	const struct x86_cpu_id *id;
>  	int rc;
>  
>  	if (no_load)
>  		return -ENODEV;
>  
> -	if (x86_match_cpu(hwp_support_ids)) {
> +	id = x86_match_cpu(hwp_support_ids);
> +	if (id) {
>  		copy_cpu_funcs(&core_funcs);
>  		if (!no_hwp) {
>  			hwp_active++;
> +			hwp_mode_bdw = id->driver_data;
>  			intel_pstate.attr = hwp_cpufreq_attrs;
>  			goto hwp_cpu_matched;
>  		}
>  	} else {
> -		const struct x86_cpu_id *id;
> -
>  		id = x86_match_cpu(intel_pstate_cpu_ids);
>  		if (!id)
>  			return -ENODEV;
> 

Applied, thanks!


