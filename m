Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3620C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB7A20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079726;
	bh=EFhlEE4yzvtFALvy8vIbX0fvJpsS96IYsC5FmqGrmXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R832+Ov5pAgyuPmVFAvrKYWmw6ceZyiFIkWsKJOnPR6Uu9rfLQBERqmXh+mabMAs4
	 mrQtslwUy4HZ4atIP/4gcLlD2U3tYfMtyOwB46ei8Los4RVqemr+kYdARrr5I6940r
	 Yo2+V5ecmawfFPNParx9tQHtBxxNOdJXfCVS9x2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731745AbfAUOIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:08:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:43988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731912AbfAUN6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:58:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F5B12087F;
        Mon, 21 Jan 2019 13:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079109;
        bh=EFhlEE4yzvtFALvy8vIbX0fvJpsS96IYsC5FmqGrmXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z9BpxAWfde+IEDm8G7NYUxiRtg3aI2E0zcUOworYJX+REHfhRAKzCuIXh6IyBArGE
         fyti9O1JYntZ2EVEo4vdpjX5ZjGIyjvfhvIbVmvt90B6djKoWI1WouLwdE9La3wZfB
         icHTyOMFOsynW8PCRM2TIrdjYb6POO+0iQkGSHRE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shawn Bohrer <sbohrer@cloudflare.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.19 12/99] netfilter: nf_conncount: speculative garbage collection on empty lists
Date:   Mon, 21 Jan 2019 14:48:04 +0100
Message-Id: <20190121134914.386905593@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit c80f10bc973af2ace6b1414724eeff61eaa71837 upstream.

Instead of removing a empty list node that might be reintroduced soon
thereafter, tentatively place the empty list node on the list passed to
tree_nodes_free(), then re-check if the list is empty again before erasing
it from the tree.

[ Florian: rebase on top of pending nf_conncount fixes ]

Fixes: 5c789e131cbb9 ("netfilter: nf_conncount: Add list lock and gc worker, and RCU for init tree search")
Reviewed-by: Shawn Bohrer <sbohrer@cloudflare.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/net/netfilter/nf_conntrack_count.h |    1 
 net/netfilter/nf_conncount.c               |   47 +++++++++--------------------
 2 files changed, 15 insertions(+), 33 deletions(-)

--- a/include/net/netfilter/nf_conntrack_count.h
+++ b/include/net/netfilter/nf_conntrack_count.h
@@ -9,7 +9,6 @@ struct nf_conncount_list {
 	spinlock_t list_lock;
 	struct list_head head;	/* connections with the same filtering key */
 	unsigned int count;	/* length of list */
-	bool dead;
 };
 
 struct nf_conncount_data *nf_conncount_init(struct net *net, unsigned int family,
--- a/net/netfilter/nf_conncount.c
+++ b/net/netfilter/nf_conncount.c
@@ -81,27 +81,20 @@ static int key_diff(const u32 *a, const
 	return memcmp(a, b, klen * sizeof(u32));
 }
 
-static bool conn_free(struct nf_conncount_list *list,
+static void conn_free(struct nf_conncount_list *list,
 		      struct nf_conncount_tuple *conn)
 {
-	bool free_entry = false;
-
 	lockdep_assert_held(&list->list_lock);
 
 	list->count--;
 	list_del(&conn->node);
-	if (list->count == 0) {
-		list->dead = true;
-		free_entry = true;
-	}
 
 	kmem_cache_free(conncount_conn_cachep, conn);
-	return free_entry;
 }
 
 static const struct nf_conntrack_tuple_hash *
 find_or_evict(struct net *net, struct nf_conncount_list *list,
-	      struct nf_conncount_tuple *conn, bool *free_entry)
+	      struct nf_conncount_tuple *conn)
 {
 	const struct nf_conntrack_tuple_hash *found;
 	unsigned long a, b;
@@ -121,7 +114,7 @@ find_or_evict(struct net *net, struct nf
 	 */
 	age = a - b;
 	if (conn->cpu == cpu || age >= 2) {
-		*free_entry = conn_free(list, conn);
+		conn_free(list, conn);
 		return ERR_PTR(-ENOENT);
 	}
 
@@ -137,14 +130,13 @@ static int __nf_conncount_add(struct net
 	struct nf_conncount_tuple *conn, *conn_n;
 	struct nf_conn *found_ct;
 	unsigned int collect = 0;
-	bool free_entry = false;
 
 	/* check the saved connections */
 	list_for_each_entry_safe(conn, conn_n, &list->head, node) {
 		if (collect > CONNCOUNT_GC_MAX_NODES)
 			break;
 
-		found = find_or_evict(net, list, conn, &free_entry);
+		found = find_or_evict(net, list, conn);
 		if (IS_ERR(found)) {
 			/* Not found, but might be about to be confirmed */
 			if (PTR_ERR(found) == -EAGAIN) {
@@ -221,7 +213,6 @@ void nf_conncount_list_init(struct nf_co
 	spin_lock_init(&list->list_lock);
 	INIT_LIST_HEAD(&list->head);
 	list->count = 0;
-	list->dead = false;
 }
 EXPORT_SYMBOL_GPL(nf_conncount_list_init);
 
@@ -233,7 +224,6 @@ bool nf_conncount_gc_list(struct net *ne
 	struct nf_conncount_tuple *conn, *conn_n;
 	struct nf_conn *found_ct;
 	unsigned int collected = 0;
-	bool free_entry = false;
 	bool ret = false;
 
 	/* don't bother if other cpu is already doing GC */
@@ -241,15 +231,10 @@ bool nf_conncount_gc_list(struct net *ne
 		return false;
 
 	list_for_each_entry_safe(conn, conn_n, &list->head, node) {
-		found = find_or_evict(net, list, conn, &free_entry);
+		found = find_or_evict(net, list, conn);
 		if (IS_ERR(found)) {
-			if (PTR_ERR(found) == -ENOENT)  {
-				if (free_entry) {
-					spin_unlock(&list->list_lock);
-					return true;
-				}
+			if (PTR_ERR(found) == -ENOENT)
 				collected++;
-			}
 			continue;
 		}
 
@@ -260,10 +245,7 @@ bool nf_conncount_gc_list(struct net *ne
 			 * closed already -> ditch it
 			 */
 			nf_ct_put(found_ct);
-			if (conn_free(list, conn)) {
-				spin_unlock(&list->list_lock);
-				return true;
-			}
+			conn_free(list, conn);
 			collected++;
 			continue;
 		}
@@ -273,10 +255,8 @@ bool nf_conncount_gc_list(struct net *ne
 			break;
 	}
 
-	if (!list->count) {
-		list->dead = true;
+	if (!list->count)
 		ret = true;
-	}
 	spin_unlock(&list->list_lock);
 
 	return ret;
@@ -291,6 +271,7 @@ static void __tree_nodes_free(struct rcu
 	kmem_cache_free(conncount_rb_cachep, rbconn);
 }
 
+/* caller must hold tree nf_conncount_locks[] lock */
 static void tree_nodes_free(struct rb_root *root,
 			    struct nf_conncount_rb *gc_nodes[],
 			    unsigned int gc_count)
@@ -300,8 +281,10 @@ static void tree_nodes_free(struct rb_ro
 	while (gc_count) {
 		rbconn = gc_nodes[--gc_count];
 		spin_lock(&rbconn->list.list_lock);
-		rb_erase(&rbconn->node, root);
-		call_rcu(&rbconn->rcu_head, __tree_nodes_free);
+		if (!rbconn->list.count) {
+			rb_erase(&rbconn->node, root);
+			call_rcu(&rbconn->rcu_head, __tree_nodes_free);
+		}
 		spin_unlock(&rbconn->list.list_lock);
 	}
 }
@@ -318,7 +301,6 @@ insert_tree(struct net *net,
 	    struct rb_root *root,
 	    unsigned int hash,
 	    const u32 *key,
-	    u8 keylen,
 	    const struct nf_conntrack_tuple *tuple,
 	    const struct nf_conntrack_zone *zone)
 {
@@ -327,6 +309,7 @@ insert_tree(struct net *net,
 	struct nf_conncount_rb *rbconn;
 	struct nf_conncount_tuple *conn;
 	unsigned int count = 0, gc_count = 0;
+	u8 keylen = data->keylen;
 	bool do_gc = true;
 
 	spin_lock_bh(&nf_conncount_locks[hash]);
@@ -454,7 +437,7 @@ count_tree(struct net *net,
 	if (!tuple)
 		return 0;
 
-	return insert_tree(net, data, root, hash, key, keylen, tuple, zone);
+	return insert_tree(net, data, root, hash, key, tuple, zone);
 }
 
 static void tree_gc_worker(struct work_struct *work)


