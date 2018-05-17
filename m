Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeEQIfM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 04:35:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42372 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752489AbeEQIfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 04:35:02 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net
Cc: Yan Markman <ymarkman@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com, Antoine Tenart <antoine.tenart@bootlin.com>
Subject: [PATCH net-next 2/3] net: mvpp2: set mac address does not require the stop/start sequence
Date: Thu, 17 May 2018 10:34:26 +0200
Message-Id: <20180517083427.15793-3-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517083427.15793-1-antoine.tenart@bootlin.com>
References: <20180517083427.15793-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yan Markman <ymarkman@marvell.com>

Remove special stop/start handling from the set_mac_address callback.
All this special care is not needed, and can be removed. It also
simplifies the up/down status in the driver and helps avoiding possible
link status mismatch issues.

Signed-off-by: Yan Markman <ymarkman@marvell.com>
[Antoine: commit message]
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 38 +++++-----------------------
 1 file changed, 7 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 73b2f2d331c5..a9483da18e00 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -7358,42 +7358,18 @@ static void mvpp2_set_rx_mode(struct net_device *dev)
 
 static int mvpp2_set_mac_address(struct net_device *dev, void *p)
 {
-	struct mvpp2_port *port = netdev_priv(dev);
 	const struct sockaddr *addr = p;
 	int err;
 
-	if (!is_valid_ether_addr(addr->sa_data)) {
-		err = -EADDRNOTAVAIL;
-		goto log_error;
-	}
-
-	if (!netif_running(dev)) {
-		err = mvpp2_prs_update_mac_da(dev, addr->sa_data);
-		if (!err)
-			return 0;
-		/* Reconfigure parser to accept the original MAC address */
-		err = mvpp2_prs_update_mac_da(dev, dev->dev_addr);
-		if (err)
-			goto log_error;
-	}
-
-	mvpp2_stop_dev(port);
+	if (!is_valid_ether_addr(addr->sa_data))
+		return -EADDRNOTAVAIL;
 
 	err = mvpp2_prs_update_mac_da(dev, addr->sa_data);
-	if (!err)
-		goto out_start;
-
-	/* Reconfigure parser accept the original MAC address */
-	err = mvpp2_prs_update_mac_da(dev, dev->dev_addr);
-	if (err)
-		goto log_error;
-out_start:
-	mvpp2_start_dev(port);
-	mvpp2_egress_enable(port);
-	mvpp2_ingress_enable(port);
-	return 0;
-log_error:
-	netdev_err(dev, "failed to change MAC address\n");
+	if (err) {
+		/* Reconfigure parser accept the original MAC address */
+		mvpp2_prs_update_mac_da(dev, dev->dev_addr);
+		netdev_err(dev, "failed to change MAC address\n");
+	}
 	return err;
 }
 
-- 
2.17.0
