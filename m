Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15285C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6872154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZdfCepP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC6872154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeI0Efs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:35:48 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:57514 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726049AbeI0Efs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:35:48 -0400
Received: from nis-sj1-27.broadcom.com (nis-sj1-27.lvn.broadcom.net [10.75.144.136])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 3146E30C00D;
        Wed, 26 Sep 2018 15:20:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 3146E30C00D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1538000441;
        bh=gftS1L1b72gHg/yXMZIjzIR1e/KTIimD8dKSviREaIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZdfCepP1u2rCieQHRjiKwHex6qexIDDpAN0yXW6uKXEf4ZnT+maUBJTvllpbRRl9r
         oCxlhXXEjzw6UAHcuzF7NXazG5ZeP3K+lfik1kZznt6KMXfnjo0NDndXT69EjROnBY
         r8TaPGxTEwAYfS+rGdCdVo52E//IPV0JolCaexHw=
Received: from stbsrv-and-3.and.broadcom.com (stbsrv-and-3.and.broadcom.com [10.28.16.21])
        by nis-sj1-27.broadcom.com (Postfix) with ESMTP id E26F7AC0729;
        Wed, 26 Sep 2018 15:20:38 -0700 (PDT)
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
Subject: [PATCH 4/5] usb: host: Add XHCI driver for Broadcom STB SoCs
Date:   Wed, 26 Sep 2018 18:20:13 -0400
Message-Id: <1538000414-24873-5-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1538000414-24873-1-git-send-email-alcooperx@gmail.com>
References: <1538000414-24873-1-git-send-email-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver enables USB XHCI on Broadcom ARM STB SoCs.
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
 drivers/usb/host/xhci-brcm.c | 294 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 294 insertions(+)
 create mode 100644 drivers/usb/host/xhci-brcm.c

diff --git a/drivers/usb/host/xhci-brcm.c b/drivers/usb/host/xhci-brcm.c
new file mode 100644
index 000000000000..1a7578b8ef6a
--- /dev/null
+++ b/drivers/usb/host/xhci-brcm.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018, Broadcom */
+
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/dma-mapping.h>
+#include <linux/clk.h>
+#include <linux/phy/phy.h>
+
+#include "xhci.h"
+
+static struct hc_driver __read_mostly xhci_brcm_hc_driver;
+
+#define BRCM_DRIVER_DESC "xHCI Broadcom STB driver"
+#define BRCM_DRIVER_NAME "xhci-brcm"
+
+#define hcd_to_xhci_priv(h) ((struct brcm_priv *)hcd_to_xhci(h)->priv)
+
+struct brcm_priv {
+	struct phy *phy;
+};
+
+static void xhci_brcm_quirks(struct device *dev, struct xhci_hcd *xhci)
+{
+	/*
+	 * As of now platform drivers don't provide MSI support so we ensure
+	 * here that the generic code does not try to make a pci_dev from our
+	 * dev struct in order to setup MSI
+	 */
+	xhci->quirks |= XHCI_PLAT;
+
+	/*
+	 * The Broadcom XHCI core does not support save/restore state
+	 * so we need to reset on resume.
+	 */
+	xhci->quirks |= XHCI_RESET_ON_RESUME;
+}
+
+/* called during probe() after chip reset completes */
+static int xhci_brcm_setup(struct usb_hcd *hcd)
+{
+	return xhci_gen_setup(hcd, xhci_brcm_quirks);
+}
+
+static const struct xhci_driver_overrides brcm_overrides __initconst = {
+
+	.extra_priv_size = sizeof(struct brcm_priv),
+	.reset = xhci_brcm_setup,
+};
+
+static int xhci_brcm_probe(struct platform_device *pdev)
+{
+	const struct hc_driver	*driver;
+	struct brcm_priv	*priv;
+	struct xhci_hcd		*xhci;
+	struct resource         *res;
+	struct usb_hcd		*hcd;
+	int			ret;
+	int			irq;
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	driver = &xhci_brcm_hc_driver;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return -ENODEV;
+
+	/* Try to set 64-bit DMA first */
+	if (WARN_ON(!pdev->dev.dma_mask))
+		/* Platform did not initialize dma_mask */
+		ret = dma_coerce_mask_and_coherent(&pdev->dev,
+						   DMA_BIT_MASK(64));
+	else
+		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+
+	/* If seting 64-bit DMA mask fails, fall back to 32-bit DMA mask */
+	if (ret) {
+		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+		if (ret)
+			return ret;
+	}
+
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
+
+	hcd = __usb_create_hcd(driver, &pdev->dev, &pdev->dev,
+			       dev_name(&pdev->dev), NULL);
+	if (!hcd) {
+		return -ENOMEM;
+		goto disable_runtime;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(hcd->regs)) {
+		ret = PTR_ERR(hcd->regs);
+		goto put_hcd;
+	}
+
+	hcd->rsrc_start = res->start;
+	hcd->rsrc_len = resource_size(res);
+
+	/*
+	 * Not all platforms have a clk so it is not an error if the
+	 * clock does not exists.
+	 */
+	xhci = hcd_to_xhci(hcd);
+	xhci->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(xhci->clk)) {
+		dev_err(&pdev->dev, "Clock not found in Device Tree\n");
+		xhci->clk = NULL;
+	}
+	device_wakeup_enable(hcd->self.controller);
+
+	xhci->main_hcd = hcd;
+	xhci->shared_hcd = __usb_create_hcd(driver, &pdev->dev, &pdev->dev,
+					    dev_name(&pdev->dev), hcd);
+	if (!xhci->shared_hcd) {
+		ret = -ENOMEM;
+		goto disable_clk;
+	}
+
+	if (device_property_read_bool(&pdev->dev, "usb3-lpm-capable"))
+		xhci->quirks |= XHCI_LPM_SUPPORT;
+
+	priv = hcd_to_xhci_priv(hcd);
+	priv->phy = devm_of_phy_get_by_index(&pdev->dev, pdev->dev.of_node, 0);
+	if (IS_ERR(priv->phy)) {
+		dev_err(&pdev->dev, "USB Phy not found.\n");
+		ret = PTR_ERR(priv->phy);
+		goto put_usb3_hcd;
+	}
+	ret = phy_init(priv->phy);
+	if (ret)
+		goto put_usb3_hcd;
+
+	hcd->skip_phy_initialization = 1;
+	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
+	if (ret)
+		goto disable_usb_phy;
+
+	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
+		xhci->shared_hcd->can_do_streams = 1;
+
+	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
+	if (ret)
+		goto dealloc_usb2_hcd;
+
+	device_enable_async_suspend(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+
+	/*
+	 * Prevent runtime pm from being on as default, users should enable
+	 * runtime pm using power/control in sysfs.
+	 */
+	pm_runtime_forbid(&pdev->dev);
+
+	return 0;
+
+dealloc_usb2_hcd:
+	usb_remove_hcd(hcd);
+
+disable_usb_phy:
+	phy_exit(priv->phy);
+
+put_usb3_hcd:
+	usb_put_hcd(xhci->shared_hcd);
+
+disable_clk:
+	if (!IS_ERR(xhci->clk))
+		clk_disable_unprepare(xhci->clk);
+
+put_hcd:
+	usb_put_hcd(hcd);
+
+disable_runtime:
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	return ret;
+}
+
+static int xhci_brcm_remove(struct platform_device *dev)
+{
+	struct usb_hcd	*hcd = platform_get_drvdata(dev);
+	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
+	struct brcm_priv *priv = hcd_to_xhci_priv(hcd);
+
+	xhci->xhc_state |= XHCI_STATE_REMOVING;
+
+	usb_remove_hcd(xhci->shared_hcd);
+	usb_remove_hcd(hcd);
+	usb_put_hcd(xhci->shared_hcd);
+	phy_exit(priv->phy);
+	clk_disable_unprepare(xhci->clk);
+	usb_put_hcd(hcd);
+
+	pm_runtime_set_suspended(&dev->dev);
+	pm_runtime_disable(&dev->dev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int xhci_brcm_suspend(struct device *dev)
+{
+	int ret;
+	struct usb_hcd	*hcd = dev_get_drvdata(dev);
+	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
+
+	ret = xhci_suspend(xhci, device_may_wakeup(dev));
+	clk_disable_unprepare(xhci->clk);
+	return ret;
+}
+
+static int xhci_brcm_resume(struct device *dev)
+{
+	struct usb_hcd	*hcd = dev_get_drvdata(dev);
+	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
+	int err;
+
+	err = clk_prepare_enable(xhci->clk);
+	if (err)
+		return err;
+	return xhci_resume(xhci, 0);
+}
+
+static int xhci_brcm_runtime_suspend(struct device *dev)
+{
+	struct usb_hcd	*hcd = dev_get_drvdata(dev);
+	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
+
+	return xhci_suspend(xhci, true);
+}
+
+static int xhci_brcm_runtime_resume(struct device *dev)
+{
+	struct usb_hcd	*hcd = dev_get_drvdata(dev);
+	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
+
+	return xhci_resume(xhci, 0);
+}
+
+#endif /* CONFIG_PM_SLEEP */
+
+
+static const struct dev_pm_ops xhci_brcm_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(xhci_brcm_suspend, xhci_brcm_resume)
+
+	SET_RUNTIME_PM_OPS(xhci_brcm_runtime_suspend,
+			   xhci_brcm_runtime_resume,
+			   NULL)
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id brcm_xhci_of_match[] = {
+	{ .compatible = "brcm,xhci-brcm-v2" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, brcm_xhci_of_match);
+#endif
+
+static struct platform_driver xhci_brcm_driver = {
+	.probe	= xhci_brcm_probe,
+	.remove	= xhci_brcm_remove,
+	.driver	= {
+		.name = BRCM_DRIVER_NAME,
+		.pm = &xhci_brcm_pm_ops,
+		.of_match_table = of_match_ptr(brcm_xhci_of_match),
+	},
+};
+
+static int __init xhci_brcm_init(void)
+{
+	pr_info("%s: " BRCM_DRIVER_DESC "\n", BRCM_DRIVER_NAME);
+	xhci_init_driver(&xhci_brcm_hc_driver, &brcm_overrides);
+	return platform_driver_register(&xhci_brcm_driver);
+}
+module_init(xhci_brcm_init);
+
+static void __exit xhci_brcm_exit(void)
+{
+	platform_driver_unregister(&xhci_brcm_driver);
+}
+module_exit(xhci_brcm_exit);
+
+MODULE_ALIAS("platform:xhci-brcm");
+MODULE_DESCRIPTION(BRCM_DRIVER_DESC);
+MODULE_AUTHOR("Al Cooper");
+MODULE_LICENSE("GPL");
-- 
1.9.0.138.g2de3478

