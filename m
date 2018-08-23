Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E599C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AAA208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7AAA208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388567AbeHWMba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:31:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55854 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHWMb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:31:29 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3549DCA0;
        Thu, 23 Aug 2018 09:02:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, claudio@evidence.eu.com,
        rostedt@goodmis.org, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 266/324] sched/deadline: Fix switched_from_dl() warning
Date:   Thu, 23 Aug 2018 09:55:32 +0200
Message-Id: <20180823075009.287942287@linuxfoundation.org>
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

From: Juri Lelli <juri.lelli@redhat.com>

[ Upstream commit e117cb52bdb4d376b711bee34af6434c9e314b3b ]

Mark noticed that syzkaller is able to reliably trigger the following warning:

  dl_rq->running_bw > dl_rq->this_bw
  WARNING: CPU: 1 PID: 153 at kernel/sched/deadline.c:124 switched_from_dl+0x454/0x608
  Kernel panic - not syncing: panic_on_warn set ...

  CPU: 1 PID: 153 Comm: syz-executor253 Not tainted 4.18.0-rc3+ #29
  Hardware name: linux,dummy-virt (DT)
  Call trace:
   dump_backtrace+0x0/0x458
   show_stack+0x20/0x30
   dump_stack+0x180/0x250
   panic+0x2dc/0x4ec
   __warn_printk+0x0/0x150
   report_bug+0x228/0x2d8
   bug_handler+0xa0/0x1a0
   brk_handler+0x2f0/0x568
   do_debug_exception+0x1bc/0x5d0
   el1_dbg+0x18/0x78
   switched_from_dl+0x454/0x608
   __sched_setscheduler+0x8cc/0x2018
   sys_sched_setattr+0x340/0x758
   el0_svc_naked+0x30/0x34

syzkaller reproducer runs a bunch of threads that constantly switch
between DEADLINE and NORMAL classes while interacting through futexes.

The splat above is caused by the fact that if a DEADLINE task is setattr
back to NORMAL while in non_contending state (blocked on a futex -
inactive timer armed), its contribution to running_bw is not removed
before sub_rq_bw() gets called (!task_on_rq_queued() branch) and the
latter sees running_bw > this_bw.

Fix it by removing a task contribution from running_bw if the task is
not queued and in non_contending state while switched to a different
class.

Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Reviewed-by: Luca Abeni <luca.abeni@santannapisa.it>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: claudio@evidence.eu.com
Cc: rostedt@goodmis.org
Link: http://lkml.kernel.org/r/20180711072948.27061-1-juri.lelli@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/deadline.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2296,8 +2296,17 @@ static void switched_from_dl(struct rq *
 	if (task_on_rq_queued(p) && p->dl.dl_runtime)
 		task_non_contending(p);
 
-	if (!task_on_rq_queued(p))
+	if (!task_on_rq_queued(p)) {
+		/*
+		 * Inactive timer is armed. However, p is leaving DEADLINE and
+		 * might migrate away from this rq while continuing to run on
+		 * some other class. We need to remove its contribution from
+		 * this rq running_bw now, or sub_rq_bw (below) will complain.
+		 */
+		if (p->dl.dl_non_contending)
+			sub_running_bw(&p->dl, &rq->dl);
 		sub_rq_bw(&p->dl, &rq->dl);
+	}
 
 	/*
 	 * We cannot use inactive_task_timer() to invoke sub_running_bw()


