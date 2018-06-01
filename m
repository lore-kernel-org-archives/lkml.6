Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbeFAErc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 00:47:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:34217 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750961AbeFAEqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 00:46:54 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 01 Jun 2018 14:44:09 +1000
Subject: [PATCH 17/18] rhashtable: rename rht_for_each*continue as *from.
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152782824992.30340.13679240743690463593.stgit@noble>
In-Reply-To: <152782754287.30340.4395718227884933670.stgit@noble>
References: <152782754287.30340.4395718227884933670.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pattern set by list.h is that for_each..continue()
iterators start at the next entry after the given one,
while for_each..next() iterators start at the given
entry.

The rht_for_each*continue() iterates are documented as though the
start at the 'next' entry, but actually start at the given entry,
and they are used expecting that behaviour.
So fix the documentation and change the names to *from for consistency
with list.h

Signed-off-by: NeilBrown <neilb@suse.com>
---
 .clang-format              |    8 ++++----
 include/linux/rhashtable.h |   38 +++++++++++++++++++-------------------
 lib/rhashtable.c           |    4 ++--
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/.clang-format b/.clang-format
index faffc0d5af4e..53a5188df01a 100644
--- a/.clang-format
+++ b/.clang-format
@@ -332,14 +332,14 @@ ForEachMacros:
   - 'rhl_for_each_entry_rcu'
   - 'rhl_for_each_rcu'
   - 'rht_for_each'
-  - 'rht_for_each_continue'
+  - 'rht_for_each_from'
   - 'rht_for_each_entry'
-  - 'rht_for_each_entry_continue'
+  - 'rht_for_each_entry_from'
   - 'rht_for_each_entry_rcu'
-  - 'rht_for_each_entry_rcu_continue'
+  - 'rht_for_each_entry_rcu_from'
   - 'rht_for_each_entry_safe'
   - 'rht_for_each_rcu'
-  - 'rht_for_each_rcu_continue'
+  - 'rht_for_each_rcu_from'
   - '__rq_for_each_bio'
   - 'rq_for_each_segment'
   - 'scsi_for_each_prot_sg'
diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index f58cb62dce05..e148f72d4a89 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -418,13 +418,13 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
 }
 
 /**
- * rht_for_each_continue - continue iterating over hash chain
+ * rht_for_each_from - iterate over hash chain from given head
  * @pos:	the &struct rhash_head to use as a loop cursor.
- * @head:	the previous &struct rhash_head to continue from
+ * @head:	the &struct rhash_head to start from
  * @tbl:	the &struct bucket_table
  * @hash:	the hash value / bucket index
  */
-#define rht_for_each_continue(pos, head, tbl, hash) \
+#define rht_for_each_from(pos, head, tbl, hash) \
 	for (pos = rht_dereference_bucket(head, tbl, hash); \
 	     !rht_is_a_nulls(pos); \
 	     pos = rht_dereference_bucket((pos)->next, tbl, hash))
@@ -436,18 +436,18 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
  * @hash:	the hash value / bucket index
  */
 #define rht_for_each(pos, tbl, hash) \
-	rht_for_each_continue(pos, rht_ptr(*rht_bucket(tbl, hash)), tbl, hash)
+	rht_for_each_from(pos, rht_ptr(*rht_bucket(tbl, hash)), tbl, hash)
 
 /**
- * rht_for_each_entry_continue - continue iterating over hash chain
+ * rht_for_each_entry_from - iterate over hash chain from given head
  * @tpos:	the type * to use as a loop cursor.
  * @pos:	the &struct rhash_head to use as a loop cursor.
- * @head:	the previous &struct rhash_head to continue from
+ * @head:	the &struct rhash_head to start from
  * @tbl:	the &struct bucket_table
  * @hash:	the hash value / bucket index
  * @member:	name of the &struct rhash_head within the hashable struct.
  */
-#define rht_for_each_entry_continue(tpos, pos, head, tbl, hash, member)	\
+#define rht_for_each_entry_from(tpos, pos, head, tbl, hash, member)	\
 	for (pos = rht_dereference_bucket(head, tbl, hash);		\
 	     (!rht_is_a_nulls(pos)) && rht_entry(tpos, pos, member);	\
 	     pos = rht_dereference_bucket((pos)->next, tbl, hash))
@@ -461,7 +461,7 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
  * @member:	name of the &struct rhash_head within the hashable struct.
  */
 #define rht_for_each_entry(tpos, pos, tbl, hash, member)		\
-	rht_for_each_entry_continue(tpos, pos, rht_ptr(*rht_bucket(tbl, hash)), \
+	rht_for_each_entry_from(tpos, pos, rht_ptr(*rht_bucket(tbl, hash)), \
 				    tbl, hash, member)
 
 /**
@@ -487,9 +487,9 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
 		       rht_dereference_bucket(pos->next, tbl, hash) : NULL)
 
 /**
- * rht_for_each_rcu_continue - continue iterating over rcu hash chain
+ * rht_for_each_rcu_from - iterate over rcu hash chain from given head
  * @pos:	the &struct rhash_head to use as a loop cursor.
- * @head:	the previous &struct rhash_head to continue from
+ * @head:	the &struct rhash_head to start from
  * @tbl:	the &struct bucket_table
  * @hash:	the hash value / bucket index
  *
@@ -497,7 +497,7 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
  * the _rcu mutation primitives such as rhashtable_insert() as long as the
  * traversal is guarded by rcu_read_lock().
  */
-#define rht_for_each_rcu_continue(pos, head, tbl, hash)			\
+#define rht_for_each_rcu_from(pos, head, tbl, hash)			\
 	for (({barrier(); }),						\
 		pos = rht_ptr(rht_dereference_bucket_rcu(head, tbl, hash)); \
 	     !rht_is_a_nulls(pos);					\
@@ -521,10 +521,10 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
 	     pos = rcu_dereference_raw(pos->next))
 
 /**
- * rht_for_each_entry_rcu_continue - continue iterating over rcu hash chain
+ * rht_for_each_entry_rcu_from - iterated over rcu hash chain from given head
  * @tpos:	the type * to use as a loop cursor.
  * @pos:	the &struct rhash_head to use as a loop cursor.
- * @head:	the previous &struct rhash_head to continue from
+ * @head:	the &struct rhash_head to start from
  * @tbl:	the &struct bucket_table
  * @hash:	the hash value / bucket index
  * @member:	name of the &struct rhash_head within the hashable struct.
@@ -533,7 +533,7 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
  * the _rcu mutation primitives such as rhashtable_insert() as long as the
  * traversal is guarded by rcu_read_lock().
  */
-#define rht_for_each_entry_rcu_continue(tpos, pos, head, tbl, hash, member) \
+#define rht_for_each_entry_rcu_from(tpos, pos, head, tbl, hash, member) \
 	for (({barrier(); }),						    \
 	     pos = rht_dereference_bucket_rcu(head, tbl, hash);		    \
 	     (!rht_is_a_nulls(pos)) && rht_entry(tpos, pos, member);	    \
@@ -552,7 +552,7 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
  * traversal is guarded by rcu_read_lock().
  */
 #define rht_for_each_entry_rcu(tpos, pos, tbl, hash, member)		   \
-	rht_for_each_entry_rcu_continue(tpos, pos,			   \
+	rht_for_each_entry_rcu_from(tpos, pos,			   \
 					rht_ptr(*rht_bucket(tbl, hash)),   \
 					tbl, hash, member)
 
@@ -609,7 +609,7 @@ static inline struct rhash_head *__rhashtable_lookup(
 	hash = rht_key_hashfn(ht, tbl, key, params);
 	head = rht_bucket(tbl, hash);
 	do {
-		rht_for_each_rcu_continue(he, *head, tbl, hash) {
+		rht_for_each_rcu_from(he, *head, tbl, hash) {
 			if (params.obj_cmpfn ?
 			    params.obj_cmpfn(&arg, rht_obj(ht, he)) :
 			    rhashtable_compare(&arg, rht_obj(ht, he)))
@@ -744,7 +744,7 @@ static inline void *__rhashtable_insert_fast(
 	}
 
 
-	rht_for_each_continue(head, rht_ptr(*headp), tbl, hash) {
+	rht_for_each_from(head, rht_ptr(*headp), tbl, hash) {
 		struct rhlist_head *plist;
 		struct rhlist_head *list;
 
@@ -1027,7 +1027,7 @@ static inline int __rhashtable_remove_fast_one(
 	lock = pprev;
 	rht_lock(lock);
 
-	rht_for_each_continue(he, rht_ptr(*pprev), tbl, hash) {
+	rht_for_each_from(he, rht_ptr(*pprev), tbl, hash) {
 		struct rhlist_head *list;
 
 		list = container_of(he, struct rhlist_head, rhead);
@@ -1189,7 +1189,7 @@ static inline int __rhashtable_replace_fast(
 	lock = pprev;
 	rht_lock(lock);
 
-	rht_for_each_continue(he, rht_ptr(*pprev), tbl, hash) {
+	rht_for_each_from(he, rht_ptr(*pprev), tbl, hash) {
 		if (he != obj_old) {
 			pprev = &he->next;
 			continue;
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 1b9820787cd5..84288142ddf6 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -232,7 +232,7 @@ static int rhashtable_rehash_one(struct rhashtable *ht,
 
 	err = -ENOENT;
 
-	rht_for_each_continue(entry, rht_ptr(*pprev), old_tbl, old_hash) {
+	rht_for_each_from(entry, rht_ptr(*pprev), old_tbl, old_hash) {
 		err = 0;
 		next = rht_dereference_bucket(entry->next, old_tbl, old_hash);
 
@@ -527,7 +527,7 @@ static void *rhashtable_lookup_one(struct rhashtable *ht,
 	int elasticity;
 
 	elasticity = RHT_ELASTICITY;
-	rht_for_each_continue(head, rht_ptr(*pprev), tbl, hash) {
+	rht_for_each_from(head, rht_ptr(*pprev), tbl, hash) {
 		struct rhlist_head *list;
 		struct rhlist_head *plist;
 
