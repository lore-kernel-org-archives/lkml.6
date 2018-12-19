Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D9EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30CAF21873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jUx3vDHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeLSJxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:53:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35485 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbeLSJxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:53:50 -0500
Received: by mail-wm1-f67.google.com with SMTP id c126so5682982wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 01:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kl/hiez7H8vqKUrwdN36AXfEtS84bobhGCKViVP/Hus=;
        b=jUx3vDHGuyWNGLm/tlgKhzoO0di6wDFVQ+8rAlW9+d8IBxXoMTj/zBqPDwBvrdWKpk
         gkLkSAjuIpIPX5gyA4OzsQWaHuH7TIpkvzXb829a3a9hasD+V4VhiQtjFeSqVS+hZsPS
         UK0hHb3GTfyavtNIARtVVSS2HiybD1l2fIEnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kl/hiez7H8vqKUrwdN36AXfEtS84bobhGCKViVP/Hus=;
        b=QGdyZs0MO7AVH3QfU6rwKanSs4s2KsWsN++fLvPO5hOe99hKwL116UtNVSR+HsYhHe
         uuDD8Wwx3ZTOTstawYGoIr3NavtjiI8mnmaamq/WhUPc3GNaWhaqS+cGPcFvAsrIOPi1
         ZvXB0jq8TBI8K0sjqodpm6i8c1iRACRH187Vb/h6O663tP1lk3cH9vbixkagNKWRtyjA
         l9cBXFVyqO0Fa7QcKARBwwHz1E8m7B8OdB3AbWI4GQssC2JMgT+tMqIzQF8F9O+faNz/
         Q63c1sEl8xWRLV/A+eODHh82hS1rBmqlp/12jsI3DAl+dj1AqdOVpJcIDTloqaEjhAT/
         XUzA==
X-Gm-Message-State: AA+aEWYZuqM3ss0+Toxw0udqE7f+bRzAXDnqA4B57QVViPUDLJZYmqtJ
        HEfIInLfG5HFB4lUbaF643H36N6B1oQ=
X-Google-Smtp-Source: AFSGD/WZfaIuzSFbyolJOlkXVcL/zP2pYpPE6D4ZNkl9HODGtzxZjdb53O/T78dHJBg9Zva3MpEHDw==
X-Received: by 2002:a1c:5892:: with SMTP id m140mr6535332wmb.60.1545213227895;
        Wed, 19 Dec 2018 01:53:47 -0800 (PST)
Received: from [192.168.0.40] (105.50.92.92.rev.sfr.net. [92.92.50.105])
        by smtp.googlemail.com with ESMTPSA id x10sm6327130wrn.29.2018.12.19.01.53.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 01:53:47 -0800 (PST)
Subject: Re: [PATCH v10 02/27] PM / Domains: Add support for CPU devices to
 genpd
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc:     "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-3-ulf.hansson@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <45ff9a4b-6130-7800-28cc-a2f5f736f44b@linaro.org>
Date:   Wed, 19 Dec 2018 10:53:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129174700.16585-3-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2018 18:46, Ulf Hansson wrote:
> To enable a device belonging to a CPU to be attached to a PM domain managed
> by genpd, let's do a few changes to it, as to make it convenient to manage
> the specifics around CPUs.
> 
> To be able to quickly find out what CPUs that are attached to a genpd,
> which typically becomes useful from a genpd governor as following changes
> is about to show, let's add a cpumask to the struct generic_pm_domain. At
> the point when a CPU device gets attached to a genpd, let's update its
> cpumask. Moreover, let's also propagate changes to the cpumask upwards in
> the topology to the master PM domains. In this way, the cpumask for a genpd
> hierarchically reflects all CPUs attached to the topology below it.
> 
> Finally, let's make this an opt-in feature, to avoid having to manage CPUs
> and the cpumask for a genpd that doesn't need it. For that reason, let's
> add a new genpd configuration bit, GENPD_FLAG_CPU_DOMAIN.
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v10:
> 	- Don't allocate the cpumask when not used.
> 	- Simplify the code that updates the cpumask.
> 	- Document the GENPD_FLAG_CPU_DOMAIN.
> 
> ---
>  drivers/base/power/domain.c | 66 ++++++++++++++++++++++++++++++++++++-
>  include/linux/pm_domain.h   | 13 ++++++++
>  2 files changed, 78 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index e27b91d36a2a..c3ff8e395308 100644
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
> @@ -1377,6 +1379,56 @@ static void genpd_free_dev_data(struct device *dev,
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

With this test, we won't continue updating the cpumask for the other
masters. Is it done on purpose ?

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
> +
> +static void genpd_update_cpumask(struct generic_pm_domain *genpd,
> +				 struct device *dev, bool set)
> +{
> +	int cpu;
> +
> +	if (!genpd_is_cpu_domain(genpd))
> +		return;
> +
> +	for_each_possible_cpu(cpu) {
> +		if (get_cpu_device(cpu) == dev) {
> +			__genpd_update_cpumask(genpd, cpu, set, 0);
> +			return;
> +		}
> +	}
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
> @@ -1398,6 +1450,8 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>  	if (ret)
>  		goto out;
>  
> +	genpd_set_cpumask(genpd, dev);
> +
>  	dev_pm_domain_set(dev, &genpd->domain);
>  
>  	genpd->device_count++;
> @@ -1459,6 +1513,7 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
>  	if (genpd->detach_dev)
>  		genpd->detach_dev(genpd, dev);
>  
> +	genpd_clear_cpumask(genpd, dev);
>  	dev_pm_domain_set(dev, NULL);
>  
>  	list_del_init(&pdd->list_node);
> @@ -1686,11 +1741,18 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>  	if (genpd_is_always_on(genpd) && !genpd_status_on(genpd))
>  		return -EINVAL;
>  
> +	if (genpd_is_cpu_domain(genpd) &&
> +	    !zalloc_cpumask_var(&genpd->cpus, GFP_KERNEL))
> +		return -ENOMEM;
> +
>  	/* Use only one "off" state if there were no states declared */
>  	if (genpd->state_count == 0) {
>  		ret = genpd_set_default_power_state(genpd);
> -		if (ret)
> +		if (ret) {
> +			if (genpd_is_cpu_domain(genpd))
> +				free_cpumask_var(genpd->cpus);
>  			return ret;
> +		}
>  	} else if (!gov) {
>  		pr_warn("%s : no governor for states\n", genpd->name);
>  	}
> @@ -1736,6 +1798,8 @@ static int genpd_remove(struct generic_pm_domain *genpd)
>  	list_del(&genpd->gpd_list_node);
>  	genpd_unlock(genpd);
>  	cancel_work_sync(&genpd->power_off_work);
> +	if (genpd_is_cpu_domain(genpd))
> +		free_cpumask_var(genpd->cpus);
>  	if (genpd->free_state) {
>  		kfree(genpd->states);
>  		genpd->states = NULL;
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index f9e09bd4152c..5a4673605d22 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -16,6 +16,7 @@
>  #include <linux/of.h>
>  #include <linux/notifier.h>
>  #include <linux/spinlock.h>
> +#include <linux/cpumask.h>
>  
>  /*
>   * Flags to control the behaviour of a genpd.
> @@ -42,11 +43,22 @@
>   * GENPD_FLAG_ACTIVE_WAKEUP:	Instructs genpd to keep the PM domain powered
>   *				on, in case any of its attached devices is used
>   *				in the wakeup path to serve system wakeups.
> + *
> + * GENPD_FLAG_CPU_DOMAIN:	Instructs genpd that it should expect to get
> + *				devices attached, which may belong to CPUs or
> + *				possibly have subdomains with CPUs attached.
> + *				This flag enables the genpd backend driver to
> + *				deploy idle power management support for CPUs
> + *				and groups of CPUs. Note that, the backend
> + *				driver must then comply with the so called,
> + *				last-man-standing algorithm, for the CPUs in the
> + *				PM domain.
>   */
>  #define GENPD_FLAG_PM_CLK	 (1U << 0)
>  #define GENPD_FLAG_IRQ_SAFE	 (1U << 1)
>  #define GENPD_FLAG_ALWAYS_ON	 (1U << 2)
>  #define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3)
> +#define GENPD_FLAG_CPU_DOMAIN	 (1U << 4)
>  
>  enum gpd_status {
>  	GPD_STATE_ACTIVE = 0,	/* PM domain is active */
> @@ -93,6 +105,7 @@ struct generic_pm_domain {
>  	unsigned int suspended_count;	/* System suspend device counter */
>  	unsigned int prepared_count;	/* Suspend counter of prepared devices */
>  	unsigned int performance_state;	/* Aggregated max performance state */
> +	cpumask_var_t cpus;		/* A cpumask of the attached CPUs */
>  	int (*power_off)(struct generic_pm_domain *domain);
>  	int (*power_on)(struct generic_pm_domain *domain);
>  	unsigned int (*opp_to_performance_state)(struct generic_pm_domain *genpd,
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

