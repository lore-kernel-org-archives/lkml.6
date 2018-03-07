Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933829AbeCGPZF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:25:05 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52780 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933335AbeCGPZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:25:03 -0500
Date: Wed, 7 Mar 2018 15:24:58 +0000
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH v5 1/4] sched/fair: add util_est on top of PELT
Message-ID: <20180307152458.GE2211@e110439-lin>
References: <20180222170153.673-1-patrick.bellasi@arm.com>
 <20180222170153.673-2-patrick.bellasi@arm.com>
 <20180306185851.GG25201@hirez.programming.kicks-ass.net>
 <20180307113149.GA2211@e110439-lin>
 <20180307122437.GM25181@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307122437.GM25181@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-Mar 13:24, Peter Zijlstra wrote:
> On Wed, Mar 07, 2018 at 11:31:49AM +0000, Patrick Bellasi wrote:
> > > It appears to me this isn't a stable situation and completely relies on
> > > the !nr_running case to recalibrate. If we ensure that doesn't happen
> > > for a significant while the sum can run-away, right?
> > 
> > By away you mean go over 1024 or overflow the unsigned int storage?
> 
> the later, I think you can make it arbitrarily large. Have a busy task
> on CPU0, this ensure !nr_running never happens.
> 
> Start a busy task on CPU1, wait for it to hit u=1, then migrate it to
> CPU0, 

At this point util_est(CPU0) = 2048, which is:

   +1024 for the busy running task
         assuming it has been enqueued with the utilization since the beginning
   +1024 for the newly migrated task from CPU1
         which is enqueued with the value he reached at dequeued time
         from CPU1

> then wait for it to hit u=.5 then kill it,

... but when we kill it, the task is dequeued, and thus we remove
1024.

Maybe that's the tricky bit: we remove the value we enqueued, _not_
the current util_avg. Notice we use _task_util_est(p)... with the
leading "_".

> this effectively adds
> .5 to the enqueued value, repeat indefinitely.

Thus this should not happen.

Basically, the RQ's util_est is the sum of the RUNNABLE tasks's
util_est at their enqueue time... which has been update at their last
dequeue time, hence the usage of name "dequeued" for both tasks and
rqs.

Does it make sense now?

-- 
#include <best/regards.h>

Patrick Bellasi
