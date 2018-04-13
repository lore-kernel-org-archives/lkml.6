Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754589AbeDMMpO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 08:45:14 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37016 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751776AbeDMMpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 08:45:12 -0400
Date: Fri, 13 Apr 2018 14:44:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH 1/7] sched/core: uclamp: add CPU clamp groups accounting
Message-ID: <20180413124458.GG4082@hirez.programming.kicks-ass.net>
References: <20180409165615.2326-1-patrick.bellasi@arm.com>
 <20180409165615.2326-2-patrick.bellasi@arm.com>
 <20180413084302.GR4043@hirez.programming.kicks-ass.net>
 <20180413111510.GS14248@e110439-lin>
 <20180413113650.GR4064@hirez.programming.kicks-ass.net>
 <20180413114745.GV14248@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413114745.GV14248@e110439-lin>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 12:47:45PM +0100, Patrick Bellasi wrote:
> In the past I remember some funny dance in cgroup callbacks when a
> task was terminating (like being moved in the root-rq just before
> exiting). But, as you say, if we always have the task_rq_lock we
> should be safe.

The syscall does the whole:

	task_rq_lock();
	queued = task_on_rq_queued();
	running = task_current();
	if (queued)
		dequeue_task();
	if (running)
		put_prev_task();

	/*
	 * task is in invariant state here,
	 * muck with it.
	 */

	if (queued)
		enqueue_task();
	if (running)
		set_curr_task()
	task_rq_unlock();

pattern; which because C sucks, we've not found a good template for yet.

Without the dequeue/put,enqueue/set you have to jump a few extra hoops.
