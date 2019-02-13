Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDF9C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF23222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391690AbfBMLCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:02:37 -0500
Received: from inva020.nxp.com ([92.121.34.13]:39270 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732696AbfBMLC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:02:29 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 13AB41A0110;
        Wed, 13 Feb 2019 12:02:27 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 06EA61A0018;
        Wed, 13 Feb 2019 12:02:27 +0100 (CET)
Received: from fsr-ub1664-016.ea.freescale.net (fsr-ub1664-016.ea.freescale.net [10.171.71.216])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 9FDF42060A;
        Wed, 13 Feb 2019 12:02:26 +0100 (CET)
From:   Claudiu Manoil <claudiu.manoil@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     alexandru.marginean@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/3] enetc: Add ENETC PF level external MDIO support
Date:   Wed, 13 Feb 2019 13:02:23 +0200
Message-Id: <1550055743-15542-4-git-send-email-claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550055743-15542-1-git-send-email-claudiu.manoil@nxp.com>
References: <1550055743-15542-1-git-send-email-claudiu.manoil@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each ENETC PF has its own MDIO interface, the corresponding
MDIO registers are mapped in the ENETC's Port register block.
The current patch adds a driver for these PF level MDIO buses,
so that each PF can manage directly its own external link.

Signed-off-by: Alex Marginean <alexandru.marginean@nxp.com>
Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/Makefile     |   3 +-
 drivers/net/ethernet/freescale/enetc/enetc_mdio.c | 196 ++++++++++++++++++++++
 drivers/net/ethernet/freescale/enetc/enetc_pf.c   |  13 ++
 drivers/net/ethernet/freescale/enetc/enetc_pf.h   |   6 +
 4 files changed, 217 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_mdio.c

diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
index 6976602..7139e41 100644
--- a/drivers/net/ethernet/freescale/enetc/Makefile
+++ b/drivers/net/ethernet/freescale/enetc/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_FSL_ENETC) += fsl-enetc.o
-fsl-enetc-$(CONFIG_FSL_ENETC) += enetc.o enetc_cbdr.o enetc_ethtool.o
+fsl-enetc-$(CONFIG_FSL_ENETC) += enetc.o enetc_cbdr.o enetc_ethtool.o \
+				 enetc_mdio.o
 fsl-enetc-$(CONFIG_PCI_IOV) += enetc_msg.o
 fsl-enetc-objs := enetc_pf.o $(fsl-enetc-y)
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
new file mode 100644
index 0000000..e71b4fd
--- /dev/null
+++ b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/* Copyright 2019 NXP */
+
+#include <linux/mdio.h>
+#include <linux/of_mdio.h>
+
+#include "enetc_pf.h"
+
+struct enetc_mdio_regs {
+	u32	mdio_cfg;	/* MDIO configuration and status */
+	u32	mdio_ctl;	/* MDIO control */
+	u32	mdio_data;	/* MDIO data */
+	u32	mdio_addr;	/* MDIO address */
+};
+
+#define bus_to_enetc_regs(bus)	(struct enetc_mdio_regs __iomem *)((bus)->priv)
+
+#define ENETC_MDIO_REG_OFFSET	0x1c00
+#define ENETC_MDC_DIV		258
+#define MDIO_CFG_CLKDIV(x)	((((x) >> 1) & 0xff) << 8)
+#define MDIO_CFG_BSY		BIT(0)
+#define MDIO_CFG_RD_ER		BIT(1)
+#define MDIO_CFG_ENC		BIT(6)
+#define MDIO_CFG_NEG		BIT(23)
+#define MDIO_CTL_DEV_ADDR(x)	((x) & 0x1f)
+#define MDIO_CTL_PORT_ADDR(x)	(((x) & 0x1f) << 5)
+#define MDIO_CTL_READ		BIT(15)
+#define MDIO_DATA(x)		((x) & 0xffff)
+
+#define TIMEOUT	1000
+static int enetc_wait_complete(struct device *dev,
+			       struct enetc_mdio_regs __iomem *regs)
+{
+	unsigned int timeout;
+
+	timeout = TIMEOUT;
+	while ((enetc_rd_reg(&regs->mdio_cfg) & MDIO_CFG_BSY) && timeout) {
+		cpu_relax();
+		timeout--;
+	}
+
+	if (!timeout) {
+		dev_err(dev, "timeout waiting for bus to be free\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int enetc_mdio_write(struct mii_bus *bus, int phy_id, int regnum,
+			    u16 value)
+{
+	struct enetc_mdio_regs __iomem *regs = bus_to_enetc_regs(bus);
+	u32 mdio_ctl, mdio_cfg;
+	u16 dev_addr;
+	int ret;
+
+	mdio_cfg = MDIO_CFG_CLKDIV(ENETC_MDC_DIV) | MDIO_CFG_NEG;
+	if (regnum & MII_ADDR_C45) {
+		/* clause 45 */
+		dev_addr = (regnum >> 16) & 0x1f;
+		mdio_cfg |= MDIO_CFG_ENC;
+	} else {
+		/* clause 22 (ie 1G) */
+		dev_addr = regnum & 0x1f;
+		mdio_cfg &= ~MDIO_CFG_ENC;
+	}
+
+	enetc_wr_reg(&regs->mdio_cfg, mdio_cfg);
+
+	ret = enetc_wait_complete(&bus->dev, regs);
+	if (ret)
+		return ret;
+
+	/* set port and dev addr */
+	mdio_ctl = MDIO_CTL_PORT_ADDR(phy_id) | MDIO_CTL_DEV_ADDR(dev_addr);
+	enetc_wr_reg(&regs->mdio_ctl, mdio_ctl);
+
+	/* set the register address */
+	if (regnum & MII_ADDR_C45) {
+		enetc_wr_reg(&regs->mdio_addr, regnum & 0xffff);
+
+		ret = enetc_wait_complete(&bus->dev, regs);
+		if (ret)
+			return ret;
+	}
+
+	/* write the value */
+	enetc_wr_reg(&regs->mdio_data, MDIO_DATA(value));
+
+	ret = enetc_wait_complete(&bus->dev, regs);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int enetc_mdio_read(struct mii_bus *bus, int phy_id, int regnum)
+{
+	struct enetc_mdio_regs __iomem *regs = bus_to_enetc_regs(bus);
+	u32 mdio_ctl, mdio_cfg;
+	u16 dev_addr, value;
+	int ret;
+
+	mdio_cfg = MDIO_CFG_CLKDIV(ENETC_MDC_DIV) | MDIO_CFG_NEG;
+	if (regnum & MII_ADDR_C45) {
+		dev_addr = (regnum >> 16) & 0x1f;
+		mdio_cfg |= MDIO_CFG_ENC;
+	} else {
+		dev_addr = regnum & 0x1f;
+		mdio_cfg &= ~MDIO_CFG_ENC;
+	}
+
+	enetc_wr_reg(&regs->mdio_cfg, mdio_cfg);
+
+	ret = enetc_wait_complete(&bus->dev, regs);
+	if (ret)
+		return ret;
+
+	/* set port and device addr */
+	mdio_ctl = MDIO_CTL_PORT_ADDR(phy_id) | MDIO_CTL_DEV_ADDR(dev_addr);
+	enetc_wr_reg(&regs->mdio_ctl, mdio_ctl);
+
+	/* set the register address */
+	if (regnum & MII_ADDR_C45) {
+		enetc_wr_reg(&regs->mdio_addr, regnum & 0xffff);
+
+		ret = enetc_wait_complete(&bus->dev, regs);
+		if (ret)
+			return ret;
+	}
+
+	/* initiate the read */
+	enetc_wr_reg(&regs->mdio_ctl, mdio_ctl | MDIO_CTL_READ);
+
+	ret = enetc_wait_complete(&bus->dev, regs);
+	if (ret)
+		return ret;
+
+	/* return all Fs if nothing was there */
+	if (enetc_rd_reg(&regs->mdio_cfg) & MDIO_CFG_RD_ER) {
+		dev_err(&bus->dev,
+			"Error while reading PHY%d reg at %d.%hhu\n",
+			phy_id, dev_addr, regnum);
+		return 0xffff;
+	}
+
+	value = enetc_rd_reg(&regs->mdio_data) & 0xffff;
+
+	return value;
+}
+
+int enetc_mdio_probe(struct enetc_pf *pf)
+{
+	struct device *dev = &pf->si->pdev->dev;
+	struct enetc_mdio_regs __iomem *regs;
+	struct mii_bus *bus;
+	int ret;
+
+	bus = mdiobus_alloc_size(sizeof(regs));
+	if (!bus)
+		return -ENOMEM;
+
+	bus->name = "Freescale ENETC MDIO Bus";
+	bus->read = enetc_mdio_read;
+	bus->write = enetc_mdio_write;
+	bus->parent = dev;
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
+
+	/* store the enetc mdio base address for this bus */
+	regs = pf->si->hw.port + ENETC_MDIO_REG_OFFSET;
+	bus->priv = regs;
+
+	ret = of_mdiobus_register(bus, dev->of_node);
+	if (ret) {
+		dev_err(dev, "cannot register MDIO bus\n");
+		goto err_registration;
+	}
+
+	pf->mdio = bus;
+
+	return 0;
+
+err_registration:
+	mdiobus_free(bus);
+
+	return ret;
+}
+
+void enetc_mdio_remove(struct enetc_pf *pf)
+{
+	if (pf->mdio) {
+		mdiobus_unregister(pf->mdio);
+		mdiobus_free(pf->mdio);
+	}
+}
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 7d28f5e..27838ed 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -746,6 +746,7 @@ static void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 
 static int enetc_of_get_phy(struct enetc_ndev_priv *priv)
 {
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
 	struct device_node *np = priv->dev->of_node;
 	int err;
 
@@ -770,12 +771,23 @@ static int enetc_of_get_phy(struct enetc_ndev_priv *priv)
 		priv->phy_node = of_node_get(np);
 	}
 
+	if (!of_phy_is_fixed_link(np)) {
+		err = enetc_mdio_probe(pf);
+		if (err) {
+			dev_err(priv->dev, "MDIO bus registration failed\n");
+			of_node_put(priv->phy_node);
+			return err;
+		}
+	}
+
 	priv->if_mode = of_get_phy_mode(np);
 	if (priv->if_mode < 0) {
 		dev_err(priv->dev, "missing phy type\n");
 		of_node_put(priv->phy_node);
 		if (of_phy_is_fixed_link(np))
 			of_phy_deregister_fixed_link(np);
+		else
+			enetc_mdio_remove(pf);
 
 		return -EINVAL;
 	}
@@ -898,6 +910,7 @@ static void enetc_pf_remove(struct pci_dev *pdev)
 
 	unregister_netdev(si->ndev);
 
+	enetc_mdio_remove(pf);
 	enetc_of_put_phy(priv);
 
 	enetc_free_msix(priv);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 2061ae5..10dd1b5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -42,8 +42,14 @@ struct enetc_pf {
 	char vlan_promisc_simap; /* bitmap of SIs in VLAN promisc mode */
 	DECLARE_BITMAP(vlan_ht_filter, ENETC_VLAN_HT_SIZE);
 	DECLARE_BITMAP(active_vlans, VLAN_N_VID);
+
+	struct mii_bus *mdio; /* saved for cleanup */
 };
 
 int enetc_msg_psi_init(struct enetc_pf *pf);
 void enetc_msg_psi_free(struct enetc_pf *pf);
 void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int mbox_id, u16 *status);
+
+/* MDIO */
+int enetc_mdio_probe(struct enetc_pf *pf);
+void enetc_mdio_remove(struct enetc_pf *pf);
-- 
2.7.4

