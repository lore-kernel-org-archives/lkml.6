Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEED7C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE3520843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE3520843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbeGYPdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:33:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58063 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbeGYPdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:33:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PELAle400159
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:21:10 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PEL91X400156;
        Wed, 25 Jul 2018 07:21:09 -0700
Date:   Wed, 25 Jul 2018 07:21:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Isaac J. Manjarres" <tipbot@zytor.com>
Message-ID: <tip-2610e88946632afb78aa58e61f11368ac4c0af7b@git.kernel.org>
Cc:     psodagud@codeaurora.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        isaacm@codeaurora.org, torvalds@linux-foundation.org,
        pkondeti@codeaurora.org, peterz@infradead.org
Reply-To: mingo@kernel.org, isaacm@codeaurora.org, hpa@zytor.com,
          pkondeti@codeaurora.org, torvalds@linux-foundation.org,
          peterz@infradead.org, psodagud@codeaurora.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <1531856129-9871-1-git-send-email-isaacm@codeaurora.org>
References: <1531856129-9871-1-git-send-email-isaacm@codeaurora.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] stop_machine: Disable preemption after queueing
 stopper threads
Git-Commit-ID: 2610e88946632afb78aa58e61f11368ac4c0af7b
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

Commit-ID:  2610e88946632afb78aa58e61f11368ac4c0af7b
Gitweb:     https://git.kernel.org/tip/2610e88946632afb78aa58e61f11368ac4c0af7b
Author:     Isaac J. Manjarres <isaacm@codeaurora.org>
AuthorDate: Tue, 17 Jul 2018 12:35:29 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:25:08 +0200

stop_machine: Disable preemption after queueing stopper threads

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
---
 kernel/stop_machine.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 1ff523dae6e2..e190d1ef3a23 100644
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
