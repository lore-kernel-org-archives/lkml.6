Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23538ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B4220875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B4220875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388039AbeGWMhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:37:36 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57858 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387910AbeGWMhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:37:36 -0400
Received: from 79.184.255.17.ipv4.supernova.orange.pl (79.184.255.17) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id ba10876207c346a5; Mon, 23 Jul 2018 13:36:47 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     lenb@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: intel_pstate: Show different max frequency with turbo 3 and HWP
Date:   Mon, 23 Jul 2018 13:35:02 +0200
Message-ID: <11214467.C5YuPW0axr@aspire.rjw.lan>
In-Reply-To: <20180718215159.28698-1-srinivas.pandruvada@linux.intel.com>
References: <20180718215159.28698-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 18, 2018 11:51:59 PM CEST Srinivas Pandruvada wrote:
> On HWP platforms with Turbo 3.0, the HWP capability max ratio shows the
> maximum ratio of that core, which can be different than other cores. If
> we show the correct maximum frequency in cpufreq sysfs via
> cpuinfo_max_freq and scaling_max_freq then, user can know which cores
> can run faster for pinning some high priority tasks.
> 
> Currently the max turbo frequency is shown as max frequency, which is
> the max of all cores, even if some cores can't reach that frequency
> even for single threaded workload.
> 
> But it is possible that max ratio in HWP capabilities is set as 0xFF or
> some high invalid value (E.g. One KBL NUC). Since the actual performance
> can never exceed 1 core turbo frequency from MSR TURBO_RATIO_LIMIT, we
> use this as a bound check.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index ece120da3353..97096127d015 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2072,6 +2072,15 @@ static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
>  			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
>  	policy->cpuinfo.max_freq *= cpu->pstate.scaling;
>  
> +	if (hwp_active) {
> +		unsigned int max_freq;
> +
> +		max_freq = global.turbo_disabled ?
> +			cpu->pstate.max_freq : cpu->pstate.turbo_freq;
> +		if (max_freq < policy->cpuinfo.max_freq)
> +			policy->cpuinfo.max_freq = max_freq;
> +	}
> +
>  	intel_pstate_init_acpi_perf_limits(policy);
>  
>  	policy->fast_switch_possible = true;
> 

Applied, thanks!


