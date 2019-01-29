Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC690C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B00A214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762183;
	bh=Yet7FJNEhCRy/fZ5vFRKss+R9yQMpzurNylOT5qOqZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bNwo46ukKFdurHkcQs7TztKZwcKuM7BJZ5tyZNNdotsTUPSfAyp8SukjaV+CyMYev
	 Wv9/N5PPdiPPlFs6cgZTVOxhIvmz3XWeViRmXfV4ycFO/ZRIm15au9kzH0za7ndJAK
	 vA/NEdoyEx9W9f9ExZ3iz5jtHOzbLHmNjR5D8SBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbfA2LnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:43:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:60956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729546AbfA2Lm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:42:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42B9E20857;
        Tue, 29 Jan 2019 11:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762177;
        bh=Yet7FJNEhCRy/fZ5vFRKss+R9yQMpzurNylOT5qOqZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fLNMP45txVCm7SqVHQ3kYUwWhYMBVZacmtvxnSyKD1hlYeOmD1clwsR+DmjkgfKzc
         GWTyKD1kEoWwWs7qqI6n+JlL48dkKPwsxCgvm4IVB9BIIyQhZLYwD6HjpsV47ciTlS
         /hJ9YglP6Oo+Jt+JqihdLApF68Xn6+rHXG2zosZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 018/103] erspan: build the header with the right proto according to erspan_ver
Date:   Tue, 29 Jan 2019 12:34:55 +0100
Message-Id: <20190129113200.616238957@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 20704bd1633dd5afb29a321d3a615c9c8e9c9d05 ]

As said in draft-foschiano-erspan-03#section4:

   Different frame variants known as "ERSPAN Types" can be
   distinguished based on the GRE "Protocol Type" field value: Type I
   and II's value is 0x88BE while Type III's is 0x22EB [ETYPES].

So set it properly in erspan_xmit() according to erspan_ver. While at
it, also remove the unused parameter 'proto' in erspan_fb_xmit().

Fixes: 94d7d8f29287 ("ip6_gre: add erspan v2 support")
Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_gre.c  |   23 ++++++++++++++---------
 net/ipv6/ip6_gre.c |    6 ++++--
 2 files changed, 18 insertions(+), 11 deletions(-)

--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -570,8 +570,7 @@ err_free_skb:
 	dev->stats.tx_dropped++;
 }
 
-static void erspan_fb_xmit(struct sk_buff *skb, struct net_device *dev,
-			   __be16 proto)
+static void erspan_fb_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	struct ip_tunnel_info *tun_info;
@@ -579,10 +578,10 @@ static void erspan_fb_xmit(struct sk_buf
 	struct erspan_metadata *md;
 	struct rtable *rt = NULL;
 	bool truncate = false;
+	__be16 df, proto;
 	struct flowi4 fl;
 	int tunnel_hlen;
 	int version;
-	__be16 df;
 	int nhoff;
 	int thoff;
 
@@ -627,18 +626,20 @@ static void erspan_fb_xmit(struct sk_buf
 	if (version == 1) {
 		erspan_build_header(skb, ntohl(tunnel_id_to_key32(key->tun_id)),
 				    ntohl(md->u.index), truncate, true);
+		proto = htons(ETH_P_ERSPAN);
 	} else if (version == 2) {
 		erspan_build_header_v2(skb,
 				       ntohl(tunnel_id_to_key32(key->tun_id)),
 				       md->u.md2.dir,
 				       get_hwid(&md->u.md2),
 				       truncate, true);
+		proto = htons(ETH_P_ERSPAN2);
 	} else {
 		goto err_free_rt;
 	}
 
 	gre_build_header(skb, 8, TUNNEL_SEQ,
-			 htons(ETH_P_ERSPAN), 0, htonl(tunnel->o_seqno++));
+			 proto, 0, htonl(tunnel->o_seqno++));
 
 	df = key->tun_flags & TUNNEL_DONT_FRAGMENT ?  htons(IP_DF) : 0;
 
@@ -722,12 +723,13 @@ static netdev_tx_t erspan_xmit(struct sk
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	bool truncate = false;
+	__be16 proto;
 
 	if (!pskb_inet_may_pull(skb))
 		goto free_skb;
 
 	if (tunnel->collect_md) {
-		erspan_fb_xmit(skb, dev, skb->protocol);
+		erspan_fb_xmit(skb, dev);
 		return NETDEV_TX_OK;
 	}
 
@@ -743,19 +745,22 @@ static netdev_tx_t erspan_xmit(struct sk
 	}
 
 	/* Push ERSPAN header */
-	if (tunnel->erspan_ver == 1)
+	if (tunnel->erspan_ver == 1) {
 		erspan_build_header(skb, ntohl(tunnel->parms.o_key),
 				    tunnel->index,
 				    truncate, true);
-	else if (tunnel->erspan_ver == 2)
+		proto = htons(ETH_P_ERSPAN);
+	} else if (tunnel->erspan_ver == 2) {
 		erspan_build_header_v2(skb, ntohl(tunnel->parms.o_key),
 				       tunnel->dir, tunnel->hwid,
 				       truncate, true);
-	else
+		proto = htons(ETH_P_ERSPAN2);
+	} else {
 		goto free_skb;
+	}
 
 	tunnel->parms.o_flags &= ~TUNNEL_KEY;
-	__gre_xmit(skb, dev, &tunnel->parms.iph, htons(ETH_P_ERSPAN));
+	__gre_xmit(skb, dev, &tunnel->parms.iph, proto);
 	return NETDEV_TX_OK;
 
 free_skb:
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -938,6 +938,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit
 	__u8 dsfield = false;
 	struct flowi6 fl6;
 	int err = -EINVAL;
+	__be16 proto;
 	__u32 mtu;
 	int nhoff;
 	int thoff;
@@ -1051,8 +1052,9 @@ static netdev_tx_t ip6erspan_tunnel_xmit
 	}
 
 	/* Push GRE header. */
-	gre_build_header(skb, 8, TUNNEL_SEQ,
-			 htons(ETH_P_ERSPAN), 0, htonl(t->o_seqno++));
+	proto = (t->parms.erspan_ver == 1) ? htons(ETH_P_ERSPAN)
+					   : htons(ETH_P_ERSPAN2);
+	gre_build_header(skb, 8, TUNNEL_SEQ, proto, 0, htonl(t->o_seqno++));
 
 	/* TooBig packet may have updated dst->dev's mtu */
 	if (!t->parms.collect_md && dst && dst_mtu(dst) > dst->dev->mtu)


