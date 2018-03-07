Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754129AbeCGJjr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 04:39:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54004 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbeCGJjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 04:39:45 -0500
Date: Wed, 7 Mar 2018 10:39:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
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
Message-ID: <20180307093937.GZ25235@hirez.programming.kicks-ass.net>
References: <20180222170153.673-1-patrick.bellasi@arm.com>
 <20180222170153.673-2-patrick.bellasi@arm.com>
 <20180306185851.GG25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306185851.GG25201@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 07:58:51PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 22, 2018 at 05:01:50PM +0000, Patrick Bellasi wrote:
> > +static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
> > +				    struct task_struct *p)
> > +{
> > +	unsigned int enqueued;
> > +
> > +	if (!sched_feat(UTIL_EST))
> > +		return;
> > +
> > +	/* Update root cfs_rq's estimated utilization */
> > +	enqueued  = READ_ONCE(cfs_rq->avg.util_est.enqueued);
> > +	enqueued += _task_util_est(p);
> > +	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, enqueued);
> > +}

> It appears to me this isn't a stable situation and completely relies on
> the !nr_running case to recalibrate. If we ensure that doesn't happen
> for a significant while the sum can run-away, right?
> 
> Should we put a max in enqueue to avoid this?

Thinking about this a bit more; would it make sense to adjust the
running sum/avg on migration? Something along the lines of:

  util_avg = se->load_avg / (cfs_rq->load_avg + se->load_avg);

(which disregards cgroups), because that should more or less be the time
it ends up running, given the WFQ rule.

That way the disparity between tasks migrating into the CPU at u=1 and
them going to sleep at u<1 is much smaller and the above sum doesn't run
away nearly as wild (it still needs some upper bound though).
