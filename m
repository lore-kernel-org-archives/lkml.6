Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0E9C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1D520861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078493;
	bh=HuRMaG1AEMTThaJ1oJNVOz61KDV3PCiZzmmF6yMNd9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ukp7PBm5luPoXEOvQIa7ic+yQaB/zmn6/hHClN6Nh0c4qw3f0h0RMUd3l5w4Alm3D
	 pkW9l7ElgGyGZhzRiJ8H0Qtf2RTAxMKh/aAqTdbJYbmxdVr+NIhi08dTFXLiC0qFeJ
	 f8cTj323/DE0KyQ6YJTjUTM03p599vel1A+9bLPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbfAUNsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:48:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:57858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729830AbfAUNsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:48:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7129E20861;
        Mon, 21 Jan 2019 13:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078487;
        bh=HuRMaG1AEMTThaJ1oJNVOz61KDV3PCiZzmmF6yMNd9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W7V+gKDbOxpvsn0i36g06wHaHIByW9sAZai4BJ2Wq3DUV5dHzFMEgj1pVA2klevz+
         L8SxIojBVMVVyrKumKQSLAYEKiCIzelhtlKzIvdafCTqFYhPDZJr0GQkhGcDBqENJ4
         VgBJkjDEbDI+9MTewsjMP8GSF5m5hCH4sM2TX3mY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shawn Bohrer <sbohrer@cloudflare.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.20 011/111] netfilter: nf_conncount: move all list iterations under spinlock
Date:   Mon, 21 Jan 2019 14:42:05 +0100
Message-Id: <20190121122457.004832613@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 2f971a8f425545da52ca0e6bee81f5b1ea0ccc5f upstream.

Two CPUs may race to remove a connection from the list, the existing
conn->dead will result in a use-after-free. Use the per-list spinlock to
protect list iterations.

As all accesses to the list now happen while holding the per-list lock,
we no longer need to delay free operations with rcu.

Joint work with Florian.

Fixes: 5c789e131cbb9 ("netfilter: nf_conncount: Add list lock and gc worker, and RCU for init tree search")
Reviewed-by: Shawn Bohrer <sbohrer@cloudflare.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_conncount.c |   46 ++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

--- a/net/netfilter/nf_conncount.c
+++ b/net/netfilter/nf_conncount.c
@@ -43,8 +43,6 @@ struct nf_conncount_tuple {
 	struct nf_conntrack_zone	zone;
 	int				cpu;
 	u32				jiffies32;
-	bool				dead;
-	struct rcu_head			rcu_head;
 };
 
 struct nf_conncount_rb {
@@ -83,36 +81,21 @@ static int key_diff(const u32 *a, const
 	return memcmp(a, b, klen * sizeof(u32));
 }
 
-static void __conn_free(struct rcu_head *h)
-{
-	struct nf_conncount_tuple *conn;
-
-	conn = container_of(h, struct nf_conncount_tuple, rcu_head);
-	kmem_cache_free(conncount_conn_cachep, conn);
-}
-
 static bool conn_free(struct nf_conncount_list *list,
 		      struct nf_conncount_tuple *conn)
 {
 	bool free_entry = false;
 
-	spin_lock_bh(&list->list_lock);
-
-	if (conn->dead) {
-		spin_unlock_bh(&list->list_lock);
-		return free_entry;
-	}
+	lockdep_assert_held(&list->list_lock);
 
 	list->count--;
-	conn->dead = true;
-	list_del_rcu(&conn->node);
+	list_del(&conn->node);
 	if (list->count == 0) {
 		list->dead = true;
 		free_entry = true;
 	}
 
-	spin_unlock_bh(&list->list_lock);
-	call_rcu(&conn->rcu_head, __conn_free);
+	kmem_cache_free(conncount_conn_cachep, conn);
 	return free_entry;
 }
 
@@ -242,7 +225,7 @@ void nf_conncount_list_init(struct nf_co
 }
 EXPORT_SYMBOL_GPL(nf_conncount_list_init);
 
-/* Return true if the list is empty */
+/* Return true if the list is empty. Must be called with BH disabled. */
 bool nf_conncount_gc_list(struct net *net,
 			  struct nf_conncount_list *list)
 {
@@ -253,12 +236,18 @@ bool nf_conncount_gc_list(struct net *ne
 	bool free_entry = false;
 	bool ret = false;
 
+	/* don't bother if other cpu is already doing GC */
+	if (!spin_trylock(&list->list_lock))
+		return false;
+
 	list_for_each_entry_safe(conn, conn_n, &list->head, node) {
 		found = find_or_evict(net, list, conn, &free_entry);
 		if (IS_ERR(found)) {
 			if (PTR_ERR(found) == -ENOENT)  {
-				if (free_entry)
+				if (free_entry) {
+					spin_unlock(&list->list_lock);
 					return true;
+				}
 				collected++;
 			}
 			continue;
@@ -271,23 +260,24 @@ bool nf_conncount_gc_list(struct net *ne
 			 * closed already -> ditch it
 			 */
 			nf_ct_put(found_ct);
-			if (conn_free(list, conn))
+			if (conn_free(list, conn)) {
+				spin_unlock(&list->list_lock);
 				return true;
+			}
 			collected++;
 			continue;
 		}
 
 		nf_ct_put(found_ct);
 		if (collected > CONNCOUNT_GC_MAX_NODES)
-			return false;
+			break;
 	}
 
-	spin_lock_bh(&list->list_lock);
 	if (!list->count) {
 		list->dead = true;
 		ret = true;
 	}
-	spin_unlock_bh(&list->list_lock);
+	spin_unlock(&list->list_lock);
 
 	return ret;
 }
@@ -478,6 +468,7 @@ static void tree_gc_worker(struct work_s
 	tree = data->gc_tree % CONNCOUNT_SLOTS;
 	root = &data->root[tree];
 
+	local_bh_disable();
 	rcu_read_lock();
 	for (node = rb_first(root); node != NULL; node = rb_next(node)) {
 		rbconn = rb_entry(node, struct nf_conncount_rb, node);
@@ -485,6 +476,9 @@ static void tree_gc_worker(struct work_s
 			gc_count++;
 	}
 	rcu_read_unlock();
+	local_bh_enable();
+
+	cond_resched();
 
 	spin_lock_bh(&nf_conncount_locks[tree]);
 	if (gc_count < ARRAY_SIZE(gc_nodes))


