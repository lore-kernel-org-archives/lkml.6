Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BD7C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65AF02184D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfA2SGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:06:23 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.250]:22192 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728622AbfA2SGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:06:16 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 29800400D9277
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 12:06:15 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id oXm3gpS554FKpoXm3gCtH4; Tue, 29 Jan 2019 12:06:15 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=44894 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1goXm2-0049dP-6P; Tue, 29 Jan 2019 12:06:14 -0600
Date:   Tue, 29 Jan 2019 12:06:12 -0600
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
Subject: [PATCH] can: mark expected switch fall-throughs
Message-ID: <20190129180612.GA28650@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1goXm2-0049dP-6P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:44894
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

This patch fixes the following warnings:

drivers/net/can/peak_canfd/peak_pciefd_main.c:668:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/net/can/spi/mcp251x.c:875:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/net/can/usb/peak_usb/pcan_usb.c:422:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/net/can/at91_can.c:895:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/net/can/at91_can.c:953:15: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/net/can/usb/peak_usb/pcan_usb.c: In function ‘pcan_usb_decode_error’:
drivers/net/can/usb/peak_usb/pcan_usb.c:422:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (n & PCAN_USB_ERROR_BUS_LIGHT) {
      ^
drivers/net/can/usb/peak_usb/pcan_usb.c:428:2: note: here
  case CAN_STATE_ERROR_WARNING:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enabling
-Wimplicit-fallthrough.

Notice that in some cases spelling mistakes were fixed.
In other cases, the /* fall through */ comment is placed
at the bottom of the case statement, which is what GCC
is expecting to find.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/can/at91_can.c                    | 6 ++++--
 drivers/net/can/peak_canfd/peak_pciefd_main.c | 2 +-
 drivers/net/can/spi/mcp251x.c                 | 3 ++-
 drivers/net/can/usb/peak_usb/pcan_usb.c       | 2 +-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index d98c69045b17..1718c20f9c99 100644
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
diff --git a/drivers/net/can/peak_canfd/peak_pciefd_main.c b/drivers/net/can/peak_canfd/peak_pciefd_main.c
index c458d5fdc8d3..e4f4d65a76b4 100644
--- a/drivers/net/can/peak_canfd/peak_pciefd_main.c
+++ b/drivers/net/can/peak_canfd/peak_pciefd_main.c
@@ -668,7 +668,7 @@ static int pciefd_can_probe(struct pciefd_board *pciefd)
 		pciefd_can_writereg(priv, CANFD_CLK_SEL_80MHZ,
 				    PCIEFD_REG_CAN_CLK_SEL);
 
-		/* fallthough */
+		/* fall through */
 	case CANFD_CLK_SEL_80MHZ:
 		priv->ucan.can.clock.freq = 80 * 1000 * 1000;
 		break;
diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index e90817608645..17257c73c302 100644
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
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 13238a72a338..eca785532b6b 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -423,7 +423,7 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 			new_state = CAN_STATE_ERROR_WARNING;
 			break;
 		}
-		/* else: fall through */
+		/* fall through */
 
 	case CAN_STATE_ERROR_WARNING:
 		if (n & PCAN_USB_ERROR_BUS_HEAVY) {
-- 
2.20.1

