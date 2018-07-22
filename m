Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64122ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 05:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F8620854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 05:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F8620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbeGVF6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 01:58:31 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49502 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbeGVF6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 01:58:31 -0400
Received: from localhost (unknown [172.58.46.180])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6F85912130EB6;
        Sat, 21 Jul 2018 22:03:11 -0700 (PDT)
Date:   Sat, 21 Jul 2018 22:03:09 -0700 (PDT)
Message-Id: <20180721.220309.1193443933653884021.davem@davemloft.net>
To:     karn@ka9q.net
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: hard-coded limit on unresolved multicast route cache in
 ipv4/ipmr.c causes slow, unreliable creation of multicast routes on busy
 networks
From:   David Miller <davem@davemloft.net>
In-Reply-To: <147f730b-8cbf-b76d-f693-b3fdaf72a89c@ka9q.net>
References: <147f730b-8cbf-b76d-f693-b3fdaf72a89c@ka9q.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 21 Jul 2018 22:03:12 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phil Karn <karn@ka9q.net>
Date: Sat, 21 Jul 2018 18:31:22 -0700

> I'm running pimd (protocol independent multicast routing) and found that
> on busy networks with lots of unresolved multicast routing entries, the
> creation of new multicast group routes can be extremely slow and
> unreliable, especially when the group in question has little traffic.
> 
> A google search revealed the following conversation about the problem
> from the fall of 2015:
> 
> https://github.com/troglobit/pimd/issues/58
> 
> Note especially the comment by kopren on Sep 13, 2016.
> 
> The writer traced the problem to function ipmr_cache_unresolved() in
> file net/ipmr.c, in the following block of code:
> 
> 		/* Create a new entry if allowable */
> 		if (atomic_read(&mrt->cache_resolve_queue_len) >= 10 ||
> 		    (c = ipmr_cache_alloc_unres()) == NULL) {
> 			spin_unlock_bh(&mfc_unres_lock);
> 
> 			kfree_skb(skb);
> 			return -ENOBUFS;
> 		}
 ...
> Does this hard-coded limit serve any purpose? Can it be safely increased
> to a much larger value, or better yet, removed altogether? If it can't
> be removed, can it at least be made configurable through a /proc entry?

Yeah that limit is bogus for several reasons.

One, it's too low.

Two, it's not configurable.

There does have to be some limit, because we are depending upon a user
process (mrouted or whatever) to receive the netlink message, resolve
the cache entry, and update the kernel.

If the user process gets stuck, or processes entries very slowly, the
backlog could grow infinitely.  So we do indeed need some kind of limit.

But, we essentially already do have such a limit, and that's the
socket receive queue limits of the mrouted socket.  And indeed, we
fail the cache creation if we cannot queue up the netlink message to
the user process successfully.

Therefore, it probably is safe and correct to remove this
cache_resolve_queue_len altogether.

Something like this:

diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
index d633f737b3c6..b166465d7c05 100644
--- a/include/linux/mroute_base.h
+++ b/include/linux/mroute_base.h
@@ -234,7 +234,6 @@ struct mr_table_ops {
  * @mfc_hash: Hash table of all resolved routes for easy lookup
  * @mfc_cache_list: list of resovled routes for possible traversal
  * @maxvif: Identifier of highest value vif currently in use
- * @cache_resolve_queue_len: current size of unresolved queue
  * @mroute_do_assert: Whether to inform userspace on wrong ingress
  * @mroute_do_pim: Whether to receive IGMP PIMv1
  * @mroute_reg_vif_num: PIM-device vif index
@@ -251,7 +250,6 @@ struct mr_table {
 	struct rhltable		mfc_hash;
 	struct list_head	mfc_cache_list;
 	int			maxvif;
-	atomic_t		cache_resolve_queue_len;
 	bool			mroute_do_assert;
 	bool			mroute_do_pim;
 	int			mroute_reg_vif_num;
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 9f79b9803a16..c007cf9bfe82 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -747,8 +747,6 @@ static void ipmr_destroy_unres(struct mr_table *mrt, struct mfc_cache *c)
 	struct sk_buff *skb;
 	struct nlmsgerr *e;
 
-	atomic_dec(&mrt->cache_resolve_queue_len);
-
 	while ((skb = skb_dequeue(&c->_c.mfc_un.unres.unresolved))) {
 		if (ip_hdr(skb)->version == 0) {
 			struct nlmsghdr *nlh = skb_pull(skb,
@@ -1135,9 +1133,11 @@ static int ipmr_cache_unresolved(struct mr_table *mrt, vifi_t vifi,
 	}
 
 	if (!found) {
+		bool was_empty;
+
 		/* Create a new entry if allowable */
-		if (atomic_read(&mrt->cache_resolve_queue_len) >= 10 ||
-		    (c = ipmr_cache_alloc_unres()) == NULL) {
+		c = ipmr_cache_alloc_unres();
+		if (!c) {
 			spin_unlock_bh(&mfc_unres_lock);
 
 			kfree_skb(skb);
@@ -1163,11 +1163,11 @@ static int ipmr_cache_unresolved(struct mr_table *mrt, vifi_t vifi,
 			return err;
 		}
 
-		atomic_inc(&mrt->cache_resolve_queue_len);
+		was_empty = list_empty(&mrt->mfc_unres_queue);
 		list_add(&c->_c.list, &mrt->mfc_unres_queue);
 		mroute_netlink_event(mrt, c, RTM_NEWROUTE);
 
-		if (atomic_read(&mrt->cache_resolve_queue_len) == 1)
+		if (was_empty)
 			mod_timer(&mrt->ipmr_expire_timer,
 				  c->_c.mfc_un.unres.expires);
 	}
@@ -1274,7 +1274,6 @@ static int ipmr_mfc_add(struct net *net, struct mr_table *mrt,
 		if (uc->mfc_origin == c->mfc_origin &&
 		    uc->mfc_mcastgrp == c->mfc_mcastgrp) {
 			list_del(&_uc->list);
-			atomic_dec(&mrt->cache_resolve_queue_len);
 			found = true;
 			break;
 		}
@@ -1322,7 +1321,7 @@ static void mroute_clean_tables(struct mr_table *mrt, bool all)
 		mr_cache_put(c);
 	}
 
-	if (atomic_read(&mrt->cache_resolve_queue_len) != 0) {
+	if (!list_empty(&mrt->mfc_unres_queue)) {
 		spin_lock_bh(&mfc_unres_lock);
 		list_for_each_entry_safe(c, tmp, &mrt->mfc_unres_queue, list) {
 			list_del(&c->list);
@@ -2648,9 +2647,19 @@ static int ipmr_rtm_route(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return ipmr_mfc_delete(tbl, &mfcc, parent);
 }
 
+static int queue_count(struct mr_table *mrt)
+{
+	struct list_head *pos;
+	int count = 0;
+	
+	list_for_each(pos, &mrt->mfc_unres_queue)
+		count++;
+	return count;
+}
+
 static bool ipmr_fill_table(struct mr_table *mrt, struct sk_buff *skb)
 {
-	u32 queue_len = atomic_read(&mrt->cache_resolve_queue_len);
+	u32 queue_len = queue_count(mrt);
 
 	if (nla_put_u32(skb, IPMRA_TABLE_ID, mrt->id) ||
 	    nla_put_u32(skb, IPMRA_TABLE_CACHE_RES_QUEUE_LEN, queue_len) ||
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 0d0f0053bb11..75e9c5a3e7ea 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -759,8 +759,6 @@ static void ip6mr_destroy_unres(struct mr_table *mrt, struct mfc6_cache *c)
 	struct net *net = read_pnet(&mrt->net);
 	struct sk_buff *skb;
 
-	atomic_dec(&mrt->cache_resolve_queue_len);
-
 	while ((skb = skb_dequeue(&c->_c.mfc_un.unres.unresolved)) != NULL) {
 		if (ipv6_hdr(skb)->version == 0) {
 			struct nlmsghdr *nlh = skb_pull(skb,
@@ -1139,8 +1137,8 @@ static int ip6mr_cache_unresolved(struct mr_table *mrt, mifi_t mifi,
 		 *	Create a new entry if allowable
 		 */
 
-		if (atomic_read(&mrt->cache_resolve_queue_len) >= 10 ||
-		    (c = ip6mr_cache_alloc_unres()) == NULL) {
+		c = ip6mr_cache_alloc_unres();
+		if (!c) {
 			spin_unlock_bh(&mfc_unres_lock);
 
 			kfree_skb(skb);
@@ -1167,7 +1165,6 @@ static int ip6mr_cache_unresolved(struct mr_table *mrt, mifi_t mifi,
 			return err;
 		}
 
-		atomic_inc(&mrt->cache_resolve_queue_len);
 		list_add(&c->_c.list, &mrt->mfc_unres_queue);
 		mr6_netlink_event(mrt, c, RTM_NEWROUTE);
 
@@ -1455,7 +1452,6 @@ static int ip6mr_mfc_add(struct net *net, struct mr_table *mrt,
 		if (ipv6_addr_equal(&uc->mf6c_origin, &c->mf6c_origin) &&
 		    ipv6_addr_equal(&uc->mf6c_mcastgrp, &c->mf6c_mcastgrp)) {
 			list_del(&_uc->list);
-			atomic_dec(&mrt->cache_resolve_queue_len);
 			found = true;
 			break;
 		}
@@ -1502,7 +1498,7 @@ static void mroute_clean_tables(struct mr_table *mrt, bool all)
 		mr_cache_put(c);
 	}
 
-	if (atomic_read(&mrt->cache_resolve_queue_len) != 0) {
+	if (!list_empty(&mrt->mfc_unres_queue)) {
 		spin_lock_bh(&mfc_unres_lock);
 		list_for_each_entry_safe(c, tmp, &mrt->mfc_unres_queue, list) {
 			list_del(&c->list);
