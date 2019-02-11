Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E521AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEC121B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfBKOIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:08:39 -0500
Received: from foss.arm.com ([217.140.101.70]:49224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727327AbfBKOIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:08:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3090A78;
        Mon, 11 Feb 2019 06:08:37 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F122F3F557;
        Mon, 11 Feb 2019 06:08:35 -0800 (PST)
Date:   Mon, 11 Feb 2019 14:08:29 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
Message-ID: <20190211140829.GA4269@e107155-lin>
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
 <20190207122227.19873-1-m.szyprowski@samsung.com>
 <20190208110053.GA7913@e107155-lin>
 <87302853-74cc-8eeb-6bd4-6338746e0738@samsung.com>
 <20190208115122.GA13043@e107155-lin>
 <66b33c07-4970-b60a-d924-d4baba79c836@samsung.com>
 <20190208174131.GB22401@e107155-lin>
 <20190211084714.nq3wqxk66dbrfqvy@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211084714.nq3wqxk66dbrfqvy@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 02:17:14PM +0530, Viresh Kumar wrote:
> On 08-02-19, 17:41, Sudeep Holla wrote:
> > Based on Rafael's suggestion, I cooked up something. See if this helps ?
> > The policy to cpu dance can be removed and we can just run through the
> > online cpumask I think.
> >
> > Regards,
> > Sudeep
> >
> > -->8
> >
> > diff --git i/drivers/cpufreq/cpufreq.c w/drivers/cpufreq/cpufreq.c
> > index e35a886e00bc..03d65a02a542 100644
> > --- i/drivers/cpufreq/cpufreq.c
> > +++ w/drivers/cpufreq/cpufreq.c
> > @@ -1640,6 +1640,7 @@ EXPORT_SYMBOL(cpufreq_generic_suspend);
> >  void cpufreq_suspend(void)
> >  {
> >  	struct cpufreq_policy *policy;
> > +	int cpu;
> >
> >  	if (!cpufreq_driver)
> >  		return;
> > @@ -1662,6 +1663,11 @@ void cpufreq_suspend(void)
> >  	}
> >
> >  suspend:
> > +	if (cpufreq_driver->flags & CPUFREQ_DEFER_INIT_DURING_RESUME)
> > +		for_each_active_policy(policy)
> > +			for_each_cpu(cpu, policy->cpus)
> > +				cpufreq_offline(cpu);
>
> You will offline boot-cpu as well :)
>

Indeed, I was just trying to check the idea of flags and clearly missed
the boot cpu :(


[..]

> > @@ -2444,14 +2455,16 @@ static enum cpuhp_state hp_online;
> >
> >  static int cpuhp_cpufreq_online(unsigned int cpu)
> >  {
> > -	cpufreq_online(cpu);
> > +	if (!(cpufreq_driver->flags & CPUFREQ_DEFER_INIT_DURING_RESUME))
> > +		cpufreq_online(cpu);
>
> This isn't correct as we can offline the CPUs without suspend as well
> and cpufreq_online/offline should always be called in such cases.
>

Understood

> Anyways, I have cc'd you on another series which may end up fixing
> this problem as well.

Sure, will have a look.

--
Regards,
Sudeep
