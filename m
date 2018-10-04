Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979B7C64EBD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CA520684
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51CA520684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeJDToO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:44:14 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37509 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbeJDToL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:44:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 26E08208B7; Thu,  4 Oct 2018 14:50:59 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id CC3BD207B4;
        Thu,  4 Oct 2018 14:50:48 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next v2 1/6] net: phy: mscc: migrate to phy_select/restore_page functions
Date:   Thu,  4 Oct 2018 14:47:23 +0200
Message-Id: <20181004124728.9821-2-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004124728.9821-1-quentin.schulz@bootlin.com>
References: <20181004124728.9821-1-quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Microsemi PHYs have multiple banks of registers (called pages).
Registers can only be accessed from one page, if we need a register from
another page, we need to switch the page and the registers of all other
pages are not accessible anymore.

Basically, to read register 5 from page 0, 1, 2, etc., you do the same
phy_read(phydev, 5); but you need to set the desired page beforehand.

In order to guarantee that two concurrent functions do not change the
page, we need to do some locking per page. This can be achieved with the
use of phy_select_page and phy_restore_page functions but phy_write/read
calls in-between those two functions shall be replaced by their
lock-free alternative __phy_write/read.

Let's migrate this driver to those functions.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/net/phy/mscc.c | 142 +++++++++++++++++++++++------------------
 1 file changed, 79 insertions(+), 63 deletions(-)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index 7d0384e26c99..35d58e7b95e9 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -140,12 +140,14 @@ static const struct vsc8531_edge_rate_table edge_table[] = {
 };
 #endif /* CONFIG_OF_MDIO */
 
-static int vsc85xx_phy_page_set(struct phy_device *phydev, u16 page)
+static int vsc85xx_phy_read_page(struct phy_device *phydev)
 {
-	int rc;
+	return __phy_read(phydev, MSCC_EXT_PAGE_ACCESS);
+}
 
-	rc = phy_write(phydev, MSCC_EXT_PAGE_ACCESS, page);
-	return rc;
+static int vsc85xx_phy_write_page(struct phy_device *phydev, int page)
+{
+	return __phy_write(phydev, MSCC_EXT_PAGE_ACCESS, page);
 }
 
 static int vsc85xx_led_cntl_set(struct phy_device *phydev,
@@ -180,7 +182,7 @@ static int vsc85xx_mdix_get(struct phy_device *phydev, u8 *mdix)
 
 static int vsc85xx_mdix_set(struct phy_device *phydev, u8 mdix)
 {
-	int rc;
+	int rc, oldpage;
 	u16 reg_val;
 
 	reg_val = phy_read(phydev, MSCC_PHY_BYPASS_CONTROL);
@@ -197,25 +199,30 @@ static int vsc85xx_mdix_set(struct phy_device *phydev, u8 mdix)
 	if (rc != 0)
 		return rc;
 
-	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_EXTENDED);
-	if (rc != 0)
-		return rc;
+	oldpage = phy_select_page(phydev, MSCC_PHY_PAGE_EXTENDED);
+	if (oldpage < 0) {
+		rc = oldpage;
+		goto out;
+	}
 
-	reg_val = phy_read(phydev, MSCC_PHY_EXT_MODE_CNTL);
+	reg_val = __phy_read(phydev, MSCC_PHY_EXT_MODE_CNTL);
 	reg_val &= ~(FORCE_MDI_CROSSOVER_MASK);
 	if (mdix == ETH_TP_MDI)
 		reg_val |= FORCE_MDI_CROSSOVER_MDI;
 	else if (mdix == ETH_TP_MDI_X)
 		reg_val |= FORCE_MDI_CROSSOVER_MDIX;
-	rc = phy_write(phydev, MSCC_PHY_EXT_MODE_CNTL, reg_val);
+	rc = __phy_write(phydev, MSCC_PHY_EXT_MODE_CNTL, reg_val);
 	if (rc != 0)
-		return rc;
+		goto out;
 
-	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_STANDARD);
-	if (rc != 0)
+	rc = phy_restore_page(phydev, oldpage, rc);
+	if (rc < 0)
 		return rc;
 
 	return genphy_restart_aneg(phydev);
+
+out:
+	return phy_restore_page(phydev, oldpage, rc);
 }
 
 static int vsc85xx_downshift_get(struct phy_device *phydev, u8 *count)
@@ -223,25 +230,24 @@ static int vsc85xx_downshift_get(struct phy_device *phydev, u8 *count)
 	int rc;
 	u16 reg_val;
 
-	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_EXTENDED);
-	if (rc != 0)
+	rc = phy_select_page(phydev, MSCC_PHY_PAGE_EXTENDED);
+	if (rc < 0)
 		goto out;
 
-	reg_val = phy_read(phydev, MSCC_PHY_ACTIPHY_CNTL);
+	reg_val = __phy_read(phydev, MSCC_PHY_ACTIPHY_CNTL);
 	reg_val &= DOWNSHIFT_CNTL_MASK;
 	if (!(reg_val & DOWNSHIFT_EN))
 		*count = DOWNSHIFT_DEV_DISABLE;
 	else
 		*count = ((reg_val & ~DOWNSHIFT_EN) >> DOWNSHIFT_CNTL_POS) + 2;
-	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_STANDARD);
 
 out:
-	return rc;
+	return phy_restore_page(phydev, rc, rc > 0 ? 0 : rc);
 }
 
 static int vsc85xx_downshift_set(struct phy_device *phydev, u8 count)
 {
-	int rc;
+	int rc, oldpage;
 	u16 reg_val;
 
 	if (count == DOWNSHIFT_DEV_DEFAULT_COUNT) {
@@ -255,21 +261,19 @@ static int vsc85xx_downshift_set(struct phy_device *phydev, u8 count)
 		count = (((count - 2) << DOWNSHIFT_CNTL_POS) | DOWNSHIFT_EN);
 	}
 
-	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_EXTENDED);
-	if (rc != 0)
+	oldpage = phy_select_page(phydev, MSCC_PHY_PAGE_EXTENDED);
+	if (oldpage < 0) {
+		rc = oldpage;
 		goto out;
+	}
 
-	reg_val = phy_read(phydev, MSCC_PHY_ACTIPHY_CNTL);
+	reg_val = __phy_read(phydev, MSCC_PHY_ACTIPHY_CNTL);
 	reg_val &= ~(DOWNSHIFT_CNTL_MASK);
 	reg_val |= count;
-	rc = phy_write(phydev, MSCC_PHY_ACTIPHY_CNTL, reg_val);
-	if (rc != 0)
-		goto out;
-
-	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_STANDARD);
+	rc = __phy_write(phydev, MSCC_PHY_ACTIPHY_CNTL, reg_val);
 
 out:
-	return rc;
+	return phy_restore_page(phydev, oldpage, rc > 0 ? 0 : rc);
 }
 
 static int vsc85xx_wol_set(struct phy_device *phydev,
@@ -283,46 +287,48 @@ static int vsc85xx_wol_set(struct phy_device *phydev,
 	u8 *mac_addr = phydev->attached_dev->dev_addr;
 
 	mutex_lock(&phydev->lock);
-	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_EXTENDED_2);
-	if (rc != 0)
+	rc = phy_select_page(phydev, MSCC_PHY_PAGE_EXTENDED_2);
+	if (rc < 0) {
+		rc = phy_restore_page(phydev, rc, rc);
 		goto out_unlock;
+	}
 
 	if (wol->wolopts & WAKE_MAGIC) {
 		/* Store the device address for the magic packet */
 		for (i = 0; i < ARRAY_SIZE(pwd); i++)
 			pwd[i] = mac_addr[5 - (i * 2 + 1)] << 8 |
 				 mac_addr[5 - i * 2];
-		phy_write(phydev, MSCC_PHY_WOL_LOWER_MAC_ADDR, pwd[0]);
-		phy_write(phydev, MSCC_PHY_WOL_MID_MAC_ADDR, pwd[1]);
-		phy_write(phydev, MSCC_PHY_WOL_UPPER_MAC_ADDR, pwd[2]);
+		__phy_write(phydev, MSCC_PHY_WOL_LOWER_MAC_ADDR, pwd[0]);
+		__phy_write(phydev, MSCC_PHY_WOL_MID_MAC_ADDR, pwd[1]);
+		__phy_write(phydev, MSCC_PHY_WOL_UPPER_MAC_ADDR, pwd[2]);
 	} else {
-		phy_write(phydev, MSCC_PHY_WOL_LOWER_MAC_ADDR, 0);
-		phy_write(phydev, MSCC_PHY_WOL_MID_MAC_ADDR, 0);
-		phy_write(phydev, MSCC_PHY_WOL_UPPER_MAC_ADDR, 0);
+		__phy_write(phydev, MSCC_PHY_WOL_LOWER_MAC_ADDR, 0);
+		__phy_write(phydev, MSCC_PHY_WOL_MID_MAC_ADDR, 0);
+		__phy_write(phydev, MSCC_PHY_WOL_UPPER_MAC_ADDR, 0);
 	}
 
 	if (wol_conf->wolopts & WAKE_MAGICSECURE) {
 		for (i = 0; i < ARRAY_SIZE(pwd); i++)
 			pwd[i] = wol_conf->sopass[5 - (i * 2 + 1)] << 8 |
 				 wol_conf->sopass[5 - i * 2];
-		phy_write(phydev, MSCC_PHY_WOL_LOWER_PASSWD, pwd[0]);
-		phy_write(phydev, MSCC_PHY_WOL_MID_PASSWD, pwd[1]);
-		phy_write(phydev, MSCC_PHY_WOL_UPPER_PASSWD, pwd[2]);
+		__phy_write(phydev, MSCC_PHY_WOL_LOWER_PASSWD, pwd[0]);
+		__phy_write(phydev, MSCC_PHY_WOL_MID_PASSWD, pwd[1]);
+		__phy_write(phydev, MSCC_PHY_WOL_UPPER_PASSWD, pwd[2]);
 	} else {
-		phy_write(phydev, MSCC_PHY_WOL_LOWER_PASSWD, 0);
-		phy_write(phydev, MSCC_PHY_WOL_MID_PASSWD, 0);
-		phy_write(phydev, MSCC_PHY_WOL_UPPER_PASSWD, 0);
+		__phy_write(phydev, MSCC_PHY_WOL_LOWER_PASSWD, 0);
+		__phy_write(phydev, MSCC_PHY_WOL_MID_PASSWD, 0);
+		__phy_write(phydev, MSCC_PHY_WOL_UPPER_PASSWD, 0);
 	}
 
-	reg_val = phy_read(phydev, MSCC_PHY_WOL_MAC_CONTROL);
+	reg_val = __phy_read(phydev, MSCC_PHY_WOL_MAC_CONTROL);
 	if (wol_conf->wolopts & WAKE_MAGICSECURE)
 		reg_val |= SECURE_ON_ENABLE;
 	else
 		reg_val &= ~SECURE_ON_ENABLE;
-	phy_write(phydev, MSCC_PHY_WOL_MAC_CONTROL, reg_val);
+	__phy_write(phydev, MSCC_PHY_WOL_MAC_CONTROL, reg_val);
 
-	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_STANDARD);
-	if (rc != 0)
+	rc = phy_restore_page(phydev, rc, rc > 0 ? 0 : rc);
+	if (rc < 0)
 		goto out_unlock;
 
 	if (wol->wolopts & WAKE_MAGIC) {
@@ -359,17 +365,17 @@ static void vsc85xx_wol_get(struct phy_device *phydev,
 	struct ethtool_wolinfo *wol_conf = wol;
 
 	mutex_lock(&phydev->lock);
-	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_EXTENDED_2);
-	if (rc != 0)
+	rc = phy_select_page(phydev, MSCC_PHY_PAGE_EXTENDED_2);
+	if (rc < 0)
 		goto out_unlock;
 
-	reg_val = phy_read(phydev, MSCC_PHY_WOL_MAC_CONTROL);
+	reg_val = __phy_read(phydev, MSCC_PHY_WOL_MAC_CONTROL);
 	if (reg_val & SECURE_ON_ENABLE)
 		wol_conf->wolopts |= WAKE_MAGICSECURE;
 	if (wol_conf->wolopts & WAKE_MAGICSECURE) {
-		pwd[0] = phy_read(phydev, MSCC_PHY_WOL_LOWER_PASSWD);
-		pwd[1] = phy_read(phydev, MSCC_PHY_WOL_MID_PASSWD);
-		pwd[2] = phy_read(phydev, MSCC_PHY_WOL_UPPER_PASSWD);
+		pwd[0] = __phy_read(phydev, MSCC_PHY_WOL_LOWER_PASSWD);
+		pwd[1] = __phy_read(phydev, MSCC_PHY_WOL_MID_PASSWD);
+		pwd[2] = __phy_read(phydev, MSCC_PHY_WOL_UPPER_PASSWD);
 		for (i = 0; i < ARRAY_SIZE(pwd); i++) {
 			wol_conf->sopass[5 - i * 2] = pwd[i] & 0x00ff;
 			wol_conf->sopass[5 - (i * 2 + 1)] = (pwd[i] & 0xff00)
@@ -377,9 +383,8 @@ static void vsc85xx_wol_get(struct phy_device *phydev,
 		}
 	}
 
-	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_STANDARD);
-
 out_unlock:
+	phy_restore_page(phydev, rc, rc > 0 ? 0 : rc);
 	mutex_unlock(&phydev->lock);
 }
 
@@ -473,22 +478,25 @@ static int vsc85xx_dt_led_modes_get(struct phy_device *phydev,
 
 static int vsc85xx_edge_rate_cntl_set(struct phy_device *phydev, u8 edge_rate)
 {
-	int rc;
+	int rc, oldpage;
 	u16 reg_val;
 
 	mutex_lock(&phydev->lock);
-	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_EXTENDED_2);
-	if (rc != 0)
+	oldpage = phy_select_page(phydev, MSCC_PHY_PAGE_EXTENDED_2);
+	if (oldpage < 0) {
+		rc = oldpage;
 		goto out_unlock;
-	reg_val = phy_read(phydev, MSCC_PHY_WOL_MAC_CONTROL);
+	}
+
+	reg_val = __phy_read(phydev, MSCC_PHY_WOL_MAC_CONTROL);
 	reg_val &= ~(EDGE_RATE_CNTL_MASK);
 	reg_val |= (edge_rate << EDGE_RATE_CNTL_POS);
-	rc = phy_write(phydev, MSCC_PHY_WOL_MAC_CONTROL, reg_val);
+	rc = __phy_write(phydev, MSCC_PHY_WOL_MAC_CONTROL, reg_val);
 	if (rc != 0)
 		goto out_unlock;
-	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_STANDARD);
 
 out_unlock:
+	rc = phy_restore_page(phydev, oldpage, rc > 0 ? 0 : rc);
 	mutex_unlock(&phydev->lock);
 
 	return rc;
@@ -537,17 +545,17 @@ static int vsc85xx_default_config(struct phy_device *phydev)
 
 	phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
 	mutex_lock(&phydev->lock);
-	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_EXTENDED_2);
-	if (rc != 0)
+	rc = phy_select_page(phydev, MSCC_PHY_PAGE_EXTENDED_2);
+	if (rc < 0)
 		goto out_unlock;
 
 	reg_val = phy_read(phydev, MSCC_PHY_RGMII_CNTL);
 	reg_val &= ~(RGMII_RX_CLK_DELAY_MASK);
 	reg_val |= (RGMII_RX_CLK_DELAY_1_1_NS << RGMII_RX_CLK_DELAY_POS);
 	phy_write(phydev, MSCC_PHY_RGMII_CNTL, reg_val);
-	rc = vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_STANDARD);
 
 out_unlock:
+	rc = phy_restore_page(phydev, rc, rc > 0 ? 0 : rc);
 	mutex_unlock(&phydev->lock);
 
 	return rc;
@@ -699,6 +707,8 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_wol	= &vsc85xx_wol_get,
 	.get_tunable	= &vsc85xx_get_tunable,
 	.set_tunable	= &vsc85xx_set_tunable,
+	.read_page	= &vsc85xx_phy_read_page,
+	.write_page	= &vsc85xx_phy_write_page,
 },
 {
 	.phy_id		= PHY_ID_VSC8531,
@@ -720,6 +730,8 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_wol	= &vsc85xx_wol_get,
 	.get_tunable	= &vsc85xx_get_tunable,
 	.set_tunable	= &vsc85xx_set_tunable,
+	.read_page	= &vsc85xx_phy_read_page,
+	.write_page	= &vsc85xx_phy_write_page,
 },
 {
 	.phy_id		= PHY_ID_VSC8540,
@@ -741,6 +753,8 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_wol	= &vsc85xx_wol_get,
 	.get_tunable	= &vsc85xx_get_tunable,
 	.set_tunable	= &vsc85xx_set_tunable,
+	.read_page	= &vsc85xx_phy_read_page,
+	.write_page	= &vsc85xx_phy_write_page,
 },
 {
 	.phy_id		= PHY_ID_VSC8541,
@@ -762,6 +776,8 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_wol	= &vsc85xx_wol_get,
 	.get_tunable	= &vsc85xx_get_tunable,
 	.set_tunable	= &vsc85xx_set_tunable,
+	.read_page	= &vsc85xx_phy_read_page,
+	.write_page	= &vsc85xx_phy_write_page,
 }
 
 };
-- 
2.17.1

