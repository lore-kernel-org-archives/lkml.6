Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162502AbeE1OP6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:15:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161937AbeE1KgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:36:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Sealey <matt.sealey@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 189/329] net: smsc911x: Fix unload crash when link is up
Date: Mon, 28 May 2018 12:01:58 +0200
Message-Id: <20180528100258.035462140@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeremy Linton <jeremy.linton@arm.com>

[ Upstream commit e06513d78d54e6c7026c9043a39e2c01ee25bdbe ]

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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/smsc/smsc911x.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -2330,14 +2330,14 @@ static int smsc911x_drv_remove(struct pl
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
