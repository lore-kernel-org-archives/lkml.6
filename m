Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B50CC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F9E20833
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbfA3KUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:20:50 -0500
Received: from foss.arm.com ([217.140.101.70]:51664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbfA3KUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:20:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 402E5A78;
        Wed, 30 Jan 2019 02:20:49 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2B083F71E;
        Wed, 30 Jan 2019 02:20:46 -0800 (PST)
Date:   Wed, 30 Jan 2019 10:20:45 +0000
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
Message-ID: <20190130102042.uwxpsep5vmeq4h62@queper01-lin>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-3-quentin.perret@arm.com>
 <20190128193656.GI81583@google.com>
 <20190129052144.plicqu4vozh3l3ss@vireshk-i7>
 <20190129091546.tfh3lo4w4sosfuba@queper01-lin>
 <20190130051806.fdsos27jaekkwgbs@vireshk-i7>
 <20190130091055.zjj2jrjvi2n3ht66@queper01-lin>
 <20190130101715.nz2bpqnust7gv4at@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130101715.nz2bpqnust7gv4at@vireshk-i7>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 Jan 2019 at 15:47:15 (+0530), Viresh Kumar wrote:
> On 30-01-19, 09:12, Quentin Perret wrote:
> > What I had in mind is something as simple as:
> > 
> > 	void of_dev_pm_opp_register_em(struct cpumask *cpus)
> > 	{
> > 		/* Bail out if an EM is there */
> > 		if (em_cpu_get(cpumask_first(cpus)))
> > 			return;
> > 
> > 		/* Check prerequisites: dpc coeff in DT, ... */
> > 		...
> > 
> > 		em_register_perf_domain(...);
> > 	}
> > 
> > IIUC, Matthias' point was that if the EM is already registered, there is
> > no good reason to call em_register_perf_domain() again. Now, that should
> > in fact be harmless because em_register_perf_domain() already does that
> > check. It's just cleaner and easier to understand from a conceptual
> > standpoint to not call that function several times for no reason I
> > assume.
> 
> If there is no good reason to call em_register_perf_domain() several
> times, then the same applies to of_dev_pm_opp_register_em() as well,
> isn't it ?

Hrmpf, that is true ... :-)

> This is init code anyway isn't going to run a lot, so I wouldn't
> suggest adding any such (duplicate) checks in
> of_dev_pm_opp_register_em().

Fair enough, I'll post a v2 w/o the check and we'll see if others have
complaints.

Thanks,
Quentin
