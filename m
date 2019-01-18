Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B796C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251FF2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfARM15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:27:57 -0500
Received: from mga05.intel.com ([192.55.52.43]:2175 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727655AbfARM1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:27:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2019 04:27:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,491,1539673200"; 
   d="scan'208";a="268136115"
Received: from elena-thinkpad-x230.fi.intel.com ([10.237.68.34])
  by orsmga004.jf.intel.com with ESMTP; 18 Jan 2019 04:27:50 -0800
From:   Elena Reshetova <elena.reshetova@intel.com>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, keescook@chromium.org,
        tglx@linutronix.de, Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 3/5] sched: convert numa_group.refcount to refcount_t
Date:   Fri, 18 Jan 2019 14:27:28 +0200
Message-Id: <1547814450-18902-4-git-send-email-elena.reshetova@intel.com>
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

The variable numa_group.refcount is used as pure reference counter.
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

For the numa_group.refcount it might make a difference
in following places:
 - get_numa_group(): increment in refcount_inc_not_zero() only
   guarantees control dependency on success vs. fully ordered
   atomic counterpart
 - put_numa_group(): decrement in refcount_dec_and_test() only
   provides RELEASE ordering and control dependency on success
   vs. fully ordered atomic counterpart

Suggested-by: Kees Cook <keescook@chromium.org>
Reviewed-by: David Windsor <dwindsor@gmail.com>
Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
---
 kernel/sched/fair.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7303e0b..32a2382 100644
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
-- 
2.7.4

