Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BD8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AB220870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AB220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbeKTHqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:46:23 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14686 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730790AbeKTHqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:46:23 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 01B305D175259;
        Tue, 20 Nov 2018 05:20:49 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.88.214) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.408.0; Tue, 20 Nov 2018 05:20:43 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, liuzhongzhu <liuzhongzhu@huawei.com>
Subject: [PATCH net-next 3/8] net: hns3: Add "FD flow table" info query function
Date:   Mon, 19 Nov 2018 21:18:40 +0000
Message-ID: <20181119211845.23168-4-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181119211845.23168-1-salil.mehta@huawei.com>
References: <20181119211845.23168-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.88.214]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: liuzhongzhu <liuzhongzhu@huawei.com>

All the Flow Director rules are stored in tcam blocks.
For each bit of tcam entry, the match value
depends on two input value(x, y).

debugfs command:
echo dump fd tcam > cmd

Sample output:
root@(none)# echo dump fd tcam > cmd
hns3 0000:7d:00.0: read result tcam key x(31):
hns3 0000:7d:00.0: 00000000
hns3 0000:7d:00.0: 00000000
hns3 0000:7d:00.0: 00000000
hns3 0000:7d:00.0: 08000000
hns3 0000:7d:00.0: 00000600
hns3 0000:7d:00.0: 00000000
hns3 0000:7d:00.0: 00000000
hns3 0000:7d:00.0: 00000000
hns3 0000:7d:00.0: 00000000
hns3 0000:7d:00.0: 00000000
hns3 0000:7d:00.0: 00000000
hns3 0000:7d:00.0: 00000000
hns3 0000:7d:00.0: 00000000
hns3 0000:7d:00.0: read result tcam key y(31):
hns3 0000:7d:00.0: 00000000
hns3 0000:7d:00.0: 00000000
hns3 0000:7d:00.0: 00000000
hns3 0000:7d:00.0: f7ff0000
hns3 0000:7d:00.0: 0000f900
hns3 0000:7d:00.0: 00000000
hns3 0000:7d:00.0: 00000000
hns3 0000:7d:00.0: 00000000
hns3 0000:7d:00.0: 00000000
hns3 0000:7d:00.0: 00000000
hns3 0000:7d:00.0: 00000000
hns3 0000:7d:00.0: 00000000
hns3 0000:7d:00.0: 0000fff8
root@(none)#

Signed-off-by: liuzhongzhu <liuzhongzhu@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  1 +
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    |  2 +
 .../ethernet/hisilicon/hns3/hns3pf/Makefile   |  2 +-
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 77 +++++++++++++++++++
 .../hisilicon/hns3/hns3pf/hclge_main.c        |  1 +
 .../hisilicon/hns3/hns3pf/hclge_main.h        |  1 +
 .../hisilicon/hns3/hns3pf/hclge_main.h.rej    | 12 +++
 7 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h.rej

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index f32f075991f5..a1707b77c47f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -453,6 +453,7 @@ struct hnae3_ae_ops {
 				struct ethtool_rxnfc *cmd, u32 *rule_locs);
 	int (*restore_fd_rules)(struct hnae3_handle *handle);
 	void (*enable_fd)(struct hnae3_handle *handle, bool enable);
+	int (*dbg_run_cmd)(struct hnae3_handle *handle, char *cmd_buf);
 	pci_ers_result_t (*process_hw_error)(struct hnae3_ae_dev *ae_dev);
 	bool (*get_hw_reset_stat)(struct hnae3_handle *handle);
 	bool (*ae_dev_resetting)(struct hnae3_handle *handle);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 04b0789d439d..366fb7f4dce9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -200,6 +200,8 @@ static ssize_t hns3_dbg_cmd_write(struct file *filp, const char __user *buffer,
 		hns3_dbg_help(handle);
 	else if (strncmp(cmd_buf, "queue info", 10) == 0)
 		ret = hns3_dbg_queue_info(handle, cmd_buf);
+	else if (handle->ae_algo->ops->dbg_run_cmd)
+		ret = handle->ae_algo->ops->dbg_run_cmd(handle, cmd_buf);
 
 	if (ret)
 		hns3_dbg_help(handle);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/Makefile b/drivers/net/ethernet/hisilicon/hns3/hns3pf/Makefile
index 580e81743681..fffe8c1c45d3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/Makefile
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/Makefile
@@ -6,6 +6,6 @@
 ccflags-y := -Idrivers/net/ethernet/hisilicon/hns3
 
 obj-$(CONFIG_HNS3_HCLGE) += hclge.o
-hclge-objs = hclge_main.o hclge_cmd.o hclge_mdio.o hclge_tm.o hclge_mbx.o hclge_err.o
+hclge-objs = hclge_main.o hclge_cmd.o hclge_mdio.o hclge_tm.o hclge_mbx.o hclge_err.o  hclge_debugfs.o
 
 hclge-$(CONFIG_HNS3_DCB) += hclge_dcb.o
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
new file mode 100644
index 000000000000..feaf33216d7f
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2018-2019 Hisilicon Limited.
+
+#include <linux/device.h>
+
+#include "hclge_cmd.h"
+#include "hclge_main.h"
+#include "hnae3.h"
+
+static void hclge_dbg_fd_tcam_read(struct hclge_dev *hdev, u8 stage,
+				   bool sel_x, u32 loc)
+{
+	struct hclge_fd_tcam_config_1_cmd *req1;
+	struct hclge_fd_tcam_config_2_cmd *req2;
+	struct hclge_fd_tcam_config_3_cmd *req3;
+	struct hclge_desc desc[3];
+	int ret, i;
+	u32 *req;
+
+	hclge_cmd_setup_basic_desc(&desc[0], HCLGE_OPC_FD_TCAM_OP, true);
+	desc[0].flag |= cpu_to_le16(HCLGE_CMD_FLAG_NEXT);
+	hclge_cmd_setup_basic_desc(&desc[1], HCLGE_OPC_FD_TCAM_OP, true);
+	desc[1].flag |= cpu_to_le16(HCLGE_CMD_FLAG_NEXT);
+	hclge_cmd_setup_basic_desc(&desc[2], HCLGE_OPC_FD_TCAM_OP, true);
+
+	req1 = (struct hclge_fd_tcam_config_1_cmd *)desc[0].data;
+	req2 = (struct hclge_fd_tcam_config_2_cmd *)desc[1].data;
+	req3 = (struct hclge_fd_tcam_config_3_cmd *)desc[2].data;
+
+	req1->stage  = stage;
+	req1->xy_sel = sel_x ? 1 : 0;
+	req1->index  = cpu_to_le32(loc);
+
+	ret = hclge_cmd_send(&hdev->hw, desc, 3);
+	if (ret)
+		return;
+
+	dev_info(&hdev->pdev->dev, " read result tcam key %s(%u):\n",
+		 sel_x ? "x" : "y", loc);
+
+	req = (u32 *)req1->tcam_data;
+	for (i = 0; i < 2; i++)
+		dev_info(&hdev->pdev->dev, "%08x\n", *req++);
+
+	req = (u32 *)req2->tcam_data;
+	for (i = 0; i < 6; i++)
+		dev_info(&hdev->pdev->dev, "%08x\n", *req++);
+
+	req = (u32 *)req3->tcam_data;
+	for (i = 0; i < 5; i++)
+		dev_info(&hdev->pdev->dev, "%08x\n", *req++);
+}
+
+static void hclge_dbg_fd_tcam(struct hclge_dev *hdev)
+{
+	u32 i;
+
+	for (i = 0; i < hdev->fd_cfg.rule_num[0]; i++) {
+		hclge_dbg_fd_tcam_read(hdev, 0, true, i);
+		hclge_dbg_fd_tcam_read(hdev, 0, false, i);
+	}
+}
+
+int hclge_dbg_run_cmd(struct hnae3_handle *handle, char *cmd_buf)
+{
+	struct hclge_vport *vport = hclge_get_vport(handle);
+	struct hclge_dev *hdev = vport->back;
+
+	if (strncmp(cmd_buf, "dump fd tcam", 12) == 0) {
+		hclge_dbg_fd_tcam(hdev);
+	} else {
+		dev_info(&hdev->pdev->dev, "unknown command\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index f78b8e188443..696cb53013bc 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -7826,6 +7826,7 @@ static const struct hnae3_ae_ops hclge_ops = {
 	.get_fd_all_rules = hclge_get_all_rules,
 	.restore_fd_rules = hclge_restore_fd_entries,
 	.enable_fd = hclge_enable_fd,
+	.dbg_run_cmd = hclge_dbg_run_cmd,
 	.process_hw_error = hclge_process_ras_hw_error,
 	.get_hw_reset_stat = hclge_get_hw_reset_stat,
 	.ae_dev_resetting = hclge_ae_dev_resetting,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 5f24dd41d7eb..4122ad1aab1f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -814,4 +814,5 @@ int hclge_func_reset_cmd(struct hclge_dev *hdev, int func_id);
 int hclge_vport_start(struct hclge_vport *vport);
 void hclge_vport_stop(struct hclge_vport *vport);
 int hclge_set_vport_mtu(struct hclge_vport *vport, int new_mtu);
+int hclge_dbg_run_cmd(struct hnae3_handle *handle, char *cmd_buf);
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h.rej b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h.rej
new file mode 100644
index 000000000000..be7d0dea06e7
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h.rej
@@ -0,0 +1,12 @@
+*************** int hclge_set_vlan_filter(struct hnae3_handle *handle, __be16 proto,
+*** 800,803 ****
+  void hclge_reset_vf_queue(struct hclge_vport *vport, u16 queue_id);
+  int hclge_cfg_flowctrl(struct hclge_dev *hdev);
+  int hclge_func_reset_cmd(struct hclge_dev *hdev, int func_id);
+  #endif
+--- 800,804 ----
+  void hclge_reset_vf_queue(struct hclge_vport *vport, u16 queue_id);
+  int hclge_cfg_flowctrl(struct hclge_dev *hdev);
+  int hclge_func_reset_cmd(struct hclge_dev *hdev, int func_id);
++ int hclge_dbg_run_cmd(struct hnae3_handle *handle, char *cmd_buf);
+  #endif
-- 
2.17.1


