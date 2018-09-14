Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEB8FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0D720861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0D720861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbeINOm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:42:29 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61920 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbeINOm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:42:29 -0400
Received: from 79.184.255.178.ipv4.supernova.orange.pl (79.184.255.178) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id e15f4b92dd6afbd5; Fri, 14 Sep 2018 11:28:48 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 04/26] PM / Domains: Add support for CPU devices to genpd
Date:   Fri, 14 Sep 2018 11:26:08 +0200
Message-ID: <3110675.RLi9TDTF77@aspire.rjw.lan>
In-Reply-To: <CAPDyKFpatx81aMrbDtaeNPH=FXBYPCHsog3i=a0VN5=Q8if0=Q@mail.gmail.com>
References: <20180620172226.15012-1-ulf.hansson@linaro.org> <CAJZ5v0jah=aiYoV_b_p=-x+puO0sxeGRBCtJnQAD8xb8p1QGfg@mail.gmail.com> <CAPDyKFpatx81aMrbDtaeNPH=FXBYPCHsog3i=a0VN5=Q8if0=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 24, 2018 8:47:21 AM CEST Ulf Hansson wrote:
> On 6 August 2018 at 11:36, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Fri, Aug 3, 2018 at 1:43 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >> On 19 July 2018 at 12:25, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >>> On Wednesday, June 20, 2018 7:22:04 PM CEST Ulf Hansson wrote:
> >>>> To enable a device belonging to a CPU to be attached to a PM domain managed
> >>>> by genpd, let's do a few changes to genpd as to make it convenient to
> >>>> manage the specifics around CPUs.
> >>>>
> >>>> First, as to be able to quickly find out what CPUs that are attached to a
> >>>> genpd, which typically becomes useful from a genpd governor as following
> >>>> changes is about to show, let's add a cpumask 'cpus' to the struct
> >>>> generic_pm_domain.
> >>>>
> >>>> At the point when a device that belongs to a CPU, is attached/detached to
> >>>> its corresponding PM domain via genpd_add_device(), let's update the
> >>>> cpumask in genpd->cpus. Moreover, propagate the update of the cpumask to
> >>>> the master domains, which makes the genpd->cpus to contain a cpumask that
> >>>> hierarchically reflect all CPUs for a genpd, including CPUs attached to
> >>>> subdomains.
> >>>>
> >>>> Second, to unconditionally manage CPUs and the cpumask in genpd->cpus, is
> >>>> unnecessary for cases when only non-CPU devices are parts of a genpd.
> >>>> Let's avoid this by adding a new configuration bit, GENPD_FLAG_CPU_DOMAIN.
> >>>> Clients must set the bit before they call pm_genpd_init(), as to instruct
> >>>> genpd that it shall deal with CPUs and thus manage the cpumask in
> >>>> genpd->cpus.
> >>>>
> >>>> Cc: Lina Iyer <ilina@codeaurora.org>
> >>>> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> >>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >>>> ---
> >>>>  drivers/base/power/domain.c | 69 ++++++++++++++++++++++++++++++++++++-
> >>>>  include/linux/pm_domain.h   |  3 ++
> >>>>  2 files changed, 71 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> >>>> index 21d298e1820b..6149ce0bfa7b 100644
> >>>> --- a/drivers/base/power/domain.c
> >>>> +++ b/drivers/base/power/domain.c
> >>>> @@ -20,6 +20,7 @@
> >>>>  #include <linux/sched.h>
> >>>>  #include <linux/suspend.h>
> >>>>  #include <linux/export.h>
> >>>> +#include <linux/cpu.h>
> >>>>
> >>>>  #include "power.h"
> >>>>
> >>>> @@ -126,6 +127,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
> >>>>  #define genpd_is_irq_safe(genpd)     (genpd->flags & GENPD_FLAG_IRQ_SAFE)
> >>>>  #define genpd_is_always_on(genpd)    (genpd->flags & GENPD_FLAG_ALWAYS_ON)
> >>>>  #define genpd_is_active_wakeup(genpd)        (genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
> >>>> +#define genpd_is_cpu_domain(genpd)   (genpd->flags & GENPD_FLAG_CPU_DOMAIN)
> >>>>
> >>>>  static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
> >>>>               const struct generic_pm_domain *genpd)
> >>>> @@ -1377,6 +1379,62 @@ static void genpd_free_dev_data(struct device *dev,
> >>>>       dev_pm_put_subsys_data(dev);
> >>>>  }
> >>>>
> >>>> +static void __genpd_update_cpumask(struct generic_pm_domain *genpd,
> >>>> +                                int cpu, bool set, unsigned int depth)
> >>>> +{
> >>>> +     struct gpd_link *link;
> >>>> +
> >>>> +     if (!genpd_is_cpu_domain(genpd))
> >>>> +             return;
> >>>> +
> >>>> +     list_for_each_entry(link, &genpd->slave_links, slave_node) {
> >>>> +             struct generic_pm_domain *master = link->master;
> >>>> +
> >>>> +             genpd_lock_nested(master, depth + 1);
> >>>> +             __genpd_update_cpumask(master, cpu, set, depth + 1);
> >>>> +             genpd_unlock(master);
> >>>> +     }
> >>>> +
> >>>> +     if (set)
> >>>> +             cpumask_set_cpu(cpu, genpd->cpus);
> >>>> +     else
> >>>> +             cpumask_clear_cpu(cpu, genpd->cpus);
> >>>> +}
> >>>
> >>> As noted elsewhere, there is a concern about the possible weight of this
> >>> cpumask and I think that it would be good to explicitly put a limit on it.
> >>
> >> I have been digesting your comments on the series, but wonder if this
> >> is still a relevant concern?
> >
> > Well, there are systems with very large cpumasks and it is sort of
> > good to have that in mind when designing any code using them.
> 
> Right.
> 
> So, if I avoid allocating the cpumask for those genpd structures that
> doesn't need it (those not having GENPD_FLAG_CPU_DOMAIN set), would
> that be sufficient to deal with your concern?

Yes, it would, if I understand you correctly.

Thanks,
Rafael

