Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DBDC43615
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACE020839
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ACE020839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387933AbeHWMVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:21:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51782 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733210AbeHWMVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:21:18 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 54D4FC74;
        Thu, 23 Aug 2018 08:52:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacek Tomaka <jacekt@dug.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 168/324] sched/nohz: Skip remote tick on idle task entirely
Date:   Thu, 23 Aug 2018 09:53:54 +0200
Message-Id: <20180823075004.577143309@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frederic Weisbecker <frederic@kernel.org>

[ Upstream commit d9c0ffcabd6aae7ff1e34e8078354c13bb9f1183 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/core.c |   40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3127,7 +3127,9 @@ static void sched_tick_remote(struct wor
 	struct tick_work *twork = container_of(dwork, struct tick_work, work);
 	int cpu = twork->cpu;
 	struct rq *rq = cpu_rq(cpu);
+	struct task_struct *curr;
 	struct rq_flags rf;
+	u64 delta;
 
 	/*
 	 * Handle the tick only if it appears the remote CPU is running in full
@@ -3136,24 +3138,28 @@ static void sched_tick_remote(struct wor
 	 * statistics and checks timeslices in a time-independent way, regardless
 	 * of when exactly it is running.
 	 */
-	if (!idle_cpu(cpu) && tick_nohz_tick_stopped_cpu(cpu)) {
-		struct task_struct *curr;
-		u64 delta;
-
-		rq_lock_irq(rq, &rf);
-		update_rq_clock(rq);
-		curr = rq->curr;
-		delta = rq_clock_task(rq) - curr->se.exec_start;
-
-		/*
-		 * Make sure the next tick runs within a reasonable
-		 * amount of time.
-		 */
-		WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
-		curr->sched_class->task_tick(rq, curr, 0);
-		rq_unlock_irq(rq, &rf);
-	}
+	if (idle_cpu(cpu) || !tick_nohz_tick_stopped_cpu(cpu))
+		goto out_requeue;
 
+	rq_lock_irq(rq, &rf);
+	curr = rq->curr;
+	if (is_idle_task(curr))
+		goto out_unlock;
+
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
+
+out_requeue:
 	/*
 	 * Run the remote tick once per second (1Hz). This arbitrary
 	 * frequency is large enough to avoid overload but short enough


