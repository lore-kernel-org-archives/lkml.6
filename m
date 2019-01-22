Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57048C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3167220844
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbfAVPpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:45:33 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56334 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729127AbfAVPpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:45:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D405A1596;
        Tue, 22 Jan 2019 07:45:29 -0800 (PST)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF84B3F589;
        Tue, 22 Jan 2019 07:45:26 -0800 (PST)
Date:   Tue, 22 Jan 2019 15:45:24 +0000
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v6 08/16] sched/cpufreq: uclamp: Add utilization clamping
 for FAIR tasks
Message-ID: <20190122154524.64c6yawmutig35zo@e110439-lin>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-9-patrick.bellasi@arm.com>
 <20190122152132.GR27931@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122152132.GR27931@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-Jan 16:21, Peter Zijlstra wrote:
> On Tue, Jan 15, 2019 at 10:15:05AM +0000, Patrick Bellasi wrote:
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -218,8 +218,15 @@ unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
> >  	 * CFS tasks and we use the same metric to track the effective
> >  	 * utilization (PELT windows are synchronized) we can directly add them
> >  	 * to obtain the CPU's actual utilization.
> > +	 *
> > +	 * CFS utilization can be boosted or capped, depending on utilization
> > +	 * clamp constraints requested by currently RUNNABLE tasks.
> > +	 * When there are no CFS RUNNABLE tasks, clamps are released and
> > +	 * frequency will be gracefully reduced with the utilization decay.
> >  	 */
> > -	util = util_cfs;
> > +	util = (type == ENERGY_UTIL)
> > +		? util_cfs
> > +		: uclamp_util(rq, util_cfs);
> 
> That's pretty horrible; what's wrong with:
> 
> 	util = util_cfs;
> 	if (type == FREQUENCY_UTIL)
> 		util = uclamp_util(rq, util);
> 
> That should generate the same code, but is (IMO) far easier to read.

Yes, right... and that's also the pattern we end up with the
following patch on RT integration.

However, as suggested by Rafael, I'll squash these two patches
together and we will get rid of the above for free ;)

> >  	util += cpu_util_rt(rq);
> >  
> >  	dl_util = cpu_util_dl(rq);

-- 
#include <best/regards.h>

Patrick Bellasi
