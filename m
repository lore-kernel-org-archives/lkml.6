Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C59C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2AF02086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2AF02086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbeK0V5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:57:43 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33532 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbeK0V5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:57:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97BD332F4;
        Tue, 27 Nov 2018 03:00:11 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA22F3F575;
        Tue, 27 Nov 2018 03:00:09 -0800 (PST)
Date:   Tue, 27 Nov 2018 11:00:02 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, tkjos@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        Dietmar.Eggemann@arm.com
Subject: Re: [RFC][PATCH 2/2] sched: Enqueue tasks on a cpu with only
 SCHED_IDLE tasks
Message-ID: <20181127110000.wpkfv7uv4z3lowrl@queper01-lin>
References: <cover.1543229820.git.viresh.kumar@linaro.org>
 <71a578a0c5b39169fe74ad378ee41eaf546844ac.1543229820.git.viresh.kumar@linaro.org>
 <20181126123738.mrjlykxhohttbef2@queper01-ThinkPad-T460s>
 <20181127102442.er4b6ita6ux6ipdq@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127102442.er4b6ita6ux6ipdq@vireshk-i7>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On Tuesday 27 Nov 2018 at 15:54:42 (+0530), Viresh Kumar wrote:
> Hi Quentin,
> 
> On 26-11-18, 12:37, Quentin Perret wrote:
> > On Monday 26 Nov 2018 at 16:50:24 (+0530), Viresh Kumar wrote:
> > > The scheduler tries to schedule a newly wakeup task on an idle CPU to
> > > make sure the new task gets chance to run as soon as possible, for
> > > performance reasons.
> > > 
> > > The SCHED_IDLE scheduling policy is used for tasks which have the lowest
> > > priority and there is no hurry in running them. If all the tasks
> > > currently enqueued on a CPU have their policy set to SCHED_IDLE, then
> > > any new task (non SCHED_IDLE) enqueued on that CPU should normally get a
> > > chance to run immediately. This patch takes advantage of this to save
> > > power in some cases by avoiding waking up an idle CPU (which may be in
> > > some deep idle state) and enqueuing the new task on a CPU which only has
> > > SCHED_IDLE tasks.
> > 
> > So, avoiding to wake-up a CPU isn't always good for energy. You may
> > prefer to spread tasks in order to keep the OPP low, for example. What
> > you're trying to achieve here can be actively harmful for both energy
> > and performance in some cases, I think.
> 
> Yeah, we may end up packing SCHED_IDLE tasks to a single CPU in this case.
> 
> We know that dynamic energy is significantly more than static energy and that is
> what we should care more about. Yes, higher OPP should be avoided (apart from
> performance reasons), but isn't it better (for power) to run a single CPU at
> somewhat higher OPP (1GHz ?) instead of running four of them at lower OPPs (500
> MHz) ?

I guess that really depends on your platform (which is why EAS is using
an Energy Model BTW, it's pretty hard to find one heuristic that works
well for all topologies out there). But your example is a bit unfair I
think. You should compare 1 CPU at 1GHz vs 4 CPUs at 250MHz. Otherwise
you're not resourcing the tasks adequately in one of the cases.

> 
> > Also, packing will reduce your chances to go cluster idle (yes you're
> > not guaranteed to go cluster idle either if you spread depending how
> > the tasks align in time, but at least there's a chance). So, even from
> > the idle perspective it's not obvious we actually want to do that.
> 
> But do we really want to fire all CPUs of a cluster to finish the work earlier
> and go cluster idle ? We don't really believe in race-to-idle as that's why we
> have the whole DVFS thing here, right ?

Right, I'm certainly not advocating for a race-to-idle policy here. What
I'm saying is that, if you can avoid to raise the OPP by spreading, it's
often a good thing from an energy standpoint, because as you said the
dynamic energy is generally the most expensive part. But even if you can
pack the tasks on a single CPU without having to raise the OPP, it's not
obvious this is the right thing to do either since that will prevent you
from going cluster idle (or reduce the time you _could_ spend cluster
idle at least).

That kind of packing vs spreading energy assessment is really hard to
do in general, especially without knowing the costs of running at
different idle states.

> > And finally, the placement that this patch tries to achieve is
> > inherently unbalanced IIUC. So, unless you hide this behind the EAS
> > static key, you'll need to make sure the periodic/idle load balance code
> > doesn't kill all the work you do in the wake-up path. So I'm not sure
> > this patch really works in practice in its current state.
> 
> True, I intentionally left the load-balancer code as is to avoid larger diff for
> now. The idea was to get more feedback on the whole thing before investing too
> much on it.

OK I see :-)

> 
> > Now, I think you have a point by saying we could possibly be a bit
> > smarter with the way we deal with SCHED_IDLE tasks, especially if they
> > are going to be used more (is that a certainty BTW ?), I'm just not
> > entirely convinced with the 'power' argument yet.
> 
> Todd confirmed earlier (privately) that most (?) of the android background tasks
> can actually be migrated to use SCHED_IDLE stuff as there is no urgency in
> scheduling them normally.

Ah, that's interesting ... If there are tasks in Android that we really
don't care about (that is it's actually fine to starve them), then maybe
we should put those in SCHED_IDLE indeed ... That'll leave the stage for
the other tasks that do have stronger requirements.

So yeah, I agree it's worth investigating.

> @Todd, can you please provide some inputs here as well ?
> 
> > Maybe there is something we could do if, say we need to schedule a
> > SCHED_NORMAL task and all CPUs have roughly the same load and/or
> > utilization numbers, then if a CPU is busy running SCHED_IDLE tasks we
> > should select it in priority since we know for a fact it's not running
> > anything important.
> > 
> > What do you think ?
> 
> Sure, I am not saying that the approach taken by this patch is the best or the
> worst. We need to come up with better policy on how we can benefit from the
> SCHED_IDLE policy and that's where I am looking for inputs from all of you.

Right so my overall advice would be to try an avoid to hard-code a pure
packing heuristic like that (unless you have loads of numbers to backup
the idea and show it works well), but perhaps to use the policy of the
tasks to try and break the tie between CPU candidates that cannot be
differentiated otherwise because the other metrics (load / utilization)
are roughly equivalent).

We really ought to make sure, however, that we have a strong use case
for SCHED_IDLE tasks in Android or elsewhere first before adding any
kind infrastructure for it.

Anyways, just my two cents ...

> Thanks for the feedback.

I hope that's useful :-)

Thanks,
Quentin
