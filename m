Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C72C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4C620660
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfAEQw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 11:52:27 -0500
Received: from gateway24.websitewelcome.com ([192.185.50.84]:43007 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726249AbfAEQw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 11:52:26 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id ABD88C5A79
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jan 2019 10:52:25 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id fpBRg3ujs2PzOfpBRgjQ37; Sat, 05 Jan 2019 10:52:25 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=42612 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gfpBQ-002ToZ-8N; Sat, 05 Jan 2019 10:52:24 -0600
Date:   Sat, 5 Jan 2019 10:52:23 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Kangjie Lu <kjlu@umn.edu>, Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] tipc: fix memory leak in tipc_nl_compat_publ_dump
Message-ID: <20190105165223.GA3296@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gfpBQ-002ToZ-8N
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:42612
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a memory leak in case genlmsg_put fails.

Fix this by freeing *args* before return.

Addresses-Coverity-ID: 1476406 ("Resource leak")
Fixes: 46273cf7e009 ("tipc: fix a missing check of genlmsg_put")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/tipc/netlink_compat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
index 40f5cae623a7..77e4b2418f30 100644
--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -904,8 +904,10 @@ static int tipc_nl_compat_publ_dump(struct tipc_nl_compat_msg *msg, u32 sock)
 
 	hdr = genlmsg_put(args, 0, 0, &tipc_genl_family, NLM_F_MULTI,
 			  TIPC_NL_PUBL_GET);
-	if (!hdr)
+	if (!hdr) {
+		kfree_skb(args);
 		return -EMSGSIZE;
+	}
 
 	nest = nla_nest_start(args, TIPC_NLA_SOCK);
 	if (!nest) {
-- 
2.20.1

