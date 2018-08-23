Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBB4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB73C208FA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB73C208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbeHWMqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:46:51 -0400
Received: from mail5.windriver.com ([192.103.53.11]:60202 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbeHWMqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:46:51 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w7N9HxXx006775
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 23 Aug 2018 02:18:00 -0700
Received: from pek-lpgtest5.wrs.com (128.224.153.85) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.399.0; Thu, 23 Aug 2018 02:17:59 -0700
From:   Haiqing Bai <Haiqing.Bai@windriver.com>
To:     <netdev@vger.kernel.org>, <jon.maloy@ericsson.com>,
        <ying.xue@windriver.com>, <davem@davemloft.net>
CC:     <zhenbo.gao@windriver.com>, <haiqing.bai@windriver.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net] tipc: fix the big/little endian issue in tipc_dest
Date:   Thu, 23 Aug 2018 16:49:18 +0800
Message-ID: <1535014158-18578-1-git-send-email-Haiqing.Bai@windriver.com>
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

Fixes: d06b2fa34f18 ("tipc: improve destination linked list")

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

