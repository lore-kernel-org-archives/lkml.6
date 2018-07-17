Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DC3ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B7D2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRyMZmJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B7D2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbeGQMlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:41:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731295AbeGQMjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:39:07 -0400
Received: from kenny.it.cumulusnetworks.com. (fw.cumulusnetworks.com [216.129.126.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B090021470;
        Tue, 17 Jul 2018 12:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531829207;
        bh=+Onk9sgSg8tyzRprLO2KfeNHFIufh3MXfKbvv1kWoK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NRyMZmJpncINYBQ0mQzeZ/bhbiv6I/ANP+zuetMWSaf6k1CR5OA0e5g72wOtoVHqG
         hxCtCboI7JUqgyIUOJV564sjLY5lGXUp1Y39nGokAXZU0SFlSRby7kKwfGozx5JE3j
         qnQv3Y65nn8pc4SSZ3cVwIJ5yi+wQaDkkL9hoM2w=
From:   dsahern@kernel.org
To:     netdev@vger.kernel.org
Cc:     nikita.leshchenko@oracle.com, roopa@cumulusnetworks.com,
        stephen@networkplumber.org, idosch@mellanox.com, jiri@mellanox.com,
        saeedm@mellanox.com, alex.aring@gmail.com,
        linux-wpan@vger.kernel.org, netfilter-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Ahern <dsahern@gmail.com>
Subject: [PATCH RFC/RFT net-next 05/17] net/ipv6: wrappers for neighbor table references
Date:   Tue, 17 Jul 2018 05:06:39 -0700
Message-Id: <20180717120651.15748-6-dsahern@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180717120651.15748-1-dsahern@kernel.org>
References: <20180717120651.15748-1-dsahern@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>

Create a helper, ipv6_neigh_table, for retrieving a reference to the ipv6
neighbor table. Add additional wrappers for commonly used neigh_* functions
to avoid propagating the ipv6_neigh_table lookup all over the code.

For ipv6, the neighbor table may not exist (e.g., IPv6 not enabled at
build time or the module is not loaded) so NULL checks are needed before
use.

Signed-off-by: David Ahern <dsahern@gmail.com>
---
 include/net/ndisc.h | 69 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 4 deletions(-)

diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index ddfbb591e2c5..078951ac54fd 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -374,17 +374,70 @@ static inline u32 ndisc_hashfn(const void *pkey, const struct net_device *dev, _
 		(p32[3] * hash_rnd[3]));
 }
 
-static inline struct neighbour *__ipv6_neigh_lookup_noref(struct net_device *dev, const void *pkey)
+static inline struct neigh_table *ipv6_neigh_table(struct net *net)
 {
-	return ___neigh_lookup_noref(&nd_tbl, neigh_key_eq128, ndisc_hashfn, pkey, dev);
+	return neigh_find_table(net, AF_INET6);
 }
 
-static inline struct neighbour *__ipv6_neigh_lookup(struct net_device *dev, const void *pkey)
+static inline struct neighbour *ipv6_neigh_create(struct net_device *dev,
+						  const void *pkey,
+						  bool want_ref)
+{
+	struct neigh_table *tbl = ipv6_neigh_table(dev_net(dev));
+	struct neighbour *n = NULL;
+
+	if (tbl)
+		n = __neigh_create(tbl, pkey, dev, want_ref);
+
+	return n;
+}
+
+static inline struct neighbour *ipv6_neigh_lookup(struct net_device *dev,
+						  const void *pkey)
+{
+	struct neigh_table *tbl = ipv6_neigh_table(dev_net(dev));
+	struct neighbour *n = NULL;
+
+	if (tbl)
+		n = neigh_lookup(tbl, pkey, dev);
+
+	return n;
+}
+
+static inline struct neighbour *__ipv6_neigh_lookup(struct net_device *dev,
+						    const void *pkey, int creat)
+{
+	struct neigh_table *tbl = ipv6_neigh_table(dev_net(dev));
+	struct neighbour *n = NULL;
+
+	if (tbl)
+		n = __neigh_lookup(tbl, pkey, dev, creat);
+
+	return n;
+}
+
+static inline
+struct neighbour *___ipv6_neigh_lookup_noref(struct net_device *dev,
+					     const void *pkey)
+{
+	struct neigh_table *tbl = ipv6_neigh_table(dev_net(dev));
+	struct neighbour *n = NULL;
+
+	if (tbl)
+		n = ___neigh_lookup_noref(tbl, neigh_key_eq128, ndisc_hashfn,
+					  pkey, dev);
+
+	return n;
+}
+
+static inline
+struct neighbour *__ipv6_neigh_lookup_noref(struct net_device *dev,
+					    const void *pkey)
 {
 	struct neighbour *n;
 
 	rcu_read_lock_bh();
-	n = __ipv6_neigh_lookup_noref(dev, pkey);
+	n = ___ipv6_neigh_lookup_noref(dev, pkey);
 	if (n && !refcount_inc_not_zero(&n->refcnt))
 		n = NULL;
 	rcu_read_unlock_bh();
@@ -409,6 +462,14 @@ static inline void __ipv6_confirm_neigh(struct net_device *dev,
 	rcu_read_unlock_bh();
 }
 
+static inline struct pneigh_entry *ipv6_pneigh_lookup(struct net *net,
+						      const void *key,
+						      struct net_device *dev,
+						      int creat)
+{
+	return pneigh_lookup(ipv6_neigh_table(net), net, key, dev, creat);
+}
+
 int ndisc_init(void);
 int ndisc_late_init(void);
 
-- 
2.11.0

