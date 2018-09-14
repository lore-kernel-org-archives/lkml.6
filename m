Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5551ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BF92147C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BF92147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbeINP6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:58:35 -0400
Received: from foss.arm.com ([217.140.101.70]:59820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727655AbeINP6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:58:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEDED80D;
        Fri, 14 Sep 2018 03:44:39 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.Emea.Arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51F693F557;
        Fri, 14 Sep 2018 03:44:36 -0700 (PDT)
Date:   Fri, 14 Sep 2018 11:44:31 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
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
Message-ID: <20180914104431.GA20567@e107981-ln.cambridge.arm.com>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <CAJZ5v0hX3gC0J_z1tMu-KkNBRf3GuJ91tbFC2Z+0D1BnHkY8kg@mail.gmail.com>
 <20180809153925.GA20329@red-moon>
 <5398488.CyAMIAYSYI@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5398488.CyAMIAYSYI@aspire.rjw.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 11:50:15AM +0200, Rafael J. Wysocki wrote:
> On Thursday, August 9, 2018 5:39:25 PM CEST Lorenzo Pieralisi wrote:
> > On Mon, Aug 06, 2018 at 11:20:59AM +0200, Rafael J. Wysocki wrote:
> > 
> > [...]
> > 
> > > >>> > @@ -245,6 +248,56 @@ static bool always_on_power_down_ok(struct dev_pm_domain *domain)
> > > >>> >     return false;
> > > >>> >  }
> > > >>> >
> > > >>> > +static bool cpu_power_down_ok(struct dev_pm_domain *pd)
> > > >>> > +{
> > > >>> > +   struct generic_pm_domain *genpd = pd_to_genpd(pd);
> > > >>> > +   ktime_t domain_wakeup, cpu_wakeup;
> > > >>> > +   s64 idle_duration_ns;
> > > >>> > +   int cpu, i;
> > > >>> > +
> > > >>> > +   if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
> > > >>> > +           return true;
> > > >>> > +
> > > >>> > +   /*
> > > >>> > +    * Find the next wakeup for any of the online CPUs within the PM domain
> > > >>> > +    * and its subdomains. Note, we only need the genpd->cpus, as it already
> > > >>> > +    * contains a mask of all CPUs from subdomains.
> > > >>> > +    */
> > > >>> > +   domain_wakeup = ktime_set(KTIME_SEC_MAX, 0);
> > > >>> > +   for_each_cpu_and(cpu, genpd->cpus, cpu_online_mask) {
> > > >>> > +           cpu_wakeup = tick_nohz_get_next_wakeup(cpu);
> > > >>> > +           if (ktime_before(cpu_wakeup, domain_wakeup))
> > > >>> > +                   domain_wakeup = cpu_wakeup;
> > > >>> > +   }
> > > >>
> > > >> Here's a concern I have missed before. :-/
> > > >>
> > > >> Say, one of the CPUs you're walking here is woken up in the meantime.
> > > >
> > > > Yes, that can happen - when we miss-predicted "next wakeup".
> > > >
> > > >>
> > > >> I don't think it is valid to evaluate tick_nohz_get_next_wakeup() for it then
> > > >> to update domain_wakeup.  We really should just avoid the domain power off in
> > > >> that case at all IMO.
> > > >
> > > > Correct.
> > > >
> > > > However, we also want to avoid locking contentions in the idle path,
> > > > which is what this boils done to.
> > > 
> > > This already is done under genpd_lock() AFAICS, so I'm not quite sure
> > > what exactly you mean.
> > > 
> > > Besides, this is not just about increased latency, which is a concern
> > > by itself but maybe not so much in all environments, but also about
> > > possibility of missing a CPU wakeup, which is a major issue.
> > > 
> > > If one of the CPUs sharing the domain with the current one is woken up
> > > during cpu_power_down_ok() and the wakeup is an edge-triggered
> > > interrupt and the domain is turned off regardless, the wakeup may be
> > > missed entirely if I'm not mistaken.
> > > 
> > > It looks like there needs to be a way for the hardware to prevent a
> > > domain poweroff when there's a pending interrupt or I don't quite see
> > > how this can be handled correctly.
> > > 
> > > >> Sure enough, if the domain power off is already started and one of the CPUs
> > > >> in the domain is woken up then, too bad, it will suffer the latency (but in
> > > >> that case the hardware should be able to help somewhat), but otherwise CPU
> > > >> wakeup should prevent domain power off from being carried out.
> > > >
> > > > The CPU is not prevented from waking up, as we rely on the FW to deal with that.
> > > >
> > > > Even if the above computation turns out to wrongly suggest that the
> > > > cluster can be powered off, the FW shall together with the genpd
> > > > backend driver prevent it.
> > > 
> > > Fine, but then the solution depends on specific FW/HW behavior, so I'm
> > > not sure how generic it really is.  At least, that expectation should
> > > be clearly documented somewhere, preferably in code comments.
> > > 
> > > > To cover this case for PSCI, we also use a per cpu variable for the
> > > > CPU's power off state, as can be seen later in the series.
> > > 
> > > Oh great, but the generic part should be independent on the underlying
> > > implementation of the driver.  If it isn't, then it also is not
> > > generic.
> > > 
> > > > Hope this clarifies your concern, else tell and will to elaborate a bit more.
> > > 
> > > Not really.
> > > 
> > > There also is one more problem and that is the interaction between
> > > this code and the idle governor.
> > > 
> > > Namely, the idle governor may select a shallower state for some
> > > reason, for example due to an additional latency limit derived from
> > > CPU utilization (like in the menu governor), and how does the code in
> > > cpu_power_down_ok() know what state has been selected and how does it
> > > honor the selection made by the idle governor?
> > 
> > That's a good question and it maybe gives a path towards a solution.
> > 
> > AFAICS the genPD governor only selects the idle state parameter that
> > determines the idle state at, say, GenPD cpumask level it does not touch
> > the CPUidle decision, that works on a subset of idle states (at cpu
> > level).
> 
> I've deferred responding to this as I wasn't quite sure if I followed you
> at that time, but I'm afraid I'm still not following you now. :-)
> 
> The idle governor has to take the total worst-case wakeup latency into
> account.  Not just from the logical CPU itself, but also from whatever
> state the SoC may end up in as a result of this particular logical CPU
> going idle, this way or another.
> 
> So for example, if your logical CPU has an idle state A that may trigger an
> idle state X at the cluster level (if the other logical CPUs happen to be in
> the right states and so on), then the worst-case exit latency for that
> is the one of state X.

I will provide an example:

IDLE STATE A (affects CPU {0,1}): exit latency 1ms, min-residency 1.5ms

CPU 0 is about to enter IDLE state A since its "next-event" fulfill the
residency requirements and exit latency constraints.

CPU 1 is in idle state A (given that CPU 0 is ON, some of the common
logic shared between CPU {0,1} is still ON, but, as soon as CPU 0
enters idle state A CPU {0,1} can enter the "full" idle state A
power savings mode).

The current CPUidle governor does not check the "next-event" for CPU 1,
that it may wake up in, say, 10us.

Requesting IDLE STATE A is a waste of power (if firmware or hardware
does not demote it since it does peek at CPU 1 next-event and actually
demote CPU 0 request).

The current flat list of idle states has no notion of CPUs sharing
an idle state request and that's where I think this series kicks in
and that's the reason I say that the genPD governor can only demote
an idle state request.

Linking power domains to idle states is the only sensible way I see
to define what logical cpus are affected by an idle state entry, this
information is missing in the current kernel (whether that's wortwhile
adding it that's another question).

> > That's my understanding, which can be wrong so please correct me
> > if that's the case because that's a bit confusing.
> > 
> > Let's imagine that we flattened out the list of idle states and feed
> > CPUidle with it (all of them - cpu, cluster, package, system - as it is
> > in the mainline _now_). Then the GenPD governor can run-through the
> > CPUidle selection and _demote_ the idle state if necessary since it
> > understands that some CPUs in the GenPD will wake up shortly and break
> > the target residency hyphothesis the CPUidle governor is expecting.
> > 
> > The whole idea about this series is improving CPUidle decision when
> > the target idle state is _shared_ among groups of cpus (again, please
> > do correct me if I am wrong).
> > 
> > It is obvious that a GenPD governor must only demote - never promote a
> > CPU idle state selection given that hierarchy implies more power
> > savings and higher target residencies required.
> 
> So I see a problem here, because the way patch 9 in this series is done,
> the genpd governor for CPUs has no idea what states have been selected by
> the idle governor, so how does it know how deep it can go with turning
> off domains?
> 
> My point is that the selection made by the idle governor need not be
> based only on timers which is the only thing that the genpd governor
> seems to be looking at.  The genpd governor should rather look at what
> idle states have been selected for each CPU in the domain by the idle
> governor and work within the boundaries of those.

That's agreed.

Lorenzo
