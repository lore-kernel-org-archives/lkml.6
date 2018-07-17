Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEC5ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C9C20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXw0KqdT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C9C20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731789AbeGQMjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:39:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731540AbeGQMjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:39:12 -0400
Received: from kenny.it.cumulusnetworks.com. (fw.cumulusnetworks.com [216.129.126.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B41B82147A;
        Tue, 17 Jul 2018 12:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531829212;
        bh=jYoNkLJ7QR4t/7uIahoReNyfAidBVd/c3Ctl8P9Uzww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NXw0KqdTchkDhkUDuzmERZ0dKcaYp6GSAFBXmYltHKQ/WHwRQZhhy7JBSdyNFBrU/
         PmUw/ZzVktJuIxbAlxijatWjQgIrHt52CrYSj63Cb8FKoT8V98ksY90RH6cnlT4FGY
         2+l0T/sbpbC9aro+YNJG5nM+WGTiLLUouPEpA09A=
From:   dsahern@kernel.org
To:     netdev@vger.kernel.org
Cc:     nikita.leshchenko@oracle.com, roopa@cumulusnetworks.com,
        stephen@networkplumber.org, idosch@mellanox.com, jiri@mellanox.com,
        saeedm@mellanox.com, alex.aring@gmail.com,
        linux-wpan@vger.kernel.org, netfilter-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Ahern <dsahern@gmail.com>
Subject: [PATCH RFC/RFT net-next 17/17] net/neighbor: Remove neigh_tables and NEIGH enum
Date:   Tue, 17 Jul 2018 05:06:51 -0700
Message-Id: <20180717120651.15748-18-dsahern@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180717120651.15748-1-dsahern@kernel.org>
References: <20180717120651.15748-1-dsahern@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>

No longer used.

Signed-off-by: David Ahern <dsahern@gmail.com>
---
 include/net/neighbour.h | 8 --------
 net/core/neighbour.c    | 2 --
 2 files changed, 10 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index e968db1b7742..72002a24e72e 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -222,14 +222,6 @@ struct neigh_table {
 	struct pneigh_entry	**phash_buckets;
 };
 
-enum {
-	NEIGH_ARP_TABLE = 0,
-	NEIGH_ND_TABLE = 1,
-	NEIGH_DN_TABLE = 2,
-	NEIGH_NR_TABLES,
-	NEIGH_LINK_TABLE = NEIGH_NR_TABLES /* Pseudo table for neigh_xmit */
-};
-
 struct neigh_table *neigh_find_table(struct net *net, u8 family);
 
 static inline int neigh_parms_family(struct neigh_parms *p)
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 1bb7fa14cb62..7c3d4cb811d3 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1559,8 +1559,6 @@ static void neigh_parms_destroy(struct neigh_parms *parms)
 
 static struct lock_class_key neigh_table_proxy_queue_class;
 
-static struct neigh_table *neigh_tables[NEIGH_NR_TABLES] __read_mostly;
-
 void neigh_table_init(struct net *net, struct neigh_table *tbl)
 {
 	unsigned long now = jiffies;
-- 
2.11.0

