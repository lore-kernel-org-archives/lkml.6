Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D385AC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9859021908
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549539768;
	bh=w/cXdpzGCMmErMgJ2gG7PL8FZdlymIFomPxAh7pxCdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hSXHK8l/zb+1zB2GFF+cbzTkg3BIlfpXIH+1QkFHgczDCsP8etAHtRqWLKPKI+dhO
	 wMV8sRJNYTObpGE0wAJ26Qep8sHy+E5vCSbiPiSrY4IbCiwjUOPRJ/RABpiffwhpMp
	 iJCwbqpx9Ar5V0uPYaEaEupPETsKrQAWpz3dG2kQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfBGLmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:42:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:32790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727134AbfBGLmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:42:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE8ED21907;
        Thu,  7 Feb 2019 11:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549539763;
        bh=w/cXdpzGCMmErMgJ2gG7PL8FZdlymIFomPxAh7pxCdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hy8c450DuW8ymTmv4Bz3lK6Rr4N/Jnwrlgic/fzVnYKJA9lNIJeYdyvow66RGlovt
         EvTUQMeB883p0TXnQe9pN6iksvQNIjiTqY6I4OH0BNbnsBndieq6LfLQO+Y6ujdywi
         KOd+OyyZbwkyMp+6a5dz+IwAIVOI9swzY2jwLZAs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Graf <tgraf@suug.ch>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 06/34] rhashtable: add rhashtable_lookup_get_insert_key()
Date:   Thu,  7 Feb 2019 12:41:48 +0100
Message-Id: <20190207113025.814134273@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207113025.552605181@linuxfoundation.org>
References: <20190207113025.552605181@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 5ca8cc5bf11faed257c762018aea9106d529232f upstream.

This patch modifies __rhashtable_insert_fast() so it returns the
existing object that clashes with the one that you want to insert.
In case the object is successfully inserted, NULL is returned.
Otherwise, you get an error via ERR_PTR().

This patch adapts the existing callers of __rhashtable_insert_fast()
so they handle this new logic, and it adds a new
rhashtable_lookup_get_insert_key() interface to fetch this existing
object.

nf_tables needs this change to improve handling of EEXIST cases via
honoring the NLM_F_EXCL flag and by checking if the data part of the
mapping matches what we have.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Thomas Graf <tgraf@suug.ch>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/rhashtable.h |   70 ++++++++++++++++++++++++++++++++++++---------
 lib/rhashtable.c           |   10 ++++--
 2 files changed, 64 insertions(+), 16 deletions(-)

--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -343,7 +343,8 @@ int rhashtable_init(struct rhashtable *h
 struct bucket_table *rhashtable_insert_slow(struct rhashtable *ht,
 					    const void *key,
 					    struct rhash_head *obj,
-					    struct bucket_table *old_tbl);
+					    struct bucket_table *old_tbl,
+					    void **data);
 int rhashtable_insert_rehash(struct rhashtable *ht, struct bucket_table *tbl);
 
 int rhashtable_walk_init(struct rhashtable *ht, struct rhashtable_iter *iter);
@@ -562,8 +563,11 @@ restart:
 	return NULL;
 }
 
-/* Internal function, please use rhashtable_insert_fast() instead */
-static inline int __rhashtable_insert_fast(
+/* Internal function, please use rhashtable_insert_fast() instead. This
+ * function returns the existing element already in hashes in there is a clash,
+ * otherwise it returns an error via ERR_PTR().
+ */
+static inline void *__rhashtable_insert_fast(
 	struct rhashtable *ht, const void *key, struct rhash_head *obj,
 	const struct rhashtable_params params)
 {
@@ -576,6 +580,7 @@ static inline int __rhashtable_insert_fa
 	spinlock_t *lock;
 	unsigned int elasticity;
 	unsigned int hash;
+	void *data = NULL;
 	int err;
 
 restart:
@@ -600,11 +605,14 @@ restart:
 
 	new_tbl = rht_dereference_rcu(tbl->future_tbl, ht);
 	if (unlikely(new_tbl)) {
-		tbl = rhashtable_insert_slow(ht, key, obj, new_tbl);
+		tbl = rhashtable_insert_slow(ht, key, obj, new_tbl, &data);
 		if (!IS_ERR_OR_NULL(tbl))
 			goto slow_path;
 
 		err = PTR_ERR(tbl);
+		if (err == -EEXIST)
+			err = 0;
+
 		goto out;
 	}
 
@@ -618,25 +626,25 @@ slow_path:
 		err = rhashtable_insert_rehash(ht, tbl);
 		rcu_read_unlock();
 		if (err)
-			return err;
+			return ERR_PTR(err);
 
 		goto restart;
 	}
 
-	err = -EEXIST;
+	err = 0;
 	elasticity = ht->elasticity;
 	rht_for_each(head, tbl, hash) {
 		if (key &&
 		    unlikely(!(params.obj_cmpfn ?
 			       params.obj_cmpfn(&arg, rht_obj(ht, head)) :
-			       rhashtable_compare(&arg, rht_obj(ht, head)))))
+			       rhashtable_compare(&arg, rht_obj(ht, head))))) {
+			data = rht_obj(ht, head);
 			goto out;
+		}
 		if (!--elasticity)
 			goto slow_path;
 	}
 
-	err = 0;
-
 	head = rht_dereference_bucket(tbl->buckets[hash], tbl, hash);
 
 	RCU_INIT_POINTER(obj->next, head);
@@ -651,7 +659,7 @@ out:
 	spin_unlock_bh(lock);
 	rcu_read_unlock();
 
-	return err;
+	return err ? ERR_PTR(err) : data;
 }
 
 /**
@@ -674,7 +682,13 @@ static inline int rhashtable_insert_fast
 	struct rhashtable *ht, struct rhash_head *obj,
 	const struct rhashtable_params params)
 {
-	return __rhashtable_insert_fast(ht, NULL, obj, params);
+	void *ret;
+
+	ret = __rhashtable_insert_fast(ht, NULL, obj, params);
+	if (IS_ERR(ret))
+		return PTR_ERR(ret);
+
+	return ret == NULL ? 0 : -EEXIST;
 }
 
 /**
@@ -703,11 +717,15 @@ static inline int rhashtable_lookup_inse
 	const struct rhashtable_params params)
 {
 	const char *key = rht_obj(ht, obj);
+	void *ret;
 
 	BUG_ON(ht->p.obj_hashfn);
 
-	return __rhashtable_insert_fast(ht, key + ht->p.key_offset, obj,
-					params);
+	ret = __rhashtable_insert_fast(ht, key + ht->p.key_offset, obj, params);
+	if (IS_ERR(ret))
+		return PTR_ERR(ret);
+
+	return ret == NULL ? 0 : -EEXIST;
 }
 
 /**
@@ -736,6 +754,32 @@ static inline int rhashtable_lookup_inse
 	struct rhashtable *ht, const void *key, struct rhash_head *obj,
 	const struct rhashtable_params params)
 {
+	void *ret;
+
+	BUG_ON(!ht->p.obj_hashfn || !key);
+
+	ret = __rhashtable_insert_fast(ht, key, obj, params);
+	if (IS_ERR(ret))
+		return PTR_ERR(ret);
+
+	return ret == NULL ? 0 : -EEXIST;
+}
+
+/**
+ * rhashtable_lookup_get_insert_key - lookup and insert object into hash table
+ * @ht:		hash table
+ * @obj:	pointer to hash head inside object
+ * @params:	hash table parameters
+ * @data:	pointer to element data already in hashes
+ *
+ * Just like rhashtable_lookup_insert_key(), but this function returns the
+ * object if it exists, NULL if it does not and the insertion was successful,
+ * and an ERR_PTR otherwise.
+ */
+static inline void *rhashtable_lookup_get_insert_key(
+	struct rhashtable *ht, const void *key, struct rhash_head *obj,
+	const struct rhashtable_params params)
+{
 	BUG_ON(!ht->p.obj_hashfn || !key);
 
 	return __rhashtable_insert_fast(ht, key, obj, params);
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -441,7 +441,8 @@ EXPORT_SYMBOL_GPL(rhashtable_insert_reha
 struct bucket_table *rhashtable_insert_slow(struct rhashtable *ht,
 					    const void *key,
 					    struct rhash_head *obj,
-					    struct bucket_table *tbl)
+					    struct bucket_table *tbl,
+					    void **data)
 {
 	struct rhash_head *head;
 	unsigned int hash;
@@ -452,8 +453,11 @@ struct bucket_table *rhashtable_insert_s
 	spin_lock_nested(rht_bucket_lock(tbl, hash), SINGLE_DEPTH_NESTING);
 
 	err = -EEXIST;
-	if (key && rhashtable_lookup_fast(ht, key, ht->p))
-		goto exit;
+	if (key) {
+		*data = rhashtable_lookup_fast(ht, key, ht->p);
+		if (*data)
+			goto exit;
+	}
 
 	err = -E2BIG;
 	if (unlikely(rht_grow_above_max(ht, tbl)))


