Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752856AbeDBOgs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 10:36:48 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:41161 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752627AbeDBOfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 10:35:51 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <ssantosh@kernel.org>,
        <malat@debian.org>, <w-kwok2@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>
Subject: [net-next PATCH v3 04/11] net: netcp: ethss: make call to gbe_sgmii_config() conditional
Date: Mon, 2 Apr 2018 10:37:54 -0400
Message-ID: <1522679881-25643-5-git-send-email-m-karicheri2@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522679881-25643-1-git-send-email-m-karicheri2@ti.com>
References: <1522679881-25643-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a preparatory patch to add support for 2u cpsw hardware found on
K2G SoC, make call to gbe_sgmii_config() conditional. This is required
since 2u uses RGMII interface instead of SGMII and to allow for driver
re-use.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/net/ethernet/ti/netcp_ethss.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index 1b79fe5..1628fbe 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -2274,7 +2274,8 @@ static int gbe_slave_open(struct gbe_intf *gbe_intf)
 
 	void (*hndlr)(struct net_device *) = gbe_adjust_link;
 
-	gbe_sgmii_config(priv, slave);
+	if (IS_SS_ID_VER_14(priv) || IS_SS_ID_NU(priv))
+		gbe_sgmii_config(priv, slave);
 	gbe_port_reset(slave);
 	gbe_sgmii_rtreset(priv, slave, false);
 	gbe_port_config(priv, slave, priv->rx_packet_max);
@@ -3042,7 +3043,8 @@ static void init_secondary_ports(struct gbe_priv *gbe_dev,
 			continue;
 		}
 
-		gbe_sgmii_config(gbe_dev, slave);
+		if (IS_SS_ID_VER_14(gbe_dev) || IS_SS_ID_NU(gbe_dev))
+			gbe_sgmii_config(gbe_dev, slave);
 		gbe_port_reset(slave);
 		gbe_port_config(gbe_dev, slave, gbe_dev->rx_packet_max);
 		list_add_tail(&slave->slave_list, &gbe_dev->secondary_slaves);
-- 
1.9.1
