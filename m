Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1B1C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A0B2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nppbqTyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A0B2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389301AbeK3Bha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:37:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:40462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732374AbeK3Bh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:37:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75ED42146D;
        Thu, 29 Nov 2018 14:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501915;
        bh=/gUOVOCnyxNBnG5ybZo4a7SuuMnh6OUg4AAERSJpUi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nppbqTyzrOxisNxjsgAb0k0istEqdtRZgQPezLmGpumjhxsYNGwIFjooPXNz+Kwuj
         8BtjyHh3cq50tl6Cx9Q1rDv9521xT/Tihsti9WWC3FzJpDdhV7zqc7018WmG+bQ1FD
         9LRi9Fmumi5WQPhlhGRovblU0pX7kc4wfTgSGMHQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.19 060/110] can: flexcan: remove not needed struct flexcan_priv::tx_mb and struct flexcan_priv::tx_mb_idx
Date:   Thu, 29 Nov 2018 15:12:31 +0100
Message-Id: <20181129135923.685914110@linuxfoundation.org>
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

From: Marc Kleine-Budde <mkl@pengutronix.de>

commit e05237f9da42ee52e73acea0bb082d788e111229 upstream.

The previous patch changes the TX path to always use the last mailbox
regardless of the used offload scheme (rx-fifo or timestamp based). This
means members "tx_mb" and "tx_mb_idx" of the struct flexcan_priv don't
depend on the offload scheme, so replace them by compile time constants.

Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/flexcan.c |   27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -258,9 +258,7 @@ struct flexcan_priv {
 	struct can_rx_offload offload;
 
 	struct flexcan_regs __iomem *regs;
-	struct flexcan_mb __iomem *tx_mb;
 	struct flexcan_mb __iomem *tx_mb_reserved;
-	u8 tx_mb_idx;
 	u32 reg_ctrl_default;
 	u32 reg_imask1_default;
 	u32 reg_imask2_default;
@@ -514,6 +512,7 @@ static int flexcan_get_berr_counter(cons
 static netdev_tx_t flexcan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	const struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->regs;
 	struct can_frame *cf = (struct can_frame *)skb->data;
 	u32 can_id;
 	u32 data;
@@ -536,17 +535,17 @@ static netdev_tx_t flexcan_start_xmit(st
 
 	if (cf->can_dlc > 0) {
 		data = be32_to_cpup((__be32 *)&cf->data[0]);
-		priv->write(data, &priv->tx_mb->data[0]);
+		priv->write(data, &regs->mb[FLEXCAN_TX_MB].data[0]);
 	}
 	if (cf->can_dlc > 4) {
 		data = be32_to_cpup((__be32 *)&cf->data[4]);
-		priv->write(data, &priv->tx_mb->data[1]);
+		priv->write(data, &regs->mb[FLEXCAN_TX_MB].data[1]);
 	}
 
 	can_put_echo_skb(skb, dev, 0);
 
-	priv->write(can_id, &priv->tx_mb->can_id);
-	priv->write(ctrl, &priv->tx_mb->can_ctrl);
+	priv->write(can_id, &regs->mb[FLEXCAN_TX_MB].can_id);
+	priv->write(ctrl, &regs->mb[FLEXCAN_TX_MB].can_ctrl);
 
 	/* Errata ERR005829 step8:
 	 * Write twice INACTIVE(0x8) code to first MB.
@@ -745,7 +744,7 @@ static inline u64 flexcan_read_reg_iflag
 	u32 iflag1, iflag2;
 
 	iflag2 = priv->read(&regs->iflag2) & priv->reg_imask2_default &
-		~FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
+		~FLEXCAN_IFLAG_MB(FLEXCAN_TX_MB);
 	iflag1 = priv->read(&regs->iflag1) & priv->reg_imask1_default;
 
 	return (u64)iflag2 << 32 | iflag1;
@@ -795,7 +794,7 @@ static irqreturn_t flexcan_irq(int irq,
 	reg_iflag2 = priv->read(&regs->iflag2);
 
 	/* transmission complete interrupt */
-	if (reg_iflag2 & FLEXCAN_IFLAG_MB(priv->tx_mb_idx)) {
+	if (reg_iflag2 & FLEXCAN_IFLAG_MB(FLEXCAN_TX_MB)) {
 		u32 reg_ctrl = priv->read(&regs->mb[FLEXCAN_TX_MB].can_ctrl);
 
 		handled = IRQ_HANDLED;
@@ -806,8 +805,8 @@ static irqreturn_t flexcan_irq(int irq,
 
 		/* after sending a RTR frame MB is in RX mode */
 		priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
-			    &priv->tx_mb->can_ctrl);
-		priv->write(FLEXCAN_IFLAG_MB(priv->tx_mb_idx), &regs->iflag2);
+			    &regs->mb[FLEXCAN_TX_MB].can_ctrl);
+		priv->write(FLEXCAN_IFLAG_MB(FLEXCAN_TX_MB), &regs->iflag2);
 		netif_wake_queue(dev);
 	}
 
@@ -949,7 +948,7 @@ static int flexcan_chip_start(struct net
 	reg_mcr &= ~FLEXCAN_MCR_MAXMB(0xff);
 	reg_mcr |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT | FLEXCAN_MCR_SUPV |
 		FLEXCAN_MCR_WRN_EN | FLEXCAN_MCR_SRX_DIS | FLEXCAN_MCR_IRMQ |
-		FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
+		FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_MAXMB(FLEXCAN_TX_MB);
 
 	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP)
 		reg_mcr &= ~FLEXCAN_MCR_FEN;
@@ -1017,7 +1016,7 @@ static int flexcan_chip_start(struct net
 
 	/* mark TX mailbox as INACTIVE */
 	priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
-		    &priv->tx_mb->can_ctrl);
+		    &regs->mb[FLEXCAN_TX_MB].can_ctrl);
 
 	/* acceptance mask/acceptance code (accept everything) */
 	priv->write(0x0, &regs->rxgmask);
@@ -1376,11 +1375,9 @@ static int flexcan_probe(struct platform
 		priv->tx_mb_reserved = &regs->mb[FLEXCAN_TX_MB_RESERVED_OFF_TIMESTAMP];
 	else
 		priv->tx_mb_reserved = &regs->mb[FLEXCAN_TX_MB_RESERVED_OFF_FIFO];
-	priv->tx_mb_idx = FLEXCAN_TX_MB;
-	priv->tx_mb = &regs->mb[priv->tx_mb_idx];
 
 	priv->reg_imask1_default = 0;
-	priv->reg_imask2_default = FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
+	priv->reg_imask2_default = FLEXCAN_IFLAG_MB(FLEXCAN_TX_MB);
 
 	priv->offload.mailbox_read = flexcan_mailbox_read;
 


