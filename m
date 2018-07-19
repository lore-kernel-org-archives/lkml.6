Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97BFECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6928B20693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6928B20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbeGSLKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:10:06 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48317 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbeGSLKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:10:06 -0400
Received: from 79.184.255.17.ipv4.supernova.orange.pl (79.184.255.17) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 0ec76970ee56d7a8; Thu, 19 Jul 2018 12:27:34 +0200
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
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 04/26] PM / Domains: Add support for CPU devices to genpd
Date:   Thu, 19 Jul 2018 12:25:54 +0200
Message-ID: <1678369.6pMUSOvdlV@aspire.rjw.lan>
In-Reply-To: <20180620172226.15012-5-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org> <20180620172226.15012-5-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, June 20, 2018 7:22:04 PM CEST Ulf Hansson wrote:
> To enable a device belonging to a CPU to be attached to a PM domain managed
> by genpd, let's do a few changes to genpd as to make it convenient to
> manage the specifics around CPUs.
> 
> First, as to be able to quickly find out what CPUs that are attached to a
> genpd, which typically becomes useful from a genpd governor as following
> changes is about to show, let's add a cpumask 'cpus' to the struct
> generic_pm_domain.
> 
> At the point when a device that belongs to a CPU, is attached/detached to
> its corresponding PM domain via genpd_add_device(), let's update the
> cpumask in genpd->cpus. Moreover, propagate the update of the cpumask to
> the master domains, which makes the genpd->cpus to contain a cpumask that
> hierarchically reflect all CPUs for a genpd, including CPUs attached to
> subdomains.
> 
> Second, to unconditionally manage CPUs and the cpumask in genpd->cpus, is
> unnecessary for cases when only non-CPU devices are parts of a genpd.
> Let's avoid this by adding a new configuration bit, GENPD_FLAG_CPU_DOMAIN.
> Clients must set the bit before they call pm_genpd_init(), as to instruct
> genpd that it shall deal with CPUs and thus manage the cpumask in
> genpd->cpus.
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 69 ++++++++++++++++++++++++++++++++++++-
>  include/linux/pm_domain.h   |  3 ++
>  2 files changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 21d298e1820b..6149ce0bfa7b 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -20,6 +20,7 @@
>  #include <linux/sched.h>
>  #include <linux/suspend.h>
>  #include <linux/export.h>
> +#include <linux/cpu.h>
>  
>  #include "power.h"
>  
> @@ -126,6 +127,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
>  #define genpd_is_irq_safe(genpd)	(genpd->flags & GENPD_FLAG_IRQ_SAFE)
>  #define genpd_is_always_on(genpd)	(genpd->flags & GENPD_FLAG_ALWAYS_ON)
>  #define genpd_is_active_wakeup(genpd)	(genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
> +#define genpd_is_cpu_domain(genpd)	(genpd->flags & GENPD_FLAG_CPU_DOMAIN)
>  
>  static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
>  		const struct generic_pm_domain *genpd)
> @@ -1377,6 +1379,62 @@ static void genpd_free_dev_data(struct device *dev,
>  	dev_pm_put_subsys_data(dev);
>  }
>  
> +static void __genpd_update_cpumask(struct generic_pm_domain *genpd,
> +				   int cpu, bool set, unsigned int depth)
> +{
> +	struct gpd_link *link;
> +
> +	if (!genpd_is_cpu_domain(genpd))
> +		return;
> +
> +	list_for_each_entry(link, &genpd->slave_links, slave_node) {
> +		struct generic_pm_domain *master = link->master;
> +
> +		genpd_lock_nested(master, depth + 1);
> +		__genpd_update_cpumask(master, cpu, set, depth + 1);
> +		genpd_unlock(master);
> +	}
> +
> +	if (set)
> +		cpumask_set_cpu(cpu, genpd->cpus);
> +	else
> +		cpumask_clear_cpu(cpu, genpd->cpus);
> +}

As noted elsewhere, there is a concern about the possible weight of this
cpumask and I think that it would be good to explicitly put a limit on it.

> +
> +static void genpd_update_cpumask(struct generic_pm_domain *genpd,
> +				 struct device *dev, bool set)
> +{
> +	bool is_cpu = false;
> +	int cpu;
> +
> +	if (!genpd_is_cpu_domain(genpd))
> +		return;
> +
> +	for_each_possible_cpu(cpu) {
> +		if (get_cpu_device(cpu) == dev) {
> +			is_cpu = true;

You may call __genpd_update_cpumask() right here and then you won't
need the extra is_cpu variable.

> +			break;
> +		}
> +	}
> +
> +	if (!is_cpu)
> +		return;
> +
> +	__genpd_update_cpumask(genpd, cpu, set, 0);
> +}
> +
> +static void genpd_set_cpumask(struct generic_pm_domain *genpd,
> +			      struct device *dev)
> +{
> +	genpd_update_cpumask(genpd, dev, true);
> +}
> +
> +static void genpd_clear_cpumask(struct generic_pm_domain *genpd,
> +				struct device *dev)
> +{
> +	genpd_update_cpumask(genpd, dev, false);
> +}
> +
>  static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>  			    struct gpd_timing_data *td)
>  {
> @@ -1398,6 +1456,8 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>  	if (ret)
>  		goto out;
>  
> +	genpd_set_cpumask(genpd, dev);
> +
>  	dev_pm_domain_set(dev, &genpd->domain);
>  
>  	genpd->device_count++;
> @@ -1459,6 +1519,7 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
>  	if (genpd->detach_dev)
>  		genpd->detach_dev(genpd, dev);
>  
> +	genpd_clear_cpumask(genpd, dev);
>  	dev_pm_domain_set(dev, NULL);
>  
>  	list_del_init(&pdd->list_node);
> @@ -1686,11 +1747,16 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>  	if (genpd_is_always_on(genpd) && !genpd_status_on(genpd))
>  		return -EINVAL;
>  
> +	if (!zalloc_cpumask_var(&genpd->cpus, GFP_KERNEL))
> +		return -ENOMEM;
> +
>  	/* Use only one "off" state if there were no states declared */
>  	if (genpd->state_count == 0) {
>  		ret = genpd_set_default_power_state(genpd);
> -		if (ret)
> +		if (ret) {
> +			free_cpumask_var(genpd->cpus);
>  			return ret;
> +		}
>  	} else if (!gov) {
>  		pr_warn("%s : no governor for states\n", genpd->name);
>  	}
> @@ -1736,6 +1802,7 @@ static int genpd_remove(struct generic_pm_domain *genpd)
>  	list_del(&genpd->gpd_list_node);
>  	genpd_unlock(genpd);
>  	cancel_work_sync(&genpd->power_off_work);
> +	free_cpumask_var(genpd->cpus);
>  	kfree(genpd->free);
>  	pr_debug("%s: removed %s\n", __func__, genpd->name);
>  
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 27fca748344a..3f67ff0c1c69 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -16,12 +16,14 @@
>  #include <linux/of.h>
>  #include <linux/notifier.h>
>  #include <linux/spinlock.h>
> +#include <linux/cpumask.h>
>  
>  /* Defines used for the flags field in the struct generic_pm_domain */
>  #define GENPD_FLAG_PM_CLK	 (1U << 0) /* PM domain uses PM clk */
>  #define GENPD_FLAG_IRQ_SAFE	 (1U << 1) /* PM domain operates in atomic */
>  #define GENPD_FLAG_ALWAYS_ON	 (1U << 2) /* PM domain is always powered on */
>  #define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3) /* Keep devices active if wakeup */
> +#define GENPD_FLAG_CPU_DOMAIN	 (1U << 4) /* PM domain manages CPUs */
>  
>  enum gpd_status {
>  	GPD_STATE_ACTIVE = 0,	/* PM domain is active */
> @@ -68,6 +70,7 @@ struct generic_pm_domain {
>  	unsigned int suspended_count;	/* System suspend device counter */
>  	unsigned int prepared_count;	/* Suspend counter of prepared devices */
>  	unsigned int performance_state;	/* Aggregated max performance state */
> +	cpumask_var_t cpus;		/* A cpumask of the attached CPUs */
>  	int (*power_off)(struct generic_pm_domain *domain);
>  	int (*power_on)(struct generic_pm_domain *domain);
>  	unsigned int (*opp_to_performance_state)(struct generic_pm_domain *genpd,
> 


