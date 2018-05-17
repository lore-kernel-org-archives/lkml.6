Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbeEQIfJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 04:35:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42381 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752498AbeEQIfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 04:35:03 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net
Cc: Yan Markman <ymarkman@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com, Antoine Tenart <antoine.tenart@bootlin.com>
Subject: [PATCH net-next 3/3] net: mvpp2: print rx error with rate-limit
Date: Thu, 17 May 2018 10:34:27 +0200
Message-Id: <20180517083427.15793-4-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517083427.15793-1-antoine.tenart@bootlin.com>
References: <20180517083427.15793-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yan Markman <ymarkman@marvell.com>

Prevent flood of RX error prints during heavy traffic with weak signal
in link by checking net_ratelimit() before using netdev_err().

Signed-off-by: Yan Markman <ymarkman@marvell.com>
[Antoine: small rework, commit message]
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index a9483da18e00..f8ed983bc767 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -6382,21 +6382,23 @@ static void mvpp2_rx_error(struct mvpp2_port *port,
 {
 	u32 status = mvpp2_rxdesc_status_get(port, rx_desc);
 	size_t sz = mvpp2_rxdesc_size_get(port, rx_desc);
+	char *err_str = NULL;
 
 	switch (status & MVPP2_RXD_ERR_CODE_MASK) {
 	case MVPP2_RXD_ERR_CRC:
-		netdev_err(port->dev, "bad rx status %08x (crc error), size=%zu\n",
-			   status, sz);
+		err_str = "crc";
 		break;
 	case MVPP2_RXD_ERR_OVERRUN:
-		netdev_err(port->dev, "bad rx status %08x (overrun error), size=%zu\n",
-			   status, sz);
+		err_str = "overrun";
 		break;
 	case MVPP2_RXD_ERR_RESOURCE:
-		netdev_err(port->dev, "bad rx status %08x (resource error), size=%zu\n",
-			   status, sz);
+		err_str = "resource";
 		break;
 	}
+	if (err_str && net_ratelimit())
+		netdev_err(port->dev,
+			   "bad rx status %08x (%s error), size=%zu\n",
+			   status, err_str, sz);
 }
 
 /* Handle RX checksum offload */
-- 
2.17.0
