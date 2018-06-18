Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1191AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 02:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB46A208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 02:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB46A208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754644AbeFRC4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 22:56:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:47650 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754516AbeFRC4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 22:56:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 62E1DAEBB;
        Mon, 18 Jun 2018 02:56:36 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
Date:   Mon, 18 Jun 2018 12:52:50 +1000
Subject: [PATCH 3/7] rhashtable: remove nulls_base and related code.
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152929037042.23173.18445603778612102650.stgit@noble>
In-Reply-To: <152929034948.23173.8671757672560065344.stgit@noble>
References: <152929034948.23173.8671757672560065344.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This "feature" is unused, undocumented, and untested and so doesn't
really belong.  A patch is under development to properly implement
support for detecting when a search gets diverted down a different
chain, which the common purpose of nulls markers.

This patch actually fixes a bug too.  The table resizing allows a
table to grow to 2^31 buckets, but the hash is truncated to 27 bits -
any growth beyond 2^27 is wasteful an ineffective.

This patch results in NULLS_MARKER(0) being used for all chains,
and leaves the use of rht_is_a_null() to test for it.

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable-types.h |    2 --
 include/linux/rhashtable.h       |   33 +++------------------------------
 lib/rhashtable.c                 |    8 --------
 lib/test_rhashtable.c            |    5 +----
 net/core/xdp.c                   |    4 ++--
 5 files changed, 6 insertions(+), 46 deletions(-)

diff --git a/include/linux/rhashtable-types.h b/include/linux/rhashtable-types.h
index 9740063ff13b..763d613ce2c2 100644
--- a/include/linux/rhashtable-types.h
+++ b/include/linux/rhashtable-types.h
@@ -50,7 +50,6 @@ typedef int (*rht_obj_cmpfn_t)(struct rhashtable_compare_arg *arg,
  * @min_size: Minimum size while shrinking
  * @locks_mul: Number of bucket locks to allocate per cpu (default: 32)
  * @automatic_shrinking: Enable automatic shrinking of tables
- * @nulls_base: Base value to generate nulls marker
  * @hashfn: Hash function (default: jhash2 if !(key_len % 4), or jhash)
  * @obj_hashfn: Function to hash object
  * @obj_cmpfn: Function to compare key with object
@@ -64,7 +63,6 @@ struct rhashtable_params {
 	u16			min_size;
 	bool			automatic_shrinking;
 	u8			locks_mul;
-	u32			nulls_base;
 	rht_hashfn_t		hashfn;
 	rht_obj_hashfn_t	obj_hashfn;
 	rht_obj_cmpfn_t		obj_cmpfn;
diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 48754ab07cdf..d9f719af7936 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -28,25 +28,8 @@
 #include <linux/rhashtable-types.h>
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
@@ -92,24 +75,14 @@ struct bucket_table {
 	struct rhash_head __rcu *buckets[] ____cacheline_aligned_in_smp;
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
@@ -119,7 +92,7 @@ static inline void *rht_obj(const struct rhashtable *ht,
 static inline unsigned int rht_bucket_index(const struct bucket_table *tbl,
 					    unsigned int hash)
 {
-	return (hash >> RHT_HASH_RESERVED_SPACE) & (tbl->size - 1);
+	return hash & (tbl->size - 1);
 }
 
 static inline unsigned int rht_key_get_hash(struct rhashtable *ht,
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index c9fafea7dc6e..688693c919be 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -995,7 +995,6 @@ static u32 rhashtable_jhash2(const void *key, u32 length, u32 seed)
  *	.key_offset = offsetof(struct test_obj, key),
  *	.key_len = sizeof(int),
  *	.hashfn = jhash,
- *	.nulls_base = (1U << RHT_BASE_SHIFT),
  * };
  *
  * Configuration Example 2: Variable length keys
@@ -1029,9 +1028,6 @@ int rhashtable_init(struct rhashtable *ht,
 	    (params->obj_hashfn && !params->obj_cmpfn))
 		return -EINVAL;
 
-	if (params->nulls_base && params->nulls_base < (1U << RHT_BASE_SHIFT))
-		return -EINVAL;
-
 	memset(ht, 0, sizeof(*ht));
 	mutex_init(&ht->mutex);
 	spin_lock_init(&ht->lock);
@@ -1096,10 +1092,6 @@ int rhltable_init(struct rhltable *hlt, const struct rhashtable_params *params)
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
index 6ca59ffcacbe..82ac39ce5310 100644
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
@@ -296,8 +295,6 @@ static int __init test_rhltable(unsigned int entries)
 	if (!obj_in_table)
 		goto out_free;
 
-	/* nulls_base not supported in rhlist interface */
-	test_rht_params.nulls_base = 0;
 	err = rhltable_init(&rhlt, &test_rht_params);
 	if (WARN_ON(err))
 		goto out_free;
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9d1f22072d5d..31c58719b5a9 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -45,8 +45,8 @@ static u32 xdp_mem_id_hashfn(const void *data, u32 len, u32 seed)
 	BUILD_BUG_ON(FIELD_SIZEOF(struct xdp_mem_allocator, mem.id)
 		     != sizeof(u32));
 
-	/* Use cyclic increasing ID as direct hash key, see rht_bucket_index */
-	return key << RHT_HASH_RESERVED_SPACE;
+	/* Use cyclic increasing ID as direct hash key */
+	return key;
 }
 
 static int xdp_mem_id_cmp(struct rhashtable_compare_arg *arg,


