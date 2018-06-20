Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CADC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9E120846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9E120846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754014AbeFTGfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 02:35:03 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:34108 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752924AbeFTGey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 02:34:54 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id w5K6XABK013330;
        Wed, 20 Jun 2018 09:33:10 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 8441)
        id ED3BD62FF7; Wed, 20 Jun 2018 09:33:09 +0300 (IDT)
From:   avifishman70@gmail.com
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc:     avifishman70@gmail.com, tmaimon77@gmail.com, venture@google.com,
        yuenn@google.com, brendanhiggins@google.com,
        mathias.nyman@linux.intel.com, bjorn.andersson@linaro.org,
        jhogan@kernel.org, albeu@free.fr, chunfeng.yun@mediatek.com,
        tony@atomide.com, baolu.lu@linux.intel.com, elder@linaro.org,
        digetx@gmail.com, kstewart@linuxfoundation.org,
        hdegoede@redhat.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, openbmc@lists.ozlabs.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Avi Fishman <AviFishman70@gmail.com>
Subject: [PATCH v7 1/3] USB host: Add USB ehci support for nuvoton npcm7xx platform
Date:   Wed, 20 Jun 2018 09:33:04 +0300
Message-Id: <20180620063306.134820-2-avifishman70@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180620063306.134820-1-avifishman70@gmail.com>
References: <20180620063306.134820-1-avifishman70@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avi Fishman <AviFishman70@gmail.com>

This patch adds support for ehci controller for the Nuvoton
npcm7xx platform.
Most of the code was taken from ehci-spear.c + specific initialization
code

Signed-off-by: Avi Fishman <AviFishman70@gmail.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/Kconfig        |   8 ++
 drivers/usb/host/Makefile       |   1 +
 drivers/usb/host/ehci-npcm7xx.c | 212 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 221 insertions(+)
 create mode 100644 drivers/usb/host/ehci-npcm7xx.c

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 9f0aeb068acb..6d8133800430 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -185,6 +185,14 @@ config USB_EHCI_MXC
 	---help---
 	  Variation of ARC USB block used in some Freescale chips.
 
+config USB_EHCI_HCD_NPCM7XX
+	tristate "Support for Nuvoton NPCM7XX on-chip EHCI USB controller"
+	depends on (USB_EHCI_HCD && ARCH_NPCM7XX) || COMPILE_TEST
+	default y if (USB_EHCI_HCD && ARCH_NPCM7XX)
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

