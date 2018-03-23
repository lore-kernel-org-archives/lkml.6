Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752507AbeCWUOa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 16:14:30 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34912 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751880AbeCWULh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 16:11:37 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH net-next 3/8] net: mscc: Add MDIO driver
Date: Fri, 23 Mar 2018 21:11:12 +0100
Message-Id: <20180323201117.8416-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the Microsemi MII Management controller (MIIM) found on
Microsemi SoCs.
On Ocelot, there are two controllers, one is connected to the internal
PHYs, the other one can communicate with external PHYs.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/net/ethernet/Kconfig          |   1 +
 drivers/net/ethernet/Makefile         |   1 +
 drivers/net/ethernet/mscc/Kconfig     |  22 ++++
 drivers/net/ethernet/mscc/Makefile    |   2 +
 drivers/net/ethernet/mscc/mscc_miim.c | 210 ++++++++++++++++++++++++++++++++++
 5 files changed, 236 insertions(+)
 create mode 100644 drivers/net/ethernet/mscc/Kconfig
 create mode 100644 drivers/net/ethernet/mscc/Makefile
 create mode 100644 drivers/net/ethernet/mscc/mscc_miim.c

diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index b6cf4b6962f5..adf643484198 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -115,6 +115,7 @@ source "drivers/net/ethernet/mediatek/Kconfig"
 source "drivers/net/ethernet/mellanox/Kconfig"
 source "drivers/net/ethernet/micrel/Kconfig"
 source "drivers/net/ethernet/microchip/Kconfig"
+source "drivers/net/ethernet/mscc/Kconfig"
 source "drivers/net/ethernet/moxa/Kconfig"
 source "drivers/net/ethernet/myricom/Kconfig"
 
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 3cdf01e96e0b..ed7df22de7ff 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_NET_VENDOR_MEDIATEK) += mediatek/
 obj-$(CONFIG_NET_VENDOR_MELLANOX) += mellanox/
 obj-$(CONFIG_NET_VENDOR_MICREL) += micrel/
 obj-$(CONFIG_NET_VENDOR_MICROCHIP) += microchip/
+obj-$(CONFIG_NET_VENDOR_MICROSEMI) += mscc/
 obj-$(CONFIG_NET_VENDOR_MOXART) += moxa/
 obj-$(CONFIG_NET_VENDOR_MYRI) += myricom/
 obj-$(CONFIG_FEALNX) += fealnx.o
diff --git a/drivers/net/ethernet/mscc/Kconfig b/drivers/net/ethernet/mscc/Kconfig
new file mode 100644
index 000000000000..2330de6e7bb6
--- /dev/null
+++ b/drivers/net/ethernet/mscc/Kconfig
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: (GPL-2.0 OR MIT)
+config NET_VENDOR_MICROSEMI
+	bool "Microsemi devices"
+	default y
+	help
+	  If you have a network (Ethernet) card belonging to this class, say Y.
+
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all
+	  the questions about Microsemi devices.
+
+if NET_VENDOR_MICROSEMI
+
+config MSCC_MIIM
+	tristate "Microsemi MIIM interface support"
+	depends on HAS_IOMEM
+	select PHYLIB
+	help
+	  This driver supports the MIIM (MDIO) interface found in the network
+	  switches of the Microsemi SoCs
+
+endif # NET_VENDOR_MICROSEMI
diff --git a/drivers/net/ethernet/mscc/Makefile b/drivers/net/ethernet/mscc/Makefile
new file mode 100644
index 000000000000..4570e8fa4711
--- /dev/null
+++ b/drivers/net/ethernet/mscc/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: (GPL-2.0 OR MIT)
+obj-$(CONFIG_MSCC_MIIM) += mscc_miim.o
diff --git a/drivers/net/ethernet/mscc/mscc_miim.c b/drivers/net/ethernet/mscc/mscc_miim.c
new file mode 100644
index 000000000000..95b8d102c90f
--- /dev/null
+++ b/drivers/net/ethernet/mscc/mscc_miim.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Driver for the MDIO interface of Microsemi network switches.
+ *
+ * Author: Alexandre Belloni <alexandre.belloni@bootlin.com>
+ * Copyright (c) 2017 Microsemi Corporation
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/phy.h>
+#include <linux/platform_device.h>
+#include <linux/bitops.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/of_mdio.h>
+
+#define MSCC_MIIM_REG_STATUS		0x0
+#define		MSCC_MIIM_STATUS_STAT_BUSY	BIT(3)
+#define MSCC_MIIM_REG_CMD		0x8
+#define		MSCC_MIIM_CMD_OPR_WRITE		BIT(1)
+#define		MSCC_MIIM_CMD_OPR_READ		BIT(2)
+#define		MSCC_MIIM_CMD_WRDATA_SHIFT	4
+#define		MSCC_MIIM_CMD_REGAD_SHIFT	20
+#define		MSCC_MIIM_CMD_PHYAD_SHIFT	25
+#define		MSCC_MIIM_CMD_VLD		BIT(31)
+#define MSCC_MIIM_REG_DATA		0xC
+#define		MSCC_MIIM_DATA_ERROR		(BIT(16) | BIT(17))
+
+#define MSCC_PHY_REG_PHY_CFG	0x0
+#define		PHY_CFG_PHY_ENA		(BIT(0) | BIT(1) | BIT(2) | BIT(3))
+#define		PHY_CFG_PHY_COMMON_RESET BIT(4)
+#define		PHY_CFG_PHY_RESET	(BIT(5) | BIT(6) | BIT(7) | BIT(8))
+#define MSCC_PHY_REG_PHY_STATUS	0x4
+
+struct mscc_miim_dev {
+	struct mutex lock;
+	void __iomem *regs;
+	void __iomem *phy_regs;
+};
+
+static int mscc_miim_wait_ready(struct mii_bus *bus)
+{
+	struct mscc_miim_dev *miim = bus->priv;
+	u32 val;
+
+	readl_poll_timeout(miim->regs + MSCC_MIIM_REG_STATUS, val,
+			   !(val & MSCC_MIIM_STATUS_STAT_BUSY), 100, 250000);
+	if (val & MSCC_MIIM_STATUS_STAT_BUSY)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int mscc_miim_read(struct mii_bus *bus, int mii_id, int regnum)
+{
+	struct mscc_miim_dev *miim = bus->priv;
+	u32 val;
+	int ret;
+
+	mutex_lock(&miim->lock);
+
+	ret = mscc_miim_wait_ready(bus);
+	if (ret)
+		goto out;
+
+	writel(MSCC_MIIM_CMD_VLD | (mii_id << MSCC_MIIM_CMD_PHYAD_SHIFT) |
+	       (regnum << MSCC_MIIM_CMD_REGAD_SHIFT) | MSCC_MIIM_CMD_OPR_READ,
+	       miim->regs + MSCC_MIIM_REG_CMD);
+
+	ret = mscc_miim_wait_ready(bus);
+	if (ret)
+		goto out;
+
+	val = readl(miim->regs + MSCC_MIIM_REG_DATA);
+	if (val & MSCC_MIIM_DATA_ERROR) {
+		ret = -EIO;
+		goto out;
+	}
+
+	ret = val & 0xFFFF;
+out:
+	mutex_unlock(&miim->lock);
+	return ret;
+}
+
+static int mscc_miim_write(struct mii_bus *bus, int mii_id,
+			   int regnum, u16 value)
+{
+	struct mscc_miim_dev *miim = bus->priv;
+	int ret;
+
+	mutex_lock(&miim->lock);
+
+	ret = mscc_miim_wait_ready(bus);
+	if (ret < 0)
+		goto out;
+
+	writel(MSCC_MIIM_CMD_VLD | (mii_id << MSCC_MIIM_CMD_PHYAD_SHIFT) |
+	       (regnum << MSCC_MIIM_CMD_REGAD_SHIFT) |
+	       (value << MSCC_MIIM_CMD_WRDATA_SHIFT) |
+	       MSCC_MIIM_CMD_OPR_WRITE,
+	       miim->regs + MSCC_MIIM_REG_CMD);
+
+out:
+	mutex_unlock(&miim->lock);
+	return ret;
+}
+
+static int mscc_miim_reset(struct mii_bus *bus)
+{
+	struct mscc_miim_dev *miim = bus->priv;
+	int i;
+
+	if (miim->phy_regs) {
+		writel(0, miim->phy_regs + MSCC_PHY_REG_PHY_CFG);
+		writel(0x1ff, miim->phy_regs + MSCC_PHY_REG_PHY_CFG);
+		mdelay(500);
+	}
+
+	for (i = 0; i < PHY_MAX_ADDR; i++) {
+		if (mscc_miim_read(bus, i, MII_PHYSID1) < 0)
+			bus->phy_mask |= BIT(i);
+	}
+
+	return 0;
+}
+
+static int mscc_miim_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct mii_bus *bus;
+	struct mscc_miim_dev *dev;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	bus = devm_mdiobus_alloc_size(&pdev->dev, sizeof(*dev));
+	if (!bus)
+		return -ENOMEM;
+
+	bus->name = "mscc_miim";
+	bus->read = mscc_miim_read;
+	bus->write = mscc_miim_write;
+	bus->reset = mscc_miim_reset;
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-mii", dev_name(&pdev->dev));
+	bus->parent = &pdev->dev;
+
+	dev = bus->priv;
+	dev->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(dev->regs)) {
+		dev_err(&pdev->dev, "Unable to map MIIM registers\n");
+		return PTR_ERR(dev->regs);
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (res) {
+		dev->phy_regs = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(dev->phy_regs)) {
+			dev_err(&pdev->dev, "Unable to map internal phy registers\n");
+			return PTR_ERR(dev->phy_regs);
+		}
+	}
+
+	if (pdev->dev.of_node)
+		ret = of_mdiobus_register(bus, pdev->dev.of_node);
+	else
+		ret = mdiobus_register(bus);
+
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Cannot register MDIO bus (%d)\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, bus);
+
+	return 0;
+}
+
+static int mscc_miim_remove(struct platform_device *pdev)
+{
+	struct mii_bus *bus = platform_get_drvdata(pdev);
+
+	mdiobus_unregister(bus);
+
+	return 0;
+}
+
+static const struct of_device_id mscc_miim_match[] = {
+	{ .compatible = "mscc,ocelot-miim" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mscc_miim_match);
+
+static struct platform_driver mscc_miim_driver = {
+	.probe = mscc_miim_probe,
+	.remove = mscc_miim_remove,
+	.driver = {
+		.name = "mscc-miim",
+		.of_match_table = mscc_miim_match,
+	},
+};
+
+module_platform_driver(mscc_miim_driver);
+
+MODULE_DESCRIPTION("Microsemi MIIM driver");
+MODULE_AUTHOR("Alexandre Belloni <alexandre.belloni@bootlin.com>");
+MODULE_LICENSE("Dual MIT/GPL");
-- 
2.16.2
