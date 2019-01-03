Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C856C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00F52073F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfACDUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 22:20:14 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:52392 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726136AbfACDUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 22:20:13 -0500
X-IronPort-AV: E=Sophos;i="5.56,433,1539619200"; 
   d="scan'208";a="51178885"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Jan 2019 11:20:11 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 667424B7D550;
        Thu,  3 Jan 2019 11:20:11 +0800 (CST)
Received: from ubuntu.g08.fujitsu.local (10.167.225.53) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 3 Jan 2019 11:20:18 +0800
From:   Su Yanjun <suyj.fnst@cn.fujitsu.com>
To:     <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>,
        <yoshfuji@linux-ipv6.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <suyj.fnst@cn.fujitsu.com>, <suyanjun218@gmail.com>
Subject: [PATCH] vti4: Fix a ipip packet processing bug in 'IPCOMP' virtual tunnel
Date:   Thu, 3 Jan 2019 07:48:41 -0500
Message-ID: <1546519721-30837-1-git-send-email-suyj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.53]
X-yoursite-MailScanner-ID: 667424B7D550.ACE21
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suyj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently we run a network test over ipcomp virtual tunnel.We find that
if a ipv4 packet needs fragment, then the peer can't receive
it.

We deep into the code and find that when packet need fragment the smaller
fragment will be encapsulated by ipip not ipcomp. So when the ipip packet
goes into xfrm, it's skb->dev is not properly set. The ipv4 reassembly code
always set skb'dev to the last fragment's dev. After ipv4 defrag processing,
when the kernel rp_filter parameter is set, the skb will be drop by -EXDEV
error.

This patch adds compatible support for the ipip process in ipcomp virtual tunnel.

Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
---
 net/ipv4/ip_vti.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index de31b30..63de2f6 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -65,6 +65,9 @@ static int vti_input(struct sk_buff *skb, int nexthdr, __be32 spi,
 
 		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 = tunnel;
 
+		if (iph->protocol == IPPROTO_IPIP)
+			skb->dev = tunnel->dev;
+
 		return xfrm_input(skb, nexthdr, spi, encap_type);
 	}
 
@@ -76,10 +79,15 @@ static int vti_input(struct sk_buff *skb, int nexthdr, __be32 spi,
 
 static int vti_rcv(struct sk_buff *skb)
 {
+	__be32 spi = 0;
+	
 	XFRM_SPI_SKB_CB(skb)->family = AF_INET;
 	XFRM_SPI_SKB_CB(skb)->daddroff = offsetof(struct iphdr, daddr);
+	
+	if (ip_hdr(skb)->protocol == IPPROTO_IPIP)
+		spi = ip_hdr(skb)->saddr;
 
-	return vti_input(skb, ip_hdr(skb)->protocol, 0, 0);
+	return vti_input(skb, ip_hdr(skb)->protocol, spi, 0);
 }
 
 static int vti_rcv_cb(struct sk_buff *skb, int err)
@@ -429,6 +437,12 @@ static struct xfrm4_protocol vti_ipcomp4_protocol __read_mostly = {
 	.priority	=	100,
 };
 
+static struct xfrm_tunnel ipip_handler __read_mostly = {
+	.handler	=	vti_rcv,
+	.err_handler	=	vti4_err,
+	.priority	=	0,
+};
+
 static int __net_init vti_init_net(struct net *net)
 {
 	int err;
@@ -597,6 +611,13 @@ static int __init vti_init(void)
 	if (err < 0)
 		goto xfrm_proto_comp_failed;
 
+	msg = "ipip tunnel";
+	err = xfrm4_tunnel_register(&ipip_handler, AF_INET);
+	if (err < 0) {
+		pr_info("%s: cant't register tunnel\n",__func__);
+		goto xfrm_tunnel_failed;
+	}
+
 	msg = "netlink interface";
 	err = rtnl_link_register(&vti_link_ops);
 	if (err < 0)
@@ -606,6 +627,8 @@ static int __init vti_init(void)
 
 rtnl_link_failed:
 	xfrm4_protocol_deregister(&vti_ipcomp4_protocol, IPPROTO_COMP);
+xfrm_tunnel_failed:
+	xfrm4_tunnel_deregister(&ipip_handler, AF_INET);
 xfrm_proto_comp_failed:
 	xfrm4_protocol_deregister(&vti_ah4_protocol, IPPROTO_AH);
 xfrm_proto_ah_failed:
-- 
2.7.4



