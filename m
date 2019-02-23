Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27A4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC7920861
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956303;
	bh=bhHDPdahz56rG0U/R9Al0Br1Dh2aSekx8q5qFbVbLIc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DMcQQw1Kss8jamRgBzLFt7yEaQj0Cx0lh80ZjxclKD+JKnPMjGQUwfNa2Ldpz7r9O
	 vo/rhMm6ilq0V818iyVkfsEPm3RaIbjhb4GfKeu1LAd0FHTFTTF1h47xlJZXSPom/Y
	 zlmZdMuEEIPTmuEbM3Hsht1juUiIfu83zV6CjSY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbfBWVLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:11:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:48198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729395AbfBWVLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:11:38 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A96E2085A;
        Sat, 23 Feb 2019 21:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956297;
        bh=bhHDPdahz56rG0U/R9Al0Br1Dh2aSekx8q5qFbVbLIc=;
        h=From:To:Cc:Subject:Date:From;
        b=QN7ql99DWPFBtymxeZ3oTVMqbBs/JVrRssfpjjFTSO7Juo883QsT3zvhDQ7V1hN1m
         bkEXq7vXPTxLkGyNmYBhdDAiQ2u5c8FmZo1dfQanZPqeyN60jGiS9ACRrVb4usK1vS
         nkZ5uEIsHx9lJyTviHAuPPRhLkTBCbA+nLULSaV4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Su Yanjun <suyj.fnst@cn.fujitsu.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 01/18] vti4: Fix a ipip packet processing bug in 'IPCOMP' virtual tunnel
Date:   Sat, 23 Feb 2019 16:11:18 -0500
Message-Id: <20190223211135.203082-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Su Yanjun <suyj.fnst@cn.fujitsu.com>

[ Upstream commit dd9ee3444014e8f28c0eefc9fffc9ac9c5248c12 ]

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
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ip_vti.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index c35e0aa57e66c..e224ca2ea1c06 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -75,6 +75,33 @@ static int vti_input(struct sk_buff *skb, int nexthdr, __be32 spi,
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
@@ -83,6 +110,14 @@ static int vti_rcv(struct sk_buff *skb)
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
@@ -409,6 +444,12 @@ static struct xfrm4_protocol vti_ipcomp4_protocol __read_mostly = {
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
@@ -562,6 +603,13 @@ static int __init vti_init(void)
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
@@ -571,6 +619,8 @@ static int __init vti_init(void)
 
 rtnl_link_failed:
 	xfrm4_protocol_deregister(&vti_ipcomp4_protocol, IPPROTO_COMP);
+xfrm_tunnel_failed:
+	xfrm4_tunnel_deregister(&ipip_handler, AF_INET);
 xfrm_proto_comp_failed:
 	xfrm4_protocol_deregister(&vti_ah4_protocol, IPPROTO_AH);
 xfrm_proto_ah_failed:
-- 
2.19.1

