Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8DAC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE60221908
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549539771;
	bh=y3xO+55gmNe1NrAVJwR1K04JdKUiOqRM7gd7WXTxsao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TTtHhMdzE2Tf6Fe3VYU1cmyYwn5pnaiVUqhUii6jSiEEB/PTl9wgwZUtVEWYnGy93
	 hf3RugLSBkd3Elb4umyfQP89z46iNVC4V0vhktLUL1+7wPwyOZXBpaAiwNU/YmGbAG
	 K0icymG/ZJ7/xwXCPEMDGnqWviII088W5WluJazs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfBGLmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:42:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:32842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbfBGLmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:42:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3E1521904;
        Thu,  7 Feb 2019 11:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549539766;
        bh=y3xO+55gmNe1NrAVJwR1K04JdKUiOqRM7gd7WXTxsao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WcCl4UupAceCIhxRW4w73T5kGFwPup+84KFU04VbdFZisuv7lwWCBkdKaRH5vIOW4
         qdT3m/uQtWtkcBQiFwxRPQc25H8JRUj46HhvJwOK5+0/TKdVIuVpAS+Jitnisobpv8
         7x+q3VZT2BhyAVhKQH+EhLM5FRSwqqnr68U8deyk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 07/34] rhashtable: Add rhashtable_lookup()
Date:   Thu,  7 Feb 2019 12:41:49 +0100
Message-Id: <20190207113025.851245215@linuxfoundation.org>
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

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

Extracted from commit ca26893f05e8 "rhashtable: Add rhlist interface".

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/rhashtable.h |   69 +++++++++++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 17 deletions(-)

--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -515,18 +515,8 @@ static inline int rhashtable_compare(str
 	return memcmp(ptr + ht->p.key_offset, arg->key, ht->p.key_len);
 }
 
-/**
- * rhashtable_lookup_fast - search hash table, inlined version
- * @ht:		hash table
- * @key:	the pointer to the key
- * @params:	hash table parameters
- *
- * Computes the hash value for the key and traverses the bucket chain looking
- * for a entry with an identical key. The first matching entry is returned.
- *
- * Returns the first entry on which the compare function returned true.
- */
-static inline void *rhashtable_lookup_fast(
+/* Internal function, do not use. */
+static inline struct rhash_head *__rhashtable_lookup(
 	struct rhashtable *ht, const void *key,
 	const struct rhashtable_params params)
 {
@@ -538,8 +528,6 @@ static inline void *rhashtable_lookup_fa
 	struct rhash_head *he;
 	unsigned int hash;
 
-	rcu_read_lock();
-
 	tbl = rht_dereference_rcu(ht->tbl, ht);
 restart:
 	hash = rht_key_hashfn(ht, tbl, key, params);
@@ -548,8 +536,7 @@ restart:
 		    params.obj_cmpfn(&arg, rht_obj(ht, he)) :
 		    rhashtable_compare(&arg, rht_obj(ht, he)))
 			continue;
-		rcu_read_unlock();
-		return rht_obj(ht, he);
+		return he;
 	}
 
 	/* Ensure we see any new tables. */
@@ -558,11 +545,59 @@ restart:
 	tbl = rht_dereference_rcu(tbl->future_tbl, ht);
 	if (unlikely(tbl))
 		goto restart;
-	rcu_read_unlock();
 
 	return NULL;
 }
 
+/**
+ * rhashtable_lookup - search hash table
+ * @ht:		hash table
+ * @key:	the pointer to the key
+ * @params:	hash table parameters
+ *
+ * Computes the hash value for the key and traverses the bucket chain looking
+ * for a entry with an identical key. The first matching entry is returned.
+ *
+ * This must only be called under the RCU read lock.
+ *
+ * Returns the first entry on which the compare function returned true.
+ */
+static inline void *rhashtable_lookup(
+	struct rhashtable *ht, const void *key,
+	const struct rhashtable_params params)
+{
+	struct rhash_head *he = __rhashtable_lookup(ht, key, params);
+
+	return he ? rht_obj(ht, he) : NULL;
+}
+
+/**
+ * rhashtable_lookup_fast - search hash table, without RCU read lock
+ * @ht:		hash table
+ * @key:	the pointer to the key
+ * @params:	hash table parameters
+ *
+ * Computes the hash value for the key and traverses the bucket chain looking
+ * for a entry with an identical key. The first matching entry is returned.
+ *
+ * Only use this function when you have other mechanisms guaranteeing
+ * that the object won't go away after the RCU read lock is released.
+ *
+ * Returns the first entry on which the compare function returned true.
+ */
+static inline void *rhashtable_lookup_fast(
+	struct rhashtable *ht, const void *key,
+	const struct rhashtable_params params)
+{
+	void *obj;
+
+	rcu_read_lock();
+	obj = rhashtable_lookup(ht, key, params);
+	rcu_read_unlock();
+
+	return obj;
+}
+
 /* Internal function, please use rhashtable_insert_fast() instead. This
  * function returns the existing element already in hashes in there is a clash,
  * otherwise it returns an error via ERR_PTR().


