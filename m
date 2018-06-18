Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8C3C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8994220874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8994220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934043AbeFRIPq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:15:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52858 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933970AbeFRIPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:15:42 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9AA9DC50;
        Mon, 18 Jun 2018 08:15:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Raghuram Chary J <raghuramchary.jallipalli@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 007/279] lan78xx: PHY DSP registers initialization to address EEE link drop issues with long cables
Date:   Mon, 18 Jun 2018 10:09:52 +0200
Message-Id: <20180618080609.141891469@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raghuram Chary J <raghuramchary.jallipalli@microchip.com>

[ Upstream commit 1c2734b31d72316e3faaad88c0c9c46fa92a4b20 ]

The patch is to configure DSP registers of PHY device
to handle Gbe-EEE failures with >40m cable length.

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
Signed-off-by: Raghuram Chary J <raghuramchary.jallipalli@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/microchip.c  |  178 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/microchipphy.h |    8 +
 2 files changed, 185 insertions(+), 1 deletion(-)

--- a/drivers/net/phy/microchip.c
+++ b/drivers/net/phy/microchip.c
@@ -20,6 +20,7 @@
 #include <linux/ethtool.h>
 #include <linux/phy.h>
 #include <linux/microchipphy.h>
+#include <linux/delay.h>
 
 #define DRIVER_AUTHOR	"WOOJUNG HUH <woojung.huh@microchip.com>"
 #define DRIVER_DESC	"Microchip LAN88XX PHY driver"
@@ -30,6 +31,16 @@ struct lan88xx_priv {
 	__u32	wolopts;
 };
 
+static int lan88xx_read_page(struct phy_device *phydev)
+{
+	return __phy_read(phydev, LAN88XX_EXT_PAGE_ACCESS);
+}
+
+static int lan88xx_write_page(struct phy_device *phydev, int page)
+{
+	return __phy_write(phydev, LAN88XX_EXT_PAGE_ACCESS, page);
+}
+
 static int lan88xx_phy_config_intr(struct phy_device *phydev)
 {
 	int rc;
@@ -66,6 +77,150 @@ static int lan88xx_suspend(struct phy_de
 	return 0;
 }
 
+static int lan88xx_TR_reg_set(struct phy_device *phydev, u16 regaddr,
+			      u32 data)
+{
+	int val, save_page, ret = 0;
+	u16 buf;
+
+	/* Save current page */
+	save_page = phy_save_page(phydev);
+	if (save_page < 0) {
+		pr_warn("Failed to get current page\n");
+		goto err;
+	}
+
+	/* Switch to TR page */
+	lan88xx_write_page(phydev, LAN88XX_EXT_PAGE_ACCESS_TR);
+
+	ret = __phy_write(phydev, LAN88XX_EXT_PAGE_TR_LOW_DATA,
+			  (data & 0xFFFF));
+	if (ret < 0) {
+		pr_warn("Failed to write TR low data\n");
+		goto err;
+	}
+
+	ret = __phy_write(phydev, LAN88XX_EXT_PAGE_TR_HIGH_DATA,
+			  (data & 0x00FF0000) >> 16);
+	if (ret < 0) {
+		pr_warn("Failed to write TR high data\n");
+		goto err;
+	}
+
+	/* Config control bits [15:13] of register */
+	buf = (regaddr & ~(0x3 << 13));/* Clr [14:13] to write data in reg */
+	buf |= 0x8000; /* Set [15] to Packet transmit */
+
+	ret = __phy_write(phydev, LAN88XX_EXT_PAGE_TR_CR, buf);
+	if (ret < 0) {
+		pr_warn("Failed to write data in reg\n");
+		goto err;
+	}
+
+	usleep_range(1000, 2000);/* Wait for Data to be written */
+	val = __phy_read(phydev, LAN88XX_EXT_PAGE_TR_CR);
+	if (!(val & 0x8000))
+		pr_warn("TR Register[0x%X] configuration failed\n", regaddr);
+err:
+	return phy_restore_page(phydev, save_page, ret);
+}
+
+static void lan88xx_config_TR_regs(struct phy_device *phydev)
+{
+	int err;
+
+	/* Get access to Channel 0x1, Node 0xF , Register 0x01.
+	 * Write 24-bit value 0x12B00A to register. Setting MrvlTrFix1000Kf,
+	 * MrvlTrFix1000Kp, MasterEnableTR bits.
+	 */
+	err = lan88xx_TR_reg_set(phydev, 0x0F82, 0x12B00A);
+	if (err < 0)
+		pr_warn("Failed to Set Register[0x0F82]\n");
+
+	/* Get access to Channel b'10, Node b'1101, Register 0x06.
+	 * Write 24-bit value 0xD2C46F to register. Setting SSTrKf1000Slv,
+	 * SSTrKp1000Mas bits.
+	 */
+	err = lan88xx_TR_reg_set(phydev, 0x168C, 0xD2C46F);
+	if (err < 0)
+		pr_warn("Failed to Set Register[0x168C]\n");
+
+	/* Get access to Channel b'10, Node b'1111, Register 0x11.
+	 * Write 24-bit value 0x620 to register. Setting rem_upd_done_thresh
+	 * bits
+	 */
+	err = lan88xx_TR_reg_set(phydev, 0x17A2, 0x620);
+	if (err < 0)
+		pr_warn("Failed to Set Register[0x17A2]\n");
+
+	/* Get access to Channel b'10, Node b'1101, Register 0x10.
+	 * Write 24-bit value 0xEEFFDD to register. Setting
+	 * eee_TrKp1Long_1000, eee_TrKp2Long_1000, eee_TrKp3Long_1000,
+	 * eee_TrKp1Short_1000,eee_TrKp2Short_1000, eee_TrKp3Short_1000 bits.
+	 */
+	err = lan88xx_TR_reg_set(phydev, 0x16A0, 0xEEFFDD);
+	if (err < 0)
+		pr_warn("Failed to Set Register[0x16A0]\n");
+
+	/* Get access to Channel b'10, Node b'1101, Register 0x13.
+	 * Write 24-bit value 0x071448 to register. Setting
+	 * slv_lpi_tr_tmr_val1, slv_lpi_tr_tmr_val2 bits.
+	 */
+	err = lan88xx_TR_reg_set(phydev, 0x16A6, 0x071448);
+	if (err < 0)
+		pr_warn("Failed to Set Register[0x16A6]\n");
+
+	/* Get access to Channel b'10, Node b'1101, Register 0x12.
+	 * Write 24-bit value 0x13132F to register. Setting
+	 * slv_sigdet_timer_val1, slv_sigdet_timer_val2 bits.
+	 */
+	err = lan88xx_TR_reg_set(phydev, 0x16A4, 0x13132F);
+	if (err < 0)
+		pr_warn("Failed to Set Register[0x16A4]\n");
+
+	/* Get access to Channel b'10, Node b'1101, Register 0x14.
+	 * Write 24-bit value 0x0 to register. Setting eee_3level_delay,
+	 * eee_TrKf_freeze_delay bits.
+	 */
+	err = lan88xx_TR_reg_set(phydev, 0x16A8, 0x0);
+	if (err < 0)
+		pr_warn("Failed to Set Register[0x16A8]\n");
+
+	/* Get access to Channel b'01, Node b'1111, Register 0x34.
+	 * Write 24-bit value 0x91B06C to register. Setting
+	 * FastMseSearchThreshLong1000, FastMseSearchThreshShort1000,
+	 * FastMseSearchUpdGain1000 bits.
+	 */
+	err = lan88xx_TR_reg_set(phydev, 0x0FE8, 0x91B06C);
+	if (err < 0)
+		pr_warn("Failed to Set Register[0x0FE8]\n");
+
+	/* Get access to Channel b'01, Node b'1111, Register 0x3E.
+	 * Write 24-bit value 0xC0A028 to register. Setting
+	 * FastMseKp2ThreshLong1000, FastMseKp2ThreshShort1000,
+	 * FastMseKp2UpdGain1000, FastMseKp2ExitEn1000 bits.
+	 */
+	err = lan88xx_TR_reg_set(phydev, 0x0FFC, 0xC0A028);
+	if (err < 0)
+		pr_warn("Failed to Set Register[0x0FFC]\n");
+
+	/* Get access to Channel b'01, Node b'1111, Register 0x35.
+	 * Write 24-bit value 0x041600 to register. Setting
+	 * FastMseSearchPhShNum1000, FastMseSearchClksPerPh1000,
+	 * FastMsePhChangeDelay1000 bits.
+	 */
+	err = lan88xx_TR_reg_set(phydev, 0x0FEA, 0x041600);
+	if (err < 0)
+		pr_warn("Failed to Set Register[0x0FEA]\n");
+
+	/* Get access to Channel b'10, Node b'1101, Register 0x03.
+	 * Write 24-bit value 0x000004 to register. Setting TrFreeze bits.
+	 */
+	err = lan88xx_TR_reg_set(phydev, 0x1686, 0x000004);
+	if (err < 0)
+		pr_warn("Failed to Set Register[0x1686]\n");
+}
+
 static int lan88xx_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -132,6 +287,25 @@ static void lan88xx_set_mdix(struct phy_
 	phy_write(phydev, LAN88XX_EXT_PAGE_ACCESS, LAN88XX_EXT_PAGE_SPACE_0);
 }
 
+static int lan88xx_config_init(struct phy_device *phydev)
+{
+	int val;
+
+	genphy_config_init(phydev);
+	/*Zerodetect delay enable */
+	val = phy_read_mmd(phydev, MDIO_MMD_PCS,
+			   PHY_ARDENNES_MMD_DEV_3_PHY_CFG);
+	val |= PHY_ARDENNES_MMD_DEV_3_PHY_CFG_ZD_DLY_EN_;
+
+	phy_write_mmd(phydev, MDIO_MMD_PCS, PHY_ARDENNES_MMD_DEV_3_PHY_CFG,
+		      val);
+
+	/* Config DSP registers */
+	lan88xx_config_TR_regs(phydev);
+
+	return 0;
+}
+
 static int lan88xx_config_aneg(struct phy_device *phydev)
 {
 	lan88xx_set_mdix(phydev);
@@ -151,7 +325,7 @@ static struct phy_driver microchip_phy_d
 	.probe		= lan88xx_probe,
 	.remove		= lan88xx_remove,
 
-	.config_init	= genphy_config_init,
+	.config_init	= lan88xx_config_init,
 	.config_aneg	= lan88xx_config_aneg,
 
 	.ack_interrupt	= lan88xx_phy_ack_interrupt,
@@ -160,6 +334,8 @@ static struct phy_driver microchip_phy_d
 	.suspend	= lan88xx_suspend,
 	.resume		= genphy_resume,
 	.set_wol	= lan88xx_set_wol,
+	.read_page	= lan88xx_read_page,
+	.write_page	= lan88xx_write_page,
 } };
 
 module_phy_driver(microchip_phy_driver);
--- a/include/linux/microchipphy.h
+++ b/include/linux/microchipphy.h
@@ -70,4 +70,12 @@
 #define	LAN88XX_MMD3_CHIP_ID			(32877)
 #define	LAN88XX_MMD3_CHIP_REV			(32878)
 
+/* DSP registers */
+#define PHY_ARDENNES_MMD_DEV_3_PHY_CFG		(0x806A)
+#define PHY_ARDENNES_MMD_DEV_3_PHY_CFG_ZD_DLY_EN_	(0x2000)
+#define LAN88XX_EXT_PAGE_ACCESS_TR		(0x52B5)
+#define LAN88XX_EXT_PAGE_TR_CR			16
+#define LAN88XX_EXT_PAGE_TR_LOW_DATA		17
+#define LAN88XX_EXT_PAGE_TR_HIGH_DATA		18
+
 #endif /* _MICROCHIPPHY_H */


