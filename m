Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D5CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426F620851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426F620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbeKTHqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:46:39 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:51312 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730141AbeKTHqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:46:38 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1F02BBC34D775;
        Tue, 20 Nov 2018 05:21:05 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.88.214) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.408.0; Tue, 20 Nov 2018 05:20:56 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, liuzhongzhu <liuzhongzhu@huawei.com>
Subject: [PATCH net-next 4/8] net: hns3: Add "tc config" info query function
Date:   Mon, 19 Nov 2018 21:18:41 +0000
Message-ID: <20181119211845.23168-5-salil.mehta@huawei.com>
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

This patch prints tc config information.

debugfs command:
echo dump tc > cmd

Sample Output:
root@(none)# echo dump tc > cmd
hns3 0000:7d:00.0: weight_offset: 14
hns3 0000:7d:00.0: tc(0): no sp mode
hns3 0000:7d:00.0: tc(1): no sp mode
hns3 0000:7d:00.0: tc(2): no sp mode
hns3 0000:7d:00.0: tc(3): no sp mode
hns3 0000:7d:00.0: tc(4): no sp mode
hns3 0000:7d:00.0: tc(5): no sp mode
hns3 0000:7d:00.0: tc(6): no sp mode
hns3 0000:7d:00.0: tc(7): no sp mode
root@(none)#

Signed-off-by: liuzhongzhu <liuzhongzhu@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    |  1 +
 .../hisilicon/hns3/hns3pf/hclge_cmd.h         |  1 +
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 40 +++++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_tm.h |  6 +++
 4 files changed, 48 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 366fb7f4dce9..b19f7ad5e45a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -130,6 +130,7 @@ static void hns3_dbg_help(struct hnae3_handle *h)
 	dev_info(&h->pdev->dev, "available commands\n");
 	dev_info(&h->pdev->dev, "queue info [number]\n");
 	dev_info(&h->pdev->dev, "dump fd tcam\n");
+	dev_info(&h->pdev->dev, "dump tc\n");
 }
 
 static ssize_t hns3_dbg_cmd_read(struct file *filp, char __user *buffer,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index aef044d08b11..2b90410eeac2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -126,6 +126,7 @@ enum hclge_opcode_type {
 	HCLGE_OPC_TM_PRI_SCH_MODE_CFG   = 0x0813,
 	HCLGE_OPC_TM_QS_SCH_MODE_CFG    = 0x0814,
 	HCLGE_OPC_TM_BP_TO_QSET_MAPPING = 0x0815,
+	HCLGE_OPC_ETS_TC_WEIGHT		= 0x0843,
 
 	/* Packet buffer allocate commands */
 	HCLGE_OPC_TX_BUFF_ALLOC		= 0x0901,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index feaf33216d7f..484a10b5dcc2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -5,8 +5,46 @@
 
 #include "hclge_cmd.h"
 #include "hclge_main.h"
+#include "hclge_tm.h"
 #include "hnae3.h"
 
+static void hclge_title_idx_print(struct hclge_dev *hdev, bool flag, int index,
+				  char *title_buf, char *true_buf,
+				  char *false_buf)
+{
+	if (flag)
+		dev_info(&hdev->pdev->dev, "%s(%d): %s\n", title_buf, index,
+			 true_buf);
+	else
+		dev_info(&hdev->pdev->dev, "%s(%d): %s\n", title_buf, index,
+			 false_buf);
+}
+
+static void hclge_dbg_dump_tc(struct hclge_dev *hdev)
+{
+	struct hclge_ets_tc_weight_cmd *ets_weight;
+	struct hclge_desc desc;
+	int i, ret;
+
+	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_ETS_TC_WEIGHT, true);
+
+	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+	if (ret) {
+		dev_err(&hdev->pdev->dev, "dump tc fail, status is %d.\n", ret);
+		return;
+	}
+
+	ets_weight = (struct hclge_ets_tc_weight_cmd *)desc.data;
+
+	dev_info(&hdev->pdev->dev, "dump tc\n");
+	dev_info(&hdev->pdev->dev, "weight_offset: %u\n",
+		 ets_weight->weight_offset);
+
+	for (i = 0; i < HNAE3_MAX_TC; i++)
+		hclge_title_idx_print(hdev, ets_weight->tc_weight[i], i,
+				      "tc", "no sp mode", "sp mode");
+}
+
 static void hclge_dbg_fd_tcam_read(struct hclge_dev *hdev, u8 stage,
 				   bool sel_x, u32 loc)
 {
@@ -68,6 +106,8 @@ int hclge_dbg_run_cmd(struct hnae3_handle *handle, char *cmd_buf)
 
 	if (strncmp(cmd_buf, "dump fd tcam", 12) == 0) {
 		hclge_dbg_fd_tcam(hdev);
+	} else if (strncmp(cmd_buf, "dump tc", 7) == 0) {
+		hclge_dbg_dump_tc(hdev);
 	} else {
 		dev_info(&hdev->pdev->dev, "unknown command\n");
 		return -EINVAL;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
index 25eef13a3e14..03474d5ed376 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
@@ -55,6 +55,12 @@ struct hclge_qs_weight_cmd {
 	u8 dwrr;
 };
 
+struct hclge_ets_tc_weight_cmd {
+	u8 tc_weight[HNAE3_MAX_TC];
+	u8 weight_offset;
+	u8 rsvd[15];
+};
+
 #define HCLGE_TM_SHAP_IR_B_MSK  GENMASK(7, 0)
 #define HCLGE_TM_SHAP_IR_B_LSH	0
 #define HCLGE_TM_SHAP_IR_U_MSK  GENMASK(11, 8)
-- 
2.17.1


