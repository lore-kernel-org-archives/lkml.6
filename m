Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B4CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CF32087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfARM1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:27:53 -0500
Received: from mga05.intel.com ([192.55.52.43]:2175 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbfARM1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:27:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2019 04:27:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,491,1539673200"; 
   d="scan'208";a="268136110"
Received: from elena-thinkpad-x230.fi.intel.com ([10.237.68.34])
  by orsmga004.jf.intel.com with ESMTP; 18 Jan 2019 04:27:47 -0800
From:   Elena Reshetova <elena.reshetova@intel.com>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, keescook@chromium.org,
        tglx@linutronix.de, Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 2/5] sched: convert signal_struct.sigcnt to refcount_t
Date:   Fri, 18 Jan 2019 14:27:27 +0200
Message-Id: <1547814450-18902-3-git-send-email-elena.reshetova@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547814450-18902-1-git-send-email-elena.reshetova@intel.com>
References: <1547814450-18902-1-git-send-email-elena.reshetova@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

atomic_t variables are currently used to implement reference
counters with the following properties:
 - counter is initialized to 1 using atomic_set()
 - a resource is freed upon counter reaching zero
 - once counter reaches zero, its further
   increments aren't allowed
 - counter schema uses basic atomic operations
   (set, inc, inc_not_zero, dec_and_test, etc.)

Such atomic variables should be converted to a newly provided
refcount_t type and API that prevents accidental counter overflows
and underflows. This is important since overflows and underflows
can lead to use-after-free situation and be exploitable.

The variable signal_struct.sigcnt is used as pure reference counter.
Convert it to refcount_t and fix up the operations.

**Important note for maintainers:

Some functions from refcount_t API defined in lib/refcount.c
have different memory ordering guarantees than their atomic
counterparts.
The full comparison can be seen in
https://lkml.org/lkml/2017/11/15/57 and it is hopefully soon
in state to be merged to the documentation tree.
Normally the differences should not matter since refcount_t provides
enough guarantees to satisfy the refcounting use cases, but in
some rare cases it might matter.
Please double check that you don't have some undocumented
memory guarantees for this variable usage.

For the signal_struct.sigcnt it might make a difference
in following places:
 - put_signal_struct(): decrement in refcount_dec_and_test() only
   provides RELEASE ordering and control dependency on success
   vs. fully ordered atomic counterpart

Suggested-by: Kees Cook <keescook@chromium.org>
Reviewed-by: David Windsor <dwindsor@gmail.com>
Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
---
 include/linux/sched/signal.h | 2 +-
 init/init_task.c             | 2 +-
 kernel/fork.c                | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 2a65721..38a0f07 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -83,7 +83,7 @@ struct multiprocess_signals {
  * the locking of signal_struct.
  */
 struct signal_struct {
-	atomic_t		sigcnt;
+	refcount_t		sigcnt;
 	atomic_t		live;
 	int			nr_threads;
 	struct list_head	thread_head;
diff --git a/init/init_task.c b/init/init_task.c
index 26131e7..756be60 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -45,7 +45,7 @@ static struct signal_struct init_signals = {
 };
 
 static struct sighand_struct init_sighand = {
-	.count		= ATOMIC_INIT(1),
+	.count		= REFCOUNT_INIT(1),
 	.action		= { { { .sa_handler = SIG_DFL, } }, },
 	.siglock	= __SPIN_LOCK_UNLOCKED(init_sighand.siglock),
 	.signalfd_wqh	= __WAIT_QUEUE_HEAD_INITIALIZER(init_sighand.signalfd_wqh),
diff --git a/kernel/fork.c b/kernel/fork.c
index 71b4757..504324c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -709,7 +709,7 @@ static inline void free_signal_struct(struct signal_struct *sig)
 
 static inline void put_signal_struct(struct signal_struct *sig)
 {
-	if (atomic_dec_and_test(&sig->sigcnt))
+	if (refcount_dec_and_test(&sig->sigcnt))
 		free_signal_struct(sig);
 }
 
@@ -1527,7 +1527,7 @@ static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
 
 	sig->nr_threads = 1;
 	atomic_set(&sig->live, 1);
-	atomic_set(&sig->sigcnt, 1);
+	refcount_set(&sig->sigcnt, 1);
 
 	/* list_add(thread_node, thread_head) without INIT_LIST_HEAD() */
 	sig->thread_head = (struct list_head)LIST_HEAD_INIT(tsk->thread_node);
@@ -2082,7 +2082,7 @@ static __latent_entropy struct task_struct *copy_process(
 		} else {
 			current->signal->nr_threads++;
 			atomic_inc(&current->signal->live);
-			atomic_inc(&current->signal->sigcnt);
+			refcount_inc(&current->signal->sigcnt);
 			task_join_group_stop(p);
 			list_add_tail_rcu(&p->thread_group,
 					  &p->group_leader->thread_group);
-- 
2.7.4

