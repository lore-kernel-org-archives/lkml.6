Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C30DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684A72087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfARM2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:28:02 -0500
Received: from mga05.intel.com ([192.55.52.43]:2175 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727679AbfARM2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:28:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2019 04:27:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,491,1539673200"; 
   d="scan'208";a="268136124"
Received: from elena-thinkpad-x230.fi.intel.com ([10.237.68.34])
  by orsmga004.jf.intel.com with ESMTP; 18 Jan 2019 04:27:56 -0800
From:   Elena Reshetova <elena.reshetova@intel.com>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, keescook@chromium.org,
        tglx@linutronix.de, Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 5/5] sched/task_struct: convert task_struct.stack_refcount to refcount_t
Date:   Fri, 18 Jan 2019 14:27:30 +0200
Message-Id: <1547814450-18902-6-git-send-email-elena.reshetova@intel.com>
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

The variable task_struct.stack_refcount is used as pure reference counter.
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

For the task_struct.stack_refcount it might make a difference
in following places:
 - try_get_task_stack(): increment in refcount_inc_not_zero() only
   guarantees control dependency on success vs. fully ordered
   atomic counterpart
 - put_task_stack(): decrement in refcount_dec_and_test() only
   provides RELEASE ordering and control dependency on success
   vs. fully ordered atomic counterpart

Suggested-by: Kees Cook <keescook@chromium.org>
Reviewed-by: David Windsor <dwindsor@gmail.com>
Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
---
 include/linux/init_task.h        | 1 +
 include/linux/sched.h            | 2 +-
 include/linux/sched/task_stack.h | 2 +-
 init/init_task.c                 | 2 +-
 kernel/fork.c                    | 6 +++---
 5 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index a7083a4..6049baa 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -13,6 +13,7 @@
 #include <linux/securebits.h>
 #include <linux/seqlock.h>
 #include <linux/rbtree.h>
+#include <linux/refcount.h>
 #include <linux/sched/autogroup.h>
 #include <net/net_namespace.h>
 #include <linux/sched/rt.h>
diff --git a/include/linux/sched.h b/include/linux/sched.h
index bead0c7..439e34a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1201,7 +1201,7 @@ struct task_struct {
 #endif
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/* A live task holds one reference: */
-	atomic_t			stack_refcount;
+	refcount_t			stack_refcount;
 #endif
 #ifdef CONFIG_LIVEPATCH
 	int patch_state;
diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index 6a84192..2413427 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -61,7 +61,7 @@ static inline unsigned long *end_of_stack(struct task_struct *p)
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 static inline void *try_get_task_stack(struct task_struct *tsk)
 {
-	return atomic_inc_not_zero(&tsk->stack_refcount) ?
+	return refcount_inc_not_zero(&tsk->stack_refcount) ?
 		task_stack_page(tsk) : NULL;
 }
 
diff --git a/init/init_task.c b/init/init_task.c
index 0ad9772..df0257c 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -62,7 +62,7 @@ struct task_struct init_task
 = {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	.thread_info	= INIT_THREAD_INFO(init_task),
-	.stack_refcount	= ATOMIC_INIT(1),
+	.stack_refcount	= REFCOUNT_INIT(1),
 #endif
 	.state		= 0,
 	.stack		= init_stack,
diff --git a/kernel/fork.c b/kernel/fork.c
index a4ac220..73c2c9f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -428,7 +428,7 @@ static void release_task_stack(struct task_struct *tsk)
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 void put_task_stack(struct task_struct *tsk)
 {
-	if (atomic_dec_and_test(&tsk->stack_refcount))
+	if (refcount_dec_and_test(&tsk->stack_refcount))
 		release_task_stack(tsk);
 }
 #endif
@@ -446,7 +446,7 @@ void free_task(struct task_struct *tsk)
 	 * If the task had a separate stack allocation, it should be gone
 	 * by now.
 	 */
-	WARN_ON_ONCE(atomic_read(&tsk->stack_refcount) != 0);
+	WARN_ON_ONCE(refcount_read(&tsk->stack_refcount) != 0);
 #endif
 	rt_mutex_debug_task_free(tsk);
 	ftrace_graph_exit_task(tsk);
@@ -866,7 +866,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->stack_vm_area = stack_vm_area;
 #endif
 #ifdef CONFIG_THREAD_INFO_IN_TASK
-	atomic_set(&tsk->stack_refcount, 1);
+	refcount_set(&tsk->stack_refcount, 1);
 #endif
 
 	if (err)
-- 
2.7.4

