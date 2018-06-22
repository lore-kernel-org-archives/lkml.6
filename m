Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FF4C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B05D23E19
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B05D23E19
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbeFVHQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:16:07 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:52383 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751250AbeFVHQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:16:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0T39frrw_1529651742;
Received: from localhost(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0T39frrw_1529651742)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Jun 2018 15:15:51 +0800
From:   Xunlei Pang <xlpang@linux.alibaba.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/cputime: Ensure correct utime and stime proportion
Date:   Fri, 22 Jun 2018 15:15:42 +0800
Message-Id: <20180622071542.61569-1-xlpang@linux.alibaba.com>
X-Mailer: git-send-email 2.14.1.40.g8e62ba1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use per-cgroup cpu usage statistics similar to "cgroup rstat",
and encountered a problem that user and sys usages are wrongly
split sometimes.

Run tasks with some random run-sleep pattern for a long time, and
when tick-based time and scheduler sum_exec_runtime hugely drifts
apart(scheduler sum_exec_runtime is less than tick-based time),
the current implementation of cputime_adjust() will produce less
sys usage than the actual use after changing to run a different
workload pattern with high sys. This is because total tick-based
utime and stime are used to split the total sum_exec_runtime.

Same problem exists on utime and stime from "/proc/<pid>/stat".

[Example]
Run some random run-sleep patterns for minutes, then change to run
high sys pattern, and watch.
1) standard "top"(which is the correct one):
   4.6 us, 94.5 sy,  0.0 ni,  0.9 id, 0.0 wa, 0.0 hi, 0.0 si, 0.0 st
2) our tool parsing utime and stime from "/proc/<pid>/stat":
   20.5 usr, 78.4 sys
We can see "20.5 usr" displayed in 2) was incorrect, it recovers
gradually with time: 9.7 usr, 89.5 sys

This patch fixes the issue by calculating using all kinds of time
elapsed since last parse in cputime_adjust(), and accumulate the
corresponding results calculated into prev_cputime. A new field
of task_cputime type is added in structure prev_cputime to record
previous task_cputime so that we can get the elapsed time deltas.

Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
---
 include/linux/sched.h         | 33 +++++++++++------------
 include/linux/sched/cputime.h | 12 ++++++++-
 kernel/sched/cputime.c        | 61 ++++++++++++++++---------------------------
 3 files changed, 51 insertions(+), 55 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 87bf02d93a27..5108ac8414e0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -223,6 +223,22 @@ extern void io_schedule_finish(int token);
 extern long io_schedule_timeout(long timeout);
 extern void io_schedule(void);
 
+/**
+ * struct task_cputime - collected CPU time counts
+ * @utime:		time spent in user mode, in nanoseconds
+ * @stime:		time spent in kernel mode, in nanoseconds
+ * @sum_exec_runtime:	total time spent on the CPU, in nanoseconds
+ *
+ * This structure groups together three kinds of CPU time that are tracked for
+ * threads and thread groups.  Most things considering CPU time want to group
+ * these counts together and treat all three of them in parallel.
+ */
+struct task_cputime {
+	u64				utime;
+	u64				stime;
+	unsigned long long		sum_exec_runtime;
+};
+
 /**
  * struct prev_cputime - snapshot of system and user cputime
  * @utime: time spent in user mode
@@ -236,26 +252,11 @@ struct prev_cputime {
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 	u64				utime;
 	u64				stime;
+	struct task_cputime		cputime;
 	raw_spinlock_t			lock;
 #endif
 };
 
-/**
- * struct task_cputime - collected CPU time counts
- * @utime:		time spent in user mode, in nanoseconds
- * @stime:		time spent in kernel mode, in nanoseconds
- * @sum_exec_runtime:	total time spent on the CPU, in nanoseconds
- *
- * This structure groups together three kinds of CPU time that are tracked for
- * threads and thread groups.  Most things considering CPU time want to group
- * these counts together and treat all three of them in parallel.
- */
-struct task_cputime {
-	u64				utime;
-	u64				stime;
-	unsigned long long		sum_exec_runtime;
-};
-
 /* Alternate field names when used on cache expirations: */
 #define virt_exp			utime
 #define prof_exp			stime
diff --git a/include/linux/sched/cputime.h b/include/linux/sched/cputime.h
index 53f883f5a2fd..49f8fd2564ed 100644
--- a/include/linux/sched/cputime.h
+++ b/include/linux/sched/cputime.h
@@ -175,10 +175,20 @@ static inline void account_group_exec_runtime(struct task_struct *tsk,
 	atomic64_add(ns, &cputimer->cputime_atomic.sum_exec_runtime);
 }
 
-static inline void prev_cputime_init(struct prev_cputime *prev)
+static inline void prev_cputime_clear(struct prev_cputime *prev)
 {
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 	prev->utime = prev->stime = 0;
+	prev->cputime.utime = 0;
+	prev->cputime.stime = 0;
+	prev->cputime.sum_exec_runtime = 0;
+#endif
+}
+
+static inline void prev_cputime_init(struct prev_cputime *prev)
+{
+#ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
+	prev_cputime_clear(prev);
 	raw_spin_lock_init(&prev->lock);
 #endif
 }
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 0796f938c4f0..a68483ee3ad7 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -590,69 +590,54 @@ static u64 scale_stime(u64 stime, u64 rtime, u64 total)
 void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
 		    u64 *ut, u64 *st)
 {
-	u64 rtime, stime, utime;
+	u64 rtime_delta, stime_delta, utime_delta;
 	unsigned long flags;
 
 	/* Serialize concurrent callers such that we can honour our guarantees */
 	raw_spin_lock_irqsave(&prev->lock, flags);
-	rtime = curr->sum_exec_runtime;
 
 	/*
 	 * This is possible under two circumstances:
-	 *  - rtime isn't monotonic after all (a bug);
+	 *  - task_cputime isn't monotonic after all (a bug);
 	 *  - we got reordered by the lock.
 	 *
 	 * In both cases this acts as a filter such that the rest of the code
 	 * can assume it is monotonic regardless of anything else.
 	 */
-	if (prev->stime + prev->utime >= rtime)
+	if (prev->cputime.utime > curr->utime ||
+	    prev->cputime.stime > curr->stime ||
+	    prev->cputime.sum_exec_runtime >= curr->sum_exec_runtime)
 		goto out;
 
-	stime = curr->stime;
-	utime = curr->utime;
+	stime_delta = curr->stime - prev->cputime.stime;
+	utime_delta = curr->utime - prev->cputime.utime;
+	rtime_delta = curr->sum_exec_runtime - prev->cputime.sum_exec_runtime;
 
 	/*
-	 * If either stime or utime are 0, assume all runtime is userspace.
-	 * Once a task gets some ticks, the monotonicy code at 'update:'
-	 * will ensure things converge to the observed ratio.
+	 * If either stime or utime increase are 0, assume all runtime
+	 * is userspace. Once a task gets some ticks, the monotonicy code
+	 * at 'update:' will ensure things converge to the observed ratio.
 	 */
-	if (stime == 0) {
-		utime = rtime;
+	if (stime_delta == 0) {
+		utime_delta = rtime_delta;
 		goto update;
 	}
 
-	if (utime == 0) {
-		stime = rtime;
+	if (utime_delta == 0) {
+		stime_delta = rtime_delta;
 		goto update;
 	}
 
-	stime = scale_stime(stime, rtime, stime + utime);
+	stime_delta = scale_stime(stime_delta, rtime_delta,
+				stime_delta + utime_delta);
+	if (stime_delta > rtime_delta)
+		stime_delta = rtime_delta;
+	utime_delta = rtime_delta - stime_delta;
 
 update:
-	/*
-	 * Make sure stime doesn't go backwards; this preserves monotonicity
-	 * for utime because rtime is monotonic.
-	 *
-	 *  utime_i+1 = rtime_i+1 - stime_i
-	 *            = rtime_i+1 - (rtime_i - utime_i)
-	 *            = (rtime_i+1 - rtime_i) + utime_i
-	 *            >= utime_i
-	 */
-	if (stime < prev->stime)
-		stime = prev->stime;
-	utime = rtime - stime;
-
-	/*
-	 * Make sure utime doesn't go backwards; this still preserves
-	 * monotonicity for stime, analogous argument to above.
-	 */
-	if (utime < prev->utime) {
-		utime = prev->utime;
-		stime = rtime - utime;
-	}
-
-	prev->stime = stime;
-	prev->utime = utime;
+	prev->cputime = *curr;
+	prev->utime += utime_delta;
+	prev->stime += stime_delta;
 out:
 	*ut = prev->utime;
 	*st = prev->stime;
-- 
2.14.1.40.g8e62ba1

