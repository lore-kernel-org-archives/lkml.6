Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbeEOXha (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 19:37:30 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:24102 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeEOXh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 19:37:28 -0400
From: Grygorii Strashko <grygorii.strashko@ti.com>
To: "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>
CC: Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next v2] net: ethernet: ti: cpsw-phy-sel: check bus_find_device() ret value
Date: Tue, 15 May 2018 18:37:25 -0500
Message-ID: <20180515233725.11882-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes klockworks warnings: Pointer 'dev' returned from call to
function 'bus_find_device' at line 179 may be NULL and will be dereferenced
at line 181.

    cpsw-phy-sel.c:179: 'dev' is assigned the return value from function 'bus_find_device'.
    bus.c:342: 'bus_find_device' explicitly returns a NULL value.
    cpsw-phy-sel.c:181: 'dev' is dereferenced by passing argument 1 to function 'dev_get_drvdata'.
    device.h:1024: 'dev' is passed to function 'dev_get_drvdata'.
    device.h:1026: 'dev' is explicitly dereferenced.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
[nsekhar@ti.com: add an error message, fix return path]
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
v2: use %pOF

 drivers/net/ethernet/ti/cpsw-phy-sel.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw-phy-sel.c b/drivers/net/ethernet/ti/cpsw-phy-sel.c
index 1801364..0c1adad 100644
--- a/drivers/net/ethernet/ti/cpsw-phy-sel.c
+++ b/drivers/net/ethernet/ti/cpsw-phy-sel.c
@@ -177,12 +177,18 @@ void cpsw_phy_sel(struct device *dev, phy_interface_t phy_mode, int slave)
 	}
 
 	dev = bus_find_device(&platform_bus_type, NULL, node, match);
-	of_node_put(node);
+	if (!dev) {
+		dev_err(dev, "unable to find platform device for %pOF\n", node);
+		goto out;
+	}
+
 	priv = dev_get_drvdata(dev);
 
 	priv->cpsw_phy_sel(priv, phy_mode, slave);
 
 	put_device(dev);
+out:
+	of_node_put(node);
 }
 EXPORT_SYMBOL_GPL(cpsw_phy_sel);
 
-- 
2.10.5
