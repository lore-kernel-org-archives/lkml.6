Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B138C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38190206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38190206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403924AbeKWAvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:51:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15139 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391983AbeKWAu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:50:59 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B3026F65F4AA2;
        Thu, 22 Nov 2018 22:11:18 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.408.0; Thu, 22 Nov 2018 22:11:12 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, liuzhongzhu <liuzhongzhu@huawei.com>
Subject: [PATCH V2 net-next 7/8] net: hns3: Add "qos prio map" info query function
Date:   Thu, 22 Nov 2018 14:09:47 +0000
Message-ID: <20181122140948.23504-8-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181122140948.23504-1-salil.mehta@huawei.com>
References: <20181122140948.23504-1-salil.mehta@huawei.com>
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
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 31 ++++++++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h | 23 ++++++++++++++++
 3 files changed, 55 insertions(+)
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 6258695..ce284c8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -133,6 +133,7 @@ static void hns3_dbg_help(struct hnae3_handle *h)
 	dev_info(&h->pdev->dev, "dump tc\n");
 	dev_info(&h->pdev->dev, "dump tm\n");
 	dev_info(&h->pdev->dev, "dump qos pause cfg\n");
+	dev_info(&h->pdev->dev, "dump qos pri map\n");
 }
 
 static ssize_t hns3_dbg_cmd_read(struct file *filp, char __user *buffer,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index 37b312b..477acf7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -3,6 +3,7 @@
 
 #include <linux/device.h>
 
+#include "hclge_debugfs.h"
 #include "hclge_cmd.h"
 #include "hclge_main.h"
 #include "hclge_tm.h"
@@ -265,6 +266,34 @@ static void hclge_dbg_dump_qos_pause_cfg(struct hclge_dev *hdev)
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
@@ -332,6 +361,8 @@ int hclge_dbg_run_cmd(struct hnae3_handle *handle, char *cmd_buf)
 		hclge_dbg_dump_tm(hdev);
 	} else if (strncmp(cmd_buf, "dump qos pause cfg", 18) == 0) {
 		hclge_dbg_dump_qos_pause_cfg(hdev);
+	} else if (strncmp(cmd_buf, "dump qos pri map", 16) == 0) {
+		hclge_dbg_dump_qos_pri_map(hdev);
 	} else {
 		dev_info(&hdev->pdev->dev, "unknown command\n");
 		return -EINVAL;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
new file mode 100644
index 0000000..50fd0b1
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2018-2019 Hisilicon Limited. */
+
+#ifndef __HCLGE_DEBUGFS_H
+#define __HCLGE_DEBUGFS_H
+
+#pragma pack(1)
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
+
+#pragma pack()
+#endif
-- 
2.7.4


