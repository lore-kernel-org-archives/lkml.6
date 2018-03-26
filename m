Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752538AbeC0Bv4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 21:51:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:39065 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752469AbeC0Bvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 21:51:52 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 27 Mar 2018 10:33:04 +1100
Subject: [PATCH 6/6] rhashtable: allow element counting to be disabled.
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152210718437.11435.16828067826759352250.stgit@noble>
In-Reply-To: <152210688405.11435.13010923693146415942.stgit@noble>
References: <152210688405.11435.13010923693146415942.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If multiple CPUs are performing concurrent updates, they can
contend on accessing the element counter even when they
don't often content on hash chains or spin locks.  This can
hurt performance.

The nelems counter is only used to trigger a resize at the
70% and 30% marks, so it does not need to be precise.

It is easy to calculate an approximate value when the table
is being rehashed, and this happens when a chain is found to
be 16 elements long.  So just moving the counting from
"every update" to "every rehash" removes lots of contention,
but has the down-side is that it allows the max bucket size
to grow to 16 (so average is probably under 8).  The normal
average is close to 1.

As a rehash can sometimes not see all (or any) elements, such as when
multiple tables are in the table chain, it is only safe to increase
nelems to match the number rehashed, never to decrease it.

If a client wants minimal contention while still maintaining
a shorter chain length, it can run a periodic task which
counts the number of elements and updates ->nelems directly.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |   26 ++++++++++++++++++--------
 lib/rhashtable.c           |   22 +++++++++++++++-------
 2 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index abdeb1f3f378..d0ce5635540f 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -134,6 +134,11 @@ struct rhashtable;
  * @never_fail_insert: Insert will always succeed, even if table will become
  *           unbalanced.  Without this, -E2BIG, -EBUSY, and -ENOMEM are possible
  *           errors from rhashtable_*insert*()
+ * @disable_count: Disable precise counting of number of entries.  It is only
+ *           updated approximately when the hash table is resized.
+ *           This reduces contention in parallel updates, but means we only
+ *           grow the table when a hash chain length reaches 16 or when owner
+ *           directly updates ->nelems.
  * @nulls_base: Base value to generate nulls marker
  * @hashfn: Hash function (default: jhash2 if !(key_len % 4), or jhash)
  * @obj_hashfn: Function to hash object
@@ -148,6 +153,7 @@ struct rhashtable_params {
 	u16			min_size;
 	bool			automatic_shrinking;
 	bool			never_fail_insert;
+	bool			disable_count;
 	u8			locks_mul;
 	u32			nulls_base;
 	rht_hashfn_t		hashfn;
@@ -838,10 +844,12 @@ static inline void *__rhashtable_insert_fast(
 
 	rcu_assign_pointer(*pprev, obj);
 
-	if (params.never_fail_insert)
-		atomic_add_unless(&ht->nelems, 1, INT_MAX);
-	else
-		atomic_inc(&ht->nelems);
+	if (!params.disable_count) {
+		if (params.never_fail_insert)
+			atomic_add_unless(&ht->nelems, 1, INT_MAX);
+		else
+			atomic_inc(&ht->nelems);
+	}
 	if (rht_grow_above_75(ht, tbl))
 		schedule_work(&ht->run_work);
 
@@ -1113,10 +1121,12 @@ static inline int __rhashtable_remove_fast_one(
 	spin_unlock_bh(lock);
 
 	if (err > 0) {
-		if (params.never_fail_insert)
-			atomic_add_unless(&ht->nelems, -1, INT_MAX);
-		else
-			atomic_dec(&ht->nelems);
+		if (!params.disable_count) {
+			if (params.never_fail_insert)
+				atomic_add_unless(&ht->nelems, -1, INT_MAX);
+			else
+				atomic_dec(&ht->nelems);
+		}
 		if (unlikely(ht->p.automatic_shrinking &&
 			     rht_shrink_below_30(ht, tbl)))
 			schedule_work(&ht->run_work);
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 427836aace60..686193faf271 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -278,12 +278,13 @@ static int rhashtable_rehash_chain(struct rhashtable *ht,
 	struct bucket_table *old_tbl = rht_dereference(ht->tbl, ht);
 	spinlock_t *old_bucket_lock;
 	int err;
+	int cnt = 0;
 
 	old_bucket_lock = rht_bucket_lock(old_tbl, old_hash);
 
 	spin_lock_bh(old_bucket_lock);
 	while (!(err = rhashtable_rehash_one(ht, old_hash)))
-		;
+		cnt++;
 
 	if (err == -ENOENT) {
 		old_tbl->rehash++;
@@ -291,7 +292,7 @@ static int rhashtable_rehash_chain(struct rhashtable *ht,
 	}
 	spin_unlock_bh(old_bucket_lock);
 
-	return err;
+	return err ?: cnt;
 }
 
 static int rhashtable_rehash_attach(struct rhashtable *ht,
@@ -324,6 +325,7 @@ static int rhashtable_rehash_table(struct rhashtable *ht)
 	struct rhashtable_walker *walker;
 	unsigned int old_hash;
 	int err;
+	unsigned int cnt = 0;
 
 	new_tbl = rht_dereference(old_tbl->future_tbl, ht);
 	if (!new_tbl)
@@ -331,12 +333,16 @@ static int rhashtable_rehash_table(struct rhashtable *ht)
 
 	for (old_hash = 0; old_hash < old_tbl->size; old_hash++) {
 		err = rhashtable_rehash_chain(ht, old_hash);
-		if (err)
+		if (err < 0)
 			return err;
+		if (INT_MAX - cnt > err)
+			cnt += err;
 	}
 
 	/* Publish the new table pointer. */
 	rcu_assign_pointer(ht->tbl, new_tbl);
+	if (ht->p.disable_count && cnt > atomic_read(&ht->nelems))
+		atomic_set(&ht->nelems, cnt);
 
 	spin_lock(&ht->lock);
 	list_for_each_entry(walker, &old_tbl->walkers, list)
@@ -582,10 +588,12 @@ static struct bucket_table *rhashtable_insert_one(struct rhashtable *ht,
 
 	rcu_assign_pointer(*pprev, obj);
 
-	if (ht->p.never_fail_insert)
-		atomic_add_unless(&ht->nelems, 1, INT_MAX);
-	else
-		atomic_inc(&ht->nelems);
+	if (!ht->p.disable_count) {
+		if (ht->p.never_fail_insert)
+			atomic_add_unless(&ht->nelems, 1, INT_MAX);
+		else
+			atomic_inc(&ht->nelems);
+	}
 	if (rht_grow_above_75(ht, tbl))
 		schedule_work(&ht->run_work);
 
