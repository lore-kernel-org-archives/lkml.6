Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA42BC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C582F2184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfAWP7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:59:48 -0500
Received: from mail.bootlin.com ([62.4.15.54]:42255 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbfAWP7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 10:59:17 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6DF73207AC; Wed, 23 Jan 2019 16:59:14 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id 32339209BF;
        Wed, 23 Jan 2019 16:58:56 +0100 (CET)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, sd@queasysnail.net, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        quentin.schulz@bootlin.com, allan.nielsen@microchip.com
Subject: [PATCH net-next 08/10] net: phy: export __phy_read_page/__phy_write_page
Date:   Wed, 23 Jan 2019 16:56:36 +0100
Message-Id: <20190123155638.13852-9-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190123155638.13852-1-antoine.tenart@bootlin.com>
References: <20190123155638.13852-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch exports the __phy_read_page and __phy_write_page helpers, to
allow reading and setting the current page when a function already holds
the MDIO lock.

This is something the Microsemi PHY driver does during its
initialization because parts of its registers and engines are shared
between ports. With the upcoming MACsec offloading support in this PHY,
we'll need to configure the MACsec engine and to do so changing pages is
required.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/phy/phy-core.c | 6 ++++--
 include/linux/phy.h        | 3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 909b3344babf..be0c65b6e2da 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -538,15 +538,17 @@ int phy_modify(struct phy_device *phydev, u32 regnum, u16 mask, u16 set)
 }
 EXPORT_SYMBOL_GPL(phy_modify);
 
-static int __phy_read_page(struct phy_device *phydev)
+int __phy_read_page(struct phy_device *phydev)
 {
 	return phydev->drv->read_page(phydev);
 }
+EXPORT_SYMBOL_GPL(__phy_read_page);
 
-static int __phy_write_page(struct phy_device *phydev, int page)
+int __phy_write_page(struct phy_device *phydev, int page)
 {
 	return phydev->drv->write_page(phydev, page);
 }
+EXPORT_SYMBOL_GPL(__phy_write_page);
 
 /**
  * phy_save_page() - take the bus lock and save the current page
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 21839f352e7c..5f17080bc697 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -766,6 +766,9 @@ static inline int __phy_write(struct phy_device *phydev, u32 regnum, u16 val)
 			       val);
 }
 
+int __phy_read_page(struct phy_device *phydev);
+int __phy_write_page(struct phy_device *phydev, int page);
+
 int __phy_modify(struct phy_device *phydev, u32 regnum, u16 mask, u16 set);
 int phy_modify(struct phy_device *phydev, u32 regnum, u16 mask, u16 set);
 
-- 
2.20.1

