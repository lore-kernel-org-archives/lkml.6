Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95AFC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F43214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbfBDI4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:56:37 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38927 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbfBDI4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:56:36 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x148uLut358076
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 00:56:21 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x148uLfD358073;
        Mon, 4 Feb 2019 00:56:21 -0800
Date:   Mon, 4 Feb 2019 00:56:21 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Elena Reshetova <tipbot@zytor.com>
Message-ID: <tip-f0b89d3958d73cd0785ec381f0ddf8efb6f183d8@git.kernel.org>
Cc:     tglx@linutronix.de, torvalds@linux-foundation.org,
        elena.reshetova@intel.com, mingo@kernel.org, hpa@zytor.com,
        peterz@infradead.org, keescook@chromium.org, dwindsor@gmail.com,
        ishkamiel@gmail.com, linux-kernel@vger.kernel.org,
        andrea.parri@amarulasolutions.com, efault@gmx.de
Reply-To: linux-kernel@vger.kernel.org, andrea.parri@amarulasolutions.com,
          efault@gmx.de, tglx@linutronix.de, elena.reshetova@intel.com,
          torvalds@linux-foundation.org, mingo@kernel.org,
          peterz@infradead.org, hpa@zytor.com, keescook@chromium.org,
          ishkamiel@gmail.com, dwindsor@gmail.com
In-Reply-To: <1547814450-18902-6-git-send-email-elena.reshetova@intel.com>
References: <1547814450-18902-6-git-send-email-elena.reshetova@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Convert task_struct.stack_refcount to
 refcount_t
Git-Commit-ID: f0b89d3958d73cd0785ec381f0ddf8efb6f183d8
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

Commit-ID:  f0b89d3958d73cd0785ec381f0ddf8efb6f183d8
Gitweb:     https://git.kernel.org/tip/f0b89d3958d73cd0785ec381f0ddf8efb6f183d8
Author:     Elena Reshetova <elena.reshetova@intel.com>
AuthorDate: Fri, 18 Jan 2019 14:27:30 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 4 Feb 2019 08:53:56 +0100

sched/core: Convert task_struct.stack_refcount to refcount_t

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

** Important note for maintainers:

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
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: David Windsor <dwindsor@gmail.com>
Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
Reviewed-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk
Link: https://lkml.kernel.org/r/1547814450-18902-6-git-send-email-elena.reshetova@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/init_task.h        | 1 +
 include/linux/sched.h            | 2 +-
 include/linux/sched/task_stack.h | 2 +-
 init/init_task.c                 | 2 +-
 kernel/fork.c                    | 6 +++---
 5 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index a7083a45a26c..6049baa5b8bc 100644
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
index 9d14d6864ca6..628bf13cb5a5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1194,7 +1194,7 @@ struct task_struct {
 #endif
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/* A live task holds one reference: */
-	atomic_t			stack_refcount;
+	refcount_t			stack_refcount;
 #endif
 #ifdef CONFIG_LIVEPATCH
 	int patch_state;
diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index 6a841929073f..2413427e439c 100644
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
index aca34c89529f..46dbf546264d 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -61,7 +61,7 @@ struct task_struct init_task
 = {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	.thread_info	= INIT_THREAD_INFO(init_task),
-	.stack_refcount	= ATOMIC_INIT(1),
+	.stack_refcount	= REFCOUNT_INIT(1),
 #endif
 	.state		= 0,
 	.stack		= init_stack,
diff --git a/kernel/fork.c b/kernel/fork.c
index 3f7e192e29f2..77059b211608 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -429,7 +429,7 @@ static void release_task_stack(struct task_struct *tsk)
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 void put_task_stack(struct task_struct *tsk)
 {
-	if (atomic_dec_and_test(&tsk->stack_refcount))
+	if (refcount_dec_and_test(&tsk->stack_refcount))
 		release_task_stack(tsk);
 }
 #endif
@@ -447,7 +447,7 @@ void free_task(struct task_struct *tsk)
 	 * If the task had a separate stack allocation, it should be gone
 	 * by now.
 	 */
-	WARN_ON_ONCE(atomic_read(&tsk->stack_refcount) != 0);
+	WARN_ON_ONCE(refcount_read(&tsk->stack_refcount) != 0);
 #endif
 	rt_mutex_debug_task_free(tsk);
 	ftrace_graph_exit_task(tsk);
@@ -867,7 +867,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->stack_vm_area = stack_vm_area;
 #endif
 #ifdef CONFIG_THREAD_INFO_IN_TASK
-	atomic_set(&tsk->stack_refcount, 1);
+	refcount_set(&tsk->stack_refcount, 1);
 #endif
 
 	if (err)
