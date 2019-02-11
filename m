Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D0CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F5E20823
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfBKVZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:25:21 -0500
Received: from mga09.intel.com ([134.134.136.24]:7819 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbfBKVZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:25:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 13:25:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,360,1544515200"; 
   d="scan'208";a="121657003"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga007.fm.intel.com with ESMTP; 11 Feb 2019 13:25:19 -0800
Message-ID: <eaf4286b0836444e00ec2e92178b5f31957c9a7a.camel@linux.intel.com>
Subject: Re: [PATCH v3] cpufreq: intel_pstate: Reporting reasons why driver
 prematurely exit
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Erwan Velu <erwanaliasr1@gmail.com>
Cc:     e.velu@criteo.com, Liam.Howlett@oracle.com,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:INTEL PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Mon, 11 Feb 2019 13:25:19 -0800
In-Reply-To: <20190211093140.23608-1-e.velu@criteo.com>
References: <20190211093140.23608-1-e.velu@criteo.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-11 at 10:31 +0100, Erwan Velu wrote:
> The init code path have several execeptions where the module can
> decide not to load.
> As CONFIG_X86_INTEL_PSTATE is generally set to Y, the return code is
> not reachable.
> The initialisation code is neither verbose of the reason why it did
> choose to prematurely exit.
> 
> This situation leads to situation where its difficult for a user to
> determine,
> on a given platform, why the driver didn't loaded properly.
> 
> This patch is about reporting to the user the reason/context why the
> driver failed to load.
> That is a precious hint when debugging a platform.
pr_info and pr_warn are too strong for this debug use case. Anytime
someone see some error in dmesg, we have an additional work to explain
that that is not a problem to an average user. So this is an
maintenance overhead for the purpose of debugging. Only few users who
are really trying to debug, will care for these errors. For them
pr_debug will be enough, we have other pr_debugs which will be helpful
to root cause the issue, even if driver loads.

Also when some user disabled intel_pstate via kernel command line,
additional debug message is not useful.

Thanks,
Srinivas

> 
> Signed-off-by: Erwan Velu <e.velu@criteo.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 36 ++++++++++++++++++++++++++----
> ----
>  1 file changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index dd66decf2087..ba2e2aee6c20 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2475,6 +2475,7 @@ static bool __init
> intel_pstate_no_acpi_pss(void)
>  		kfree(pss);
>  	}
>  
> +	pr_info("Cannot detect ACPI PSS");
>  	return true;
>  }
>  
> @@ -2484,10 +2485,16 @@ static bool __init
> intel_pstate_no_acpi_pcch(void)
>  	acpi_handle handle;
>  
>  	status = acpi_get_handle(NULL, "\\_SB", &handle);
> -	if (ACPI_FAILURE(status))
> +	if (ACPI_FAILURE(status)) {
> +		pr_info("Cannot detect ACPI SB");
>  		return true;
> +	}
>  
> -	return !acpi_has_method(handle, "PCCH");
> +	status = acpi_has_method(handle, "PCCH");
> +	if (!status) {
> +		pr_info("Cannot detect ACPI PCCH");
> +	}
> +	return !status;
>  }
>  
>  static bool __init intel_pstate_has_acpi_ppc(void)
> @@ -2502,6 +2509,7 @@ static bool __init
> intel_pstate_has_acpi_ppc(void)
>  		if (acpi_has_method(pr->handle, "_PPC"))
>  			return true;
>  	}
> +	pr_info("Cannot detect ACPI PPC");
>  	return false;
>  }
>  
> @@ -2592,8 +2600,10 @@ static int __init intel_pstate_init(void)
>  	const struct x86_cpu_id *id;
>  	int rc;
>  
> -	if (no_load)
> +	if (no_load) {
> +		pr_info("disabling as per user-request\n");
>  		return -ENODEV;
> +	}
>  
>  	id = x86_match_cpu(hwp_support_ids);
>  	if (id) {
> @@ -2606,31 +2616,41 @@ static int __init intel_pstate_init(void)
>  		}
>  	} else {
>  		id = x86_match_cpu(intel_pstate_cpu_ids);
> -		if (!id)
> +		if (!id) {
> +			pr_warn("CPU ID is not in the list of supported
> devices\n");
>  			return -ENODEV;
> +		}
>  
>  		copy_cpu_funcs((struct pstate_funcs *)id->driver_data);
>  	}
>  
> -	if (intel_pstate_msrs_not_valid())
> +	if (intel_pstate_msrs_not_valid()) {
> +		pr_warn("Cannot enable driver as per invalid MSRs\n");
>  		return -ENODEV;
> +	}
>  
>  hwp_cpu_matched:
>  	/*
>  	 * The Intel pstate driver will be ignored if the platform
>  	 * firmware has its own power management modes.
>  	 */
> -	if (intel_pstate_platform_pwr_mgmt_exists())
> +	if (intel_pstate_platform_pwr_mgmt_exists()) {
> +		pr_warn("Platform already taking care of power
> management\n");
>  		return -ENODEV;
> +	}
>  
> -	if (!hwp_active && hwp_only)
> +	if (!hwp_active && hwp_only) {
> +		pr_warn("HWP not present\n");
>  		return -ENOTSUPP;
> +	}
>  
>  	pr_info("Intel P-state driver initializing\n");
>  
>  	all_cpu_data = vzalloc(array_size(sizeof(void *),
> num_possible_cpus()));
> -	if (!all_cpu_data)
> +	if (!all_cpu_data) {
> +		pr_warn("Cannot allocate memory\n");
>  		return -ENOMEM;
> +	}
>  
>  	intel_pstate_request_control_from_smm();
>  

