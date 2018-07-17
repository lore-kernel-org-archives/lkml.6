Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8301FECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F41E20C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ro5v1AeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F41E20C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbeGQMjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:39:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731295AbeGQMjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:39:06 -0400
Received: from kenny.it.cumulusnetworks.com. (fw.cumulusnetworks.com [216.129.126.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FC5B2146E;
        Tue, 17 Jul 2018 12:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531829205;
        bh=rwZrS2vy406LKz+0Z1X2BMDXCIoN747644S/zkMBeDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ro5v1AeSX9GMl42sy7SZpnOPP5Omk8SX4Z3V7On3zuJx62HCcHL+hxkak/7MeRRP5
         CV2kkt5zsB5RAb9RoRPhgiWYaw3hBVynFK0NhiXwCPWDJ7gdr2HH4hhSM0M1v9oLY/
         9cDdX0Ig10RqqXronSkHOuK0AZ6qAKlJf79YohxA=
From:   dsahern@kernel.org
To:     netdev@vger.kernel.org
Cc:     nikita.leshchenko@oracle.com, roopa@cumulusnetworks.com,
        stephen@networkplumber.org, idosch@mellanox.com, jiri@mellanox.com,
        saeedm@mellanox.com, alex.aring@gmail.com,
        linux-wpan@vger.kernel.org, netfilter-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Ahern <dsahern@gmail.com>
Subject: [PATCH RFC/RFT net-next 02/17] net/neigh: export neigh_find_table
Date:   Tue, 17 Jul 2018 05:06:36 -0700
Message-Id: <20180717120651.15748-3-dsahern@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180717120651.15748-1-dsahern@kernel.org>
References: <20180717120651.15748-1-dsahern@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>

neighbor code already has an API for access to neighbor caches by
address family. Export it for use by networking code. Add the
namespace as an input arg and make family a u8 versus an int (all
existing callers pass ndm_family which is a u8).

Signed-off-by: David Ahern <dsahern@gmail.com>
---
 include/net/neighbour.h | 2 ++
 net/core/neighbour.c    | 7 ++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 6c1eecd56a4d..5bc4d79b4b3a 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -229,6 +229,8 @@ enum {
 	NEIGH_LINK_TABLE = NEIGH_NR_TABLES /* Pseudo table for neigh_xmit */
 };
 
+struct neigh_table *neigh_find_table(struct net *net, u8 family);
+
 static inline int neigh_parms_family(struct neigh_parms *p)
 {
 	return p->tbl->family;
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index cbe85d8d4cc2..e8630f9de24a 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1625,7 +1625,7 @@ int neigh_table_clear(int index, struct neigh_table *tbl)
 }
 EXPORT_SYMBOL(neigh_table_clear);
 
-static struct neigh_table *neigh_find_table(int family)
+struct neigh_table *neigh_find_table(struct net *net, u8 family)
 {
 	struct neigh_table *tbl = NULL;
 
@@ -1643,6 +1643,7 @@ static struct neigh_table *neigh_find_table(int family)
 
 	return tbl;
 }
+EXPORT_SYMBOL(neigh_find_table);
 
 static int neigh_delete(struct sk_buff *skb, struct nlmsghdr *nlh,
 			struct netlink_ext_ack *extack)
@@ -1672,7 +1673,7 @@ static int neigh_delete(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 	}
 
-	tbl = neigh_find_table(ndm->ndm_family);
+	tbl = neigh_find_table(net, ndm->ndm_family);
 	if (tbl == NULL)
 		return -EAFNOSUPPORT;
 
@@ -1740,7 +1741,7 @@ static int neigh_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 			goto out;
 	}
 
-	tbl = neigh_find_table(ndm->ndm_family);
+	tbl = neigh_find_table(net, ndm->ndm_family);
 	if (tbl == NULL)
 		return -EAFNOSUPPORT;
 
-- 
2.11.0

