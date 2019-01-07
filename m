Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A79EC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507A92089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864461;
	bh=CZHeM2TbDE8shUOdwMdIGJBjsEBHpHrQXEe7/tdE0/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NHMPlOjOBIj2GEIMbfUsO5AGKrGwjI48MIY62DMcEA5lW7GmWwzI+yhuPvcLpOImQ
	 LsUCQhG3WSgGOhODL9U75cedvgi6VgWVM4n1n49d+cdOnCUOITysitbM0yeA02bxNZ
	 61vrdNVjAjST4jdNUNNrei+gQz1cGlyXy0pSCSqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfAGMeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:34:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbfAGMeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:34:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9152F2147C;
        Mon,  7 Jan 2019 12:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864456;
        bh=CZHeM2TbDE8shUOdwMdIGJBjsEBHpHrQXEe7/tdE0/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JqLCZ77WdDabdaqV6Iq7oTyOR2VGWbqbhvIpKdDZS55QbLtXtABOv2YpYkSv1pzTR
         uFdfQKYY1MDqlKH0dnvjVeeKAHrDQWZNtDaUbNEiG5HErdQ0Y8dXeePmHAngBVFtaQ
         /IqiG1MTGRkNGmChiCKf5ufeck5Q1guWhhyrvkO4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 009/145] ip: validate header length on virtual device xmit
Date:   Mon,  7 Jan 2019 13:30:46 +0100
Message-Id: <20190107104438.533894989@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit cb9f1b783850b14cbd7f87d061d784a666dfba1f ]

KMSAN detected read beyond end of buffer in vti and sit devices when
passing truncated packets with PF_PACKET. The issue affects additional
ip tunnel devices.

Extend commit 76c0ddd8c3a6 ("ip6_tunnel: be careful when accessing the
inner header") and commit ccfec9e5cb2d ("ip_tunnel: be careful when
accessing the inner header").

Move the check to a separate helper and call at the start of each
ndo_start_xmit function in net/ipv4 and net/ipv6.

Minor changes:
- convert dev_kfree_skb to kfree_skb on error path,
  as dev_kfree_skb calls consume_skb which is not for error paths.
- use pskb_network_may_pull even though that is pedantic here,
  as the same as pskb_may_pull for devices without llheaders.
- do not cache ipv6 hdrs if used only once
  (unsafe across pskb_may_pull, was more relevant to earlier patch)

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/ip_tunnels.h |   20 ++++++++++++++++++++
 net/ipv4/ip_gre.c        |    9 +++++++++
 net/ipv4/ip_tunnel.c     |    9 ---------
 net/ipv4/ip_vti.c        |   12 +++++++++---
 net/ipv6/ip6_gre.c       |   10 +++++++---
 net/ipv6/ip6_tunnel.c    |   10 +++-------
 net/ipv6/ip6_vti.c       |    8 ++++----
 net/ipv6/ip6mr.c         |   17 +++++++++++------
 net/ipv6/sit.c           |    3 +++
 9 files changed, 66 insertions(+), 32 deletions(-)

--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -307,6 +307,26 @@ int ip_tunnel_encap_del_ops(const struct
 int ip_tunnel_encap_setup(struct ip_tunnel *t,
 			  struct ip_tunnel_encap *ipencap);
 
+static inline bool pskb_inet_may_pull(struct sk_buff *skb)
+{
+	int nhlen;
+
+	switch (skb->protocol) {
+#if IS_ENABLED(CONFIG_IPV6)
+	case htons(ETH_P_IPV6):
+		nhlen = sizeof(struct ipv6hdr);
+		break;
+#endif
+	case htons(ETH_P_IP):
+		nhlen = sizeof(struct iphdr);
+		break;
+	default:
+		nhlen = 0;
+	}
+
+	return pskb_network_may_pull(skb, nhlen);
+}
+
 static inline int ip_encap_hlen(struct ip_tunnel_encap *e)
 {
 	const struct ip_tunnel_encap_ops *ops;
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -674,6 +674,9 @@ static netdev_tx_t ipgre_xmit(struct sk_
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	const struct iphdr *tnl_params;
 
+	if (!pskb_inet_may_pull(skb))
+		goto free_skb;
+
 	if (tunnel->collect_md) {
 		gre_fb_xmit(skb, dev, skb->protocol);
 		return NETDEV_TX_OK;
@@ -717,6 +720,9 @@ static netdev_tx_t erspan_xmit(struct sk
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	bool truncate = false;
 
+	if (!pskb_inet_may_pull(skb))
+		goto free_skb;
+
 	if (tunnel->collect_md) {
 		erspan_fb_xmit(skb, dev, skb->protocol);
 		return NETDEV_TX_OK;
@@ -760,6 +766,9 @@ static netdev_tx_t gre_tap_xmit(struct s
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 
+	if (!pskb_inet_may_pull(skb))
+		goto free_skb;
+
 	if (tunnel->collect_md) {
 		gre_fb_xmit(skb, dev, htons(ETH_P_TEB));
 		return NETDEV_TX_OK;
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -627,7 +627,6 @@ void ip_tunnel_xmit(struct sk_buff *skb,
 		    const struct iphdr *tnl_params, u8 protocol)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
-	unsigned int inner_nhdr_len = 0;
 	const struct iphdr *inner_iph;
 	struct flowi4 fl4;
 	u8     tos, ttl;
@@ -637,14 +636,6 @@ void ip_tunnel_xmit(struct sk_buff *skb,
 	__be32 dst;
 	bool connected;
 
-	/* ensure we can access the inner net header, for several users below */
-	if (skb->protocol == htons(ETH_P_IP))
-		inner_nhdr_len = sizeof(struct iphdr);
-	else if (skb->protocol == htons(ETH_P_IPV6))
-		inner_nhdr_len = sizeof(struct ipv6hdr);
-	if (unlikely(!pskb_may_pull(skb, inner_nhdr_len)))
-		goto tx_error;
-
 	inner_iph = (const struct iphdr *)skb_inner_network_header(skb);
 	connected = (tunnel->parms.iph.daddr != 0);
 
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -241,6 +241,9 @@ static netdev_tx_t vti_tunnel_xmit(struc
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	struct flowi fl;
 
+	if (!pskb_inet_may_pull(skb))
+		goto tx_err;
+
 	memset(&fl, 0, sizeof(fl));
 
 	switch (skb->protocol) {
@@ -253,15 +256,18 @@ static netdev_tx_t vti_tunnel_xmit(struc
 		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
 		break;
 	default:
-		dev->stats.tx_errors++;
-		dev_kfree_skb(skb);
-		return NETDEV_TX_OK;
+		goto tx_err;
 	}
 
 	/* override mark with tunnel output key */
 	fl.flowi_mark = be32_to_cpu(tunnel->parms.o_key);
 
 	return vti_xmit(skb, dev, &fl);
+
+tx_err:
+	dev->stats.tx_errors++;
+	kfree_skb(skb);
+	return NETDEV_TX_OK;
 }
 
 static int vti4_err(struct sk_buff *skb, u32 info)
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -879,6 +879,9 @@ static netdev_tx_t ip6gre_tunnel_xmit(st
 	struct net_device_stats *stats = &t->dev->stats;
 	int ret;
 
+	if (!pskb_inet_may_pull(skb))
+		goto tx_err;
+
 	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
 		goto tx_err;
 
@@ -921,6 +924,9 @@ static netdev_tx_t ip6erspan_tunnel_xmit
 	int nhoff;
 	int thoff;
 
+	if (!pskb_inet_may_pull(skb))
+		goto tx_err;
+
 	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
 		goto tx_err;
 
@@ -993,8 +999,6 @@ static netdev_tx_t ip6erspan_tunnel_xmit
 			goto tx_err;
 		}
 	} else {
-		struct ipv6hdr *ipv6h = ipv6_hdr(skb);
-
 		switch (skb->protocol) {
 		case htons(ETH_P_IP):
 			memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
@@ -1002,7 +1006,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit
 						 &dsfield, &encap_limit);
 			break;
 		case htons(ETH_P_IPV6):
-			if (ipv6_addr_equal(&t->parms.raddr, &ipv6h->saddr))
+			if (ipv6_addr_equal(&t->parms.raddr, &ipv6_hdr(skb)->saddr))
 				goto tx_err;
 			if (prepare_ip6gre_xmit_ipv6(skb, dev, &fl6,
 						     &dsfield, &encap_limit))
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1243,10 +1243,6 @@ ip4ip6_tnl_xmit(struct sk_buff *skb, str
 	u8 tproto;
 	int err;
 
-	/* ensure we can access the full inner ip header */
-	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
-		return -1;
-
 	iph = ip_hdr(skb);
 	memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
 
@@ -1321,9 +1317,6 @@ ip6ip6_tnl_xmit(struct sk_buff *skb, str
 	u8 tproto;
 	int err;
 
-	if (unlikely(!pskb_may_pull(skb, sizeof(*ipv6h))))
-		return -1;
-
 	ipv6h = ipv6_hdr(skb);
 	tproto = READ_ONCE(t->parms.proto);
 	if ((tproto != IPPROTO_IPV6 && tproto != 0) ||
@@ -1405,6 +1398,9 @@ ip6_tnl_start_xmit(struct sk_buff *skb,
 	struct net_device_stats *stats = &t->dev->stats;
 	int ret;
 
+	if (!pskb_inet_may_pull(skb))
+		goto tx_err;
+
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
 		ret = ip4ip6_tnl_xmit(skb, dev);
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -522,18 +522,18 @@ vti6_tnl_xmit(struct sk_buff *skb, struc
 {
 	struct ip6_tnl *t = netdev_priv(dev);
 	struct net_device_stats *stats = &t->dev->stats;
-	struct ipv6hdr *ipv6h;
 	struct flowi fl;
 	int ret;
 
+	if (!pskb_inet_may_pull(skb))
+		goto tx_err;
+
 	memset(&fl, 0, sizeof(fl));
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IPV6):
-		ipv6h = ipv6_hdr(skb);
-
 		if ((t->parms.proto != IPPROTO_IPV6 && t->parms.proto != 0) ||
-		    vti6_addr_conflict(t, ipv6h))
+		    vti6_addr_conflict(t, ipv6_hdr(skb)))
 			goto tx_err;
 
 		xfrm_decode_session(skb, &fl, AF_INET6);
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -51,6 +51,7 @@
 #include <linux/export.h>
 #include <net/ip6_checksum.h>
 #include <linux/netconf.h>
+#include <net/ip_tunnels.h>
 
 #include <linux/nospec.h>
 
@@ -599,13 +600,12 @@ static netdev_tx_t reg_vif_xmit(struct s
 		.flowi6_iif	= skb->skb_iif ? : LOOPBACK_IFINDEX,
 		.flowi6_mark	= skb->mark,
 	};
-	int err;
 
-	err = ip6mr_fib_lookup(net, &fl6, &mrt);
-	if (err < 0) {
-		kfree_skb(skb);
-		return err;
-	}
+	if (!pskb_inet_may_pull(skb))
+		goto tx_err;
+
+	if (ip6mr_fib_lookup(net, &fl6, &mrt) < 0)
+		goto tx_err;
 
 	read_lock(&mrt_lock);
 	dev->stats.tx_bytes += skb->len;
@@ -614,6 +614,11 @@ static netdev_tx_t reg_vif_xmit(struct s
 	read_unlock(&mrt_lock);
 	kfree_skb(skb);
 	return NETDEV_TX_OK;
+
+tx_err:
+	dev->stats.tx_errors++;
+	kfree_skb(skb);
+	return NETDEV_TX_OK;
 }
 
 static int reg_vif_get_iflink(const struct net_device *dev)
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1021,6 +1021,9 @@ tx_error:
 static netdev_tx_t sit_tunnel_xmit(struct sk_buff *skb,
 				   struct net_device *dev)
 {
+	if (!pskb_inet_may_pull(skb))
+		goto tx_err;
+
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
 		sit_tunnel_xmit__(skb, dev, IPPROTO_IPIP);


