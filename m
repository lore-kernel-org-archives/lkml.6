Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80354C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F69B206C2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbeLOPdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 10:33:06 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:54930 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730631AbeLOPdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 10:33:02 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 70F7090070B97;
        Sat, 15 Dec 2018 23:32:58 +0800 (CST)
Received: from S00293818-DELL1.home (10.47.95.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Sat, 15 Dec 2018 23:32:52 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, liuzhongzhu <liuzhongzhu@huawei.com>
Subject: [PATCH V2 net-next 6/6] net: hns3: Add "tm map" status information query function
Date:   Sat, 15 Dec 2018 15:31:58 +0000
Message-ID: <20181215153158.1239-7-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181215153158.1239-1-salil.mehta@huawei.com>
References: <20181215153158.1239-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.95.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: liuzhongzhu <liuzhongzhu@huawei.com>

This patch prints dcb register status  information by module.

debugfs command:
root@(none)# echo dump tm map 100 > cmd
queue_id | qset_id | pri_id | tc_id
0100     | 0065    | 08     | 00
root@(none)#

Signed-off-by: liuzhongzhu <liuzhongzhu@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |  1 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |  1 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 84 ++++++++++++++++++++++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  |  7 ++
 4 files changed, 93 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 76c74b4b9777..0de543faa5b1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -241,6 +241,7 @@ static void hns3_dbg_help(struct hnae3_handle *h)
 	dev_info(&h->pdev->dev, "bd info [q_num] <bd index>\n");
 	dev_info(&h->pdev->dev, "dump fd tcam\n");
 	dev_info(&h->pdev->dev, "dump tc\n");
+	dev_info(&h->pdev->dev, "dump tm map [q_num]\n");
 	dev_info(&h->pdev->dev, "dump tm\n");
 	dev_info(&h->pdev->dev, "dump qos pause cfg\n");
 	dev_info(&h->pdev->dev, "dump qos pri map\n");
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index c3758f7cb9a0..47717800e0b5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -165,6 +165,7 @@ enum hclge_opcode_type {
 	HCLGE_OPC_CFG_TX_QUEUE		= 0x0B01,
 	HCLGE_OPC_QUERY_TX_POINTER	= 0x0B02,
 	HCLGE_OPC_QUERY_TX_STATUS	= 0x0B03,
+	HCLGE_OPC_TQP_TX_QUEUE_TC	= 0x0B04,
 	HCLGE_OPC_CFG_RX_QUEUE		= 0x0B11,
 	HCLGE_OPC_QUERY_RX_POINTER	= 0x0B12,
 	HCLGE_OPC_QUERY_RX_STATUS	= 0x0B13,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index 2d43d347ddfd..26d80504c730 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -537,6 +537,88 @@ static void hclge_dbg_dump_tm(struct hclge_dev *hdev)
 		cmd, ret);
 }
 
+static void hclge_dbg_dump_tm_map(struct hclge_dev *hdev, char *cmd_buf)
+{
+	struct hclge_bp_to_qs_map_cmd *bp_to_qs_map_cmd;
+	struct hclge_nq_to_qs_link_cmd *nq_to_qs_map;
+	struct hclge_qs_to_pri_link_cmd *map;
+	struct hclge_tqp_tx_queue_tc_cmd *tc;
+	enum hclge_opcode_type cmd;
+	struct hclge_desc desc;
+	int queue_id, group_id;
+	u32 qset_maping[32];
+	int tc_id, qset_id;
+	int pri_id, ret;
+	u32 i;
+
+	ret = kstrtouint(&cmd_buf[12], 10, &queue_id);
+	queue_id = (ret != 0) ? 0 : queue_id;
+
+	cmd = HCLGE_OPC_TM_NQ_TO_QS_LINK;
+	nq_to_qs_map = (struct hclge_nq_to_qs_link_cmd *)desc.data;
+	hclge_cmd_setup_basic_desc(&desc, cmd, true);
+	nq_to_qs_map->nq_id = cpu_to_le16(queue_id);
+	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+	if (ret)
+		goto err_tm_map_cmd_send;
+	qset_id = nq_to_qs_map->qset_id & 0x3FF;
+
+	cmd = HCLGE_OPC_TM_QS_TO_PRI_LINK;
+	map = (struct hclge_qs_to_pri_link_cmd *)desc.data;
+	hclge_cmd_setup_basic_desc(&desc, cmd, true);
+	map->qs_id = cpu_to_le16(qset_id);
+	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+	if (ret)
+		goto err_tm_map_cmd_send;
+	pri_id = map->priority;
+
+	cmd = HCLGE_OPC_TQP_TX_QUEUE_TC;
+	tc = (struct hclge_tqp_tx_queue_tc_cmd *)desc.data;
+	hclge_cmd_setup_basic_desc(&desc, cmd, true);
+	tc->queue_id = cpu_to_le16(queue_id);
+	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+	if (ret)
+		goto err_tm_map_cmd_send;
+	tc_id = tc->tc_id & 0x7;
+
+	dev_info(&hdev->pdev->dev, "queue_id | qset_id | pri_id | tc_id\n");
+	dev_info(&hdev->pdev->dev, "%04d     | %04d    | %02d     | %02d\n",
+		 queue_id, qset_id, pri_id, tc_id);
+
+	cmd = HCLGE_OPC_TM_BP_TO_QSET_MAPPING;
+	bp_to_qs_map_cmd = (struct hclge_bp_to_qs_map_cmd *)desc.data;
+	for (group_id = 0; group_id < 32; group_id++) {
+		hclge_cmd_setup_basic_desc(&desc, cmd, true);
+		bp_to_qs_map_cmd->tc_id = tc_id;
+		bp_to_qs_map_cmd->qs_group_id = group_id;
+		ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+		if (ret)
+			goto err_tm_map_cmd_send;
+
+		qset_maping[group_id] = bp_to_qs_map_cmd->qs_bit_map;
+	}
+
+	dev_info(&hdev->pdev->dev, "index | tm bp qset maping:\n");
+
+	i = 0;
+	for (group_id = 0; group_id < 4; group_id++) {
+		dev_info(&hdev->pdev->dev,
+			 "%04d  | %08x:%08x:%08x:%08x:%08x:%08x:%08x:%08x\n",
+			 group_id * 256, qset_maping[(u32)(i + 7)],
+			 qset_maping[(u32)(i + 6)], qset_maping[(u32)(i + 5)],
+			 qset_maping[(u32)(i + 4)], qset_maping[(u32)(i + 3)],
+			 qset_maping[(u32)(i + 2)], qset_maping[(u32)(i + 1)],
+			 qset_maping[i]);
+		i += 8;
+	}
+
+	return;
+
+err_tm_map_cmd_send:
+	dev_err(&hdev->pdev->dev, "dump tqp map fail(0x%x), status is %d\n",
+		cmd, ret);
+}
+
 static void hclge_dbg_dump_qos_pause_cfg(struct hclge_dev *hdev)
 {
 	struct hclge_cfg_pause_param_cmd *pause_param;
@@ -828,6 +910,8 @@ int hclge_dbg_run_cmd(struct hnae3_handle *handle, char *cmd_buf)
 		hclge_dbg_fd_tcam(hdev);
 	} else if (strncmp(cmd_buf, "dump tc", 7) == 0) {
 		hclge_dbg_dump_tc(hdev);
+	} else if (strncmp(cmd_buf, "dump tm map", 11) == 0) {
+		hclge_dbg_dump_tm_map(hdev, cmd_buf);
 	} else if (strncmp(cmd_buf, "dump tm", 7) == 0) {
 		hclge_dbg_dump_tm(hdev);
 	} else if (strncmp(cmd_buf, "dump qos pause cfg", 18) == 0) {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
index 9c6192c46aa6..b6496a439304 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
@@ -40,6 +40,13 @@ struct hclge_nq_to_qs_link_cmd {
 	__le16 qset_id;
 };
 
+struct hclge_tqp_tx_queue_tc_cmd {
+	__le16 queue_id;
+	__le16 rsvd;
+	u8 tc_id;
+	u8 rev[3];
+};
+
 struct hclge_pg_weight_cmd {
 	u8 pg_id;
 	u8 dwrr;
-- 
2.11.0


