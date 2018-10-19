Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65907ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314F521486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 314F521486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeJTDYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 23:24:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14094 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727680AbeJTDYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 23:24:32 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6599BBBEA32B4;
        Sat, 20 Oct 2018 03:17:02 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Sat, 20 Oct 2018 03:16:57 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH net-next 1/7] net: hns3: Add PCIe AER callback error_detected
Date:   Fri, 19 Oct 2018 20:15:26 +0100
Message-ID: <20181019191532.10088-2-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181019191532.10088-1-salil.mehta@huawei.com>
References: <20181019191532.10088-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

Set of hw errors occurred in the HNS3 are reported to the
hns3 driver through PCIe AER and RAS.The error info will be
processed and appropriately recovered.
This patch adds error_detected callback and error processing.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 30 +++++++++++++++++
 .../net/ethernet/hisilicon/hns3/hns3pf/Makefile    |  2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 38 ++++++++++++++++++++++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h | 29 +++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  2 ++
 6 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index c3bd2a1..2af3a2d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -429,6 +429,7 @@ struct hnae3_ae_ops {
 				struct ethtool_rxnfc *cmd, u32 *rule_locs);
 	int (*restore_fd_rules)(struct hnae3_handle *handle);
 	void (*enable_fd)(struct hnae3_handle *handle, bool enable);
+	pci_ers_result_t (*process_hw_error)(struct hnae3_ae_dev *ae_dev);
 };
 
 struct hnae3_dcb_ops {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 76ce2f2..3c6fa39 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1771,6 +1771,35 @@ static void hns3_shutdown(struct pci_dev *pdev)
 		pci_set_power_state(pdev, PCI_D3hot);
 }
 
+static pci_ers_result_t hns3_error_detected(struct pci_dev *pdev,
+					    pci_channel_state_t state)
+{
+	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(pdev);
+	pci_ers_result_t ret;
+
+	dev_info(&pdev->dev, "PCI error detected, state(=%d)!!\n", state);
+
+	if (state == pci_channel_io_perm_failure)
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	if (!ae_dev) {
+		dev_err(&pdev->dev,
+			"Can't recover - error happened during device init\n");
+		return PCI_ERS_RESULT_NONE;
+	}
+
+	if (ae_dev->ops->process_hw_error)
+		ret = ae_dev->ops->process_hw_error(ae_dev);
+	else
+		return PCI_ERS_RESULT_NONE;
+
+	return ret;
+}
+
+static const struct pci_error_handlers hns3_err_handler = {
+	.error_detected = hns3_error_detected,
+};
+
 static struct pci_driver hns3_driver = {
 	.name     = hns3_driver_name,
 	.id_table = hns3_pci_tbl,
@@ -1778,6 +1807,7 @@ static struct pci_driver hns3_driver = {
 	.remove   = hns3_remove,
 	.shutdown = hns3_shutdown,
 	.sriov_configure = hns3_pci_sriov_configure,
+	.err_handler    = &hns3_err_handler,
 };
 
 /* set default feature to hns3 */
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/Makefile b/drivers/net/ethernet/hisilicon/hns3/hns3pf/Makefile
index cb8ddd0..580e817 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/Makefile
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/Makefile
@@ -6,6 +6,6 @@
 ccflags-y := -Idrivers/net/ethernet/hisilicon/hns3
 
 obj-$(CONFIG_HNS3_HCLGE) += hclge.o
-hclge-objs = hclge_main.o hclge_cmd.o hclge_mdio.o hclge_tm.o hclge_mbx.o
+hclge-objs = hclge_main.o hclge_cmd.o hclge_mdio.o hclge_tm.o hclge_mbx.o hclge_err.o
 
 hclge-$(CONFIG_HNS3_DCB) += hclge_dcb.o
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
new file mode 100644
index 0000000..83aca6f
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) 2016-2017 Hisilicon Limited. */
+
+#include "hclge_err.h"
+
+static const struct hclge_hw_blk hw_blk[] = {
+	{ /* sentinel */ }
+};
+
+pci_ers_result_t hclge_process_ras_hw_error(struct hnae3_ae_dev *ae_dev)
+{
+	struct hclge_dev *hdev = ae_dev->priv;
+	struct device *dev = &hdev->pdev->dev;
+	u32 sts, val;
+	int i = 0;
+
+	sts = hclge_read_dev(&hdev->hw, HCLGE_RAS_PF_OTHER_INT_STS_REG);
+
+	/* Processing Non-fatal errors */
+	if (sts & HCLGE_RAS_REG_NFE_MASK) {
+		val = (sts >> HCLGE_RAS_REG_NFE_SHIFT) & 0xFF;
+		i = 0;
+		while (hw_blk[i].name) {
+			if (!(hw_blk[i].msk & val)) {
+				i++;
+				continue;
+			}
+			dev_warn(dev, "%s ras non-fatal error identified\n",
+				 hw_blk[i].name);
+			if (hw_blk[i].process_error)
+				hw_blk[i].process_error(hdev,
+							 HCLGE_ERR_INT_RAS_NFE);
+			i++;
+		}
+	}
+
+	return PCI_ERS_RESULT_NEED_RESET;
+}
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
new file mode 100644
index 0000000..ea1637c
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*  Copyright (c) 2016-2017 Hisilicon Limited. */
+
+#ifndef __HCLGE_ERR_H
+#define __HCLGE_ERR_H
+
+#include "hclge_main.h"
+
+#define HCLGE_RAS_PF_OTHER_INT_STS_REG   0x20B00
+#define HCLGE_RAS_REG_FE_MASK    0xFF
+#define HCLGE_RAS_REG_NFE_MASK   0xFF00
+#define HCLGE_RAS_REG_NFE_SHIFT	8
+
+enum hclge_err_int_type {
+	HCLGE_ERR_INT_MSIX = 0,
+	HCLGE_ERR_INT_RAS_CE = 1,
+	HCLGE_ERR_INT_RAS_NFE = 2,
+	HCLGE_ERR_INT_RAS_FE = 3,
+};
+
+struct hclge_hw_blk {
+	u32 msk;
+	const char *name;
+	void (*process_error)(struct hclge_dev *hdev,
+			      enum hclge_err_int_type type);
+};
+
+pci_ers_result_t hclge_process_ras_hw_error(struct hnae3_ae_dev *ae_dev);
+#endif
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 1bd83e8..94d3678 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -19,6 +19,7 @@
 #include "hclge_mbx.h"
 #include "hclge_mdio.h"
 #include "hclge_tm.h"
+#include "hclge_err.h"
 #include "hnae3.h"
 
 #define HCLGE_NAME			"hclge"
@@ -7312,6 +7313,7 @@ static const struct hnae3_ae_ops hclge_ops = {
 	.get_fd_all_rules = hclge_get_all_rules,
 	.restore_fd_rules = hclge_restore_fd_entries,
 	.enable_fd = hclge_enable_fd,
+	.process_hw_error = hclge_process_ras_hw_error,
 };
 
 static struct hnae3_ae_algo ae_algo = {
-- 
2.7.4


