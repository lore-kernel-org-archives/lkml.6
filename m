Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1551C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5789F2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5789F2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbeICWre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:47:34 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.234]:19629 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727380AbeICWrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:47:33 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 3C78417A7A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Sep 2018 13:26:09 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id wtXmfNqQWaSeywtY0fqwES; Mon, 03 Sep 2018 13:26:08 -0500
X-Authority-Reason: nr=8
Received: from [189.250.106.191] (port=39550 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fwtXl-002GAj-94; Mon, 03 Sep 2018 13:25:45 -0500
Date:   Mon, 3 Sep 2018 13:25:41 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] can: mcp251x: fix fall-through annotation
Message-ID: <20180903182541.GA3956@embeddedor.com>
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
X-Source-IP: 189.250.106.191
X-Source-L: No
X-Exim-ID: 1fwtXl-002GAj-94
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.106.191]:39550
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properly place the "fall through" annotation at the bottom of the case,
which is what GCC is expecting to find.

This fix is part of the ongoing efforts to enabling -Wimplicit-fallthrough

Addresses-Coverity-ID: 114880 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/can/spi/mcp251x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index e908176..17257c7 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -875,7 +875,8 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
 			if (new_state >= CAN_STATE_ERROR_WARNING &&
 			    new_state <= CAN_STATE_BUS_OFF)
 				priv->can.can_stats.error_warning++;
-		case CAN_STATE_ERROR_WARNING:	/* fallthrough */
+			/* fall through */
+		case CAN_STATE_ERROR_WARNING:
 			if (new_state >= CAN_STATE_ERROR_PASSIVE &&
 			    new_state <= CAN_STATE_BUS_OFF)
 				priv->can.can_stats.error_passive++;
-- 
2.7.4

