Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeEDDy4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 23:54:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:44957 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751236AbeEDDyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 23:54:53 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 04 May 2018 13:54:14 +1000
Subject: [PATCH 2/8] rhashtable: remove nulls_base and related code.
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152540605427.18473.12277050439942480863.stgit@noble>
In-Reply-To: <152540595840.18473.11298241115621799037.stgit@noble>
References: <152540595840.18473.11298241115621799037.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This "feature" is unused, undocumented, and untested and so
doesn't really belong.  If a use for the nulls marker
is found, all this code would need to be reviewed to
ensure it works as required.  It would be just as easy to
just add the code if/when it is needed instead.

This patch actually fixes a bug too.  The table resizing allows a
table to grow to 2^31 buckets, but the hash is truncated to 27 bits -
any growth beyond 2^27 is wasteful an ineffective.

This patch result in NULLS_MARKER(0) being used for all chains,
and leave the use of rht_is_a_null() to test for it.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |   35 +++--------------------------------
 lib/rhashtable.c           |    8 --------
 lib/test_rhashtable.c      |    5 +----
 3 files changed, 4 insertions(+), 44 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 4e1f535c2034..8822924dd05a 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -29,25 +29,8 @@
 
 /*
  * The end of the chain is marked with a special nulls marks which has
- * the following format:
- *
- * +-------+-----------------------------------------------------+-+
- * | Base  |                      Hash                           |1|
- * +-------+-----------------------------------------------------+-+
- *
- * Base (4 bits) : Reserved to distinguish between multiple tables.
- *                 Specified via &struct rhashtable_params.nulls_base.
- * Hash (27 bits): Full hash (unmasked) of first element added to bucket
- * 1 (1 bit)     : Nulls marker (always set)
- *
- * The remaining bits of the next pointer remain unused for now.
+ * the least significant bit set.
  */
-#define RHT_BASE_BITS		4
-#define RHT_HASH_BITS		27
-#define RHT_BASE_SHIFT		RHT_HASH_BITS
-
-/* Base bits plus 1 bit for nulls marker */
-#define RHT_HASH_RESERVED_SPACE	(RHT_BASE_BITS + 1)
 
 /* Maximum chain length before rehash
  *
@@ -129,7 +112,6 @@ struct rhashtable;
  * @min_size: Minimum size while shrinking
  * @locks_mul: Number of bucket locks to allocate per cpu (default: 32)
  * @automatic_shrinking: Enable automatic shrinking of tables
- * @nulls_base: Base value to generate nulls marker
  * @hashfn: Hash function (default: jhash2 if !(key_len % 4), or jhash)
  * @obj_hashfn: Function to hash object
  * @obj_cmpfn: Function to compare key with object
@@ -143,7 +125,6 @@ struct rhashtable_params {
 	u16			min_size;
 	bool			automatic_shrinking;
 	u8			locks_mul;
-	u32			nulls_base;
 	rht_hashfn_t		hashfn;
 	rht_obj_hashfn_t	obj_hashfn;
 	rht_obj_cmpfn_t		obj_cmpfn;
@@ -210,24 +191,14 @@ struct rhashtable_iter {
 	bool end_of_table;
 };
 
-static inline unsigned long rht_marker(const struct rhashtable *ht, u32 hash)
-{
-	return NULLS_MARKER(ht->p.nulls_base + hash);
-}
-
 #define INIT_RHT_NULLS_HEAD(ptr, ht, hash) \
-	((ptr) = (typeof(ptr)) rht_marker(ht, hash))
+	((ptr) = (typeof(ptr)) NULLS_MARKER(0))
 
 static inline bool rht_is_a_nulls(const struct rhash_head *ptr)
 {
 	return ((unsigned long) ptr & 1);
 }
 
-static inline unsigned long rht_get_nulls_value(const struct rhash_head *ptr)
-{
-	return ((unsigned long) ptr) >> 1;
-}
-
 static inline void *rht_obj(const struct rhashtable *ht,
 			    const struct rhash_head *he)
 {
@@ -237,7 +208,7 @@ static inline void *rht_obj(const struct rhashtable *ht,
 static inline unsigned int rht_bucket_index(const struct bucket_table *tbl,
 					    unsigned int hash)
 {
-	return (hash >> RHT_HASH_RESERVED_SPACE) & (tbl->size - 1);
+	return hash & (tbl->size - 1);
 }
 
 static inline unsigned int rht_key_get_hash(struct rhashtable *ht,
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 9427b5766134..4a3f94e8e8a6 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -994,7 +994,6 @@ static u32 rhashtable_jhash2(const void *key, u32 length, u32 seed)
  *	.key_offset = offsetof(struct test_obj, key),
  *	.key_len = sizeof(int),
  *	.hashfn = jhash,
- *	.nulls_base = (1U << RHT_BASE_SHIFT),
  * };
  *
  * Configuration Example 2: Variable length keys
@@ -1028,9 +1027,6 @@ int rhashtable_init(struct rhashtable *ht,
 	    (params->obj_hashfn && !params->obj_cmpfn))
 		return -EINVAL;
 
-	if (params->nulls_base && params->nulls_base < (1U << RHT_BASE_SHIFT))
-		return -EINVAL;
-
 	memset(ht, 0, sizeof(*ht));
 	mutex_init(&ht->mutex);
 	spin_lock_init(&ht->lock);
@@ -1095,10 +1091,6 @@ int rhltable_init(struct rhltable *hlt, const struct rhashtable_params *params)
 {
 	int err;
 
-	/* No rhlist NULLs marking for now. */
-	if (params->nulls_base)
-		return -EINVAL;
-
 	err = rhashtable_init(&hlt->ht, params);
 	hlt->ht.rhlist = true;
 	return err;
diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
index bf92b7aa2a49..b428a9c7522a 100644
--- a/lib/test_rhashtable.c
+++ b/lib/test_rhashtable.c
@@ -83,7 +83,7 @@ static u32 my_hashfn(const void *data, u32 len, u32 seed)
 {
 	const struct test_obj_rhl *obj = data;
 
-	return (obj->value.id % 10) << RHT_HASH_RESERVED_SPACE;
+	return (obj->value.id % 10);
 }
 
 static int my_cmpfn(struct rhashtable_compare_arg *arg, const void *obj)
@@ -99,7 +99,6 @@ static struct rhashtable_params test_rht_params = {
 	.key_offset = offsetof(struct test_obj, value),
 	.key_len = sizeof(struct test_obj_val),
 	.hashfn = jhash,
-	.nulls_base = (3U << RHT_BASE_SHIFT),
 };
 
 static struct rhashtable_params test_rht_params_dup = {
@@ -294,8 +293,6 @@ static int __init test_rhltable(unsigned int entries)
 	if (!obj_in_table)
 		goto out_free;
 
-	/* nulls_base not supported in rhlist interface */
-	test_rht_params.nulls_base = 0;
 	err = rhltable_init(&rhlt, &test_rht_params);
 	if (WARN_ON(err))
 		goto out_free;
