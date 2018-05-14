Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754556AbeENP3p (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 11:29:45 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:41162 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752118AbeENP3n (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 14 May 2018 11:29:43 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: akpm@linux-foundation.org, tgraf@suug.ch, herbert@gondor.apana.org.au
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] lib/rhashtable: reorder some inititalization sequences
Date: Mon, 14 May 2018 08:13:32 -0700
Message-Id: <20180514151332.31352-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rhashtable_init() allocates memory at the very end of the
call, once everything is setup; with the exception of the
nelems parameter. However, unless the user is doing something
bogus with params for which -EINVAL is returned, memory
allocation is the only operation that can trigger the call
to fail.

Thus move bucket_table_alloc() up such that we fail back to
the caller asap, instead of doing useless checks. This is
safe as the the table allocation isn't using the halfly
setup 'ht' structure and bucket_table_alloc() call chain only
ends up using the ht->nulls_base member in INIT_RHT_NULLS_HEAD.

Also move the locking initialization down to the end.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 lib/rhashtable.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 9427b5766134..68aadd6bff60 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -1022,8 +1022,6 @@ int rhashtable_init(struct rhashtable *ht,
 	struct bucket_table *tbl;
 	size_t size;
 
-	size = HASH_DEFAULT_SIZE;
-
 	if ((!params->key_len && !params->obj_hashfn) ||
 	    (params->obj_hashfn && !params->obj_cmpfn))
 		return -EINVAL;
@@ -1032,10 +1030,17 @@ int rhashtable_init(struct rhashtable *ht,
 		return -EINVAL;
 
 	memset(ht, 0, sizeof(*ht));
-	mutex_init(&ht->mutex);
-	spin_lock_init(&ht->lock);
 	memcpy(&ht->p, params, sizeof(*params));
 
+	if (!params->nelem_hint)
+		size = HASH_DEFAULT_SIZE;
+	else
+		size = rounded_hashtable_size(&ht->p);
+
+	tbl = bucket_table_alloc(ht, size, GFP_KERNEL);
+	if (tbl == NULL)
+		return -ENOMEM;
+
 	if (params->min_size)
 		ht->p.min_size = roundup_pow_of_two(params->min_size);
 
@@ -1050,9 +1055,6 @@ int rhashtable_init(struct rhashtable *ht,
 
 	ht->p.min_size = max_t(u16, ht->p.min_size, HASH_MIN_SIZE);
 
-	if (params->nelem_hint)
-		size = rounded_hashtable_size(&ht->p);
-
 	if (params->locks_mul)
 		ht->p.locks_mul = roundup_pow_of_two(params->locks_mul);
 	else
@@ -1068,10 +1070,8 @@ int rhashtable_init(struct rhashtable *ht,
 		}
 	}
 
-	tbl = bucket_table_alloc(ht, size, GFP_KERNEL);
-	if (tbl == NULL)
-		return -ENOMEM;
-
+	mutex_init(&ht->mutex);
+	spin_lock_init(&ht->lock);
 	atomic_set(&ht->nelems, 0);
 
 	RCU_INIT_POINTER(ht->tbl, tbl);
-- 
2.13.6
