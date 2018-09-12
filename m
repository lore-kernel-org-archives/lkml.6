Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809EDC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C7F20833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C7F20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbeILVBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:01:33 -0400
Received: from foss.arm.com ([217.140.101.70]:34222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbeILVBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:01:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7D0C7A9;
        Wed, 12 Sep 2018 08:56:24 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14A303F5C0;
        Wed, 12 Sep 2018 08:56:21 -0700 (PDT)
Date:   Wed, 12 Sep 2018 16:56:19 +0100
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
Message-ID: <20180912155619.GG1413@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-3-patrick.bellasi@arm.com>
 <20180912134945.GZ24106@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912134945.GZ24106@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-Sep 15:49, Peter Zijlstra wrote:
> On Tue, Aug 28, 2018 at 02:53:10PM +0100, Patrick Bellasi wrote:
> > +/**
> > + * Utilization's clamp group
> > + *
> > + * A utilization clamp group maps a "clamp value" (value), i.e.
> > + * util_{min,max}, to a "clamp group index" (group_id).
> > + */
> > +struct uclamp_se {
> > +	unsigned int value;
> > +	unsigned int group_id;
> > +};
> 
> > +/**
> > + * uclamp_map: reference counts a utilization "clamp value"
> > + * @value:    the utilization "clamp value" required
> > + * @se_count: the number of scheduling entities requiring the "clamp value"
> > + * @se_lock:  serialize reference count updates by protecting se_count
> 
> Why do you have a spinlock to serialize a single value? Don't we have
> atomics for that?

There are some code paths where it's used to protect clamp groups
mapping and initialization, e.g.

      uclamp_group_get()
          spin_lock()
              // initialize clamp group (if required) and then...
              se_count += 1
          spin_unlock()

Almost all these paths are triggered from user-space and protected
by a global uclamp_mutex, but fork/exit paths.

To serialize these paths I'm using the spinlock above, does it make
sense ? Can we use the global uclamp_mutex on forks/exit too ?

One additional observations is that, if in the future we want to add a
kernel space API, (e.g. driver asking for a new clamp value), maybe we
will need to have a serialized non-sleeping uclamp_group_get() API ?

> > + */
> > +struct uclamp_map {
> > +	int value;
> > +	int se_count;
> > +	raw_spinlock_t se_lock;
> > +};
> > +
> > +/**
> > + * uclamp_maps: maps each SEs "clamp value" into a CPUs "clamp group"
> > + *
> > + * Since only a limited number of different "clamp values" are supported, we
> > + * need to map each different clamp value into a "clamp group" (group_id) to
> > + * be used by the per-CPU accounting in the fast-path, when tasks are
> > + * enqueued and dequeued.
> > + * We also support different kind of utilization clamping, min and max
> > + * utilization for example, each representing what we call a "clamp index"
> > + * (clamp_id).
> > + *
> > + * A matrix is thus required to map "clamp values" to "clamp groups"
> > + * (group_id), for each "clamp index" (clamp_id), where:
> > + * - rows are indexed by clamp_id and they collect the clamp groups for a
> > + *   given clamp index
> > + * - columns are indexed by group_id and they collect the clamp values which
> > + *   maps to that clamp group
> > + *
> > + * Thus, the column index of a given (clamp_id, value) pair represents the
> > + * clamp group (group_id) used by the fast-path's per-CPU accounting.
> > + *
> > + * NOTE: first clamp group (group_id=0) is reserved for tracking of non
> > + * clamped tasks.  Thus we allocate one more slot than the value of
> > + * CONFIG_UCLAMP_GROUPS_COUNT.
> > + *
> > + * Here is the map layout and, right below, how entries are accessed by the
> > + * following code.
> > + *
> > + *                          uclamp_maps is a matrix of
> > + *          +------- UCLAMP_CNT by CONFIG_UCLAMP_GROUPS_COUNT+1 entries
> > + *          |                                |
> > + *          |                /---------------+---------------\
> > + *          |               +------------+       +------------+
> > + *          |  / UCLAMP_MIN | value      |       | value      |
> > + *          |  |            | se_count   |...... | se_count   |
> > + *          |  |            +------------+       +------------+
> > + *          +--+            +------------+       +------------+
> > + *             |            | value      |       | value      |
> > + *             \ UCLAMP_MAX | se_count   |...... | se_count   |
> > + *                          +-----^------+       +----^-------+
> > + *                                |                   |
> > + *                      uc_map =  +                   |
> > + *                     &uclamp_maps[clamp_id][0]      +
> > + *                                                clamp_value =
> > + *                                       uc_map[group_id].value
> > + */
> > +static struct uclamp_map uclamp_maps[UCLAMP_CNT]
> > +				    [CONFIG_UCLAMP_GROUPS_COUNT + 1]
> > +				    ____cacheline_aligned_in_smp;
> > +
> 
> I'm still completely confused by all this.
> 
> sizeof(uclamp_map) = 12
> 
> that array is 2*6=12 of those, so the whole thing is 144 bytes. which is
> more than 2 (64 byte) cachelines.

This data structure is *not* used in the hot-path, that's why I did not
care about fitting it exactly into few cache lines.

It's used to map a user-space "clamp value" into a kernel-space "clamp
group" when user-space:
 - changes a task specific clamp value
 - changes a cgroup clamp value
 - a task forks/exits

I assume we can consider all those as "slow" code paths, is that correct ?

At enqueue/dequeue time we use instead struct uclamp_cpu, introduced
by the next patch:

   [PATCH v4 03/16] sched/core: uclamp: add CPU's clamp groups accounting
   https://lore.kernel.org/lkml/20180828135324.21976-4-patrick.bellasi@arm.com/

That's where we refcount RUNNABLE tasks and we have to figure out
the current clamp value for a CPU.

That data structure, with CONFIG_UCLAMP_GROUPS_COUNT=5, is:

   struct uclamp_cpu {
           struct uclamp_group        group[2][6];          /*     0    96 */
           /* --- cacheline 1 boundary (64 bytes) was 32 bytes ago --- */
           int                        value[2];             /*    96     8 */
           int                        flags;                /*   104     4 */

           /* size: 108, cachelines: 2, members: 3 */
           /* last cacheline: 44 bytes */
   };

and we fit into 2 cache lines with this data layout:

   util_min[0..5] | util_max[0..5] | other data

> What's the purpose of that cacheline align statement?

In uclamp_maps, we still need to scan the array when a clamp value is
changed from user-space, i.e. the cases reported above. Thus, that
alignment is just to ensure that we minimize the number of cache lines
used. Does that make sense ?

Maybe that alignment implicitly generated by the compiler ?

> Note that without that apparently superfluous lock, it would be 8*12 =
> 96 bytes, which is 1.5 lines and would indeed suggest you default to
> GROUP_COUNT=7 by default to fill 2 lines.

Yes, will check better if we can count on just the uclamp_mutex

> Why are the min and max things torn up like that?  I'm fairly sure I
> asked some of that last time; but the above comments only try to explain
> what, not why.

We use that organization to speedup scanning for clamp values of the
same clamp_id. That's more important in the hot-path than above, where
we need to scan struct uclamp_cpu when a new aggregated clamp value
has to be computed. This is done in:

   [PATCH v4 03/16] sched/core: uclamp: add CPU's clamp groups accounting
   https://lore.kernel.org/lkml/20180828135324.21976-4-patrick.bellasi@arm.com/

Specifically:

   dequeue_task()
     uclamp_cpu_put()
       uclamp_cpu_put_id(clamp_id)
         uclamp_cpu_update(clamp_id)
            // Here we have an array scan by clamp_id

With the given data layout I reported above, when we update the
min_clamp value (boost) we have all the data required in a single
cache line.

If that makes sense, I can certainly improve the comment above to
justify its layout.

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
