Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AD1C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E18C20854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfAVSSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:18:38 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58604 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfAVSSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:18:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 342B3A78;
        Tue, 22 Jan 2019 10:18:37 -0800 (PST)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F24D3F6A8;
        Tue, 22 Jan 2019 10:18:34 -0800 (PST)
Date:   Tue, 22 Jan 2019 18:18:31 +0000
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
Message-ID: <20190122181831.a4w65qcivx4hua6d@e110439-lin>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-9-patrick.bellasi@arm.com>
 <20190122171314.GS27931@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122171314.GS27931@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-Jan 18:13, Peter Zijlstra wrote:
> On Tue, Jan 15, 2019 at 10:15:05AM +0000, Patrick Bellasi wrote:
> > @@ -342,11 +350,24 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
> >  		return;
> >  	sg_cpu->iowait_boost_pending = true;
> >  
> > +	/*
> > +	 * Boost FAIR tasks only up to the CPU clamped utilization.
> > +	 *
> > +	 * Since DL tasks have a much more advanced bandwidth control, it's
> > +	 * safe to assume that IO boost does not apply to those tasks.
> 
> I'm not buying that argument. IO-boost isn't related to b/w management.
> 
> IO-boot is more about compensating for hidden dependencies, and those
> don't get less hidden for using a different scheduling class.
> 
> Now, arguably DL should not be doing IO in the first place, but that's a
> whole different discussion.

My understanding is that IOBoost is there to help tasks doing many
and _frequent_ IO operations, which are relatively _not so much_
computational intensive on the CPU.

Those tasks generate a small utilization and, without IOBoost, will be
executed at a lower frequency and will add undesired latency on
triggering the next IO operation.

Isn't mainly that the reason for it?

IO operations have also to be _frequent_ since we don't got to max OPP
at the very first wakeup from IO. We double frequency and get to max
only if we have a stable stream of IO operations.

IMHO, it makes perfectly sense to use DL for these kind of operations
but I would expect that, since you care about latency we should come
up with a proper description of the required bandwidth... eventually
accounting for an additional headroom to compensate for "hidden
dependencies"... without relaying on a quite dummy policy like
IOBoost to get our DL tasks working.

At the end, DL is now quite good in driving the freq as high has it
needs... and by closing userspace feedback loops it can also
compensate for all sort of fluctuations and noise... as demonstrated
by Alessio during last OSPM:

   http://retis.sssup.it/luca/ospm-summit/2018/Downloads/OSPM_deadline_audio.pdf

> > +	 * Instead, since RT tasks are not utilization clamped, we don't want
> > +	 * to apply clamping on IO boost while there is blocked RT
> > +	 * utilization.
> > +	 */
> > +	max_boost = sg_cpu->iowait_boost_max;
> > +	if (!cpu_util_rt(cpu_rq(sg_cpu->cpu)))
> > +		max_boost = uclamp_util(cpu_rq(sg_cpu->cpu), max_boost);
> > +
> >  	/* Double the boost at each request */
> >  	if (sg_cpu->iowait_boost) {
> >  		sg_cpu->iowait_boost <<= 1;
> > -		if (sg_cpu->iowait_boost > sg_cpu->iowait_boost_max)
> > -			sg_cpu->iowait_boost = sg_cpu->iowait_boost_max;
> > +		if (sg_cpu->iowait_boost > max_boost)
> > +			sg_cpu->iowait_boost = max_boost;
> >  		return;
> >  	}
> 
> Hurmph...  so I'm not sold on this bit.

If a task is not clamped we execute it at its required utilization or
even max frequency in case of wakeup from IO.

When a task is util_max clamped instead, we are saying that we don't
care to run it above the specified clamp value and, if possible, we
should run it below that capacity level.

If that's the case, why this clamping hints should not be enforced on
IO wakeups too?

At the end it's still a user-space decision, we basically allow
userspace to defined what's the max IO boost they like to get.

-- 
#include <best/regards.h>

Patrick Bellasi
