Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B31C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA6720879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SFiK/UY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfAJTpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:45:14 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51124 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfAJTpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 14:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SA2rno/ImRtIKRvjBG0krAbnAAJOc3fz0NpY5rOe95U=; b=SFiK/UY7s8gj5nYtKBE9xZ1Q9
        QFjbQYO906lB8RwwmySzdHGSXABwRlewirqshoBvzoZP0Qko/R9YhUJOck85Sa0kGi6ucsumbr7Vc
        lhXsbhH25TA6bBfTwv5PSAt7SXVSzokIgW4g1Pr+vCZiFPARguh+C2A6AIgbEhJ4EuHsoD8nWKnAc
        OLGaFmkMF510RgvsKPCzEgA36ImCZ8+Fup9g1bwGZDpv1Zv3vfrOF40yhhetkQCjz8oATMiWVNh4/
        T7spUfuaMY+C2VJz/cMcO1G639KQGeC4ndBc7LiWl/59KZLF69yHwVdhb9bEnZFc/+Yuq3BCj0zAF
        y252EmYyg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghgGG-0006pE-6V; Thu, 10 Jan 2019 19:45:04 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D4C619844AF; Thu, 10 Jan 2019 20:44:59 +0100 (CET)
Date:   Thu, 10 Jan 2019 20:44:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v5 07/15] locking/lockdep: Free lock classes that are no
 longer in use
Message-ID: <20190110194459.GD2861@worktop.programming.kicks-ass.net>
References: <20181217213002.73776-1-bvanassche@acm.org>
 <20181217213002.73776-8-bvanassche@acm.org>
 <20190110152412.GG30894@hirez.programming.kicks-ass.net>
 <1547146287.83374.49.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547146287.83374.49.camel@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 10:51:27AM -0800, Bart Van Assche wrote:
> On Thu, 2019-01-10 at 16:24 +0100, Peter Zijlstra wrote:
> >  /*
> >   * A data structure for delayed freeing of data structures that may be
> > - * accessed by RCU readers at the time these were freed. The size of the array
> > - * is a compromise between minimizing the amount of memory used by this array
> > - * and minimizing the number of wait_event() calls by get_pending_free_lock().
> > + * accessed by RCU readers at the time these were freed.
> >   */
> >  static struct pending_free {
> > -	struct list_head zapped_classes;
> >  	struct rcu_head	 rcu_head;
> > +	int		 index;
> >  	int		 pending;
> > -} pending_free[2];
> > -static DECLARE_WAIT_QUEUE_HEAD(rcu_cb);
> > +	struct list_head zapped[2];
> > +} pending_free;
> 
> Hi Peter,
> 
> If the zapped[] array only has two elements there is no guarantee that an
> element will be free when zap_class() is called. I think we need at least
> num_online_cpus() elements to guarantee that at least one element is free
> when zap_class() is called. So removing the wait loop from
> get_pending_free_lock() seems wrong to me. Have you tried to run a workload
> that keeps all CPUs busy and that triggers get_pending_free_lock()
> frequently?

I have not ran (yet); but I do not quite follow your argument. There is
only a single rcu_head, yes? Thereby only a single list can be pending
at any one time, and the other list is free to be appended to during
this time -- all is serialized by the graph lock after all.

When the rcu callback happens, we flush the list we started the QS for,
which then becomes empty and if the open list contains entries, we
flip the lot and requeue the rcu_head for another QS.

Therefore we only ever need 2 lists; 1 closed with entries waiting for
the callback, 1 open, to which we can append all newly freed entries.

Find below a version of the patch that should apply to the first 13
patches. I'll try and run the whole set tomorrow morning or so.

---
Subject: lockdep: A wait-free RCU zapping
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Jan 10 16:16:33 CET 2019

Implement a version of the RCU zapped_classes list that doesn't
requiring waiting.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/lockdep.c |  257 +++++++++++++++++++++++------------------------
 1 file changed, 127 insertions(+), 130 deletions(-)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -292,18 +292,22 @@ LIST_HEAD(all_lock_classes);
 static LIST_HEAD(free_lock_classes);
 /*
  * A data structure for delayed freeing of data structures that may be
- * accessed by RCU readers at the time these were freed. The size of the array
- * is a compromise between minimizing the amount of memory used by this array
- * and minimizing the number of wait_event() calls by get_pending_free_lock().
+ * accessed by RCU readers at the time these were freed.
  */
-static struct pending_free {
+
+struct pending_free {
+	int empty;
 	struct list_head zapped_classes;
-	struct rcu_head	 rcu_head;
-	bool		 scheduled;
-	DECLARE_BITMAP(list_entries_being_freed, MAX_LOCKDEP_ENTRIES);
-	DECLARE_BITMAP(lock_chains_being_freed, MAX_LOCKDEP_CHAINS);
-} pending_free[2];
-static DECLARE_WAIT_QUEUE_HEAD(rcu_cb);
+	DECLARE_BITMAP(zapped_list_entries, MAX_LOCKDEP_ENTRIES);
+	DECLARE_BITMAP(zapped_lock_chains,  MAX_LOCKDEP_CHAINS);
+};
+
+static struct pending_head {
+	struct rcu_head rcu_head;
+	int index;
+	int pending;
+	struct pending_free pf[2];
+} pending_head;

 /*
  * The lockdep classes are in a hash-table as well, for fast lookup:
@@ -853,8 +857,9 @@ static bool list_entry_being_freed(int l
 	struct pending_free *pf;
 	int i;

-	for (i = 0, pf = pending_free; i < ARRAY_SIZE(pending_free); i++, pf++) {
-		if (test_bit(list_entry_idx, pf->list_entries_being_freed))
+	for (i = 0; i < ARRAY_SIZE(pending_head.pf); i++) {
+		pf = &pending_head.pf[i];
+		if (test_bit(list_entry_idx, pf->zapped_list_entries))
 			return true;
 	}

@@ -866,7 +871,8 @@ static bool in_any_zapped_class_list(str
 	struct pending_free *pf;
 	int i;

-	for (i = 0, pf = pending_free; i < ARRAY_SIZE(pending_free); i++, pf++) {
+	for (i = 0; i < ARRAY_SIZE(pending_head.pf); i++) {
+		pf = &pending_head.pf[i];
 		if (in_list(&class->lock_entry, &pf->zapped_classes))
 			return true;
 	}
@@ -958,7 +964,6 @@ static bool check_data_structures(void)
 static void init_data_structures_once(void)
 {
 	static bool initialization_happened;
-	struct pending_free *pf;
 	int i;

 	if (likely(initialization_happened))
@@ -966,10 +971,10 @@ static void init_data_structures_once(vo

 	initialization_happened = true;

-	for (i = 0, pf = pending_free; i < ARRAY_SIZE(pending_free);
-	     i++, pf++) {
+	init_rcu_head(&pending_head.rcu_head);
+	for (i = 0; i < ARRAY_SIZE(pending_head.pf); i++) {
+		struct pending_free *pf = &pending_head.pf[i];
 		INIT_LIST_HEAD(&pf->zapped_classes);
-		init_rcu_head(&pf->rcu_head);
 	}

 	for (i = 0; i < ARRAY_SIZE(lock_classes); i++) {
@@ -4406,10 +4411,11 @@ static void remove_class_from_lock_chain
 		if (chain_hlocks[i] != class - lock_classes)
 			continue;
 		/* The code below leaks one chain_hlock[] entry. */
-		if (--chain->depth > 0)
+		if (--chain->depth > 0) {
 			memmove(&chain_hlocks[i], &chain_hlocks[i + 1],
 				(chain->base + chain->depth - i) *
 				sizeof(chain_hlocks[0]));
+		}
 		/*
 		 * Each lock class occurs at most once in a lock chain so once
 		 * we found a match we can break out of this loop.
@@ -4432,7 +4438,8 @@ static void remove_class_from_lock_chain
 	 * hlist_for_each_entry_rcu() loop is safe.
 	 */
 	hlist_del_rcu(&chain->entry);
-	__set_bit(chain - lock_chains, pf->lock_chains_being_freed);
+	pf->empty = 0;
+	__set_bit(chain - lock_chains, pf->zapped_lock_chains);
 	if (chain->depth == 0)
 		return;
 	/*
@@ -4485,13 +4492,15 @@ static void zap_class(struct pending_fre
 		entry = list_entries + i;
 		if (entry->class != class && entry->links_to != class)
 			continue;
-		if (__test_and_set_bit(i, pf->list_entries_being_freed))
+		pf->empty = 0;
+		if (__test_and_set_bit(i, pf->zapped_list_entries))
 			continue;
 		nr_list_entries--;
 		list_del_rcu(&entry->entry);
 	}
 	if (list_empty(&class->locks_after) &&
 	    list_empty(&class->locks_before)) {
+		pf->empty = 0;
 		list_move_tail(&class->lock_entry, &pf->zapped_classes);
 		hlist_del_rcu(&class->hash_entry);
 		WRITE_ONCE(class->key, NULL);
@@ -4529,124 +4538,100 @@ static bool inside_selftest(void)
 	return current == lockdep_selftest_task_struct;
 }

-/*
- * Free all lock classes that are on the pf->zapped_classes list and also all
- * list entries that have been marked as being freed. Called as an RCU
- * callback function. May be called from RCU callback context.
- */
-static void free_zapped_classes(struct rcu_head *ch)
+/* must hold graph lock */
+struct pending_free *get_pf(void)
 {
-	struct pending_free *pf = container_of(ch, typeof(*pf), rcu_head);
-	struct lock_class *class;
-	unsigned long flags;
-
-	raw_local_irq_save(flags);
-	if (!graph_lock())
-		goto restore_irqs;
-	pf->scheduled = false;
-	if (check_data_structure_consistency)
-		WARN_ON_ONCE(!check_data_structures());
-	list_for_each_entry(class, &pf->zapped_classes, lock_entry) {
-		reinit_class(class);
-	}
-	list_splice_init(&pf->zapped_classes, &free_lock_classes);
-	bitmap_andnot(list_entries_in_use, list_entries_in_use,
-		      pf->list_entries_being_freed, ARRAY_SIZE(list_entries));
-	bitmap_clear(pf->list_entries_being_freed, 0, ARRAY_SIZE(list_entries));
-#ifdef CONFIG_PROVE_LOCKING
-	bitmap_andnot(lock_chains_in_use, lock_chains_in_use,
-		      pf->lock_chains_being_freed, ARRAY_SIZE(lock_chains));
-	bitmap_clear(pf->lock_chains_being_freed, 0, ARRAY_SIZE(lock_chains));
-#endif
-	graph_unlock();
-restore_irqs:
-	raw_local_irq_restore(flags);
+	struct pending_head *ph = &pending_head;

-	wake_up(&rcu_cb);
+	return ph->pf + ph->index;
 }

+static void pending_free_rcu(struct rcu_head *ch);
+
 /* Schedule an RCU callback. Must be called with the graph lock held. */
-static void schedule_free_zapped_classes(struct pending_free *pf)
+static void put_pf(struct pending_free *pf)
 {
+	struct pending_head *ph = &pending_head;
+
 	WARN_ON_ONCE(inside_selftest());
-	pf->scheduled = true;
-	call_rcu(&pf->rcu_head, free_zapped_classes);
-}
+	WARN_ON_ONCE(pf != get_pf());

-/*
- * Find an element in the pending_free[] array for which no RCU callback is
- * pending.
- */
-static struct pending_free *get_pending_free(void)
-{
-	struct pending_free *pf;
-	int i;
+	if (pf->empty)
+		return;
+
+	if (ph->pending)
+		return;

-	for (i = 0, pf = pending_free; i < ARRAY_SIZE(pending_free);
-	     i++, pf++)
-		if (!pf->scheduled)
-			return pf;
+	ph->pending = 1;
+	ph->index ^= 1;
+	/* Verify the list we just opened is empty. */
+	WARN_ON_ONCE(!get_pf()->empty);

-	return NULL;
+	call_rcu(&ph->rcu_head, pending_free_rcu);
 }

-/*
- * Find an element in the pending_free[] array for which no RCU callback is
- * pending and obtain the graph lock. May sleep.
- */
-static struct pending_free *get_pending_free_lock(unsigned long *flags)
+static void __free_pending(struct pending_free *pf)
 {
-	struct pending_free *pf;
+	struct lock_class *class;

-	WARN_ON_ONCE(inside_selftest());
+	if (check_data_structure_consistency)
+		WARN_ON_ONCE(!check_data_structures());

-	while (true) {
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
+	list_for_each_entry(class, &pf->zapped_classes, lock_entry)
+		reinit_class(class);

-		wait_event(rcu_cb, get_pending_free() != NULL);
-	}
+	list_splice_init(&pf->zapped_classes, &free_lock_classes);
+
+	bitmap_andnot(list_entries_in_use, list_entries_in_use,
+		      pf->zapped_list_entries, ARRAY_SIZE(list_entries));
+	bitmap_clear(pf->zapped_list_entries, 0, ARRAY_SIZE(list_entries));
+#ifdef CONFIG_PROVE_LOCKING
+	bitmap_andnot(lock_chains_in_use, lock_chains_in_use,
+		      pf->zapped_lock_chains, ARRAY_SIZE(lock_chains));
+	bitmap_clear(pf->zapped_lock_chains, 0, ARRAY_SIZE(lock_chains));
+#endif

-	return pf;
+	pf->empty = 1;
 }

 /*
- * Find an element in the pending_free[] array for which no RCU callback is
- * pending and obtain the graph lock. Ignores debug_locks. Does not sleep.
+ * ph->pf + ph->index      := head open for addition
+ * ph->pf + (ph->idex ^ 1) := closed head, waiting for RCU QS
  */
-static struct pending_free *get_pending_free_lock_imm(unsigned long *flags)
+static void pending_free_rcu(struct rcu_head *ch)
 {
+	struct pending_head *ph = container_of(ch, typeof(*ph), rcu_head);
 	struct pending_free *pf;
+	unsigned long flags;

-	WARN_ON_ONCE(!inside_selftest());
+	if (WARN_ON_ONCE(ph != &pending_head))
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
+	pf = ph->pf + (ph->index ^ 1); /* closed head */
+	__free_pending(pf); /* empty now */
+	ph->pending = 0;
+
+	/* if there's anything on the open list, close and start a new callback */
+	put_pf(get_pf());

-	return pf;
+	graph_unlock();
+out_irq:
+	raw_local_irq_restore(flags);
 }

+
 /*
  * Remove all lock classes from the class hash table and from the
  * all_lock_classes list whose key or name is in the address range [start,
  * start + size). Move these lock classes to the zapped_classes list. Must
  * be called with the graph lock held.
  */
-static void __lockdep_free_key_range(struct pending_free *pf, void *start,
-				     unsigned long size)
+static void
+__lockdep_free_key_range(struct pending_free *pf, void *start, unsigned long size)
 {
 	struct lock_class *class;
 	struct hlist_head *head;
@@ -4683,12 +4668,16 @@ static void lockdep_free_key_range_reg(v

 	init_data_structures_once();

-	pf = get_pending_free_lock(&flags);
-	if (!pf)
-		return;
+	raw_local_irq_save(flags);
+	if (!graph_lock())
+		goto out_irq;
+
+	pf = get_pf();
 	__lockdep_free_key_range(pf, start, size);
-	schedule_free_zapped_classes(pf);
+	put_pf(pf);
+
 	graph_unlock();
+out_irq:
 	raw_local_irq_restore(flags);

 	/*
@@ -4702,23 +4691,25 @@ static void lockdep_free_key_range_reg(v

 /*
  * Free all lockdep keys in the range [start, start+size). Does not sleep.
- * Ignores debug_locks. Must only be used by the lockdep selftests.
+ * Must only be used by the lockdep selftests.
  */
 static void lockdep_free_key_range_imm(void *start, unsigned long size)
 {
-	struct pending_free *pf;
+	struct pending_free *pf = get_pf();
 	unsigned long flags;

 	init_data_structures_once();

-	pf = get_pending_free_lock_imm(&flags);
-	if (!pf)
-		return;
+	raw_local_irq_save(flags);
+	if (!graph_lock())
+		goto out_irq;
+
 	__lockdep_free_key_range(pf, start, size);
-	arch_spin_unlock(&lockdep_lock);
-	raw_local_irq_restore(flags);
+	__free_pending(pf);

-	free_zapped_classes(&pf->rcu_head);
+	graph_unlock();
+out_irq:
+	raw_local_irq_restore(flags);
 }

 void lockdep_free_key_range(void *start, unsigned long size)
@@ -4754,8 +4745,8 @@ static bool lock_class_cache_is_register
 }

 /* The caller must hold the graph lock. Does not sleep. */
-static void __lockdep_reset_lock(struct pending_free *pf,
-				 struct lockdep_map *lock)
+static void
+__lockdep_reset_lock(struct pending_free *pf, struct lockdep_map *lock)
 {
 	struct lock_class *class;
 	int j;
@@ -4790,32 +4781,38 @@ static void lockdep_reset_lock_reg(struc

 	might_sleep();

-	pf = get_pending_free_lock(&flags);
-	if (!pf)
-		return;
+	raw_local_irq_save(flags);
+	if (!graph_lock())
+		goto out_irq;
+
+	pf = get_pf();
 	__lockdep_reset_lock(pf, lock);
-	schedule_free_zapped_classes(pf);
+	put_pf(pf);
+
 	graph_unlock();
+out_irq:
 	raw_local_irq_restore(flags);
 }

 /*
- * Reset a lock. Does not sleep. Ignores debug_locks. Must only be used by the
+ * Reset a lock. Does not sleep. Must only be used by the
  * lockdep selftests.
  */
 static void lockdep_reset_lock_imm(struct lockdep_map *lock)
 {
-	struct pending_free *pf;
+	struct pending_free *pf = get_pf();
 	unsigned long flags;

-	pf = get_pending_free_lock_imm(&flags);
-	if (!pf)
-		return;
+	raw_local_irq_save(flags);
+	if (!graph_lock())
+		goto out_irq;
+
 	__lockdep_reset_lock(pf, lock);
-	arch_spin_unlock(&lockdep_lock);
-	raw_local_irq_restore(flags);
+	__free_pending(pf);

-	free_zapped_classes(&pf->rcu_head);
+	graph_unlock();
+out_irq:
+	raw_local_irq_restore(flags);
 }

 void lockdep_reset_lock(struct lockdep_map *lock)

