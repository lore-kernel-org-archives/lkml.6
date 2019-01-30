Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C67FC282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD002184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbfA3JMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:12:37 -0500
Received: from foss.arm.com ([217.140.101.70]:50132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730545AbfA3JMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:12:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 018B9A78;
        Wed, 30 Jan 2019 01:12:35 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76AF73F557;
        Wed, 30 Jan 2019 01:12:32 -0800 (PST)
Date:   Wed, 30 Jan 2019 09:12:27 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>, rjw@rjwysocki.net,
        sudeep.holla@arm.com, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH 2/7] cpufreq: dt: Register an Energy Model
Message-ID: <20190130091055.zjj2jrjvi2n3ht66@queper01-lin>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-3-quentin.perret@arm.com>
 <20190128193656.GI81583@google.com>
 <20190129052144.plicqu4vozh3l3ss@vireshk-i7>
 <20190129091546.tfh3lo4w4sosfuba@queper01-lin>
 <20190130051806.fdsos27jaekkwgbs@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130051806.fdsos27jaekkwgbs@vireshk-i7>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On Wednesday 30 Jan 2019 at 10:48:06 (+0530), Viresh Kumar wrote:
> On 29-01-19, 09:15, Quentin Perret wrote:
> > On Tuesday 29 Jan 2019 at 10:51:44 (+0530), Viresh Kumar wrote:
> > > On 28-01-19, 11:36, Matthias Kaehlcke wrote:
> > > > I think this patch will result in error messages at registration on
> > > > platforms that use the cpufreq-dt driver and don't specify
> > > > 'dynamic-power-coefficient' for the CPUs in the DT. Not sure if that's
> > > > a problem as long as the cpufreq initialization succeeds regardless,
> > > > it could be seen as a not-so-gentle nudge to add the values.
> > > 
> > > That wouldn't be acceptable.
> > 
> > Fair enough. What I can propose in this case is to have in PM_OPP a
> > helper called 'dev_pm_opp_of_register_em()' or something like this. This
> > function will check all prerequisites are present (we have the right
> > values in DT, and so on) and then call (or not) em_register_perf_domain().
> > Then we can make the CPUFreq drivers use that instead of calling
> > em_register_perf_domain() directly.
> 
> That should be fine.
> 
> > That would also make it easy to implement Matthias' suggestion to not
> > call em_register_perf_domain() if an EM is already present.
> 
> So you will track registration state within the OPP core for that ?

What I had in mind is something as simple as:

	void of_dev_pm_opp_register_em(struct cpumask *cpus)
	{
		/* Bail out if an EM is there */
		if (em_cpu_get(cpumask_first(cpus)))
			return;

		/* Check prerequisites: dpc coeff in DT, ... */
		...

		em_register_perf_domain(...);
	}

IIUC, Matthias' point was that if the EM is already registered, there is
no good reason to call em_register_perf_domain() again. Now, that should
in fact be harmless because em_register_perf_domain() already does that
check. It's just cleaner and easier to understand from a conceptual
standpoint to not call that function several times for no reason I
assume.

> Sorry but that doesn't sound right. What's wrong with having an
> unregister helper in energy-model to keep proper code flow everywhere
> ?

For the EM we basically allocate the tables in memory once and for all
at boot time and never touch them again. That makes it easy for users
(the scheduler as of now, IPA soon) to access them without messing
around with RCU or so. So there isn't really a concept or unregistering
a pd right now.

Thanks,
Quentin
