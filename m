Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B21C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9B921871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbeLSLRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:17:53 -0500
Received: from foss.arm.com ([217.140.101.70]:33126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727155AbeLSLRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 06:17:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D5F8EBD;
        Wed, 19 Dec 2018 03:17:52 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAC293F5C0;
        Wed, 19 Dec 2018 03:17:49 -0800 (PST)
Date:   Wed, 19 Dec 2018 11:17:44 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 24/27] drivers: firmware: psci: Support CPU hotplug
 for the hierarchical model
Message-ID: <20181219111744.GA23393@e107981-ln.cambridge.arm.com>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-25-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129174700.16585-25-ulf.hansson@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 06:46:57PM +0100, Ulf Hansson wrote:
> When the hierarchical CPU topology is used and when a CPU has been put
> offline (hotplug), that same CPU prevents its PM domain and thus also
> potential master PM domains, from being powered off. This is because genpd
> observes the CPU's struct device to remain being active from a runtime PM
> point of view.
> 
> To deal with this, let's decrease the runtime PM usage count by calling
> pm_runtime_put_sync_suspend() of the CPU's struct device when putting it
> offline. Consequentially, we must then increase the runtime PM usage for
> the CPU, while putting it online again.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v10:
> 	- Make it work when the hierarchical CPU topology is used, which may be
> 	  used both for OSI and PC mode.
> 	- Rework the code to prevent "BUG: sleeping function called from
> 	  invalid context".
> ---
>  drivers/firmware/psci/psci.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index b03bccce0a5d..f62c4963eb62 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -15,6 +15,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/arm-smccc.h>
> +#include <linux/cpu.h>
>  #include <linux/cpuidle.h>
>  #include <linux/errno.h>
>  #include <linux/linkage.h>
> @@ -199,9 +200,20 @@ static int psci_cpu_suspend(u32 state, unsigned long entry_point)
>  
>  static int psci_cpu_off(u32 state)
>  {
> +	struct device *dev;
>  	int err;
>  	u32 fn;
>  
> +	/*
> +	 * When the hierarchical CPU topology is used, decrease the runtime PM
> +	 * usage count for the current CPU, as to allow other parts in the
> +	 * topology to enter low power states.
> +	 */
> +	if (psci_dt_topology) {
> +		dev = get_cpu_device(smp_processor_id());
> +		pm_runtime_put_sync_suspend(dev);
> +	}
> +
>  	fn = psci_function_id[PSCI_FN_CPU_OFF];
>  	err = invoke_psci_fn(fn, state, 0, 0);
>  	return psci_to_linux_errno(err);
> @@ -209,6 +221,7 @@ static int psci_cpu_off(u32 state)
>  
>  static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
>  {
> +	struct device *dev;
>  	int err;
>  	u32 fn;
>  
> @@ -216,6 +229,13 @@ static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
>  	err = invoke_psci_fn(fn, cpuid, entry_point, 0);
>  	/* Clear the domain state to start fresh. */
>  	psci_set_domain_state(0);
> +
> +	/* Increase runtime PM usage count if the hierarchical CPU toplogy. */
> +	if (!err && psci_dt_topology) {
> +		dev = get_cpu_device(cpuid);

I do not like adding this code in the cpu_{on/off} method themselves, I will
have a look at the patchset as whole to see how we can restructure it.

More to the point, using cpuid as a logical cpu id is wrong, it is a
physical id that you should convert to a logical id through
get_logical_index().

Lorenzo

> +		pm_runtime_get_sync(dev);
> +	}
> +
>  	return psci_to_linux_errno(err);
>  }
>  
> -- 
> 2.17.1
> 
