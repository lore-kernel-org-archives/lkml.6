Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4115C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570C1214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i3yjkCAX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfAJPYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:24:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40574 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbfAJPYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ws+hIGIrRVbzIe3+MrbsVXUVbTTX9Zomfo5EZifUAJk=; b=i3yjkCAXypsNx8Hg71Unfn23u
        ye12dFUpfn9EZloly3FXA5Nh2LKTqAyXqQ/p2Ei79aEL/QHQxfZUJ9/538NGqKMb2tsv7rJtBPs/m
        Tz4QSSWgptPRecilHNOO02LxF7ah2SDfYJpesjLqiwOYHdh0olQsWNIvJ6dotd1X7STb+zuBcIKBc
        ADwWXuBEmFfMgxX84cbWKg/Mq6TfYf00SJ0Wuis5B9BRMm76Z0Ab3HVZPNc3jc1qvryIebovdnWSr
        q6G1/95AoerAzQ8zg1X4LIJWCb0l0tXeVsG7UrSPgpkrnNWpmcybvPUtKsR/gjJ2wX05jNgx/ymNt
        sr23wcbEg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghcBq-0005v6-JF; Thu, 10 Jan 2019 15:24:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E8EE92040B9FD; Thu, 10 Jan 2019 16:24:12 +0100 (CET)
Date:   Thu, 10 Jan 2019 16:24:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v5 07/15] locking/lockdep: Free lock classes that are no
 longer in use
Message-ID: <20190110152412.GG30894@hirez.programming.kicks-ass.net>
References: <20181217213002.73776-1-bvanassche@acm.org>
 <20181217213002.73776-8-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217213002.73776-8-bvanassche@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 01:29:54PM -0800, Bart Van Assche wrote:
> +static struct pending_free {
> +	struct list_head zapped_classes;
> +	struct rcu_head	 rcu_head;
> +	bool		 scheduled;
> +} pending_free[2];
> +static DECLARE_WAIT_QUEUE_HEAD(rcu_cb);

> +/*
> + * Find an element in the pending_free[] array for which no RCU callback is
> + * pending and obtain the graph lock. May sleep.
> + */
> +static struct pending_free *get_pending_free_lock(unsigned long *flags)
> +{
> +	struct pending_free *pf;
> +
> +	WARN_ON_ONCE(inside_selftest());
> +
> +	while (true) {
> +		raw_local_irq_save(*flags);
> +		if (!graph_lock()) {
> +			raw_local_irq_restore(*flags);
> +			return NULL;
> +		}
> +		pf = get_pending_free();
> +		if (pf)
> +			break;
> +		graph_unlock();
> +		raw_local_irq_restore(*flags);
> +
> +		wait_event(rcu_cb, get_pending_free() != NULL);
> +	}
> +
> +	return pf;
> +}

That should work, but urgh. I've done the below wee patch on top, which
compiles but I've not yet tested it. I'll continue with the remaining
patches and then give the whole thing a spin.

---
Subject: lockdep: A wait-free RCU zapping
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Jan 10 16:16:33 CET 2019

Implement a version of the RCU zapped_classes list that doesn't
requiring waiting.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/lockdep.c |  230 +++++++++++++++++++++--------------------------
 1 file changed, 106 insertions(+), 124 deletions(-)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -288,16 +288,15 @@ LIST_HEAD(all_lock_classes);
 static LIST_HEAD(free_lock_classes);
 /*
  * A data structure for delayed freeing of data structures that may be
- * accessed by RCU readers at the time these were freed. The size of the array
- * is a compromise between minimizing the amount of memory used by this array
- * and minimizing the number of wait_event() calls by get_pending_free_lock().
+ * accessed by RCU readers at the time these were freed.
  */
 static struct pending_free {
-	struct list_head zapped_classes;
 	struct rcu_head	 rcu_head;
+	int		 index;
 	int		 pending;
-} pending_free[2];
-static DECLARE_WAIT_QUEUE_HEAD(rcu_cb);
+	struct list_head zapped[2];
+} pending_free;
+
 
 /*
  * The lockdep classes are in a hash-table as well, for fast lookup:
@@ -758,12 +757,11 @@ static bool assign_lock_key(struct lockd
 
 /*
  * Initialize the lock_classes[] array elements, the free_lock_classes list
- * and also the pending_free[] array.
+ * and also the pending_free structure.
  */
 static void init_data_structures_once(void)
 {
 	static bool initialization_happened;
-	struct pending_free *pf;
 	int i;
 
 	if (likely(initialization_happened))
@@ -771,10 +769,11 @@ static void init_data_structures_once(vo
 
 	initialization_happened = true;
 
-	for (i = 0, pf = pending_free; i < ARRAY_SIZE(pending_free); i++, pf++) {
-		INIT_LIST_HEAD(&pf->zapped_classes);
-		init_rcu_head(&pf->rcu_head);
-	}
+	init_rcu_head(&pending_free.rcu_head);
+	pending_free.index = 0;
+	pending_free.pending = 0;
+	INIT_LIST_HEAD(&pending_free.zapped[0]);
+	INIT_LIST_HEAD(&pending_free.zapped[1]);
 
 	for (i = 0; i < ARRAY_SIZE(lock_classes); i++) {
 		list_add_tail(&lock_classes[i].lock_entry, &free_lock_classes);
@@ -4257,7 +4256,7 @@ static void remove_class_from_lock_chain
 /*
  * Remove all references to a lock class. The caller must hold the graph lock.
  */
-static void zap_class(struct pending_free *pf, struct lock_class *class)
+static void zap_class(struct list_head *zapped, struct lock_class *class)
 {
 	struct lock_list *entry;
 	int i;
@@ -4277,7 +4276,7 @@ static void zap_class(struct pending_fre
 		WRITE_ONCE(entry->links_to, NULL);
 	}
 	if (list_empty(&class->locks_after) && list_empty(&class->locks_before)) {
-		list_move_tail(&class->lock_entry, &pf->zapped_classes);
+		list_move_tail(&class->lock_entry, zapped);
 		hlist_del_rcu(&class->hash_entry);
 		WRITE_ONCE(class->key, NULL);
 		WRITE_ONCE(class->name, NULL);
@@ -4313,104 +4312,74 @@ static bool inside_selftest(void)
 	return current == lockdep_selftest_task_struct;
 }
 
-/*
- * Free all lock classes that are on the pf->zapped_classes list. May be called
- * from RCU callback context.
- */
-static void free_zapped_classes(struct rcu_head *ch)
+struct list_head *get_zapped_head(void)
 {
-	struct pending_free *pf = container_of(ch, typeof(*pf), rcu_head);
-	struct lock_class *class;
-	unsigned long flags;
-
-	raw_local_irq_save(flags);
-	if (!graph_lock())
-		goto restore_irqs;
-
-	list_for_each_entry(class, &pf->zapped_classes, lock_entry)
-		reinit_class(class);
-
-	list_splice_init(&pf->zapped_classes, &free_lock_classes);
-	pf->busy = 0;
-	graph_unlock();
-restore_irqs:
-	raw_local_irq_restore(flags);
-
-	wake_up(&rcu_cb);
+	/* must hold graph lock */
+	return pending_free.zapped + pending_free.index;
 }
 
+static void free_zapped_rcu(struct rcu_head *ch);
+
 /* Schedule an RCU callback. Must be called with the graph lock held. */
-static void schedule_free_zapped_classes(struct pending_free *pf)
+static void call_rcu_zapped(struct list_head *zapped)
 {
+	struct pending_free *pf = &pending_free;
+
 	WARN_ON_ONCE(inside_selftest());
-	pf->budy = 1;
-	call_rcu(&pf->rcu_head, free_zapped_classes);
-}
 
-/*
- * Find an element in the pending_free[] array for which no RCU callback is
- * pending.
- */
-static struct pending_free *get_pending_free(void)
-{
-	struct pending_free *pf;
-	int i;
+	if (list_empty(zapped))
+		return;
 
-	for (i = 0, pf = pending_free; i < ARRAY_SIZE(pending_free); i++, pf++) {
-		if (!pf->pending)
-			return pf;
-	}
+	if (pf->pending)
+		return;
 
-	return NULL;
-}
+	pf->pending = 1;
 
-/*
- * Find an element in the pending_free[] array for which no RCU callback is
- * pending and obtain the graph lock. May sleep.
- */
-static struct pending_free *get_pending_free_lock(unsigned long *flags)
-{
-	struct pending_free *pf;
+	WARN_ON_ONCE(pf->zapped + pf->index != zapped);
+	pf->index ^= 1;
+	/* Verify the list we just opened is empty. */
+	WARN_ON_ONCE(!list_empty(pf->zapped + pf->index));
 
-	WARN_ON_ONCE(inside_selftest());
+	call_rcu(&pending_free.rcu_head, free_zapped_rcu);
+}
 
-	for (;;) {
-		raw_local_irq_save(*flags);
-		if (!graph_lock()) {
-			raw_local_irq_restore(*flags);
-			return NULL;
-		}
-		pf = get_pending_free();
-		if (pf)
-			break;
-		graph_unlock();
-		raw_local_irq_restore(*flags);
+static void __free_zapped_classes(struct list_head *zapped)
+{
+	struct lock_class *class;
 
-		wait_event(rcu_cb, get_pending_free() != NULL);
-	}
+	list_for_each_entry(class, zapped, lock_entry)
+		reinit_class(class);
 
-	return pf;
+	list_splice_init(zapped, &free_lock_classes);
 }
 
 /*
- * Find an element in the pending_free[] array for which no RCU callback is
- * pending and obtain the graph lock. Ignores debug_locks. Does not sleep.
+ * pf->zapped + pf->index := head open for addition
+ * pf->zapped + (pf->idex ^ 1) := closed head, waiting for RCU QS
  */
-static struct pending_free *get_pending_free_lock_imm(unsigned long *flags)
+static void free_zapped_rcu(struct rcu_head *ch)
 {
-	struct pending_free *pf;
+	struct pending_free *pf = container_of(ch, typeof(*pf), rcu_head);
+	struct list_head *zapped;
+	unsigned long flags;
 
-	WARN_ON_ONCE(!inside_selftest());
+	if (WARN_ON_ONCE(pf != &pending_free))
+		return;
 
-	raw_local_irq_save(*flags);
-	arch_spin_lock(&lockdep_lock);
-	pf = get_pending_free();
-	if (!pf) {
-		arch_spin_unlock(&lockdep_lock);
-		raw_local_irq_restore(*flags);
-	}
+	raw_local_irq_save(flags);
+	if (!graph_lock())
+		goto out_irq;
+
+	zapped = pf->zapped + (pf->index ^ 1); /* closed head */
+	__free_zapped_classes(zapped); /* empty now */
+	pf->pending = 0;
 
-	return pf;
+	/* if there's anything on the open list, close and start a new callback */
+	call_rcu_zapped(pf->zapped + pf->index);
+
+	graph_unlock();
+out_irq:
+	raw_local_irq_restore(flags);
 }
 
 /*
@@ -4419,8 +4388,8 @@ static struct pending_free *get_pending_
  * start + size). Move these lock classes to the zapped_classes list. Must
  * be called with the graph lock held.
  */
-static void __lockdep_free_key_range(struct pending_free *pf, void *start,
-				     unsigned long size)
+static void
+__lockdep_free_key_range(struct list_head *zapped, void *start, unsigned long size)
 {
 	struct lock_class *class;
 	struct hlist_head *head;
@@ -4435,7 +4404,8 @@ static void __lockdep_free_key_range(str
 			if (!within(class->key, start, size) &&
 			    !within(class->name, start, size))
 				continue;
-			zap_class(pf, class);
+
+			zap_class(zapped, class);
 		}
 	}
 }
@@ -4450,19 +4420,23 @@ static void __lockdep_free_key_range(str
  */
 static void lockdep_free_key_range_reg(void *start, unsigned long size)
 {
-	struct pending_free *pf;
+	struct list_head *zapped;
 	unsigned long flags;
 
 	might_sleep();
 
 	init_data_structures_once();
 
-	pf = get_pending_free_lock(&flags);
-	if (!pf)
-		return;
-	__lockdep_free_key_range(pf, start, size);
-	schedule_free_zapped_classes(pf);
+	raw_local_irq_save(flags);
+	if (!graph_lock())
+		goto out_irq;
+
+	zapped = get_zapped_head();
+	__lockdep_free_key_range(zapped, start, size);
+	call_rcu_zapped(zapped);
+
 	graph_unlock();
+out_irq:
 	raw_local_irq_restore(flags);
 
 	/*
@@ -4480,19 +4454,21 @@ static void lockdep_free_key_range_reg(v
  */
 static void lockdep_free_key_range_imm(void *start, unsigned long size)
 {
-	struct pending_free *pf;
 	unsigned long flags;
+	LIST_HEAD(zapped);
 
 	init_data_structures_once();
 
-	pf = get_pending_free_lock_imm(&flags);
-	if (!pf)
-		return;
-	__lockdep_free_key_range(pf, start, size);
-	arch_spin_unlock(&lockdep_lock);
-	raw_local_irq_restore(flags);
+	raw_local_irq_save(flags);
+	if (!graph_lock())
+		goto out_irq;
 
-	free_zapped_classes(&pf->rcu_head);
+	__lockdep_free_key_range(&zapped, start, size);
+	__free_zapped_classes(&zapped);
+
+	graph_unlock();
+out_irq:
+	raw_local_irq_restore(flags);
 }
 
 void lockdep_free_key_range(void *start, unsigned long size)
@@ -4528,8 +4504,8 @@ static bool lock_class_cache_is_register
 }
 
 /* The caller must hold the graph lock. Does not sleep. */
-static void __lockdep_reset_lock(struct pending_free *pf,
-				 struct lockdep_map *lock)
+static void
+__lockdep_reset_lock(struct list_head *zapped, struct lockdep_map *lock)
 {
 	struct lock_class *class;
 	int j;
@@ -4543,7 +4519,7 @@ static void __lockdep_reset_lock(struct
 		 */
 		class = look_up_lock_class(lock, j);
 		if (class)
-			zap_class(pf, class);
+			zap_class(zapped, class);
 	}
 	/*
 	 * Debug check: in the end all mapped classes should
@@ -4559,17 +4535,21 @@ static void __lockdep_reset_lock(struct
  */
 static void lockdep_reset_lock_reg(struct lockdep_map *lock)
 {
-	struct pending_free *pf;
+	struct list_head *zapped;
 	unsigned long flags;
 
 	might_sleep();
 
-	pf = get_pending_free_lock(&flags);
-	if (!pf)
-		return;
-	__lockdep_reset_lock(pf, lock);
-	schedule_free_zapped_classes(pf);
+	raw_local_irq_save(flags);
+	if (!graph_lock())
+		goto out_irq;
+
+	zapped = get_zapped_head();
+	__lockdep_reset_lock(zapped, lock);
+	call_rcu_zapped(zapped);
+
 	graph_unlock();
+out_irq:
 	raw_local_irq_restore(flags);
 }
 
@@ -4579,17 +4559,19 @@ static void lockdep_reset_lock_reg(struc
  */
 static void lockdep_reset_lock_imm(struct lockdep_map *lock)
 {
-	struct pending_free *pf;
 	unsigned long flags;
+	LIST_HEAD(zapped);
 
-	pf = get_pending_free_lock_imm(&flags);
-	if (!pf)
-		return;
-	__lockdep_reset_lock(pf, lock);
-	arch_spin_unlock(&lockdep_lock);
-	raw_local_irq_restore(flags);
+	raw_local_irq_save(flags);
+	if (!graph_lock())
+		goto out_irq;
+
+	__lockdep_reset_lock(&zapped, lock);
+	__free_zapped_classes(&zapped);
 
-	free_zapped_classes(&pf->rcu_head);
+	graph_unlock();
+out_irq:
+	raw_local_irq_restore(flags);
 }
 
 void lockdep_reset_lock(struct lockdep_map *lock)
