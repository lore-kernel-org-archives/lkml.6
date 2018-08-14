Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D148C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4B5216E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A4B5216E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbeHNUXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:23:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57188 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729177AbeHNUXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:23:17 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 27F0CE21;
        Tue, 14 Aug 2018 17:35:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, bigeasy@linutronix.de,
        matt@codeblueprint.co.uk, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 008/104] stop_machine: Disable preemption after queueing stopper threads
Date:   Tue, 14 Aug 2018 19:16:22 +0200
Message-Id: <20180814171515.777916480@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171515.270692185@linuxfoundation.org>
References: <20180814171515.270692185@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Isaac J. Manjarres <isaacm@codeaurora.org>

commit 2610e88946632afb78aa58e61f11368ac4c0af7b upstream.

This commit:

  9fb8d5dc4b64 ("stop_machine, Disable preemption when waking two stopper threads")

does not fully address the race condition that can occur
as follows:

On one CPU, call it CPU 3, thread 1 invokes
cpu_stop_queue_two_works(2, 3,...), and the execution is such
that thread 1 queues the works for migration/2 and migration/3,
and is preempted after releasing the locks for migration/2 and
migration/3, but before waking the threads.

Then, On CPU 2, a kworker, call it thread 2, is running,
and it invokes cpu_stop_queue_two_works(1, 2,...), such that
thread 2 queues the works for migration/1 and migration/2.
Meanwhile, on CPU 3, thread 1 resumes execution, and wakes
migration/2 and migration/3. This means that when CPU 2
releases the locks for migration/1 and migration/2, but before
it wakes those threads, it can be preempted by migration/2.

If thread 2 is preempted by migration/2, then migration/2 will
execute the first work item successfully, since migration/3
was woken up by CPU 3, but when it goes to execute the second
work item, it disables preemption, calls multi_cpu_stop(),
and thus, CPU 2 will wait forever for migration/1, which should
have been woken up by thread 2. However migration/1 cannot be
woken up by thread 2, since it is a kworker, so it is affine to
CPU 2, but CPU 2 is running migration/2 with preemption
disabled, so thread 2 will never run.

Disable preemption after queueing works for stopper threads
to ensure that the operation of queueing the works and waking
the stopper threads is atomic.

Co-Developed-by: Prasad Sodagudi <psodagud@codeaurora.org>
Co-Developed-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bigeasy@linutronix.de
Cc: gregkh@linuxfoundation.org
Cc: matt@codeblueprint.co.uk
Fixes: 9fb8d5dc4b64 ("stop_machine, Disable preemption when waking two stopper threads")
Link: http://lkml.kernel.org/r/1531856129-9871-1-git-send-email-isaacm@codeaurora.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/stop_machine.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -260,6 +260,15 @@ retry:
 	err = 0;
 	__cpu_stop_queue_work(stopper1, work1, &wakeq);
 	__cpu_stop_queue_work(stopper2, work2, &wakeq);
+	/*
+	 * The waking up of stopper threads has to happen
+	 * in the same scheduling context as the queueing.
+	 * Otherwise, there is a possibility of one of the
+	 * above stoppers being woken up by another CPU,
+	 * and preempting us. This will cause us to n ot
+	 * wake up the other stopper forever.
+	 */
+	preempt_disable();
 unlock:
 	raw_spin_unlock(&stopper2->lock);
 	raw_spin_unlock_irq(&stopper1->lock);
@@ -271,7 +280,6 @@ unlock:
 	}
 
 	if (!err) {
-		preempt_disable();
 		wake_up_q(&wakeq);
 		preempt_enable();
 	}


