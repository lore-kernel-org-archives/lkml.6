Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752289AbeC0Jwj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:52:39 -0400
Received: from atl4mhob11.registeredsite.com ([209.17.115.49]:36356 "EHLO
        atl4mhob11.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752217AbeC0Jwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:52:36 -0400
X-TCPREMOTEIP: 37.74.225.130
X-Authenticated-UID: mike@milosoftware.com
From: Mike Looijmans <mike.looijmans@topic.nl>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andrew@lunn.ch, f.fainelli@gmail.com, robh+dt@kernel.org,
        frowand.list@gmail.com, Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH v3 2/2] net: macb: Try to retrieve MAC addess from nvmem provider
Date: Tue, 27 Mar 2018 11:52:26 +0200
Message-Id: <1522144346-32367-3-git-send-email-mike.looijmans@topic.nl>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522144346-32367-1-git-send-email-mike.looijmans@topic.nl>
References: <1522144346-32367-1-git-send-email-mike.looijmans@topic.nl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call of_get_nvmem_mac_address() to fetch the MAC address from an nvmem
cell, if one is provided in the device tree. This allows the address to
be stored in an I2C EEPROM device for example.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/net/ethernet/cadence/macb_main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index e84afcf..eabe14f 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3950,10 +3950,16 @@ static int macb_probe(struct platform_device *pdev)
 		dev->max_mtu = ETH_DATA_LEN;
 
 	mac = of_get_mac_address(np);
-	if (mac)
+	if (mac) {
 		ether_addr_copy(bp->dev->dev_addr, mac);
-	else
-		macb_get_hwaddr(bp);
+	} else {
+		err = of_get_nvmem_mac_address(np, bp->dev->dev_addr);
+		if (err) {
+			if (err == -EPROBE_DEFER)
+				goto err_out_free_netdev;
+			macb_get_hwaddr(bp);
+		}
+	}
 
 	err = of_get_phy_mode(np);
 	if (err < 0) {
-- 
1.9.1
