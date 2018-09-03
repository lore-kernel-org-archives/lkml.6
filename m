Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02BAC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89E620658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B89E620658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbeICV5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:57:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48082 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbeICV5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:57:16 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3BBDDD16;
        Mon,  3 Sep 2018 17:36:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        isaacm@codeaurora.org, matt@codeblueprint.co.uk,
        psodagud@codeaurora.org, pkondeti@codeaurora.org
Subject: [PATCH 4.18 039/123] stop_machine: Reflow cpu_stop_queue_two_works()
Date:   Mon,  3 Sep 2018 18:56:23 +0200
Message-Id: <20180903165721.129191585@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit b80a2bfce85e1051056d98d04ecb2d0b55cbbc1c upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/stop_machine.c |   41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -236,13 +236,24 @@ static int cpu_stop_queue_two_works(int
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


