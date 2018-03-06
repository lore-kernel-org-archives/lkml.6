Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933030AbeCFPAZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 10:00:25 -0500
Received: from foss.arm.com ([217.140.101.70]:39796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932537AbeCFPAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 10:00:24 -0500
From: Jeremy Linton <jeremy.linton@arm.com>
To: netdev@vger.kernel.org
Cc: steve.glendinning@shawell.net, matt.sealey@arm.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] net: smsc911x: Fix unload crash when link is up
Date: Tue,  6 Mar 2018 09:00:06 -0600
Message-Id: <20180306150006.31512-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The smsc911x driver will crash if it is rmmod'ed while the netdev
is up like:

Call trace:
  phy_detach+0x94/0x150
  phy_disconnect+0x40/0x50
  smsc911x_stop+0x104/0x128 [smsc911x]
  __dev_close_many+0xb4/0x138
  dev_close_many+0xbc/0x190
  rollback_registered_many+0x140/0x460
  rollback_registered+0x68/0xb0
  unregister_netdevice_queue+0x100/0x118
  unregister_netdev+0x28/0x38
  smsc911x_drv_remove+0x58/0x130 [smsc911x]
  platform_drv_remove+0x30/0x50
  device_release_driver_internal+0x15c/0x1f8
  driver_detach+0x54/0x98
  bus_remove_driver+0x64/0xe8
  driver_unregister+0x34/0x60
  platform_driver_unregister+0x20/0x30
  smsc911x_cleanup_module+0x14/0xbca8 [smsc911x]
  SyS_delete_module+0x1e8/0x238
  __sys_trace_return+0x0/0x4

This is caused by the mdiobus being unregistered/free'd
and the code in phy_detach() attempting to manipulate mdio
related structures from unregister_netdev() calling close()

To fix this, we delay the mdiobus teardown until after
the netdev is deregistered.

Reported-by: Matt Sealey <matt.sealey@arm.com>
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/net/ethernet/smsc/smsc911x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index 012fb66eed8d..f0afb88d7bc2 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -2335,14 +2335,14 @@ static int smsc911x_drv_remove(struct platform_device *pdev)
 	pdata = netdev_priv(dev);
 	BUG_ON(!pdata);
 	BUG_ON(!pdata->ioaddr);
-	WARN_ON(dev->phydev);
 
 	SMSC_TRACE(pdata, ifdown, "Stopping driver");
 
+	unregister_netdev(dev);
+
 	mdiobus_unregister(pdata->mii_bus);
 	mdiobus_free(pdata->mii_bus);
 
-	unregister_netdev(dev);
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 					   "smsc911x-memory");
 	if (!res)
-- 
2.13.6
