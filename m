Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753877AbeFDOQ7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:16:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:43740 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753641AbeFDOQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:16:41 -0400
From: Miroslav Benes <mbenes@suse.cz>
To: jikos@kernel.org, jpoimboe@redhat.com, jeyu@kernel.org
Cc: pmladek@suse.com, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 1/2] livepatch: Send a fake signal periodically
Date: Mon,  4 Jun 2018 16:16:35 +0200
Message-Id: <20180604141636.11523-2-mbenes@suse.cz>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180604141636.11523-1-mbenes@suse.cz>
References: <20180604141636.11523-1-mbenes@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An administrator may send a fake signal to all remaining blocking tasks
of a running transition by writing to
/sys/kernel/livepatch/<patch>/signal attribute. Let's do it
automatically after 10 seconds. The timeout is chosen deliberately. It
gives the tasks enough time to transition themselves.

Theoretically, sending it once should be more than enough. Better be safe
than sorry, so send it periodically. A new workqueue job could be a
cleaner solution to achieve it, but it could also introduce deadlocks
and cause more headaches with synchronization and cancelling.

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---
 Documentation/livepatch/livepatch.txt |  3 ++-
 kernel/livepatch/transition.c         | 11 +++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/livepatch/livepatch.txt b/Documentation/livepatch/livepatch.txt
index 1ae2de758c08..011897e2392f 100644
--- a/Documentation/livepatch/livepatch.txt
+++ b/Documentation/livepatch/livepatch.txt
@@ -163,7 +163,8 @@ patched state. This may be harmful to the system though.
 Writing 1 to the attribute sends a fake signal to all remaining blocking
 tasks. No proper signal is actually delivered (there is no data in signal
 pending structures). Tasks are interrupted or woken up, and forced to change
-their patched state.
+their patched state. Despite the sysfs attribute the fake signal is also sent
+every 10 seconds automatically.
 
 Administrator can also affect a transition through
 /sys/kernel/livepatch/<patch>/force attribute. Writing 1 there clears
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 7c6631e693bc..c33d29c74ac6 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -29,6 +29,8 @@
 #define MAX_STACK_ENTRIES  100
 #define STACK_ERR_BUF_SIZE 128
 
+#define SIGNALS_TIMEOUT 10
+
 struct klp_patch *klp_transition_patch;
 
 static int klp_target_state = KLP_UNDEFINED;
@@ -367,6 +369,7 @@ void klp_try_complete_transition(void)
 	unsigned int cpu;
 	struct task_struct *g, *task;
 	bool complete = true;
+	static unsigned int signals_cnt = 0;
 
 	WARN_ON_ONCE(klp_target_state == KLP_UNDEFINED);
 
@@ -403,6 +406,9 @@ void klp_try_complete_transition(void)
 	put_online_cpus();
 
 	if (!complete) {
+		if (!(++signals_cnt % SIGNALS_TIMEOUT))
+			klp_send_signals();
+
 		/*
 		 * Some tasks weren't able to be switched over.  Try again
 		 * later and/or wait for other methods like kernel exit
@@ -410,10 +416,12 @@ void klp_try_complete_transition(void)
 		 */
 		schedule_delayed_work(&klp_transition_work,
 				      round_jiffies_relative(HZ));
+
 		return;
 	}
 
 	/* we're done, now cleanup the data structures */
+	signals_cnt = 0;
 	klp_complete_transition();
 }
 
@@ -577,8 +585,7 @@ void klp_copy_process(struct task_struct *child)
 
 /*
  * Sends a fake signal to all non-kthread tasks with TIF_PATCH_PENDING set.
- * Kthreads with TIF_PATCH_PENDING set are woken up. Only admin can request this
- * action currently.
+ * Kthreads with TIF_PATCH_PENDING set are woken up.
  */
 void klp_send_signals(void)
 {
-- 
2.17.0
