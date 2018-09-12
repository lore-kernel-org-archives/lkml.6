Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21380C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E0D20854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E0D20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeILWky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:40:54 -0400
Received: from foss.arm.com ([217.140.101.70]:36516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbeILWkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:40:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B8BF7A9;
        Wed, 12 Sep 2018 10:35:21 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BFDA3F557;
        Wed, 12 Sep 2018 10:35:18 -0700 (PDT)
Date:   Wed, 12 Sep 2018 18:35:15 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 02/16] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Message-ID: <20180912173515.GH1413@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-3-patrick.bellasi@arm.com>
 <20180912134945.GZ24106@hirez.programming.kicks-ass.net>
 <20180912155619.GG1413@e110439-lin>
 <20180912161218.GW24082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912161218.GW24082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-Sep 18:12, Peter Zijlstra wrote:
> On Wed, Sep 12, 2018 at 04:56:19PM +0100, Patrick Bellasi wrote:
> > On 12-Sep 15:49, Peter Zijlstra wrote:
> > > On Tue, Aug 28, 2018 at 02:53:10PM +0100, Patrick Bellasi wrote:
> 
> > > > +/**
> > > > + * uclamp_map: reference counts a utilization "clamp value"
> > > > + * @value:    the utilization "clamp value" required
> > > > + * @se_count: the number of scheduling entities requiring the "clamp value"
> > > > + * @se_lock:  serialize reference count updates by protecting se_count
> > > 
> > > Why do you have a spinlock to serialize a single value? Don't we have
> > > atomics for that?
> > 
> > There are some code paths where it's used to protect clamp groups
> > mapping and initialization, e.g.
> > 
> >       uclamp_group_get()
> >           spin_lock()
> >               // initialize clamp group (if required) and then...
                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
               This is actually a couple of function calls

> >               se_count += 1
> >           spin_unlock()
> > 
> > Almost all these paths are triggered from user-space and protected
> > by a global uclamp_mutex, but fork/exit paths.
> > 
> > To serialize these paths I'm using the spinlock above, does it make
> > sense ? Can we use the global uclamp_mutex on forks/exit too ?
> 
> OK, then your comment is misleading; it serializes both fields.

Yes... that definitively needs an update.

> > One additional observations is that, if in the future we want to add a
> > kernel space API, (e.g. driver asking for a new clamp value), maybe we
> > will need to have a serialized non-sleeping uclamp_group_get() API ?
> 
> No idea; but if you want to go all fancy you can replace he whole
> uclamp_map thing with something like:
> 
> struct uclamp_map {
> 	union {
> 		struct {
> 			unsigned long v : 10;
> 			unsigned long c : BITS_PER_LONG - 10;
> 		};
> 		atomic_long_t s;
> 	};
> };

That sounds really cool and scary at the same time :)

The v:10 requires that we never set SCHED_CAPACITY_SCALE>1024
or that we use it to track a percentage value (i.e. [0..100]).

One of the last patches introduces percentage values to userspace.
But, I was considering that in kernel space we should always track
full scale utilization values.

The c:(BITS_PER_LONG-10) restricts the range of concurrently active
SE refcounting the same clamp value. Which, for some 32bit systems is
only 4 milions among tasks and cgroups... maybe still reasonable...


> And use uclamp_map::c == 0 as unused (as per normal refcount
> semantics) and atomic_long_cmpxchg() the whole thing using
> uclamp_map::s.

Yes... that could work for the uclamp_map updates, but as I noted
above, I think I have other calls serialized by that lock... will look
better into what you suggest, thanks!


[...]

> > > What's the purpose of that cacheline align statement?
> > 
> > In uclamp_maps, we still need to scan the array when a clamp value is
> > changed from user-space, i.e. the cases reported above. Thus, that
> > alignment is just to ensure that we minimize the number of cache lines
> > used. Does that make sense ?
> > 
> > Maybe that alignment implicitly generated by the compiler ?
> 
> It is not, but if it really is a slow path, we shouldn't care about
> alignment.

Ok, will remove it.

> > > Note that without that apparently superfluous lock, it would be 8*12 =
> > > 96 bytes, which is 1.5 lines and would indeed suggest you default to
> > > GROUP_COUNT=7 by default to fill 2 lines.
> > 
> > Yes, will check better if we can count on just the uclamp_mutex
> 
> Well, if we don't care about performance (slow path) then keeping he
> lock is fine, just the comment and alignment are misleading.

Ok

[...]

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
