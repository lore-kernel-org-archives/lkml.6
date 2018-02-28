Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934469AbeB1UAr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 15:00:47 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:40990 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932712AbeB1T67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 14:58:59 -0500
X-Google-Smtp-Source: AG47ELu45IXu89yHICgG1kQnBAAMGrzifaRp/rN+k/i8CprIWmo2rHQOBQKJM+pzXgMLBsvn5g8QFw==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Russell King <rmk@armlinux.org.uk>,
        linux-kernel@vger.kernel.org (open list), moritz.fischer@ettus.com
Subject: [PATCH net-next v2 2/5] net: phy: Export gen10g_* functions
Date: Wed, 28 Feb 2018 11:58:46 -0800
Message-Id: <20180228195849.17770-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180228195849.17770-1-f.fainelli@gmail.com>
References: <20180228195849.17770-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to remove a fair amount of duplication in the different 10G PHY
drivers, export all gen10g_* functions to be able to make use of those.
While we are at it, rename gen10g_soft_reset() to gen10g_no_soft_reset()
to illustrate what it does.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/phy-c45.c | 20 +++++++++++++-------
 include/linux/phy.h       |  8 ++++++++
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index a4576859afae..0017eddc24db 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -268,12 +268,13 @@ EXPORT_SYMBOL_GPL(genphy_c45_read_mdix);
 
 /* The gen10g_* functions are the old Clause 45 stub */
 
-static int gen10g_config_aneg(struct phy_device *phydev)
+int gen10g_config_aneg(struct phy_device *phydev)
 {
 	return 0;
 }
+EXPORT_SYMBOL_GPL(gen10g_config_aneg);
 
-static int gen10g_read_status(struct phy_device *phydev)
+int gen10g_read_status(struct phy_device *phydev)
 {
 	u32 mmd_mask = phydev->c45_ids.devices_in_package;
 	int ret;
@@ -291,14 +292,16 @@ static int gen10g_read_status(struct phy_device *phydev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(gen10g_read_status);
 
-static int gen10g_soft_reset(struct phy_device *phydev)
+int gen10g_no_soft_reset(struct phy_device *phydev)
 {
 	/* Do nothing for now */
 	return 0;
 }
+EXPORT_SYMBOL_GPL(gen10g_no_soft_reset);
 
-static int gen10g_config_init(struct phy_device *phydev)
+int gen10g_config_init(struct phy_device *phydev)
 {
 	/* Temporarily just say we support everything */
 	phydev->supported = SUPPORTED_10000baseT_Full;
@@ -306,22 +309,25 @@ static int gen10g_config_init(struct phy_device *phydev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(gen10g_config_init);
 
-static int gen10g_suspend(struct phy_device *phydev)
+int gen10g_suspend(struct phy_device *phydev)
 {
 	return 0;
 }
+EXPORT_SYMBOL_GPL(gen10g_suspend);
 
-static int gen10g_resume(struct phy_device *phydev)
+int gen10g_resume(struct phy_device *phydev)
 {
 	return 0;
 }
+EXPORT_SYMBOL_GPL(gen10g_resume);
 
 struct phy_driver genphy_10g_driver = {
 	.phy_id         = 0xffffffff,
 	.phy_id_mask    = 0xffffffff,
 	.name           = "Generic 10G PHY",
-	.soft_reset	= gen10g_soft_reset,
+	.soft_reset	= gen10g_no_soft_reset,
 	.config_init    = gen10g_config_init,
 	.features       = 0,
 	.config_aneg    = gen10g_config_aneg,
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5a0c3e53e7c2..6e38c699b753 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -994,6 +994,14 @@ int genphy_c45_pma_setup_forced(struct phy_device *phydev);
 int genphy_c45_an_disable_aneg(struct phy_device *phydev);
 int genphy_c45_read_mdix(struct phy_device *phydev);
 
+/* The gen10g_* functions are the old Clause 45 stub */
+int gen10g_config_aneg(struct phy_device *phydev);
+int gen10g_read_status(struct phy_device *phydev);
+int gen10g_no_soft_reset(struct phy_device *phydev);
+int gen10g_config_init(struct phy_device *phydev);
+int gen10g_suspend(struct phy_device *phydev);
+int gen10g_resume(struct phy_device *phydev);
+
 static inline int phy_read_status(struct phy_device *phydev)
 {
 	if (!phydev->drv)
-- 
2.14.1
