Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342B8ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE43206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE43206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389749AbeGTN2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:28:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49868 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbeGTN2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:28:23 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9463ECEE;
        Fri, 20 Jul 2018 12:36:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        Stefano Brivio <sbrivio@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 017/101] net: fix use-after-free in GRO with ESP
Date:   Fri, 20 Jul 2018 14:13:23 +0200
Message-Id: <20180720121423.681819617@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 603d4cf8fe095b1ee78f423d514427be507fb513 ]

Since the addition of GRO for ESP, gro_receive can consume the skb and
return -EINPROGRESS. In that case, the lower layer GRO handler cannot
touch the skb anymore.

Commit 5f114163f2f5 ("net: Add a skb_gro_flush_final helper.") converted
some of the gro_receive handlers that can lead to ESP's gro_receive so
that they wouldn't access the skb when -EINPROGRESS is returned, but
missed other spots, mainly in tunneling protocols.

This patch finishes the conversion to using skb_gro_flush_final(), and
adds a new helper, skb_gro_flush_final_remcsum(), used in VXLAN and
GUE.

Fixes: 5f114163f2f5 ("net: Add a skb_gro_flush_final helper.")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/geneve.c      |    2 +-
 drivers/net/vxlan.c       |    4 +---
 include/linux/netdevice.h |   20 ++++++++++++++++++++
 net/8021q/vlan.c          |    2 +-
 net/ipv4/fou.c            |    4 +---
 net/ipv4/gre_offload.c    |    2 +-
 net/ipv4/udp_offload.c    |    2 +-
 7 files changed, 26 insertions(+), 10 deletions(-)

--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -474,7 +474,7 @@ static struct sk_buff **geneve_gro_recei
 out_unlock:
 	rcu_read_unlock();
 out:
-	NAPI_GRO_CB(skb)->flush |= flush;
+	skb_gro_flush_final(skb, pp, flush);
 
 	return pp;
 }
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -623,9 +623,7 @@ static struct sk_buff **vxlan_gro_receiv
 	flush = 0;
 
 out:
-	skb_gro_remcsum_cleanup(skb, &grc);
-	skb->remcsum_offload = 0;
-	NAPI_GRO_CB(skb)->flush |= flush;
+	skb_gro_flush_final_remcsum(skb, pp, flush, &grc);
 
 	return pp;
 }
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2735,11 +2735,31 @@ static inline void skb_gro_flush_final(s
 	if (PTR_ERR(pp) != -EINPROGRESS)
 		NAPI_GRO_CB(skb)->flush |= flush;
 }
+static inline void skb_gro_flush_final_remcsum(struct sk_buff *skb,
+					       struct sk_buff **pp,
+					       int flush,
+					       struct gro_remcsum *grc)
+{
+	if (PTR_ERR(pp) != -EINPROGRESS) {
+		NAPI_GRO_CB(skb)->flush |= flush;
+		skb_gro_remcsum_cleanup(skb, grc);
+		skb->remcsum_offload = 0;
+	}
+}
 #else
 static inline void skb_gro_flush_final(struct sk_buff *skb, struct sk_buff **pp, int flush)
 {
 	NAPI_GRO_CB(skb)->flush |= flush;
 }
+static inline void skb_gro_flush_final_remcsum(struct sk_buff *skb,
+					       struct sk_buff **pp,
+					       int flush,
+					       struct gro_remcsum *grc)
+{
+	NAPI_GRO_CB(skb)->flush |= flush;
+	skb_gro_remcsum_cleanup(skb, grc);
+	skb->remcsum_offload = 0;
+}
 #endif
 
 static inline int dev_hard_header(struct sk_buff *skb, struct net_device *dev,
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -688,7 +688,7 @@ static struct sk_buff **vlan_gro_receive
 out_unlock:
 	rcu_read_unlock();
 out:
-	NAPI_GRO_CB(skb)->flush |= flush;
+	skb_gro_flush_final(skb, pp, flush);
 
 	return pp;
 }
--- a/net/ipv4/fou.c
+++ b/net/ipv4/fou.c
@@ -448,9 +448,7 @@ next_proto:
 out_unlock:
 	rcu_read_unlock();
 out:
-	NAPI_GRO_CB(skb)->flush |= flush;
-	skb_gro_remcsum_cleanup(skb, &grc);
-	skb->remcsum_offload = 0;
+	skb_gro_flush_final_remcsum(skb, pp, flush, &grc);
 
 	return pp;
 }
--- a/net/ipv4/gre_offload.c
+++ b/net/ipv4/gre_offload.c
@@ -223,7 +223,7 @@ static struct sk_buff **gre_gro_receive(
 out_unlock:
 	rcu_read_unlock();
 out:
-	NAPI_GRO_CB(skb)->flush |= flush;
+	skb_gro_flush_final(skb, pp, flush);
 
 	return pp;
 }
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -295,7 +295,7 @@ unflush:
 out_unlock:
 	rcu_read_unlock();
 out:
-	NAPI_GRO_CB(skb)->flush |= flush;
+	skb_gro_flush_final(skb, pp, flush);
 	return pp;
 }
 EXPORT_SYMBOL(udp_gro_receive);


