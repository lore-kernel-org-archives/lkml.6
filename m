Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961A2C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611ED20818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611ED20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbeKJHwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:52:31 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43848 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728651AbeKJHve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:51:34 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A3D5B4F566EBB;
        Sat, 10 Nov 2018 06:08:58 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Sat, 10 Nov 2018 06:08:49 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <andrew@lunn.ch>, <yuvalm@mellanox.com>,
        <leon@kernel.org>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        liuzhongzhu <liuzhongzhu@huawei.com>
Subject: [RFC PATCH 04/10] net: hns3: Add "promisc mode" config info query function
Date:   Fri, 9 Nov 2018 22:07:37 +0000
Message-ID: <20181109220743.10264-5-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181109220743.10264-1-salil.mehta@huawei.com>
References: <20181109220743.10264-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: liuzhongzhu <liuzhongzhu@huawei.com>

This patch prints promiscuous mode status.

debugfs command:
echo dump promisc 0 > cmd

Sample Output:
root@(none)# echo dump promisc 0 > cmd
hns3 0000:7d:00.0: vf(0) promisc mode
hns3 0000:7d:00.0: uc: disable
hns3 0000:7d:00.0: mc: disable
hns3 0000:7d:00.0: bc: disable
root@(none)#

Signed-off-by: liuzhongzhu <liuzhongzhu@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |  1 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 53 ++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 0bc2f59..47afdcd 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -129,6 +129,7 @@ static void hns3_dbg_help(struct hnae3_handle *h)
 	dev_info(&h->pdev->dev, "available commands\n");
 	dev_info(&h->pdev->dev, "queue info [number]\n");
 	dev_info(&h->pdev->dev, "dump fd tcam\n");
+	dev_info(&h->pdev->dev, "dump promisc [vf id]\n");
 }
 
 static ssize_t hns3_dbg_cmd_read(struct file *filp, char __user *buffer,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index feaf332..0a12473 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -7,6 +7,57 @@
 #include "hclge_main.h"
 #include "hnae3.h"
 
+static void hclge_print(struct hclge_dev *hdev, bool flag, char *true_buf,
+			char *false_buf)
+{
+	if (flag)
+		dev_info(&hdev->pdev->dev, "%s\n", true_buf);
+	else
+		dev_info(&hdev->pdev->dev, "%s\n", false_buf);
+}
+
+static void hclge_dbg_dump_promisc_cfg(struct hclge_dev *hdev, char *cmd_buf)
+{
+#define HCLGE_DBG_UC_MODE_B BIT(1)
+#define HCLGE_DBG_MC_MODE_B BIT(2)
+#define HCLGE_DBG_BC_MODE_B BIT(3)
+
+	struct hclge_promisc_cfg_cmd *req;
+	struct hclge_desc desc;
+	u16 vf_id;
+	int ret;
+
+	ret = kstrtou16(&cmd_buf[13], 10, &vf_id);
+	if (ret)
+		vf_id = 0;
+
+	if (vf_id >= hdev->num_req_vfs) {
+		dev_err(&hdev->pdev->dev, "vf_id (%u) is out of range(%u)\n",
+			vf_id, hdev->num_req_vfs);
+		return;
+	}
+
+	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_CFG_PROMISC_MODE, true);
+	req = (struct hclge_promisc_cfg_cmd *)desc.data;
+	req->vf_id = (u8)vf_id;
+
+	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+	if (ret) {
+		dev_err(&hdev->pdev->dev,
+			"dump promisc mode fail, status is %d.\n", ret);
+		return;
+	}
+
+	dev_info(&hdev->pdev->dev, "vf(%u) promisc mode\n", req->vf_id);
+
+	hclge_print(hdev, req->flag & HCLGE_DBG_UC_MODE_B,
+		    "uc: enable", "uc: disable");
+	hclge_print(hdev, req->flag & HCLGE_DBG_MC_MODE_B,
+		    "mc: enable", "mc: disable");
+	hclge_print(hdev, req->flag & HCLGE_DBG_BC_MODE_B,
+		    "bc: enable", "bc: disable");
+}
+
 static void hclge_dbg_fd_tcam_read(struct hclge_dev *hdev, u8 stage,
 				   bool sel_x, u32 loc)
 {
@@ -68,6 +119,8 @@ int hclge_dbg_run_cmd(struct hnae3_handle *handle, char *cmd_buf)
 
 	if (strncmp(cmd_buf, "dump fd tcam", 12) == 0) {
 		hclge_dbg_fd_tcam(hdev);
+	} else if (strncmp(cmd_buf, "dump promisc", 12) == 0) {
+		hclge_dbg_dump_promisc_cfg(hdev, cmd_buf);
 	} else {
 		dev_info(&hdev->pdev->dev, "unknown command\n");
 		return -EINVAL;
-- 
2.7.4


