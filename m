Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDE6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D52A20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfAOMfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:35:48 -0500
Received: from inva021.nxp.com ([92.121.34.21]:44996 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbfAOMfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:35:48 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AFE5B2000B1;
        Tue, 15 Jan 2019 13:35:45 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A234C20003B;
        Tue, 15 Jan 2019 13:35:45 +0100 (CET)
Received: from fsr-ub1464-019.ea.freescale.net (fsr-ub1464-019.ea.freescale.net [10.171.81.207])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 46553205DC;
        Tue, 15 Jan 2019 13:35:45 +0100 (CET)
From:   Camelia Groza <camelia.groza@nxp.com>
To:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        davem@davemloft.net, oss@buserror.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Camelia Groza <camelia.groza@nxp.com>
Subject: [PATCH net] net: phy: phy driver features are mandatory
Date:   Tue, 15 Jan 2019 14:35:19 +0200
Message-Id: <1547555719-13541-1-git-send-email-camelia.groza@nxp.com>
X-Mailer: git-send-email 1.9.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since phy driver features became a link_mode bitmap, phy drivers that
don't have a list of features configured will cause the kernel to crash
when probed.

Prevent the phy driver from registering if the features field is missing.

Fixes: 719655a14971 ("net: phy: Replace phy driver features u32 with link_mode bitmap")
Reported-by: Scott Wood <oss@buserror.net>
Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
---
This patch should be merged to 4.20 stable.
---
 drivers/net/phy/phy_device.c | 3 +++
 include/linux/phy.h          | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 5199000..f70dfb3 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2243,6 +2243,9 @@ int phy_driver_register(struct phy_driver *new_driver, struct module *owner)
 {
 	int retval;
 
+	if (WARN_ON(!new_driver->features))
+		return -EINVAL;
+
 	new_driver->mdiodrv.flags |= MDIO_DEVICE_IS_PHY;
 	new_driver->mdiodrv.driver.name = new_driver->name;
 	new_driver->mdiodrv.driver.bus = &mdio_bus_type;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 3b051f7..ec3b6d5 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -467,8 +467,8 @@ struct phy_device {
  *   only works for PHYs with IDs which match this field
  * name: The friendly name of this PHY type
  * phy_id_mask: Defines the important bits of the phy_id
- * features: A list of features (speed, duplex, etc) supported
- *   by this PHY
+ * features: A mandatory list of features (speed, duplex, etc)
+ *   supported by this PHY
  * flags: A bitfield defining certain other features this PHY
  *   supports (like interrupts)
  *
-- 
1.9.1

