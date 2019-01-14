Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF41CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE202086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfYoEfFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfANKKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:10:15 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42523 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfANKKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:10:15 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so10122429pfr.9;
        Mon, 14 Jan 2019 02:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RuLTi3Pphu9Sazu10yaidHBBzdJ1XeAHxFxDO0J0aak=;
        b=gfYoEfFe+sY8XgxwqBGeK/OvpzO2FzI3afju04igCtH4FZdZL1T6iXTkANaBTXTVdz
         rxQhp9tGdybJTrbbdmjR1D2V2YGhEN1ixudH5J9BSaTL/8DGpO9i5KdQRPvyFmSvonQI
         MKnj56Jy0uj+fwjHBVAVYWcaP/Xun+q4l7ssyAT+gq5wU7iZ3AGxR3qRhItU8x0/MlBQ
         zxKxlOPIPw5Kt21Uu9Nj3OjEuu/nntRYnQ4cBKScD9Fcwi9PKyJWDekSR+ZcN4pr/0JS
         a9UfjcgsNH5w/Ccnixn1/lcNLjIs9bJOgMv6p6ezpK/ZBSXJ9uCnB1T/oUq9Gfes823n
         YZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RuLTi3Pphu9Sazu10yaidHBBzdJ1XeAHxFxDO0J0aak=;
        b=RpjNeO0yGz4kInF0kwix+YxEt3AeNORdB08j6HPvOqwxXT8u2Cfq5lwng4dNZzH/0a
         HfWq0WCGqvcmjawtQO2iB3l8w3i2YrHf2kAiCL5dp+70aUa44bWubLr5cXvfLJheqaLa
         RRHx4zpfDo91gfHcVXtvRgtdOk9EU5mUuJZjT+OPmDPI/OFT01SHRxyMLRlzNYG26+gQ
         ulJozTBU8uxvYbdUgZZsy7udYa142Xajs90JWE7kQmo4Hd4ALwhWymVpqGX2w6YcvrlH
         NrZfArsKH3X3dqlKEuDFUWLWsWRKPRtZ4AWI81SonN6kX+XYSkUzhSqMqAjW7GWV5GMk
         /bIA==
X-Gm-Message-State: AJcUukeW69hIsMUun2T4hXutldbokNSbfTs29RmRg1yVTkGPZxitjxbT
        sSrxgd6azwW82n6PVXt2Qc99c34g
X-Google-Smtp-Source: ALg8bN5NJ8D3imBUs2CcwMri10yUq9c2qYVYt72nyPDapEKnwqyWrAaf3DiaWcxmtCjWustd/8h4Lg==
X-Received: by 2002:a63:2784:: with SMTP id n126mr22535690pgn.48.1547460614222;
        Mon, 14 Jan 2019 02:10:14 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v9sm124571654pfg.144.2019.01.14.02.10.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 02:10:13 -0800 (PST)
From:   Xin Long <lucien.xin@gmail.com>
To:     linux-kernel@vger.kernel.org, network dev <netdev@vger.kernel.org>
Cc:     davem@davemloft.net, William Tu <u9012063@gmail.com>
Subject: [PATCH net] erspan: build the header with the right proto according to erspan_ver
Date:   Mon, 14 Jan 2019 18:10:06 +0800
Message-Id: <ae6a0efc813739ab1f9179f2ec8036285193dba9.1547460606.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As said in draft-foschiano-erspan-03#section4:

   Different frame variants known as "ERSPAN Types" can be
   distinguished based on the GRE "Protocol Type" field value: Type I
   and II's value is 0x88BE while Type III's is 0x22EB [ETYPES].

So set it properly in erspan_xmit() according to erspan_ver. While at
it, also remove the unused parameter 'proto' in erspan_fb_xmit().

Fixes: 94d7d8f29287 ("ip6_gre: add erspan v2 support")
Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/ipv4/ip_gre.c  | 23 ++++++++++++++---------
 net/ipv6/ip6_gre.c |  6 ++++--
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index d1d09f3..b1a74d8 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -569,8 +569,7 @@ static void gre_fb_xmit(struct sk_buff *skb, struct net_device *dev,
 	dev->stats.tx_dropped++;
 }
 
-static void erspan_fb_xmit(struct sk_buff *skb, struct net_device *dev,
-			   __be16 proto)
+static void erspan_fb_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	struct ip_tunnel_info *tun_info;
@@ -578,10 +577,10 @@ static void erspan_fb_xmit(struct sk_buff *skb, struct net_device *dev,
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
 
@@ -626,18 +625,20 @@ static void erspan_fb_xmit(struct sk_buff *skb, struct net_device *dev,
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
 
@@ -721,12 +722,13 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
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
 
@@ -742,19 +744,22 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
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
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 09d0826..12772d4 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -922,6 +922,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	__u8 dsfield = false;
 	struct flowi6 fl6;
 	int err = -EINVAL;
+	__be16 proto;
 	__u32 mtu;
 	int nhoff;
 	int thoff;
@@ -1035,8 +1036,9 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	}
 
 	/* Push GRE header. */
-	gre_build_header(skb, 8, TUNNEL_SEQ,
-			 htons(ETH_P_ERSPAN), 0, htonl(t->o_seqno++));
+	proto = (t->parms.erspan_ver == 1) ? htons(ETH_P_ERSPAN)
+					   : htons(ETH_P_ERSPAN2);
+	gre_build_header(skb, 8, TUNNEL_SEQ, proto, 0, htonl(t->o_seqno++));
 
 	/* TooBig packet may have updated dst->dev's mtu */
 	if (!t->parms.collect_md && dst && dst_mtu(dst) > dst->dev->mtu)
-- 
2.1.0

