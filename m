Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0344C169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 02:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFB7218D9
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 02:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yDcKMLEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfBGCh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 21:37:57 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:41820 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfBGCh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 21:37:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version
        :Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=7ZnH3ZnGJSSCKAPsfsWHpW9HtM7OrWF6Te+lE/Bvl4A=; b=yDcKMLEeMen2FxpoLQHRTEwZsy
        Hkx0dS1JI25lxGHroFk2AO4JoY3AxU/PprysLgW1t+o9wVMtY6/dZz5gPfBmpin53L7hphPinfcSA
        J1Dh7npQflN3XNOd+pnCY/Xzz8Ac/zgZscF37wBAio6/8iCCwFW05XYMh1o2YoH+IuKM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1grZZJ-0003SW-Dk; Thu, 07 Feb 2019 03:37:37 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Emeric Dupont <emeric.dupont@zii.aero>,
        Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v5] mfd: tqmx86: IO controller with i2c, wachdog and gpio
Date:   Thu,  7 Feb 2019 03:37:31 +0100
Message-Id: <20190207023731.13259-1-andrew@lunn.ch>
X-Mailer: git-send-email 2.11.0
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

v3

Fix indentation of help
Fix SPDX to match MODULE_LICENSE
Remove warranty text
Add my Copyright
Sort include files
Add _REG_ to register defines
Add #defines for all resources
Replace magic numbers with #defines
Rename pld_clock to pld_clock_rate
Remove wrapper around ioread8()/iowrite8()
Scatter const keyword in a few places
Remove enum for calls
Implement lookup for board in tq_board_if
Rename ioeic to io_ext_int_val to make is more readable
Handle optional calls in a different way
Better group code and structures
Kill all the sysfs attributes
Use devm_mfd_add_devices()
Don't exist silently for unknown board ID

Not addressed, waiting for answers:
MODULE_PARM for GPIO interrupts
Not using regmap, intel IO not supported by regmap
Setting GPIO irq on resource structure
Global tqmx86_pdev
Jumping through hoops

v4

Remove -- to avoid broken mailer

v5

Remove device data since it is only used in the probe function
Remove platform data, since it only contains well know values
Move GPIO IRQ resource first and comment about this assumption
Fixup platform data naming
Use true for ignore_resource_conflicts
Use ARRAY_SIZE for num_resources
Replace tq_board_info with two functions using switch
Error out for invalid GPIO IRQ configuration
Error out if GPIO IRQ cannot be configured in the hardware
Split registering cells into two calls
Validate GPIO IRQ using a switch statement, and derive the HW configuration
---
 drivers/mfd/Kconfig  |   8 ++
 drivers/mfd/Makefile |   1 +
 drivers/mfd/tqmx86.c | 289 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 298 insertions(+)
 create mode 100644 drivers/mfd/tqmx86.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index f461460a2aeb..226f7eeb2093 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1677,6 +1677,14 @@ config MFD_TC6393XB
 	help
 	  Support for Toshiba Mobile IO Controller TC6393XB
 
+config MFD_TQMX86
+	tristate "TQ-Systems IO controller TQMX86"
+	select MFD_CORE
+	help
+	  Say yes here to enable support for various functions of the
+	  TQ-Systems IO controller and watchdog device, found on their
+	  ComExpress CPU modules.
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
index 000000000000..9028e026f9a6
--- /dev/null
+++ b/drivers/mfd/tqmx86.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * TQ-Systems PLD MFD core driver, based on vendor driver by
+ * Vadim V.Vlasov <vvlasov@dev.rtsoft.ru>
+ *
+ * Copyright (c) 2015 TQ-Systems GmbH
+ * Copyright (c) 2019 Andrew Lunn <andrew@lunn.ch>
+ */
+
+#include <linux/delay.h>
+#include <linux/dmi.h>
+#include <linux/i2c.h>
+#include <linux/io.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/platform_data/i2c-ocores.h>
+#include <linux/platform_device.h>
+
+#define TQMX86_IOBASE	0x160
+#define TQMX86_IOSIZE	0x3f
+#define TQMX86_IOBASE_I2C	0x1a0
+#define TQMX86_IOSIZE_I2C	0xa
+#define TQMX86_IOBASE_WATCHDOG	0x18b
+#define TQMX86_IOSIZE_WATCHDOG	0x2
+#define TQMX86_IOBASE_GPIO	0x18d
+#define TQMX86_IOSIZE_GPIO	0x4
+
+#define TQMX86_REG_BOARD_ID	0x20
+#define TQMX86_REG_BOARD_ID_E38M	1
+#define TQMX86_REG_BOARD_ID_50UC	2
+#define TQMX86_REG_BOARD_ID_E38C	3
+#define TQMX86_REG_BOARD_ID_60EB	4
+#define TQMX86_REG_BOARD_ID_E39M	5
+#define TQMX86_REG_BOARD_ID_E39C	6
+#define TQMX86_REG_BOARD_ID_E39x	7
+#define TQMX86_REG_BOARD_ID_70EB	8
+#define TQMX86_REG_BOARD_ID_80UC	9
+#define TQMX86_REG_BOARD_ID_90UC	10
+#define TQMX86_REG_BOARD_REV	0x21
+#define TQMX86_REG_IO_EXT_INT	0x26
+#define TQMX86_REG_IO_EXT_INT_NONE		0
+#define TQMX86_REG_IO_EXT_INT_7			1
+#define TQMX86_REG_IO_EXT_INT_9			2
+#define TQMX86_REG_IO_EXT_INT_12		3
+#define TQMX86_REG_IO_EXT_INT_MASK		0x3
+#define TQMX86_REG_IO_EXT_INT_GPIO_SHIFT	4
+
+#define TQMX86_REG_I2C_DETECT	0x47
+#define TQMX86_REG_I2C_DETECT_SOFT		0xa5
+#define TQMX86_REG_I2C_INT_EN	0x49
+
+static uint gpio_irq;
+module_param(gpio_irq, uint, 0);
+MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (7, 9, 12)");
+
+static u8 gpio_irq_cfg;
+
+static const struct resource tqmx_i2c_soft_resources[] = {
+	DEFINE_RES_IO(TQMX86_IOBASE_I2C, TQMX86_IOSIZE_I2C),
+};
+
+static const struct resource tqmx_watchdog_resources[] = {
+	DEFINE_RES_IO(TQMX86_IOBASE_WATCHDOG, TQMX86_IOSIZE_WATCHDOG),
+};
+
+/*
+ * The IRQ resource must be first, since it is updated with the
+ * configured IRQ in the probe function.
+ */
+static struct resource tqmx_gpio_resources[] = {
+	DEFINE_RES_IRQ(0),
+	DEFINE_RES_IO(TQMX86_IOBASE_GPIO, TQMX86_IOSIZE_GPIO),
+};
+
+static struct i2c_board_info tqmx86_i2c_devices[] = {
+	{
+		/* 4K EEPROM at 0x50 */
+		I2C_BOARD_INFO("24c32", 0x50),
+	},
+};
+
+static struct ocores_i2c_platform_data ocores_platfom_data = {
+	.num_devices = ARRAY_SIZE(tqmx86_i2c_devices),
+	.devices = tqmx86_i2c_devices,
+};
+
+static const struct mfd_cell tqmx86_i2c_soft_dev[] = {
+	{
+		.name = "ocores-i2c",
+		.platform_data = &ocores_platfom_data,
+		.pdata_size = sizeof(ocores_platfom_data),
+		.resources = tqmx_i2c_soft_resources,
+		.num_resources = ARRAY_SIZE(tqmx_i2c_soft_resources),
+	},
+};
+
+static const struct mfd_cell tqmx86_devs[] = {
+	{
+		.name = "tqmx86-wdt",
+		.resources = tqmx_watchdog_resources,
+		.num_resources = ARRAY_SIZE(tqmx_watchdog_resources),
+		.ignore_resource_conflicts = true,
+	},
+	{
+		.name = "tqmx86-gpio",
+		.resources = tqmx_gpio_resources,
+		.num_resources = ARRAY_SIZE(tqmx_gpio_resources),
+		.ignore_resource_conflicts = true,
+	},
+};
+
+static const char *tqmx86_board_id_to_name(u8 board_id)
+{
+	switch (board_id) {
+	case TQMX86_REG_BOARD_ID_E38M:
+		return "TQMxE38M";
+	case TQMX86_REG_BOARD_ID_50UC:
+		return "TQMx50UC";
+	case TQMX86_REG_BOARD_ID_E38C:
+		return "TQMxE38C";
+	case TQMX86_REG_BOARD_ID_60EB:
+		return "TQMx60EB";
+	case TQMX86_REG_BOARD_ID_E39M:
+		return "TQMxE39M";
+	case TQMX86_REG_BOARD_ID_E39C:
+		return "TQMxE39C";
+	case TQMX86_REG_BOARD_ID_E39x:
+		return "TQMxE39x";
+	case TQMX86_REG_BOARD_ID_70EB:
+		return "TQMx70EB";
+	case TQMX86_REG_BOARD_ID_80UC:
+		return "TQMx80UC";
+	case TQMX86_REG_BOARD_ID_90UC:
+		return "TQMx90UC";
+	default:
+		return "Unknown";
+	}
+}
+
+static int tqmx86_board_id_to_clk_rate(u8 board_id)
+{
+	switch (board_id) {
+	case TQMX86_REG_BOARD_ID_E38M:
+		return 33000;
+	case TQMX86_REG_BOARD_ID_50UC:
+		return 24000;
+	case TQMX86_REG_BOARD_ID_E38C:
+		return 33000;
+	case TQMX86_REG_BOARD_ID_60EB:
+		return 24000;
+	case TQMX86_REG_BOARD_ID_E39M:
+		return 25000;
+	case TQMX86_REG_BOARD_ID_E39C:
+		return 25000;
+	case TQMX86_REG_BOARD_ID_E39x:
+		return 25000;
+	case TQMX86_REG_BOARD_ID_70EB:
+		return 24000;
+	case TQMX86_REG_BOARD_ID_80UC:
+		return 24000;
+	case TQMX86_REG_BOARD_ID_90UC:
+		return 24000;
+	default:
+		return 0;
+	}
+}
+
+static int tqmx86_probe(struct platform_device *pdev)
+{
+	u8 board_id, rev, i2c_det, i2c_ien, io_ext_int_val;
+	struct device *dev = &pdev->dev;
+	const char *board_name;
+	void __iomem *io_base;
+	int err;
+
+	io_base = devm_ioport_map(dev, TQMX86_IOBASE, TQMX86_IOSIZE);
+	if (!io_base)
+		return -ENOMEM;
+
+	board_id = ioread8(io_base + TQMX86_REG_BOARD_ID);
+	board_name = tqmx86_board_id_to_name(board_id);
+	rev = ioread8(io_base + TQMX86_REG_BOARD_REV);
+
+	dev_info(dev,
+		 "Found %s - Board ID %d, PCB Revision %d, PLD Revision %d\n",
+		 board_name, board_id, rev >> 4, rev & 0xf);
+
+	i2c_det = ioread8(io_base + TQMX86_REG_I2C_DETECT);
+	i2c_ien = ioread8(io_base + TQMX86_REG_I2C_INT_EN);
+
+	if (gpio_irq_cfg) {
+		io_ext_int_val = gpio_irq_cfg <<
+			TQMX86_REG_IO_EXT_INT_GPIO_SHIFT;
+		iowrite8(io_ext_int_val, io_base + TQMX86_REG_IO_EXT_INT);
+		if (ioread8(io_base + TQMX86_REG_IO_EXT_INT) !=
+		    io_ext_int_val) {
+			dev_warn(dev, "GPIO interrupts not supported.\n");
+			return -EINVAL;
+		}
+
+		/* Assumes the IRQ resource is first. */
+		tqmx_gpio_resources[0].start = gpio_irq;
+	}
+
+	ocores_platfom_data.clock_khz = tqmx86_board_id_to_clk_rate(board_id);
+
+	if (i2c_det == TQMX86_REG_I2C_DETECT_SOFT) {
+		err = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
+					   tqmx86_i2c_soft_dev,
+					   ARRAY_SIZE(tqmx86_i2c_soft_dev),
+					   NULL, 0, NULL);
+		if (err)
+			return err;
+	}
+
+	return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
+				    tqmx86_devs,
+				    ARRAY_SIZE(tqmx86_devs),
+				    NULL, 0, NULL);
+}
+
+static int tqmx86_create_platform_device(const struct dmi_system_id *id)
+{
+	struct platform_device *pdev;
+	int err;
+
+	pdev = platform_device_alloc("tqmx86", -1);
+	if (!pdev)
+		return -ENOMEM;
+
+	err = platform_device_add(pdev);
+	if (err)
+		platform_device_put(pdev);
+
+	return err;
+}
+
+static const struct dmi_system_id tqmx86_dmi_table[] __initconst = {
+	{
+		.ident = "TQMX86",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TQ-Group"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TQMx"),
+		},
+		.callback = tqmx86_create_platform_device,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(dmi, tqmx86_dmi_table);
+
+static struct platform_driver tqmx86_driver = {
+	.driver		= {
+		.name	= "tqmx86",
+	},
+	.probe		= tqmx86_probe,
+};
+
+static int __init tqmx86_init(void)
+{
+	switch (gpio_irq) {
+	case 0:
+		gpio_irq_cfg = TQMX86_REG_IO_EXT_INT_NONE;
+		break;
+	case 7:
+		gpio_irq_cfg = TQMX86_REG_IO_EXT_INT_7;
+		break;
+	case 9:
+		gpio_irq_cfg = TQMX86_REG_IO_EXT_INT_9;
+		break;
+	case 12:
+		gpio_irq_cfg = TQMX86_REG_IO_EXT_INT_12;
+		break;
+	default:
+		pr_err("tqmx86: Invalid GPIO IRQ (%d)\n", gpio_irq);
+		return -EINVAL;
+	}
+
+	if (!dmi_check_system(tqmx86_dmi_table))
+		return -ENODEV;
+
+	return platform_driver_register(&tqmx86_driver);
+}
+
+module_init(tqmx86_init);
+
+MODULE_DESCRIPTION("TQx86 PLD Core Driver");
+MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:tqmx86");
-- 
2.20.1

