Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCFAC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0447E2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0447E2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbeGSLUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:20:12 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:63293 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbeGSLUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:20:12 -0400
Received: from 79.184.255.17.ipv4.supernova.orange.pl (79.184.255.17) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 1c24aeafc6239828; Thu, 19 Jul 2018 12:37:38 +0200
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
Subject: Re: [PATCH v8 08/26] PM / Domains: Extend genpd CPU governor to cope with QoS constraints
Date:   Thu, 19 Jul 2018 12:35:59 +0200
Message-ID: <1683770.JmsJDzJTZp@aspire.rjw.lan>
In-Reply-To: <20180620172226.15012-9-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org> <20180620172226.15012-9-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, June 20, 2018 7:22:08 PM CEST Ulf Hansson wrote:
> CPU devices and other regular devices may share the same PM domain and may
> also be hierarchically related via subdomains. In either case, all devices
> including CPUs, may be attached to a PM domain managed by genpd, that has
> an idle state with an enter/exit latency.
> 
> Let's take these latencies into account in the state selection process by
> genpd's governor for CPUs. This means the governor, pm_domain_cpu_gov,
> becomes extended to satisfy both a state's residency and a potential dev PM
> QoS constraint.
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain_governor.c | 15 +++++++++++----
>  include/linux/pm_domain.h            |  1 +
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
> index 1aad55719537..03d4e9454ce9 100644
> --- a/drivers/base/power/domain_governor.c
> +++ b/drivers/base/power/domain_governor.c
> @@ -214,8 +214,10 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
>  	struct generic_pm_domain *genpd = pd_to_genpd(pd);
>  	struct gpd_link *link;
>  
> -	if (!genpd->max_off_time_changed)
> +	if (!genpd->max_off_time_changed) {
> +		genpd->state_idx = genpd->cached_power_down_state_idx;
>  		return genpd->cached_power_down_ok;
> +	}
>  
>  	/*
>  	 * We have to invalidate the cached results for the masters, so
> @@ -240,6 +242,7 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
>  		genpd->state_idx--;
>  	}
>  
> +	genpd->cached_power_down_state_idx = genpd->state_idx;
>  	return genpd->cached_power_down_ok;
>  }
>  
> @@ -255,6 +258,10 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>  	s64 idle_duration_ns;
>  	int cpu, i;
>  
> +	/* Validate dev PM QoS constraints. */
> +	if (!default_power_down_ok(pd))
> +		return false;
> +
>  	if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
>  		return true;
>  
> @@ -276,9 +283,9 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>  	/*
>  	 * Find the deepest idle state that has its residency value satisfied
>  	 * and by also taking into account the power off latency for the state.
> -	 * Start at the deepest supported state.
> +	 * Start at the state picked by the dev PM QoS constraint validation.
>  	 */
> -	i = genpd->state_count - 1;
> +	i = genpd->state_idx;
>  	do {
>  		if (!genpd->states[i].residency_ns)
>  			break;
> @@ -312,6 +319,6 @@ struct dev_power_governor pm_domain_always_on_gov = {
>  };
>  
>  struct dev_power_governor pm_domain_cpu_gov = {
> -	.suspend_ok = NULL,
> +	.suspend_ok = default_suspend_ok,
>  	.power_down_ok = cpu_power_down_ok,
>  };
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 97901c833108..dbc69721cad8 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -81,6 +81,7 @@ struct generic_pm_domain {
>  	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
>  	bool max_off_time_changed;
>  	bool cached_power_down_ok;
> +	bool cached_power_down_state_idx;
>  	int (*attach_dev)(struct generic_pm_domain *domain,
>  			  struct device *dev);
>  	void (*detach_dev)(struct generic_pm_domain *domain,
> 

I don't see much value in splitting this patch off [07/26] and it actually
confused me, so it may as well confuse someone else.

