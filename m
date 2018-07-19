Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8350CC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CB320671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16CB320671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeGSKAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:00:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36727 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726857AbeGSKAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:00:53 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9BCFCC4F65321;
        Thu, 19 Jul 2018 17:18:35 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.382.0; Thu, 19 Jul 2018
 17:18:28 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <jon.maloy@ericsson.com>,
        <ying.xue@windriver.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <tipc-discussion@lists.sourceforge.net>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] tipc: make some functions static
Date:   Thu, 19 Jul 2018 17:16:59 +0800
Message-ID: <20180719091659.20248-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following sparse warnings:

net/tipc/link.c:376:5: warning: symbol 'link_bc_rcv_gap' was not declared. Should it be static?
net/tipc/link.c:823:6: warning: symbol 'link_prepare_wakeup' was not declared. Should it be static?
net/tipc/link.c:959:6: warning: symbol 'tipc_link_advance_backlog' was not declared. Should it be static?
net/tipc/link.c:1009:5: warning: symbol 'tipc_link_retrans' was not declared. Should it be static?
net/tipc/monitor.c:687:5: warning: symbol '__tipc_nl_add_monitor_peer' was not declared. Should it be static?
net/tipc/group.c:230:20: warning: symbol 'tipc_group_find_member' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/tipc/group.c   |  4 ++--
 net/tipc/link.c    | 11 ++++++-----
 net/tipc/monitor.c |  3 ++-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/tipc/group.c b/net/tipc/group.c
index 8f43e7d..e82f13c 100644
--- a/net/tipc/group.c
+++ b/net/tipc/group.c
@@ -227,8 +227,8 @@ void tipc_group_delete(struct net *net, struct tipc_group *grp)
 	kfree(grp);
 }
 
-struct tipc_member *tipc_group_find_member(struct tipc_group *grp,
-					   u32 node, u32 port)
+static struct tipc_member *tipc_group_find_member(struct tipc_group *grp,
+						  u32 node, u32 port)
 {
 	struct rb_node *n = grp->members.rb_node;
 	u64 nkey, key = (u64)node << 32 | port;
diff --git a/net/tipc/link.c b/net/tipc/link.c
index 6987ffc..b1f0bee 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -373,7 +373,7 @@ int tipc_link_bc_peers(struct tipc_link *l)
 	return l->ackers;
 }
 
-u16 link_bc_rcv_gap(struct tipc_link *l)
+static u16 link_bc_rcv_gap(struct tipc_link *l)
 {
 	struct sk_buff *skb = skb_peek(&l->deferdq);
 	u16 gap = 0;
@@ -820,7 +820,7 @@ static int link_schedule_user(struct tipc_link *l, struct tipc_msg *hdr)
  * Wake up a number of waiting users, as permitted by available space
  * in the send queue
  */
-void link_prepare_wakeup(struct tipc_link *l)
+static void link_prepare_wakeup(struct tipc_link *l)
 {
 	struct sk_buff *skb, *tmp;
 	int imp, i = 0;
@@ -956,7 +956,8 @@ int tipc_link_xmit(struct tipc_link *l, struct sk_buff_head *list,
 	return rc;
 }
 
-void tipc_link_advance_backlog(struct tipc_link *l, struct sk_buff_head *xmitq)
+static void tipc_link_advance_backlog(struct tipc_link *l,
+				      struct sk_buff_head *xmitq)
 {
 	struct sk_buff *skb, *_skb;
 	struct tipc_msg *hdr;
@@ -1006,8 +1007,8 @@ static void link_retransmit_failure(struct tipc_link *l, struct sk_buff *skb)
  * @to: retransmit to (inclusive) this sequence number
  * xmitq: queue for accumulating the retransmitted packets
  */
-int tipc_link_retrans(struct tipc_link *l, struct tipc_link *r,
-		      u16 from, u16 to, struct sk_buff_head *xmitq)
+static int tipc_link_retrans(struct tipc_link *l, struct tipc_link *r,
+			     u16 from, u16 to, struct sk_buff_head *xmitq)
 {
 	struct sk_buff *_skb, *skb = skb_peek(&l->transmq);
 	u16 bc_ack = l->bc_rcvlink->rcv_nxt - 1;
diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c
index 5453e56..67f6938 100644
--- a/net/tipc/monitor.c
+++ b/net/tipc/monitor.c
@@ -684,7 +684,8 @@ int tipc_nl_monitor_get_threshold(struct net *net)
 	return tn->mon_threshold;
 }
 
-int __tipc_nl_add_monitor_peer(struct tipc_peer *peer, struct tipc_nl_msg *msg)
+static int __tipc_nl_add_monitor_peer(struct tipc_peer *peer,
+				      struct tipc_nl_msg *msg)
 {
 	struct tipc_mon_domain *dom = peer->domain;
 	struct nlattr *attrs;
-- 
2.7.0


