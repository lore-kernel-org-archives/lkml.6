Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DAAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA2D20645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387994AbfAOQsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:48:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:47472 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387721AbfAOQpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:45:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C15E8ACD3;
        Tue, 15 Jan 2019 16:45:10 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     jpoimboe@redhat.com, jeyu@kernel.org, jikos@kernel.org,
        pmladek@suse.com
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 1/2] livepatch: Send a fake signal periodically
Date:   Tue, 15 Jan 2019 17:45:06 +0100
Message-Id: <20190115164507.14676-2-mbenes@suse.cz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115164507.14676-1-mbenes@suse.cz>
References: <20190115164507.14676-1-mbenes@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An administrator may send a fake signal to all remaining blocking tasks
of a running transition by writing to
/sys/kernel/livepatch/<patch>/signal attribute. Let's do it
automatically after 15 seconds. The timeout is chosen deliberately. It
gives the tasks enough time to transition themselves.

Theoretically, sending it once should be more than enough. However,
every task must get outside of a patched function to be successfully
transitioned. It could prove not to be simple and resending could be
helpful in that case.

A new workqueue job could be a cleaner solution to achieve it, but it
could also introduce deadlocks and cause more headaches with
synchronization and cancelling.

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---
 Documentation/livepatch/livepatch.txt |  3 ++-
 kernel/livepatch/transition.c         | 17 ++++++++++++++---
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/livepatch/livepatch.txt b/Documentation/livepatch/livepatch.txt
index 71d7f286ec4d..407e0f03dc99 100644
--- a/Documentation/livepatch/livepatch.txt
+++ b/Documentation/livepatch/livepatch.txt
@@ -163,7 +163,8 @@ patched state. This may be harmful to the system though.
 Writing 1 to the attribute sends a fake signal to all remaining blocking
 tasks. No proper signal is actually delivered (there is no data in signal
 pending structures). Tasks are interrupted or woken up, and forced to change
-their patched state.
+their patched state. Despite the sysfs attribute the fake signal is also sent
+every 15 seconds automatically.
 
 Administrator can also affect a transition through
 /sys/kernel/livepatch/<patch>/force attribute. Writing 1 there clears
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 300273819674..12a1a65531a0 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -29,10 +29,14 @@
 #define MAX_STACK_ENTRIES  100
 #define STACK_ERR_BUF_SIZE 128
 
+#define SIGNALS_TIMEOUT 15
+
 struct klp_patch *klp_transition_patch;
 
 static int klp_target_state = KLP_UNDEFINED;
 
+static unsigned int klp_signals_cnt;
+
 /*
  * This work can be performed periodically to finish patching or unpatching any
  * "straggler" tasks which failed to transition in the first attempt.
@@ -393,6 +397,10 @@ void klp_try_complete_transition(void)
 	put_online_cpus();
 
 	if (!complete) {
+		if (klp_signals_cnt && !(klp_signals_cnt % SIGNALS_TIMEOUT))
+			klp_send_signals();
+		klp_signals_cnt++;
+
 		/*
 		 * Some tasks weren't able to be switched over.  Try again
 		 * later and/or wait for other methods like kernel exit
@@ -400,6 +408,7 @@ void klp_try_complete_transition(void)
 		 */
 		schedule_delayed_work(&klp_transition_work,
 				      round_jiffies_relative(HZ));
+
 		return;
 	}
 
@@ -454,6 +463,8 @@ void klp_start_transition(void)
 		if (task->patch_state != klp_target_state)
 			set_tsk_thread_flag(task, TIF_PATCH_PENDING);
 	}
+
+	klp_signals_cnt = 0;
 }
 
 /*
@@ -578,14 +589,14 @@ void klp_copy_process(struct task_struct *child)
 
 /*
  * Sends a fake signal to all non-kthread tasks with TIF_PATCH_PENDING set.
- * Kthreads with TIF_PATCH_PENDING set are woken up. Only admin can request this
- * action currently.
+ * Kthreads with TIF_PATCH_PENDING set are woken up.
  */
 void klp_send_signals(void)
 {
 	struct task_struct *g, *task;
 
-	pr_notice("signaling remaining tasks\n");
+	if (klp_signals_cnt == SIGNALS_TIMEOUT)
+		pr_notice("signaling remaining tasks\n");
 
 	read_lock(&tasklist_lock);
 	for_each_process_thread(g, task) {
-- 
2.20.1

