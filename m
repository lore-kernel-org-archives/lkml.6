Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755617AbeDYSCD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:02:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35156 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750935AbeDYSCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:02:00 -0400
Date: Wed, 25 Apr 2018 20:01:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
        daniel.lezcano@linaro.org, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com
Subject: Re: [PATCH 3/3] sched: limit cpu search and rotate search window for
 scalability
Message-ID: <20180425180140.GU4129@hirez.programming.kicks-ass.net>
References: <20180424004116.28151-1-subhra.mazumdar@oracle.com>
 <20180424004116.28151-4-subhra.mazumdar@oracle.com>
 <20180424125349.GU4082@hirez.programming.kicks-ass.net>
 <d7efc4d3-7c50-752e-a1ae-a164d991dbcc@oracle.com>
 <20180425153600.GA4043@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425153600.GA4043@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 05:36:00PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 24, 2018 at 05:10:34PM -0700, Subhra Mazumdar wrote:
> > On 04/24/2018 05:53 AM, Peter Zijlstra wrote:
> 
> > > Why do you need to put a max on? Why isn't the proportional thing
> > > working as is? (is the average no good because of big variance or what)
> 
> > Firstly the choosing of 512 seems arbitrary.
> 
> It is; it is a crud attempt to deal with big variance. The comment says
> as much.
> 
> > Secondly the logic here is that the enqueuing cpu should search up to
> > time it can get work itself.  Why is that the optimal amount to
> > search?
> 
> 1/512-th of the time in fact, per the above random number, but yes.
> Because searching for longer than we're expecting to be idle for is
> clearly bad, at that point we're inhibiting doing useful work.
> 
> But while thinking about all this, I think I've spotted a few more
> issues, aside from the variance:
> 
> Firstly, while avg_idle estimates the average duration for _when_ we go
> idle, it doesn't give a good measure when we do not in fact go idle. So
> when we get wakeups while fully busy, avg_idle is a poor measure.
> 
> Secondly, the number of wakeups performed is also important. If we have
> a lot of wakeups, we need to look at aggregate wakeup time over a
> period. Not just single wakeup time.
> 
> And thirdly, we're sharing the idle duration with newidle balance.
> 
> And I think the 512 is a result of me not having recognised these
> additional issues when looking at the traces, I saw variance and left it
> there.
> 
> 
> This leaves me thinking we need a better estimator for wakeups. Because
> if there really is significant idle time, not looking for idle CPUs to
> run on is bad. Placing that upper limit, especially such a low one, is
> just an indication of failure.
> 
> 
> I'll see if I can come up with something.

Something like so _could_ work. Again, completely untested. We give idle
time to wake_avg, we subtract select_idle_sibling 'runtime' from
wake_avg, such that when there's lots of wakeups we don't use more time
than there was reported idle time. And we age wake_avg, such that if
there hasn't been idle for a number of ticks (we've been real busy) we
also stop scanning wide.

But it could eat your granny and set your cat on fire :-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5e10aaeebfcc..bc910e5776cc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1671,6 +1671,9 @@ static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
 		if (rq->avg_idle > max)
 			rq->avg_idle = max;
 
+		rq->wake_stamp = jiffies;
+		rq->wake_avg = rq->avg_idle / 2;
+
 		rq->idle_stamp = 0;
 	}
 #endif
@@ -6072,6 +6075,8 @@ void __init sched_init(void)
 		rq->online = 0;
 		rq->idle_stamp = 0;
 		rq->avg_idle = 2*sysctl_sched_migration_cost;
+		rq->wake_stamp = jiffies;
+		rq->wake_avg = rq->avg_idle;
 		rq->max_idle_balance_cost = sysctl_sched_migration_cost;
 
 		INIT_LIST_HEAD(&rq->cfs_tasks);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 54dc31e7ab9b..fee31dbe15ed 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6369,7 +6369,9 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
 static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	struct sched_domain *this_sd;
+	unsigned long now = jiffies;
 	u64 avg_cost, avg_idle;
+	struct rq *this_rq;
 	u64 time, cost;
 	s64 delta;
 	int cpu, nr = INT_MAX;
@@ -6378,11 +6380,18 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	if (!this_sd)
 		return -1;
 
-	/*
-	 * Due to large variance we need a large fuzz factor; hackbench in
-	 * particularly is sensitive here.
-	 */
-	avg_idle = this_rq()->avg_idle / 512;
+	this_rq = this_rq();
+	if (sched_feat(SIS_NEW)) {
+		/* age the remaining idle time */
+		if (unlikely(this_rq->wake_stamp < now)) {
+			while (this_rq->wake_stamp < now && this_rq->wake_avg)
+				this_rq->wake_avg >>= 1;
+		}
+		avg_idle = this_rq->wake_avg;
+	} else {
+		avg_idle = this_rq->avg_idle / 512;
+	}
+
 	avg_cost = this_sd->avg_scan_cost + 1;
 
 	if (sched_feat(SIS_AVG_CPU) && avg_idle < avg_cost)
@@ -6412,6 +6421,12 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	delta = (s64)(time - cost) / 8;
 	this_sd->avg_scan_cost += delta;
 
+	/* you can only spend the time once */
+	if (this_rq->wake_avg > time)
+		this_rq->wake_avg -= time;
+	else
+		this_rq->wake_avg = 0;
+
 	return cpu;
 }
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 85ae8488039c..f5f86a59aac4 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -57,6 +57,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
  */
 SCHED_FEAT(SIS_AVG_CPU, false)
 SCHED_FEAT(SIS_PROP, true)
+SCHED_FEAT(SIS_NEW, false)
 
 /*
  * Issue a WARN when we do multiple update_rq_clock() calls
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 15750c222ca2..c4d6ddf907b5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -831,6 +831,9 @@ struct rq {
 	u64			idle_stamp;
 	u64			avg_idle;
 
+	unsigned long		wake_stamp;
+	u64			wake_avg;
+
 	/* This is used to determine avg_idle's max value */
 	u64			max_idle_balance_cost;
 #endif
