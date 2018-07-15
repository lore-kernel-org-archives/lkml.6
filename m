Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F93ECDFB3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233572084C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233572084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeGPABU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 20:01:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52259 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeGPABT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 20:01:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FNaIGv922546
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 16:36:18 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FNaHlW922543;
        Sun, 15 Jul 2018 16:36:17 -0700
Date:   Sun, 15 Jul 2018 16:36:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Xunlei Pang <tipbot@zytor.com>
Message-ID: <tip-8d4c00dc38a8aa30dae8402955e55e7b34e74bc8@git.kernel.org>
Cc:     hpa@zytor.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, tj@kernel.org,
        lcapitulino@redhat.com, frederic@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, xlpang@linux.alibaba.com
Reply-To: xlpang@linux.alibaba.com, tglx@linutronix.de,
          frederic@kernel.org, lcapitulino@redhat.com,
          peterz@infradead.org, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, tj@kernel.org,
          mingo@kernel.org
In-Reply-To: <20180709145843.126583-1-xlpang@linux.alibaba.com>
References: <20180709145843.126583-1-xlpang@linux.alibaba.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/cputime: Ensure accurate utime and stime
 ratio in cputime_adjust()
Git-Commit-ID: 8d4c00dc38a8aa30dae8402955e55e7b34e74bc8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8d4c00dc38a8aa30dae8402955e55e7b34e74bc8
Gitweb:     https://git.kernel.org/tip/8d4c00dc38a8aa30dae8402955e55e7b34e74bc8
Author:     Xunlei Pang <xlpang@linux.alibaba.com>
AuthorDate: Mon, 9 Jul 2018 22:58:43 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 16 Jul 2018 00:28:31 +0200

sched/cputime: Ensure accurate utime and stime ratio in cputime_adjust()

If users access "/proc/pid/stat", the utime and stime ratio in the
current SAMPLE period are excepted, but currently cputime_adjust()
always calculates with the ratio of the WHOLE lifetime of the process.

This results in inaccurate utime and stime in "/proc/pid/stat". For
example,  a process runs for a while with "50% usr, 0% sys", then
followed by "100% sys". For later while, the following is excepted:

  0.0 usr,  100.0 sys

but we get:

  10.0 usr,  90.0 sys

This patch uses the accurate ratio in cputime_adjust() to address the
issue. A new 'task_cputime' type field is added in prev_cputime to record
previous 'task_cputime' so that we can get the elapsed times as the accurate
ratio.

Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luiz Capitulino <lcapitulino@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: baoyou.xie@gmail.com
Link: http://lkml.kernel.org/r/20180709145843.126583-1-xlpang@linux.alibaba.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h         | 34 ++++++++++++------------
 include/linux/sched/cputime.h | 12 ++++++++-
 kernel/sched/cputime.c        | 61 ++++++++++++++++---------------------------
 3 files changed, 52 insertions(+), 55 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 43731fe51c97..fedc69d4a425 100644
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
@@ -590,69 +590,54 @@ drop_precision:
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
