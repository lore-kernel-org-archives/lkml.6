Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC735C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12BA206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbeLNPSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:18:15 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:20575 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730386AbeLNPSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:18:14 -0500
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wBEFICq8081841;
        Sat, 15 Dec 2018 00:18:12 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Sat, 15 Dec 2018 00:18:12 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wBEFI5DP081726
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 15 Dec 2018 00:18:11 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] kernel/hung_task.c: Break RCU locks based on jiffies.
Date:   Sat, 15 Dec 2018 00:17:38 +0900
Message-Id: <1544800658-11423-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_hung_uninterruptible_tasks() is currently calling rcu_lock_break()
for every 1024 threads. But check_hung_task() is very slow if printk()
was called, and is very fast otherwise. If many threads within some 1024
threads called printk(), the RCU grace period might be extended enough
to trigger RCU stall warnings. Therefore, calling rcu_lock_break() for
every some fixed jiffies will be safer.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 kernel/hung_task.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index cb8e3e8..444b8b5 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -34,7 +34,7 @@
  * is disabled during the critical section. It also controls the size of
  * the RCU grace period. So it needs to be upper-bound.
  */
-#define HUNG_TASK_BATCHING 1024
+#define HUNG_TASK_LOCK_BREAK (HZ / 10)
 
 /*
  * Zero means infinite timeout - no checking done:
@@ -173,7 +173,7 @@ static bool rcu_lock_break(struct task_struct *g, struct task_struct *t)
 static void check_hung_uninterruptible_tasks(unsigned long timeout)
 {
 	int max_count = sysctl_hung_task_check_count;
-	int batch_count = HUNG_TASK_BATCHING;
+	unsigned long last_break = jiffies;
 	struct task_struct *g, *t;
 
 	/*
@@ -188,10 +188,10 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	for_each_process_thread(g, t) {
 		if (!max_count--)
 			goto unlock;
-		if (!--batch_count) {
-			batch_count = HUNG_TASK_BATCHING;
+		if (time_after(jiffies, last_break + HUNG_TASK_LOCK_BREAK)) {
 			if (!rcu_lock_break(g, t))
 				goto unlock;
+			last_break = jiffies;
 		}
 		/* use "==" to skip the TASK_KILLABLE tasks waiting on NFS */
 		if (t->state == TASK_UNINTERRUPTIBLE)
-- 
1.8.3.1

