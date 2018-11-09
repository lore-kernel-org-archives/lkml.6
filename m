Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4ABC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CBF20883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CBF20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbeKJHvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:51:50 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43968 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728644AbeKJHvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:51:49 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D2B18EC9B5DDA;
        Sat, 10 Nov 2018 06:09:13 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Sat, 10 Nov 2018 06:09:07 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <andrew@lunn.ch>, <yuvalm@mellanox.com>,
        <leon@kernel.org>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        liuzhongzhu <liuzhongzhu@huawei.com>
Subject: [RFC PATCH 09/10] net: hns3: Add "qos prio map" info query function
Date:   Fri, 9 Nov 2018 22:07:42 +0000
Message-ID: <20181109220743.10264-10-salil.mehta@huawei.com>
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

This patch prints qos priority map information.

debugfs command:
echo dump qos pri map > cmd

Sample Command:
root@(none)# echo dump qos pri map > cmd
hns3 0000:7d:00.0: dump qos pri map
hns3 0000:7d:00.0: vlan_to_pri: 0x0
hns3 0000:7d:00.0: pri_0_to_tc: 0x0
hns3 0000:7d:00.0: pri_1_to_tc: 0x0
hns3 0000:7d:00.0: pri_2_to_tc: 0x0
hns3 0000:7d:00.0: pri_3_to_tc: 0x0
hns3 0000:7d:00.0: pri_4_to_tc: 0x0
hns3 0000:7d:00.0: pri_5_to_tc: 0x0
hns3 0000:7d:00.0: pri_6_to_tc: 0x0
hns3 0000:7d:00.0: pri_7_to_tc: 0x0
root@(none)#

Signed-off-by: liuzhongzhu <liuzhongzhu@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |  1 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 30 ++++++++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h | 13 ++++++++++
 3 files changed, 44 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 8edb4e9..6c0d237 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -134,6 +134,7 @@ static void hns3_dbg_help(struct hnae3_handle *h)
 	dev_info(&h->pdev->dev, "dump tm\n");
 	dev_info(&h->pdev->dev, "dump checksum\n");
 	dev_info(&h->pdev->dev, "dump qos pause cfg\n");
+	dev_info(&h->pdev->dev, "dump qos pri map\n");
 }
 
 static ssize_t hns3_dbg_cmd_read(struct file *filp, char __user *buffer,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index a71e9d0..b8921a8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -364,6 +364,34 @@ static void hclge_dbg_dump_qos_pause_cfg(struct hclge_dev *hdev)
 		 pause_param->pause_trans_time);
 }
 
+static void hclge_dbg_dump_qos_pri_map(struct hclge_dev *hdev)
+{
+	struct hclge_qos_pri_map_cmd *pri_map;
+	struct hclge_desc desc;
+	int ret;
+
+	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_PRI_TO_TC_MAPPING, true);
+
+	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+	if (ret) {
+		dev_err(&hdev->pdev->dev,
+			"dump qos pri map fail, status is %d.\n", ret);
+		return;
+	}
+
+	pri_map = (struct hclge_qos_pri_map_cmd *)desc.data;
+	dev_info(&hdev->pdev->dev, "dump qos pri map\n");
+	dev_info(&hdev->pdev->dev, "vlan_to_pri: 0x%x\n", pri_map->vlan_pri);
+	dev_info(&hdev->pdev->dev, "pri_0_to_tc: 0x%x\n", pri_map->pri0_tc);
+	dev_info(&hdev->pdev->dev, "pri_1_to_tc: 0x%x\n", pri_map->pri1_tc);
+	dev_info(&hdev->pdev->dev, "pri_2_to_tc: 0x%x\n", pri_map->pri2_tc);
+	dev_info(&hdev->pdev->dev, "pri_3_to_tc: 0x%x\n", pri_map->pri3_tc);
+	dev_info(&hdev->pdev->dev, "pri_4_to_tc: 0x%x\n", pri_map->pri4_tc);
+	dev_info(&hdev->pdev->dev, "pri_5_to_tc: 0x%x\n", pri_map->pri5_tc);
+	dev_info(&hdev->pdev->dev, "pri_6_to_tc: 0x%x\n", pri_map->pri6_tc);
+	dev_info(&hdev->pdev->dev, "pri_7_to_tc: 0x%x\n", pri_map->pri7_tc);
+}
+
 static void hclge_dbg_fd_tcam_read(struct hclge_dev *hdev, u8 stage,
 				   bool sel_x, u32 loc)
 {
@@ -435,6 +463,8 @@ int hclge_dbg_run_cmd(struct hnae3_handle *handle, char *cmd_buf)
 		hclge_dbg_dump_checksum(hdev);
 	} else if (strncmp(cmd_buf, "dump qos pause cfg", 18) == 0) {
 		hclge_dbg_dump_qos_pause_cfg(hdev);
+	} else if (strncmp(cmd_buf, "dump qos pri map", 16) == 0) {
+		hclge_dbg_dump_qos_pri_map(hdev);
 	} else {
 		dev_info(&hdev->pdev->dev, "unknown command\n");
 		return -EINVAL;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
index 4ec9ced..6c839ee 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
@@ -8,4 +8,17 @@ struct hclge_checksum_cmd {
 	u8 outer;
 	u8 inner;
 };
+
+struct hclge_qos_pri_map_cmd {
+	u8 pri0_tc  : 4,
+	   pri1_tc  : 4;
+	u8 pri2_tc  : 4,
+	   pri3_tc  : 4;
+	u8 pri4_tc  : 4,
+	   pri5_tc  : 4;
+	u8 pri6_tc  : 4,
+	   pri7_tc  : 4;
+	u8 vlan_pri : 4,
+	   rev	    : 4;
+};
 #endif
-- 
2.7.4


