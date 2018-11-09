Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F4CC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19AA20818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F19AA20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbeKJHwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:52:09 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15075 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728784AbeKJHvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:51:43 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0D137BC4054E5;
        Sat, 10 Nov 2018 06:09:09 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Sat, 10 Nov 2018 06:09:00 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <andrew@lunn.ch>, <yuvalm@mellanox.com>,
        <leon@kernel.org>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        liuzhongzhu <liuzhongzhu@huawei.com>
Subject: [RFC PATCH 07/10] net: hns3: Add checksum info query function
Date:   Fri, 9 Nov 2018 22:07:40 +0000
Message-ID: <20181109220743.10264-8-salil.mehta@huawei.com>
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

This patch prints checksum config information
related to various layers of headers.

debugfs command:
echo dump checksum > cmd

Sample Output:
root@(none)# echo dump checksum > cmd
hns3 0000:7d:00.0: dump checksum
hns3 0000:7d:00.0: outer_l3: enable
hns3 0000:7d:00.0: outer_udp: enable
hns3 0000:7d:00.0: inner_l3: enable
hns3 0000:7d:00.0: inner_tcp: enable
hns3 0000:7d:00.0: inner_udp: enable
hns3 0000:7d:00.0: inner_sctp: enable
root@(none)#

Signed-off-by: liuzhongzhu <liuzhongzhu@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |  1 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |  3 ++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 50 ++++++++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h | 11 +++++
 4 files changed, 65 insertions(+)
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 4d7be38..27757be 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -132,6 +132,7 @@ static void hns3_dbg_help(struct hnae3_handle *h)
 	dev_info(&h->pdev->dev, "dump promisc [vf id]\n");
 	dev_info(&h->pdev->dev, "dump tc\n");
 	dev_info(&h->pdev->dev, "dump tm\n");
+	dev_info(&h->pdev->dev, "dump checksum\n");
 }
 
 static ssize_t hns3_dbg_cmd_read(struct file *filp, char __user *buffer,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index cc0f214..2c84e39 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -96,6 +96,9 @@ enum hclge_opcode_type {
 	HCLGE_OPC_CONFIG_SPEED_DUP	= 0x0309,
 	HCLGE_OPC_SERDES_LOOPBACK       = 0x0315,
 
+	/* check sum command */
+	HCLGE_OPC_CFG_CHECKSUM_EN       = 0x0601,
+
 	/* PFC/Pause commands */
 	HCLGE_OPC_CFG_MAC_PAUSE_EN      = 0x0701,
 	HCLGE_OPC_CFG_PFC_PAUSE_EN      = 0x0702,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index 4ada773..4fa546f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -3,6 +3,7 @@
 
 #include <linux/device.h>
 
+#include "hclge_debugfs.h"
 #include "hclge_cmd.h"
 #include "hclge_main.h"
 #include "hclge_tm.h"
@@ -17,6 +18,15 @@ static void hclge_print(struct hclge_dev *hdev, bool flag, char *true_buf,
 		dev_info(&hdev->pdev->dev, "%s\n", false_buf);
 }
 
+static void hclge_title_print(struct hclge_dev *hdev, bool flag,
+			      char *title_buf, char *true_buf, char *false_buf)
+{
+	if (flag)
+		dev_info(&hdev->pdev->dev, "%s: %s\n", title_buf, true_buf);
+	else
+		dev_info(&hdev->pdev->dev, "%s: %s\n", title_buf, false_buf);
+}
+
 static void hclge_title_idx_print(struct hclge_dev *hdev, bool flag, int index,
 				  char *title_buf, char *true_buf,
 				  char *false_buf)
@@ -293,6 +303,44 @@ static void hclge_dbg_dump_tm(struct hclge_dev *hdev)
 		cmd, ret);
 }
 
+static void hclge_dbg_dump_checksum(struct hclge_dev *hdev)
+{
+#define HCLGE_DBG_OUTER_L3_B   BIT(0)
+#define HCLGE_DBG_OUTER_UDP_B  BIT(1)
+#define HCLGE_DBG_INNER_L3_B   BIT(0)
+#define HCLGE_DBG_INNER_TCP_B  BIT(1)
+#define HCLGE_DBG_INNER_UDP_B  BIT(2)
+#define HCLGE_DBG_INNER_SCTP_B BIT(3)
+
+	struct hclge_checksum_cmd *checksum;
+	struct hclge_desc desc;
+	int ret;
+
+	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_CFG_CHECKSUM_EN, true);
+
+	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+	if (ret) {
+		dev_err(&hdev->pdev->dev, "dump checksum fail, status is %d.\n",
+			ret);
+		return;
+	}
+
+	checksum = (struct hclge_checksum_cmd *)desc.data;
+	dev_info(&hdev->pdev->dev, "dump checksum\n");
+	hclge_title_print(hdev, checksum->outer & HCLGE_DBG_OUTER_L3_B,
+			  "outer_l3", "enable", "disable");
+	hclge_title_print(hdev, checksum->outer & HCLGE_DBG_OUTER_UDP_B,
+			  "outer_udp", "enable", "disable");
+	hclge_title_print(hdev, checksum->inner & HCLGE_DBG_INNER_L3_B,
+			  "inner_l3", "enable", "disable");
+	hclge_title_print(hdev, checksum->inner & HCLGE_DBG_INNER_TCP_B,
+			  "inner_tcp", "enable", "disable");
+	hclge_title_print(hdev, checksum->inner & HCLGE_DBG_INNER_UDP_B,
+			  "inner_udp", "enable", "disable");
+	hclge_title_print(hdev, checksum->inner & HCLGE_DBG_INNER_SCTP_B,
+			  "inner_sctp", "enable", "disable");
+}
+
 static void hclge_dbg_fd_tcam_read(struct hclge_dev *hdev, u8 stage,
 				   bool sel_x, u32 loc)
 {
@@ -360,6 +408,8 @@ int hclge_dbg_run_cmd(struct hnae3_handle *handle, char *cmd_buf)
 		hclge_dbg_dump_tc(hdev);
 	} else if (strncmp(cmd_buf, "dump tm", 7) == 0) {
 		hclge_dbg_dump_tm(hdev);
+	} else if (strncmp(cmd_buf, "dump checksum", 13) == 0) {
+		hclge_dbg_dump_checksum(hdev);
 	} else {
 		dev_info(&hdev->pdev->dev, "unknown command\n");
 		return -EINVAL;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
new file mode 100644
index 0000000..4ec9ced
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2018-2019 Hisilicon Limited.
+
+#ifndef __HCLGE_DEBUGFS_H
+#define __HCLGE_DEBUGFS_H
+
+struct hclge_checksum_cmd {
+	u8 outer;
+	u8 inner;
+};
+#endif
-- 
2.7.4


