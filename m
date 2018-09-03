Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE024C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD9120843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD9120843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeICQFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 12:05:33 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:22531 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbeICQFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 12:05:33 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w83Bj1Kt098220;
        Mon, 3 Sep 2018 20:45:01 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Mon, 03 Sep 2018 20:45:01 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w83BiuEf098197
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Sep 2018 20:45:01 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH] kernel/{lockdep,hung_task}: Show locks and backtrace of running tasks.
Date:   Mon,  3 Sep 2018 20:44:57 +0900
Message-Id: <1535975097-19080-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are getting reports from syzbot where running task seems to be
relevant to a hung task problem but NMI backtrace does not print useful
information [1].

Although commit 8cc05c71ba5f7936 ("locking/lockdep: Move sanity check to
inside lockdep_print_held_locks()") says that calling
lockdep_print_held_locks() on a running thread is considered unsafe,
it is useful for syzbot to show locks and backtrace of running tasks.
Thus, let's allow it if CONFIG_DEBUG_AID_FOR_SYZBOT is defined.

[1] https://syzkaller.appspot.com/bug?id=8bab7a6a5597bb10f90e8227a7d8a483748d93be

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 kernel/hung_task.c       | 20 ++++++++++++++++++++
 kernel/locking/lockdep.c |  9 +++++++++
 2 files changed, 29 insertions(+)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index b9132d1..1ac49a5 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -201,6 +201,26 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	if (hung_task_show_lock)
 		debug_show_all_locks();
 	if (hung_task_call_panic) {
+#ifdef CONFIG_DEBUG_AID_FOR_SYZBOT
+		/*
+		 * debug_show_all_locks() above forcibly dumped locks held by
+		 * running tasks with locks held. Now, let's dump backtrace of
+		 * running tasks as well, for NMI backtrace below tends to show
+		 * current thread (i.e. khungtaskd thread itself) and idle CPU
+		 * which are useless for debugging hung task problems.
+		 */
+		rcu_read_lock();
+		for_each_process_thread(g, t) {
+			if (t->state != TASK_RUNNING || t == current)
+				continue;
+			pr_err("INFO: task %s:%d was running.\n", t->comm,
+			       t->pid);
+			sched_show_task(t);
+			touch_nmi_watchdog();
+			touch_all_softlockup_watchdogs();
+		}
+		rcu_read_unlock();
+#endif
 		trigger_all_cpu_backtrace();
 		panic("hung_task: blocked tasks");
 	}
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e406c5f..efeebf6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -565,12 +565,21 @@ static void lockdep_print_held_locks(struct task_struct *p)
 	else
 		printk("%d lock%s held by %s/%d:\n", depth,
 		       depth > 1 ? "s" : "", p->comm, task_pid_nr(p));
+#ifndef CONFIG_DEBUG_AID_FOR_SYZBOT
 	/*
 	 * It's not reliable to print a task's held locks if it's not sleeping
 	 * and it's not the current task.
 	 */
 	if (p->state == TASK_RUNNING && p != current)
 		return;
+#else
+	/*
+	 * But showing locks and backtrace of running tasks seems to be helpful
+	 * for debugging hung task problems. Since syzbot will call panic()
+	 * shortly, risking problems caused by accessing stale information is
+	 * acceptable here.
+	 */
+#endif
 	for (i = 0; i < depth; i++) {
 		printk(" #%d: ", i);
 		print_lock(p->held_locks + i);
-- 
1.8.3.1

