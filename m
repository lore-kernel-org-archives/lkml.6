Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55272ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136142084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136142084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbeGSLRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:17:06 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64616 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731154AbeGSLRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:17:06 -0400
Received: from 79.184.255.17.ipv4.supernova.orange.pl (79.184.255.17) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 1a7fa92920cc6fa8; Thu, 19 Jul 2018 12:34:32 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v8 07/26] PM / Domains: Add genpd governor for CPUs
Date:   Thu, 19 Jul 2018 12:32:52 +0200
Message-ID: <3574880.GjmnMm1lMq@aspire.rjw.lan>
In-Reply-To: <20180620172226.15012-8-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org> <20180620172226.15012-8-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, June 20, 2018 7:22:07 PM CEST Ulf Hansson wrote:
> As it's now perfectly possible that a PM domain managed by genpd contains
> devices belonging to CPUs, we should start to take into account the
> residency values for the idle states during the state selection process.
> The residency value specifies the minimum duration of time, the CPU or a
> group of CPUs, needs to spend in an idle state to not waste energy entering
> it.
> 
> To deal with this, let's add a new genpd governor, pm_domain_cpu_gov, that
> may be used for a PM domain that have CPU devices attached or if the CPUs
> are attached through subdomains.
> 
> The new governor computes the minimum expected idle duration time for the
> online CPUs being attached to the PM domain and its subdomains. Then in the
> state selection process, trying the deepest state first, it verifies that
> the idle duration time satisfies the state's residency value.
> 
> It should be noted that, when computing the minimum expected idle duration
> time, we use the information from tick_nohz_get_next_wakeup(), to find the
> next wakeup for the related CPUs. Future wise, this may deserve to be
> improved, as there are more reasons to why a CPU may be woken up from idle.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain_governor.c | 58 ++++++++++++++++++++++++++++
>  include/linux/pm_domain.h            |  2 +
>  2 files changed, 60 insertions(+)
> 
> diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
> index 99896fbf18e4..1aad55719537 100644
> --- a/drivers/base/power/domain_governor.c
> +++ b/drivers/base/power/domain_governor.c
> @@ -10,6 +10,9 @@
>  #include <linux/pm_domain.h>
>  #include <linux/pm_qos.h>
>  #include <linux/hrtimer.h>
> +#include <linux/cpumask.h>
> +#include <linux/ktime.h>
> +#include <linux/tick.h>
>  
>  static int dev_update_qos_constraint(struct device *dev, void *data)
>  {
> @@ -245,6 +248,56 @@ static bool always_on_power_down_ok(struct dev_pm_domain *domain)
>  	return false;
>  }
>  
> +static bool cpu_power_down_ok(struct dev_pm_domain *pd)
> +{
> +	struct generic_pm_domain *genpd = pd_to_genpd(pd);
> +	ktime_t domain_wakeup, cpu_wakeup;
> +	s64 idle_duration_ns;
> +	int cpu, i;
> +
> +	if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
> +		return true;
> +
> +	/*
> +	 * Find the next wakeup for any of the online CPUs within the PM domain
> +	 * and its subdomains. Note, we only need the genpd->cpus, as it already
> +	 * contains a mask of all CPUs from subdomains.
> +	 */
> +	domain_wakeup = ktime_set(KTIME_SEC_MAX, 0);
> +	for_each_cpu_and(cpu, genpd->cpus, cpu_online_mask) {
> +		cpu_wakeup = tick_nohz_get_next_wakeup(cpu);
> +		if (ktime_before(cpu_wakeup, domain_wakeup))
> +			domain_wakeup = cpu_wakeup;
> +	}
> +
> +	/* The minimum idle duration is from now - until the next wakeup. */
> +	idle_duration_ns = ktime_to_ns(ktime_sub(domain_wakeup, ktime_get()));
> +

If idle_duration_ns is negative at this point, you can return false right
away and then you won't need to bother with this case below.

> +	/*
> +	 * Find the deepest idle state that has its residency value satisfied
> +	 * and by also taking into account the power off latency for the state.
> +	 * Start at the deepest supported state.
> +	 */
> +	i = genpd->state_count - 1;
> +	do {
> +		if (!genpd->states[i].residency_ns)
> +			break;
> +
> +		/* Check idle_duration_ns >= 0 to compare signed/unsigned. */
> +		if (idle_duration_ns >= 0 && idle_duration_ns >=
> +		    (genpd->states[i].residency_ns +
> +		     genpd->states[i].power_off_latency_ns))

Why don't you set state_idx and return true right here?

Then you'll only need to return false if you haven't found a matching state.

> +			break;
> +		i--;
> +	} while (i >= 0);
> +
> +	if (i < 0)
> +		return false;
> +
> +	genpd->state_idx = i;
> +	return true;
> +}
> +
>  struct dev_power_governor simple_qos_governor = {
>  	.suspend_ok = default_suspend_ok,
>  	.power_down_ok = default_power_down_ok,
> @@ -257,3 +310,8 @@ struct dev_power_governor pm_domain_always_on_gov = {
>  	.power_down_ok = always_on_power_down_ok,
>  	.suspend_ok = default_suspend_ok,
>  };
> +
> +struct dev_power_governor pm_domain_cpu_gov = {
> +	.suspend_ok = NULL,
> +	.power_down_ok = cpu_power_down_ok,

I see that I haven't got your code flow right after all. :-)

And which means that this should work AFAICS.

> +};
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 2c09cf80b285..97901c833108 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -160,6 +160,7 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
>  
>  extern struct dev_power_governor simple_qos_governor;
>  extern struct dev_power_governor pm_domain_always_on_gov;
> +extern struct dev_power_governor pm_domain_cpu_gov;
>  #else
>  
>  static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
> @@ -203,6 +204,7 @@ static inline int dev_pm_genpd_set_performance_state(struct device *dev,
>  
>  #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
>  #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
> +#define pm_domain_cpu_gov		(*(struct dev_power_governor *)(NULL))
>  #endif
>  
>  #ifdef CONFIG_PM_GENERIC_DOMAINS_SLEEP
> 


