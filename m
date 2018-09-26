Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A51C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135EF2154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Bp1vshm2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135EF2154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbeI0Efn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:35:43 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:57388 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726049AbeI0Efm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:35:42 -0400
Received: from nis-sj1-27.broadcom.com (nis-sj1-27.lvn.broadcom.net [10.75.144.136])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 3C7C130C013;
        Wed, 26 Sep 2018 15:20:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 3C7C130C013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1538000436;
        bh=C7lYI13DZxtJqIphhxp6WyLtV/c9hUhzMnz5BFFJkZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bp1vshm2WyJl/DZAJzuPmcPLpML2IQ5oKSCPWZROmq66j0X4ObQZMpwtw+kEs5d+a
         K4aBIa0ybMMBAA/946ocLfvrsp/FAzrtuCXMBsw9u6tk23P4rKfVl5UYholGcIca8J
         /Bk8ZPBSUFd2vektRbJ9SsCE6Gc5bDFmDu8IZVgc=
Received: from stbsrv-and-3.and.broadcom.com (stbsrv-and-3.and.broadcom.com [10.28.16.21])
        by nis-sj1-27.broadcom.com (Postfix) with ESMTP id ED378AC0729;
        Wed, 26 Sep 2018 15:20:33 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        James Hogan <jhogan@kernel.org>, Alban Bedel <albeu@free.fr>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 2/5] usb: host: Add OHCI driver for Broadcom STB SoCs
Date:   Wed, 26 Sep 2018 18:20:11 -0400
Message-Id: <1538000414-24873-3-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1538000414-24873-1-git-send-email-alcooperx@gmail.com>
References: <1538000414-24873-1-git-send-email-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver enables USB OHCI on Broadcom ARM and MIPS STB SoCs.
The drivers depend on a matching "brcm,brcmstb-usb-phy"
Broadcom STB USB Phy driver.

The standard platform driver can't be used because of differences
in PHY and Clock handling. The standard PHY handling in hcd.c will
do a phy_exit/phy_init on suspend/resume and this will end up
shutting down the PHYs to the point that the host controller
registers are no longer accessible and will cause suspend to crash.
The clocks specified in device tree for these drivers are not
available in mainline so instead of returning EPROBE_DEFER when
the specified clock is not found and eventually failing probe,
the clock pointer is set to NULL which disables all clock handling.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/usb/host/ohci-brcm.c | 204 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 204 insertions(+)
 create mode 100644 drivers/usb/host/ohci-brcm.c

diff --git a/drivers/usb/host/ohci-brcm.c b/drivers/usb/host/ohci-brcm.c
new file mode 100644
index 000000000000..d4de59a56e2c
--- /dev/null
+++ b/drivers/usb/host/ohci-brcm.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018, Broadcom */
+
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+
+#include "ohci.h"
+
+#define BRCM_DRIVER_DESC "OHCI Broadcom STB driver"
+
+static const char hcd_name[] = "ohci-brcm";
+
+#define hcd_to_ohci_priv(h) ((struct brcm_priv *)hcd_to_ohci(h)->priv)
+
+struct brcm_priv {
+	struct clk *clk;
+	struct phy *phy;
+};
+
+static struct hc_driver __read_mostly ohci_brcm_hc_driver;
+
+static const struct ohci_driver_overrides brcm_overrides __initconst = {
+	.product_desc =	"Broadcom STB OHCI controller",
+	.extra_priv_size = sizeof(struct brcm_priv),
+};
+
+static int ohci_brcm_probe(struct platform_device *dev)
+{
+	struct usb_hcd *hcd;
+	struct brcm_priv *priv;
+	struct resource *res_mem;
+	int irq;
+	int err;
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	err = dma_coerce_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32));
+	if (err)
+		return err;
+
+	irq = platform_get_irq(dev, 0);
+	if (irq < 0) {
+		dev_err(&dev->dev, "no irq provided");
+		return irq;
+	}
+
+	/* initialize hcd */
+	hcd = usb_create_hcd(&ohci_brcm_hc_driver,
+			&dev->dev, dev_name(&dev->dev));
+	if (!hcd)
+		return -ENOMEM;
+
+	platform_set_drvdata(dev, hcd);
+	priv = hcd_to_ohci_priv(hcd);
+
+	priv->clk = devm_clk_get(&dev->dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		dev_err(&dev->dev, "Clock not found in Device Tree\n");
+		priv->clk = NULL;
+	}
+	err = clk_prepare_enable(priv->clk);
+	if (err)
+		goto err_hcd;
+
+	priv->phy = devm_of_phy_get_by_index(&dev->dev, dev->dev.of_node, 0);
+	if (IS_ERR(priv->phy)) {
+		dev_err(&dev->dev, "USB Phy not found.\n");
+		err = PTR_ERR(priv->phy);
+		goto err_clk;
+	}
+	phy_init(priv->phy);
+
+	pm_runtime_set_active(&dev->dev);
+	pm_runtime_enable(&dev->dev);
+
+	res_mem = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	hcd->regs = devm_ioremap_resource(&dev->dev, res_mem);
+	if (IS_ERR(hcd->regs)) {
+		err = PTR_ERR(hcd->regs);
+		goto err_phy;
+	}
+	hcd->rsrc_start = res_mem->start;
+	hcd->rsrc_len = resource_size(res_mem);
+	hcd->skip_phy_initialization = 1;
+	err = usb_add_hcd(hcd, irq, IRQF_SHARED);
+	if (err)
+		goto err_phy;
+
+	device_wakeup_enable(hcd->self.controller);
+
+	platform_set_drvdata(dev, hcd);
+
+	return err;
+
+err_phy:
+	pm_runtime_disable(&dev->dev);
+	phy_exit(priv->phy);
+err_clk:
+	clk_disable_unprepare(priv->clk);
+err_hcd:
+	usb_put_hcd(hcd);
+
+	return err;
+
+}
+
+static int ohci_brcm_remove(struct platform_device *dev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(dev);
+	struct brcm_priv *priv = hcd_to_ohci_priv(hcd);
+
+	pm_runtime_get_sync(&dev->dev);
+	usb_remove_hcd(hcd);
+	phy_exit(priv->phy);
+	clk_disable_unprepare(priv->clk);
+	usb_put_hcd(hcd);
+	pm_runtime_put_sync(&dev->dev);
+	pm_runtime_disable(&dev->dev);
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+
+static int ohci_brcm_suspend(struct device *dev)
+{
+	int ret;
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct brcm_priv *priv = hcd_to_ohci_priv(hcd);
+	bool do_wakeup = device_may_wakeup(dev);
+
+	ret = ohci_suspend(hcd, do_wakeup);
+	clk_disable_unprepare(priv->clk);
+	return ret;
+}
+
+static int ohci_brcm_resume(struct device *dev)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct brcm_priv *priv = hcd_to_ohci_priv(hcd);
+	int err;
+
+	err = clk_prepare_enable(priv->clk);
+	if (err)
+		return err;
+	ohci_resume(hcd, false);
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static SIMPLE_DEV_PM_OPS(ohci_brcm_pm_ops, ohci_brcm_suspend,
+		ohci_brcm_resume);
+
+#ifdef CONFIG_OF
+static const struct of_device_id brcm_ohci_of_match[] = {
+	{ .compatible = "brcm,ohci-brcm-v2", },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, brcm_ohci_of_match);
+#endif /* CONFIG_OF */
+
+static struct platform_driver ohci_brcm_driver = {
+	.probe		= ohci_brcm_probe,
+	.remove		= ohci_brcm_remove,
+	.shutdown	= usb_hcd_platform_shutdown,
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "ohci-brcm",
+		.pm	= &ohci_brcm_pm_ops,
+		.of_match_table = of_match_ptr(brcm_ohci_of_match),
+	}
+};
+
+static int __init ohci_brcm_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	pr_info("%s: " BRCM_DRIVER_DESC "\n", hcd_name);
+
+	ohci_init_driver(&ohci_brcm_hc_driver, &brcm_overrides);
+	return platform_driver_register(&ohci_brcm_driver);
+}
+module_init(ohci_brcm_init);
+
+static void __exit ohci_brcm_exit(void)
+{
+	platform_driver_unregister(&ohci_brcm_driver);
+}
+module_exit(ohci_brcm_exit);
+
+MODULE_ALIAS("platform:ohci-brcm");
+MODULE_DESCRIPTION(BRCM_DRIVER_DESC);
+MODULE_AUTHOR("Al Cooper");
+MODULE_LICENSE("GPL");
-- 
1.9.0.138.g2de3478

