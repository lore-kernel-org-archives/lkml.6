Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C963AC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38A8214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfBDIzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:55:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50617 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbfBDIzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:55:18 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x148t3ED357962
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 00:55:03 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x148t3bC357958;
        Mon, 4 Feb 2019 00:55:03 -0800
Date:   Mon, 4 Feb 2019 00:55:03 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Elena Reshetova <tipbot@zytor.com>
Message-ID: <tip-c45a77952427b678aa9205e1b0ee3bcf33339a2e@git.kernel.org>
Cc:     andrea.parri@amarulasolutions.com, dwindsor@gmail.com,
        peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, ishkamiel@gmail.com,
        torvalds@linux-foundation.org, efault@gmx.de, hpa@zytor.com,
        keescook@chromium.org, elena.reshetova@intel.com
Reply-To: andrea.parri@amarulasolutions.com, dwindsor@gmail.com,
          peterz@infradead.org, tglx@linutronix.de, ishkamiel@gmail.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org, efault@gmx.de,
          torvalds@linux-foundation.org, keescook@chromium.org,
          elena.reshetova@intel.com, hpa@zytor.com
In-Reply-To: <1547814450-18902-4-git-send-email-elena.reshetova@intel.com>
References: <1547814450-18902-4-git-send-email-elena.reshetova@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Convert numa_group.refcount to
 refcount_t
Git-Commit-ID: c45a77952427b678aa9205e1b0ee3bcf33339a2e
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

Commit-ID:  c45a77952427b678aa9205e1b0ee3bcf33339a2e
Gitweb:     https://git.kernel.org/tip/c45a77952427b678aa9205e1b0ee3bcf33339a2e
Author:     Elena Reshetova <elena.reshetova@intel.com>
AuthorDate: Fri, 18 Jan 2019 14:27:28 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 4 Feb 2019 08:53:54 +0100

sched/fair: Convert numa_group.refcount to refcount_t

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

The variable numa_group.refcount is used as pure reference counter.
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

For the numa_group.refcount it might make a difference
in following places:

 - get_numa_group(): increment in refcount_inc_not_zero() only
   guarantees control dependency on success vs. fully ordered
   atomic counterpart
 - put_numa_group(): decrement in refcount_dec_and_test() only
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
Link: https://lkml.kernel.org/r/1547814450-18902-4-git-send-email-elena.reshetova@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e2ff4b69dcf6..5b2b919c7929 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1035,7 +1035,7 @@ unsigned int sysctl_numa_balancing_scan_size = 256;
 unsigned int sysctl_numa_balancing_scan_delay = 1000;
 
 struct numa_group {
-	atomic_t refcount;
+	refcount_t refcount;
 
 	spinlock_t lock; /* nr_tasks, tasks */
 	int nr_tasks;
@@ -1104,7 +1104,7 @@ static unsigned int task_scan_start(struct task_struct *p)
 		unsigned long shared = group_faults_shared(ng);
 		unsigned long private = group_faults_priv(ng);
 
-		period *= atomic_read(&ng->refcount);
+		period *= refcount_read(&ng->refcount);
 		period *= shared + 1;
 		period /= private + shared + 1;
 	}
@@ -1127,7 +1127,7 @@ static unsigned int task_scan_max(struct task_struct *p)
 		unsigned long private = group_faults_priv(ng);
 		unsigned long period = smax;
 
-		period *= atomic_read(&ng->refcount);
+		period *= refcount_read(&ng->refcount);
 		period *= shared + 1;
 		period /= private + shared + 1;
 
@@ -2203,12 +2203,12 @@ static void task_numa_placement(struct task_struct *p)
 
 static inline int get_numa_group(struct numa_group *grp)
 {
-	return atomic_inc_not_zero(&grp->refcount);
+	return refcount_inc_not_zero(&grp->refcount);
 }
 
 static inline void put_numa_group(struct numa_group *grp)
 {
-	if (atomic_dec_and_test(&grp->refcount))
+	if (refcount_dec_and_test(&grp->refcount))
 		kfree_rcu(grp, rcu);
 }
 
@@ -2229,7 +2229,7 @@ static void task_numa_group(struct task_struct *p, int cpupid, int flags,
 		if (!grp)
 			return;
 
-		atomic_set(&grp->refcount, 1);
+		refcount_set(&grp->refcount, 1);
 		grp->active_nodes = 1;
 		grp->max_faults_cpu = 0;
 		spin_lock_init(&grp->lock);
