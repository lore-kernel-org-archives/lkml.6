Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E769ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262802075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 262802075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbeGQR4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:56:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:28157 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729741AbeGQR4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:56:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 10:23:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,366,1526367600"; 
   d="scan'208";a="72141659"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jul 2018 10:23:00 -0700
Message-ID: <d4419603cb727bb28fe9ab7abfc9595b78cb7554.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Load when ACPI PCCH is present
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andreas Herrmann <aherrmann@suse.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 17 Jul 2018 10:23:00 -0700
In-Reply-To: <8115130.Fhkpr82c7G@aspire.rjw.lan>
References: <20180717065048.74mmgk4t5utjaa6a@suselix>
         <20180717102136.snayvzmv2h3dcwiq@suselix>
         <20180717140336.ayovaz4ksdlak6bb@suselix>
         <8115130.Fhkpr82c7G@aspire.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-17 at 18:13 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Currently, intel_pstate doesn't load if _PSS is not present on
> HP Proliant systems, because it expects the firmware to take over
> CPU performance scaling in that case.  However, if ACPI PCCH is
> present, the firmware expects the kernel to use it for CPU
> performance scaling and the pcc-cpufreq driver is loaded for that.
> 
> Unfortunately, the firmware interface used by that driver is not
> scalable for fundamental reasons, so pcc-cpufreq is way suboptimal
> on systems with more than just a few CPUs.  In fact, it is better to
> avoid using it at all.
> 
> For this reason, modify intel_pstate to look for ACPI PCCH if _PSS
> is not present and load if it is there.
> 
> Fixes: fbbcdc0744da (intel_pstate: skip the driver if ACPI has power
> mgmt option)
> Reported-by: Andreas Herrmann <aherrmann@suse.com>
> Tested-by: Andreas Herrmann <aherrmann@suse.com>
> Reviewed-by: Andreas Herrmann <aherrmann@suse.com>
> Cc: 4.17+ <stable@vger.kernel.org> # 4.17+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

But do we need a change as done by the following commit in in pcc-
cpufreq.c?

"
commit 8a61e12e84597b5f8155ac91b44dea866ccfaac2
Author: Yinghai Lu <yinghai@kernel.org>
Date:   Fri Sep 20 10:43:56 2013 -0700

    acpi-cpufreq: skip loading acpi_cpufreq after intel_pstate
    
"

Thanks,
Srinivas

> ---
>  drivers/cpufreq/intel_pstate.c |   17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -2391,6 +2391,18 @@ static bool __init intel_pstate_no_acpi_
>  	return true;
>  }
>  
> +static bool __init intel_pstate_no_acpi_pcch(void)
> +{
> +	acpi_status status;
> +	acpi_handle handle;
> +
> +	status = acpi_get_handle(NULL, "\\_SB", &handle);
> +	if (ACPI_FAILURE(status))
> +		return true;
> +
> +	return !acpi_has_method(handle, "PCCH");
> +}
> +
>  static bool __init intel_pstate_has_acpi_ppc(void)
>  {
>  	int i;
> @@ -2450,7 +2462,10 @@ static bool __init intel_pstate_platform
>  
>  	switch (plat_info[idx].data) {
>  	case PSS:
> -		return intel_pstate_no_acpi_pss();
> +		if (!intel_pstate_no_acpi_pss())
> +			return false;
> +
> +		return intel_pstate_no_acpi_pcch();
>  	case PPC:
>  		return intel_pstate_has_acpi_ppc() && !force_load;
>  	}
> 
