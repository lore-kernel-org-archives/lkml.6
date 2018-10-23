Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4358BC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9607207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9607207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbeJXGR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 02:17:28 -0400
Received: from mga05.intel.com ([192.55.52.43]:5471 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728282AbeJXGR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 02:17:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 14:52:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,417,1534834800"; 
   d="scan'208";a="273871478"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga005.fm.intel.com with ESMTP; 23 Oct 2018 14:52:12 -0700
Message-ID: <af0dac7535332ecedeab9f04654fbb1d5a21e1a2.camel@linux.intel.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Fix compilation for
 !CONFIG_ACPI
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-pm@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org
Date:   Tue, 23 Oct 2018 14:52:12 -0700
In-Reply-To: <20181023195403.GA3094@light.dominikbrodowski.net>
References: <20181023185429.GA6756@light.dominikbrodowski.net>
         <e8e018e267434cabc2b8db434a3576c082ab3fff.camel@linux.intel.com>
         <20181023193405.pxfl4vyazt7rtc3x@isilmar-4.linta.de>
         <b95b247b5dd85b0839a9fa6167fd1682578fb92b.camel@linux.intel.com>
         <20181023195403.GA3094@light.dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-23 at 21:54 +0200, Dominik Brodowski wrote:
> While at it, add a few comments which config options #ifdef
> and #else statements refer to.
> 
> Fixes: 86d333a8cc7f ("cpufreq: intel_pstate: Add base_frequency
> attribute")
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> 
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index 49c0abf2d48f..9578312e43f2 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -386,16 +386,11 @@ static int intel_pstate_get_cppc_guranteed(int
> cpu)
>  	return cppc_perf.guaranteed_perf;
>  }
>  
> -#else
> +#else /* CONFIG_ACPI_CPPC_LIB */
>  static void intel_pstate_set_itmt_prio(int cpu)
>  {
>  }
> -
> -static int intel_pstate_get_cppc_guranteed(int cpu)
> -{
> -	return -ENOTSUPP;
> -}
> -#endif
> +#endif /* CONFIG_ACPI_CPPC_LIB */
>  
>  static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy
> *policy)
>  {
> @@ -477,7 +472,7 @@ static void intel_pstate_exit_perf_limits(struct
> cpufreq_policy *policy)
>  
>  	acpi_processor_unregister_performance(policy->cpu);
>  }
> -#else
> +#else /* CONFIG_ACPI */
>  static inline void intel_pstate_init_acpi_perf_limits(struct
> cpufreq_policy *policy)
>  {
>  }
> @@ -490,7 +485,14 @@ static inline bool
> intel_pstate_acpi_pm_profile_server(void)
>  {
>  	return false;
>  }
> -#endif
> +#endif /* CONFIG_ACPI */
> +
> +#ifndef CONFIG_ACPI_CPPC_LIB
> +static int intel_pstate_get_cppc_guranteed(int cpu)
> +{
> +	return -ENOTSUPP;
> +}
> +#endif /* CONFIG_ACPI_CPPC_LIB */
>  
>  static inline void update_turbo_state(void)
>  {

