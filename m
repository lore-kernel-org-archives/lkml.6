Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899E3C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388812146D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388812146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbeIMAfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:35:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728282AbeIMAfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:35:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7167240216FE;
        Wed, 12 Sep 2018 19:29:08 +0000 (UTC)
Received: from llong.com (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F250C10DCF47;
        Wed, 12 Sep 2018 19:29:07 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <andi@firstfloor.org>,
        Dave Chinner <dchinner@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH v9 5/5] lib/dlock-list: Scale dlock_lists_empty()
Date:   Wed, 12 Sep 2018 15:28:52 -0400
Message-Id: <1536780532-4092-6-git-send-email-longman@redhat.com>
In-Reply-To: <1536780532-4092-1-git-send-email-longman@redhat.com>
References: <1536780532-4092-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 12 Sep 2018 19:29:08 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 12 Sep 2018 19:29:08 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

Instead of the current O(N) implementation, at the cost
of adding an atomic counter, we can convert the call to
an atomic_read(). The counter only serves for accounting
empty to non-empty transitions, and vice versa; therefore
only modified twice for each of the lists during the
lifetime of the dlock (while used).

In addition, to be able to unaccount a list_del(), we
add a dlist pointer to each head, thus minimizing the
overall memory footprint.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Acked-by: Waiman Long <longman@redhat.com>
---
 include/linux/dlock-list.h |  8 ++++++
 lib/dlock-list.c           | 67 +++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/include/linux/dlock-list.h b/include/linux/dlock-list.h
index 327cb9e..ac1a2e3 100644
--- a/include/linux/dlock-list.h
+++ b/include/linux/dlock-list.h
@@ -32,10 +32,18 @@
 struct dlock_list_head {
 	struct list_head list;
 	spinlock_t lock;
+	struct dlock_list_heads *dlist;
 } ____cacheline_aligned_in_smp;
 
+/*
+ * This is the main dlist data structure, with the array of heads
+ * and a counter that atomically tracks if any of the lists are
+ * being used. That is, empty to non-empty (and vice versa)
+ * head->list transitions.
+ */
 struct dlock_list_heads {
 	struct dlock_list_head *heads;
+	atomic_t used_lists;
 };
 
 /*
diff --git a/lib/dlock-list.c b/lib/dlock-list.c
index e286094..04da20d 100644
--- a/lib/dlock-list.c
+++ b/lib/dlock-list.c
@@ -122,8 +122,11 @@ int __alloc_dlock_list_heads(struct dlock_list_heads *dlist,
 
 		INIT_LIST_HEAD(&head->list);
 		head->lock = __SPIN_LOCK_UNLOCKED(&head->lock);
+		head->dlist = dlist;
 		lockdep_set_class(&head->lock, key);
 	}
+
+	atomic_set(&dlist->used_lists, 0);
 	return 0;
 }
 EXPORT_SYMBOL(__alloc_dlock_list_heads);
@@ -139,29 +142,36 @@ void free_dlock_list_heads(struct dlock_list_heads *dlist)
 {
 	kfree(dlist->heads);
 	dlist->heads = NULL;
+	atomic_set(&dlist->used_lists, 0);
 }
 EXPORT_SYMBOL(free_dlock_list_heads);
 
 /**
  * dlock_lists_empty - Check if all the dlock lists are empty
  * @dlist: Pointer to the dlock_list_heads structure
- * Return: true if list is empty, false otherwise.
  *
- * This can be a pretty expensive function call. If this function is required
- * in a performance critical path, we may have to maintain a global count
- * of the list entries in the global dlock_list_heads structure instead.
+ * Return: true if all dlock lists are empty, false otherwise.
  */
 bool dlock_lists_empty(struct dlock_list_heads *dlist)
 {
-	int idx;
-
 	/* Shouldn't be called before nr_dlock_lists is initialized */
 	WARN_ON_ONCE(!nr_dlock_lists);
 
-	for (idx = 0; idx < nr_dlock_lists; idx++)
-		if (!list_empty(&dlist->heads[idx].list))
-			return false;
-	return true;
+	/*
+	 * Serialize dlist->used_lists such that a 0->1 transition is not
+	 * missed by another thread checking if any of the dlock lists are
+	 * used.
+	 *
+	 * CPU0				    CPU1
+	 * dlock_list_add()                 dlock_lists_empty()
+	 *   [S] atomic_inc(used_lists);
+	 *       smp_mb__after_atomic();
+	 *					  smp_mb__before_atomic();
+	 *				      [L] atomic_read(used_lists)
+	 *       list_add()
+	 */
+	smp_mb__before_atomic();
+	return !atomic_read(&dlist->used_lists);
 }
 EXPORT_SYMBOL(dlock_lists_empty);
 
@@ -177,11 +187,39 @@ void dlock_lists_add(struct dlock_list_node *node,
 		     struct dlock_list_heads *dlist)
 {
 	struct dlock_list_head *head = &dlist->heads[this_cpu_read(cpu2idx)];
+	bool list_empty_before_lock = false;
+
+	/*
+	 * Optimistically bump the used_lists counter _before_ taking
+	 * the head->lock such that we don't miss a thread adding itself
+	 * to a list while spinning for the lock.
+	 *
+	 * Then, after taking the lock, recheck if the empty to non-empty
+	 * transition changed and (un)account for ourselves, accordingly.
+	 * Note that all these scenarios are corner cases, and not the
+	 * common scenario, where the lists are actually populated most
+	 * of the time.
+	 */
+	if (unlikely(list_empty_careful(&head->list))) {
+		list_empty_before_lock = true;
+		atomic_inc(&dlist->used_lists);
+		smp_mb__after_atomic();
+	}
 
 	/*
 	 * There is no need to disable preemption
 	 */
 	spin_lock(&head->lock);
+
+	if (unlikely(!list_empty_before_lock && list_empty(&head->list))) {
+		atomic_inc(&dlist->used_lists);
+		smp_mb__after_atomic();
+	}
+	if (unlikely(list_empty_before_lock && !list_empty(&head->list))) {
+		atomic_dec(&dlist->used_lists);
+		smp_mb__after_atomic();
+	}
+
 	WRITE_ONCE(node->head, head);
 	list_add(&node->list, &head->list);
 	spin_unlock(&head->lock);
@@ -212,6 +250,15 @@ void dlock_lists_del(struct dlock_list_node *node)
 		spin_lock(&head->lock);
 		if (likely(head == READ_ONCE(node->head))) {
 			list_del_init(&node->list);
+
+			if (unlikely(list_empty(&head->list))) {
+				struct dlock_list_heads *dlist;
+				dlist = node->head->dlist;
+
+				atomic_dec(&dlist->used_lists);
+				smp_mb__after_atomic();
+			}
+
 			WRITE_ONCE(node->head, NULL);
 			retry = false;
 		} else {
-- 
1.8.3.1

