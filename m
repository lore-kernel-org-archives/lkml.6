Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B6EC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305C1214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfBDIz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:55:58 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41283 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfBDIz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:55:58 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x148tgHF358027
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 00:55:42 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x148tg8N358024;
        Mon, 4 Feb 2019 00:55:42 -0800
Date:   Mon, 4 Feb 2019 00:55:42 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Elena Reshetova <tipbot@zytor.com>
Message-ID: <tip-ec1d281923cf81cc660343d0cb8ffc837ffb991d@git.kernel.org>
Cc:     elena.reshetova@intel.com, linux-kernel@vger.kernel.org,
        dwindsor@gmail.com, ishkamiel@gmail.com, peterz@infradead.org,
        efault@gmx.de, keescook@chromium.org,
        torvalds@linux-foundation.org, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, andrea.parri@amarulasolutions.com
Reply-To: tglx@linutronix.de, andrea.parri@amarulasolutions.com,
          hpa@zytor.com, mingo@kernel.org, peterz@infradead.org,
          ishkamiel@gmail.com, torvalds@linux-foundation.org,
          dwindsor@gmail.com, efault@gmx.de, keescook@chromium.org,
          elena.reshetova@intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <1547814450-18902-5-git-send-email-elena.reshetova@intel.com>
References: <1547814450-18902-5-git-send-email-elena.reshetova@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Convert task_struct.usage to
 refcount_t
Git-Commit-ID: ec1d281923cf81cc660343d0cb8ffc837ffb991d
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

Commit-ID:  ec1d281923cf81cc660343d0cb8ffc837ffb991d
Gitweb:     https://git.kernel.org/tip/ec1d281923cf81cc660343d0cb8ffc837ffb991d
Author:     Elena Reshetova <elena.reshetova@intel.com>
AuthorDate: Fri, 18 Jan 2019 14:27:29 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 4 Feb 2019 08:53:55 +0100

sched/core: Convert task_struct.usage to refcount_t

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

The variable task_struct.usage is used as pure reference counter.
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

For the task_struct.usage it might make a difference
in following places:

 - put_task_struct(): decrement in refcount_dec_and_test() only
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
Link: https://lkml.kernel.org/r/1547814450-18902-5-git-send-email-elena.reshetova@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h      | 3 ++-
 include/linux/sched/task.h | 4 ++--
 init/init_task.c           | 2 +-
 kernel/fork.c              | 4 ++--
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e2bba022827d..9d14d6864ca6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -21,6 +21,7 @@
 #include <linux/seccomp.h>
 #include <linux/nodemask.h>
 #include <linux/rcupdate.h>
+#include <linux/refcount.h>
 #include <linux/resource.h>
 #include <linux/latencytop.h>
 #include <linux/sched/prio.h>
@@ -607,7 +608,7 @@ struct task_struct {
 	randomized_struct_fields_start
 
 	void				*stack;
-	atomic_t			usage;
+	refcount_t			usage;
 	/* Per task flags (PF_*), defined further below: */
 	unsigned int			flags;
 	unsigned int			ptrace;
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 44c6f15800ff..2e97a2227045 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -88,13 +88,13 @@ extern void sched_exec(void);
 #define sched_exec()   {}
 #endif
 
-#define get_task_struct(tsk) do { atomic_inc(&(tsk)->usage); } while(0)
+#define get_task_struct(tsk) do { refcount_inc(&(tsk)->usage); } while(0)
 
 extern void __put_task_struct(struct task_struct *t);
 
 static inline void put_task_struct(struct task_struct *t)
 {
-	if (atomic_dec_and_test(&t->usage))
+	if (refcount_dec_and_test(&t->usage))
 		__put_task_struct(t);
 }
 
diff --git a/init/init_task.c b/init/init_task.c
index 9aa3ebc74970..aca34c89529f 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -65,7 +65,7 @@ struct task_struct init_task
 #endif
 	.state		= 0,
 	.stack		= init_stack,
-	.usage		= ATOMIC_INIT(2),
+	.usage		= REFCOUNT_INIT(2),
 	.flags		= PF_KTHREAD,
 	.prio		= MAX_PRIO - 20,
 	.static_prio	= MAX_PRIO - 20,
diff --git a/kernel/fork.c b/kernel/fork.c
index 935a42d5f8ff..3f7e192e29f2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -717,7 +717,7 @@ static inline void put_signal_struct(struct signal_struct *sig)
 void __put_task_struct(struct task_struct *tsk)
 {
 	WARN_ON(!tsk->exit_state);
-	WARN_ON(atomic_read(&tsk->usage));
+	WARN_ON(refcount_read(&tsk->usage));
 	WARN_ON(tsk == current);
 
 	cgroup_free(tsk);
@@ -896,7 +896,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	 * One for us, one for whoever does the "release_task()" (usually
 	 * parent)
 	 */
-	atomic_set(&tsk->usage, 2);
+	refcount_set(&tsk->usage, 2);
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	tsk->btrace_seq = 0;
 #endif
