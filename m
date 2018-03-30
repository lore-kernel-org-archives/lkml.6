Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeC3KGF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 06:06:05 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35183 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751053AbeC3KGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 06:06:03 -0400
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>, stefanc@marvell.com,
        ymarkman@marvell.com, Yelena Krivosheev <yelena@marvell.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH] net: mvneta: fix enable of all initialized RXQs
Date: Fri, 30 Mar 2018 12:05:31 +0200
Message-Id: <20180330100531.5995-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yelena Krivosheev <yelena@marvell.com>

In mvneta_port_up() we enable relevant RX and TX port queues by write
queues bit map to an appropriate register.

q_map must be ZERO in the beginning of this process.

Signed-off-by: Yelena Krivosheev <yelena@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 25e9a551cc8c..3f6fb635738c 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1132,6 +1132,7 @@ static void mvneta_port_up(struct mvneta_port *pp)
 	}
 	mvreg_write(pp, MVNETA_TXQ_CMD, q_map);
 
+	q_map = 0;
 	/* Enable all initialized RXQs. */
 	for (queue = 0; queue < rxq_number; queue++) {
 		struct mvneta_rx_queue *rxq = &pp->rxqs[queue];
-- 
2.16.2
