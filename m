Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C315C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E02820859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfAGCbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:31:55 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:43985 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726180AbfAGCby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 21:31:54 -0500
X-IronPort-AV: E=Sophos;i="5.56,449,1539619200"; 
   d="scan'208";a="51434766"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Jan 2019 10:31:49 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 273B34B7D68F;
        Mon,  7 Jan 2019 10:31:44 +0800 (CST)
Received: from ubuntu.g08.fujitsu.local (10.167.225.53) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 7 Jan 2019 10:31:47 +0800
From:   Su Yanjun <suyj.fnst@cn.fujitsu.com>
To:     <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>,
        <yoshfuji@linux-ipv6.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <suyj.fnst@cn.fujitsu.com>, <suyanjun218@gmail.com>
Subject: [PATCH v2] vti4: Fix a ipip packet processing bug in 'IPCOMP' virtual tunnel
Date:   Sun, 6 Jan 2019 21:31:20 -0500
Message-ID: <1546828280-26039-1-git-send-email-suyj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.53]
X-yoursite-MailScanner-ID: 273B34B7D68F.ADDC2
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
Based on Linus' master branch.

Changes from v1:
- use a separate handler for ipip packet processing in ipcomp virtual tunnel

 net/ipv4/ip_vti.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index de31b30..d155a51 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -74,6 +74,33 @@ static int vti_input(struct sk_buff *skb, int nexthdr, __be32 spi,
 	return 0;
 }
 
+static int vti_input_ipip(struct sk_buff *skb, int nexthdr, __be32 spi,
+		     int encap_type)
+{
+	struct ip_tunnel *tunnel;
+	const struct iphdr *iph = ip_hdr(skb);
+	struct net *net = dev_net(skb->dev);
+	struct ip_tunnel_net *itn = net_generic(net, vti_net_id);
+
+	tunnel = ip_tunnel_lookup(itn, skb->dev->ifindex, TUNNEL_NO_KEY,
+				  iph->saddr, iph->daddr, 0);
+	if (tunnel) {
+		if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb))
+			goto drop;
+
+		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 = tunnel;
+
+		skb->dev = tunnel->dev;
+
+		return xfrm_input(skb, nexthdr, spi, encap_type);
+	}
+
+	return -EINVAL;
+drop:
+	kfree_skb(skb);
+	return 0;
+}
+
 static int vti_rcv(struct sk_buff *skb)
 {
 	XFRM_SPI_SKB_CB(skb)->family = AF_INET;
@@ -82,6 +109,14 @@ static int vti_rcv(struct sk_buff *skb)
 	return vti_input(skb, ip_hdr(skb)->protocol, 0, 0);
 }
 
+static int vti_rcv_ipip(struct sk_buff *skb)
+{
+	XFRM_SPI_SKB_CB(skb)->family = AF_INET;
+	XFRM_SPI_SKB_CB(skb)->daddroff = offsetof(struct iphdr, daddr);
+
+	return vti_input_ipip(skb, ip_hdr(skb)->protocol, ip_hdr(skb)->saddr, 0);
+}
+
 static int vti_rcv_cb(struct sk_buff *skb, int err)
 {
 	unsigned short family;
@@ -429,6 +464,12 @@ static struct xfrm4_protocol vti_ipcomp4_protocol __read_mostly = {
 	.priority	=	100,
 };
 
+static struct xfrm_tunnel ipip_handler __read_mostly = {
+	.handler	=	vti_rcv_ipip,
+	.err_handler	=	vti4_err,
+	.priority	=	0,
+};
+
 static int __net_init vti_init_net(struct net *net)
 {
 	int err;
@@ -597,6 +638,13 @@ static int __init vti_init(void)
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
@@ -606,6 +654,8 @@ static int __init vti_init(void)
 
 rtnl_link_failed:
 	xfrm4_protocol_deregister(&vti_ipcomp4_protocol, IPPROTO_COMP);
+xfrm_tunnel_failed:
+	xfrm4_tunnel_deregister(&ipip_handler, AF_INET);
 xfrm_proto_comp_failed:
 	xfrm4_protocol_deregister(&vti_ah4_protocol, IPPROTO_AH);
 xfrm_proto_ah_failed:
-- 
2.7.4



