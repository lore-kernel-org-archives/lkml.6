Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8296C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B5A2252A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M48ZuzFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B5A2252A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388829AbeKOIae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:30:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:37632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728133AbeKOIac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:30:32 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFA5022529;
        Wed, 14 Nov 2018 22:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234328;
        bh=3tOuktUsrkqr5CbJSgMPMErp/eXams0Tu8BZ16LQQFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M48ZuzFvHFGT8Iq7ufKQR0/+LjPLBUnQm50Ef8Z44ujhrodk4E8uPaS8O8yl28mHN
         JimGT8eKdn6NbuqPVd4WlFiN60oUBE7rTpKfTehaZ8uqvTN2VQrxSfu7rN+2Sw+rdH
         hY0fGCyKzwZjGRb1eqbvga7MONmkSHh2QsW9HKC4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stefano Brivio <sbrivio@redhat.com>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 02/27] netfilter: ipset: list:set: Decrease refcount synchronously on deletion and replace
Date:   Wed, 14 Nov 2018 17:24:51 -0500
Message-Id: <20181114222520.99926-2-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222520.99926-1-sashal@kernel.org>
References: <20181114222520.99926-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Brivio <sbrivio@redhat.com>

[ Upstream commit 439cd39ea136d2c026805264d58a91f36b6b64ca ]

Commit 45040978c899 ("netfilter: ipset: Fix set:list type crash
when flush/dump set in parallel") postponed decreasing set
reference counters to the RCU callback.

An 'ipset del' command can terminate before the RCU grace period
is elapsed, and if sets are listed before then, the reference
counter shown in userspace will be wrong:

 # ipset create h hash:ip; ipset create l list:set; ipset add l
 # ipset del l h; ipset list h
 Name: h
 Type: hash:ip
 Revision: 4
 Header: family inet hashsize 1024 maxelem 65536
 Size in memory: 88
 References: 1
 Number of entries: 0
 Members:
 # sleep 1; ipset list h
 Name: h
 Type: hash:ip
 Revision: 4
 Header: family inet hashsize 1024 maxelem 65536
 Size in memory: 88
 References: 0
 Number of entries: 0
 Members:

Fix this by making the reference count update synchronous again.

As a result, when sets are listed, ip_set_name_byindex() might
now fetch a set whose reference count is already zero. Instead
of relying on the reference count to protect against concurrent
set renaming, grab ip_set_ref_lock as reader and copy the name,
while holding the same lock in ip_set_rename() as writer
instead.

Reported-by: Li Shuang <shuali@redhat.com>
Fixes: 45040978c899 ("netfilter: ipset: Fix set:list type crash when flush/dump set in parallel")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netfilter/ipset/ip_set.h |  2 +-
 net/netfilter/ipset/ip_set_core.c      | 23 +++++++++++------------
 net/netfilter/ipset/ip_set_list_set.c  | 17 +++++++++++------
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/include/linux/netfilter/ipset/ip_set.h b/include/linux/netfilter/ipset/ip_set.h
index 8e42253e5d4d..91a533bd3eb1 100644
--- a/include/linux/netfilter/ipset/ip_set.h
+++ b/include/linux/netfilter/ipset/ip_set.h
@@ -312,7 +312,7 @@ enum {
 extern ip_set_id_t ip_set_get_byname(struct net *net,
 				     const char *name, struct ip_set **set);
 extern void ip_set_put_byindex(struct net *net, ip_set_id_t index);
-extern const char *ip_set_name_byindex(struct net *net, ip_set_id_t index);
+extern void ip_set_name_byindex(struct net *net, ip_set_id_t index, char *name);
 extern ip_set_id_t ip_set_nfnl_get_byindex(struct net *net, ip_set_id_t index);
 extern void ip_set_nfnl_put(struct net *net, ip_set_id_t index);
 
diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 9d2ce1459cec..a3f1dc7cf538 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -668,21 +668,20 @@ ip_set_put_byindex(struct net *net, ip_set_id_t index)
 EXPORT_SYMBOL_GPL(ip_set_put_byindex);
 
 /* Get the name of a set behind a set index.
- * We assume the set is referenced, so it does exist and
- * can't be destroyed. The set cannot be renamed due to
- * the referencing either.
- *
+ * Set itself is protected by RCU, but its name isn't: to protect against
+ * renaming, grab ip_set_ref_lock as reader (see ip_set_rename()) and copy the
+ * name.
  */
-const char *
-ip_set_name_byindex(struct net *net, ip_set_id_t index)
+void
+ip_set_name_byindex(struct net *net, ip_set_id_t index, char *name)
 {
-	const struct ip_set *set = ip_set_rcu_get(net, index);
+	struct ip_set *set = ip_set_rcu_get(net, index);
 
 	BUG_ON(!set);
-	BUG_ON(set->ref == 0);
 
-	/* Referenced, so it's safe */
-	return set->name;
+	read_lock_bh(&ip_set_ref_lock);
+	strncpy(name, set->name, IPSET_MAXNAMELEN);
+	read_unlock_bh(&ip_set_ref_lock);
 }
 EXPORT_SYMBOL_GPL(ip_set_name_byindex);
 
@@ -1128,7 +1127,7 @@ static int ip_set_rename(struct net *net, struct sock *ctnl,
 	if (!set)
 		return -ENOENT;
 
-	read_lock_bh(&ip_set_ref_lock);
+	write_lock_bh(&ip_set_ref_lock);
 	if (set->ref != 0) {
 		ret = -IPSET_ERR_REFERENCED;
 		goto out;
@@ -1145,7 +1144,7 @@ static int ip_set_rename(struct net *net, struct sock *ctnl,
 	strncpy(set->name, name2, IPSET_MAXNAMELEN);
 
 out:
-	read_unlock_bh(&ip_set_ref_lock);
+	write_unlock_bh(&ip_set_ref_lock);
 	return ret;
 }
 
diff --git a/net/netfilter/ipset/ip_set_list_set.c b/net/netfilter/ipset/ip_set_list_set.c
index 178d4eba013b..75d52aed6fdb 100644
--- a/net/netfilter/ipset/ip_set_list_set.c
+++ b/net/netfilter/ipset/ip_set_list_set.c
@@ -156,9 +156,7 @@ __list_set_del_rcu(struct rcu_head * rcu)
 {
 	struct set_elem *e = container_of(rcu, struct set_elem, rcu);
 	struct ip_set *set = e->set;
-	struct list_set *map = set->data;
 
-	ip_set_put_byindex(map->net, e->id);
 	ip_set_ext_destroy(set, e);
 	kfree(e);
 }
@@ -166,15 +164,21 @@ __list_set_del_rcu(struct rcu_head * rcu)
 static inline void
 list_set_del(struct ip_set *set, struct set_elem *e)
 {
+	struct list_set *map = set->data;
+
 	set->elements--;
 	list_del_rcu(&e->list);
+	ip_set_put_byindex(map->net, e->id);
 	call_rcu(&e->rcu, __list_set_del_rcu);
 }
 
 static inline void
-list_set_replace(struct set_elem *e, struct set_elem *old)
+list_set_replace(struct ip_set *set, struct set_elem *e, struct set_elem *old)
 {
+	struct list_set *map = set->data;
+
 	list_replace_rcu(&old->list, &e->list);
+	ip_set_put_byindex(map->net, old->id);
 	call_rcu(&old->rcu, __list_set_del_rcu);
 }
 
@@ -306,7 +310,7 @@ list_set_uadd(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 	INIT_LIST_HEAD(&e->list);
 	list_set_init_extensions(set, ext, e);
 	if (n)
-		list_set_replace(e, n);
+		list_set_replace(set, e, n);
 	else if (next)
 		list_add_tail_rcu(&e->list, &next->list);
 	else if (prev)
@@ -497,6 +501,7 @@ list_set_list(const struct ip_set *set,
 	const struct list_set *map = set->data;
 	struct nlattr *atd, *nested;
 	u32 i = 0, first = cb->args[IPSET_CB_ARG0];
+	char name[IPSET_MAXNAMELEN];
 	struct set_elem *e;
 	int ret = 0;
 
@@ -515,8 +520,8 @@ list_set_list(const struct ip_set *set,
 		nested = ipset_nest_start(skb, IPSET_ATTR_DATA);
 		if (!nested)
 			goto nla_put_failure;
-		if (nla_put_string(skb, IPSET_ATTR_NAME,
-				   ip_set_name_byindex(map->net, e->id)))
+		ip_set_name_byindex(map->net, e->id, name);
+		if (nla_put_string(skb, IPSET_ATTR_NAME, name))
 			goto nla_put_failure;
 		if (ip_set_put_extensions(skb, set, e, true))
 			goto nla_put_failure;
-- 
2.17.1

