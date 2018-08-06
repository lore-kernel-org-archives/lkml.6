Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0DEC46470
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806FC218FC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806FC218FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeHFF0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 01:26:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56043 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727217AbeHFF0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 01:26:07 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AB843B88C54A6;
        Mon,  6 Aug 2018 11:19:03 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Mon, 6 Aug 2018 11:19:02 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>, <stephen@networkplumber.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] net/bridge/br_multicast: remove redundant variable "err"
Date:   Mon, 6 Aug 2018 11:07:23 +0800
Message-ID: <1533524843-51236-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The err is not modified after initalization, So remove it and make
it to be void function.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
v1->v2:
 -  The initalization of err  to '0' is unnecesary. so drop the change

 net/bridge/br_multicast.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 920665d..20ed7ad 100644
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

