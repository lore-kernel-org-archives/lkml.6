Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rGhiMQJYGVsVfgAAmS7hNA
	; Thu, 07 Jun 2018 16:06:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B573A607E7; Thu,  7 Jun 2018 16:06:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 46FFD60590;
	Thu,  7 Jun 2018 16:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 46FFD60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=rockwellcollins.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936009AbeFGQGY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:06:24 -0400
Received: from da1vs01.rockwellcollins.com ([205.175.227.27]:60116 "EHLO
        da1vs01.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933058AbeFGQGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:06:19 -0400
X-Greylist: delayed 574 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jun 2018 12:06:19 EDT
Received: from ofwda1n02.rockwellcollins.com (HELO ciulimr02.rockwellcollins.com) ([205.175.227.14])
  by da1vs01.rockwellcollins.com with ESMTP; 07 Jun 2018 10:56:44 -0500
X-Received: from righttwix.rockwellcollins.com (righttwix.rockwellcollins.com [192.168.141.218])
        by ciulimr02.rockwellcollins.com (Postfix) with ESMTP id 4E3BD20094;
        Thu,  7 Jun 2018 10:56:44 -0500 (CDT)
From: Brandon Maier <brandon.maier@rockwellcollins.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
        michal.simek@xilinx.com, clayton.shotwell@rockwellcollins.com,
        kristopher.cory@rockwellcollins.com, linux-kernel@vger.kernel.org,
        Brandon Maier <brandon.maier@rockwellcollins.com>
Subject: [PATCH 1/3] net: phy: Check phy_driver ready before accessing
Date: Thu,  7 Jun 2018 10:53:46 -0500
Message-Id: <20180607155348.149665-1-brandon.maier@rockwellcollins.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a phy_device is added to the global mdio_bus list during
phy_device_register(), but a phy_device's phy_driver doesn't get
attached until phy_probe(). It's possible of_phy_find_device() in
xgmiitorgmii will return a valid phy with a NULL phy_driver. Leading to
a NULL pointer access during the memcpy().

Signed-off-by: Brandon Maier <brandon.maier@rockwellcollins.com>
---
 drivers/net/phy/xilinx_gmii2rgmii.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
index 2e5150b0b8d5..04c8bec1c4c1 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -81,6 +81,11 @@ static int xgmiitorgmii_probe(struct mdio_device *mdiodev)
 		return -EPROBE_DEFER;
 	}
 
+	if (!priv->phy_dev->drv) {
+		dev_info(dev, "Attached phy not ready\n");
+		return -EPROBE_DEFER;
+	}
+
 	priv->addr = mdiodev->addr;
 	priv->phy_drv = priv->phy_dev->drv;
 	memcpy(&priv->conv_phy_drv, priv->phy_dev->drv,
-- 
2.14.3
