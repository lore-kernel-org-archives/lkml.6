Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDCDC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E792174C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E792174C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754041AbeGBH7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:59:10 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:39234 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S933479AbeGBH6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:58:18 -0400
X-UUID: 830603471234494dbdf6157bc6e6fa7e-20180702
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2069116566; Mon, 02 Jul 2018 15:58:16 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 2 Jul 2018 15:58:15 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 2 Jul 2018 15:58:13 +0800
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
Subject: [PATCH v3 3/4] PCI: mediatek: Add system pm support for MT2712 and MT7622
Date:   Mon, 2 Jul 2018 15:57:43 +0800
Message-ID: <1530518264-6125-4-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1530518264-6125-1-git-send-email-honghui.zhang@mediatek.com>
References: <1530518264-6125-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

The MTCMOS of PCIe Host for MT2712 and MT7622 will be off when system
suspend, and all the internal control register will be reset after system
resume. The PCIe link should be re-established and the related control
register values should be re-set after system resume.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 67 ++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 86918d4..175d7b6 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -134,12 +134,14 @@ struct mtk_pcie_port;
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
@@ -1197,12 +1199,75 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
+static int __maybe_unused mtk_pcie_suspend_noirq(struct device *dev)
+{
+	struct mtk_pcie *pcie = dev_get_drvdata(dev);
+	const struct mtk_pcie_soc *soc = pcie->soc;
+	struct mtk_pcie_port *port;
+
+	if (!soc->pm_support)
+		return 0;
+
+	if (list_empty(&pcie->ports))
+		return 0;
+
+	list_for_each_entry(port, &pcie->ports, list) {
+		clk_disable_unprepare(port->pipe_ck);
+		clk_disable_unprepare(port->obff_ck);
+		clk_disable_unprepare(port->axi_ck);
+		clk_disable_unprepare(port->aux_ck);
+		clk_disable_unprepare(port->ahb_ck);
+		clk_disable_unprepare(port->sys_ck);
+		phy_power_off(port->phy);
+		phy_exit(port->phy);
+	}
+
+	mtk_pcie_subsys_powerdown(pcie);
+
+	return 0;
+}
+
+static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
+{
+	struct mtk_pcie *pcie = dev_get_drvdata(dev);
+	const struct mtk_pcie_soc *soc = pcie->soc;
+	struct mtk_pcie_port *port, *tmp;
+
+	if (!soc->pm_support)
+		return 0;
+
+	if (list_empty(&pcie->ports))
+		return 0;
+
+	if (dev->pm_domain) {
+		pm_runtime_enable(dev);
+		pm_runtime_get_sync(dev);
+	}
+
+	clk_prepare_enable(pcie->free_ck);
+
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+		mtk_pcie_enable_port(port);
+
+	/* In case of EP was removed while system suspend. */
+	if (list_empty(&pcie->ports))
+		mtk_pcie_subsys_powerdown(pcie);
+
+	return 0;
+}
+
+static const struct dev_pm_ops mtk_pcie_pm_ops = {
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
@@ -1210,6 +1275,7 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
 
 static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
 	.need_fix_class_id = true,
+	.pm_support = true,
 	.ops = &mtk_pcie_ops_v2,
 	.startup = mtk_pcie_startup_port_v2,
 	.setup_irq = mtk_pcie_setup_irq,
@@ -1229,6 +1295,7 @@ static struct platform_driver mtk_pcie_driver = {
 		.name = "mtk-pcie",
 		.of_match_table = mtk_pcie_ids,
 		.suppress_bind_attrs = true,
+		.pm = &mtk_pcie_pm_ops,
 	},
 };
 builtin_platform_driver(mtk_pcie_driver);
-- 
2.6.4

