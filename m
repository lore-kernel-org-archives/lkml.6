Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932671AbeDWWaJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 18:30:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:54639 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932645AbeDWWaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 18:30:06 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
Date: Tue, 24 Apr 2018 08:29:13 +1000
Subject: [PATCH 4/4] rhashtable: improve rhashtable_walk stability when
 stop/start used.
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152452255351.1456.12384285355497513812.stgit@noble>
In-Reply-To: <152452244405.1456.8175298512483573078.stgit@noble>
References: <152452244405.1456.8175298512483573078.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a walk of an rhashtable is interrupted with rhastable_walk_stop()
and then rhashtable_walk_start(), the location to restart from is based
on a 'skip' count in the current hash chain, and this can be incorrect
if insertions or deletions have happened.  This does not happen when
the walk is not stopped and started as iter->p is a placeholder which
is safe to use while holding the RCU read lock.

In rhashtable_walk_start() we can revalidate that 'p' is still in the
same hash chain.  If it isn't then the current method is still used.

With this patch, if a rhashtable walker ensures that the current
object remains in the table over a stop/start period (possibly by
elevating the reference count if that is sufficient), it can be sure
that a walk will not miss objects that were in the hashtable for the
whole time of the walk.

rhashtable_walk_start() may not find the object even though it is
still in the hashtable if a rehash has moved it to a new table.  In
this case it will (eventually) get -EAGAIN and will need to proceed
through the whole table again to be sure to see everything at least
once.

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 lib/rhashtable.c |   44 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 81edf1ab38ab..9427b5766134 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -727,6 +727,7 @@ int rhashtable_walk_start_check(struct rhashtable_iter *iter)
 	__acquires(RCU)
 {
 	struct rhashtable *ht = iter->ht;
+	bool rhlist = ht->rhlist;
 
 	rcu_read_lock();
 
@@ -735,13 +736,52 @@ int rhashtable_walk_start_check(struct rhashtable_iter *iter)
 		list_del(&iter->walker.list);
 	spin_unlock(&ht->lock);
 
-	if (!iter->walker.tbl && !iter->end_of_table) {
+	if (iter->end_of_table)
+		return 0;
+	if (!iter->walker.tbl) {
 		iter->walker.tbl = rht_dereference_rcu(ht->tbl, ht);
 		iter->slot = 0;
 		iter->skip = 0;
 		return -EAGAIN;
 	}
 
+	if (iter->p && !rhlist) {
+		/*
+		 * We need to validate that 'p' is still in the table, and
+		 * if so, update 'skip'
+		 */
+		struct rhash_head *p;
+		int skip = 0;
+		rht_for_each_rcu(p, iter->walker.tbl, iter->slot) {
+			skip++;
+			if (p == iter->p) {
+				iter->skip = skip;
+				goto found;
+			}
+		}
+		iter->p = NULL;
+	} else if (iter->p && rhlist) {
+		/* Need to validate that 'list' is still in the table, and
+		 * if so, update 'skip' and 'p'.
+		 */
+		struct rhash_head *p;
+		struct rhlist_head *list;
+		int skip = 0;
+		rht_for_each_rcu(p, iter->walker.tbl, iter->slot) {
+			for (list = container_of(p, struct rhlist_head, rhead);
+			     list;
+			     list = rcu_dereference(list->next)) {
+				skip++;
+				if (list == iter->list) {
+					iter->p = p;
+					skip = skip;
+					goto found;
+				}
+			}
+		}
+		iter->p = NULL;
+	}
+found:
 	return 0;
 }
 EXPORT_SYMBOL_GPL(rhashtable_walk_start_check);
@@ -917,8 +957,6 @@ void rhashtable_walk_stop(struct rhashtable_iter *iter)
 		iter->walker.tbl = NULL;
 	spin_unlock(&ht->lock);
 
-	iter->p = NULL;
-
 out:
 	rcu_read_unlock();
 }
