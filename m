Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F32C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77B121479
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77B121479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbeHPVp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:45:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56716 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730085AbeHPVp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:45:57 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 63A78CC4;
        Thu, 16 Aug 2018 18:45:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 13/22] sched/debug: Fix task state recording/printout
Date:   Thu, 16 Aug 2018 20:45:14 +0200
Message-Id: <20180816171624.726313966@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180816171622.831964729@linuxfoundation.org>
References: <20180816171622.831964729@linuxfoundation.org>
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

From: Thomas Gleixner <tglx@linutronix.de>

commit 3f5fe9fef5b2da06b6319fab8123056da5217c3f upstream.

The recent conversion of the task state recording to use task_state_index()
broke the sched_switch tracepoint task state output.

task_state_index() returns surprisingly an index (0-7) which is then
printed with __print_flags() applying bitmasks. Not really working and
resulting in weird states like 'prev_state=t' instead of 'prev_state=I'.

Use TASK_REPORT_MAX instead of TASK_STATE_MAX to report preemption. Build a
bitmask from the return value of task_state_index() and store it in
entry->prev_state, which makes __print_flags() work as expected.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: stable@vger.kernel.org
Fixes: efb40f588b43 ("sched/tracing: Fix trace_sched_switch task-state printing")
Link: http://lkml.kernel.org/r/alpine.DEB.2.20.1711221304180.1751@nanos
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/trace/events/sched.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -116,9 +116,9 @@ static inline long __trace_sched_switch_
 	 * RUNNING (we will not have dequeued if state != RUNNING).
 	 */
 	if (preempt)
-		return TASK_STATE_MAX;
+		return TASK_REPORT_MAX;
 
-	return __get_task_state(p);
+	return 1 << __get_task_state(p);
 }
 #endif /* CREATE_TRACE_POINTS */
 
@@ -164,7 +164,7 @@ TRACE_EVENT(sched_switch,
 				{ 0x40, "P" }, { 0x80, "I" }) :
 		  "R",
 
-		__entry->prev_state & TASK_STATE_MAX ? "+" : "",
+		__entry->prev_state & TASK_REPORT_MAX ? "+" : "",
 		__entry->next_comm, __entry->next_pid, __entry->next_prio)
 );
 


