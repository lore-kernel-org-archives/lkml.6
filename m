Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbeFAEqA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 00:46:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:34073 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751441AbeFAEpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 00:45:55 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 01 Jun 2018 14:44:09 +1000
Subject: [PATCH 08/18] rhashtable: clean up dereference of ->future_tbl.
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152782824957.30340.14092720576731091742.stgit@noble>
In-Reply-To: <152782754287.30340.4395718227884933670.stgit@noble>
References: <152782754287.30340.4395718227884933670.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using rht_dereference_bucket() to dereference
->future_tbl looks like a type error, and could be confusing.
Using rht_dereference_rcu() to test a pointer for NULL
adds an unnecessary barrier - rcu_access_pointer() is preferred
for NULL tests when no lock is held.

This uses 3 different ways to access ->future_tbl.
- if we know the mutex is held, use rht_dereference()
- if we don't hold the mutex, and are only testing for NULL,
  use rcu_access_pointer()
- otherwise (using RCU protection for true dereference),
  use rht_dereference_rcu().

Note that this includes a simplification of the call to
rhashtable_last_table() - we don't do an extra dereference
before the call any more.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |    2 +-
 lib/rhashtable.c           |    9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 49f80506d02e..10435a77b156 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -605,7 +605,7 @@ static inline void *__rhashtable_insert_fast(
 	lock = rht_bucket_lock(tbl, hash);
 	spin_lock_bh(lock);
 
-	if (unlikely(rht_dereference_bucket(tbl->future_tbl, tbl, hash))) {
+	if (unlikely(rcu_access_pointer(tbl->future_tbl))) {
 slow_path:
 		spin_unlock_bh(lock);
 		rcu_read_unlock();
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index b5d17bce19ff..1737fbd049da 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -226,8 +226,7 @@ static struct bucket_table *rhashtable_last_table(struct rhashtable *ht,
 static int rhashtable_rehash_one(struct rhashtable *ht, unsigned int old_hash)
 {
 	struct bucket_table *old_tbl = rht_dereference(ht->tbl, ht);
-	struct bucket_table *new_tbl = rhashtable_last_table(ht,
-		rht_dereference_rcu(old_tbl->future_tbl, ht));
+	struct bucket_table *new_tbl = rhashtable_last_table(ht, old_tbl);
 	struct rhash_head __rcu **pprev = rht_bucket_var(old_tbl, old_hash);
 	int err = -EAGAIN;
 	struct rhash_head *head, *next, *entry;
@@ -467,7 +466,7 @@ static int rhashtable_insert_rehash(struct rhashtable *ht,
 
 fail:
 	/* Do not fail the insert if someone else did a rehash. */
-	if (likely(rcu_dereference_raw(tbl->future_tbl)))
+	if (likely(rcu_access_pointer(tbl->future_tbl)))
 		return 0;
 
 	/* Schedule async rehash to retry allocation in process context. */
@@ -540,7 +539,7 @@ static struct bucket_table *rhashtable_insert_one(struct rhashtable *ht,
 	if (PTR_ERR(data) != -EAGAIN && PTR_ERR(data) != -ENOENT)
 		return ERR_CAST(data);
 
-	new_tbl = rcu_dereference(tbl->future_tbl);
+	new_tbl = rht_dereference_rcu(tbl->future_tbl, ht);
 	if (new_tbl)
 		return new_tbl;
 
@@ -599,7 +598,7 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
 			break;
 
 		spin_unlock_bh(lock);
-		tbl = rcu_dereference(tbl->future_tbl);
+		tbl = rht_dereference_rcu(tbl->future_tbl, ht);
 	}
 
 	data = rhashtable_lookup_one(ht, tbl, hash, key, obj);
