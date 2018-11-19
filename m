Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3850C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779B92086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779B92086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbeKTHqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:46:53 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:51383 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730141AbeKTHqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:46:52 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5104A3517B7A;
        Tue, 20 Nov 2018 05:21:20 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.88.214) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.408.0; Tue, 20 Nov 2018 05:21:11 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, liuzhongzhu <liuzhongzhu@huawei.com>
Subject: [PATCH net-next 6/8] net: hns3: Add pause config info query function
Date:   Mon, 19 Nov 2018 21:18:43 +0000
Message-ID: <20181119211845.23168-7-salil.mehta@huawei.com>
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

This patch prints qos pause config information.

debugfs command:
echo dump qos pause cfg > cmd

Sample Command:
root@(none)# echo dump qos pause cfg > cmd
hns3 0000:7d:00.0: dump qos pause cfg
hns3 0000:7d:00.0: pause_trans_gap: 0xff
hns3 0000:7d:00.0: pause_trans_time: 0xffff
root@(none)#

Signed-off-by: liuzhongzhu <liuzhongzhu@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    |  1 +
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 25 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 5e938879ca66..83ca76849be4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -132,6 +132,7 @@ static void hns3_dbg_help(struct hnae3_handle *h)
 	dev_info(&h->pdev->dev, "dump fd tcam\n");
 	dev_info(&h->pdev->dev, "dump tc\n");
 	dev_info(&h->pdev->dev, "dump tm\n");
+	dev_info(&h->pdev->dev, "dump qos pause cfg\n");
 }
 
 static ssize_t hns3_dbg_cmd_read(struct file *filp, char __user *buffer,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index e6f70260fd9d..3dc1c69269ee 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -242,6 +242,29 @@ static void hclge_dbg_dump_tm(struct hclge_dev *hdev)
 		cmd, ret);
 }
 
+static void hclge_dbg_dump_qos_pause_cfg(struct hclge_dev *hdev)
+{
+	struct hclge_cfg_pause_param_cmd *pause_param;
+	struct hclge_desc desc;
+	int ret;
+
+	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_CFG_MAC_PARA, true);
+
+	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+	if (ret) {
+		dev_err(&hdev->pdev->dev, "dump checksum fail, status is %d.\n",
+			ret);
+		return;
+	}
+
+	pause_param = (struct hclge_cfg_pause_param_cmd *)desc.data;
+	dev_info(&hdev->pdev->dev, "dump qos pause cfg\n");
+	dev_info(&hdev->pdev->dev, "pause_trans_gap: 0x%x\n",
+		 pause_param->pause_trans_gap);
+	dev_info(&hdev->pdev->dev, "pause_trans_time: 0x%x\n",
+		 pause_param->pause_trans_time);
+}
+
 static void hclge_dbg_fd_tcam_read(struct hclge_dev *hdev, u8 stage,
 				   bool sel_x, u32 loc)
 {
@@ -307,6 +330,8 @@ int hclge_dbg_run_cmd(struct hnae3_handle *handle, char *cmd_buf)
 		hclge_dbg_dump_tc(hdev);
 	} else if (strncmp(cmd_buf, "dump tm", 7) == 0) {
 		hclge_dbg_dump_tm(hdev);
+	} else if (strncmp(cmd_buf, "dump qos pause cfg", 18) == 0) {
+		hclge_dbg_dump_qos_pause_cfg(hdev);
 	} else {
 		dev_info(&hdev->pdev->dev, "unknown command\n");
 		return -EINVAL;
-- 
2.17.1


