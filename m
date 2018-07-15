Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4E6ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E189208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E189208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeGOXuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 19:50:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52477 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbeGOXuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 19:50:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FNOqio920883
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 16:24:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FNOqO0920880;
        Sun, 15 Jul 2018 16:24:52 -0700
Date:   Sun, 15 Jul 2018 16:24:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juri Lelli <tipbot@zytor.com>
Message-ID: <tip-e117cb52bdb4d376b711bee34af6434c9e314b3b@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        mark.rutland@arm.com, mingo@kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org,
        juri.lelli@redhat.com, luca.abeni@santannapisa.it,
        bristot@redhat.com
Reply-To: hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
          bristot@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
          luca.abeni@santannapisa.it, mark.rutland@arm.com,
          mingo@kernel.org, torvalds@linux-foundation.org
In-Reply-To: <20180711072948.27061-1-juri.lelli@redhat.com>
References: <20180711072948.27061-1-juri.lelli@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/deadline: Fix switched_from_dl() warning
Git-Commit-ID: e117cb52bdb4d376b711bee34af6434c9e314b3b
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

Commit-ID:  e117cb52bdb4d376b711bee34af6434c9e314b3b
Gitweb:     https://git.kernel.org/tip/e117cb52bdb4d376b711bee34af6434c9e314b3b
Author:     Juri Lelli <juri.lelli@redhat.com>
AuthorDate: Wed, 11 Jul 2018 09:29:48 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 15 Jul 2018 23:47:33 +0200

sched/deadline: Fix switched_from_dl() warning

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
---
 kernel/sched/deadline.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index fbfc3f1d368a..10c7b51c0d1f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2290,8 +2290,17 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
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
