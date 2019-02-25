Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09E4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA0E213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130134;
	bh=QBHdeBc3fTMJRx6Pqrm9v9GHhOBG9HJWzR4YPSFbmJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zidm2ZIMaY5wG9Bnd+Nu9CeqE7RP/iudLOXTZZHsbnXttGUc7Dq0YeJ1wGEEmlHsJ
	 Z73yRJcjgemC+rUeZyITnWI6qpiBAp4BS9JOVh+Z+TG7oN83BZBH+WnpEOV8FF8Acb
	 4gfO2byzdM08VinNXtEsYlDBuez75+NKqjQJw7Ko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731921AbfBYV2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:28:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:34616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731906AbfBYV2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:28:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC1442084D;
        Mon, 25 Feb 2019 21:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130130;
        bh=QBHdeBc3fTMJRx6Pqrm9v9GHhOBG9HJWzR4YPSFbmJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XbQ++LjXBowinXSwJyZY2LZDi4PiW9VC/xAaiYc9sUhz0sfii0R7pmLZxQbhs4+Kl
         E4JMPm00ZhrGZjnrKgLlVJSmIqBQP4dI/wZSzEy4yowAUFTO5PounZViWpSlnFMor5
         LJNToTsN24AISh/DITILPeNYUxer7dfyLaF3nDHI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.20 009/183] mac80211: Use linked list instead of rhashtable walk for mesh tables
Date:   Mon, 25 Feb 2019 22:09:42 +0100
Message-Id: <20190225195056.212549785@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

From: Herbert Xu <herbert@gondor.apana.org.au>

commit b4c3fbe6360178dc2181b7b43b7ae793a192b282 upstream.

The mesh table code walks over hash tables for two purposes.  First of
all it's used as part of a netlink dump process, but it is also used
for looking up entries to delete using criteria other than the hash
key.

The second purpose is directly contrary to the design specification
of rhashtable walks.  It is only meant for use by netlink dumps.

This is because rhashtable is resizable and you cannot obtain a
stable walk over it during a resize process.

In fact mesh's use of rhashtable for dumping is bogus too.  Rather
than using rhashtable walk's iterator to keep track of the current
position, it always converts the current position to an integer
which defeats the purpose of the iterator.

Therefore this patch converts all uses of rhashtable walk into a
simple linked list.

This patch also adds a new spin lock to protect the hash table
insertion/removal as well as the walk list modifications.  In fact
the previous code was buggy as the removals can race with each
other, potentially resulting in a double-free.

Cc: stable@vger.kernel.org
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/mesh.h         |    6 +
 net/mac80211/mesh_pathtbl.c |  138 +++++++++++---------------------------------
 2 files changed, 43 insertions(+), 101 deletions(-)

--- a/net/mac80211/mesh.h
+++ b/net/mac80211/mesh.h
@@ -70,6 +70,7 @@ enum mesh_deferred_task_flags {
  * @dst: mesh path destination mac address
  * @mpp: mesh proxy mac address
  * @rhash: rhashtable list pointer
+ * @walk_list: linked list containing all mesh_path objects.
  * @gate_list: list pointer for known gates list
  * @sdata: mesh subif
  * @next_hop: mesh neighbor to which frames for this destination will be
@@ -105,6 +106,7 @@ struct mesh_path {
 	u8 dst[ETH_ALEN];
 	u8 mpp[ETH_ALEN];	/* used for MPP or MAP */
 	struct rhash_head rhash;
+	struct hlist_node walk_list;
 	struct hlist_node gate_list;
 	struct ieee80211_sub_if_data *sdata;
 	struct sta_info __rcu *next_hop;
@@ -133,12 +135,16 @@ struct mesh_path {
  * gate's mpath may or may not be resolved and active.
  * @gates_lock: protects updates to known_gates
  * @rhead: the rhashtable containing struct mesh_paths, keyed by dest addr
+ * @walk_head: linked list containging all mesh_path objects
+ * @walk_lock: lock protecting walk_head
  * @entries: number of entries in the table
  */
 struct mesh_table {
 	struct hlist_head known_gates;
 	spinlock_t gates_lock;
 	struct rhashtable rhead;
+	struct hlist_head walk_head;
+	spinlock_t walk_lock;
 	atomic_t entries;		/* Up to MAX_MESH_NEIGHBOURS */
 };
 
--- a/net/mac80211/mesh_pathtbl.c
+++ b/net/mac80211/mesh_pathtbl.c
@@ -59,8 +59,10 @@ static struct mesh_table *mesh_table_all
 		return NULL;
 
 	INIT_HLIST_HEAD(&newtbl->known_gates);
+	INIT_HLIST_HEAD(&newtbl->walk_head);
 	atomic_set(&newtbl->entries,  0);
 	spin_lock_init(&newtbl->gates_lock);
+	spin_lock_init(&newtbl->walk_lock);
 
 	return newtbl;
 }
@@ -249,28 +251,15 @@ mpp_path_lookup(struct ieee80211_sub_if_
 static struct mesh_path *
 __mesh_path_lookup_by_idx(struct mesh_table *tbl, int idx)
 {
-	int i = 0, ret;
-	struct mesh_path *mpath = NULL;
-	struct rhashtable_iter iter;
-
-	ret = rhashtable_walk_init(&tbl->rhead, &iter, GFP_ATOMIC);
-	if (ret)
-		return NULL;
-
-	rhashtable_walk_start(&iter);
+	int i = 0;
+	struct mesh_path *mpath;
 
-	while ((mpath = rhashtable_walk_next(&iter))) {
-		if (IS_ERR(mpath) && PTR_ERR(mpath) == -EAGAIN)
-			continue;
-		if (IS_ERR(mpath))
-			break;
+	hlist_for_each_entry_rcu(mpath, &tbl->walk_head, walk_list) {
 		if (i++ == idx)
 			break;
 	}
-	rhashtable_walk_stop(&iter);
-	rhashtable_walk_exit(&iter);
 
-	if (IS_ERR(mpath) || !mpath)
+	if (!mpath)
 		return NULL;
 
 	if (mpath_expired(mpath)) {
@@ -432,6 +421,7 @@ struct mesh_path *mesh_path_add(struct i
 		return ERR_PTR(-ENOMEM);
 
 	tbl = sdata->u.mesh.mesh_paths;
+	spin_lock_bh(&tbl->walk_lock);
 	do {
 		ret = rhashtable_lookup_insert_fast(&tbl->rhead,
 						    &new_mpath->rhash,
@@ -441,8 +431,10 @@ struct mesh_path *mesh_path_add(struct i
 			mpath = rhashtable_lookup_fast(&tbl->rhead,
 						       dst,
 						       mesh_rht_params);
-
+		else if (!ret)
+			hlist_add_head(&new_mpath->walk_list, &tbl->walk_head);
 	} while (unlikely(ret == -EEXIST && !mpath));
+	spin_unlock_bh(&tbl->walk_lock);
 
 	if (ret && ret != -EEXIST)
 		return ERR_PTR(ret);
@@ -480,9 +472,14 @@ int mpp_path_add(struct ieee80211_sub_if
 
 	memcpy(new_mpath->mpp, mpp, ETH_ALEN);
 	tbl = sdata->u.mesh.mpp_paths;
+
+	spin_lock_bh(&tbl->walk_lock);
 	ret = rhashtable_lookup_insert_fast(&tbl->rhead,
 					    &new_mpath->rhash,
 					    mesh_rht_params);
+	if (!ret)
+		hlist_add_head_rcu(&new_mpath->walk_list, &tbl->walk_head);
+	spin_unlock_bh(&tbl->walk_lock);
 
 	sdata->u.mesh.mpp_paths_generation++;
 	return ret;
@@ -503,20 +500,9 @@ void mesh_plink_broken(struct sta_info *
 	struct mesh_table *tbl = sdata->u.mesh.mesh_paths;
 	static const u8 bcast[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 	struct mesh_path *mpath;
-	struct rhashtable_iter iter;
-	int ret;
-
-	ret = rhashtable_walk_init(&tbl->rhead, &iter, GFP_ATOMIC);
-	if (ret)
-		return;
-
-	rhashtable_walk_start(&iter);
 
-	while ((mpath = rhashtable_walk_next(&iter))) {
-		if (IS_ERR(mpath) && PTR_ERR(mpath) == -EAGAIN)
-			continue;
-		if (IS_ERR(mpath))
-			break;
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(mpath, &tbl->walk_head, walk_list) {
 		if (rcu_access_pointer(mpath->next_hop) == sta &&
 		    mpath->flags & MESH_PATH_ACTIVE &&
 		    !(mpath->flags & MESH_PATH_FIXED)) {
@@ -530,8 +516,7 @@ void mesh_plink_broken(struct sta_info *
 				WLAN_REASON_MESH_PATH_DEST_UNREACHABLE, bcast);
 		}
 	}
-	rhashtable_walk_stop(&iter);
-	rhashtable_walk_exit(&iter);
+	rcu_read_unlock();
 }
 
 static void mesh_path_free_rcu(struct mesh_table *tbl,
@@ -551,6 +536,7 @@ static void mesh_path_free_rcu(struct me
 
 static void __mesh_path_del(struct mesh_table *tbl, struct mesh_path *mpath)
 {
+	hlist_del_rcu(&mpath->walk_list);
 	rhashtable_remove_fast(&tbl->rhead, &mpath->rhash, mesh_rht_params);
 	mesh_path_free_rcu(tbl, mpath);
 }
@@ -571,27 +557,14 @@ void mesh_path_flush_by_nexthop(struct s
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	struct mesh_table *tbl = sdata->u.mesh.mesh_paths;
 	struct mesh_path *mpath;
-	struct rhashtable_iter iter;
-	int ret;
-
-	ret = rhashtable_walk_init(&tbl->rhead, &iter, GFP_ATOMIC);
-	if (ret)
-		return;
-
-	rhashtable_walk_start(&iter);
-
-	while ((mpath = rhashtable_walk_next(&iter))) {
-		if (IS_ERR(mpath) && PTR_ERR(mpath) == -EAGAIN)
-			continue;
-		if (IS_ERR(mpath))
-			break;
+	struct hlist_node *n;
 
+	spin_lock_bh(&tbl->walk_lock);
+	hlist_for_each_entry_safe(mpath, n, &tbl->walk_head, walk_list) {
 		if (rcu_access_pointer(mpath->next_hop) == sta)
 			__mesh_path_del(tbl, mpath);
 	}
-
-	rhashtable_walk_stop(&iter);
-	rhashtable_walk_exit(&iter);
+	spin_unlock_bh(&tbl->walk_lock);
 }
 
 static void mpp_flush_by_proxy(struct ieee80211_sub_if_data *sdata,
@@ -599,51 +572,26 @@ static void mpp_flush_by_proxy(struct ie
 {
 	struct mesh_table *tbl = sdata->u.mesh.mpp_paths;
 	struct mesh_path *mpath;
-	struct rhashtable_iter iter;
-	int ret;
-
-	ret = rhashtable_walk_init(&tbl->rhead, &iter, GFP_ATOMIC);
-	if (ret)
-		return;
-
-	rhashtable_walk_start(&iter);
-
-	while ((mpath = rhashtable_walk_next(&iter))) {
-		if (IS_ERR(mpath) && PTR_ERR(mpath) == -EAGAIN)
-			continue;
-		if (IS_ERR(mpath))
-			break;
+	struct hlist_node *n;
 
+	spin_lock_bh(&tbl->walk_lock);
+	hlist_for_each_entry_safe(mpath, n, &tbl->walk_head, walk_list) {
 		if (ether_addr_equal(mpath->mpp, proxy))
 			__mesh_path_del(tbl, mpath);
 	}
-
-	rhashtable_walk_stop(&iter);
-	rhashtable_walk_exit(&iter);
+	spin_unlock_bh(&tbl->walk_lock);
 }
 
 static void table_flush_by_iface(struct mesh_table *tbl)
 {
 	struct mesh_path *mpath;
-	struct rhashtable_iter iter;
-	int ret;
-
-	ret = rhashtable_walk_init(&tbl->rhead, &iter, GFP_ATOMIC);
-	if (ret)
-		return;
-
-	rhashtable_walk_start(&iter);
+	struct hlist_node *n;
 
-	while ((mpath = rhashtable_walk_next(&iter))) {
-		if (IS_ERR(mpath) && PTR_ERR(mpath) == -EAGAIN)
-			continue;
-		if (IS_ERR(mpath))
-			break;
+	spin_lock_bh(&tbl->walk_lock);
+	hlist_for_each_entry_safe(mpath, n, &tbl->walk_head, walk_list) {
 		__mesh_path_del(tbl, mpath);
 	}
-
-	rhashtable_walk_stop(&iter);
-	rhashtable_walk_exit(&iter);
+	spin_unlock_bh(&tbl->walk_lock);
 }
 
 /**
@@ -675,7 +623,7 @@ static int table_path_del(struct mesh_ta
 {
 	struct mesh_path *mpath;
 
-	rcu_read_lock();
+	spin_lock_bh(&tbl->walk_lock);
 	mpath = rhashtable_lookup_fast(&tbl->rhead, addr, mesh_rht_params);
 	if (!mpath) {
 		rcu_read_unlock();
@@ -683,7 +631,7 @@ static int table_path_del(struct mesh_ta
 	}
 
 	__mesh_path_del(tbl, mpath);
-	rcu_read_unlock();
+	spin_unlock_bh(&tbl->walk_lock);
 	return 0;
 }
 
@@ -854,28 +802,16 @@ void mesh_path_tbl_expire(struct ieee802
 			  struct mesh_table *tbl)
 {
 	struct mesh_path *mpath;
-	struct rhashtable_iter iter;
-	int ret;
+	struct hlist_node *n;
 
-	ret = rhashtable_walk_init(&tbl->rhead, &iter, GFP_KERNEL);
-	if (ret)
-		return;
-
-	rhashtable_walk_start(&iter);
-
-	while ((mpath = rhashtable_walk_next(&iter))) {
-		if (IS_ERR(mpath) && PTR_ERR(mpath) == -EAGAIN)
-			continue;
-		if (IS_ERR(mpath))
-			break;
+	spin_lock_bh(&tbl->walk_lock);
+	hlist_for_each_entry_safe(mpath, n, &tbl->walk_head, walk_list) {
 		if ((!(mpath->flags & MESH_PATH_RESOLVING)) &&
 		    (!(mpath->flags & MESH_PATH_FIXED)) &&
 		     time_after(jiffies, mpath->exp_time + MESH_PATH_EXPIRE))
 			__mesh_path_del(tbl, mpath);
 	}
-
-	rhashtable_walk_stop(&iter);
-	rhashtable_walk_exit(&iter);
+	spin_unlock_bh(&tbl->walk_lock);
 }
 
 void mesh_path_expire(struct ieee80211_sub_if_data *sdata)


