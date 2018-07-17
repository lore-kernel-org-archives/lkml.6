Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17454ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49C020C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49C020C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731824AbeGQOQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:16:26 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.13]:18753 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731603AbeGQOQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:16:25 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id C471696C388
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 08:43:40 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id fQG4fwbzAbXuJfQGIf4VGJ; Tue, 17 Jul 2018 08:43:40 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=41792 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ffQG3-001Aes-SY; Tue, 17 Jul 2018 08:43:16 -0500
Date:   Tue, 17 Jul 2018 08:43:14 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] rtnetlink: fix uninitialized variable
Message-ID: <20180717134314.GA31127@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1ffQG3-001Aes-SY
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:41792
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there are execution paths in which variable err is
returned without being properly initialized previously:

1417        if (rtnl_xdp_report_one(skb, dev, &prog_id, &mode, XDP_ATTACHED_SKB,
1418                                IFLA_XDP_SKB_PROG_ID, rtnl_xdp_prog_skb))
1419                goto err_cancel;
1420        if (rtnl_xdp_report_one(skb, dev, &prog_id, &mode, XDP_ATTACHED_DRV,
1421                                IFLA_XDP_DRV_PROG_ID, rtnl_xdp_prog_drv))
1422                goto err_cancel;
1423        if (rtnl_xdp_report_one(skb, dev, &prog_id, &mode, XDP_ATTACHED_HW,
1424                                IFLA_XDP_HW_PROG_ID, rtnl_xdp_prog_hw))
1425                goto err_cancel;

Fix this by initializing variable err to -EMSGSIZE.

Addresses-Coverity-ID: 1471831 ("Uninitialized scalar variable")
Fixes: a25717d2b604 ("xdp: support simultaneous driver and hw XDP attachment")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/core/rtnetlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index e03258e..648c984 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1405,12 +1405,12 @@ static int rtnl_xdp_fill(struct sk_buff *skb, struct net_device *dev)
 {
 	struct nlattr *xdp;
 	u32 prog_id;
-	int err;
+	int err = -EMSGSIZE;
 	u8 mode;
 
 	xdp = nla_nest_start(skb, IFLA_XDP);
 	if (!xdp)
-		return -EMSGSIZE;
+		return err;
 
 	prog_id = 0;
 	mode = XDP_ATTACHED_NONE;
-- 
2.7.4

