Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D44C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC9220836
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC9220836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753978AbeGFHNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:13:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:44924 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753604AbeGFHNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:13:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0E520AD72;
        Fri,  6 Jul 2018 07:13:31 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Herbert <tom@quantonium.net>
Date:   Fri, 06 Jul 2018 17:11:32 +1000
Subject: [PATCH 1/3] rhashtable: further improve stability of rhashtable_walk
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <153086109256.2825.15329014177598382684.stgit@noble>
In-Reply-To: <153086101070.2825.6850140624411927465.stgit@noble>
References: <153086101070.2825.6850140624411927465.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the sequence:
   obj = rhashtable_walk_next(iter);
   rhashtable_walk_stop(iter);
   rhashtable_remove_fast(ht, &obj->head, params);
   rhashtable_walk_start(iter);

 races with another thread inserting or removing
 an object on the same hash chain, a subsequent
 rhashtable_walk_next() is not guaranteed to get the "next"
 object. It is possible that an object could be
 repeated, or missed.

 This can be made more reliable by keeping the objects in a hash chain
 sorted by memory address.  A subsequent rhashtable_walk_next()
 call can reliably find the correct position in the list, and thus
 find the 'next' object.

 It is not possible to take this approach with an rhltable as keeping
 the hash chain in order is not so easy.  When the first object with a
 given key is removed, it is replaced in the chain with the next
 object with the same key, and the address of that object may not be
 correctly ordered.
 I have not yet found any way to achieve the same stability
 with rhltables, that doesn't have a major impact on lookup
 or insert.  No code currently in Linux would benefit from
 such extra stability.

 With this patch:
 - a new object is always inserted after the last object with a
   smaller address, or at the start.  This preserves the property,
   important when allowing objects to be removed and re-added, that
   an object is never inserted *after* a position that it previously
   held in the list.
 - when rhashtable_walk_start() is called, it records that 'p' is not
   'safe', meaning that it cannot be dereferenced.  The revalidation
   that was previously done here is moved to rhashtable_walk_next()
 - when rhashtable_walk_next() is called while p is not NULL and not
   safe, it walks the chain looking for the first object with an
   address greater than p and returns that.  If there is none, it moves
   to the next hash chain.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable-types.h |    1 
 include/linux/rhashtable.h       |   10 ++++-
 lib/rhashtable.c                 |   82 +++++++++++++++++++++++++-------------
 3 files changed, 62 insertions(+), 31 deletions(-)

diff --git a/include/linux/rhashtable-types.h b/include/linux/rhashtable-types.h
index 763d613ce2c2..bc3e84547ba7 100644
--- a/include/linux/rhashtable-types.h
+++ b/include/linux/rhashtable-types.h
@@ -126,6 +126,7 @@ struct rhashtable_iter {
 	struct rhashtable_walker walker;
 	unsigned int slot;
 	unsigned int skip;
+	bool p_is_unsafe;
 	bool end_of_table;
 };
 
diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 10435a77b156..657e37ae314c 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -628,7 +628,12 @@ static inline void *__rhashtable_insert_fast(
 		    (params.obj_cmpfn ?
 		     params.obj_cmpfn(&arg, rht_obj(ht, head)) :
 		     rhashtable_compare(&arg, rht_obj(ht, head)))) {
-			pprev = &head->next;
+			if (rhlist) {
+				pprev = &head->next;
+			} else {
+				if (head < obj)
+					headp = &head->next;
+			}
 			continue;
 		}
 
@@ -1124,7 +1129,8 @@ static inline int rhashtable_walk_init(struct rhashtable *ht,
  * Note that if you restart a walk after rhashtable_walk_stop you
  * may see the same object twice.  Also, you may miss objects if
  * there are removals in between rhashtable_walk_stop and the next
- * call to rhashtable_walk_start.
+ * call to rhashtable_walk_start.  Note that this is different to
+ * rhashtable_walk_enter() which misses objects.
  *
  * For a completely stable walk you should construct your own data
  * structure outside the hash table.
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index f87af707f086..36f97d0c69ce 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -228,6 +228,7 @@ static int rhashtable_rehash_one(struct rhashtable *ht, unsigned int old_hash)
 	struct bucket_table *old_tbl = rht_dereference(ht->tbl, ht);
 	struct bucket_table *new_tbl = rhashtable_last_table(ht, old_tbl);
 	struct rhash_head __rcu **pprev = rht_bucket_var(old_tbl, old_hash);
+	struct rhash_head __rcu **inspos;
 	int err = -EAGAIN;
 	struct rhash_head *head, *next, *entry;
 	spinlock_t *new_bucket_lock;
@@ -256,12 +257,15 @@ static int rhashtable_rehash_one(struct rhashtable *ht, unsigned int old_hash)
 	new_bucket_lock = rht_bucket_lock(new_tbl, new_hash);
 
 	spin_lock_nested(new_bucket_lock, SINGLE_DEPTH_NESTING);
-	head = rht_dereference_bucket(new_tbl->buckets[new_hash],
-				      new_tbl, new_hash);
-
+	inspos = &new_tbl->buckets[new_hash];
+	head = rht_dereference_bucket(*inspos, new_tbl, new_hash);
+	while (!rht_is_a_nulls(head) && head < entry) {
+		inspos = &head->next;
+		head = rht_dereference_bucket(*inspos, new_tbl, new_hash);
+	}
 	RCU_INIT_POINTER(entry->next, head);
 
-	rcu_assign_pointer(new_tbl->buckets[new_hash], entry);
+	rcu_assign_pointer(*inspos, entry);
 	spin_unlock(new_bucket_lock);
 
 	rcu_assign_pointer(*pprev, next);
@@ -557,6 +561,10 @@ static struct bucket_table *rhashtable_insert_one(struct rhashtable *ht,
 		return ERR_PTR(-ENOMEM);
 
 	head = rht_dereference_bucket(*pprev, tbl, hash);
+	while (!ht->rhlist && !rht_is_a_nulls(head) && head < obj) {
+		pprev = &head->next;
+		head = rht_dereference_bucket(*pprev, tbl, hash);
+	}
 
 	RCU_INIT_POINTER(obj->next, head);
 	if (ht->rhlist) {
@@ -651,10 +659,10 @@ EXPORT_SYMBOL_GPL(rhashtable_insert_slow);
  *
  * This function prepares a hash table walk.
  *
- * Note that if you restart a walk after rhashtable_walk_stop you
- * may see the same object twice.  Also, you may miss objects if
- * there are removals in between rhashtable_walk_stop and the next
- * call to rhashtable_walk_start.
+ * A walk is guaranteed to return every object that was in
+ * the table before this call, and is still in the table when
+ * rhashtable_walk_next() returns NULL.  Duplicates can be
+ * seen, but only if there is a rehash event during the walk.
  *
  * For a completely stable walk you should construct your own data
  * structure outside the hash table.
@@ -738,19 +746,10 @@ int rhashtable_walk_start_check(struct rhashtable_iter *iter)
 
 	if (iter->p && !rhlist) {
 		/*
-		 * We need to validate that 'p' is still in the table, and
-		 * if so, update 'skip'
+		 * 'p' will be revalidated when rhashtable_walk_next()
+		 * is called.
 		 */
-		struct rhash_head *p;
-		int skip = 0;
-		rht_for_each_rcu(p, iter->walker.tbl, iter->slot) {
-			skip++;
-			if (p == iter->p) {
-				iter->skip = skip;
-				goto found;
-			}
-		}
-		iter->p = NULL;
+		iter->p_is_unsafe = true;
 	} else if (iter->p && rhlist) {
 		/* Need to validate that 'list' is still in the table, and
 		 * if so, update 'skip' and 'p'.
@@ -867,15 +866,39 @@ void *rhashtable_walk_next(struct rhashtable_iter *iter)
 	bool rhlist = ht->rhlist;
 
 	if (p) {
-		if (!rhlist || !(list = rcu_dereference(list->next))) {
-			p = rcu_dereference(p->next);
-			list = container_of(p, struct rhlist_head, rhead);
-		}
-		if (!rht_is_a_nulls(p)) {
-			iter->skip++;
-			iter->p = p;
-			iter->list = list;
-			return rht_obj(ht, rhlist ? &list->rhead : p);
+		if (!rhlist && iter->p_is_unsafe) {
+			/*
+			 * First time next() was called after start().
+			 * Need to find location of 'p' in the list.
+			 */
+			struct rhash_head *p;
+
+			iter->skip = 0;
+			rht_for_each_rcu(p, iter->walker.tbl, iter->slot) {
+				iter->skip++;
+				if (p <= iter->p)
+					continue;
+
+				/* p is the next object after iter->p */
+				iter->p = p;
+				iter->p_is_unsafe = false;
+				return rht_obj(ht, p);
+			}
+			/* There is no "next" object in the list, move
+			 * to next hash chain.
+			 */
+		} else {
+			if (!rhlist || !(list = rcu_dereference(list->next))) {
+				p = rcu_dereference(p->next);
+				list = container_of(p, struct rhlist_head,
+						    rhead);
+			}
+			if (!rht_is_a_nulls(p)) {
+				iter->skip++;
+				iter->p = p;
+				iter->list = list;
+				return rht_obj(ht, rhlist ? &list->rhead : p);
+			}
 		}
 
 		/* At the end of this slot, switch to next one and then find
@@ -885,6 +908,7 @@ void *rhashtable_walk_next(struct rhashtable_iter *iter)
 		iter->slot++;
 	}
 
+	iter->p_is_unsafe = false;
 	return __rhashtable_walk_find_next(iter);
 }
 EXPORT_SYMBOL_GPL(rhashtable_walk_next);


