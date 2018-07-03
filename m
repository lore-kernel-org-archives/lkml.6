Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3FBC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E4324C34
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E4324C34
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933332AbeGCHth (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:49:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39135 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932517AbeGCHtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:49:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w637mv1R201673
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Jul 2018 00:48:57 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w637muhb201669;
        Tue, 3 Jul 2018 00:48:56 -0700
Date:   Tue, 3 Jul 2018 00:48:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-d9c0ffcabd6aae7ff1e34e8078354c13bb9f1183@git.kernel.org>
Cc:     paulmck@linux.vnet.ibm.com, anna-maria@linutronix.de,
        hpa@zytor.com, peterz@infradead.org, jacekt@dug.com,
        frederic@kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org
Reply-To: frederic@kernel.org, tglx@linutronix.de, jacekt@dug.com,
          hpa@zytor.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com,
          anna-maria@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
In-Reply-To: <1530203381-31234-1-git-send-email-frederic@kernel.org>
References: <1530203381-31234-1-git-send-email-frederic@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/nohz: Skip remote tick on idle task entirely
Git-Commit-ID: d9c0ffcabd6aae7ff1e34e8078354c13bb9f1183
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

Commit-ID:  d9c0ffcabd6aae7ff1e34e8078354c13bb9f1183
Gitweb:     https://git.kernel.org/tip/d9c0ffcabd6aae7ff1e34e8078354c13bb9f1183
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Thu, 28 Jun 2018 18:29:41 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 3 Jul 2018 09:17:28 +0200

sched/nohz: Skip remote tick on idle task entirely

Some people have reported that the warning in sched_tick_remote()
occasionally triggers, especially in favour of some RCU-Torture
pressure:

	WARNING: CPU: 11 PID: 906 at kernel/sched/core.c:3138 sched_tick_remote+0xb6/0xc0
	Modules linked in:
	CPU: 11 PID: 906 Comm: kworker/u32:3 Not tainted 4.18.0-rc2+ #1
	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
	Workqueue: events_unbound sched_tick_remote
	RIP: 0010:sched_tick_remote+0xb6/0xc0
	Code: e8 0f 06 b8 00 c6 03 00 fb eb 9d 8b 43 04 85 c0 75 8d 48 8b 83 e0 0a 00 00 48 85 c0 75 81 eb 88 48 89 df e8 bc fe ff ff eb aa <0f> 0b eb
	+c5 66 0f 1f 44 00 00 bf 17 00 00 00 e8 b6 2e fe ff 0f b6
	Call Trace:
	 process_one_work+0x1df/0x3b0
	 worker_thread+0x44/0x3d0
	 kthread+0xf3/0x130
	 ? set_worker_desc+0xb0/0xb0
	 ? kthread_create_worker_on_cpu+0x70/0x70
	 ret_from_fork+0x35/0x40

This happens when the remote tick applies on an idle task. Usually the
idle_cpu() check avoids that, but it is performed before we lock the
runqueue and it is therefore racy. It was intended to be that way in
order to prevent from useless runqueue locks since idle task tick
callback is a no-op.

Now if the racy check slips out of our hands and we end up remotely
ticking an idle task, the empty task_tick_idle() is harmless. Still
it won't pass the WARN_ON_ONCE() test that ensures rq_clock_task() is
not too far from curr->se.exec_start because update_curr_idle() doesn't
update the exec_start value like other scheduler policies. Hence the
reported false positive.

So let's have another check, while the rq is locked, to make sure we
don't remote tick on an idle task. The lockless idle_cpu() still applies
to avoid unecessary rq lock contention.

Reported-by: Jacek Tomaka <jacekt@dug.com>
Reported-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Reported-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1530203381-31234-1-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 78d8facba456..22fce36426c0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3113,7 +3113,9 @@ static void sched_tick_remote(struct work_struct *work)
 	struct tick_work *twork = container_of(dwork, struct tick_work, work);
 	int cpu = twork->cpu;
 	struct rq *rq = cpu_rq(cpu);
+	struct task_struct *curr;
 	struct rq_flags rf;
+	u64 delta;
 
 	/*
 	 * Handle the tick only if it appears the remote CPU is running in full
@@ -3122,24 +3124,28 @@ static void sched_tick_remote(struct work_struct *work)
 	 * statistics and checks timeslices in a time-independent way, regardless
 	 * of when exactly it is running.
 	 */
-	if (!idle_cpu(cpu) && tick_nohz_tick_stopped_cpu(cpu)) {
-		struct task_struct *curr;
-		u64 delta;
+	if (idle_cpu(cpu) || !tick_nohz_tick_stopped_cpu(cpu))
+		goto out_requeue;
 
-		rq_lock_irq(rq, &rf);
-		update_rq_clock(rq);
-		curr = rq->curr;
-		delta = rq_clock_task(rq) - curr->se.exec_start;
+	rq_lock_irq(rq, &rf);
+	curr = rq->curr;
+	if (is_idle_task(curr))
+		goto out_unlock;
 
-		/*
-		 * Make sure the next tick runs within a reasonable
-		 * amount of time.
-		 */
-		WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
-		curr->sched_class->task_tick(rq, curr, 0);
-		rq_unlock_irq(rq, &rf);
-	}
+	update_rq_clock(rq);
+	delta = rq_clock_task(rq) - curr->se.exec_start;
+
+	/*
+	 * Make sure the next tick runs within a reasonable
+	 * amount of time.
+	 */
+	WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
+	curr->sched_class->task_tick(rq, curr, 0);
+
+out_unlock:
+	rq_unlock_irq(rq, &rf);
 
+out_requeue:
 	/*
 	 * Run the remote tick once per second (1Hz). This arbitrary
 	 * frequency is large enough to avoid overload but short enough
