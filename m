Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE75C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003572075E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003572075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeGKIND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:13:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38112 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726205AbeGKIND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:13:03 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4B2563DA1EC6C;
        Wed, 11 Jul 2018 16:09:57 +0800 (CST)
Received: from vm107-55-164.huawei.com (100.107.55.164) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.382.0; Wed, 11 Jul 2018 16:09:47 +0800
From:   Xiaowei Song <songxiaowei@hisilicon.com>
To:     <wangbinghui@hisilicon.com>, <bhelgaas@google.com>,
        <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <suzhuangluan@hisilicon.com>, <andy.shevchenko@gmail.com>
CC:     <kongfei@hisilicon.com>, <chenyao11@huawei.com>,
        <songxiaowei@hisilicon.com>
Subject: [PATCH v7 1/1] PCI: kirin: Add MSI support
Date:   Wed, 11 Jul 2018 16:09:46 +0800
Message-ID: <20180711080946.14942-2-songxiaowei@hisilicon.com>
X-Mailer: git-send-email 2.11.GIT
In-Reply-To: <20180711080946.14942-1-songxiaowei@hisilicon.com>
References: <20180711080946.14942-1-songxiaowei@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.107.55.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for MSI

Signed-off-by: Xiaowei Song <songxiaowei@hisilicon.com>
Signed-off-by: Yao Chen <chenyao11@huawei.com>
---
 drivers/pci/dwc/pcie-kirin.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pci/dwc/pcie-kirin.c b/drivers/pci/dwc/pcie-kirin.c
index d2970a009eb5..5352e0c3be82 100644
--- a/drivers/pci/dwc/pcie-kirin.c
+++ b/drivers/pci/dwc/pcie-kirin.c
@@ -430,6 +430,9 @@ static int kirin_pcie_host_init(struct pcie_port *pp)
 {
 	kirin_pcie_establish_link(pp);
 
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		dw_pcie_msi_init(pp);
+
 	return 0;
 }
 
@@ -445,9 +448,34 @@ static const struct dw_pcie_host_ops kirin_pcie_host_ops = {
 	.host_init = kirin_pcie_host_init,
 };
 
+static int kirin_pcie_add_msi(struct dw_pcie *pci,
+				struct platform_device *pdev)
+{
+	int irq;
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		irq = platform_get_irq(pdev, 0);
+		if (irq < 0) {
+			dev_err(&pdev->dev,
+				"failed to get MSI IRQ (%d)\n", irq);
+			return irq;
+		}
+
+		pci->pp.msi_irq = irq;
+	}
+
+	return 0;
+}
+
 static int __init kirin_add_pcie_port(struct dw_pcie *pci,
 				      struct platform_device *pdev)
 {
+	int ret;
+
+	ret = kirin_pcie_add_msi(pci, pdev);
+	if (ret)
+		return ret;
+
 	pci->pp.ops = &kirin_pcie_host_ops;
 
 	return dw_pcie_host_init(&pci->pp);
-- 
2.11.GIT

