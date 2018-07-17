Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012C6ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF47220C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpRDF48F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF47220C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731765AbeGQMjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:39:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731578AbeGQMjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:39:12 -0400
Received: from kenny.it.cumulusnetworks.com. (fw.cumulusnetworks.com [216.129.126.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ED6A21470;
        Tue, 17 Jul 2018 12:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531829211;
        bh=/yZPFCgK/INgKrVBYrtJOt18h5bxAzE2qcZcuTkzidg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OpRDF48F3ac6gd+bfkkMKBBUHv9/A9ykstdM1PPuAutxxMQcdRcnm041jH0ohIZMH
         ks4YKlojw6NDGGNtuheJJulu7cuJzdTZTTiqUhlOtOZg1jbKLDPAarzM7nl3614OZ6
         4V+QqUDsoPqxgDaKm+Snb3MsRU9PpkvZ4Dbzqms4=
From:   dsahern@kernel.org
To:     netdev@vger.kernel.org
Cc:     nikita.leshchenko@oracle.com, roopa@cumulusnetworks.com,
        stephen@networkplumber.org, idosch@mellanox.com, jiri@mellanox.com,
        saeedm@mellanox.com, alex.aring@gmail.com,
        linux-wpan@vger.kernel.org, netfilter-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Ahern <dsahern@gmail.com>
Subject: [PATCH RFC/RFT net-next 16/17] net/decnet: Move neighbor table to per-namespace
Date:   Tue, 17 Jul 2018 05:06:50 -0700
Message-Id: <20180717120651.15748-17-dsahern@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180717120651.15748-1-dsahern@kernel.org>
References: <20180717120651.15748-1-dsahern@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>

Convert decnet neighbor table to per-namespace. Since there are no
other per-namespace parameters for decnet just add the reference to
struct net directly.

Signed-off-by: David Ahern <dsahern@gmail.com>
---
 include/net/net_namespace.h |  3 +++
 net/core/neighbour.c        | 26 ++++++++++----------------
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index a71264d75d7f..77799ed7212e 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -108,6 +108,9 @@ struct net {
 #if IS_ENABLED(CONFIG_IPV6)
 	struct netns_ipv6	ipv6;
 #endif
+#if IS_ENABLED(CONFIG_DECNET)
+	struct neigh_table	*dn_tbl;
+#endif
 #if IS_ENABLED(CONFIG_IEEE802154_6LOWPAN)
 	struct netns_ieee802154_lowpan	ieee802154_lowpan;
 #endif
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 35c41c4876e5..1bb7fa14cb62 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1485,15 +1485,11 @@ EXPORT_SYMBOL(pneigh_enqueue);
 static inline struct neigh_parms *lookup_neigh_parms(struct neigh_table *tbl,
 						      struct net *net, int ifindex)
 {
-	struct net *def_net = &init_net;
 	struct neigh_parms *p;
 
-	if (tbl->family != AF_DECnet)
-		def_net = neigh_parms_net(p);
-
 	list_for_each_entry(p, &tbl->parms_list, list) {
 		if ((p->dev && p->dev->ifindex == ifindex && net_eq(neigh_parms_net(p), net)) ||
-		    (!p->dev && !ifindex && net_eq(net, def_net)))
+		    (!p->dev && !ifindex))
 			return p;
 	}
 
@@ -1622,9 +1618,11 @@ void neigh_table_init(struct net *net, struct neigh_table *tbl)
 		net->ipv6.nd_tbl = tbl;
 		break;
 #endif
+#if IS_ENABLED(CONFIG_DECNET)
 	case AF_DECnet:
-		neigh_tables[NEIGH_DN_TABLE] = tbl;
+		net->dn_tbl = tbl;
 		break;
+#endif
 	}
 }
 EXPORT_SYMBOL(neigh_table_init);
@@ -1642,9 +1640,11 @@ int neigh_table_clear(struct net *net, struct neigh_table *tbl)
 		net->ipv6.nd_tbl = NULL;
 		break;
 #endif
+#if IS_ENABLED(CONFIG_DECNET)
 	case AF_DECnet:
-		neigh_tables[NEIGH_DN_TABLE] = NULL;
+		net->dn_tbl = NULL;
 		break;
+#endif
 	}
 
 	/* It is not clean... Fix it to unload IPv6 module safely */
@@ -1684,9 +1684,11 @@ struct neigh_table *neigh_find_table(struct net *net, u8 family)
 		tbl = net->ipv6.nd_tbl;
 		break;
 #endif
+#if IS_ENABLED(CONFIG_DECNET)
 	case AF_DECnet:
-		tbl = neigh_tables[NEIGH_DN_TABLE];
+		tbl = net->dn_tbl;
 		break;
+#endif
 	}
 
 	return tbl;
@@ -2182,14 +2184,6 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 	}
 
-	err = -ENOENT;
-	if (tbl->family == AF_DECnet) {
-		if ((tb[NDTA_THRESH1] || tb[NDTA_THRESH2] ||
-		     tb[NDTA_THRESH3] || tb[NDTA_GC_INTERVAL]) &&
-		    !net_eq(net, &init_net))
-			goto errout_tbl_lock;
-	}
-
 	if (tb[NDTA_THRESH1])
 		tbl->gc_thresh1 = nla_get_u32(tb[NDTA_THRESH1]);
 
-- 
2.11.0

