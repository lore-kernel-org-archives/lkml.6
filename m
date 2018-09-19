Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C90ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FEBB20645
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FEBB20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbeISPHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:07:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43229 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbeISPHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:07:16 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0F82D207D4; Wed, 19 Sep 2018 11:30:12 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id CE8BB208B0;
        Wed, 19 Sep 2018 11:30:01 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 05/12] net: mvpp2: fix the number of queues per cpu for PPv2.2
Date:   Wed, 19 Sep 2018 11:27:04 +0200
Message-Id: <20180919092711.22296-6-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919092711.22296-1-antoine.tenart@bootlin.com>
References: <20180919092711.22296-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Marvell PPv2.2 engine only has 8 Rx queues per CPU, while PPv2.1 has
16 of them. This patch updates the code so that the Rx queues mask width
is selected given the version of the network controller used.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h      | 3 ++-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 7 ++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 43f9d8372b28..014e3343b660 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -253,7 +253,8 @@
 #define     MVPP2_ISR_ENABLE_INTERRUPT(mask)	((mask) & 0xffff)
 #define     MVPP2_ISR_DISABLE_INTERRUPT(mask)	(((mask) << 16) & 0xffff0000)
 #define MVPP2_ISR_RX_TX_CAUSE_REG(port)		(0x5480 + 4 * (port))
-#define     MVPP2_CAUSE_RXQ_OCCUP_DESC_ALL_MASK	0xffff
+#define     MVPP2_CAUSE_RXQ_OCCUP_DESC_ALL_MASK(version) \
+					((version) == MVPP21 ? 0xffff : 0xff)
 #define     MVPP2_CAUSE_TXQ_OCCUP_DESC_ALL_MASK	0xff0000
 #define     MVPP2_CAUSE_TXQ_OCCUP_DESC_ALL_OFFSET	16
 #define     MVPP2_CAUSE_RX_FIFO_OVERRUN_MASK	BIT(24)
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 546328041898..86f4b1323077 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -909,7 +909,7 @@ static void mvpp2_interrupts_unmask(void *arg)
 	u32 val;
 
 	val = MVPP2_CAUSE_MISC_SUM_MASK |
-		MVPP2_CAUSE_RXQ_OCCUP_DESC_ALL_MASK;
+		MVPP2_CAUSE_RXQ_OCCUP_DESC_ALL_MASK(port->priv->hw_version);
 	if (port->has_tx_irqs)
 		val |= MVPP2_CAUSE_TXQ_OCCUP_DESC_ALL_MASK;
 
@@ -929,7 +929,7 @@ mvpp2_shared_interrupt_mask_unmask(struct mvpp2_port *port, bool mask)
 	if (mask)
 		val = 0;
 	else
-		val = MVPP2_CAUSE_RXQ_OCCUP_DESC_ALL_MASK;
+		val = MVPP2_CAUSE_RXQ_OCCUP_DESC_ALL_MASK(MVPP22);
 
 	for (i = 0; i < port->nqvecs; i++) {
 		struct mvpp2_queue_vector *v = port->qvecs + i;
@@ -3065,7 +3065,8 @@ static int mvpp2_poll(struct napi_struct *napi, int budget)
 	}
 
 	/* Process RX packets */
-	cause_rx = cause_rx_tx & MVPP2_CAUSE_RXQ_OCCUP_DESC_ALL_MASK;
+	cause_rx = cause_rx_tx &
+		   MVPP2_CAUSE_RXQ_OCCUP_DESC_ALL_MASK(port->priv->hw_version);
 	cause_rx <<= qv->first_rxq;
 	cause_rx |= qv->pending_cause_rx;
 	while (cause_rx && budget > 0) {
-- 
2.17.1

