Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750830AbeFAEqY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 00:46:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:34134 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751678AbeFAEqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 00:46:20 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 01 Jun 2018 14:44:09 +1000
Subject: [PATCH 12/18] rhashtable: add rhashtable_walk_prev()
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152782824973.30340.11914706498791212568.stgit@noble>
In-Reply-To: <152782754287.30340.4395718227884933670.stgit@noble>
References: <152782754287.30340.4395718227884933670.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rhashtable_walk_prev() returns the object returned by
the previous rhashtable_walk_next(), providing it is still in the
table (or was during this grace period).
This works even if rhashtable_walk_stop() and rhashtable_talk_start()
have been called since the last rhashtable_walk_next().

If there have been no calls to rhashtable_walk_next(), or if the
object is gone from the table, then NULL is returned.

This can usefully be used in a seq_file ->start() function.
If the pos is the same as was returned by the last ->next() call,
then rhashtable_walk_prev() can be used to re-establish the
current location in the table.  If it returns NULL, then
rhashtable_walk_next() should be used.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |    1 +
 lib/rhashtable.c           |   31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index c612d2446d90..1b70d690ab65 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -247,6 +247,7 @@ static inline void rhashtable_walk_start(struct rhashtable_iter *iter)
 }
 
 void *rhashtable_walk_next(struct rhashtable_iter *iter);
+void *rhashtable_walk_prev(struct rhashtable_iter *iter);
 void rhashtable_walk_stop(struct rhashtable_iter *iter) __releases(RCU);
 
 void rhashtable_free_and_destroy(struct rhashtable *ht,
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 5ab0f4825271..a185f5a8b34d 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -915,6 +915,37 @@ void *rhashtable_walk_next(struct rhashtable_iter *iter)
 }
 EXPORT_SYMBOL_GPL(rhashtable_walk_next);
 
+/**
+ * rhashtable_walk_prev - Return the previously returned object, if available
+ * @iter:	Hash table iterator
+ *
+ * If rhashtable_walk_next() has previously been called and the object
+ * it returned is still in the hash table, that object is returned again,
+ * otherwise %NULL is returned.
+ *
+ * If the recent rhashtable_walk_next() call was since the most recent
+ * rhashtable_walk_start() call then the returned object may not, strictly
+ * speaking, still be in the table.  It will be safe to dereference.
+ *
+ * Note that the iterator is not changed and in particular it does not
+ * step backwards.
+ */
+void *rhashtable_walk_prev(struct rhashtable_iter *iter)
+{
+	struct rhashtable *ht = iter->ht;
+	struct rhash_head *p = iter->p;
+
+	if (!p)
+		return NULL;
+	if (!iter->p_is_unsafe || ht->rhlist)
+		return p;
+	rht_for_each_rcu(p, iter->walker.tbl, iter->slot)
+		if (p == iter->p)
+			return p;
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(rhashtable_walk_prev);
+
 /**
  * rhashtable_walk_stop - Finish a hash table walk
  * @iter:	Hash table iterator
