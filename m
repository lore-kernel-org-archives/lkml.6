Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755461AbeCHJPz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 04:15:55 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55350 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755101AbeCHJPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 04:15:52 -0500
Date: Thu, 8 Mar 2018 10:15:33 +0100
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
Subject: Re: [PATCH v5 4/4] sched/fair: update util_est only on util_avg
 updates
Message-ID: <20180308091533.GA25235@hirez.programming.kicks-ass.net>
References: <20180222170153.673-1-patrick.bellasi@arm.com>
 <20180222170153.673-5-patrick.bellasi@arm.com>
 <20180307103852.GJ25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307103852.GJ25201@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 11:38:52AM +0100, Peter Zijlstra wrote:
> On Thu, Feb 22, 2018 at 05:01:53PM +0000, Patrick Bellasi wrote:

> > @@ -5218,7 +5242,7 @@ static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
> >  
> >  	/* Update root cfs_rq's estimated utilization */
> >  	enqueued  = READ_ONCE(cfs_rq->avg.util_est.enqueued);
> > -	enqueued += _task_util_est(p);
> > +	enqueued += (_task_util_est(p) | 0x1);
> 
> UTIL_EST_NEED_UPDATE_FLAG, although I do agree that 0x1 is much easier
> to type ;-)
> 
> But you set it for the cfs_rq value ?! That doesn't seem right.
> 
> >  	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, enqueued);
> >  }
> >  
> > @@ -5310,7 +5334,7 @@ static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
> >  	if (cfs_rq->nr_running) {
> >  		ue.enqueued  = READ_ONCE(cfs_rq->avg.util_est.enqueued);
> >  		ue.enqueued -= min_t(unsigned int, ue.enqueued,
> > -				     _task_util_est(p));
> > +				     (_task_util_est(p) | UTIL_EST_NEED_UPDATE_FLAG));
> >  	}
> >  	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, ue.enqueued);
> >  

OK, so you unconditionally set that bit here to make the add/sub match.
Clearly I wasn't having a good day yesterday.
