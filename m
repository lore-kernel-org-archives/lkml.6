Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974E8C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 03:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA11255A6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 03:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA11255A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933632AbeGBDui (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 23:50:38 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:50017 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S933458AbeGBDuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 23:50:03 -0400
X-UUID: 6c269c091d494081baee6b23d8e593d0-20180702
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 832182728; Mon, 02 Jul 2018 11:50:01 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 2 Jul 2018 11:49:59 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 2 Jul 2018 11:49:58 +0800
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
Subject: [PATCH v2 4/4] PCI: mediatek: Add loadable kernel module support
Date:   Mon, 2 Jul 2018 11:49:44 +0800
Message-ID: <1530503384-1218-5-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1530503384-1218-1-git-send-email-honghui.zhang@mediatek.com>
References: <1530503384-1218-1-git-send-email-honghui.zhang@mediatek.com>
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
---
 drivers/pci/controller/Kconfig         |  2 +-
 drivers/pci/controller/pcie-mediatek.c | 60 +++++++++++++++++++++++++++++++---
 2 files changed, 57 insertions(+), 5 deletions(-)

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
index c530539..b17cac6 100644
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
@@ -538,6 +540,27 @@ static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
 	writel(val, port->base + PCIE_INT_MASK);
 }
 
+static void mtk_pcie_irq_teardown(struct mtk_pcie *pcie)
+{
+	struct mtk_pcie_port *port, *tmp;
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
@@ -628,7 +651,7 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
 	struct mtk_pcie *pcie = port->pcie;
 	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
-	int err, irq;
+	int err;
 
 	err = mtk_pcie_init_irq_domain(port, node);
 	if (err) {
@@ -636,8 +659,9 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
 		return err;
 	}
 
-	irq = platform_get_irq(pdev, port->slot);
-	irq_set_chained_handler_and_data(irq, mtk_pcie_intr_handler, port);
+	port->irq = platform_get_irq(pdev, port->slot);
+	irq_set_chained_handler_and_data(port->irq,
+					 mtk_pcie_intr_handler, port);
 
 	return 0;
 }
@@ -1199,6 +1223,32 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
+
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
+	mtk_pcie_put_resources(pcie);
+
+	return 0;
+}
+
 static int __maybe_unused mtk_pcie_suspend_noirq(struct device *dev)
 {
 	struct mtk_pcie *pcie = dev_get_drvdata(dev);
@@ -1291,6 +1341,7 @@ static const struct of_device_id mtk_pcie_ids[] = {
 
 static struct platform_driver mtk_pcie_driver = {
 	.probe = mtk_pcie_probe,
+	.remove = mtk_pcie_remove,
 	.driver = {
 		.name = "mtk-pcie",
 		.of_match_table = mtk_pcie_ids,
@@ -1298,4 +1349,5 @@ static struct platform_driver mtk_pcie_driver = {
 		.pm = &mtk_pcie_pm_ops,
 	},
 };
-builtin_platform_driver(mtk_pcie_driver);
+module_platform_driver(mtk_pcie_driver);
+MODULE_LICENSE("GPL v2");
-- 
2.6.4

