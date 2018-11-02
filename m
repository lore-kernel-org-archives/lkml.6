Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDCFC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 09:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F162D2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 09:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F162D2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbeKBS7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 14:59:55 -0400
Received: from foss.arm.com ([217.140.101.70]:39316 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbeKBS7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 14:59:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9B621596;
        Fri,  2 Nov 2018 02:53:19 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 815DB3F71D;
        Fri,  2 Nov 2018 02:53:17 -0700 (PDT)
Date:   Fri, 2 Nov 2018 09:53:14 +0000
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Ye Xiaolong <xiaolong.ye@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] sched/fair: util_est: fix cpu_util_wake for execl
Message-ID: <20181102095314.GB31275@e110439-lin>
References: <20181030160947.19581-1-patrick.bellasi@arm.com>
 <20181031184527.GA3178@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031184527.GA3178@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-Oct 19:45, Peter Zijlstra wrote:
> On Tue, Oct 30, 2018 at 04:09:47PM +0000, Patrick Bellasi wrote:
> 
> > Let's fix this by ensuring to always discount the task estimated
> > utilization from the CPU's estimated utilization when the task is also
> > the current one. The same benchmark of the bug report, executed on a
> > dual socket 40 CPUs Intel(R) Xeon(R) CPU E5-2690 v2 @ 3.00GHz machine,
> > reports these "Execl Throughput" figures (higher the better):
> 
> Before this we have:
> 
> 	/* Discount task's blocked util from CPU's util */
> 	util -= min_t(unsigned int, util, task_util(p));
> 
> at the very least that comment is now inaccurate, since @p might not be
> blocked.

Right... will fix this too.

> > @@ -6258,8 +6267,17 @@ static unsigned long cpu_util_wake(int cpu, struct task_struct *p)
> >  	 * covered by the following code when estimated utilization is
> >  	 * enabled.
> >  	 */
> > -	if (sched_feat(UTIL_EST))
> > -		util = max(util, READ_ONCE(cfs_rq->avg.util_est.enqueued));
> > +	if (sched_feat(UTIL_EST)) {
> > +		unsigned int estimated =
> > +			READ_ONCE(cfs_rq->avg.util_est.enqueued);
> > +
> > +		if (unlikely(current == p || task_on_rq_queued(p))) {
> 
> I'm confused by the need for 'current == p', afaict task_on_rq_queued(p)
> is sufficient -- we've already established task_cpu(p) == cpu earlier.

Mmm... you right, I've got confused by the fact that current is
removed from the RBTree, but we keep tracking it as:

    on_rq = TASK_ON_RQ_QUEUED

... unless, select_task_rq_fair() races with LB's:

    detach_task()
      p->on_rq = TASK_ON_RQ_MIGRATING;
      -----------------------------------A
      deactivate_task()                   \
        dequeue_task()                     +- RaceTime
          util_est_dequeue()              /
      -----------------------------------B
      set_task_cpu()
        migrate_task_rq{_fair}()
          detach_entity_cfs_rq()

where, in [A..B] we will still avoid to discount *p's estimated
utilization. :/

Do you think we can live with that for the time being, maybe by just
adding a comment, or should we try to close that too ?

Eventually, the (current == p) check, maybe moved to the right of the
OR condition above, should certainly close the race window for the
specific UnixBench's execl case. Assuming for example the execl is
executed by a misfit task which is target of an active load balance...


> > +			estimated -= min_t(unsigned int, estimated,
> > +				(_task_util_est(p) | UTIL_AVG_UNCHANGED));
> > +		}
> > +
> > +		util = max(util, estimated);
> > +	}
> 
> Also, I think it is about time we find a suitable name for:
> 
> #define xxx(_var, _val) do { \

   remove_contrib(_var, _val) ?

> 	typeof(_var) var = (_var); \
> 	typeof(_var) val = (_val); \
> 	typeof(_var) res = var - val; \
> 	if (res > var) \
> 		res = 0; \
> 	(_var) = res; \
> } while (0)
> 
> Which is basically sub_positive() but without the READ_ONCE/WRITE_ONCE
> stuff.

Perhaps there are still some paths in where sub_positive() can be
recycled... will look better into that and see what we can do on that
polishing side. However, I'll keep all that in a different patch.

> We do that:
> 
> 	var -= min_t(typeof(var), var, val);
> 
> pattern _all_ over.

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
