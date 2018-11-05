Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9A2C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CCC2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CCC2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbeKFATI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:19:08 -0500
Received: from foss.arm.com ([217.140.101.70]:45428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbeKFATI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:19:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22833A78;
        Mon,  5 Nov 2018 06:59:02 -0800 (PST)
Received: from e105550-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 339C13F5CF;
        Mon,  5 Nov 2018 06:59:00 -0800 (PST)
Date:   Mon, 5 Nov 2018 14:58:54 +0000
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        pkondeti@codeaurora.org
Subject: Re: [PATCH v5 2/2] sched/fair: update scale invariance of PELT
Message-ID: <20181105145854.GA6401@e105550-lin.cambridge.arm.com>
References: <1540570303-6097-1-git-send-email-vincent.guittot@linaro.org>
 <1540570303-6097-3-git-send-email-vincent.guittot@linaro.org>
 <b89b6805-45c0-8462-b75b-b7da4a35c022@arm.com>
 <CAKfTPtBapA3JvbgUyESzE=2ZXOGLRLmZh7oi8N=H9PHubCCuNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBapA3JvbgUyESzE=2ZXOGLRLmZh7oi8N=H9PHubCCuNg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 10:10:34AM +0100, Vincent Guittot wrote:
> On Fri, 2 Nov 2018 at 16:36, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >
> > On 10/26/18 6:11 PM, Vincent Guittot wrote:
> > > The current implementation of load tracking invariance scales the
> > > contribution with current frequency and uarch performance (only for
> > > utilization) of the CPU. One main result of this formula is that the
> > > figures are capped by current capacity of CPU. Another one is that the
> > > load_avg is not invariant because not scaled with uarch.
> > >
> > > The util_avg of a periodic task that runs r time slots every p time slots
> > > varies in the range :
> > >
> > >      U * (1-y^r)/(1-y^p) * y^i < Utilization < U * (1-y^r)/(1-y^p)
> > >
> > > with U is the max util_avg value = SCHED_CAPACITY_SCALE
> > >
> > > At a lower capacity, the range becomes:
> > >
> > >      U * C * (1-y^r')/(1-y^p) * y^i' < Utilization <  U * C * (1-y^r')/(1-y^p)
> > >
> > > with C reflecting the compute capacity ratio between current capacity and
> > > max capacity.
> > >
> > > so C tries to compensate changes in (1-y^r') but it can't be accurate.
> > >
> > > Instead of scaling the contribution value of PELT algo, we should scale the
> > > running time. The PELT signal aims to track the amount of computation of
> > > tasks and/or rq so it seems more correct to scale the running time to
> > > reflect the effective amount of computation done since the last update.
> > >
> > > In order to be fully invariant, we need to apply the same amount of
> > > running time and idle time whatever the current capacity. Because running
> > > at lower capacity implies that the task will run longer, we have to ensure
> > > that the same amount of idle time will be apply when system becomes idle
> > > and no idle time has been "stolen". But reaching the maximum utilization
> > > value (SCHED_CAPACITY_SCALE) means that the task is seen as an
> > > always-running task whatever the capacity of the CPU (even at max compute
> > > capacity). In this case, we can discard this "stolen" idle times which
> > > becomes meaningless.
> > >
> > > In order to achieve this time scaling, a new clock_pelt is created per rq.
> > > The increase of this clock scales with current capacity when something
> > > is running on rq and synchronizes with clock_task when rq is idle. With
> > > this mecanism, we ensure the same running and idle time whatever the
> > > current capacity.
> >
> > Thinking about this new approach on a big.LITTLE platform:
> >
> > CPU Capacities big: 1024 LITTLE: 512, performance CPUfreq governor
> >
> > A 50% (runtime/period) task on a big CPU will become an always running
> > task on the little CPU. The utilization signal of the task and the
> > cfs_rq of the little CPU converges to 1024.
> >
> > With contrib scaling the utilization signal of the 50% task converges to
> > 512 on the little CPU, even it is always running on it, and so does the
> > one of the cfs_rq.
> >
> > Two 25% tasks on a big CPU will become two 50% tasks on a little CPU.
> > The utilization signal of the tasks converges to 512 and the one of the
> > cfs_rq of the little CPU converges to 1024.
> >
> > With contrib scaling the utilization signal of the 25% tasks converges
> > to 256 on the little CPU, even they run each 50% on it, and the one of
> > the cfs_rq converges to 512.
> >
> > So what do we consider system-wide invariance? I thought that e.g. a 25%
> > task should have a utilization value of 256 no matter on which CPU it is
> > running?
> >
> > In both cases, the little CPU is not going idle whereas the big CPU does.
> 
> IMO, the key point here is that there is no idle time. As soon as
> there is no idle time, you don't know if a task has enough compute
> capacity so you can't make difference between the 50% running task or
> an always running task on the little core.
> That's also interesting to noticed that the task will reach the always
> running state after more than 600ms on little core with utilization
> starting from 0.
> 
> Then considering the system-wide invariance, the task are not really
> invariant. If we take a 50% running task that run 40ms in a period of
> 80ms, the max utilization of the task will be 721 on the big core and
> 512 on the little core.
> Then, if you take a 39ms running task instead, the utilization on the
> big core will reach 709 but it will be 507 on little core. So your
> utilization depends on the current capacity
> With the new proposal, the max utilization will be 709 on big and
> little cores for the 39ms running task. For the 40ms running task, the
> utilization will be 721 on big core. then if the task moves on the
> little, it will reach the value 721 after 80ms,  then 900 after more
> than 160ms and 1000 after 320ms

It has always been debatable what to do with utilization when there are
no spare cycles.

In Dietmar's example where two 25% tasks are put on a 512 (50%) capacity
CPU we add just enough utilization to have no spare cycles left. One
could argue that 25% is still the correct utilization for those tasks.
However, we only know their true utilization because they just ran
unconstrained on a higher capacity CPU. Once they are on the 512 capacity
CPU we wouldn't know if the tasks grew in utilization as there are no
spare cycles to use.

As I see it, the most fundamental difference between scaling
contribution and time for PELT is the characteristics when CPUs are
over-utilized.

With contribution scaling the PELT utilization of a task is a _minimum_
utilization. Regardless of where the task is currently/was running (and
provided that it doesn't change behaviour) its PELT utilization will
approximate its _minimum_ utilization on an idle 1024 capacity CPU.

With time scaling the PELT utilization doesn't really have a meaning on
its own. It has to be compared to the capacity of the CPU where it
is/was running to know what the its current PELT utilization means. When
the utilization over-shoots the capacity its value is no longer
represents utilization, it just means that it has a higher compute
demand than is offered on its current CPU and a high value means that it
has been suffering longer. It can't be used to predict the actual
utilization on an idle 1024 capacity any better than contribution scaled
PELT utilization.

This change might not be a showstopper, but it is something to be aware
off and take into account wherever PELT utilization is used.

Morten
