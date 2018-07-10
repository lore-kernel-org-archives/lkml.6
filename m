Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573D8C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B4120936
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B4120936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389140AbeGJSeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:34:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47926 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388051AbeGJSeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:34:02 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7452DD0B;
        Tue, 10 Jul 2018 18:33:49 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mansky Christian <man@keba.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 52/53] sched, tracing: Fix trace_sched_pi_setprio() for deboosting
Date:   Tue, 10 Jul 2018 20:25:28 +0200
Message-Id: <20180710182501.713478720@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182458.736721865@linuxfoundation.org>
References: <20180710182458.736721865@linuxfoundation.org>
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

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

commit 4ff648decf4712d39f184fc2df3163f43975575a upstream.

Since the following commit:

  b91473ff6e97 ("sched,tracing: Update trace_sched_pi_setprio()")

the sched_pi_setprio trace point shows the "newprio" during a deboost:

  |futex sched_pi_setprio: comm=futex_requeue_p pid"34 oldprio newprio=3D98
  |futex sched_switch: prev_comm=futex_requeue_p prev_pid"34 prev_prio=120

This patch open codes __rt_effective_prio() in the tracepoint as the
'newprio' to get the old behaviour back / the correct priority:

  |futex sched_pi_setprio: comm=futex_requeue_p pid"20 oldprio newprio=3D120
  |futex sched_switch: prev_comm=futex_requeue_p prev_pid"20 prev_prio=120

Peter suggested to open code the new priority so people using tracehook
could get the deadline data out.

Reported-by: Mansky Christian <man@keba.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: b91473ff6e97 ("sched,tracing: Update trace_sched_pi_setprio()")
Link: http://lkml.kernel.org/r/20180524132647.gg6ziuogczdmjjzu@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/trace/events/sched.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -435,7 +435,9 @@ TRACE_EVENT(sched_pi_setprio,
 		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
 		__entry->pid		= tsk->pid;
 		__entry->oldprio	= tsk->prio;
-		__entry->newprio	= pi_task ? pi_task->prio : tsk->prio;
+		__entry->newprio	= pi_task ?
+				min(tsk->normal_prio, pi_task->prio) :
+				tsk->normal_prio;
 		/* XXX SCHED_DEADLINE bits missing */
 	),
 


