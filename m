Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1292BC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769612089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769612089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933216AbeGJLsY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 07:48:24 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:26556 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752029AbeGJLsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 07:48:23 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6ABlrNb058515;
        Tue, 10 Jul 2018 20:47:53 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp);
 Tue, 10 Jul 2018 20:47:52 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6ABllgN058392
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 10 Jul 2018 20:47:52 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: [PATCH v2] locking/lockdep: Dump state of percpu_rwsem upon hung up.
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
References: <1530945060-7507-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <a3cfcc9d-9d4d-7940-84c5-b8f18f5b3535@i-love.sakura.ne.jp>
Date:   Tue, 10 Jul 2018 20:47:51 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <1530945060-7507-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added "#ifndef CONFIG_RWSEM_GENERIC_SPINLOCK" check.

From 88f979f8f019f32de94327878ef1f7ccb7500321 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Tue, 10 Jul 2018 20:43:18 +0900
Subject: [PATCH v2] locking/lockdep: Dump state of percpu_rwsem upon hung up.

This is a temporary patch which should not go to linux.git.

syzbot is hitting hung task problems at __sb_start_write() [1]. While hung
tasks at __sb_start_write() suggest that filesystem was frozen, syzbot is
not doing ioctl(FIFREEZE) requests. Therefore, the root cause of hung tasks
is currently unknown. As a first step for debugging this problem, let's
check what atomic_long_read(&sem->rw_sem.count) says when hung task is
reported. Since it is impossible to reproduce this problem locally, this
patch was made in order to test linux-next.git using syzbot infrastructure.

[1] https://syzkaller.appspot.com/bug?id=287aa8708bc940d0ca1645223c53dd4c2d203be6

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 include/linux/sched.h         |  1 +
 kernel/hung_task.c            | 27 +++++++++++++++++++++++++++
 kernel/locking/percpu-rwsem.c |  2 ++
 3 files changed, 30 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2974378..df56c65 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1191,6 +1191,7 @@ struct task_struct {
 	/* Used by LSM modules for access restriction: */
 	void				*security;
 #endif
+	struct percpu_rw_semaphore	*pcpu_rwsem_read_waiting;
 
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 	unsigned long			lowest_stack;
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index b9132d1..43975df 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -18,6 +18,7 @@
 #include <linux/utsname.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/debug.h>
+#include <linux/percpu-rwsem.h>
 
 #include <trace/events/sched.h>
 
@@ -82,6 +83,31 @@ static int __init hung_task_panic_setup(char *str)
 	.notifier_call = hung_task_panic,
 };
 
+static void dump_percpu_rwsem_state(struct percpu_rw_semaphore *sem)
+{
+#ifndef CONFIG_RWSEM_GENERIC_SPINLOCK
+	unsigned int sum = 0;
+	int cpu;
+
+	if (!sem)
+		return;
+	pr_info("percpu_rw_semaphore(%p)\n", sem);
+	pr_info("  ->rw_sem.count=0x%lx\n",
+		atomic_long_read(&sem->rw_sem.count));
+	pr_info("  ->rss.gp_state=%d\n", sem->rss.gp_state);
+	pr_info("  ->rss.gp_count=%d\n", sem->rss.gp_count);
+	pr_info("  ->rss.cb_state=%d\n", sem->rss.cb_state);
+	pr_info("  ->rss.gp_type=%d\n", sem->rss.gp_type);
+	pr_info("  ->readers_block=%d\n", sem->readers_block);
+	for_each_possible_cpu(cpu)
+		sum += per_cpu(*sem->read_count, cpu);
+	pr_info("  ->read_count=%d\n", sum);
+	pr_info("  ->list_empty(rw_sem.wait_list)=%d\n",
+	       list_empty(&sem->rw_sem.wait_list));
+	pr_info("  ->writer.task=%p\n", sem->writer.task);
+#endif
+}
+
 static void check_hung_task(struct task_struct *t, unsigned long timeout)
 {
 	unsigned long switch_count = t->nvcsw + t->nivcsw;
@@ -130,6 +156,7 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 		pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_secs\""
 			" disables this message.\n");
 		sched_show_task(t);
+		dump_percpu_rwsem_state(t->pcpu_rwsem_read_waiting);
 		hung_task_show_lock = true;
 	}
 
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 883cf1b..b3654ab 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -82,7 +82,9 @@ int __percpu_down_read(struct percpu_rw_semaphore *sem, int try)
 	/*
 	 * Avoid lockdep for the down/up_read() we already have them.
 	 */
+	current->pcpu_rwsem_read_waiting = sem;
 	__down_read(&sem->rw_sem);
+	current->pcpu_rwsem_read_waiting = NULL;
 	this_cpu_inc(*sem->read_count);
 	__up_read(&sem->rw_sem);
 
-- 
1.8.3.1


