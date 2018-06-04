Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeFDQGT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 12:06:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45390 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751058AbeFDQGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 12:06:15 -0400
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>, Todd Kjos <tkjos@google.com>
Subject: [PATCH 1/2] sched/fair: pelt: use u32 for util_avg
Date: Mon,  4 Jun 2018 17:05:59 +0100
Message-Id: <20180604160600.22052-2-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180604160600.22052-1-patrick.bellasi@arm.com>
References: <20180604160600.22052-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The util_avg signal is used to track the utilization (i.e. RUNNING time)
of SEs and RQs. Its values are computed according to the PELT algorithm
and thus, for SE, they are bounded to an (internal) representation which
uses 20bits. For RQ instead they are technically un-bounded, since when
tasks are migrated across RQs we sum their utilization to the
destination RQ.

We currently use an unsigned long to track util_avg which maps into a
64bits storage on 64bits systems. However, 32bits should be good enough
for all practical usages. Indeed, even for RQs, the remaining 12bits
allows to track up to 4K 100% tasks concurrently RUNNABLE on a single
CPU.

Since the sched_avg data structure already completely fits a 64B cache
line, let's get back 4B by using u32 to track util_avg. The recovered
space could be conveniently used to fit other load tracking related
metrics into the same cache line.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Steve Muckle <smuckle@google.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 include/linux/sched.h |  2 +-
 kernel/sched/debug.c  |  2 +-
 kernel/sched/fair.c   | 17 ++++++++++-------
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 28ff3ca9f752..9d8732dab264 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -402,7 +402,7 @@ struct sched_avg {
 	u32				period_contrib;
 	unsigned long			load_avg;
 	unsigned long			runnable_load_avg;
-	unsigned long			util_avg;
+	u32				util_avg;
 	struct util_est			util_est;
 } ____cacheline_aligned;
 
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 15b10e210a6b..a985789eeb9c 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -541,7 +541,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			cfs_rq->avg.load_avg);
 	SEQ_printf(m, "  .%-30s: %lu\n", "runnable_load_avg",
 			cfs_rq->avg.runnable_load_avg);
-	SEQ_printf(m, "  .%-30s: %lu\n", "util_avg",
+	SEQ_printf(m, "  .%-30s: %u\n", "util_avg",
 			cfs_rq->avg.util_avg);
 	SEQ_printf(m, "  .%-30s: %u\n", "util_est_enqueued",
 			cfs_rq->avg.util_est.enqueued);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e497c05aab7f..f74441be3f44 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -750,19 +750,22 @@ static void attach_entity_cfs_rq(struct sched_entity *se);
 void post_init_entity_util_avg(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
-	struct sched_avg *sa = &se->avg;
 	long cap = (long)(SCHED_CAPACITY_SCALE - cfs_rq->avg.util_avg) / 2;
 
 	if (cap > 0) {
-		if (cfs_rq->avg.util_avg != 0) {
-			sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;
-			sa->util_avg /= (cfs_rq->avg.load_avg + 1);
+		struct sched_avg *sa = &se->avg;
+		u64 util_avg = READ_ONCE(sa->util_avg);
 
-			if (sa->util_avg > cap)
-				sa->util_avg = cap;
+		if (cfs_rq->avg.util_avg != 0) {
+			util_avg  =  cfs_rq->avg.util_avg * se->load.weight;
+			util_avg /= (cfs_rq->avg.load_avg + 1);
+			if (util_avg > cap)
+				util_avg = cap;
 		} else {
-			sa->util_avg = cap;
+			util_avg = cap;
 		}
+
+		WRITE_ONCE(sa->util_avg, util_avg);
 	}
 
 	if (entity_is_task(se)) {
-- 
2.15.1
