Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D48EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFDE213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0TGRopl1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFDE213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389287AbeK3Bh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:37:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:40390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732374AbeK3Bh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:37:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BE65213A2;
        Thu, 29 Nov 2018 14:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501913;
        bh=7P5G6jWQ/LMhDsCD/UQAmfqcOV6mCEA0MKl9hY2ARxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0TGRopl1cq9/FGNztrSiXlTuFsQwnLf/GwBQnuqlNrq2uxtmRxIQtybirT8soRkaK
         n3Ttsy9SVyPT9z0SfEa0qlE4YDfgMpUY7dv+XJoxG6mwmY68u+k79HDlcKX3SZ5bEA
         snruS900tFiG+on5yxvJbgv37LlI/zlTT/ZPuf10=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.19 059/110] can: flexcan: Always use last mailbox for TX
Date:   Thu, 29 Nov 2018 15:12:30 +0100
Message-Id: <20181129135923.648208772@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Stein <alexander.stein@systec-electronic.com>

commit cbffaf7aa09edbaea2bc7dc440c945297095e2fd upstream.

Essentially this patch moves the TX mailbox to position 63, regardless
of timestamp based offloading or RX FIFO. So mainly the iflag register
usage regarding TX has changed. The rest is consolidating RX FIFO and
timestamp offloading as they now use both the same TX mailbox.

The reason is a very annoying behavior regarding sending RTR frames when
_not_ using RX FIFO:

If a TX mailbox sent a RTR frame it becomes a RX mailbox. For that
reason flexcan_irq disables the TX mailbox again. But if during the time
the RTR was sent and the TX mailbox is disabled a new CAN frames is
received, it is lost without notice. The reason is that so-called
"Move-in" process starts from the lowest mailbox which happen to be a TX
mailbox set to EMPTY.

Steps to reproduce (I used an imx7d):
1. generate regular bursts of messages
2. send a RTR from flexcan with higher priority than burst messages every
   1ms, e.g. cangen -I 0x100 -L 0 -g 1 -R can0
3. notice a lost message without notification after some seconds

When running an iperf in parallel this problem is occurring even more
frequently. Using filters is not possible as at least one single CAN-ID
is allowed. Handling the TX MB during RX is also not possible as there
is no race-free disable of RX MB.

There is still a slight window when the described problem can occur. But
for that all RX MB must be in use which is essentially next to an
overrun. Still there will be no indication if it ever occurs.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/flexcan.c |   67 ++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -135,13 +135,12 @@
 
 /* FLEXCAN interrupt flag register (IFLAG) bits */
 /* Errata ERR005829 step7: Reserve first valid MB */
-#define FLEXCAN_TX_MB_RESERVED_OFF_FIFO	8
-#define FLEXCAN_TX_MB_OFF_FIFO		9
+#define FLEXCAN_TX_MB_RESERVED_OFF_FIFO		8
 #define FLEXCAN_TX_MB_RESERVED_OFF_TIMESTAMP	0
-#define FLEXCAN_TX_MB_OFF_TIMESTAMP		1
-#define FLEXCAN_RX_MB_OFF_TIMESTAMP_FIRST	(FLEXCAN_TX_MB_OFF_TIMESTAMP + 1)
-#define FLEXCAN_RX_MB_OFF_TIMESTAMP_LAST	63
-#define FLEXCAN_IFLAG_MB(x)		BIT(x)
+#define FLEXCAN_TX_MB				63
+#define FLEXCAN_RX_MB_OFF_TIMESTAMP_FIRST	(FLEXCAN_TX_MB_RESERVED_OFF_TIMESTAMP + 1)
+#define FLEXCAN_RX_MB_OFF_TIMESTAMP_LAST	(FLEXCAN_TX_MB - 1)
+#define FLEXCAN_IFLAG_MB(x)		BIT(x & 0x1f)
 #define FLEXCAN_IFLAG_RX_FIFO_OVERFLOW	BIT(7)
 #define FLEXCAN_IFLAG_RX_FIFO_WARN	BIT(6)
 #define FLEXCAN_IFLAG_RX_FIFO_AVAILABLE	BIT(5)
@@ -745,9 +744,9 @@ static inline u64 flexcan_read_reg_iflag
 	struct flexcan_regs __iomem *regs = priv->regs;
 	u32 iflag1, iflag2;
 
-	iflag2 = priv->read(&regs->iflag2) & priv->reg_imask2_default;
-	iflag1 = priv->read(&regs->iflag1) & priv->reg_imask1_default &
+	iflag2 = priv->read(&regs->iflag2) & priv->reg_imask2_default &
 		~FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
+	iflag1 = priv->read(&regs->iflag1) & priv->reg_imask1_default;
 
 	return (u64)iflag2 << 32 | iflag1;
 }
@@ -759,11 +758,9 @@ static irqreturn_t flexcan_irq(int irq,
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
 	irqreturn_t handled = IRQ_NONE;
-	u32 reg_iflag1, reg_esr;
+	u32 reg_iflag2, reg_esr;
 	enum can_state last_state = priv->can.state;
 
-	reg_iflag1 = priv->read(&regs->iflag1);
-
 	/* reception interrupt */
 	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
 		u64 reg_iflag;
@@ -777,6 +774,9 @@ static irqreturn_t flexcan_irq(int irq,
 				break;
 		}
 	} else {
+		u32 reg_iflag1;
+
+		reg_iflag1 = priv->read(&regs->iflag1);
 		if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) {
 			handled = IRQ_HANDLED;
 			can_rx_offload_irq_offload_fifo(&priv->offload);
@@ -792,8 +792,10 @@ static irqreturn_t flexcan_irq(int irq,
 		}
 	}
 
+	reg_iflag2 = priv->read(&regs->iflag2);
+
 	/* transmission complete interrupt */
-	if (reg_iflag1 & FLEXCAN_IFLAG_MB(priv->tx_mb_idx)) {
+	if (reg_iflag2 & FLEXCAN_IFLAG_MB(priv->tx_mb_idx)) {
 		u32 reg_ctrl = priv->read(&regs->mb[FLEXCAN_TX_MB].can_ctrl);
 
 		handled = IRQ_HANDLED;
@@ -805,7 +807,7 @@ static irqreturn_t flexcan_irq(int irq,
 		/* after sending a RTR frame MB is in RX mode */
 		priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
 			    &priv->tx_mb->can_ctrl);
-		priv->write(FLEXCAN_IFLAG_MB(priv->tx_mb_idx), &regs->iflag1);
+		priv->write(FLEXCAN_IFLAG_MB(priv->tx_mb_idx), &regs->iflag2);
 		netif_wake_queue(dev);
 	}
 
@@ -947,15 +949,13 @@ static int flexcan_chip_start(struct net
 	reg_mcr &= ~FLEXCAN_MCR_MAXMB(0xff);
 	reg_mcr |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT | FLEXCAN_MCR_SUPV |
 		FLEXCAN_MCR_WRN_EN | FLEXCAN_MCR_SRX_DIS | FLEXCAN_MCR_IRMQ |
-		FLEXCAN_MCR_IDAM_C;
+		FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
 
-	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP)
 		reg_mcr &= ~FLEXCAN_MCR_FEN;
-		reg_mcr |= FLEXCAN_MCR_MAXMB(priv->offload.mb_last);
-	} else {
-		reg_mcr |= FLEXCAN_MCR_FEN |
-			FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
-	}
+	else
+		reg_mcr |= FLEXCAN_MCR_FEN;
+
 	netdev_dbg(dev, "%s: writing mcr=0x%08x", __func__, reg_mcr);
 	priv->write(reg_mcr, &regs->mcr);
 
@@ -998,16 +998,17 @@ static int flexcan_chip_start(struct net
 		priv->write(reg_ctrl2, &regs->ctrl2);
 	}
 
-	/* clear and invalidate all mailboxes first */
-	for (i = priv->tx_mb_idx; i < ARRAY_SIZE(regs->mb); i++) {
-		priv->write(FLEXCAN_MB_CODE_RX_INACTIVE,
-			    &regs->mb[i].can_ctrl);
-	}
-
 	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
-		for (i = priv->offload.mb_first; i <= priv->offload.mb_last; i++)
+		for (i = priv->offload.mb_first; i <= priv->offload.mb_last; i++) {
 			priv->write(FLEXCAN_MB_CODE_RX_EMPTY,
 				    &regs->mb[i].can_ctrl);
+		}
+	} else {
+		/* clear and invalidate unused mailboxes first */
+		for (i = FLEXCAN_TX_MB_RESERVED_OFF_FIFO; i <= ARRAY_SIZE(regs->mb); i++) {
+			priv->write(FLEXCAN_MB_CODE_RX_INACTIVE,
+				    &regs->mb[i].can_ctrl);
+		}
 	}
 
 	/* Errata ERR005829: mark first TX mailbox as INACTIVE */
@@ -1371,17 +1372,15 @@ static int flexcan_probe(struct platform
 	priv->devtype_data = devtype_data;
 	priv->reg_xceiver = reg_xceiver;
 
-	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
-		priv->tx_mb_idx = FLEXCAN_TX_MB_OFF_TIMESTAMP;
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP)
 		priv->tx_mb_reserved = &regs->mb[FLEXCAN_TX_MB_RESERVED_OFF_TIMESTAMP];
-	} else {
-		priv->tx_mb_idx = FLEXCAN_TX_MB_OFF_FIFO;
+	else
 		priv->tx_mb_reserved = &regs->mb[FLEXCAN_TX_MB_RESERVED_OFF_FIFO];
-	}
+	priv->tx_mb_idx = FLEXCAN_TX_MB;
 	priv->tx_mb = &regs->mb[priv->tx_mb_idx];
 
-	priv->reg_imask1_default = FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
-	priv->reg_imask2_default = 0;
+	priv->reg_imask1_default = 0;
+	priv->reg_imask2_default = FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
 
 	priv->offload.mailbox_read = flexcan_mailbox_read;
 


