Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA0FC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4224620854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4224620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbeIMTAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:00:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33236 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbeIMTAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:00:36 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CFDEACFE;
        Thu, 13 Sep 2018 13:51:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhenbo Gao <zhenbo.gao@windriver.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        Haiqing Bai <Haiqing.Bai@windriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 019/197] tipc: fix the big/little endian issue in tipc_dest
Date:   Thu, 13 Sep 2018 15:29:28 +0200
Message-Id: <20180913131842.338293774@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haiqing Bai <Haiqing.Bai@windriver.com>

[ Upstream commit 30935198b7d0be12b1c45c328b66a7fdefb16256 ]

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
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/name_table.c |   10 ++++------
 net/tipc/name_table.h |    9 ++-------
 2 files changed, 6 insertions(+), 13 deletions(-)

--- a/net/tipc/name_table.c
+++ b/net/tipc/name_table.c
@@ -980,20 +980,17 @@ int tipc_nl_name_table_dump(struct sk_bu
 
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
@@ -1002,7 +999,8 @@ bool tipc_dest_push(struct list_head *l,
 	dst = kmalloc(sizeof(*dst), GFP_ATOMIC);
 	if (unlikely(!dst))
 		return false;
-	dst->value = value;
+	dst->node = node;
+	dst->port = port;
 	list_add(&dst->list, l);
 	return true;
 }
--- a/net/tipc/name_table.h
+++ b/net/tipc/name_table.h
@@ -133,13 +133,8 @@ void tipc_nametbl_stop(struct net *net);
 
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


