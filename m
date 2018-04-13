Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753997AbeDMJih (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 05:38:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36160 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbeDMJif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 05:38:35 -0400
Date: Fri, 13 Apr 2018 11:38:22 +0200
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
Message-ID: <20180413093822.GM4129@hirez.programming.kicks-ass.net>
References: <20180409165615.2326-1-patrick.bellasi@arm.com>
 <20180409165615.2326-2-patrick.bellasi@arm.com>
 <20180413093005.GS4043@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413093005.GS4043@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 11:30:05AM +0200, Peter Zijlstra wrote:
> On Mon, Apr 09, 2018 at 05:56:09PM +0100, Patrick Bellasi wrote:
> > +struct uclamp_group {
> > +	/* Utilization clamp value for tasks on this clamp group */
> > +	int value;
> > +	/* Number of RUNNABLE tasks on this clamp group */
> > +	int tasks;
> > +};
> 
> > +struct uclamp_cpu {
> > +	/* Utilization clamp value for a CPU */
> > +	int value;
> > +	/* Utilization clamp groups affecting this CPU */
> > +	struct uclamp_group group[CONFIG_UCLAMP_GROUPS_COUNT + 1];
> > +};
> 
> > @@ -811,6 +885,11 @@ struct rq {
> >  	unsigned long		cpu_capacity;
> >  	unsigned long		cpu_capacity_orig;
> >  
> > +#ifdef CONFIG_UCLAMP_TASK
> > +	/* util_{min,max} clamp values based on CPU's active tasks */
> > +	struct uclamp_cpu uclamp[UCLAMP_CNT];
> > +#endif
> > +
> >  	struct callback_head	*balance_callback;
> >  
> >  	unsigned char		idle_balance;
> 
> So that is:
> 
> struct rq {
> 
> 	struct uclamp_cpu {
> 		int value;
> 
> 		/* 4 byte hole */
> 
> 		struct uclamp_group {
> 			int value;
> 			int tasks;
> 		} [COUNT + 1];	// size: COUNT+2 * 8 [bytes]
> 
> 	} [2]; // size: 2 * COUNT+2 * 8 [bytes]
> 
> };

Note that you can slightly compress the data structure if you do
something like:

	struct rq {

		int active_clamp[2];

		struct uclamp_group {
			int value;
			int task;
		} [COUNT + 1][2]; // XXX check array order of C
	};

It also avoids the active values being split over 2 lines; and we need
those values every time, even if there are no active clamp tasks on the
system.
