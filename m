Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbeDEJTl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 05:19:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36441 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751928AbeDEJTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 05:19:38 -0400
Date: Thu, 5 Apr 2018 02:18:57 -0700
From: tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-317d359df95dd0cb7653d09b7fc513770590cf85@git.kernel.org>
Cc: mgorman@techsingularity.net, acme@redhat.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        vincent.guittot@linaro.org, hpa@zytor.com, peterz@infradead.org,
        frederic@kernel.org, patrick.bellasi@arm.com, mingo@kernel.org,
        tony.luck@intel.com, nmanthey@amazon.de, linux-kernel@vger.kernel.org
Reply-To: patrick.bellasi@arm.com, frederic@kernel.org, nmanthey@amazon.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, tony.luck@intel.com,
        tglx@linutronix.de, vincent.guittot@linaro.org,
        mgorman@techsingularity.net, acme@redhat.com,
        torvalds@linux-foundation.org, peterz@infradead.org, hpa@zytor.com
In-Reply-To: <20180405080521.GG4129@hirez.programming.kicks-ass.net>
References: <20180405080521.GG4129@hirez.programming.kicks-ass.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/core: Force proper alignment of 'struct
 util_est'
Git-Commit-ID: 317d359df95dd0cb7653d09b7fc513770590cf85
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  317d359df95dd0cb7653d09b7fc513770590cf85
Gitweb:     https://git.kernel.org/tip/317d359df95dd0cb7653d09b7fc513770590cf85
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Thu, 5 Apr 2018 10:05:21 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 5 Apr 2018 10:56:16 +0200

sched/core: Force proper alignment of 'struct util_est'

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

Reported-and-Tested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Norbert Manthey <nmanthey@amazon.de>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony <tony.luck@intel.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Fixes: d519329f72a6 ("sched/fair: Update util_est only on util_avg updates")
Link: http://lkml.kernel.org/r/20180405080521.GG4129@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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
 
