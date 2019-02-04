Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E6BC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937A721848
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfBDIyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:54:55 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48455 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfBDIyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:54:55 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x148sR80357869
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 00:54:27 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x148sQ17357866;
        Mon, 4 Feb 2019 00:54:26 -0800
Date:   Mon, 4 Feb 2019 00:54:26 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Elena Reshetova <tipbot@zytor.com>
Message-ID: <tip-60d4de3ff7f775509deba94b3db3c1abe55bf7a5@git.kernel.org>
Cc:     oleg@redhat.com, torvalds@linux-foundation.org, efault@gmx.de,
        dwindsor@gmail.com, tglx@linutronix.de, elena.reshetova@intel.com,
        mingo@kernel.org, hpa@zytor.com, ishkamiel@gmail.com,
        keescook@chromium.org, andrea.parri@amarulasolutions.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Reply-To: andrea.parri@amarulasolutions.com, elena.reshetova@intel.com,
          tglx@linutronix.de, keescook@chromium.org, mingo@kernel.org,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          efault@gmx.de, torvalds@linux-foundation.org, hpa@zytor.com,
          oleg@redhat.com, ishkamiel@gmail.com, dwindsor@gmail.com
In-Reply-To: <1547814450-18902-3-git-send-email-elena.reshetova@intel.com>
References: <1547814450-18902-3-git-send-email-elena.reshetova@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Convert signal_struct.sigcnt to
 refcount_t
Git-Commit-ID: 60d4de3ff7f775509deba94b3db3c1abe55bf7a5
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

Commit-ID:  60d4de3ff7f775509deba94b3db3c1abe55bf7a5
Gitweb:     https://git.kernel.org/tip/60d4de3ff7f775509deba94b3db3c1abe55bf7a5
Author:     Elena Reshetova <elena.reshetova@intel.com>
AuthorDate: Fri, 18 Jan 2019 14:27:27 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 4 Feb 2019 08:53:53 +0100

sched/core: Convert signal_struct.sigcnt to refcount_t

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

For the signal_struct.sigcnt it might make a difference
in following places:

 - put_signal_struct(): decrement in refcount_dec_and_test() only
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
Link: https://lkml.kernel.org/r/1547814450-18902-3-git-send-email-elena.reshetova@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched/signal.h | 2 +-
 init/init_task.c             | 2 +-
 kernel/fork.c                | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 37eeb1a28eba..ae5655197698 100644
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
index 5aebe3be4d7c..9aa3ebc74970 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -44,7 +44,7 @@ static struct signal_struct init_signals = {
 };
 
 static struct sighand_struct init_sighand = {
-	.count		= ATOMIC_INIT(1),
+	.count		= REFCOUNT_INIT(1),
 	.action		= { { { .sa_handler = SIG_DFL, } }, },
 	.siglock	= __SPIN_LOCK_UNLOCKED(init_sighand.siglock),
 	.signalfd_wqh	= __WAIT_QUEUE_HEAD_INITIALIZER(init_sighand.signalfd_wqh),
diff --git a/kernel/fork.c b/kernel/fork.c
index 370856d4c0b3..935a42d5f8ff 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -710,7 +710,7 @@ static inline void free_signal_struct(struct signal_struct *sig)
 
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
