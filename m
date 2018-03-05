Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932423AbeCEOUK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:20:10 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58648 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932266AbeCEOUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:20:04 -0500
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net
Cc: Yan Markman <ymarkman@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com, Antoine Tenart <antoine.tenart@bootlin.com>
Subject: [PATCH net-next v2 3/5] net: mvpp2: use a data size of 10kB for Tx FIFO on port 0
Date: Mon,  5 Mar 2018 15:16:52 +0100
Message-Id: <20180305141654.7789-4-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180305141654.7789-1-antoine.tenart@bootlin.com>
References: <20180305141654.7789-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yan Markman <ymarkman@marvell.com>

This patch sets the Tx FIFO data size on port 0 to 10kB. This prepares
the PPv2 driver for the Jumbo frame support addition as the hardware
will need big enough Tx FIFO buffers when dealing with frames going
through an interface with an MTU of 9000.

Signed-off-by: Yan Markman <ymarkman@marvell.com>
[Antoine: commit message, small reworks.]
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index ea30112e9e5a..9c378f803649 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -44,6 +44,7 @@
 #define MVPP2_RX_ATTR_FIFO_SIZE_REG(port)	(0x20 + 4 * (port))
 #define MVPP2_RX_MIN_PKT_SIZE_REG		0x60
 #define MVPP2_RX_FIFO_INIT_REG			0x64
+#define MVPP22_TX_FIFO_THRESH_REG(port)		(0x8840 + 4 * (port))
 #define MVPP22_TX_FIFO_SIZE_REG(port)		(0x8860 + 4 * (port))
 
 /* RX DMA Top Registers */
@@ -542,6 +543,11 @@
 /* TX FIFO constants */
 #define MVPP22_TX_FIFO_DATA_SIZE_10KB		0xa
 #define MVPP22_TX_FIFO_DATA_SIZE_3KB		0x3
+#define MVPP2_TX_FIFO_THRESHOLD_MIN		256
+#define MVPP2_TX_FIFO_THRESHOLD_10KB	\
+	(MVPP22_TX_FIFO_DATA_SIZE_10KB * 1024 - MVPP2_TX_FIFO_THRESHOLD_MIN)
+#define MVPP2_TX_FIFO_THRESHOLD_3KB	\
+	(MVPP22_TX_FIFO_DATA_SIZE_3KB * 1024 - MVPP2_TX_FIFO_THRESHOLD_MIN)
 
 /* RX buffer constants */
 #define MVPP2_SKB_SHINFO_SIZE \
@@ -8456,14 +8462,25 @@ static void mvpp22_rx_fifo_init(struct mvpp2 *priv)
 	mvpp2_write(priv, MVPP2_RX_FIFO_INIT_REG, 0x1);
 }
 
-/* Initialize Tx FIFO's */
+/* Initialize Tx FIFO's: the total FIFO size is 19kB on PPv2.2 and 10G
+ * interfaces must have a Tx FIFO size of 10kB. As only port 0 can do 10G,
+ * configure its Tx FIFO size to 10kB and the others ports Tx FIFO size to 3kB.
+ */
 static void mvpp22_tx_fifo_init(struct mvpp2 *priv)
 {
-	int port;
+	int port, size, thrs;
 
-	for (port = 0; port < MVPP2_MAX_PORTS; port++)
-		mvpp2_write(priv, MVPP22_TX_FIFO_SIZE_REG(port),
-			    MVPP22_TX_FIFO_DATA_SIZE_3KB);
+	for (port = 0; port < MVPP2_MAX_PORTS; port++) {
+		if (port == 0) {
+			size = MVPP22_TX_FIFO_DATA_SIZE_10KB;
+			thrs = MVPP2_TX_FIFO_THRESHOLD_10KB;
+		} else {
+			size = MVPP22_TX_FIFO_DATA_SIZE_3KB;
+			thrs = MVPP2_TX_FIFO_THRESHOLD_3KB;
+		}
+		mvpp2_write(priv, MVPP22_TX_FIFO_SIZE_REG(port), size);
+		mvpp2_write(priv, MVPP22_TX_FIFO_THRESH_REG(port), thrs);
+	}
 }
 
 static void mvpp2_axi_init(struct mvpp2 *priv)
-- 
2.14.3
