Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F30C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12E720825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12E720825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeKHTou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 14:44:50 -0500
Received: from lgeamrelo12.lge.com ([156.147.23.52]:59412 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726758AbeKHTot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 14:44:49 -0500
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.52 with ESMTP; 8 Nov 2018 19:10:03 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO kernel.lge.com) (165.186.175.97)
        by 156.147.1.121 with ESMTP; 8 Nov 2018 19:10:03 +0900
X-Original-SENDERIP: 165.186.175.97
X-Original-MAILFROM: chanho.min@lge.com
From:   Chanho Min <chanho.min@lge.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seungho Park <seungho1.park@lge.com>,
        Chanho Min <chanho.min@lge.com>
Subject: [PATCH] freezer: fix freeze timeout on exec
Date:   Thu,  8 Nov 2018 19:09:55 +0900
Message-Id: <1541671796-8725-1-git-send-email-chanho.min@lge.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suspend fails due to the exec family of fuctnions blocking the freezer.
This issue has been found that it is mentioned in the ancient mail thread.
The casue is that de_thread() sleeps in TASK_UNINTERRUPTIBLE waiting for all
sub-threads to die, and we have the "deadlock" if one of them is frozen.
It causes freeze timeout as bellows.

Freezing of tasks failed after 20.010 seconds (1 tasks refusing to freeze, wq_busy=0):
setcpushares-ls D ffffffc00008ed70     0  5817   1483 0x0040000d
 Call trace:
[<ffffffc00008ed70>] __switch_to+0x88/0xa0
[<ffffffc000d1c30c>] __schedule+0x1bc/0x720
[<ffffffc000d1ca90>] schedule+0x40/0xa8
[<ffffffc0001cd784>] flush_old_exec+0xdc/0x640
[<ffffffc000220360>] load_elf_binary+0x2a8/0x1090
[<ffffffc0001ccff4>] search_binary_handler+0x9c/0x240
[<ffffffc00021c584>] load_script+0x20c/0x228
[<ffffffc0001ccff4>] search_binary_handler+0x9c/0x240
[<ffffffc0001ce8e0>] do_execveat_common.isra.14+0x4f8/0x6e8
[<ffffffc0001cedd0>] compat_SyS_execve+0x38/0x48
[<ffffffc00008de30>] el0_svc_naked+0x24/0x28

To fix this, I suggest a patch by emboding the mentioned solution.
First, revive and rework cancel_freezing_and_thaw() function whitch stops the
task from sleeping in refrigirator reliably. And, The task to be killed does not
allow to freeze.

Reference:
http://lkml.iu.edu/hypermail//linux/kernel/0702.2/1300.html

Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 include/linux/freezer.h |  7 +++++++
 kernel/freezer.c        | 14 ++++++++++++++
 kernel/signal.c         |  7 +++++++
 3 files changed, 28 insertions(+)

diff --git a/include/linux/freezer.h b/include/linux/freezer.h
index 21f5aa0..1c1e3cb 100644
--- a/include/linux/freezer.h
+++ b/include/linux/freezer.h
@@ -57,6 +57,12 @@ static inline bool try_to_freeze_unsafe(void)
 	might_sleep();
 	if (likely(!freezing(current)))
 		return false;
+	/*
+	 * we are going to call do_exit() really soon,
+	 * we have a pending SIGKILL
+	 */
+	if (unlikely(current->signal->flags & SIGNAL_GROUP_EXIT))
+		return false;
 	return __refrigerator(false);
 }
 
@@ -68,6 +74,7 @@ static inline bool try_to_freeze(void)
 }
 
 extern bool freeze_task(struct task_struct *p);
+extern void cancel_freezing_thaw_task(struct task_struct *p);
 extern bool set_freezable(void);
 
 #ifdef CONFIG_CGROUP_FREEZER
diff --git a/kernel/freezer.c b/kernel/freezer.c
index b162b74..584c5c8 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -148,6 +148,20 @@ bool freeze_task(struct task_struct *p)
 	return true;
 }
 
+void cancel_freezing_thaw_task(struct task_struct *p)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&freezer_lock, flags);
+	if (freezing(p)) {
+		spin_lock(&p->sighand->siglock);
+		recalc_sigpending_and_wake(p);
+		spin_unlock(&p->sighand->siglock);
+	} else if (frozen(p))
+		wake_up_process(p);
+	spin_unlock_irqrestore(&freezer_lock, flags);
+}
+
 void __thaw_task(struct task_struct *p)
 {
 	unsigned long flags;
diff --git a/kernel/signal.c b/kernel/signal.c
index 5843c54..ca9b25b 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -41,6 +41,7 @@
 #include <linux/compiler.h>
 #include <linux/posix-timers.h>
 #include <linux/livepatch.h>
+#include <linux/freezer.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/signal.h>
@@ -1273,6 +1274,12 @@ int zap_other_threads(struct task_struct *p)
 		/* Don't bother with already dead threads */
 		if (t->exit_state)
 			continue;
+
+		/*
+		 * we can check sig->group_exit_task to detect de_thread,
+		 * but perhaps it doesn't hurt if the caller is do_group_exit
+		 */
+		cancel_freezing_thaw_task(t);
 		sigaddset(&t->pending.signal, SIGKILL);
 		signal_wake_up(t, 1);
 	}
-- 
2.7.4

