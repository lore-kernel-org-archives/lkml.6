Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED525C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F2A2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F2A2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbeGZKcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:32:42 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50476 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbeGZKcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:32:42 -0400
Received: from 79.184.255.17.ipv4.supernova.orange.pl (79.184.255.17) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 266f98e022b82640; Thu, 26 Jul 2018 11:16:44 +0200
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
Date:   Thu, 26 Jul 2018 11:14:56 +0200
Message-ID: <10360149.m4MlxDWZY5@aspire.rjw.lan>
In-Reply-To: <3574880.GjmnMm1lMq@aspire.rjw.lan>
References: <20180620172226.15012-1-ulf.hansson@linaro.org> <20180620172226.15012-8-ulf.hansson@linaro.org> <3574880.GjmnMm1lMq@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 19, 2018 12:32:52 PM CEST Rafael J. Wysocki wrote:
> On Wednesday, June 20, 2018 7:22:07 PM CEST Ulf Hansson wrote:
> > As it's now perfectly possible that a PM domain managed by genpd contains
> > devices belonging to CPUs, we should start to take into account the
> > residency values for the idle states during the state selection process.
> > The residency value specifies the minimum duration of time, the CPU or a
> > group of CPUs, needs to spend in an idle state to not waste energy entering
> > it.
> > 
> > To deal with this, let's add a new genpd governor, pm_domain_cpu_gov, that
> > may be used for a PM domain that have CPU devices attached or if the CPUs
> > are attached through subdomains.
> > 
> > The new governor computes the minimum expected idle duration time for the
> > online CPUs being attached to the PM domain and its subdomains. Then in the
> > state selection process, trying the deepest state first, it verifies that
> > the idle duration time satisfies the state's residency value.
> > 
> > It should be noted that, when computing the minimum expected idle duration
> > time, we use the information from tick_nohz_get_next_wakeup(), to find the
> > next wakeup for the related CPUs. Future wise, this may deserve to be
> > improved, as there are more reasons to why a CPU may be woken up from idle.
> > 
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Lina Iyer <ilina@codeaurora.org>
> > Cc: Frederic Weisbecker <fweisbec@gmail.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/base/power/domain_governor.c | 58 ++++++++++++++++++++++++++++
> >  include/linux/pm_domain.h            |  2 +
> >  2 files changed, 60 insertions(+)
> > 
> > diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
> > index 99896fbf18e4..1aad55719537 100644
> > --- a/drivers/base/power/domain_governor.c
> > +++ b/drivers/base/power/domain_governor.c
> > @@ -10,6 +10,9 @@
> >  #include <linux/pm_domain.h>
> >  #include <linux/pm_qos.h>
> >  #include <linux/hrtimer.h>
> > +#include <linux/cpumask.h>
> > +#include <linux/ktime.h>
> > +#include <linux/tick.h>
> >  
> >  static int dev_update_qos_constraint(struct device *dev, void *data)
> >  {
> > @@ -245,6 +248,56 @@ static bool always_on_power_down_ok(struct dev_pm_domain *domain)
> >  	return false;
> >  }
> >  
> > +static bool cpu_power_down_ok(struct dev_pm_domain *pd)
> > +{
> > +	struct generic_pm_domain *genpd = pd_to_genpd(pd);
> > +	ktime_t domain_wakeup, cpu_wakeup;
> > +	s64 idle_duration_ns;
> > +	int cpu, i;
> > +
> > +	if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
> > +		return true;
> > +
> > +	/*
> > +	 * Find the next wakeup for any of the online CPUs within the PM domain
> > +	 * and its subdomains. Note, we only need the genpd->cpus, as it already
> > +	 * contains a mask of all CPUs from subdomains.
> > +	 */
> > +	domain_wakeup = ktime_set(KTIME_SEC_MAX, 0);
> > +	for_each_cpu_and(cpu, genpd->cpus, cpu_online_mask) {
> > +		cpu_wakeup = tick_nohz_get_next_wakeup(cpu);
> > +		if (ktime_before(cpu_wakeup, domain_wakeup))
> > +			domain_wakeup = cpu_wakeup;
> > +	}

Here's a concern I have missed before. :-/

Say, one of the CPUs you're walking here is woken up in the meantime.

I don't think it is valid to evaluate tick_nohz_get_next_wakeup() for it then
to update domain_wakeup.  We really should just avoid the domain power off in
that case at all IMO.

Sure enough, if the domain power off is already started and one of the CPUs
in the domain is woken up then, too bad, it will suffer the latency (but in
that case the hardware should be able to help somewhat), but otherwise CPU
wakeup should prevent domain power off from being carried out.

Thanks,
Rafael

