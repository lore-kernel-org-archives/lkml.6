Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F53C282D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710BA20820
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbfBDIyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:54:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45295 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbfBDIyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:54:19 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x148rntG357613
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 00:53:49 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x148rlvw357608;
        Mon, 4 Feb 2019 00:53:47 -0800
Date:   Mon, 4 Feb 2019 00:53:47 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Elena Reshetova <tipbot@zytor.com>
Message-ID: <tip-d036bda7d0e7269c2982eb979acfef855f5d7977@git.kernel.org>
Cc:     andrea.parri@amarulasolutions.com, efault@gmx.de, mingo@kernel.org,
        dwindsor@gmail.com, tglx@linutronix.de, keescook@chromium.org,
        ishkamiel@gmail.com, peterz@infradead.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        elena.reshetova@intel.com, oleg@redhat.com, hpa@zytor.com
Reply-To: andrea.parri@amarulasolutions.com, linux-kernel@vger.kernel.org,
          efault@gmx.de, torvalds@linux-foundation.org,
          elena.reshetova@intel.com, oleg@redhat.com, mingo@kernel.org,
          dwindsor@gmail.com, keescook@chromium.org, tglx@linutronix.de,
          ishkamiel@gmail.com, peterz@infradead.org, hpa@zytor.com
In-Reply-To: <1547814450-18902-2-git-send-email-elena.reshetova@intel.com>
References: <1547814450-18902-2-git-send-email-elena.reshetova@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Convert sighand_struct.count to
 refcount_t
Git-Commit-ID: d036bda7d0e7269c2982eb979acfef855f5d7977
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

Commit-ID:  d036bda7d0e7269c2982eb979acfef855f5d7977
Gitweb:     https://git.kernel.org/tip/d036bda7d0e7269c2982eb979acfef855f5d7977
Author:     Elena Reshetova <elena.reshetova@intel.com>
AuthorDate: Fri, 18 Jan 2019 14:27:26 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 4 Feb 2019 08:53:52 +0100

sched/core: Convert sighand_struct.count to refcount_t

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

The variable sighand_struct.count is used as pure reference counter.
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

For the sighand_struct.count it might make a difference
in following places:

 - __cleanup_sighand: decrement in refcount_dec_and_test() only
   provides RELEASE ordering and control dependency on success
   vs. fully ordered atomic counterpart

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: David Windsor <dwindsor@gmail.com>
Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
Reviewed-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk
Link: https://lkml.kernel.org/r/1547814450-18902-2-git-send-email-elena.reshetova@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 fs/exec.c                    | 4 ++--
 fs/proc/task_nommu.c         | 2 +-
 include/linux/sched/signal.h | 3 ++-
 kernel/fork.c                | 8 ++++----
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index fb72d36f7823..966cd98a2ce2 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1189,7 +1189,7 @@ no_thread_group:
 	flush_itimer_signals();
 #endif
 
-	if (atomic_read(&oldsighand->count) != 1) {
+	if (refcount_read(&oldsighand->count) != 1) {
 		struct sighand_struct *newsighand;
 		/*
 		 * This ->sighand is shared with the CLONE_SIGHAND
@@ -1199,7 +1199,7 @@ no_thread_group:
 		if (!newsighand)
 			return -ENOMEM;
 
-		atomic_set(&newsighand->count, 1);
+		refcount_set(&newsighand->count, 1);
 		memcpy(newsighand->action, oldsighand->action,
 		       sizeof(newsighand->action));
 
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index 0b63d68dedb2..f912872fbf91 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -64,7 +64,7 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
 	else
 		bytes += kobjsize(current->files);
 
-	if (current->sighand && atomic_read(&current->sighand->count) > 1)
+	if (current->sighand && refcount_read(&current->sighand->count) > 1)
 		sbytes += kobjsize(current->sighand);
 	else
 		bytes += kobjsize(current->sighand);
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 13789d10a50e..37eeb1a28eba 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -8,13 +8,14 @@
 #include <linux/sched/jobctl.h>
 #include <linux/sched/task.h>
 #include <linux/cred.h>
+#include <linux/refcount.h>
 
 /*
  * Types defining task->signal and task->sighand and APIs using them:
  */
 
 struct sighand_struct {
-	atomic_t		count;
+	refcount_t		count;
 	struct k_sigaction	action[_NSIG];
 	spinlock_t		siglock;
 	wait_queue_head_t	signalfd_wqh;
diff --git a/kernel/fork.c b/kernel/fork.c
index b69248e6f0e0..370856d4c0b3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1463,7 +1463,7 @@ static int copy_sighand(unsigned long clone_flags, struct task_struct *tsk)
 	struct sighand_struct *sig;
 
 	if (clone_flags & CLONE_SIGHAND) {
-		atomic_inc(&current->sighand->count);
+		refcount_inc(&current->sighand->count);
 		return 0;
 	}
 	sig = kmem_cache_alloc(sighand_cachep, GFP_KERNEL);
@@ -1471,7 +1471,7 @@ static int copy_sighand(unsigned long clone_flags, struct task_struct *tsk)
 	if (!sig)
 		return -ENOMEM;
 
-	atomic_set(&sig->count, 1);
+	refcount_set(&sig->count, 1);
 	spin_lock_irq(&current->sighand->siglock);
 	memcpy(sig->action, current->sighand->action, sizeof(sig->action));
 	spin_unlock_irq(&current->sighand->siglock);
@@ -1480,7 +1480,7 @@ static int copy_sighand(unsigned long clone_flags, struct task_struct *tsk)
 
 void __cleanup_sighand(struct sighand_struct *sighand)
 {
-	if (atomic_dec_and_test(&sighand->count)) {
+	if (refcount_dec_and_test(&sighand->count)) {
 		signalfd_cleanup(sighand);
 		/*
 		 * sighand_cachep is SLAB_TYPESAFE_BY_RCU so we can free it
@@ -2439,7 +2439,7 @@ static int check_unshare_flags(unsigned long unshare_flags)
 			return -EINVAL;
 	}
 	if (unshare_flags & (CLONE_SIGHAND | CLONE_VM)) {
-		if (atomic_read(&current->sighand->count) > 1)
+		if (refcount_read(&current->sighand->count) > 1)
 			return -EINVAL;
 	}
 	if (unshare_flags & CLONE_VM) {
