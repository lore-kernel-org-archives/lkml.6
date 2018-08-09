Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB91EC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA2721D68
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA2721D68
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732374AbeHISEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 14:04:50 -0400
Received: from foss.arm.com ([217.140.101.70]:55652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731432AbeHISEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 14:04:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0663B7A9;
        Thu,  9 Aug 2018 08:39:23 -0700 (PDT)
Received: from red-moon (red-moon.emea.arm.com [10.4.13.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A80C3F5B3;
        Thu,  9 Aug 2018 08:39:19 -0700 (PDT)
Date:   Thu, 9 Aug 2018 16:39:25 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v8 07/26] PM / Domains: Add genpd governor for CPUs
Message-ID: <20180809153925.GA20329@red-moon>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <20180620172226.15012-8-ulf.hansson@linaro.org>
 <3574880.GjmnMm1lMq@aspire.rjw.lan>
 <10360149.m4MlxDWZY5@aspire.rjw.lan>
 <CAPDyKFonHYSq32WxvB1x5PXissXZvraqazgU_ZyLR=tsyD9vAA@mail.gmail.com>
 <CAJZ5v0hX3gC0J_z1tMu-KkNBRf3GuJ91tbFC2Z+0D1BnHkY8kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hX3gC0J_z1tMu-KkNBRf3GuJ91tbFC2Z+0D1BnHkY8kg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 11:20:59AM +0200, Rafael J. Wysocki wrote:

[...]

> >>> > @@ -245,6 +248,56 @@ static bool always_on_power_down_ok(struct dev_pm_domain *domain)
> >>> >     return false;
> >>> >  }
> >>> >
> >>> > +static bool cpu_power_down_ok(struct dev_pm_domain *pd)
> >>> > +{
> >>> > +   struct generic_pm_domain *genpd = pd_to_genpd(pd);
> >>> > +   ktime_t domain_wakeup, cpu_wakeup;
> >>> > +   s64 idle_duration_ns;
> >>> > +   int cpu, i;
> >>> > +
> >>> > +   if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
> >>> > +           return true;
> >>> > +
> >>> > +   /*
> >>> > +    * Find the next wakeup for any of the online CPUs within the PM domain
> >>> > +    * and its subdomains. Note, we only need the genpd->cpus, as it already
> >>> > +    * contains a mask of all CPUs from subdomains.
> >>> > +    */
> >>> > +   domain_wakeup = ktime_set(KTIME_SEC_MAX, 0);
> >>> > +   for_each_cpu_and(cpu, genpd->cpus, cpu_online_mask) {
> >>> > +           cpu_wakeup = tick_nohz_get_next_wakeup(cpu);
> >>> > +           if (ktime_before(cpu_wakeup, domain_wakeup))
> >>> > +                   domain_wakeup = cpu_wakeup;
> >>> > +   }
> >>
> >> Here's a concern I have missed before. :-/
> >>
> >> Say, one of the CPUs you're walking here is woken up in the meantime.
> >
> > Yes, that can happen - when we miss-predicted "next wakeup".
> >
> >>
> >> I don't think it is valid to evaluate tick_nohz_get_next_wakeup() for it then
> >> to update domain_wakeup.  We really should just avoid the domain power off in
> >> that case at all IMO.
> >
> > Correct.
> >
> > However, we also want to avoid locking contentions in the idle path,
> > which is what this boils done to.
> 
> This already is done under genpd_lock() AFAICS, so I'm not quite sure
> what exactly you mean.
> 
> Besides, this is not just about increased latency, which is a concern
> by itself but maybe not so much in all environments, but also about
> possibility of missing a CPU wakeup, which is a major issue.
> 
> If one of the CPUs sharing the domain with the current one is woken up
> during cpu_power_down_ok() and the wakeup is an edge-triggered
> interrupt and the domain is turned off regardless, the wakeup may be
> missed entirely if I'm not mistaken.
> 
> It looks like there needs to be a way for the hardware to prevent a
> domain poweroff when there's a pending interrupt or I don't quite see
> how this can be handled correctly.
> 
> >> Sure enough, if the domain power off is already started and one of the CPUs
> >> in the domain is woken up then, too bad, it will suffer the latency (but in
> >> that case the hardware should be able to help somewhat), but otherwise CPU
> >> wakeup should prevent domain power off from being carried out.
> >
> > The CPU is not prevented from waking up, as we rely on the FW to deal with that.
> >
> > Even if the above computation turns out to wrongly suggest that the
> > cluster can be powered off, the FW shall together with the genpd
> > backend driver prevent it.
> 
> Fine, but then the solution depends on specific FW/HW behavior, so I'm
> not sure how generic it really is.  At least, that expectation should
> be clearly documented somewhere, preferably in code comments.
> 
> > To cover this case for PSCI, we also use a per cpu variable for the
> > CPU's power off state, as can be seen later in the series.
> 
> Oh great, but the generic part should be independent on the underlying
> implementation of the driver.  If it isn't, then it also is not
> generic.
> 
> > Hope this clarifies your concern, else tell and will to elaborate a bit more.
> 
> Not really.
> 
> There also is one more problem and that is the interaction between
> this code and the idle governor.
> 
> Namely, the idle governor may select a shallower state for some
> reason, for example due to an additional latency limit derived from
> CPU utilization (like in the menu governor), and how does the code in
> cpu_power_down_ok() know what state has been selected and how does it
> honor the selection made by the idle governor?

That's a good question and it maybe gives a path towards a solution.

AFAICS the genPD governor only selects the idle state parameter that
determines the idle state at, say, GenPD cpumask level it does not touch
the CPUidle decision, that works on a subset of idle states (at cpu
level).

That's my understanding, which can be wrong so please correct me
if that's the case because that's a bit confusing.

Let's imagine that we flattened out the list of idle states and feed
CPUidle with it (all of them - cpu, cluster, package, system - as it is
in the mainline _now_). Then the GenPD governor can run-through the
CPUidle selection and _demote_ the idle state if necessary since it
understands that some CPUs in the GenPD will wake up shortly and break
the target residency hyphothesis the CPUidle governor is expecting.

The whole idea about this series is improving CPUidle decision when
the target idle state is _shared_ among groups of cpus (again, please
do correct me if I am wrong).

It is obvious that a GenPD governor must only demote - never promote a
CPU idle state selection given that hierarchy implies more power
savings and higher target residencies required.

This whole series would become more generic and won't depend on
PSCI OSI at all - actually that would become a hierarchical
CPUidle governor.

I still think that PSCI firmware and most certainly mwait() play the
role the GenPD governor does since they can detect in FW/HW whether
that's worthwhile to switch off a domain, the information is obviously
there and the kernel would just add latency to the idle path in that
case but let's gloss over this for the sake of this discussion.

Lorenzo
