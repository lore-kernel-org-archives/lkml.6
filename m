Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751708AbeDEIFe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 04:05:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38790 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbeDEIFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 04:05:30 -0400
Date: Thu, 5 Apr 2018 10:05:21 +0200
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
Message-ID: <20180405080521.GG4129@hirez.programming.kicks-ass.net>
References: <20180402232448.fbop7k5xicblski5@agluck-desk>
 <20180403073706.GV4082@hirez.programming.kicks-ass.net>
 <20180403185829.yteixqsb5zazmav6@agluck-desk>
 <3908561D78D1C84285E8C5FCA982C28F7B3C2F5D@ORSMSX110.amr.corp.intel.com>
 <20180404072513.GF4082@hirez.programming.kicks-ass.net>
 <20180404163855.3obxjshmrlppzhdp@agluck-desk>
 <20180404165310.GJ4082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404165310.GJ4082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 06:53:10PM +0200, Peter Zijlstra wrote:
> Awesome, I'll go get it merged, even though I don't understand where it
> went wobbly.

Ingo, could you magic this in?

---
Subject: sched: Force alignment of struct util_est
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Apr  5 09:56:16 CEST 2018

For some as yet not understood reason, Tony gets unaligned access
traps on IA64 because of:

  struct util_est ue = READ_ONCE(p->se.avg.util_est);

and:

  WRITE_ONCE(p->se.avg.util_est, ue);

introduced by commit:

  d519329f72a6 ("sched/fair: Update util_est only on util_avg updates")

Normally those two fields should end up on an 8-byte aligned location,
but UP and RANDSTRUCT can mess that up so enforce the alignment
explicitly.

Also make the alignment on sched_avg unconditional, as it is really
about data locality, not false-sharing.

With or without this patch the layout for sched_avg on a
ia64-defconfig build looks like:

$ pahole -EC sched_avg ia64-defconfig/kernel/sched/core.o
die__process_function: tag not supported (INVALID)!
struct sched_avg {
        /* typedef u64 */ long long unsigned int     last_update_time;                   /*     0     8 */
        /* typedef u64 */ long long unsigned int     load_sum;                           /*     8     8 */
        /* typedef u64 */ long long unsigned int     runnable_load_sum;                  /*    16     8 */
        /* typedef u32 */ unsigned int               util_sum;                           /*    24     4 */
        /* typedef u32 */ unsigned int               period_contrib;                     /*    28     4 */
        long unsigned int          load_avg;                                             /*    32     8 */
        long unsigned int          runnable_load_avg;                                    /*    40     8 */
        long unsigned int          util_avg;                                             /*    48     8 */
        struct util_est {
                unsigned int       enqueued;                                             /*    56     4 */
                unsigned int       ewma;                                                 /*    60     4 */
        } util_est; /*    56     8 */
        /* --- cacheline 1 boundary (64 bytes) --- */

        /* size: 64, cachelines: 1, members: 9 */
};

Fixes: d519329f72a6 ("sched/fair: Update util_est only on util_avg updates")
Reported-and-Tested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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
 
