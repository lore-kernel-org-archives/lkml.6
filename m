Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8062CECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384972146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zFI2ZD8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384972146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731640AbeGQMjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:39:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731540AbeGQMjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:39:08 -0400
Received: from kenny.it.cumulusnetworks.com. (fw.cumulusnetworks.com [216.129.126.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1C9C2147E;
        Tue, 17 Jul 2018 12:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531829208;
        bh=ezNXNvfCtBr5mcRLn7FsQH/TLeGEzNXlU37sdYu1LXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zFI2ZD8ovqYGaAP0KVzvrn9o9HvbbtJEp8pgslCrKNUQ5JvrTHHO08dMZWlO1Pcc8
         82dIukhsKwYX42NM/dicqYOAjt5P2mysrgz5fAvuI0SZcVNvchNZEfCunhMoZ9J8jk
         2FdzTbZsvInvAFSGLVgNmtOqt8urjSIhzGRShC/Y=
From:   dsahern@kernel.org
To:     netdev@vger.kernel.org
Cc:     nikita.leshchenko@oracle.com, roopa@cumulusnetworks.com,
        stephen@networkplumber.org, idosch@mellanox.com, jiri@mellanox.com,
        saeedm@mellanox.com, alex.aring@gmail.com,
        linux-wpan@vger.kernel.org, netfilter-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Ahern <dsahern@gmail.com>
Subject: [PATCH RFC/RFT net-next 08/17] net: Remove nd_tbl from ipv6 stub
Date:   Tue, 17 Jul 2018 05:06:42 -0700
Message-Id: <20180717120651.15748-9-dsahern@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180717120651.15748-1-dsahern@kernel.org>
References: <20180717120651.15748-1-dsahern@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>

Fixup last 2 users to nd_tbl entry of the stub and remove it.

Signed-off-by: David Ahern <dsahern@gmail.com>
---
 include/net/addrconf.h       | 1 -
 net/bridge/br_arp_nd_proxy.c | 2 +-
 net/core/filter.c            | 3 +--
 net/ipv6/af_inet6.c          | 1 -
 4 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 5f43f7a70fe6..3108e9d6a066 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -256,7 +256,6 @@ struct ipv6_stub {
 	void (*ndisc_send_na)(struct net_device *dev, const struct in6_addr *daddr,
 			      const struct in6_addr *solicited_addr,
 			      bool router, bool solicited, bool override, bool inc_opt);
-	struct neigh_table *nd_tbl;
 };
 extern const struct ipv6_stub *ipv6_stub __read_mostly;
 
diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 29a1e25fc169..9dd2a5dd721b 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -433,7 +433,7 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 		return;
 	}
 
-	n = neigh_lookup(ipv6_stub->nd_tbl, &msg->target, vlandev);
+	n = ipv6_neigh_lookup(vlandev, &msg->target);
 	if (n) {
 		struct net_bridge_fdb_entry *f;
 
diff --git a/net/core/filter.c b/net/core/filter.c
index b9ec916f4e3a..11d4af3886be 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4290,8 +4290,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	 * not needed here. Can not use __ipv6_neigh_lookup_noref here
 	 * because we need to get nd_tbl via the stub
 	 */
-	neigh = ___neigh_lookup_noref(ipv6_stub->nd_tbl, neigh_key_eq128,
-				      ndisc_hashfn, dst, dev);
+	neigh = ___ipv6_neigh_lookup_noref(dev, dst);
 	if (!neigh)
 		return BPF_FIB_LKUP_RET_NO_NEIGH;
 
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index c9535354149f..9e7d0f3d4edb 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -898,7 +898,6 @@ static const struct ipv6_stub ipv6_stub_impl = {
 	.ip6_mtu_from_fib6 = ip6_mtu_from_fib6,
 	.udpv6_encap_enable = udpv6_encap_enable,
 	.ndisc_send_na = ndisc_send_na,
-	.nd_tbl	= &nd_tbl,
 };
 
 static const struct ipv6_bpf_stub ipv6_bpf_stub_impl = {
-- 
2.11.0

