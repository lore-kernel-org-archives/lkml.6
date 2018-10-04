Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08426C64EBD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E6E2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E6E2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeJDUKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:10:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38691 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727464AbeJDUKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:10:47 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 48930207CC; Thu,  4 Oct 2018 15:17:29 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id D07B8207F3;
        Thu,  4 Oct 2018 15:17:18 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, andrew@lunn.ch,
        f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        antoine.tenart@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH v2 net-next 3/5] net: phy: mscc: add support for VSC8574 PHY
Date:   Thu,  4 Oct 2018 15:17:08 +0200
Message-Id: <20181004131710.14978-4-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004131710.14978-1-quentin.schulz@bootlin.com>
References: <20181004131710.14978-1-quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VSC8574 PHY is a 4-ports PHY that is 10/100/1000BASE-T, 100BASE-FX,
1000BASE-X and triple-speed copper SFP capable, can communicate with
the MAC via SGMII, QSGMII or 1000BASE-X, supports WOL, downshifting and
can set the blinking pattern of each of its 4 LEDs, supports SyncE as
well as HP Auto-MDIX detection.

This adds support for 10/100/1000BASE-T, SGMII/QSGMII link with the MAC,
WOL, downshifting, HP Auto-MDIX detection and blinking pattern for its 4
LEDs.

The VSC8574 has also an internal Intel 8051 microcontroller whose
firmware needs to be patched when the PHY is reset. If the 8051's
firmware has the expected CRC, its patching can be skipped. The
microcontroller can be accessed from any port of the PHY, though the CRC
function can only be done through the PHY that is the base PHY of the
package (internal address 0) due to a limitation of the firmware.

The GPIO register bank is a set of registers that are common to all PHYs
in the package. So any modification in any register of this bank affects
all PHYs of the package.

If the PHYs haven't been reset before booting the Linux kernel and were
configured to use interrupts for e.g. link status updates, it is
required to clear the interrupts mask register of all PHYs before being
able to use interrupts with any PHY. The first PHY of the package that
will be init will take care of clearing all PHYs interrupts mask
registers. Thus, we need to keep track of the init sequence in the
package, if it's already been done or if it's to be done.

Most of the init sequence of a PHY of the package is common to all PHYs
in the package, thus we use the SMI broadcast feature which enables us
to propagate a write in one register of one PHY to all PHYs in the same
package.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/net/phy/mscc.c | 320 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 319 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index 14d61aac1313..0e1502dcc24c 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -65,6 +65,8 @@ enum rgmii_rx_clock_delay {
 #define MEDIA_OP_MODE_AMS_COPPER_100BASEFX	7
 #define MEDIA_OP_MODE_POS		  8
 
+#define MSCC_PHY_EXT_PHY_CNTL_2		  24
+
 #define MII_VSC85XX_INT_MASK		  25
 #define MII_VSC85XX_INT_MASK_MASK	  0xa000
 #define MII_VSC85XX_INT_MASK_WOL	  0x0040
@@ -151,6 +153,7 @@ enum rgmii_rx_clock_delay {
 #define DW8051_CLK_EN			  0x0010
 #define MICRO_CLK_EN			  0x0008
 #define MICRO_CLK_DIVIDE(x)		  ((x) >> 1)
+#define MSCC_DW8051_VLD_MASK		  0xf1ff
 
 /* x Address in range 1-4 */
 #define MSCC_TRAP_ROM_ADDR(x)		  ((x) * 2 + 1)
@@ -184,7 +187,9 @@ enum rgmii_rx_clock_delay {
 #define PROC_CMD_SGMII_MAC		  0x0030
 #define PROC_CMD_QSGMII_MAC		  0x0020
 #define PROC_CMD_NO_MAC_CONF		  0x0000
+#define PROC_CMD_1588_DEFAULT_INIT	  0x0010
 #define PROC_CMD_NOP			  0x000f
+#define PROC_CMD_PHY_INIT		  0x000a
 #define PROC_CMD_CRC16			  0x0008
 #define PROC_CMD_FIBER_MEDIA_CONF	  0x0001
 #define PROC_CMD_MCB_ACCESS_MAC_CONF	  0x0000
@@ -198,6 +203,9 @@ enum rgmii_rx_clock_delay {
 /* Test page Registers */
 #define MSCC_PHY_TEST_PAGE_5		  5
 #define MSCC_PHY_TEST_PAGE_8		  8
+#define MSCC_PHY_TEST_PAGE_9		  9
+#define MSCC_PHY_TEST_PAGE_20		  20
+#define MSCC_PHY_TEST_PAGE_24		  24
 
 /* Token ring page Registers */
 #define MSCC_PHY_TR_CNTL		  16
@@ -211,6 +219,7 @@ enum rgmii_rx_clock_delay {
 #define PHY_ID_VSC8531			  0x00070570
 #define PHY_ID_VSC8540			  0x00070760
 #define PHY_ID_VSC8541			  0x00070770
+#define PHY_ID_VSC8574			  0x000704a0
 #define PHY_ID_VSC8584			  0x000707c0
 
 #define MSCC_VDDMAC_1500		  1500
@@ -258,6 +267,10 @@ enum rgmii_rx_clock_delay {
 #define MSCC_VSC8584_REVB_INT8051_FW_START_ADDR	0xe800
 #define MSCC_VSC8584_REVB_INT8051_FW_CRC	0xfb48
 
+#define MSCC_VSC8574_REVB_INT8051_FW		"mscc_vsc8574_revb_int8051_29e8.bin"
+#define MSCC_VSC8574_REVB_INT8051_FW_START_ADDR	0x4000
+#define MSCC_VSC8574_REVB_INT8051_FW_CRC	0x29e8
+
 #define VSC8584_REVB				0x0001
 #define MSCC_DEV_REV_MASK			GENMASK(3, 0)
 
@@ -1133,6 +1146,250 @@ static int vsc8584_patch_fw(struct phy_device *phydev,
 	return 0;
 }
 
+/* bus->mdio_lock should be locked when using this function */
+static bool vsc8574_is_serdes_init(struct phy_device *phydev)
+{
+	u16 reg;
+	bool ret;
+
+	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS,
+		       MSCC_PHY_PAGE_EXTENDED_GPIO);
+
+	reg = phy_base_read(phydev, MSCC_TRAP_ROM_ADDR(1));
+	if (reg != 0x3eb7) {
+		ret = false;
+		goto out;
+	}
+
+	reg = phy_base_read(phydev, MSCC_PATCH_RAM_ADDR(1));
+	if (reg != 0x4012) {
+		ret = false;
+		goto out;
+	}
+
+	reg = phy_base_read(phydev, MSCC_INT_MEM_CNTL);
+	if (reg != EN_PATCH_RAM_TRAP_ADDR(1)) {
+		ret = false;
+		goto out;
+	}
+
+	reg = phy_base_read(phydev, MSCC_DW8051_CNTL_STATUS);
+	if ((MICRO_NSOFT_RESET | RUN_FROM_INT_ROM |  DW8051_CLK_EN |
+	     MICRO_CLK_EN) != (reg & MSCC_DW8051_VLD_MASK)) {
+		ret = false;
+		goto out;
+	}
+
+	ret = true;
+out:
+	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_STANDARD);
+
+	return ret;
+}
+
+/* bus->mdio_lock should be locked when using this function */
+static int vsc8574_config_pre_init(struct phy_device *phydev)
+{
+	const struct reg_val pre_init1[] = {
+		{0x0fae, 0x000401bd},
+		{0x0fac, 0x000f000f},
+		{0x17a0, 0x00a0f147},
+		{0x0fe4, 0x00052f54},
+		{0x1792, 0x0027303d},
+		{0x07fe, 0x00000704},
+		{0x0fe0, 0x00060150},
+		{0x0f82, 0x0012b00a},
+		{0x0f80, 0x00000d74},
+		{0x02e0, 0x00000012},
+		{0x03a2, 0x00050208},
+		{0x03b2, 0x00009186},
+		{0x0fb0, 0x000e3700},
+		{0x1688, 0x00049f81},
+		{0x0fd2, 0x0000ffff},
+		{0x168a, 0x00039fa2},
+		{0x1690, 0x0020640b},
+		{0x0258, 0x00002220},
+		{0x025a, 0x00002a20},
+		{0x025c, 0x00003060},
+		{0x025e, 0x00003fa0},
+		{0x03a6, 0x0000e0f0},
+		{0x0f92, 0x00001489},
+		{0x16a2, 0x00007000},
+		{0x16a6, 0x00071448},
+		{0x16a0, 0x00eeffdd},
+		{0x0fe8, 0x0091b06c},
+		{0x0fea, 0x00041600},
+		{0x16b0, 0x00eeff00},
+		{0x16b2, 0x00007000},
+		{0x16b4, 0x00000814},
+		{0x0f90, 0x00688980},
+		{0x03a4, 0x0000d8f0},
+		{0x0fc0, 0x00000400},
+		{0x07fa, 0x0050100f},
+		{0x0796, 0x00000003},
+		{0x07f8, 0x00c3ff98},
+		{0x0fa4, 0x0018292a},
+		{0x168c, 0x00d2c46f},
+		{0x17a2, 0x00000620},
+		{0x16a4, 0x0013132f},
+		{0x16a8, 0x00000000},
+		{0x0ffc, 0x00c0a028},
+		{0x0fec, 0x00901c09},
+		{0x0fee, 0x0004a6a1},
+		{0x0ffe, 0x00b01807},
+	};
+	const struct reg_val pre_init2[] = {
+		{0x0486, 0x0008a518},
+		{0x0488, 0x006dc696},
+		{0x048a, 0x00000912},
+		{0x048e, 0x00000db6},
+		{0x049c, 0x00596596},
+		{0x049e, 0x00000514},
+		{0x04a2, 0x00410280},
+		{0x04a4, 0x00000000},
+		{0x04a6, 0x00000000},
+		{0x04a8, 0x00000000},
+		{0x04aa, 0x00000000},
+		{0x04ae, 0x007df7dd},
+		{0x04b0, 0x006d95d4},
+		{0x04b2, 0x00492410},
+	};
+	struct device *dev = &phydev->mdio.dev;
+	const struct firmware *fw;
+	unsigned int i;
+	u16 crc, reg;
+	bool serdes_init;
+	int ret;
+
+	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_STANDARD);
+
+	/* all writes below are broadcasted to all PHYs in the same package */
+	reg = phy_base_read(phydev, MSCC_PHY_EXT_CNTL_STATUS);
+	reg |= SMI_BROADCAST_WR_EN;
+	phy_base_write(phydev, MSCC_PHY_EXT_CNTL_STATUS, reg);
+
+	phy_base_write(phydev, MII_VSC85XX_INT_MASK, 0);
+
+	/* The below register writes are tweaking analog and electrical
+	 * configuration that were determined through characterization by PHY
+	 * engineers. These don't mean anything more than "these are the best
+	 * values".
+	 */
+	phy_base_write(phydev, MSCC_PHY_EXT_PHY_CNTL_2, 0x0040);
+
+	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_TEST);
+
+	phy_base_write(phydev, MSCC_PHY_TEST_PAGE_20, 0x4320);
+	phy_base_write(phydev, MSCC_PHY_TEST_PAGE_24, 0x0c00);
+	phy_base_write(phydev, MSCC_PHY_TEST_PAGE_9, 0x18ca);
+	phy_base_write(phydev, MSCC_PHY_TEST_PAGE_5, 0x1b20);
+
+	reg = phy_base_read(phydev, MSCC_PHY_TEST_PAGE_8);
+	reg |= 0x8000;
+	phy_base_write(phydev, MSCC_PHY_TEST_PAGE_8, reg);
+
+	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_TR);
+
+	for (i = 0; i < ARRAY_SIZE(pre_init1); i++)
+		vsc8584_csr_write(phydev, pre_init1[i].reg, pre_init1[i].val);
+
+	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_EXTENDED_2);
+
+	phy_base_write(phydev, MSCC_PHY_CU_PMD_TX_CNTL, 0x028e);
+
+	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_TR);
+
+	for (i = 0; i < ARRAY_SIZE(pre_init2); i++)
+		vsc8584_csr_write(phydev, pre_init2[i].reg, pre_init2[i].val);
+
+	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_TEST);
+
+	reg = phy_base_read(phydev, MSCC_PHY_TEST_PAGE_8);
+	reg &= ~0x8000;
+	phy_base_write(phydev, MSCC_PHY_TEST_PAGE_8, reg);
+
+	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_STANDARD);
+
+	/* end of write broadcasting */
+	reg = phy_base_read(phydev, MSCC_PHY_EXT_CNTL_STATUS);
+	reg &= ~SMI_BROADCAST_WR_EN;
+	phy_base_write(phydev, MSCC_PHY_EXT_CNTL_STATUS, reg);
+
+	ret = request_firmware(&fw, MSCC_VSC8574_REVB_INT8051_FW, dev);
+	if (ret) {
+		dev_err(dev, "failed to load firmware %s, ret: %d\n",
+			MSCC_VSC8574_REVB_INT8051_FW, ret);
+		return ret;
+	}
+
+	/* Add one byte to size for the one added by the patch_fw function */
+	ret = vsc8584_get_fw_crc(phydev,
+				 MSCC_VSC8574_REVB_INT8051_FW_START_ADDR,
+				 fw->size + 1, &crc);
+	if (ret)
+		goto out;
+
+	if (crc == MSCC_VSC8574_REVB_INT8051_FW_CRC) {
+		serdes_init = vsc8574_is_serdes_init(phydev);
+
+		if (!serdes_init) {
+			ret = vsc8584_micro_assert_reset(phydev);
+			if (ret) {
+				dev_err(dev,
+					"%s: failed to assert reset of micro\n",
+					__func__);
+				return ret;
+			}
+		}
+	} else {
+		dev_dbg(dev, "FW CRC is not the expected one, patching FW\n");
+
+		serdes_init = false;
+
+		if (vsc8584_patch_fw(phydev, fw))
+			dev_warn(dev,
+				 "failed to patch FW, expect non-optimal device\n");
+	}
+
+	if (!serdes_init) {
+		phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS,
+			       MSCC_PHY_PAGE_EXTENDED_GPIO);
+
+		phy_base_write(phydev, MSCC_TRAP_ROM_ADDR(1), 0x3eb7);
+		phy_base_write(phydev, MSCC_PATCH_RAM_ADDR(1), 0x4012);
+		phy_base_write(phydev, MSCC_INT_MEM_CNTL,
+			       EN_PATCH_RAM_TRAP_ADDR(1));
+
+		vsc8584_micro_deassert_reset(phydev, false);
+
+		/* Add one byte to size for the one added by the patch_fw
+		 * function
+		 */
+		ret = vsc8584_get_fw_crc(phydev,
+					 MSCC_VSC8574_REVB_INT8051_FW_START_ADDR,
+					 fw->size + 1, &crc);
+		if (ret)
+			goto out;
+
+		if (crc != MSCC_VSC8574_REVB_INT8051_FW_CRC)
+			dev_warn(dev,
+				 "FW CRC after patching is not the expected one, expect non-optimal device\n");
+	}
+
+	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS,
+		       MSCC_PHY_PAGE_EXTENDED_GPIO);
+
+	ret = vsc8584_cmd(phydev, PROC_CMD_1588_DEFAULT_INIT |
+			  PROC_CMD_PHY_INIT);
+
+out:
+	phy_base_write(phydev, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_STANDARD);
+
+	release_firmware(fw);
+
+	return ret;
+}
+
 /* bus->mdio_lock should be locked when using this function */
 static int vsc8584_config_pre_init(struct phy_device *phydev)
 {
@@ -1356,7 +1613,15 @@ static int vsc8584_config_init(struct phy_device *phydev)
 	 * in this pre-init function.
 	 */
 	if (!vsc8584_is_pkg_init(phydev, val & PHY_ADDR_REVERSED ? 1 : 0)) {
-		ret = vsc8584_config_pre_init(phydev);
+		if ((phydev->phy_id & phydev->drv->phy_id_mask) ==
+		    (PHY_ID_VSC8574 & phydev->drv->phy_id_mask))
+			ret = vsc8574_config_pre_init(phydev);
+		else if ((phydev->phy_id & phydev->drv->phy_id_mask) ==
+			 (PHY_ID_VSC8584 & phydev->drv->phy_id_mask))
+			ret = vsc8584_config_pre_init(phydev);
+		else
+			ret = -EINVAL;
+
 		if (ret)
 			goto err;
 	}
@@ -1522,6 +1787,31 @@ static int vsc85xx_read_status(struct phy_device *phydev)
 	return genphy_read_status(phydev);
 }
 
+static int vsc8574_probe(struct phy_device *phydev)
+{
+	struct vsc8531_private *vsc8531;
+	u32 default_mode[4] = {VSC8531_LINK_1000_ACTIVITY,
+	   VSC8531_LINK_100_ACTIVITY, VSC8531_LINK_ACTIVITY,
+	   VSC8531_DUPLEX_COLLISION};
+
+	vsc8531 = devm_kzalloc(&phydev->mdio.dev, sizeof(*vsc8531), GFP_KERNEL);
+	if (!vsc8531)
+		return -ENOMEM;
+
+	phydev->priv = vsc8531;
+
+	vsc8531->nleds = 4;
+	vsc8531->supp_led_modes = VSC8584_SUPP_LED_MODES;
+	vsc8531->hw_stats = vsc8584_hw_stats;
+	vsc8531->nstats = ARRAY_SIZE(vsc8584_hw_stats);
+	vsc8531->stats = devm_kmalloc_array(&phydev->mdio.dev, vsc8531->nstats,
+					    sizeof(u64), GFP_KERNEL);
+	if (!vsc8531->stats)
+		return -ENOMEM;
+
+	return vsc85xx_dt_led_modes_get(phydev, default_mode);
+}
+
 static int vsc8584_probe(struct phy_device *phydev)
 {
 	struct vsc8531_private *vsc8531;
@@ -1688,6 +1978,33 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
 },
+{
+	.phy_id		= PHY_ID_VSC8574,
+	.name		= "Microsemi GE VSC8574 SyncE",
+	.phy_id_mask	= 0xfffffff0,
+	.features	= PHY_GBIT_FEATURES,
+	.flags		= PHY_HAS_INTERRUPT,
+	.soft_reset	= &genphy_soft_reset,
+	.config_init    = &vsc8584_config_init,
+	.config_aneg    = &vsc85xx_config_aneg,
+	.aneg_done	= &genphy_aneg_done,
+	.read_status	= &vsc85xx_read_status,
+	.ack_interrupt  = &vsc85xx_ack_interrupt,
+	.config_intr    = &vsc85xx_config_intr,
+	.did_interrupt  = &vsc8584_did_interrupt,
+	.suspend	= &genphy_suspend,
+	.resume		= &genphy_resume,
+	.probe		= &vsc8574_probe,
+	.set_wol	= &vsc85xx_wol_set,
+	.get_wol	= &vsc85xx_wol_get,
+	.get_tunable	= &vsc85xx_get_tunable,
+	.set_tunable	= &vsc85xx_set_tunable,
+	.read_page	= &vsc85xx_phy_read_page,
+	.write_page	= &vsc85xx_phy_write_page,
+	.get_sset_count = &vsc85xx_get_sset_count,
+	.get_strings    = &vsc85xx_get_strings,
+	.get_stats      = &vsc85xx_get_stats,
+},
 {
 	.phy_id		= PHY_ID_VSC8584,
 	.name		= "Microsemi GE VSC8584 SyncE",
@@ -1723,6 +2040,7 @@ static struct mdio_device_id __maybe_unused vsc85xx_tbl[] = {
 	{ PHY_ID_VSC8531, 0xfffffff0, },
 	{ PHY_ID_VSC8540, 0xfffffff0, },
 	{ PHY_ID_VSC8541, 0xfffffff0, },
+	{ PHY_ID_VSC8574, 0xfffffff0, },
 	{ PHY_ID_VSC8584, 0xfffffff0, },
 	{ }
 };
-- 
2.17.1

