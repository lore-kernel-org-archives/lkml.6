Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756631AbeDZT7p (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 15:59:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35253 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755855AbeDZT7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 15:59:39 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH net-next v2 2/7] net: mscc: Add MDIO driver
Date: Thu, 26 Apr 2018 21:59:26 +0200
Message-Id: <20180426195931.5393-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180426195931.5393-1-alexandre.belloni@bootlin.com>
References: <20180426195931.5393-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the Microsemi MII Management controller (MIIM) found on
Microsemi SoCs.
On Ocelot, there are two controllers, one is connected to the internal
PHYs, the other one can communicate with external PHYs.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/net/phy/Kconfig          |   7 ++
 drivers/net/phy/Makefile         |   1 +
 drivers/net/phy/mdio-mscc-miim.c | 197 +++++++++++++++++++++++++++++++
 3 files changed, 205 insertions(+)
 create mode 100644 drivers/net/phy/mdio-mscc-miim.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index bdfbabb86ee0..c67a72d23157 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -123,6 +123,13 @@ config MDIO_MOXART
 	  This driver supports the MDIO interface found in the network
 	  interface units of the MOXA ART SoC
 
+config MDIO_MSCC_MIIM
+	tristate "Microsemi MIIM interface support"
+	depends on HAS_IOMEM
+	help
+	  This driver supports the MIIM (MDIO) interface found in the network
+	  switches of the Microsemi SoCs
+
 config MDIO_OCTEON
 	tristate "Octeon and some ThunderX SOCs MDIO buses"
 	depends on 64BIT
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 01acbcb2c798..7c0ef479ffc4 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_MDIO_GPIO)		+= mdio-gpio.o
 obj-$(CONFIG_MDIO_HISI_FEMAC)	+= mdio-hisi-femac.o
 obj-$(CONFIG_MDIO_I2C)		+= mdio-i2c.o
 obj-$(CONFIG_MDIO_MOXART)	+= mdio-moxart.o
+obj-$(CONFIG_MDIO_MSCC_MIIM)	+= mdio-mscc-miim.o
 obj-$(CONFIG_MDIO_OCTEON)	+= mdio-octeon.o
 obj-$(CONFIG_MDIO_SUN4I)	+= mdio-sun4i.o
 obj-$(CONFIG_MDIO_THUNDER)	+= mdio-thunder.o
diff --git a/drivers/net/phy/mdio-mscc-miim.c b/drivers/net/phy/mdio-mscc-miim.c
new file mode 100644
index 000000000000..8c689ccfdbca
--- /dev/null
+++ b/drivers/net/phy/mdio-mscc-miim.c
@@ -0,0 +1,197 @@
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
+	return ret;
+}
+
+static int mscc_miim_write(struct mii_bus *bus, int mii_id,
+			   int regnum, u16 value)
+{
+	struct mscc_miim_dev *miim = bus->priv;
+	int ret;
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
+	return ret;
+}
+
+static int mscc_miim_reset(struct mii_bus *bus)
+{
+	struct mscc_miim_dev *miim = bus->priv;
+
+	if (miim->phy_regs) {
+		writel(0, miim->phy_regs + MSCC_PHY_REG_PHY_CFG);
+		writel(0x1ff, miim->phy_regs + MSCC_PHY_REG_PHY_CFG);
+		mdelay(500);
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
2.17.0
