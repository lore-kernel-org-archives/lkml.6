Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A80C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1962F24267
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1962F24267
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933868AbeGCJ1d (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:27:33 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43268 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754519AbeGCJZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:25:56 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=somnus.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <anna-maria@linutronix.de>)
        id 1faHZJ-0006Sm-VP; Tue, 03 Jul 2018 11:25:54 +0200
From:   Anna-Maria Gleixner <anna-maria@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [PATCH v2] hrtimer: consolidate hrtimer_init() + hrtimer_init_sleeper() calls
Date:   Tue,  3 Jul 2018 11:25:41 +0200
Message-Id: <20180703092541.2870-1-anna-maria@linutronix.de>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

hrtimer_init_sleeper() calls require a prior initialisation of the
hrtimer object with hrtimer_init(). Lets make the initialisation of
the hrtimer object part of hrtimer_init_sleeper(). To remain
consistent consider init_on_stack as well.

Beside adapting the hrtimer_init_sleeper[_on_stack]() functions, call
sites need to be updated as well.

Link: http://lkml.kernel.org/r/20170905135719.qsj4h5twhjkmkbak@linutronix.de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[anna-maria: Updating the commit message]
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---

v1..v2: Fix missing call site in drivers/staging/android/vsoc.c

 block/blk-mq.c                 |  3 +--
 drivers/staging/android/vsoc.c |  6 ++---
 include/linux/hrtimer.h        | 19 +++++++++++---
 include/linux/wait.h           |  4 +--
 kernel/futex.c                 | 19 ++++++--------
 kernel/time/hrtimer.c          | 46 ++++++++++++++++++++++++++--------
 net/core/pktgen.c              |  4 +--
 7 files changed, 67 insertions(+), 34 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 95919268564b..f95ad9ede0f6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2984,10 +2984,9 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 	kt = nsecs;
 
 	mode = HRTIMER_MODE_REL;
-	hrtimer_init_on_stack(&hs.timer, CLOCK_MONOTONIC, mode);
+	hrtimer_init_sleeper_on_stack(&hs, CLOCK_MONOTONIC, mode, current);
 	hrtimer_set_expires(&hs.timer, kt);
 
-	hrtimer_init_sleeper(&hs, current);
 	do {
 		if (blk_mq_rq_state(rq) == MQ_RQ_COMPLETE)
 			break;
diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
index 806beda1040b..6c7f666c0e33 100644
--- a/drivers/staging/android/vsoc.c
+++ b/drivers/staging/android/vsoc.c
@@ -438,12 +438,10 @@ static int handle_vsoc_cond_wait(struct file *filp, struct vsoc_cond_wait *arg)
 
 		if (!timespec_valid(&ts))
 			return -EINVAL;
-		hrtimer_init_on_stack(&to->timer, CLOCK_MONOTONIC,
-				      HRTIMER_MODE_ABS);
+		hrtimer_init_sleeper_on_stack(to, CLOCK_MONOTONIC,
+					      HRTIMER_MODE_ABS, current);
 		hrtimer_set_expires_range_ns(&to->timer, timespec_to_ktime(ts),
 					     current->timer_slack_ns);
-
-		hrtimer_init_sleeper(to, current);
 	}
 
 	while (1) {
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 3892e9c8b2de..b8bbaabd5aff 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -364,10 +364,17 @@ DECLARE_PER_CPU(struct tick_device, tick_cpu_device);
 /* Initialize timers: */
 extern void hrtimer_init(struct hrtimer *timer, clockid_t which_clock,
 			 enum hrtimer_mode mode);
+extern void hrtimer_init_sleeper(struct hrtimer_sleeper *sl, clockid_t clock_id,
+				 enum hrtimer_mode mode,
+				 struct task_struct *task);
 
 #ifdef CONFIG_DEBUG_OBJECTS_TIMERS
 extern void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t which_clock,
 				  enum hrtimer_mode mode);
+extern void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
+					  clockid_t clock_id,
+					  enum hrtimer_mode mode,
+					  struct task_struct *task);
 
 extern void destroy_hrtimer_on_stack(struct hrtimer *timer);
 #else
@@ -377,6 +384,15 @@ static inline void hrtimer_init_on_stack(struct hrtimer *timer,
 {
 	hrtimer_init(timer, which_clock, mode);
 }
+
+static inline void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
+					    clockid_t clock_id,
+					    enum hrtimer_mode mode,
+					    struct task_struct *task)
+{
+	hrtimer_init_sleeper(sl, clock_id, mode, task);
+}
+
 static inline void destroy_hrtimer_on_stack(struct hrtimer *timer) { }
 #endif
 
@@ -480,9 +496,6 @@ extern long hrtimer_nanosleep(const struct timespec64 *rqtp,
 			      const enum hrtimer_mode mode,
 			      const clockid_t clockid);
 
-extern void hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
-				 struct task_struct *tsk);
-
 extern int schedule_hrtimeout_range(ktime_t *expires, u64 delta,
 						const enum hrtimer_mode mode);
 extern int schedule_hrtimeout_range_clock(ktime_t *expires,
diff --git a/include/linux/wait.h b/include/linux/wait.h
index d9f131ecf708..a0938fc8dcdb 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -488,8 +488,8 @@ do {										\
 	int __ret = 0;								\
 	struct hrtimer_sleeper __t;						\
 										\
-	hrtimer_init_on_stack(&__t.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);	\
-	hrtimer_init_sleeper(&__t, current);					\
+	hrtimer_init_sleeper_on_stack(&__t, CLOCK_MONOTONIC, HRTIMER_MODE_REL,	\
+				      current);					\
 	if ((timeout) != KTIME_MAX)						\
 		hrtimer_start_range_ns(&__t.timer, timeout,			\
 				       current->timer_slack_ns,			\
diff --git a/kernel/futex.c b/kernel/futex.c
index 1f450e092c74..146432d78e06 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2624,10 +2624,9 @@ static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 	if (abs_time) {
 		to = &timeout;
 
-		hrtimer_init_on_stack(&to->timer, (flags & FLAGS_CLOCKRT) ?
-				      CLOCK_REALTIME : CLOCK_MONOTONIC,
-				      HRTIMER_MODE_ABS);
-		hrtimer_init_sleeper(to, current);
+		hrtimer_init_sleeper_on_stack(to, (flags & FLAGS_CLOCKRT) ?
+					      CLOCK_REALTIME : CLOCK_MONOTONIC,
+					      HRTIMER_MODE_ABS, current);
 		hrtimer_set_expires_range_ns(&to->timer, *abs_time,
 					     current->timer_slack_ns);
 	}
@@ -2726,9 +2725,8 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 
 	if (time) {
 		to = &timeout;
-		hrtimer_init_on_stack(&to->timer, CLOCK_REALTIME,
-				      HRTIMER_MODE_ABS);
-		hrtimer_init_sleeper(to, current);
+		hrtimer_init_sleeper_on_stack(to, CLOCK_REALTIME,
+					      HRTIMER_MODE_ABS, current);
 		hrtimer_set_expires(&to->timer, *time);
 	}
 
@@ -3125,10 +3123,9 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 
 	if (abs_time) {
 		to = &timeout;
-		hrtimer_init_on_stack(&to->timer, (flags & FLAGS_CLOCKRT) ?
-				      CLOCK_REALTIME : CLOCK_MONOTONIC,
-				      HRTIMER_MODE_ABS);
-		hrtimer_init_sleeper(to, current);
+		hrtimer_init_sleeper_on_stack(to, (flags & FLAGS_CLOCKRT) ?
+					      CLOCK_REALTIME : CLOCK_MONOTONIC,
+					      HRTIMER_MODE_ABS, current);
 		hrtimer_set_expires_range_ns(&to->timer, *abs_time,
 					     current->timer_slack_ns);
 	}
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 3e93c54bd3a1..56ff1c889b18 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1649,13 +1649,44 @@ static enum hrtimer_restart hrtimer_wakeup(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-void hrtimer_init_sleeper(struct hrtimer_sleeper *sl, struct task_struct *task)
+static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
+				   clockid_t clock_id,
+				   enum hrtimer_mode mode,
+				   struct task_struct *task)
 {
+	__hrtimer_init(&sl->timer, clock_id, mode);
 	sl->timer.function = hrtimer_wakeup;
 	sl->task = task;
 }
+
+/**
+ * hrtimer_init_sleeper - initialize sleeper to the given clock
+ * @sl:		sleeper to be initialized
+ * @clock_id:	the clock to be used
+ * @mode:	timer mode abs/rel
+ * @task:	the task to wake up
+ */
+void hrtimer_init_sleeper(struct hrtimer_sleeper *sl, clockid_t clock_id,
+			  enum hrtimer_mode mode, struct task_struct *task)
+{
+	debug_init(&sl->timer, clock_id, mode);
+	__hrtimer_init_sleeper(sl, clock_id, mode, task);
+
+}
 EXPORT_SYMBOL_GPL(hrtimer_init_sleeper);
 
+#ifdef CONFIG_DEBUG_OBJECTS_TIMERS
+void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
+				   clockid_t clock_id,
+				   enum hrtimer_mode mode,
+				   struct task_struct *task)
+{
+	debug_object_init_on_stack(&sl->timer, &hrtimer_debug_descr);
+	__hrtimer_init_sleeper(sl, clock_id, mode, task);
+}
+EXPORT_SYMBOL_GPL(hrtimer_init_sleeper_on_stack);
+#endif
+
 int nanosleep_copyout(struct restart_block *restart, struct timespec64 *ts)
 {
 	switch(restart->nanosleep.type) {
@@ -1679,8 +1710,6 @@ static int __sched do_nanosleep(struct hrtimer_sleeper *t, enum hrtimer_mode mod
 {
 	struct restart_block *restart;
 
-	hrtimer_init_sleeper(t, current);
-
 	do {
 		set_current_state(TASK_INTERRUPTIBLE);
 		hrtimer_start_expires(&t->timer, mode);
@@ -1717,10 +1746,9 @@ static long __sched hrtimer_nanosleep_restart(struct restart_block *restart)
 	struct hrtimer_sleeper t;
 	int ret;
 
-	hrtimer_init_on_stack(&t.timer, restart->nanosleep.clockid,
-				HRTIMER_MODE_ABS);
+	hrtimer_init_sleeper_on_stack(&t, restart->nanosleep.clockid,
+				      HRTIMER_MODE_ABS, current);
 	hrtimer_set_expires_tv64(&t.timer, restart->nanosleep.expires);
-
 	ret = do_nanosleep(&t, HRTIMER_MODE_ABS);
 	destroy_hrtimer_on_stack(&t.timer);
 	return ret;
@@ -1738,7 +1766,7 @@ long hrtimer_nanosleep(const struct timespec64 *rqtp,
 	if (dl_task(current) || rt_task(current))
 		slack = 0;
 
-	hrtimer_init_on_stack(&t.timer, clockid, mode);
+	hrtimer_init_sleeper_on_stack(&t, clockid, mode, current);
 	hrtimer_set_expires_range_ns(&t.timer, timespec64_to_ktime(*rqtp), slack);
 	ret = do_nanosleep(&t, mode);
 	if (ret != -ERESTART_RESTARTBLOCK)
@@ -1937,11 +1965,9 @@ schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
 		return -EINTR;
 	}
 
-	hrtimer_init_on_stack(&t.timer, clock_id, mode);
+	hrtimer_init_sleeper_on_stack(&t, clock_id, mode, current);
 	hrtimer_set_expires_range_ns(&t.timer, *expires, delta);
 
-	hrtimer_init_sleeper(&t, current);
-
 	hrtimer_start_expires(&t.timer, mode);
 
 	if (likely(t.task))
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 49368e21d228..ac2d059ad598 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -2162,7 +2162,8 @@ static void spin(struct pktgen_dev *pkt_dev, ktime_t spin_until)
 	s64 remaining;
 	struct hrtimer_sleeper t;
 
-	hrtimer_init_on_stack(&t.timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	hrtimer_init_sleeper_on_stack(&t, CLOCK_MONOTONIC, HRTIMER_MODE_ABS,
+				      current);
 	hrtimer_set_expires(&t.timer, spin_until);
 
 	remaining = ktime_to_ns(hrtimer_expires_remaining(&t.timer));
@@ -2177,7 +2178,6 @@ static void spin(struct pktgen_dev *pkt_dev, ktime_t spin_until)
 		} while (ktime_compare(end_time, spin_until) < 0);
 	} else {
 		/* see do_nanosleep */
-		hrtimer_init_sleeper(&t, current);
 		do {
 			set_current_state(TASK_INTERRUPTIBLE);
 			hrtimer_start_expires(&t.timer, HRTIMER_MODE_ABS);
-- 
2.18.0

