Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B68CECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372B320C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOg4YjnY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372B320C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731702AbeGQMjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:39:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731578AbeGQMjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:39:10 -0400
Received: from kenny.it.cumulusnetworks.com. (fw.cumulusnetworks.com [216.129.126.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB1722146E;
        Tue, 17 Jul 2018 12:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531829209;
        bh=8GKzGp9shED2/wquQmVc5Qc9+R7PbjPi5BjBwbBPP9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uOg4YjnYCSOTRgxJbP9huV3zhHr2XKYDwVFlK4iKIhvIUkPV9gKr/nNRL87G8QhBY
         qdd4LjY85n67/PsQCiIj9CR79XMxjwbUsl6JnvaNZ8QkOJ0psO7hCZUSbQufWK4WH4
         /cnq44e+05OOotjgcHNF4478obIsT1UAesMb9MYI=
From:   dsahern@kernel.org
To:     netdev@vger.kernel.org
Cc:     nikita.leshchenko@oracle.com, roopa@cumulusnetworks.com,
        stephen@networkplumber.org, idosch@mellanox.com, jiri@mellanox.com,
        saeedm@mellanox.com, alex.aring@gmail.com,
        linux-wpan@vger.kernel.org, netfilter-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Ahern <dsahern@gmail.com>
Subject: [PATCH RFC/RFT net-next 10/17] net: Add key_len to neighbor constructor
Date:   Tue, 17 Jul 2018 05:06:44 -0700
Message-Id: <20180717120651.15748-11-dsahern@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180717120651.15748-1-dsahern@kernel.org>
References: <20180717120651.15748-1-dsahern@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>

Allows arp_constructor to not reference the arp_tbl directly.
ndisc_constructor assumes key length. Could do the same with arp.

Signed-off-by: David Ahern <dsahern@gmail.com>
---
 include/net/neighbour.h | 3 ++-
 net/core/neighbour.c    | 3 ++-
 net/decnet/dn_neigh.c   | 4 ++--
 net/ipv4/arp.c          | 6 +++---
 net/ipv6/ndisc.c        | 4 ++--
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 5bc4d79b4b3a..6cf9ce16eac8 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -198,7 +198,8 @@ struct neigh_table {
 					const struct net_device *dev,
 					__u32 *hash_rnd);
 	bool			(*key_eq)(const struct neighbour *, const void *pkey);
-	int			(*constructor)(struct neighbour *);
+	int			(*constructor)(struct neighbour *,
+					       unsigned int key_len);
 	int			(*pconstructor)(struct pneigh_entry *);
 	void			(*pdestructor)(struct pneigh_entry *);
 	void			(*proxy_redo)(struct sk_buff *skb);
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index e8630f9de24a..41841d8e4ea4 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -505,7 +505,8 @@ struct neighbour *__neigh_create(struct neigh_table *tbl, const void *pkey,
 	dev_hold(dev);
 
 	/* Protocol specific setup. */
-	if (tbl->constructor &&	(error = tbl->constructor(n)) < 0) {
+	if (tbl->constructor &&
+	    (error = tbl->constructor(n, tbl->key_len)) < 0) {
 		rc = ERR_PTR(error);
 		goto out_neigh_release;
 	}
diff --git a/net/decnet/dn_neigh.c b/net/decnet/dn_neigh.c
index 94b306f6d551..74112777beb0 100644
--- a/net/decnet/dn_neigh.c
+++ b/net/decnet/dn_neigh.c
@@ -49,7 +49,7 @@
 #include <net/dn_neigh.h>
 #include <net/dn_route.h>
 
-static int dn_neigh_construct(struct neighbour *);
+static int dn_neigh_construct(struct neighbour *, unsigned int key_len);
 static void dn_neigh_error_report(struct neighbour *, struct sk_buff *);
 static int dn_neigh_output(struct neighbour *neigh, struct sk_buff *skb);
 
@@ -108,7 +108,7 @@ struct neigh_table dn_neigh_table = {
 	.gc_thresh3 =			1024,
 };
 
-static int dn_neigh_construct(struct neighbour *neigh)
+static int dn_neigh_construct(struct neighbour *neigh, unsigned int key_len)
 {
 	struct net_device *dev = neigh->dev;
 	struct dn_neigh *dn = container_of(neigh, struct dn_neigh, n);
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index fd4a380da9bb..7b27faefa01b 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -125,7 +125,7 @@
  */
 static u32 arp_hash(const void *pkey, const struct net_device *dev, __u32 *hash_rnd);
 static bool arp_key_eq(const struct neighbour *n, const void *pkey);
-static int arp_constructor(struct neighbour *neigh);
+static int arp_constructor(struct neighbour *neigh, unsigned int key_len);
 static void arp_solicit(struct neighbour *neigh, struct sk_buff *skb);
 static void arp_error_report(struct neighbour *neigh, struct sk_buff *skb);
 static void parp_redo(struct sk_buff *skb);
@@ -221,7 +221,7 @@ static bool arp_key_eq(const struct neighbour *neigh, const void *pkey)
 	return neigh_key_eq32(neigh, pkey);
 }
 
-static int arp_constructor(struct neighbour *neigh)
+static int arp_constructor(struct neighbour *neigh, unsigned int key_len)
 {
 	__be32 addr;
 	struct net_device *dev = neigh->dev;
@@ -230,7 +230,7 @@ static int arp_constructor(struct neighbour *neigh)
 	u32 inaddr_any = INADDR_ANY;
 
 	if (dev->flags & (IFF_LOOPBACK | IFF_POINTOPOINT))
-		memcpy(neigh->primary_key, &inaddr_any, arp_tbl.key_len);
+		memcpy(neigh->primary_key, &inaddr_any, key_len);
 
 	addr = *(__be32 *)neigh->primary_key;
 	rcu_read_lock();
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 14b925f36099..5103d8641b04 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -77,7 +77,7 @@ static u32 ndisc_hash(const void *pkey,
 		      const struct net_device *dev,
 		      __u32 *hash_rnd);
 static bool ndisc_key_eq(const struct neighbour *neigh, const void *pkey);
-static int ndisc_constructor(struct neighbour *neigh);
+static int ndisc_constructor(struct neighbour *neigh, unsigned int key_len);
 static void ndisc_solicit(struct neighbour *neigh, struct sk_buff *skb);
 static void ndisc_error_report(struct neighbour *neigh, struct sk_buff *skb);
 static int pndisc_constructor(struct pneigh_entry *n);
@@ -319,7 +319,7 @@ static bool ndisc_key_eq(const struct neighbour *n, const void *pkey)
 	return neigh_key_eq128(n, pkey);
 }
 
-static int ndisc_constructor(struct neighbour *neigh)
+static int ndisc_constructor(struct neighbour *neigh, unsigned int key_len)
 {
 	struct in6_addr *addr = (struct in6_addr *)&neigh->primary_key;
 	struct net_device *dev = neigh->dev;
-- 
2.11.0

