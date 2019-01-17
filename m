Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A66AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C2420652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfAQMXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:23:14 -0500
Received: from inva021.nxp.com ([92.121.34.21]:55474 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727501AbfAQMXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 07:23:14 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1B695200197;
        Thu, 17 Jan 2019 13:23:12 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0E99B200029;
        Thu, 17 Jan 2019 13:23:12 +0100 (CET)
Received: from fsr-ub1464-019.ea.freescale.net (fsr-ub1464-019.ea.freescale.net [10.171.81.207])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id A70F320618;
        Thu, 17 Jan 2019 13:23:11 +0100 (CET)
From:   Camelia Groza <camelia.groza@nxp.com>
To:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        davem@davemloft.net, oss@buserror.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Camelia Groza <camelia.groza@nxp.com>
Subject: [PATCH net v2] net: phy: phy driver features are mandatory
Date:   Thu, 17 Jan 2019 14:22:36 +0200
Message-Id: <1547727756-18854-1-git-send-email-camelia.groza@nxp.com>
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
v2: Print the name of the driver that has missing features.

This patch should be merged to 4.20 stable.
---
 drivers/net/phy/phy_device.c | 5 +++++
 include/linux/phy.h          | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index bf3ce48..46c8672 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2255,6 +2255,11 @@ int phy_driver_register(struct phy_driver *new_driver, struct module *owner)
 {
 	int retval;
 
+	if (WARN_ON(!new_driver->features)) {
+		pr_err("%s: Driver features are missing\n", new_driver->name);
+		return -EINVAL;
+	}
+
 	new_driver->mdiodrv.flags |= MDIO_DEVICE_IS_PHY;
 	new_driver->mdiodrv.driver.name = new_driver->name;
 	new_driver->mdiodrv.driver.bus = &mdio_bus_type;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5511465..ef20aee 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -469,8 +469,8 @@ struct phy_device {
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

