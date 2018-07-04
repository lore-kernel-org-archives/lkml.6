Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D40EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300AC241A3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 300AC241A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753063AbeGDVjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:39:19 -0400
Received: from gateway36.websitewelcome.com ([50.116.127.2]:27908 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752888AbeGDVjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:39:18 -0400
X-Greylist: delayed 1490 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Jul 2018 17:39:18 EDT
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 7C5AF400C813B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jul 2018 15:15:15 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ap69f9OjobXuJap6OfJbp1; Wed, 04 Jul 2018 16:14:26 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=56890 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fap68-0049Lh-Km; Wed, 04 Jul 2018 16:14:00 -0500
Date:   Wed, 4 Jul 2018 16:13:59 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] tipc: mark expected switch fall-throughs
Message-ID: <20180704211359.GA9836@embeddedor.com>
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
X-Exim-ID: 1fap68-0049Lh-Km
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:56890
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Warning level 2 was used: -Wimplicit-fallthrough=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/tipc/bearer.c | 1 +
 net/tipc/link.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 2dfb492..fd6d8f1 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -610,6 +610,7 @@ static int tipc_l2_device_event(struct notifier_block *nb, unsigned long evt,
 	case NETDEV_CHANGE:
 		if (netif_carrier_ok(dev))
 			break;
+		/* else: fall through */
 	case NETDEV_UP:
 		test_and_set_bit_lock(0, &b->up);
 		break;
diff --git a/net/tipc/link.c b/net/tipc/link.c
index 695acb7..6386032 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1063,6 +1063,7 @@ static bool tipc_data_input(struct tipc_link *l, struct sk_buff *skb,
 			skb_queue_tail(mc_inputq, skb);
 			return true;
 		}
+		/* else: fall through */
 	case CONN_MANAGER:
 		skb_queue_tail(inputq, skb);
 		return true;
-- 
2.7.4

