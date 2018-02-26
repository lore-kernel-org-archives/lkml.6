Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753929AbeBZOP2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:15:28 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50776 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753858AbeBZOPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:15:13 -0500
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net
Cc: Yan Markman <ymarkman@marvell.com>, mw@semihalf.com,
        stefanc@marvell.com, thomas.petazzoni@free-electrons.com,
        gregory.clement@free-electrons.com, miquel.raynal@free-electrons.com,
        nadavh@marvell.com, maxime.chevallier@bootlin.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/3] net: mvpp2: adjust gso stop wake thresholds
Date: Mon, 26 Feb 2018 15:14:26 +0100
Message-Id: <20180226141427.31536-2-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180226141427.31536-1-antoine.tenart@bootlin.com>
References: <20180226141427.31536-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yan Markman <ymarkman@marvell.com>

Adjust MVPP2_MAX_TSO_SEGS and stop_threshold/wake_threshold
for better TXQ utilization and performance.

Signed-off-by: Yan Markman <ymarkman@marvell.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 55300b1fe6c0..1a893ef70eab 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -498,7 +498,7 @@
  * skb. As we need a maxium of two descriptors per fragments (1 header, 1 data),
  * multiply this value by two to count the maximum number of skb descs needed.
  */
-#define MVPP2_MAX_TSO_SEGS		300
+#define MVPP2_MAX_TSO_SEGS		100
 #define MVPP2_MAX_SKB_DESCS		(MVPP2_MAX_TSO_SEGS * 2 + MAX_SKB_FRAGS)
 
 /* Dfault number of RXQs in use */
@@ -5810,7 +5810,7 @@ static int mvpp2_txq_init(struct mvpp2_port *port,
 		txq_pcpu->tso_headers = NULL;
 
 		txq_pcpu->stop_threshold = txq->size - MVPP2_MAX_SKB_DESCS;
-		txq_pcpu->wake_threshold = txq_pcpu->stop_threshold / 2;
+		txq_pcpu->wake_threshold = txq_pcpu->stop_threshold - 100;
 
 		txq_pcpu->tso_headers =
 			dma_alloc_coherent(port->dev->dev.parent,
-- 
2.14.3
