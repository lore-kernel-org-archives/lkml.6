Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F9EC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F6520875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F6520875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933135AbeGIO7R (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:59:17 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:59294 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932792AbeGIO7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:59:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0T4HidXe_1531148322;
Received: from localhost(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0T4HidXe_1531148322)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 09 Jul 2018 22:58:59 +0800
From:   Xunlei Pang <xlpang@linux.alibaba.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>, baoyou.xie@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched/cputime: Ensure accurate utime and stime ratio in cputime_adjust()
Date:   Mon,  9 Jul 2018 22:58:43 +0800
Message-Id: <20180709145843.126583-1-xlpang@linux.alibaba.com>
X-Mailer: git-send-email 2.14.1.40.g8e62ba1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If users access "/proc/pid/stat", the utime and stime ratio in the
current SAMPLE period are excepted, but currently cputime_adjust()
always calculates with the ratio of the WHOLE lifetime of the process.

This results in inaccurate utime and stime in "/proc/pid/stat". For
example,  a process runs for a while with "50% usr, 0% sys", then
followed by "100% sys". For later while, the following is excepted:
  0.0 usr,  100.0 sys
but we got:
  10.0 usr,  90.0 sys

This patch uses the accurate ratio in cputime_adjust() to address the
issue. A new task_cputime type field is added in prev_cputime to record
previous task_cputime so that we can get the elapsed times as the accurate
ratio.

Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
---
v1->v2:
 - Rewrite the changelog.

 include/linux/sched.h         | 34 ++++++++++++------------
 include/linux/sched/cputime.h | 12 ++++++++-
 kernel/sched/cputime.c        | 61 ++++++++++++++++---------------------------
 3 files changed, 52 insertions(+), 55 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 87bf02d93a27..9cb76005b638 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -223,10 +223,27 @@ extern void io_schedule_finish(int token);
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
  * @stime: time spent in system mode
+ * @cputime: previous task_cputime to calculate utime/stime
  * @lock: protects the above two fields
  *
  * Stores previous user/system time values such that we can guarantee
@@ -236,26 +253,11 @@ struct prev_cputime {
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

