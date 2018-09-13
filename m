Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA81ECDFD1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92ADC20866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92ADC20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbeIMUrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:47:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50274 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbeIMUrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:47:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C9D97A9;
        Thu, 13 Sep 2018 08:37:34 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.emea.arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC3C33F557;
        Thu, 13 Sep 2018 08:37:30 -0700 (PDT)
Date:   Thu, 13 Sep 2018 16:37:27 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
Message-ID: <20180913153727.GB6199@e107981-ln.cambridge.arm.com>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <20180620172226.15012-8-ulf.hansson@linaro.org>
 <3574880.GjmnMm1lMq@aspire.rjw.lan>
 <10360149.m4MlxDWZY5@aspire.rjw.lan>
 <CAPDyKFonHYSq32WxvB1x5PXissXZvraqazgU_ZyLR=tsyD9vAA@mail.gmail.com>
 <CAJZ5v0hX3gC0J_z1tMu-KkNBRf3GuJ91tbFC2Z+0D1BnHkY8kg@mail.gmail.com>
 <20180809153925.GA20329@red-moon>
 <CAPDyKFp=AuqEPHKYgi-+DAhejQZSHixmtLORj_Rkn3m8fUoqJw@mail.gmail.com>
 <20180824103828.GA11491@red-moon>
 <CAPDyKFqDHeMwyJ3Xx1kJcj968s=__3juR5bPn-d_3w=bzo-ovA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqDHeMwyJ3Xx1kJcj968s=__3juR5bPn-d_3w=bzo-ovA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 03:36:02PM +0200, Ulf Hansson wrote:
> On 24 August 2018 at 12:38, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> > On Fri, Aug 24, 2018 at 11:26:19AM +0200, Ulf Hansson wrote:
> >
> > [...]
> >
> >> > That's a good question and it maybe gives a path towards a solution.
> >> >
> >> > AFAICS the genPD governor only selects the idle state parameter that
> >> > determines the idle state at, say, GenPD cpumask level it does not touch
> >> > the CPUidle decision, that works on a subset of idle states (at cpu
> >> > level).
> >> >
> >> > That's my understanding, which can be wrong so please correct me
> >> > if that's the case because that's a bit confusing.
> >> >
> >> > Let's imagine that we flattened out the list of idle states and feed
> >> > CPUidle with it (all of them - cpu, cluster, package, system - as it is
> >> > in the mainline _now_). Then the GenPD governor can run-through the
> >> > CPUidle selection and _demote_ the idle state if necessary since it
> >> > understands that some CPUs in the GenPD will wake up shortly and break
> >> > the target residency hyphothesis the CPUidle governor is expecting.
> >> >
> >> > The whole idea about this series is improving CPUidle decision when
> >> > the target idle state is _shared_ among groups of cpus (again, please
> >> > do correct me if I am wrong).
> >>
> >> Absolutely, this is one of the main reason for the series!
> >>
> >> >
> >> > It is obvious that a GenPD governor must only demote - never promote a
> >> > CPU idle state selection given that hierarchy implies more power
> >> > savings and higher target residencies required.
> >>
> >> Absolutely. I apologize if I have been using the word "promote"
> >> wrongly, I realize it may be a bit confusing.
> >>
> >> >
> >> > This whole series would become more generic and won't depend on
> >> > PSCI OSI at all - actually that would become a hierarchical
> >> > CPUidle governor.
> >>
> >> Well, to me we need a first user of the new infrastructure code in
> >> genpd and PSCI is probably the easiest one to start with. An option
> >> would be to start with an old ARM32 platform, but it seems a bit silly
> >> to me.
> >
> > If the code can be structured as described above as a hierarchical
> > (possibly optional through a Kconfig entry or sysfs tuning) idle
> > decision you can apply it to _any_ PSCI based platform out there,
> > provided that the new governor improves power savings.
> >
> >> In regards to OS-initiated mode vs platform coordinated mode, let's
> >> discuss that in details in the other email thread instead.
> >
> > I think that's crystal clear by now that IMHO PSCI OS-initiated mode is
> > a red-herring, it has nothing to do with this series, it is there just
> > because QC firmware does not support PSCI platform coordinated suspend
> > mode.
> 
> I fully agree that the series isn't specific to PSCI OSI mode. On the
> other hand, for PSCI OSI mode, that's where I see this series to fit
> naturally. And in particular for the QCOM 410c board.
> 
> When it comes to the PSCI PC mode, it may under certain circumstances
> be useful to deploy this approach for that as well, and I agree that
> it seems reasonable to have that configurable as opt-in, somehow.
> 
> Although, let's discuss that separately, in a next step. Or at least
> let's try to keep PSCI related technical discussions to the other
> thread, as that makes it easier to follow.
> 
> >
> > You can apply the concept in this series to _any_ arch provided
> > the power domains representation is correct (and again, I would sound
> > like a broken record but the series must improve power savings over
> > vanilla CPUidle menu governor).
> 
> I agree, but let me elaborate a bit, to hopefully add some clarity,
> which I may not have been able to communicate earlier.
> 
> The goal with the series is to enable platforms to support all its
> available idlestates, which are shared among a group of CPUs. This is
> the case for QCOM 410c, for example.
> 
> To my knowledge, we have other ARM32 based platforms that currently
> have disabled some of its cluster idle states. That's because they
> can't know when it's safe to power off the cluster "coherency domain",
> in cases when the platform also have other shared resources in it.
> 
> The point is, to see improved power savings, additional platform
> deployment may be needed and that just takes time. For example runtime
> PM support is needed in those drivers that deals with the "shared
> resources", a correctly modeled PM domain topology using genpd, etc,
> etc.
> 
> >
> >> > I still think that PSCI firmware and most certainly mwait() play the
> >> > role the GenPD governor does since they can detect in FW/HW whether
> >> > that's worthwhile to switch off a domain, the information is obviously
> >> > there and the kernel would just add latency to the idle path in that
> >> > case but let's gloss over this for the sake of this discussion.
> >>
> >> Yep, let's discuss that separately.
> >>
> >> That said, can I interpret your comments on the series up until this
> >> change, that you seems rather happy with where the series is going?
> >
> > It is something we have been discussing with Daniel since generic idle
> > was merged for Arm a long while back. I have nothing against describing
> > idle states with power domains but it must improve idle decisions
> > against the mainline. As I said before, runtime PM can also be used
> > to get rid of CPU PM notifiers (because with power domains we KNOW
> > what devices eg PMU are switched off on idle entry, we do not guess
> > any longer; replacing CPU PM notifiers is challenging and can be
> > tackled - if required - in a different series).
> 
> Yes, we have be talking about the CPU PM and CPU_CLUSTER_PM notifiers
> and I fully agree. It's something that we should look into and in
> future steps.
> 
> >
> > Bottom line (talk is cheap, I know and apologise about that): this
> > series (up until this change) adds complexity to the idle path and lots
> > of code; if its usage is made optional and can be switched on on systems
> > where it saves power that's fine by me as long as we keep PSCI
> > OS-initiated idle states out of the equation, that's an orthogonal
> > discussion as, I hope, I managed to convey.
> >
> > Thanks,
> > Lorenzo
> 
> Lorenzo, thanks for your feedback!
> 
> Please, when you have time, could you also reply to the other thread
> we started, I would like to understand how I should proceed with this
> series.

OK, thanks, I will, sorry for the delay in responding.

Lorenzo
