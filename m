Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FD0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7718F21841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="es3S48cq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeLRQy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:54:26 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:51967 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbeLRQyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:54:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=Message-Id:Date:Subject:Cc:To:From; bh=EY+s1c64fjbQsV87kkCuYTWiDpYkk6IxHN9/JJR3Sh8=;
        b=es3S48cqlxWhMzhj4SNC8Z4Qjpg0dq584o0tuIg1Qlrk1CN3nmeRi8/KJeUgoBH18YNWLdAlBMgjGCqxolhbPLhu1UWCElXM2EY0/mf7wN45ZsCdIsLkqem0zdYfOnQIq47/Vq9KQBzTuxDBa0cURWMqBgPBPzv67nHVgNXL818=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gZId8-00063Q-EP; Tue, 18 Dec 2018 17:54:02 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2] mfd: tqmx86: IO controller with i2c, wachdog and gpio
Date:   Tue, 18 Dec 2018 17:53:56 +0100
Message-Id: <1545152036-23239-1-git-send-email-andrew@lunn.ch>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QMX86 is a PLD present on some TQ-Systems ComExpress modules. It
provides 1 or 2 I2C bus masters, 8 GPIOs and a watchdog timer. Add an
MFD which will instantiate the individual drivers.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
v2:

Drop setting i2c bus speed, which removes the build dependencies on
the i2c ocores patches. This can be added back later.
---
 drivers/mfd/Kconfig  |   8 +
 drivers/mfd/Makefile |   1 +
 drivers/mfd/tqmx86.c | 404 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 413 insertions(+)
 create mode 100644 drivers/mfd/tqmx86.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 8c5dfdce4326..8c86a2a215e8 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1676,6 +1676,14 @@ config MFD_TC6393XB
 	help
 	  Support for Toshiba Mobile IO Controller TC6393XB
 
+config MFD_TQMX86
+       tristate "TQ-Systems IO controller TQMX86"
+       select MFD_CORE
+       help
+	  Say yes here to enable support for various functions of the
+	  TQ-Systems IO controller and watchdog device, found on their
+	  ComExpress CPU modules
+
 config MFD_VX855
 	tristate "VIA VX855/VX875 integrated south bridge"
 	depends on PCI
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 12980a4ad460..7f4790662988 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_MFD_TC3589X)	+= tc3589x.o
 obj-$(CONFIG_MFD_T7L66XB)	+= t7l66xb.o tmio_core.o
 obj-$(CONFIG_MFD_TC6387XB)	+= tc6387xb.o tmio_core.o
 obj-$(CONFIG_MFD_TC6393XB)	+= tc6393xb.o tmio_core.o
+obj-$(CONFIG_MFD_TQMX86)	+= tqmx86.o
 
 obj-$(CONFIG_MFD_ARIZONA)	+= arizona-core.o
 obj-$(CONFIG_MFD_ARIZONA)	+= arizona-irq.o
diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
new file mode 100644
index 000000000000..4eca166db000
--- /dev/null
+++ b/drivers/mfd/tqmx86.c
@@ -0,0 +1,404 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TQ-Systems PLD MFD core driver
+ *
+ * Copyright (c) 2015 TQ-Systems GmbH
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/dmi.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/platform_data/i2c-ocores.h>
+
+#define TQMX86_IOBASE	0x160
+#define TQMX86_IOSIZE	0x3f
+#define TQMX86_CLK	33000	/* default */
+
+/* Registers offsets */
+#define TQMX86_BID	0x20	/* Board ID */
+#define TQMX86_BREV	0x21	/* Board and PLD Revisions */
+#define TQMX86_IOEIC	0x26	/* I/O Extension Interrupt Configuration */
+#define TQMX86_I2C_DET	0x47	/* I2C controller detection register */
+#define TQMX86_I2C_IEN	0x49	/* machxo2 I2C nterrupt enable register */
+
+struct tqmx86_info {
+	u32	board_id;
+	u32	board_rev;
+	u32	pld_rev;
+	u32	i2c_type;
+};
+
+#define I2C_KIND_SOFT	1	/* Ocores soft controller */
+#define I2C_KIND_HARD	2	/* Machxo2 hard controller */
+
+/**
+ * struct tqmx86_device_data - Internal representation of the PLD device
+ * @io_base:		Pointer to the IO memory
+ * @pld_clock:		PLD clock frequency
+ * @dev:		Pointer to kernel device structure
+ */
+struct tqmx86_device_data {
+	void __iomem		*io_base;
+	u32			pld_clock;
+	struct device		*dev;
+	struct tqmx86_info	info;
+};
+
+/**
+ * struct tqmx86_platform_data - PLD hardware configuration structure
+ * @pld_clock:			PLD clock frequency
+ * @ioresource:			IO addresses of the PLD
+ */
+struct tqmx86_platform_data {
+	u32				pld_clock;
+	struct resource			*ioresource;
+};
+
+static uint gpio_irq;
+module_param(gpio_irq, uint, 0);
+MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (7, 9, 12)");
+
+static u8 i2c_irq_ctl[16] = {
+	[7] = 1,
+	[9] = 2,
+	[12] = 3
+};
+
+static u8 tqmx86_readb(struct tqmx86_device_data *pld, u32 off)
+{
+	return ioread8(pld->io_base + off);
+}
+
+static void tqmx86_writeb(struct tqmx86_device_data *pld, u8 val, u32 off)
+{
+	iowrite8(val, pld->io_base + off);
+}
+
+enum tqmx86_cells {
+	TQMX86_I2C_SOFT = 0,
+	TQMX86_WDT,
+	TQMX86_GPIO,
+	TQMX86_UART,
+};
+
+static struct resource tqmx_i2c_soft_resources[] = {
+	DEFINE_RES_IO(0x1a0, 10),
+};
+
+static struct resource tqmx_watchdog_resources[] = {
+	DEFINE_RES_IO(0x18b, 2),
+};
+
+static struct resource tqmx_gpio_resources[] = {
+	DEFINE_RES_IO(0x18d, 4),
+	DEFINE_RES_IRQ(0)
+};
+
+static struct i2c_board_info tqmx86_i2c_devices[] = {
+	/* 4K EEPROM at 0x50 */
+	{
+		.type = "24c32",
+		.addr = 0x50,
+	},
+};
+
+static struct ocores_i2c_platform_data ocores_platfom_data = {
+	.clock_khz = TQMX86_CLK,
+	.num_devices = ARRAY_SIZE(tqmx86_i2c_devices),
+	.devices = tqmx86_i2c_devices,
+};
+
+static const struct mfd_cell tqmx86_devs[] = {
+	[TQMX86_I2C_SOFT] = {
+		.name = "ocores-i2c",
+		.platform_data = &ocores_platfom_data,
+		.pdata_size = sizeof(ocores_platfom_data),
+		.resources = tqmx_i2c_soft_resources,
+		.num_resources = ARRAY_SIZE(tqmx_i2c_soft_resources),
+	},
+	[TQMX86_WDT] = {
+		.name = "tqmx86-wdt",
+		.resources = tqmx_watchdog_resources,
+		.num_resources = 1,
+		.ignore_resource_conflicts = 1,
+	},
+	[TQMX86_GPIO] = {
+		.name = "tqmx86-gpio",
+		.resources = tqmx_gpio_resources,
+		.num_resources = ARRAY_SIZE(tqmx_gpio_resources),
+		.ignore_resource_conflicts = 1,
+	},
+};
+
+#define TQMX86_MAX_DEVS	ARRAY_SIZE(tqmx86_devs)
+
+static int tqmx86_register_cells(struct tqmx86_device_data *pld)
+{
+	struct mfd_cell devs[TQMX86_MAX_DEVS];
+	int i = 0;
+	u8 ioeic_val = 0;
+
+	ioeic_val |= (i2c_irq_ctl[gpio_irq] & 0x3) << 4;
+
+	dev_dbg(pld->dev, "ioeic %x\n", ioeic_val);
+
+	if (ioeic_val) {
+		tqmx86_writeb(pld, ioeic_val, TQMX86_IOEIC);
+		if (tqmx86_readb(pld, TQMX86_IOEIC) != ioeic_val) {
+			dev_warn(pld->dev,
+				 "i2c/gpio interrupts not supported.\n");
+			gpio_irq = 0;
+		}
+	}
+
+	if (pld->info.i2c_type == I2C_KIND_SOFT) {
+		ocores_platfom_data.clock_khz = pld->pld_clock;
+		devs[i++] = tqmx86_devs[TQMX86_I2C_SOFT];
+	}
+
+	tqmx_gpio_resources[1].start = gpio_irq;
+
+	devs[i++] = tqmx86_devs[TQMX86_WDT];
+	devs[i++] = tqmx86_devs[TQMX86_GPIO];
+
+	return mfd_add_devices(pld->dev, -1, devs, i, NULL, 0, NULL);
+}
+
+static struct resource tqmx86_ioresource = {
+	.start	= TQMX86_IOBASE,
+	.end	= TQMX86_IOBASE + TQMX86_IOSIZE,
+	.flags	= IORESOURCE_IO,
+};
+
+static const struct tqmx86_platform_data tqmx86_platform_data_generic = {
+	.pld_clock		= TQMX86_CLK,
+	.ioresource		= &tqmx86_ioresource,
+};
+
+static struct platform_device *tqmx86_pdev;
+
+static int tqmx86_create_platform_device(const struct dmi_system_id *id)
+{
+	struct tqmx86_platform_data *pdata = id->driver_data;
+	int ret;
+
+	tqmx86_pdev = platform_device_alloc("tqmx86", -1);
+	if (!tqmx86_pdev)
+		return -ENOMEM;
+
+	ret = platform_device_add_data(tqmx86_pdev, pdata, sizeof(*pdata));
+	if (ret)
+		goto err;
+
+	ret = platform_device_add_resources(tqmx86_pdev, pdata->ioresource, 1);
+	if (ret)
+		goto err;
+
+	ret = platform_device_add(tqmx86_pdev);
+	if (ret)
+		goto err;
+
+	return 0;
+err:
+	platform_device_put(tqmx86_pdev);
+	return ret;
+}
+
+static struct tq_board_info {
+	char *name;
+	u32 pld_clock;
+} tq_board_info[] = {
+	{"", 0},
+	{"TQMxE38M", 33000},
+	{"TQMx50UC", 24000},
+	{"TQMxE38C", 33000},
+	{"TQMx60EB", 24000},
+	{"TQMxE39M", 25000},
+	{"TQMxE39C", 25000},
+	{"TQMxE39x", 25000},
+	{"TQMx70EB", 24000},
+	{"TQMx80UC", 24000},
+	{"TQMx90UC", 24000}
+};
+
+static ssize_t board_id_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct tqmx86_device_data *pld = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n",
+			 tq_board_info[pld->info.board_id].name);
+}
+
+static ssize_t board_rev_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct tqmx86_device_data *pld = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", pld->info.board_rev);
+}
+
+static ssize_t pld_rev_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct tqmx86_device_data *pld = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "PLD Revision: %d",
+			 pld->info.pld_rev);
+}
+
+static DEVICE_ATTR_RO(board_id);
+static DEVICE_ATTR_RO(board_rev);
+static DEVICE_ATTR_RO(pld_rev);
+
+static struct attribute *pld_attributes[] = {
+	&dev_attr_board_id.attr,
+	&dev_attr_board_rev.attr,
+	&dev_attr_pld_rev.attr,
+	NULL
+};
+
+static const struct attribute_group pld_attr_group = {
+	.attrs = pld_attributes,
+};
+
+static int tqmx86_detect_device(struct tqmx86_device_data *pld)
+{
+	u8 board_id, rev, i2c_det, i2c_ien;
+	int ret;
+
+
+	board_id = tqmx86_readb(pld, TQMX86_BID);
+	if (board_id == 0 || board_id > ARRAY_SIZE(tq_board_info) - 1)
+		return -ENODEV;
+
+	pld->pld_clock = tq_board_info[board_id].pld_clock;
+
+	rev = tqmx86_readb(pld, TQMX86_BREV);
+	pld->info.board_id = board_id;
+	pld->info.board_rev = rev >> 4;
+	pld->info.pld_rev = rev & 0xf;
+
+	i2c_det = tqmx86_readb(pld, TQMX86_I2C_DET);
+	i2c_ien = tqmx86_readb(pld, TQMX86_I2C_IEN);
+
+	if (i2c_det == 0xa5 && (i2c_ien & 0xf0) == 0xf0)
+		pld->info.i2c_type = I2C_KIND_SOFT;
+	else
+		pld->info.i2c_type = I2C_KIND_HARD;
+
+	dev_info(pld->dev,
+		 "Found TQx86 PLD - Board ID %d, PCB Revision %d, PLD Revision %d\n",
+		 board_id, rev >> 4, rev & 0xf);
+
+	ret = sysfs_create_group(&pld->dev->kobj, &pld_attr_group);
+	if (ret)
+		return ret;
+
+	ret = tqmx86_register_cells(pld);
+	if (ret)
+		sysfs_remove_group(&pld->dev->kobj, &pld_attr_group);
+
+	return ret;
+}
+
+static int tqmx86_probe(struct platform_device *pdev)
+{
+	struct tqmx86_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct tqmx86_device_data *pld;
+	struct resource *ioport;
+
+	pld = devm_kzalloc(dev, sizeof(*pld), GFP_KERNEL);
+	if (!pld)
+		return -ENOMEM;
+
+	ioport = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!ioport)
+		return -EINVAL;
+
+	pld->io_base = devm_ioport_map(dev, ioport->start,
+				       resource_size(ioport));
+	if (!pld->io_base)
+		return -ENOMEM;
+
+	pld->pld_clock = pdata->pld_clock;
+	pld->dev = dev;
+
+	platform_set_drvdata(pdev, pld);
+
+	return tqmx86_detect_device(pld);
+}
+
+static int tqmx86_remove(struct platform_device *pdev)
+{
+	struct tqmx86_device_data *pld = dev_get_drvdata(&pdev->dev);
+
+	sysfs_remove_group(&pld->dev->kobj, &pld_attr_group);
+	mfd_remove_devices(&pdev->dev);
+
+	return 0;
+}
+
+static struct platform_driver tqmx86_driver = {
+	.driver		= {
+		.name	= "tqmx86",
+	},
+	.probe		= tqmx86_probe,
+	.remove		= tqmx86_remove,
+};
+
+static struct dmi_system_id tqmx86_dmi_table[] __initdata = {
+	{
+		.ident = "TQMX86",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TQ-Group"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TQMx"),
+		},
+		.driver_data = (void *)&tqmx86_platform_data_generic,
+		.callback = tqmx86_create_platform_device,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(dmi, tqmx86_dmi_table);
+
+static int __init tqmx86_init(void)
+{
+	if (gpio_irq > 15) {
+		pr_warn("tqmx86: Invalid GPIO IRQ (%d)\n", gpio_irq);
+		gpio_irq = 0;
+	} else if (i2c_irq_ctl[gpio_irq] == 0) {
+		pr_warn("tqmx86: GPIO IRQ %d not supported\n", gpio_irq);
+		gpio_irq = 0;
+	}
+
+	if (!dmi_check_system(tqmx86_dmi_table))
+		return -ENODEV;
+
+	return platform_driver_register(&tqmx86_driver);
+}
+
+static void __exit tqmx86_exit(void)
+{
+	if (tqmx86_pdev)
+		platform_device_unregister(tqmx86_pdev);
+
+	platform_driver_unregister(&tqmx86_driver);
+}
+
+module_init(tqmx86_init);
+module_exit(tqmx86_exit);
+
+MODULE_DESCRIPTION("TQx86 PLD Core Driver");
+MODULE_AUTHOR("Vadim V.Vlasov <vvlasov@dev.rtsoft.ru>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:tqmx86");
-- 
2.19.1

