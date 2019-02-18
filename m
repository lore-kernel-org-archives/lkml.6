Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C14C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A62421738
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389271AbfBRQbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:31:12 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:57142 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732378AbfBRQbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:31:11 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gvloy-000396-PA; Mon, 18 Feb 2019 17:31:08 +0100
Date:   Mon, 18 Feb 2019 17:31:08 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-rt-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/2] softirq: Avoid "local_softirq_pending" messages if
 ksoftirqd is blocked
Message-ID: <20190218163107.iwdpngwmbs6xyk7x@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the ksoftirqd thread has a softirq pending and is blocked on the
`local_softirq_locks' lock then softirq_check_pending_idle() won't
complain because the "lock owner" will mask away this softirq from the
mask of pending softirqs.
If ksoftirqd has an additional softirq pending then it won't be masked
out because we never look at ksoftirqd's mask.

If there are still pending softirqs while going to idle check
ksoftirqd's and ktimersfotd's mask before complaining about unhandled
softirqs.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/softirq.c | 58 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 16 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index c15583162a559..8da664eb843a4 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -92,6 +92,31 @@ static inline void softirq_clr_runner(unsigned int sirq)
 	sr->runner[sirq] = NULL;
 }
 
+static bool softirq_check_runner_tsk(struct task_struct *tsk,
+				     unsigned int *pending)
+{
+	bool ret = false;
+
+	if (!tsk)
+		return ret;
+
+	/*
+	 * The wakeup code in rtmutex.c wakes up the task
+	 * _before_ it sets pi_blocked_on to NULL under
+	 * tsk->pi_lock. So we need to check for both: state
+	 * and pi_blocked_on.
+	 */
+	raw_spin_lock(&tsk->pi_lock);
+	if (tsk->pi_blocked_on || tsk->state == TASK_RUNNING) {
+		/* Clear all bits pending in that task */
+		*pending &= ~(tsk->softirqs_raised);
+		ret = true;
+	}
+	raw_spin_unlock(&tsk->pi_lock);
+
+	return ret;
+}
+
 /*
  * On preempt-rt a softirq running context might be blocked on a
  * lock. There might be no other runnable task on this CPU because the
@@ -104,6 +129,7 @@ static inline void softirq_clr_runner(unsigned int sirq)
  */
 void softirq_check_pending_idle(void)
 {
+	struct task_struct *tsk;
 	static int rate_limit;
 	struct softirq_runner *sr = this_cpu_ptr(&softirq_runners);
 	u32 warnpending;
@@ -113,26 +139,26 @@ void softirq_check_pending_idle(void)
 		return;
 
 	warnpending = local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK;
+	if (!warnpending)
+		return;
 	for (i = 0; i < NR_SOFTIRQS; i++) {
-		struct task_struct *tsk = sr->runner[i];
+		tsk = sr->runner[i];
 
-		/*
-		 * The wakeup code in rtmutex.c wakes up the task
-		 * _before_ it sets pi_blocked_on to NULL under
-		 * tsk->pi_lock. So we need to check for both: state
-		 * and pi_blocked_on.
-		 */
-		if (tsk) {
-			raw_spin_lock(&tsk->pi_lock);
-			if (tsk->pi_blocked_on || tsk->state == TASK_RUNNING) {
-				/* Clear all bits pending in that task */
-				warnpending &= ~(tsk->softirqs_raised);
-				warnpending &= ~(1 << i);
-			}
-			raw_spin_unlock(&tsk->pi_lock);
-		}
+		if (softirq_check_runner_tsk(tsk, &warnpending))
+			warnpending &= ~(1 << i);
 	}
 
+	if (warnpending) {
+		tsk = __this_cpu_read(ksoftirqd);
+		softirq_check_runner_tsk(tsk, &warnpending);
+	}
+
+	if (warnpending) {
+		tsk = __this_cpu_read(ktimer_softirqd);
+		softirq_check_runner_tsk(tsk, &warnpending);
+	}
+
+
 	if (warnpending) {
 		printk(KERN_ERR "NOHZ: local_softirq_pending %02x\n",
 		       warnpending);
-- 
2.20.1

