Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeFAEq4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 00:46:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:34207 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751792AbeFAEqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 00:46:47 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 01 Jun 2018 14:44:09 +1000
Subject: [PATCH 16/18] rhashtable: allow percpu element counter
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152782824988.30340.1959305499830343473.stgit@noble>
In-Reply-To: <152782754287.30340.4395718227884933670.stgit@noble>
References: <152782754287.30340.4395718227884933670.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an rhashtable is receiving a high rate of updates on multiple
CPUs, the atomic update to the nelems counter can become a
measurable contention point.

We can use a per-cpu counter instead of an atomic_t.  This reduces the
contention on updates, but reduces the precision for grow/shrink
decisions.  This results in a performance trade-off between updates
and lookups.  Updates should be faster due to reduced contention,
lookups could be slower if a resize is delayed.  This trade-off will
only be appropriate on rhashtables which have a high proportion of
updates compared to lookups.

A fast read of a percpu counter can have an error of as much
as 32 times the number of CPUs.  A more precise count can be
extracted, but this takes longer.  It seems sensible to
use the fast read to schedule a rehash, and the slow read
to choose the new size of the table.  This has the drawback
that if the fast read is sufficiently higher than the slow read,
we might repeatedly schedule a rehash which never happens.
To avoid this, we record the most recently noticed difference
between the two reads and use this to adjust the estimate returned
by the fast read.  If the rehash thread determines that a rehash is
not needed, it will update the recored error so that updaters
will not schedule the thread again until there is substantially
more growth.

When the fast-read shows that the table is over 100% full,
we need to double check with a slow read at that point too,
and update the recorded error to ensure we only resize
when it is really appropriate, but don't keep performing slow
tests to see exactly when it is appropriate.

The error we keep (in pnelems_error) is 1.5 time the absolute
difference between percpu_counter_read_positive() and
percpu_counter_sum_positive().  The extra 50% reduces the frequency
with which we have to do the slow read, at a cost of allowing
the occupancy rate to grow well above 1 (but usually less than 2).

This patch includes a change to include/linux/percpu_counter.h
to make some functions accept a const pointer.

It also adds a module parameter to test_rhashtable.ko to allow
testing of percpu counters.

Signed-off-by: NeilBrown <neil@brown.name>
---
 include/linux/percpu_counter.h   |    4 +
 include/linux/rhashtable-types.h |    8 ++
 include/linux/rhashtable.h       |  126 +++++++++++++++++++++++++++++++++-----
 lib/rhashtable.c                 |   70 +++++++++++++++++----
 lib/test_rhashtable.c            |   14 ++++
 5 files changed, 189 insertions(+), 33 deletions(-)

diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index 4f052496cdfd..a541a6c49a88 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -66,7 +66,7 @@ static inline s64 percpu_counter_sum(struct percpu_counter *fbc)
 	return __percpu_counter_sum(fbc);
 }
 
-static inline s64 percpu_counter_read(struct percpu_counter *fbc)
+static inline s64 percpu_counter_read(const struct percpu_counter *fbc)
 {
 	return fbc->count;
 }
@@ -76,7 +76,7 @@ static inline s64 percpu_counter_read(struct percpu_counter *fbc)
  * number for some counter which should never be negative.
  *
  */
-static inline s64 percpu_counter_read_positive(struct percpu_counter *fbc)
+static inline s64 percpu_counter_read_positive(const struct percpu_counter *fbc)
 {
 	s64 ret = fbc->count;
 
diff --git a/include/linux/rhashtable-types.h b/include/linux/rhashtable-types.h
index 39e5e1fb9b65..c08c3bcfb5ad 100644
--- a/include/linux/rhashtable-types.h
+++ b/include/linux/rhashtable-types.h
@@ -13,6 +13,7 @@
 #include <linux/compiler.h>
 #include <linux/mutex.h>
 #include <linux/workqueue.h>
+#include <linux/percpu_counter.h>
 
 struct rhash_head {
 	struct rhash_head __rcu		*next;
@@ -49,6 +50,7 @@ typedef int (*rht_obj_cmpfn_t)(struct rhashtable_compare_arg *arg,
  * @max_size: Maximum size while expanding
  * @min_size: Minimum size while shrinking
  * @automatic_shrinking: Enable automatic shrinking of tables
+ * @percpu_count: Use a per-cpu counter instead of atomic_t
  * @hashfn: Hash function (default: jhash2 if !(key_len % 4), or jhash)
  * @obj_hashfn: Function to hash object
  * @obj_cmpfn: Function to compare key with object
@@ -61,6 +63,7 @@ struct rhashtable_params {
 	unsigned int		max_size;
 	u16			min_size;
 	bool			automatic_shrinking;
+	bool			percpu_count;
 	rht_hashfn_t		hashfn;
 	rht_obj_hashfn_t	obj_hashfn;
 	rht_obj_cmpfn_t		obj_cmpfn;
@@ -77,6 +80,9 @@ struct rhashtable_params {
  * @mutex: Mutex to protect current/future table swapping
  * @lock: Spin lock to protect walker list
  * @nelems: Number of elements in table
+ * @pnelems: Alternate per-cpu nelems counter
+ * @pnelems_error: absolute difference between approximate and actual
+ *          percpu count at last check: 1.5 * abs("read" - "sum").
  */
 struct rhashtable {
 	struct bucket_table __rcu	*tbl;
@@ -88,6 +94,8 @@ struct rhashtable {
 	struct mutex                    mutex;
 	spinlock_t			lock;
 	atomic_t			nelems;
+	struct percpu_counter		pnelems;
+	unsigned int			pnelems_error;
 };
 
 /**
diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 8e4d483ddf22..f58cb62dce05 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -27,6 +27,8 @@
 #include <linux/bit_spinlock.h>
 
 #include <linux/rhashtable-types.h>
+#include <linux/percpu_counter.h>
+
 /*
  * The end of the chain is marked with a special nulls marks which has
  * the least significant bit set.
@@ -200,30 +202,95 @@ static inline unsigned int rht_head_hashfn(
 	       rht_key_hashfn(ht, tbl, ptr + params.key_offset, params);
 }
 
+/*
+ * Per-CPU element counting.
+ * During insert/remove we check the percpu element counter (if active)
+ * with percpu_counter_read_positive().  This is fast but has a possible
+ * error of as much as 32*NUM_CPUS.
+ * In the rehash thread, we determine the number of elements with
+ * percpu_counter_sum_positive().  This is slower and more precise.
+ * We chose a new table size based on this precise count.
+ * If the approximate count is more than 70% of the table size, while
+ * the precise count is below that, the above rules would cause the
+ * rehash thread to be continually scheduled, which is not ideal.
+ * So we record an error, being 1.5 times the absolute difference between
+ * the approximate and precise element counts.  When testing if we need to grow,
+ * we subtract the error from the approximate count, and test that.
+ * When testing if we need to shrink, we add the error.
+ * This ensures we don't thrash the rehash thread, at the cost of delaying
+ * resize operations.  This is the cost trade-off for using per-cpu
+ * element counting:  insert/remove will be faster by avoiding an atomic
+ * operation 31/32 of the time, but lookup might be slower as hash chains
+ * can be expected to be slightly longer on average.  If the error is
+ * so bad that hash chains grow to 16 (could happen when the table is small
+ * and lots of CPUs are adding items), that will trigger a rehash which will
+ * correct the table size update the recorded error.  Possibly the '16' should
+ * be reduce to 8 when per-cpu element counting is active.
+ */
+
+static inline bool __rht_grow_above_75(const struct rhashtable *ht,
+				       const struct bucket_table *tbl,
+				       unsigned int nelems)
+{
+	return nelems > (tbl->size / 4 * 3) &&
+	       (!ht->p.max_size || tbl->size < ht->p.max_size);
+}
 /**
  * rht_grow_above_75 - returns true if nelems > 0.75 * table-size
  * @ht:		hash table
  * @tbl:	current table
  */
 static inline bool rht_grow_above_75(const struct rhashtable *ht,
-				     const struct bucket_table *tbl)
+				     const struct bucket_table *tbl,
+				     const struct rhashtable_params params)
 {
 	/* Expand table when exceeding 75% load */
-	return atomic_read(&ht->nelems) > (tbl->size / 4 * 3) &&
-	       (!ht->p.max_size || tbl->size < ht->p.max_size);
+	unsigned int nelems;
+
+	if (!params.percpu_count)
+		nelems = atomic_read(&ht->nelems);
+	else {
+		nelems = percpu_counter_read_positive(&ht->pnelems);
+		if (nelems > ht->pnelems_error)
+			nelems -= ht->pnelems_error;
+	}
+	return __rht_grow_above_75(ht, tbl, nelems);
 }
 
+static inline bool __rht_shrink_below_30(const struct rhashtable *ht,
+					 const struct bucket_table *tbl,
+					 const unsigned int nelems)
+{
+	/* Shrink table beneath 30% load */
+	return nelems < (tbl->size * 3 / 10) &&
+	       tbl->size > ht->p.min_size;
+}
 /**
  * rht_shrink_below_30 - returns true if nelems < 0.3 * table-size
  * @ht:		hash table
  * @tbl:	current table
  */
 static inline bool rht_shrink_below_30(const struct rhashtable *ht,
-				       const struct bucket_table *tbl)
+				       const struct bucket_table *tbl,
+				       const struct rhashtable_params params)
 {
 	/* Shrink table beneath 30% load */
-	return atomic_read(&ht->nelems) < (tbl->size * 3 / 10) &&
-	       tbl->size > ht->p.min_size;
+	unsigned int nelems;
+
+	if (params.percpu_count)
+		nelems = percpu_counter_read_positive(&ht->pnelems) +
+			ht->pnelems_error;
+	else
+		nelems = atomic_read(&ht->nelems);
+	return __rht_shrink_below_30(ht, tbl, nelems);
+}
+
+static inline bool __rht_grow_above_100(const struct rhashtable *ht,
+					const struct bucket_table *tbl,
+					unsigned int nelems)
+{
+	return nelems > tbl->size &&
+		(!ht->p.max_size || tbl->size < ht->p.max_size);
 }
 
 /**
@@ -232,10 +299,19 @@ static inline bool rht_shrink_below_30(const struct rhashtable *ht,
  * @tbl:	current table
  */
 static inline bool rht_grow_above_100(const struct rhashtable *ht,
-				      const struct bucket_table *tbl)
+				      const struct bucket_table *tbl,
+				      const struct rhashtable_params params)
 {
-	return atomic_read(&ht->nelems) > tbl->size &&
-		(!ht->p.max_size || tbl->size < ht->p.max_size);
+	unsigned int nelems;
+
+	if (!params.percpu_count)
+		nelems = atomic_read(&ht->nelems);
+	else {
+		nelems = percpu_counter_read_positive(&ht->pnelems);
+		if (nelems > ht->pnelems_error)
+			nelems -= ht->pnelems_error;
+	}
+	return __rht_grow_above_100(ht, tbl, nelems);
 }
 
 /**
@@ -244,9 +320,19 @@ static inline bool rht_grow_above_100(const struct rhashtable *ht,
  * @tbl:	current table
  */
 static inline bool rht_grow_above_max(const struct rhashtable *ht,
-				      const struct bucket_table *tbl)
+				      const struct bucket_table *tbl,
+				      const struct rhashtable_params params)
 {
-	return atomic_read(&ht->nelems) >= ht->max_elems;
+	unsigned int nelems;
+
+	if (!params.percpu_count)
+		nelems = atomic_read(&ht->nelems);
+	else {
+		nelems = percpu_counter_read_positive(&ht->pnelems);
+		if (nelems > ht->pnelems_error)
+			nelems -= ht->pnelems_error;
+	}
+	return nelems >= ht->max_elems;
 }
 
 #ifdef CONFIG_PROVE_LOCKING
@@ -699,10 +785,10 @@ static inline void *__rhashtable_insert_fast(
 		goto slow_path;
 
 	data = ERR_PTR(-E2BIG);
-	if (unlikely(rht_grow_above_max(ht, tbl)))
+	if (unlikely(rht_grow_above_max(ht, tbl, params)))
 		goto out;
 
-	if (unlikely(rht_grow_above_100(ht, tbl)))
+	if (unlikely(rht_grow_above_100(ht, tbl, params)))
 		goto slow_path;
 
 	head = rht_dereference_bucket(*headp, tbl, hash);
@@ -717,8 +803,11 @@ static inline void *__rhashtable_insert_fast(
 
 	rcu_assign_pointer(*headp, obj);
 
-	atomic_inc(&ht->nelems);
-	if (rht_grow_above_75(ht, tbl))
+	if (params.percpu_count)
+		percpu_counter_inc(&ht->pnelems);
+	else
+		atomic_inc(&ht->nelems);
+	if (rht_grow_above_75(ht, tbl, params))
 		schedule_work(&ht->run_work);
 
 good:
@@ -990,9 +1079,12 @@ static inline int __rhashtable_remove_fast_one(
 	rht_unlock(lock);
 unlocked:
 	if (err > 0) {
-		atomic_dec(&ht->nelems);
+		if (params.percpu_count)
+			percpu_counter_dec(&ht->pnelems);
+		else
+			atomic_dec(&ht->nelems);
 		if (unlikely(ht->p.automatic_shrinking &&
-			     rht_shrink_below_30(ht, tbl)))
+			     rht_shrink_below_30(ht, tbl, params)))
 			schedule_work(&ht->run_work);
 		err = 0;
 	}
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 381acab7a909..1b9820787cd5 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -386,10 +386,9 @@ static int rhashtable_rehash_alloc(struct rhashtable *ht,
  * It is valid to have concurrent insertions and deletions protected by per
  * bucket locks or concurrent RCU protected lookups and traversals.
  */
-static int rhashtable_shrink(struct rhashtable *ht)
+static int rhashtable_shrink(struct rhashtable *ht, const unsigned int nelems)
 {
 	struct bucket_table *old_tbl = rht_dereference(ht->tbl, ht);
-	unsigned int nelems = atomic_read(&ht->nelems);
 	unsigned int size = 0;
 
 	if (nelems)
@@ -406,10 +405,28 @@ static int rhashtable_shrink(struct rhashtable *ht)
 	return rhashtable_rehash_alloc(ht, old_tbl, size);
 }
 
+static int check_nelems(struct rhashtable *ht)
+{
+	unsigned int nelems;
+
+	if (ht->p.percpu_count) {
+		unsigned int approx = percpu_counter_read_positive(&ht->pnelems);
+
+		nelems = percpu_counter_sum_positive(&ht->pnelems);
+		if (approx > nelems)
+			ht->pnelems_error = (approx - nelems) * 3 / 2;
+		else
+			ht->pnelems_error = (nelems - approx) * 3 / 2;
+	} else
+		nelems = atomic_read(&ht->nelems);
+	return nelems;
+}
+
 static void rht_deferred_worker(struct work_struct *work)
 {
 	struct rhashtable *ht;
 	struct bucket_table *tbl;
+	unsigned int nelems;
 	int err = 0;
 
 	ht = container_of(work, struct rhashtable, run_work);
@@ -418,10 +435,18 @@ static void rht_deferred_worker(struct work_struct *work)
 	tbl = rht_dereference(ht->tbl, ht);
 	tbl = rhashtable_last_table(ht, tbl);
 
-	if (rht_grow_above_75(ht, tbl))
-		err = rhashtable_rehash_alloc(ht, tbl, tbl->size * 2);
-	else if (ht->p.automatic_shrinking && rht_shrink_below_30(ht, tbl))
-		err = rhashtable_shrink(ht);
+	nelems = check_nelems(ht);
+
+	if (__rht_grow_above_75(ht, tbl, nelems)) {
+		unsigned int size = roundup_pow_of_two(nelems * 4 / 3);
+
+		if (ht->p.max_size && size > ht->p.max_size)
+			size = ht->p.max_size;
+
+		err = rhashtable_rehash_alloc(ht, tbl, size);
+	} else if (ht->p.automatic_shrinking &&
+		   __rht_shrink_below_30(ht, tbl, nelems))
+		err = rhashtable_shrink(ht, nelems);
 	else if (tbl->nest)
 		err = rhashtable_rehash_alloc(ht, tbl, tbl->size);
 
@@ -439,6 +464,7 @@ static int rhashtable_insert_rehash(struct rhashtable *ht,
 {
 	struct bucket_table *old_tbl;
 	struct bucket_table *new_tbl;
+	unsigned int nelems;
 	unsigned int size;
 	int err;
 
@@ -448,7 +474,12 @@ static int rhashtable_insert_rehash(struct rhashtable *ht,
 
 	err = -EBUSY;
 
-	if (rht_grow_above_75(ht, tbl))
+	/* Now is a good time to ensure ->pnelems_error is up to date,
+	 * and to use the exact count
+	 */
+	nelems = check_nelems(ht);
+
+	if (__rht_grow_above_75(ht, tbl, nelems))
 		size *= 2;
 	/* Do not schedule more than one rehash */
 	else if (old_tbl != tbl)
@@ -556,11 +587,15 @@ static struct bucket_table *rhashtable_insert_one(struct rhashtable *ht,
 	if (PTR_ERR(data) != -ENOENT)
 		return ERR_CAST(data);
 
-	if (unlikely(rht_grow_above_max(ht, tbl)))
+	if (unlikely(rht_grow_above_max(ht, tbl, ht->p)))
 		return ERR_PTR(-E2BIG);
 
-	if (unlikely(rht_grow_above_100(ht, tbl)))
-		return ERR_PTR(-EAGAIN);
+	if (unlikely(rht_grow_above_100(ht, tbl, ht->p))) {
+		unsigned int nelems = check_nelems(ht);
+
+		if (__rht_grow_above_100(ht, tbl, nelems))
+			return ERR_PTR(-EAGAIN);
+	}
 
 	head = rht_ptr(rht_dereference_bucket(*pprev, tbl, hash));
 	while (!ht->rhlist && !rht_is_a_nulls(head) && head < obj) {
@@ -581,8 +616,11 @@ static struct bucket_table *rhashtable_insert_one(struct rhashtable *ht,
 		obj = (void *)(2UL | (unsigned long)obj);
 	rcu_assign_pointer(*pprev, obj);
 
-	atomic_inc(&ht->nelems);
-	if (rht_grow_above_75(ht, tbl))
+	if (ht->p.percpu_count)
+		percpu_counter_inc(&ht->pnelems);
+	else
+		atomic_inc(&ht->nelems);
+	if (rht_grow_above_75(ht, tbl, ht->p))
 		schedule_work(&ht->run_work);
 
 	return NULL;
@@ -1069,6 +1107,12 @@ int rhashtable_init(struct rhashtable *ht,
 		return -ENOMEM;
 
 	atomic_set(&ht->nelems, 0);
+	ht->pnelems_error = 0;
+	if (params->percpu_count)
+		if (percpu_counter_init(&ht->pnelems, 0, GFP_KERNEL)) {
+			bucket_table_free(tbl);
+			return -ENOMEM;
+		}
 
 	RCU_INIT_POINTER(ht->tbl, tbl);
 
@@ -1159,6 +1203,8 @@ void rhashtable_free_and_destroy(struct rhashtable *ht,
 	}
 
 	bucket_table_free(tbl);
+	if (ht->p.percpu_count)
+		percpu_counter_destroy(&ht->pnelems);
 	mutex_unlock(&ht->mutex);
 }
 EXPORT_SYMBOL_GPL(rhashtable_free_and_destroy);
diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
index b428a9c7522a..0902db84a37d 100644
--- a/lib/test_rhashtable.c
+++ b/lib/test_rhashtable.c
@@ -57,6 +57,10 @@ static bool enomem_retry = false;
 module_param(enomem_retry, bool, 0);
 MODULE_PARM_DESC(enomem_retry, "Retry insert even if -ENOMEM was returned (default: off)");
 
+static bool percpu_count = false;
+module_param(percpu_count, bool, 0);
+MODULE_PARM_DESC(percpu_count, "Use less-precise percpu counter for counting elements (default: off)");
+
 struct test_obj_val {
 	int	id;
 	int	tid;
@@ -180,6 +184,7 @@ static void test_bucket_stats(struct rhashtable *ht, unsigned int entries)
 	unsigned int err, total = 0, chain_len = 0;
 	struct rhashtable_iter hti;
 	struct rhash_head *pos;
+	unsigned int nelems;
 
 	err = rhashtable_walk_init(ht, &hti, GFP_KERNEL);
 	if (err) {
@@ -206,10 +211,14 @@ static void test_bucket_stats(struct rhashtable *ht, unsigned int entries)
 	rhashtable_walk_stop(&hti);
 	rhashtable_walk_exit(&hti);
 
+	if (ht->p.percpu_count)
+		nelems = percpu_counter_sum(&ht->pnelems);
+	else
+		nelems = atomic_read(&ht->nelems);
 	pr_info("  Traversal complete: counted=%u, nelems=%u, entries=%d, table-jumps=%u\n",
-		total, atomic_read(&ht->nelems), entries, chain_len);
+		total, nelems, entries, chain_len);
 
-	if (total != atomic_read(&ht->nelems) || total != entries)
+	if (total != nelems || total != entries)
 		pr_warn("Test failed: Total count mismatch ^^^");
 }
 
@@ -705,6 +714,7 @@ static int __init test_rht_init(void)
 	test_rht_params.automatic_shrinking = shrinking;
 	test_rht_params.max_size = max_size ? : roundup_pow_of_two(entries);
 	test_rht_params.nelem_hint = size;
+	test_rht_params.percpu_count = percpu_count;
 
 	objs = vzalloc((test_rht_params.max_size + 1) * sizeof(struct test_obj));
 	if (!objs)
