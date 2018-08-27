Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508A9C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 02:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174202174A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 02:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174202174A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeH0Fpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 01:45:54 -0400
Received: from mail1.windriver.com ([147.11.146.13]:49868 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbeH0Fpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 01:45:54 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w7R21MTb027605
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 26 Aug 2018 19:01:23 -0700 (PDT)
Received: from pek-lpgtest5.wrs.com (128.224.153.85) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.408.0; Sun, 26 Aug 2018 19:01:22 -0700
From:   Haiqing Bai <Haiqing.Bai@windriver.com>
To:     <netdev@vger.kernel.org>, <jon.maloy@ericsson.com>,
        <ying.xue@windriver.com>, <davem@davemloft.net>
CC:     <zhenbo.gao@windriver.com>, <haiqing.bai@windriver.com>,
        <linux-kernel@vger.kernel.org>
Subject: [V2][PATCH net] tipc: fix the big/little endian issue in tipc_dest
Date:   Mon, 27 Aug 2018 09:32:26 +0800
Message-ID: <1535333546-16753-1-git-send-email-Haiqing.Bai@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function tipc_dest_push, the 32bit variables 'node' and 'port'
are stored separately in uppper and lower part of 64bit 'value'.
Then this value is assigned to dst->value which is a union like:
union
{
  struct {
    u32 port;
    u32 node;
  };
  u64 value;
}
This works on little-endian machines like x86 but fails on big-endian
machines.

The fix remove the 'value' stack parameter and even the 'value'
member of the union in tipc_dest, assign the 'node' and 'port' member
directly with the input parameter to avoid the endian issue.

Fixes: a80ae5306a73 ("tipc: improve destination linked list")

Signed-off-by: Zhenbo Gao <zhenbo.gao@windriver.com>
Acked-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: Haiqing Bai <Haiqing.Bai@windriver.com>
---
 net/tipc/name_table.c | 10 ++++------
 net/tipc/name_table.h |  9 ++-------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/net/tipc/name_table.c b/net/tipc/name_table.c
index 88f027b..66d5b2c 100644
--- a/net/tipc/name_table.c
+++ b/net/tipc/name_table.c
@@ -980,20 +980,17 @@ int tipc_nl_name_table_dump(struct sk_buff *skb, struct netlink_callback *cb)
 
 struct tipc_dest *tipc_dest_find(struct list_head *l, u32 node, u32 port)
 {
-	u64 value = (u64)node << 32 | port;
 	struct tipc_dest *dst;
 
 	list_for_each_entry(dst, l, list) {
-		if (dst->value != value)
-			continue;
-		return dst;
+		if (dst->node == node && dst->port == port)
+			return dst;
 	}
 	return NULL;
 }
 
 bool tipc_dest_push(struct list_head *l, u32 node, u32 port)
 {
-	u64 value = (u64)node << 32 | port;
 	struct tipc_dest *dst;
 
 	if (tipc_dest_find(l, node, port))
@@ -1002,7 +999,8 @@ bool tipc_dest_push(struct list_head *l, u32 node, u32 port)
 	dst = kmalloc(sizeof(*dst), GFP_ATOMIC);
 	if (unlikely(!dst))
 		return false;
-	dst->value = value;
+	dst->node = node;
+	dst->port = port;
 	list_add(&dst->list, l);
 	return true;
 }
diff --git a/net/tipc/name_table.h b/net/tipc/name_table.h
index 0febba4..892bd75 100644
--- a/net/tipc/name_table.h
+++ b/net/tipc/name_table.h
@@ -133,13 +133,8 @@ struct publication *tipc_nametbl_remove_publ(struct net *net, u32 type,
 
 struct tipc_dest {
 	struct list_head list;
-	union {
-		struct {
-			u32 port;
-			u32 node;
-		};
-		u64 value;
-	};
+	u32 port;
+	u32 node;
 };
 
 struct tipc_dest *tipc_dest_find(struct list_head *l, u32 node, u32 port);
-- 
1.9.1

