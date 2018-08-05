Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353F8C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 14:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D22921885
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 14:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D22921885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbeHEQfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 12:35:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37212 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726207AbeHEQfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 12:35:20 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 63A33510FCFB7;
        Sun,  5 Aug 2018 22:30:24 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.399.0; Sun, 5 Aug 2018 22:30:22 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>, <stephen@networkplumber.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] net/bridge/br_multicast: remove redundant variable "err"
Date:   Sun, 5 Aug 2018 22:18:43 +0800
Message-ID: <1533478723-18361-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The err is not used after initalization, So remove it and make
it void function.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 net/bridge/br_multicast.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 920665d..dc26c53 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1423,10 +1423,10 @@ static void br_multicast_query_received(struct net_bridge *br,
 	br_multicast_mark_router(br, port);
 }
 
-static int br_ip4_multicast_query(struct net_bridge *br,
-				  struct net_bridge_port *port,
-				  struct sk_buff *skb,
-				  u16 vid)
+static void br_ip4_multicast_query(struct net_bridge *br,
+				   struct net_bridge_port *port,
+				   struct sk_buff *skb,
+				   u16 vid)
 {
 	const struct iphdr *iph = ip_hdr(skb);
 	struct igmphdr *ih = igmp_hdr(skb);
@@ -1439,7 +1439,6 @@ static int br_ip4_multicast_query(struct net_bridge *br,
 	unsigned long now = jiffies;
 	unsigned int offset = skb_transport_offset(skb);
 	__be32 group;
-	int err = 0;
 
 	spin_lock(&br->multicast_lock);
 	if (!netif_running(br->dev) ||
@@ -1498,7 +1497,6 @@ static int br_ip4_multicast_query(struct net_bridge *br,
 
 out:
 	spin_unlock(&br->multicast_lock);
-	return err;
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -1797,7 +1795,7 @@ static int br_multicast_ipv4_rcv(struct net_bridge *br,
 	struct sk_buff *skb_trimmed = NULL;
 	const unsigned char *src;
 	struct igmphdr *ih;
-	int err;
+	int err = 0;
 
 	err = ip_mc_check_igmp(skb, &skb_trimmed);
 
@@ -1828,7 +1826,7 @@ static int br_multicast_ipv4_rcv(struct net_bridge *br,
 		err = br_ip4_multicast_igmp3_report(br, port, skb_trimmed, vid);
 		break;
 	case IGMP_HOST_MEMBERSHIP_QUERY:
-		err = br_ip4_multicast_query(br, port, skb_trimmed, vid);
+		br_ip4_multicast_query(br, port, skb_trimmed, vid);
 		break;
 	case IGMP_HOST_LEAVE_MESSAGE:
 		br_ip4_multicast_leave_group(br, port, ih->group, vid, src);
-- 
1.7.12.4

