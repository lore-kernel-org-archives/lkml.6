Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59EFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06452086C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732119AbeLQJql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:46:41 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:39158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732021AbeLQJqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:46:38 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A8CE08E5AF39E;
        Mon, 17 Dec 2018 17:46:34 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Mon, 17 Dec 2018
 17:46:29 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <roopa@cumulusnetworks.com>,
        <nikolay@cumulusnetworks.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <bridge@lists.linux-foundation.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: bridge: remove unneeded variable 'err'
Date:   Mon, 17 Dec 2018 17:46:23 +0800
Message-ID: <20181217094623.32668-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

function br_multicast_toggle now always return 0,
so the variable 'err' is unneeded.
Also cleanup dead branch in br_changelink.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/bridge/br_multicast.c | 3 +--
 net/bridge/br_netlink.c   | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 879cd23..3aeff08 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1937,7 +1937,6 @@ static void br_multicast_start_querier(struct net_bridge *br,
 int br_multicast_toggle(struct net_bridge *br, unsigned long val)
 {
 	struct net_bridge_port *port;
-	int err = 0;
 
 	spin_lock_bh(&br->multicast_lock);
 	if (!!br_opt_get(br, BROPT_MULTICAST_ENABLED) == !!val)
@@ -1958,7 +1957,7 @@ int br_multicast_toggle(struct net_bridge *br, unsigned long val)
 unlock:
 	spin_unlock_bh(&br->multicast_lock);
 
-	return err;
+	return 0;
 }
 
 bool br_multicast_enabled(const struct net_device *dev)
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 935495b..9c07591 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1175,9 +1175,7 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 	if (data[IFLA_BR_MCAST_SNOOPING]) {
 		u8 mcast_snooping = nla_get_u8(data[IFLA_BR_MCAST_SNOOPING]);
 
-		err = br_multicast_toggle(br, mcast_snooping);
-		if (err)
-			return err;
+		br_multicast_toggle(br, mcast_snooping);
 	}
 
 	if (data[IFLA_BR_MCAST_QUERY_USE_IFADDR]) {
-- 
2.7.0


