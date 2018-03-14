Return-Path: <neil@brown.name>
X-Google-Smtp-Source: AG47ELtDdL48WpUTA5wzvGvFfnoXblNESA2oPRt+WiJmpPIUgzwUi0Viu2RwdGphYnrSGSfkbhj3
ARC-Seal: i=1; a=rsa-sha256; t=1521059043; cv=none;
        d=google.com; s=arc-20160816;
        b=RijW2mipEaJoGR2jW8nS+0gb8moGfX5l4LGnkkcG8T0nbtJZLTDIvdO9Bimbsxvud/
         xYIp6FBJxNvZEGjKw2ow9stDt+6XO/AEowpjBy/XCFbB9BJJrq7wO/Z8++ciLnNW+lbZ
         vEsZneKostAlfdSui4hRGdKoBNfyDRx2Rj7z7M+vLmuKpHWC//65ajqLF4ppcK0krByE
         UsqiS/bkD4jIZ4orwCTVbfycZ0EHUQQfHC0NC1+plwwxpX8lOlcMiEXZ0R7QjQASszik
         aNIO7hTZlLZanqShkQYrn3r50s2u3tnryraUozpmL9dSDHixhSnUirARPOmHeikskIdp
         YR+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=kn1bZ3WpLtXjKSzRH/6D/jnRr76wVFwhto/f58KRY6o=;
        b=xqLVo0xCBFTx+kLG6fhZwIHSiFuNVu63LUwf79eGWbE/7bQ+sSXohw9ecUSZqzsTWM
         XJmr+aJMpNsUmiYScBdF4jrT8SU4Zt7jP6AglXf1V67ndoDlQ6mSTOygS0YGYIl27eSJ
         upnNHlEtLK/ToJqrAPvCHt2hYj1u/sWzo3qaEDotI238kwEhP3qazDuiAa2DCJmpWg8t
         JWYIuSGL66DpblZCXu4+KJLsg1IpSoN4i2Hj4oZt4CWro4wdalRaU1qjMLpcy8ukiGn3
         gc77IpCqll8M3qqscalDSs+yhqDFZFwesJfoSDxPkYFtRx21v4VqjFtQCgQTp3HIV6ml
         +Aaw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of neil@brown.name) smtp.mailfrom=neil@brown.name
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of neil@brown.name) smtp.mailfrom=neil@brown.name
From: NeilBrown <neil@brown.name>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 15 Mar 2018 07:22:36 +1100
Subject: [PATCH 09/13] staging: mt7621-eth: add gigabit switch driver (GSW)
Cc: devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>,
 John Crispin <blogic@openwrt.org>
Message-ID: <152105895614.22262.6507099447027006239.stgit@noble>
In-Reply-To: <152105892255.22262.1902152685410223215.stgit@noble>
References: <152105892255.22262.1902152685410223215.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594946008052339671?=
X-GMAIL-MSGID: =?utf-8?q?1594946008052339671?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: John Crispin <blogic@openwrt.org>

The GSW is found in all of the 1000mbit SoCs. it has 5 external ports,
1-2 cpu ports and 1 further port that the internal HW offloading engine
connects to. The switch core used is a MT7530, which also exists as a
standalone chip. Although these SoCs (mt7620/1/3) share the same switch
core, the bring up of these is slightly different. One of the reasons is
that on mt7620 the switch core is mmio mapped while MT7621/3 talks to the
switch via MDIO addr 0x1f. Additionally, the SoCs have different MAC types
and some of them have TRGMII support. MT7621 can do 1,2gbit and MT7623 is
able to do 2,6gbit. The support for the TRGMII bring up is not part of this
series as the code is based on the SDK driver and has between 1500 and 2000
magic values that still need to be converted to defines.

Because of these differences we have 3 separate drivers for these 3 SoCs.
These drivers are very basic and only provides basic init and irq support.

The SoC and switch core both have support for a special tag making DSA
support possible.

NeilBrown:
 - added setting to mt7621_hw_init to match working code from libreCMC
 This needs to be converted to use switchdev.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/staging/mt7621-eth/TODO         |    1 
 drivers/staging/mt7621-eth/gsw_mt7620.h |  277 +++++++++++++++++++++++++++++
 drivers/staging/mt7621-eth/gsw_mt7621.c |  298 +++++++++++++++++++++++++++++++
 3 files changed, 576 insertions(+)
 create mode 100644 drivers/staging/mt7621-eth/gsw_mt7620.h
 create mode 100644 drivers/staging/mt7621-eth/gsw_mt7621.c

diff --git a/drivers/staging/mt7621-eth/TODO b/drivers/staging/mt7621-eth/TODO
index 25c550e8df8c..1ab0530131ae 100644
--- a/drivers/staging/mt7621-eth/TODO
+++ b/drivers/staging/mt7621-eth/TODO
@@ -3,5 +3,6 @@
 - fix ethtool - currently doesn't return valid data.
 - general code review and clean up
 - add support for second MAC on mt7621
+- convert gsw code to use switchdev interfaces
 
 Cc: NeilBrown <neil@brown.name>
diff --git a/drivers/staging/mt7621-eth/gsw_mt7620.h b/drivers/staging/mt7621-eth/gsw_mt7620.h
new file mode 100644
index 000000000000..1766939e2101
--- /dev/null
+++ b/drivers/staging/mt7621-eth/gsw_mt7620.h
@@ -0,0 +1,277 @@
+/*   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; version 2 of the License
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   Copyright (C) 2009-2016 John Crispin <blogic@openwrt.org>
+ *   Copyright (C) 2009-2016 Felix Fietkau <nbd@openwrt.org>
+ *   Copyright (C) 2013-2016 Michael Lee <igvtee@gmail.com>
+ */
+
+#ifndef _RALINK_GSW_MT7620_H__
+#define _RALINK_GSW_MT7620_H__
+
+#define GSW_REG_PHY_TIMEOUT	(5 * HZ)
+
+#define MT7620_GSW_REG_PIAC	0x0004
+
+#define GSW_NUM_VLANS		16
+#define GSW_NUM_VIDS		4096
+#define GSW_NUM_PORTS		7
+#define GSW_PORT6		6
+
+#define GSW_MDIO_ACCESS		BIT(31)
+#define GSW_MDIO_READ		BIT(19)
+#define GSW_MDIO_WRITE		BIT(18)
+#define GSW_MDIO_START		BIT(16)
+#define GSW_MDIO_ADDR_SHIFT	20
+#define GSW_MDIO_REG_SHIFT	25
+
+#define GSW_REG_PORT_PMCR(x)	(0x3000 + (x * 0x100))
+#define GSW_REG_PORT_STATUS(x)	(0x3008 + (x * 0x100))
+#define GSW_REG_SMACCR0		0x3fE4
+#define GSW_REG_SMACCR1		0x3fE8
+#define GSW_REG_CKGCR		0x3ff0
+
+#define GSW_REG_IMR		0x7008
+#define GSW_REG_ISR		0x700c
+#define GSW_REG_GPC1		0x7014
+
+#define SYSC_REG_CHIP_REV_ID	0x0c
+#define SYSC_REG_CFG		0x10
+#define SYSC_REG_CFG1		0x14
+#define RST_CTRL_MCM		BIT(2)
+#define SYSC_PAD_RGMII2_MDIO	0x58
+#define SYSC_GPIO_MODE		0x60
+
+#define PORT_IRQ_ST_CHG		0x7f
+
+#define MT7621_ESW_PHY_POLLING	0x0000
+#define MT7620_ESW_PHY_POLLING	0x7000
+
+#define	PMCR_IPG		BIT(18)
+#define	PMCR_MAC_MODE		BIT(16)
+#define	PMCR_FORCE		BIT(15)
+#define	PMCR_TX_EN		BIT(14)
+#define	PMCR_RX_EN		BIT(13)
+#define	PMCR_BACKOFF		BIT(9)
+#define	PMCR_BACKPRES		BIT(8)
+#define	PMCR_RX_FC		BIT(5)
+#define	PMCR_TX_FC		BIT(4)
+#define	PMCR_SPEED(_x)		(_x << 2)
+#define	PMCR_DUPLEX		BIT(1)
+#define	PMCR_LINK		BIT(0)
+
+#define PHY_AN_EN		BIT(31)
+#define PHY_PRE_EN		BIT(30)
+#define PMY_MDC_CONF(_x)	((_x & 0x3f) << 24)
+
+/* ethernet subsystem config register */
+#define ETHSYS_SYSCFG0		0x14
+/* ethernet subsystem clock register */
+#define ETHSYS_CLKCFG0		0x2c
+#define ETHSYS_TRGMII_CLK_SEL362_5	BIT(11)
+
+/* p5 RGMII wrapper TX clock control register */
+#define MT7530_P5RGMIITXCR	0x7b04
+/* p5 RGMII wrapper RX clock control register */
+#define MT7530_P5RGMIIRXCR	0x7b00
+/* TRGMII TDX ODT registers */
+#define MT7530_TRGMII_TD0_ODT	0x7a54
+#define MT7530_TRGMII_TD1_ODT	0x7a5c
+#define MT7530_TRGMII_TD2_ODT	0x7a64
+#define MT7530_TRGMII_TD3_ODT	0x7a6c
+#define MT7530_TRGMII_TD4_ODT	0x7a74
+#define MT7530_TRGMII_TD5_ODT	0x7a7c
+/* TRGMII TCK ctrl register */
+#define MT7530_TRGMII_TCK_CTRL	0x7a78
+/* TRGMII Tx ctrl register */
+#define MT7530_TRGMII_TXCTRL	0x7a40
+/* port 6 extended control register */
+#define MT7530_P6ECR            0x7830
+/* IO driver control register */
+#define MT7530_IO_DRV_CR	0x7810
+/* top signal control register */
+#define MT7530_TOP_SIG_CTRL	0x7808
+/* modified hwtrap register */
+#define MT7530_MHWTRAP		0x7804
+/* hwtrap status register */
+#define MT7530_HWTRAP		0x7800
+/* status interrupt register */
+#define MT7530_SYS_INT_STS	0x700c
+/* system nterrupt register */
+#define MT7530_SYS_INT_EN	0x7008
+/* system control register */
+#define MT7530_SYS_CTRL		0x7000
+/* port MAC status register */
+#define MT7530_PMSR_P(x)	(0x3008 + (x * 0x100))
+/* port MAC control register */
+#define MT7530_PMCR_P(x)	(0x3000 + (x * 0x100))
+
+#define MT7621_XTAL_SHIFT	6
+#define MT7621_XTAL_MASK	0x7
+#define MT7621_XTAL_25		6
+#define MT7621_XTAL_40		3
+#define MT7621_MDIO_DRV_MASK	(3 << 4)
+#define MT7621_GE1_MODE_MASK	(3 << 12)
+
+#define TRGMII_TXCTRL_TXC_INV	BIT(30)
+#define P6ECR_INTF_MODE_RGMII	BIT(1)
+#define P5RGMIIRXCR_C_ALIGN	BIT(8)
+#define P5RGMIIRXCR_DELAY_2	BIT(1)
+#define P5RGMIITXCR_DELAY_2	(BIT(8) | BIT(2))
+
+/* TOP_SIG_CTRL bits */
+#define TOP_SIG_CTRL_NORMAL	(BIT(17) | BIT(16))
+
+/* MHWTRAP bits */
+#define MHWTRAP_MANUAL		BIT(16)
+#define MHWTRAP_P5_MAC_SEL	BIT(13)
+#define MHWTRAP_P6_DIS		BIT(8)
+#define MHWTRAP_P5_RGMII_MODE	BIT(7)
+#define MHWTRAP_P5_DIS		BIT(6)
+#define MHWTRAP_PHY_ACCESS	BIT(5)
+
+/* HWTRAP bits */
+#define HWTRAP_XTAL_SHIFT	9
+#define HWTRAP_XTAL_MASK	0x3
+
+/* SYS_CTRL bits */
+#define SYS_CTRL_SW_RST		BIT(1)
+#define SYS_CTRL_REG_RST	BIT(0)
+
+/* PMCR bits */
+#define PMCR_IFG_XMIT_96	BIT(18)
+#define PMCR_MAC_MODE		BIT(16)
+#define PMCR_FORCE_MODE		BIT(15)
+#define PMCR_TX_EN		BIT(14)
+#define PMCR_RX_EN		BIT(13)
+#define PMCR_BACK_PRES_EN	BIT(9)
+#define PMCR_BACKOFF_EN		BIT(8)
+#define PMCR_TX_FC_EN		BIT(5)
+#define PMCR_RX_FC_EN		BIT(4)
+#define PMCR_FORCE_SPEED_1000	BIT(3)
+#define PMCR_FORCE_FDX		BIT(1)
+#define PMCR_FORCE_LNK		BIT(0)
+#define PMCR_FIXED_LINK		(PMCR_IFG_XMIT_96 | PMCR_MAC_MODE | \
+				 PMCR_FORCE_MODE | PMCR_TX_EN | PMCR_RX_EN | \
+				 PMCR_BACK_PRES_EN | PMCR_BACKOFF_EN | \
+				 PMCR_FORCE_SPEED_1000 | PMCR_FORCE_FDX | \
+				 PMCR_FORCE_LNK)
+
+#define PMCR_FIXED_LINK_FC	(PMCR_FIXED_LINK | \
+				 PMCR_TX_FC_EN | PMCR_RX_FC_EN)
+
+/* TRGMII control registers */
+#define GSW_INTF_MODE		0x390
+#define GSW_TRGMII_TD0_ODT	0x354
+#define GSW_TRGMII_TD1_ODT	0x35c
+#define GSW_TRGMII_TD2_ODT	0x364
+#define GSW_TRGMII_TD3_ODT	0x36c
+#define GSW_TRGMII_TXCTL_ODT	0x374
+#define GSW_TRGMII_TCK_ODT	0x37c
+#define GSW_TRGMII_RCK_CTRL	0x300
+
+#define INTF_MODE_TRGMII	BIT(1)
+#define TRGMII_RCK_CTRL_RX_RST	BIT(31)
+
+/* Mac control registers */
+#define MTK_MAC_P2_MCR		0x200
+#define MTK_MAC_P1_MCR		0x100
+
+#define MAC_MCR_MAX_RX_2K	BIT(29)
+#define MAC_MCR_IPG_CFG		(BIT(18) | BIT(16))
+#define MAC_MCR_FORCE_MODE	BIT(15)
+#define MAC_MCR_TX_EN		BIT(14)
+#define MAC_MCR_RX_EN		BIT(13)
+#define MAC_MCR_BACKOFF_EN	BIT(9)
+#define MAC_MCR_BACKPR_EN	BIT(8)
+#define MAC_MCR_FORCE_RX_FC	BIT(5)
+#define MAC_MCR_FORCE_TX_FC	BIT(4)
+#define MAC_MCR_SPEED_1000	BIT(3)
+#define MAC_MCR_FORCE_DPX	BIT(1)
+#define MAC_MCR_FORCE_LINK	BIT(0)
+#define MAC_MCR_FIXED_LINK	(MAC_MCR_MAX_RX_2K | MAC_MCR_IPG_CFG | \
+				 MAC_MCR_FORCE_MODE | MAC_MCR_TX_EN | \
+				 MAC_MCR_RX_EN | MAC_MCR_BACKOFF_EN | \
+				 MAC_MCR_BACKPR_EN | MAC_MCR_FORCE_RX_FC | \
+				 MAC_MCR_FORCE_TX_FC | MAC_MCR_SPEED_1000 | \
+				 MAC_MCR_FORCE_DPX | MAC_MCR_FORCE_LINK)
+#define MAC_MCR_FIXED_LINK_FC	(MAC_MCR_MAX_RX_2K | MAC_MCR_IPG_CFG | \
+				 MAC_MCR_FIXED_LINK)
+
+/* possible XTAL speed */
+#define	MT7623_XTAL_40		0
+#define MT7623_XTAL_20		1
+#define MT7623_XTAL_25		3
+
+/* GPIO port control registers */
+#define	GPIO_OD33_CTRL8		0x4c0
+#define	GPIO_BIAS_CTRL		0xed0
+#define GPIO_DRV_SEL10		0xf00
+
+/* on MT7620 the functio of port 4 can be software configured */
+enum {
+	PORT4_EPHY = 0,
+	PORT4_EXT,
+};
+
+/* struct mt7620_gsw -	the structure that holds the SoC specific data
+ * @dev:		The Device struct
+ * @base:		The base address
+ * @piac_offset:	The PIAC base may change depending on SoC
+ * @irq:		The IRQ we are using
+ * @port4:		The port4 mode on MT7620
+ * @autopoll:		Is MDIO autopolling enabled
+ * @ethsys:		The ethsys register map
+ * @pctl:		The pin control register map
+ * @clk_gsw:		The switch clock
+ * @clk_gp1:		The gmac1 clock
+ * @clk_gp2:		The gmac2 clock
+ * @clk_trgpll:		The trgmii pll clock
+ */
+struct mt7620_gsw {
+	struct device		*dev;
+	void __iomem		*base;
+	u32			piac_offset;
+	int			irq;
+	int			port4;
+	unsigned long int	autopoll;
+
+	struct regmap		*ethsys;
+	struct regmap		*pctl;
+
+	struct clk		*clk_gsw;
+	struct clk		*clk_gp1;
+	struct clk		*clk_gp2;
+	struct clk		*clk_trgpll;
+};
+
+/* switch register I/O wrappers */
+void mtk_switch_w32(struct mt7620_gsw *gsw, u32 val, unsigned reg);
+u32 mtk_switch_r32(struct mt7620_gsw *gsw, unsigned reg);
+
+/* the callback used by the driver core to bringup the switch */
+int mtk_gsw_init(struct mtk_eth *eth);
+
+/* MDIO access wrappers */
+int mt7620_mdio_write(struct mii_bus *bus, int phy_addr, int phy_reg, u16 val);
+int mt7620_mdio_read(struct mii_bus *bus, int phy_addr, int phy_reg);
+void mt7620_mdio_link_adjust(struct mtk_eth *eth, int port);
+int mt7620_has_carrier(struct mtk_eth *eth);
+void mt7620_print_link_state(struct mtk_eth *eth, int port, int link,
+			     int speed, int duplex);
+void mt7530_mdio_w32(struct mt7620_gsw *gsw, u32 reg, u32 val);
+u32 mt7530_mdio_r32(struct mt7620_gsw *gsw, u32 reg);
+void mt7530_mdio_m32(struct mt7620_gsw *gsw, u32 mask, u32 set, u32 reg);
+
+u32 _mt7620_mii_write(struct mt7620_gsw *gsw, u32 phy_addr,
+		      u32 phy_register, u32 write_data);
+u32 _mt7620_mii_read(struct mt7620_gsw *gsw, int phy_addr, int phy_reg);
+void mt7620_handle_carrier(struct mtk_eth *eth);
+
+#endif
diff --git a/drivers/staging/mt7621-eth/gsw_mt7621.c b/drivers/staging/mt7621-eth/gsw_mt7621.c
new file mode 100644
index 000000000000..b49ee946e6bd
--- /dev/null
+++ b/drivers/staging/mt7621-eth/gsw_mt7621.c
@@ -0,0 +1,298 @@
+/*   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; version 2 of the License
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   Copyright (C) 2009-2016 John Crispin <blogic@openwrt.org>
+ *   Copyright (C) 2009-2016 Felix Fietkau <nbd@openwrt.org>
+ *   Copyright (C) 2013-2016 Michael Lee <igvtee@gmail.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+
+#include <ralink_regs.h>
+
+#include "mtk_eth_soc.h"
+#include "gsw_mt7620.h"
+
+void mtk_switch_w32(struct mt7620_gsw *gsw, u32 val, unsigned reg)
+{
+	iowrite32(val, gsw->base + reg);
+}
+EXPORT_SYMBOL_GPL(mtk_switch_w32);
+
+u32 mtk_switch_r32(struct mt7620_gsw *gsw, unsigned reg)
+{
+	return ioread32(gsw->base + reg);
+}
+EXPORT_SYMBOL_GPL(mtk_switch_r32);
+
+static irqreturn_t gsw_interrupt_mt7621(int irq, void *_eth)
+{
+	struct mtk_eth *eth = (struct mtk_eth *)_eth;
+	struct mt7620_gsw *gsw = (struct mt7620_gsw *)eth->sw_priv;
+	u32 reg, i;
+
+	reg = mt7530_mdio_r32(gsw, MT7530_SYS_INT_STS);
+
+	for (i = 0; i < 5; i++) {
+		unsigned int link;
+
+		if ((reg & BIT(i)) == 0)
+			continue;
+
+		link = mt7530_mdio_r32(gsw, MT7530_PMSR_P(i)) & 0x1;
+
+		if (link == eth->link[i])
+			continue;
+
+		eth->link[i] = link;
+		if (link)
+			netdev_info(*eth->netdev,
+				    "port %d link up\n", i);
+		else
+			netdev_info(*eth->netdev,
+				    "port %d link down\n", i);
+	}
+
+	mt7530_mdio_w32(gsw, MT7530_SYS_INT_STS, 0x1f);
+
+	return IRQ_HANDLED;
+}
+
+static void mt7621_hw_init(struct mtk_eth *eth, struct mt7620_gsw *gsw,
+			   struct device_node *np)
+{
+	u32 i;
+	u32 val;
+
+	/* hardware reset the switch */
+	mtk_reset(eth, RST_CTRL_MCM);
+	mdelay(10);
+
+	/* reduce RGMII2 PAD driving strength */
+	rt_sysc_m32(MT7621_MDIO_DRV_MASK, 0, SYSC_PAD_RGMII2_MDIO);
+
+	/* gpio mux - RGMII1=Normal mode */
+	rt_sysc_m32(BIT(14), 0, SYSC_GPIO_MODE);
+
+	/* set GMAC1 RGMII mode */
+	rt_sysc_m32(MT7621_GE1_MODE_MASK, 0, SYSC_REG_CFG1);
+
+	/* enable MDIO to control MT7530 */
+	rt_sysc_m32(3 << 12, 0, SYSC_GPIO_MODE);
+
+	/* turn off all PHYs */
+	for (i = 0; i <= 4; i++) {
+		val = _mt7620_mii_read(gsw, i, 0x0);
+		val |= BIT(11);
+		_mt7620_mii_write(gsw, i, 0x0, val);
+	}
+
+	/* reset the switch */
+	mt7530_mdio_w32(gsw, MT7530_SYS_CTRL,
+			SYS_CTRL_SW_RST | SYS_CTRL_REG_RST);
+	usleep_range(10, 20);
+
+	if ((rt_sysc_r32(SYSC_REG_CHIP_REV_ID) & 0xFFFF) == 0x0101) {
+		/* GE1, Force 1000M/FD, FC ON, MAX_RX_LENGTH 1536 */
+		mtk_switch_w32(gsw, MAC_MCR_FIXED_LINK, MTK_MAC_P2_MCR);
+		mt7530_mdio_w32(gsw, MT7530_PMCR_P(6), PMCR_FIXED_LINK);
+	} else {
+		/* GE1, Force 1000M/FD, FC ON, MAX_RX_LENGTH 1536 */
+		mtk_switch_w32(gsw, MAC_MCR_FIXED_LINK_FC, MTK_MAC_P1_MCR);
+		mt7530_mdio_w32(gsw, MT7530_PMCR_P(6), PMCR_FIXED_LINK_FC);
+	}
+
+	/* GE2, Link down */
+	mtk_switch_w32(gsw, MAC_MCR_FORCE_MODE, MTK_MAC_P2_MCR);
+
+	/* Enable Port 6, P5 as GMAC5, P5 disable */
+	val = mt7530_mdio_r32(gsw, MT7530_MHWTRAP);
+	/* Enable Port 6 */
+	val &= ~MHWTRAP_P6_DIS;
+	/* Disable Port 5 */
+	val |= MHWTRAP_P5_DIS;
+	/* manual override of HW-Trap */
+	val |= MHWTRAP_MANUAL;
+	mt7530_mdio_w32(gsw, MT7530_MHWTRAP, val);
+
+	val = rt_sysc_r32(SYSC_REG_CFG);
+	val = (val >> MT7621_XTAL_SHIFT) & MT7621_XTAL_MASK;
+	if (val < MT7621_XTAL_25 && val >= MT7621_XTAL_40) {
+		/* 40Mhz */
+
+		/* disable MT7530 core clock */
+		_mt7620_mii_write(gsw, 0, 13, 0x1f);
+		_mt7620_mii_write(gsw, 0, 14, 0x410);
+		_mt7620_mii_write(gsw, 0, 13, 0x401f);
+		_mt7620_mii_write(gsw, 0, 14, 0x0);
+
+		/* disable MT7530 PLL */
+		_mt7620_mii_write(gsw, 0, 13, 0x1f);
+		_mt7620_mii_write(gsw, 0, 14, 0x40d);
+		_mt7620_mii_write(gsw, 0, 13, 0x401f);
+		_mt7620_mii_write(gsw, 0, 14, 0x2020);
+
+		/* for MT7530 core clock = 500Mhz */
+		_mt7620_mii_write(gsw, 0, 13, 0x1f);
+		_mt7620_mii_write(gsw, 0, 14, 0x40e);
+		_mt7620_mii_write(gsw, 0, 13, 0x401f);
+		_mt7620_mii_write(gsw, 0, 14, 0x119);
+
+		/* enable MT7530 PLL */
+		_mt7620_mii_write(gsw, 0, 13, 0x1f);
+		_mt7620_mii_write(gsw, 0, 14, 0x40d);
+		_mt7620_mii_write(gsw, 0, 13, 0x401f);
+		_mt7620_mii_write(gsw, 0, 14, 0x2820);
+
+		usleep_range(20, 40);
+
+		/* enable MT7530 core clock */
+		_mt7620_mii_write(gsw, 0, 13, 0x1f);
+		_mt7620_mii_write(gsw, 0, 14, 0x410);
+		_mt7620_mii_write(gsw, 0, 13, 0x401f);
+	}
+
+	/* RGMII */
+	_mt7620_mii_write(gsw, 0, 14, 0x1);
+
+	/* set MT7530 central align */
+	mt7530_mdio_m32(gsw, BIT(0), P6ECR_INTF_MODE_RGMII, MT7530_P6ECR);
+	mt7530_mdio_m32(gsw, TRGMII_TXCTRL_TXC_INV, 0,
+			MT7530_TRGMII_TXCTRL);
+	mt7530_mdio_w32(gsw, MT7530_TRGMII_TCK_CTRL, 0x855);
+
+	/* delay setting for 10/1000M */
+	mt7530_mdio_w32(gsw, MT7530_P5RGMIIRXCR,
+			P5RGMIIRXCR_C_ALIGN | P5RGMIIRXCR_DELAY_2);
+	mt7530_mdio_w32(gsw, MT7530_P5RGMIITXCR, 0x14);
+
+	/* lower Tx Driving*/
+	mt7530_mdio_w32(gsw, MT7530_TRGMII_TD0_ODT, 0x44);
+	mt7530_mdio_w32(gsw, MT7530_TRGMII_TD1_ODT, 0x44);
+	mt7530_mdio_w32(gsw, MT7530_TRGMII_TD2_ODT, 0x44);
+	mt7530_mdio_w32(gsw, MT7530_TRGMII_TD3_ODT, 0x44);
+	mt7530_mdio_w32(gsw, MT7530_TRGMII_TD4_ODT, 0x44);
+	mt7530_mdio_w32(gsw, MT7530_TRGMII_TD5_ODT, 0x44);
+
+	/* turn on all PHYs */
+	for (i = 0; i <= 4; i++) {
+		val = _mt7620_mii_read(gsw, i, 0);
+		val &= ~BIT(11);
+		_mt7620_mii_write(gsw, i, 0, val);
+	}
+
+#define MT7530_NUM_PORTS 8
+#define REG_ESW_PORT_PCR(x)    (0x2004 | ((x) << 8))
+#define REG_ESW_PORT_PVC(x)    (0x2010 | ((x) << 8))
+#define REG_ESW_PORT_PPBV1(x)  (0x2014 | ((x) << 8))
+#define MT7530_CPU_PORT                6
+
+	/* This is copied from mt7530_apply_config in libreCMC driver */
+	{
+		int i;
+		for (i = 0; i < MT7530_NUM_PORTS; i++)
+			mt7530_mdio_w32(gsw, REG_ESW_PORT_PCR(i), 0x00400000);
+
+		mt7530_mdio_w32(gsw, REG_ESW_PORT_PCR(MT7530_CPU_PORT), 0x00ff0000);
+
+		for (i = 0; i < MT7530_NUM_PORTS; i++)
+			mt7530_mdio_w32(gsw, REG_ESW_PORT_PVC(i), 0x810000c0);
+
+	}
+
+	/* enable irq */
+	mt7530_mdio_m32(gsw, 0, 3 << 16, MT7530_TOP_SIG_CTRL);
+	mt7530_mdio_w32(gsw, MT7530_SYS_INT_EN, 0x1f);
+
+}
+
+static const struct of_device_id mediatek_gsw_match[] = {
+	{ .compatible = "mediatek,mt7621-gsw" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mediatek_gsw_match);
+
+int mtk_gsw_init(struct mtk_eth *eth)
+{
+	struct device_node *np = eth->switch_np;
+	struct platform_device *pdev = of_find_device_by_node(np);
+	struct mt7620_gsw *gsw;
+
+	if (!pdev)
+		return -ENODEV;
+
+	if (!of_device_is_compatible(np, mediatek_gsw_match->compatible))
+		return -EINVAL;
+
+	gsw = platform_get_drvdata(pdev);
+	eth->sw_priv = gsw;
+
+	if (!gsw->irq)
+		return -EINVAL;
+
+	request_irq(gsw->irq, gsw_interrupt_mt7621, 0,
+		    "gsw", eth);
+	disable_irq(gsw->irq);
+
+	mt7621_hw_init(eth, gsw, np);
+
+	enable_irq(gsw->irq);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mtk_gsw_init);
+
+static int mt7621_gsw_probe(struct platform_device *pdev)
+{
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct mt7620_gsw *gsw;
+
+	gsw = devm_kzalloc(&pdev->dev, sizeof(struct mt7620_gsw), GFP_KERNEL);
+	if (!gsw)
+		return -ENOMEM;
+
+	gsw->base = devm_ioremap_resource(&pdev->dev, res);
+	if (!gsw->base)
+		return -EADDRNOTAVAIL;
+
+	gsw->dev = &pdev->dev;
+	gsw->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+
+	platform_set_drvdata(pdev, gsw);
+
+	return 0;
+}
+
+static int mt7621_gsw_remove(struct platform_device *pdev)
+{
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver gsw_driver = {
+	.probe = mt7621_gsw_probe,
+	.remove = mt7621_gsw_remove,
+	.driver = {
+		.name = "mt7621-gsw",
+		.owner = THIS_MODULE,
+		.of_match_table = mediatek_gsw_match,
+	},
+};
+
+module_platform_driver(gsw_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
+MODULE_DESCRIPTION("GBit switch driver for Mediatek MT7621 SoC");
