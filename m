Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDACC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711542643B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711542643B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753470AbeF0JWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:22:18 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:35320 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753319AbeF0JV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:21:59 -0400
X-UUID: 747f2962b28b460bb1873de5c46714d4-20180627
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 158322434; Wed, 27 Jun 2018 17:21:55 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 27 Jun 2018 17:21:53 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 27 Jun 2018 17:21:52 +0800
From:   <honghui.zhang@mediatek.com>
To:     <lorenzo.pieralisi@arm.com>, <marc.zyngier@arm.com>,
        <bhelgaas@google.com>, <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <ryder.lee@mediatek.com>
CC:     <honghui.zhang@mediatek.com>, <hongkun.cao@mediatek.com>,
        <youlin.pei@mediatek.com>, <yong.wu@mediatek.com>,
        <yt.shen@mediatek.com>, <sean.wang@mediatek.com>
Subject: [PATCH 4/4] PCI: mediatek: Add loadable kernel module support
Date:   Wed, 27 Jun 2018 17:21:38 +0800
Message-ID: <1530091298-28120-5-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1530091298-28120-1-git-send-email-honghui.zhang@mediatek.com>
References: <1530091298-28120-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

Implement remove callback function for Mediatek PCIe driver to add
loadable kernel module support.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/controller/Kconfig         |  2 +-
 drivers/pci/controller/pcie-mediatek.c | 63 +++++++++++++++++++++++++++++++---
 2 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 18fa09b..6c61ac65 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -234,7 +234,7 @@ config PCIE_ROCKCHIP_EP
 	  available to support GEN2 with 4 slots.
 
 config PCIE_MEDIATEK
-	bool "MediaTek PCIe controller"
+	tristate "MediaTek PCIe controller"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index cac01ab..5830cea 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -15,6 +15,7 @@
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/msi.h>
+#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
@@ -184,6 +185,7 @@ struct mtk_pcie_port {
 	struct phy *phy;
 	u32 lane;
 	u32 slot;
+	int irq;
 	struct irq_domain *irq_domain;
 	struct irq_domain *inner_domain;
 	struct irq_domain *msi_domain;
@@ -536,6 +538,30 @@ static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
 	writel(val, port->base + PCIE_INT_MASK);
 }
 
+static void mtk_pcie_irq_teardown(struct mtk_pcie *pcie)
+{
+	struct mtk_pcie_port *port, *tmp;
+
+	if (list_empty(&pcie->ports))
+		return;
+
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+		irq_set_chained_handler_and_data(port->irq, NULL, NULL);
+
+		if (port->irq_domain)
+			irq_domain_remove(port->irq_domain);
+
+		if (IS_ENABLED(CONFIG_PCI_MSI)) {
+			if (port->msi_domain)
+				irq_domain_remove(port->msi_domain);
+			if (port->inner_domain)
+				irq_domain_remove(port->inner_domain);
+		}
+
+		irq_dispose_mapping(port->irq);
+	}
+}
+
 static int mtk_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
 			     irq_hw_number_t hwirq)
 {
@@ -626,7 +652,7 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
 	struct mtk_pcie *pcie = port->pcie;
 	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
-	int err, irq;
+	int err;
 
 	err = mtk_pcie_init_irq_domain(port, node);
 	if (err) {
@@ -634,8 +660,9 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
 		return err;
 	}
 
-	irq = platform_get_irq(pdev, port->slot);
-	irq_set_chained_handler_and_data(irq, mtk_pcie_intr_handler, port);
+	port->irq = platform_get_irq(pdev, port->slot);
+	irq_set_chained_handler_and_data(port->irq,
+					 mtk_pcie_intr_handler, port);
 
 	return 0;
 }
@@ -1197,6 +1224,32 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
+static void mtk_pcie_free_resources(struct mtk_pcie *pcie)
+{
+	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
+	struct list_head *windows = &host->windows;
+
+	pci_unmap_iospace(&pcie->pio);
+	pci_free_resource_list(windows);
+}
+
+static int mtk_pcie_remove(struct platform_device *pdev)
+{
+	struct mtk_pcie *pcie = platform_get_drvdata(pdev);
+	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
+
+	pci_stop_root_bus(host->bus);
+	pci_remove_root_bus(host->bus);
+	mtk_pcie_free_resources(pcie);
+
+	mtk_pcie_irq_teardown(pcie);
+
+	if (!list_empty(&pcie->ports))
+		mtk_pcie_put_resources(pcie);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int mtk_pcie_suspend_noirq(struct device *dev)
 {
@@ -1290,6 +1343,7 @@ static const struct of_device_id mtk_pcie_ids[] = {
 
 static struct platform_driver mtk_pcie_driver = {
 	.probe = mtk_pcie_probe,
+	.remove = mtk_pcie_remove,
 	.driver = {
 		.name = "mtk-pcie",
 		.of_match_table = mtk_pcie_ids,
@@ -1297,4 +1351,5 @@ static struct platform_driver mtk_pcie_driver = {
 		.pm = &mtk_pcie_pm_ops,
 	},
 };
-builtin_platform_driver(mtk_pcie_driver);
+module_platform_driver(mtk_pcie_driver);
+MODULE_LICENSE("GPL v2");
-- 
2.6.4

