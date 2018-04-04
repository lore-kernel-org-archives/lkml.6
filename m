Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbeDDHZc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 03:25:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45656 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbeDDHZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 03:25:31 -0400
Date: Wed, 4 Apr 2018 09:25:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Norbert Manthey <nmanthey@amazon.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: v4.16+ seeing many unaligned access in dequeue_task_fair() on
 IA64
Message-ID: <20180404072513.GF4082@hirez.programming.kicks-ass.net>
References: <20180402232448.fbop7k5xicblski5@agluck-desk>
 <20180403073706.GV4082@hirez.programming.kicks-ass.net>
 <20180403185829.yteixqsb5zazmav6@agluck-desk>
 <3908561D78D1C84285E8C5FCA982C28F7B3C2F5D@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7B3C2F5D@ORSMSX110.amr.corp.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 12:04:00AM +0000, Luck, Tony wrote:
> > bisect says:
> >
> > d519329f72a6 ("sched/fair: Update util_est only on util_avg updates")
> > 
> > Reverting just this commit makes the problem go away.
> 
> The unaligned read and write seem to come from:
> 
> struct util_est ue = READ_ONCE(p->se.avg.util_est);
> WRITE_ONCE(p->se.avg.util_est, ue);
> 
> which is puzzling as they were around before. Also the "avg"
> field is tagged with an attribute to make it cache aligned
> and there don't look to be holes in the structure that would
> make util_est not be 8-byte aligned ... though it does consist
> of two 4-byte fields, so legal for it to be 4-byte aligned.

Right, I remember being careful with that. Which again brings me to the
RANDSTRUCT thing, which will mess that up.

Does the below cure things? It makes absolutely no difference for my
x86_64-defconfig build, but it puts more explicit alignment constraints
on things.


diff --git a/include/linux/sched.h b/include/linux/sched.h
index f228c6033832..b3d697f3b573 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -300,7 +300,7 @@ struct util_est {
 	unsigned int			enqueued;
 	unsigned int			ewma;
 #define UTIL_EST_WEIGHT_SHIFT		2
-};
+} __attribute__((__aligned__(sizeof(u64))));
 
 /*
  * The load_avg/util_avg accumulates an infinite geometric series
@@ -364,7 +364,7 @@ struct sched_avg {
 	unsigned long			runnable_load_avg;
 	unsigned long			util_avg;
 	struct util_est			util_est;
-};
+} ____cacheline_aligned;
 
 struct sched_statistics {
 #ifdef CONFIG_SCHEDSTATS
@@ -435,7 +435,7 @@ struct sched_entity {
 	 * Put into separate cache line so it does not
 	 * collide with read-mostly values above.
 	 */
-	struct sched_avg		avg ____cacheline_aligned_in_smp;
+	struct sched_avg		avg;
 #endif
 };
 
