Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9C3C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C36214F1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C36214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387540AbeHBPT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:19:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56253 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387454AbeHBPTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:19:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w72DRqbM3515865
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 06:27:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w72DRqnx3515862;
        Thu, 2 Aug 2018 06:27:52 -0700
Date:   Thu, 2 Aug 2018 06:27:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-b80a2bfce85e1051056d98d04ecb2d0b55cbbc1c@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, bigeasy@linutronix.de, hpa@zytor.com,
        mingo@kernel.org
Reply-To: bigeasy@linutronix.de, peterz@infradead.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20180730112140.GH2494@hirez.programming.kicks-ass.net>
References: <20180730112140.GH2494@hirez.programming.kicks-ass.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] stop_machine: Reflow cpu_stop_queue_two_works()
Git-Commit-ID: b80a2bfce85e1051056d98d04ecb2d0b55cbbc1c
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

Commit-ID:  b80a2bfce85e1051056d98d04ecb2d0b55cbbc1c
Gitweb:     https://git.kernel.org/tip/b80a2bfce85e1051056d98d04ecb2d0b55cbbc1c
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Mon, 30 Jul 2018 13:21:40 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 2 Aug 2018 15:25:20 +0200

stop_machine: Reflow cpu_stop_queue_two_works()

The code flow in cpu_stop_queue_two_works() is a little arcane; fix this by
lifting the preempt_disable() to the top to create more natural nesting wrt
the spinlocks and make the wake_up_q() and preempt_enable() unconditional
at the end.

Furthermore, enable preemption in the -EDEADLK case, such that we spin-wait
with preemption enabled.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: isaacm@codeaurora.org
Cc: matt@codeblueprint.co.uk
Cc: psodagud@codeaurora.org
Cc: gregkh@linuxfoundation.org
Cc: pkondeti@codeaurora.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180730112140.GH2494@hirez.programming.kicks-ass.net
---
 kernel/stop_machine.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index e190d1ef3a23..34b6652e8677 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -236,13 +236,24 @@ static int cpu_stop_queue_two_works(int cpu1, struct cpu_stop_work *work1,
 	struct cpu_stopper *stopper2 = per_cpu_ptr(&cpu_stopper, cpu2);
 	DEFINE_WAKE_Q(wakeq);
 	int err;
+
 retry:
+	/*
+	 * The waking up of stopper threads has to happen in the same
+	 * scheduling context as the queueing.  Otherwise, there is a
+	 * possibility of one of the above stoppers being woken up by another
+	 * CPU, and preempting us. This will cause us to not wake up the other
+	 * stopper forever.
+	 */
+	preempt_disable();
 	raw_spin_lock_irq(&stopper1->lock);
 	raw_spin_lock_nested(&stopper2->lock, SINGLE_DEPTH_NESTING);
 
-	err = -ENOENT;
-	if (!stopper1->enabled || !stopper2->enabled)
+	if (!stopper1->enabled || !stopper2->enabled) {
+		err = -ENOENT;
 		goto unlock;
+	}
+
 	/*
 	 * Ensure that if we race with __stop_cpus() the stoppers won't get
 	 * queued up in reverse order leading to system deadlock.
@@ -253,36 +264,30 @@ retry:
 	 * It can be falsely true but it is safe to spin until it is cleared,
 	 * queue_stop_cpus_work() does everything under preempt_disable().
 	 */
-	err = -EDEADLK;
-	if (unlikely(stop_cpus_in_progress))
-			goto unlock;
+	if (unlikely(stop_cpus_in_progress)) {
+		err = -EDEADLK;
+		goto unlock;
+	}
 
 	err = 0;
 	__cpu_stop_queue_work(stopper1, work1, &wakeq);
 	__cpu_stop_queue_work(stopper2, work2, &wakeq);
-	/*
-	 * The waking up of stopper threads has to happen
-	 * in the same scheduling context as the queueing.
-	 * Otherwise, there is a possibility of one of the
-	 * above stoppers being woken up by another CPU,
-	 * and preempting us. This will cause us to n ot
-	 * wake up the other stopper forever.
-	 */
-	preempt_disable();
+
 unlock:
 	raw_spin_unlock(&stopper2->lock);
 	raw_spin_unlock_irq(&stopper1->lock);
 
 	if (unlikely(err == -EDEADLK)) {
+		preempt_enable();
+
 		while (stop_cpus_in_progress)
 			cpu_relax();
+
 		goto retry;
 	}
 
-	if (!err) {
-		wake_up_q(&wakeq);
-		preempt_enable();
-	}
+	wake_up_q(&wakeq);
+	preempt_enable();
 
 	return err;
 }
