Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755500AbeE3Cfr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 22:35:47 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:12934 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750821AbeE3Cfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 22:35:44 -0400
X-UUID: 06d0201d67524240aa9ec034ccb2e30f-20180530
From: <honghui.zhang@mediatek.com>
To: <lorenzo.pieralisi@arm.com>, <marc.zyngier@arm.com>,
        <bhelgaas@google.com>, <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <ryder.lee@mediatek.com>
CC: <honghui.zhang@mediatek.com>, <hongkun.cao@mediatek.com>,
        <youlin.pei@mediatek.com>, <yong.wu@mediatek.com>,
        <yt.shen@mediatek.com>, <sean.wang@mediatek.com>,
        <xinping.qian@mediatek.com>
Subject: [PATCH] PCI: mediatek: Add system pm support for MT2712
Date: Wed, 30 May 2018 10:35:36 +0800
Message-ID: <1527647736-19986-1-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

The MTCMOS of PCIe Host for MT2712 will be off when system suspend, and all
the internel control register will be reset after system resume. The PCIe
link should be re-established and the related control register values should
be re-set after system resume.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
CC: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/host/pcie-mediatek.c | 82 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index dabf1086..60f98d92 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -132,12 +132,14 @@ struct mtk_pcie_port;
 /**
  * struct mtk_pcie_soc - differentiate between host generations
  * @need_fix_class_id: whether this host's class ID needed to be fixed or not
+ * @pm_support: whether the host's MTCMOS will be off when suspend
  * @ops: pointer to configuration access functions
  * @startup: pointer to controller setting functions
  * @setup_irq: pointer to initialize IRQ functions
  */
 struct mtk_pcie_soc {
 	bool need_fix_class_id;
+	bool pm_support;
 	struct pci_ops *ops;
 	int (*startup)(struct mtk_pcie_port *port);
 	int (*setup_irq)(struct mtk_pcie_port *port, struct device_node *node);
@@ -1179,12 +1181,91 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
+static int __maybe_unused mtk_pcie_suspend_noirq(struct device *dev)
+{
+	struct platform_device *pdev;
+	struct mtk_pcie *pcie;
+	struct mtk_pcie_port *port;
+	const struct mtk_pcie_soc *soc;
+
+	pdev = to_platform_device(dev);
+	pcie = platform_get_drvdata(pdev);
+	soc = pcie->soc;
+	if (!soc->pm_support)
+		return 0;
+
+	list_for_each_entry(port, &pcie->ports, list) {
+		clk_disable_unprepare(port->ahb_ck);
+		clk_disable_unprepare(port->sys_ck);
+		phy_power_off(port->phy);
+	}
+
+	return 0;
+}
+
+static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
+{
+	struct platform_device *pdev;
+	struct mtk_pcie *pcie;
+	struct mtk_pcie_port *port;
+	const struct mtk_pcie_soc *soc;
+	int ret;
+
+	pdev = to_platform_device(dev);
+	pcie = platform_get_drvdata(pdev);
+	soc = pcie->soc;
+	if (!soc->pm_support)
+		return 0;
+
+	list_for_each_entry(port, &pcie->ports, list) {
+		ret = phy_power_on(port->phy);
+		if (ret) {
+			dev_err(dev, "could not power on phy\n");
+			return ret;
+		}
+		ret = clk_prepare_enable(port->sys_ck);
+		if (ret) {
+			dev_err(dev, "enable sys clock error\n");
+			phy_power_off(port->phy);
+			return ret;
+		}
+
+		ret = clk_prepare_enable(port->ahb_ck);
+		if (ret) {
+			dev_err(dev, "enable ahb clock error\n");
+			phy_power_off(port->phy);
+			clk_disable_unprepare(port->sys_ck);
+			return ret;
+		}
+
+		ret = soc->startup(port);
+		if (ret) {
+			dev_err(dev, "pcie linkup failed\n");
+			phy_power_off(port->phy);
+			clk_disable_unprepare(port->sys_ck);
+			clk_disable_unprepare(port->ahb_ck);
+			return ret;
+		}
+
+		if (IS_ENABLED(CONFIG_PCI_MSI))
+			mtk_pcie_enable_msi(port);
+	}
+
+	return 0;
+}
+
+const struct dev_pm_ops mtk_pcie_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_pcie_suspend_noirq,
+				      mtk_pcie_resume_noirq)
+};
+
 static const struct mtk_pcie_soc mtk_pcie_soc_v1 = {
 	.ops = &mtk_pcie_ops,
 	.startup = mtk_pcie_startup_port,
 };
 
 static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
+	.pm_support = true,
 	.ops = &mtk_pcie_ops_v2,
 	.startup = mtk_pcie_startup_port_v2,
 	.setup_irq = mtk_pcie_setup_irq,
@@ -1211,6 +1292,7 @@ static struct platform_driver mtk_pcie_driver = {
 		.name = "mtk-pcie",
 		.of_match_table = mtk_pcie_ids,
 		.suppress_bind_attrs = true,
+		.pm = &mtk_pcie_pm_ops,
 	},
 };
 builtin_platform_driver(mtk_pcie_driver);
-- 
2.6.4
