Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D742ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5FC2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yu69DhCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5FC2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbeGQMjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:39:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729508AbeGQMjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:39:06 -0400
Received: from kenny.it.cumulusnetworks.com. (fw.cumulusnetworks.com [216.129.126.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4B582146F;
        Tue, 17 Jul 2018 12:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531829206;
        bh=KQdVRaz4SnPg7pOrOTp7YyfKELMCceKO5akI9ql/Wag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yu69DhCFMOFVZgpvKlfH/UKVG0qwqkmMldfn7Igm10UZ0dhnc2AFRHOxErRoQxSoJ
         SNob6dPhu5ECUigIAdpqaLOhHCokDbIALcmP0RvuTS5UJTYxoeBmkLGaoNCBgRt6Bn
         Xh+JomwXlh2CJAzirIVVOFf9hO0gb/QzELc/WbTc=
From:   dsahern@kernel.org
To:     netdev@vger.kernel.org
Cc:     nikita.leshchenko@oracle.com, roopa@cumulusnetworks.com,
        stephen@networkplumber.org, idosch@mellanox.com, jiri@mellanox.com,
        saeedm@mellanox.com, alex.aring@gmail.com,
        linux-wpan@vger.kernel.org, netfilter-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Ahern <dsahern@gmail.com>
Subject: [PATCH RFC/RFT net-next 03/17] net/ipv4: wrappers for arp table references
Date:   Tue, 17 Jul 2018 05:06:37 -0700
Message-Id: <20180717120651.15748-4-dsahern@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180717120651.15748-1-dsahern@kernel.org>
References: <20180717120651.15748-1-dsahern@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>

Create a helper, ipv4_neigh_table, for retrieving a reference to the arp
table. Add additional wrappers for commonly used neigh_* functions to
avoid propagating the ipv4_neigh_table lookup all over the code.

Signed-off-by: David Ahern <dsahern@gmail.com>
---
 include/net/arp.h | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/net/arp.h b/include/net/arp.h
index 977aabfcdc03..7b503bedd9fb 100644
--- a/include/net/arp.h
+++ b/include/net/arp.h
@@ -10,6 +10,29 @@
 
 extern struct neigh_table arp_tbl;
 
+static inline struct neigh_table *ipv4_neigh_table(struct net *net)
+{
+	return neigh_find_table(net, AF_INET);
+}
+
+static inline struct neighbour *ipv4_neigh_create(struct net_device *dev,
+						  const void *pkey)
+{
+	return neigh_create(ipv4_neigh_table(dev_net(dev)), pkey, dev);
+}
+
+static inline struct neighbour *ipv4_neigh_create_noref(struct net_device *dev,
+							const void *pkey)
+{
+	return __neigh_create(ipv4_neigh_table(dev_net(dev)), pkey, dev, false);
+}
+
+static inline struct neighbour *ipv4_neigh_lookup(struct net_device *dev,
+						  void *key)
+{
+	return neigh_lookup(ipv4_neigh_table(dev_net(dev)), key, dev);
+}
+
 static inline u32 arp_hashfn(const void *pkey, const struct net_device *dev, u32 *hash_rnd)
 {
 	u32 key = *(const u32 *)pkey;
@@ -23,7 +46,8 @@ static inline struct neighbour *__ipv4_neigh_lookup_noref(struct net_device *dev
 	if (dev->flags & (IFF_LOOPBACK | IFF_POINTOPOINT))
 		key = INADDR_ANY;
 
-	return ___neigh_lookup_noref(&arp_tbl, neigh_key_eq32, arp_hashfn, &key, dev);
+	return ___neigh_lookup_noref(ipv4_neigh_table(dev_net(dev)),
+				     neigh_key_eq32, arp_hashfn, &key, dev);
 }
 
 static inline struct neighbour *__ipv4_neigh_lookup(struct net_device *dev, u32 key)
-- 
2.11.0

