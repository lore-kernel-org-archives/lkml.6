Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755925AbeEaRlr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 13:41:47 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:33219 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755807AbeEaRlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:41:42 -0400
From: avifishman70@gmail.com
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, venture@google.com,
        yuenn@google.com, brendanhiggins@google.com,
        mathias.nyman@linux.intel.com, bjorn.andersson@linaro.org,
        jhogan@kernel.org, albeu@free.fr, chunfeng.yun@mediatek.com,
        tony@atomide.com, baolu.lu@linux.intel.com, elder@linaro.org,
        digetx@gmail.com, kstewart@linuxfoundation.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        openbmc@lists.ozlabs.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Avi Fishman <AviFishman70@gmail.com>
Subject: [PATCH v3 1/3] USB host: Add USB ehci support for nuvoton npcm7xx platform
Date: Thu, 31 May 2018 20:40:28 +0300
Message-Id: <1527788430-12494-2-git-send-email-avifishman70@gmail.com>
X-Mailer: git-send-email 1.8.3.4
In-Reply-To: <1527788430-12494-1-git-send-email-avifishman70@gmail.com>
References: <1527788430-12494-1-git-send-email-avifishman70@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avi Fishman <AviFishman70@gmail.com>

This patch adds support for ehci controller for the Nuvoton
npcm7xx platform.
Most of the code was taken from ehci-spear.c + specific initialization
code

Signed-off-by: Avi Fishman <AviFishman70@gmail.com>
---
 drivers/usb/host/Kconfig        |   8 ++
 drivers/usb/host/Makefile       |   1 +
 drivers/usb/host/ehci-npcm7xx.c | 212 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 221 insertions(+)
 create mode 100644 drivers/usb/host/ehci-npcm7xx.c

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 9f0aeb068acb..e3100b249f0f 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -185,6 +185,14 @@ config USB_EHCI_MXC
 	---help---
 	  Variation of ARC USB block used in some Freescale chips.
 
+config USB_EHCI_HCD_NPCM7XX
+	tristate "Support for Nuvoton NPCM7XX on-chip EHCI USB controller"
+	depends on (USB_EHCI_HCD && ARCH_NPCM7XX) || COMPILE_TEST
+	default y
+	help
+	  Enables support for the on-chip EHCI controller on
+	  Nuvoton NPCM7XX chips.
+
 config USB_EHCI_HCD_OMAP
 	tristate "EHCI support for OMAP3 and later chips"
 	depends on ARCH_OMAP
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 8a8cffe0b445..fcf5dab5efa4 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_USB_EHCI_HCD)	+= ehci-hcd.o
 obj-$(CONFIG_USB_EHCI_PCI)	+= ehci-pci.o
 obj-$(CONFIG_USB_EHCI_HCD_PLATFORM)	+= ehci-platform.o
 obj-$(CONFIG_USB_EHCI_MXC)	+= ehci-mxc.o
+obj-$(CONFIG_USB_EHCI_HCD_NPCM7XX)	+= ehci-npcm7xx.o
 obj-$(CONFIG_USB_EHCI_HCD_OMAP)	+= ehci-omap.o
 obj-$(CONFIG_USB_EHCI_HCD_ORION)	+= ehci-orion.o
 obj-$(CONFIG_USB_EHCI_HCD_SPEAR)	+= ehci-spear.o
diff --git a/drivers/usb/host/ehci-npcm7xx.c b/drivers/usb/host/ehci-npcm7xx.c
new file mode 100644
index 000000000000..c80a8792d3b0
--- /dev/null
+++ b/drivers/usb/host/ehci-npcm7xx.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Nuvoton NPCM7xx driver for EHCI HCD
+ *
+ * Copyright (C) 2018 Nuvoton Technologies,
+ * Avi Fishman <avi.fishman@nuvoton.com> <avifishman70@gmail.com>
+ * Tomer Maimon <tomer.maimon@nuvoton.com> <tmaimon77@gmail.com>
+ *
+ * Based on various ehci-spear.c driver
+ */
+
+
+#include <linux/dma-mapping.h>
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+
+#include "ehci.h"
+
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+
+#define DRIVER_DESC "EHCI npcm7xx driver"
+
+static const char hcd_name[] = "npcm7xx-ehci";
+
+#define  USB2PHYCTL_OFFSET 0x144
+
+#define  IPSRST2_OFFSET 0x24
+#define  IPSRST3_OFFSET 0x34
+
+
+static struct hc_driver __read_mostly ehci_npcm7xx_hc_driver;
+
+#ifdef CONFIG_PM_SLEEP
+static int ehci_npcm7xx_drv_suspend(struct device *dev)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	bool do_wakeup = device_may_wakeup(dev);
+
+	return ehci_suspend(hcd, do_wakeup);
+}
+
+static int ehci_npcm7xx_drv_resume(struct device *dev)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+
+	ehci_resume(hcd, false);
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static SIMPLE_DEV_PM_OPS(ehci_npcm7xx_pm_ops, ehci_npcm7xx_drv_suspend,
+		ehci_npcm7xx_drv_resume);
+
+static int npcm7xx_ehci_hcd_drv_probe(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd;
+	struct resource *res;
+	struct regmap *gcr_regmap;
+	struct regmap *rst_regmap;
+	const struct hc_driver *driver = &ehci_npcm7xx_hc_driver;
+	int irq;
+	int retval;
+
+	dev_dbg(&pdev->dev,	"initializing npcm7xx ehci USB Controller\n");
+
+	gcr_regmap = syscon_regmap_lookup_by_compatible("nuvoton,npcm750-gcr");
+	if (IS_ERR(gcr_regmap)) {
+		dev_err(&pdev->dev, "%s: failed to find nuvoton,npcm750-gcr\n",
+			__func__);
+		return IS_ERR(gcr_regmap);
+	}
+
+	rst_regmap = syscon_regmap_lookup_by_compatible("nuvoton,npcm750-rst");
+	if (IS_ERR(rst_regmap)) {
+		dev_err(&pdev->dev, "%s: failed to find nuvoton,npcm750-rst\n",
+			__func__);
+		return IS_ERR(rst_regmap);
+	}
+
+	/********* phy init  ******/
+	// reset usb host
+	regmap_update_bits(rst_regmap, IPSRST2_OFFSET,
+			(0x1 << 26), (0x1 << 26));
+	regmap_update_bits(rst_regmap, IPSRST3_OFFSET,
+			(0x1 << 25), (0x1 << 25));
+	regmap_update_bits(gcr_regmap, USB2PHYCTL_OFFSET,
+			(0x1 << 28), 0);
+
+	udelay(1);
+
+	// enable phy
+	regmap_update_bits(rst_regmap, IPSRST3_OFFSET,
+			(0x1 << 25), 0);
+
+	udelay(50); // enable phy
+
+	regmap_update_bits(gcr_regmap, USB2PHYCTL_OFFSET,
+			(0x1 << 28), (0x1 << 28));
+
+	// enable host
+	regmap_update_bits(rst_regmap, IPSRST2_OFFSET,
+			(0x1 << 26), 0);
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		retval = irq;
+		goto fail;
+	}
+
+	/*
+	 * Right now device-tree probed devices don't get dma_mask set.
+	 * Since shared usb code relies on it, set it here for now.
+	 * Once we have dma capability bindings this can go away.
+	 */
+	retval = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (retval)
+		goto fail;
+
+	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
+	if (!hcd) {
+		retval = -ENOMEM;
+		goto fail;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(hcd->regs)) {
+		retval = PTR_ERR(hcd->regs);
+		goto err_put_hcd;
+	}
+	hcd->rsrc_start = res->start;
+	hcd->rsrc_len = resource_size(res);
+
+	/* registers start at offset 0x0 */
+	hcd_to_ehci(hcd)->caps = hcd->regs;
+
+	retval = usb_add_hcd(hcd, irq, IRQF_SHARED);
+	if (retval)
+		goto err_put_hcd;
+
+	device_wakeup_enable(hcd->self.controller);
+	return retval;
+
+err_put_hcd:
+	usb_put_hcd(hcd);
+fail:
+	dev_err(&pdev->dev, "init fail, %d\n", retval);
+
+	return retval;
+}
+
+static int npcm7xx_ehci_hcd_drv_remove(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+
+	usb_remove_hcd(hcd);
+
+	usb_put_hcd(hcd);
+
+	return 0;
+}
+
+static const struct of_device_id npcm7xx_ehci_id_table[] = {
+	{ .compatible = "nuvoton,npcm750-ehci" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, npcm7xx_ehci_id_table);
+
+static struct platform_driver npcm7xx_ehci_hcd_driver = {
+	.probe		= npcm7xx_ehci_hcd_drv_probe,
+	.remove		= npcm7xx_ehci_hcd_drv_remove,
+	.shutdown	= usb_hcd_platform_shutdown,
+	.driver		= {
+		.name = "npcm7xx-ehci",
+		.bus = &platform_bus_type,
+		.pm = &ehci_npcm7xx_pm_ops,
+		.of_match_table = npcm7xx_ehci_id_table,
+	}
+};
+
+static int __init ehci_npcm7xx_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
+
+	ehci_init_driver(&ehci_npcm7xx_hc_driver, NULL);
+	return platform_driver_register(&npcm7xx_ehci_hcd_driver);
+}
+module_init(ehci_npcm7xx_init);
+
+static void __exit ehci_npcm7xx_cleanup(void)
+{
+	platform_driver_unregister(&npcm7xx_ehci_hcd_driver);
+}
+module_exit(ehci_npcm7xx_cleanup);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_ALIAS("platform:npcm7xx-ehci");
+MODULE_AUTHOR("Avi Fishman");
+MODULE_LICENSE("GPL v2");
-- 
2.14.1
