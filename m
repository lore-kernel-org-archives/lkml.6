Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754248AbeCRTt7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 15:49:59 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:40702 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752711AbeCRTt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 15:49:57 -0400
X-Google-Smtp-Source: AG47ELuSVkF924W2RbOA1ntOi3qfAVIVGwWThgGZZImWAHTOexP0UPuduVSjtIOQXIuwo17F3eMFBg==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, andrew@lunn.ch, l.stach@pengutronix.de,
        Florian Fainelli <f.fainelli@gmail.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: fec: Fix unbalanced PM runtime calls
Date: Sun, 18 Mar 2018 12:49:51 -0700
Message-Id: <20180318194952.31411-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When unbinding/removing the driver, we will run into the following warnings:

[  259.655198] fec 400d1000.ethernet: 400d1000.ethernet supply phy not found, using dummy regulator
[  259.665065] fec 400d1000.ethernet: Unbalanced pm_runtime_enable!
[  259.672770] fec 400d1000.ethernet (unnamed net_device) (uninitialized): Invalid MAC address: 00:00:00:00:00:00
[  259.683062] fec 400d1000.ethernet (unnamed net_device) (uninitialized): Using random MAC address: f2:3e:93:b7:29:c1
[  259.696239] libphy: fec_enet_mii_bus: probed

Avoid these warnings by balancing the runtime PM calls during fec_drv_remove().

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 7a7f3a42b2aa..d4604bc8eb5b 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3600,6 +3600,8 @@ fec_drv_remove(struct platform_device *pdev)
 	fec_enet_mii_remove(fep);
 	if (fep->reg_phy)
 		regulator_disable(fep->reg_phy);
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	if (of_phy_is_fixed_link(np))
 		of_phy_deregister_fixed_link(np);
 	of_node_put(fep->phy_node);
-- 
2.14.1
