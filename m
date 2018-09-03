Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2D1C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AFF20869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46AFF20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeICXSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:18:51 -0400
Received: from gateway30.websitewelcome.com ([192.185.160.12]:13287 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727493AbeICXSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:18:50 -0400
X-Greylist: delayed 1238 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Sep 2018 19:18:50 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 350EA15688
        for <linux-kernel@vger.kernel.org>; Mon,  3 Sep 2018 13:36:46 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id wti4fONUHaSeywtiGfrTE3; Mon, 03 Sep 2018 13:36:45 -0500
X-Authority-Reason: nr=8
Received: from [189.250.106.191] (port=40082 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fwti0-002L2x-DM; Mon, 03 Sep 2018 13:36:23 -0500
Date:   Mon, 3 Sep 2018 13:36:18 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] can: at91_can: fix fall-through annotations
Message-ID: <20180903183618.GA6905@embeddedor.com>
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
X-Exim-ID: 1fwti0-002L2x-DM
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.106.191]:40082
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 22
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properly place the "fall through" annotations at the bottom of the case,
which is what GCC is expecting to find.

This fix is part of the ongoing efforts to enabling -Wimplicit-fallthrough

Addresses-Coverity-ID: 1222851 ("Missing break in switch")
Addresses-Coverity-ID: 402011 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/can/at91_can.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index d98c690..1718c20 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -902,7 +902,8 @@ static void at91_irq_err_state(struct net_device *dev,
 				CAN_ERR_CRTL_TX_WARNING :
 				CAN_ERR_CRTL_RX_WARNING;
 		}
-	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
+		/* fall through */
+	case CAN_STATE_ERROR_WARNING:
 		/*
 		 * from: ERROR_ACTIVE, ERROR_WARNING
 		 * to  : ERROR_PASSIVE, BUS_OFF
@@ -951,7 +952,8 @@ static void at91_irq_err_state(struct net_device *dev,
 		netdev_dbg(dev, "Error Active\n");
 		cf->can_id |= CAN_ERR_PROT;
 		cf->data[2] = CAN_ERR_PROT_ACTIVE;
-	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
+		/* fall through */
+	case CAN_STATE_ERROR_WARNING:
 		reg_idr = AT91_IRQ_ERRA | AT91_IRQ_WARN | AT91_IRQ_BOFF;
 		reg_ier = AT91_IRQ_ERRP;
 		break;
-- 
2.7.4

