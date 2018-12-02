Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE75CC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E5520834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E5520834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbeLBXLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 18:11:18 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15623 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbeLBXLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 18:11:18 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 02CF17DA3549E;
        Mon,  3 Dec 2018 07:11:13 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.90.156) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Mon, 3 Dec 2018 07:11:08 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, liuzhongzhu <liuzhongzhu@huawei.com>
Subject: [RFC net-next 2/9] net: hns3: Add "mac table" information query function
Date:   Sun, 2 Dec 2018 23:09:26 +0000
Message-ID: <20181202230933.15560-3-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181202230933.15560-1-salil.mehta@huawei.com>
References: <20181202230933.15560-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.90.156]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: liuzhongzhu <liuzhongzhu@huawei.com>

This patch prints mac table information.

debugfs command:
echo dump mac tbl > cmd

Sample Command:
root@(none)# echo dump mac tbl > cmd
 Unicast tab:
 |index |mac_addr          |vlan_id |VMDq1 |U_M |mac_en |in_port
 |0088  |22:22:22:22:22:00 |0000    |0     |0   |0      |2
 |0556  |33:33:00:00:00:01 |0000    |1     |1   |1      |0
 |2812  |33:33:ff:82:68:17 |0000    |1     |1   |1      |0
 |2844  |01:00:5e:00:00:01 |0000    |1     |1   |1      |0
 |3368  |c2:f1:c5:82:68:17 |0000    |0     |0   |0      |0
 Multicast tab: entry number = 3
 |index |mac_addr          |UM_MC_RDATA
 |0556  |33:33:00:00:00:01 |00000000:00000001:00000000:00000000:00000000
 |2812  |33:33:ff:82:68:17 |00000000:00000001:00000000:00000000:00000000
 |2844  |01:00:5e:00:00:01 |00000000:00000001:00000000:00000000:00000000
root@(none)#

Signed-off-by: liuzhongzhu <liuzhongzhu@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |   1 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |  18 +++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 125 +++++++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h |  16 +++
 4 files changed, 160 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 9a026556df0e..e59591b1258b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -210,6 +210,7 @@ static void hns3_dbg_help(struct hnae3_handle *h)
 	dev_info(&h->pdev->dev, "dump qos pause cfg\n");
 	dev_info(&h->pdev->dev, "dump qos pri map\n");
 	dev_info(&h->pdev->dev, "dump qos buf cfg\n");
+	dev_info(&h->pdev->dev, "dump mac tbl\n");
 }
 
 static ssize_t hns3_dbg_cmd_read(struct file *filp, char __user *buffer,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index e1805b972628..d5d10a8cbb5d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -232,6 +232,7 @@ enum hclge_opcode_type {
 	HCLGE_TM_QCN_MEM_INT_INFO_CMD	= 0x1A17,
 	HCLGE_PPP_CMD0_INT_CMD		= 0x2100,
 	HCLGE_PPP_CMD1_INT_CMD		= 0x2101,
+	HCLGE_PPP_MAC_VLAN_IDX_RD	= 0x2104,
 	HCLGE_NCSI_INT_QUERY		= 0x2400,
 	HCLGE_NCSI_INT_EN		= 0x2401,
 	HCLGE_NCSI_INT_CLR		= 0x2402,
@@ -725,6 +726,23 @@ struct hclge_rx_vlan_type_cfg_cmd {
 	u8 rsv[16];
 };
 
+#pragma pack(1)
+struct hclge_mac_vlan_idx_rd_cmd {
+	u8	rsv0;
+	u8	resp_code;
+	__le16  vlan_tag;
+	u8      mac_add[6];
+	__le16  port;
+	u8	entry_type;
+	u8	mc_mac_en;
+	__le16  egress_port;
+	__le16  egress_queue;
+	__le16  vsi;
+	__le32  index;
+};
+
+#pragma pack()
+
 struct hclge_cfg_com_tqp_queue_cmd {
 	__le16 tqp_id;
 	__le16 stream_id;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index 14577bbf3e11..19b76f5e93d7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -407,6 +407,129 @@ static void hclge_dbg_dump_qos_buf_cfg(struct hclge_dev *hdev)
 		"dump qos buf cfg fail(0x%x), status is %d\n", cmd, ret);
 }
 
+static void hclge_dbg_dump_mac_table(struct hclge_dev *hdev)
+{
+	struct hclge_mac_vlan_idx_rd_cmd *mac_rd_cmd;
+	struct hclge_mac_vlan_idx_rd_mc *mc_mac_tbl;
+	char printf_buf[HCLGE_DBG_BUF_LEN];
+	struct hclge_desc desc[3];
+	u32 mc_tbl_idx, i;
+	int ret, len;
+	int j;
+
+	len = sizeof(struct hclge_mac_vlan_idx_rd_mc) * HCLGE_DBG_MAC_TBL_MAX;
+	mc_mac_tbl = kzalloc(len, GFP_KERNEL);
+	if (!mc_mac_tbl) {
+		dev_err(&hdev->pdev->dev, "mc_mac_tbl alloc memory failed\n");
+		return;
+	}
+
+	memset(printf_buf, 0, HCLGE_DBG_BUF_LEN);
+	dev_info(&hdev->pdev->dev, "Unicast tab:\n");
+	strncat(printf_buf, "|index |mac_addr          |vlan_id |VMDq1 |",
+		HCLGE_DBG_BUF_LEN);
+	strncat(printf_buf, "U_M |mac_en |in_port |E_type |E_Port\n",
+		HCLGE_DBG_BUF_LEN - strlen(printf_buf));
+
+	dev_info(&hdev->pdev->dev, "%s", printf_buf);
+
+	mc_tbl_idx = 0;
+	for (i = 0; i < HCLGE_DBG_MAC_TBL_MAX; i++) {
+		/* Prevent long-term occupation of the command channel. */
+		if ((i % 100) == 0)
+			msleep(100);
+
+		hclge_cmd_setup_basic_desc(&desc[0], HCLGE_PPP_MAC_VLAN_IDX_RD,
+					   true);
+		desc[0].flag |= cpu_to_le16(HCLGE_CMD_FLAG_NEXT);
+		hclge_cmd_setup_basic_desc(&desc[1], HCLGE_PPP_MAC_VLAN_IDX_RD,
+					   true);
+		desc[1].flag |= cpu_to_le16(HCLGE_CMD_FLAG_NEXT);
+		hclge_cmd_setup_basic_desc(&desc[2], HCLGE_PPP_MAC_VLAN_IDX_RD,
+					   true);
+
+		mac_rd_cmd = (struct hclge_mac_vlan_idx_rd_cmd *)desc[0].data;
+
+		mac_rd_cmd->index = cpu_to_le32(i);
+		ret = hclge_cmd_send(&hdev->hw, desc, 3);
+		if (ret) {
+			dev_err(&hdev->pdev->dev,
+				"call hclge_cmd_send fail, ret = %d\n", ret);
+			kfree(mc_mac_tbl);
+			return;
+		}
+
+		if (mac_rd_cmd->resp_code)
+			continue;
+
+		memset(printf_buf, 0, HCLGE_DBG_BUF_LEN);
+		snprintf(printf_buf, HCLGE_DBG_BUF_LEN,
+			 "|%04d  |%02x:%02x:%02x:%02x:%02x:%02x |",
+			 i, mac_rd_cmd->mac_add[0], mac_rd_cmd->mac_add[1],
+			 mac_rd_cmd->mac_add[2], mac_rd_cmd->mac_add[3],
+			 mac_rd_cmd->mac_add[4], mac_rd_cmd->mac_add[5]);
+
+		snprintf(printf_buf + strlen(printf_buf),
+			 HCLGE_DBG_BUF_LEN - strlen(printf_buf),
+			 "%04u    |%d     |%d   |%d      |%u       |",
+			 mac_rd_cmd->vlan_tag,
+			 mac_rd_cmd->entry_type && HCLGE_DBG_MAC_TBL_EN_TYPE,
+			 mac_rd_cmd->entry_type && HCLGE_DBG_MAC_TBL_MC_TYPE,
+			 mac_rd_cmd->mc_mac_en && HCLGE_DBG_MAC_TBL_MAC_EN,
+			 mac_rd_cmd->port & HCLGE_DBG_MAC_TBL_IN_PORT);
+		snprintf(printf_buf + strlen(printf_buf),
+			 HCLGE_DBG_BUF_LEN - strlen(printf_buf),
+			 "%d      |%04x\n",
+			 mac_rd_cmd->egress_port && HCLGE_DBG_MAC_TBL_E_PORT_B,
+			 mac_rd_cmd->egress_port & HCLGE_DBG_MAC_TBL_E_PORT);
+
+		dev_info(&hdev->pdev->dev, "%s", printf_buf);
+
+		if (mac_rd_cmd->entry_type == HCLGE_DBG_MAC_MC_TBL) {
+			mc_mac_tbl[mc_tbl_idx].index = i;
+			memcpy(mc_mac_tbl[mc_tbl_idx].mac_add,
+			       mac_rd_cmd->mac_add, 6);
+			memcpy(mc_mac_tbl[mc_tbl_idx].mg_vf_mb,
+			       desc[1].data, 24);
+			memcpy(&mc_mac_tbl[mc_tbl_idx].mg_vf_mb[24],
+			       desc[2].data, 8);
+			mc_tbl_idx++;
+		}
+	}
+
+	if (mc_tbl_idx > 0) {
+		dev_info(&hdev->pdev->dev,
+			 "Multicast tab: entry number = %u\n", mc_tbl_idx);
+		memset(printf_buf, 0, HCLGE_DBG_BUF_LEN);
+		strncat(printf_buf, "|index |mac_addr          |UM_MC_RDATA\n",
+			HCLGE_DBG_BUF_LEN);
+		dev_info(&hdev->pdev->dev, "%s", printf_buf);
+	}
+
+	for (i = 0; i < mc_tbl_idx; i++) {
+		memset(printf_buf, 0, HCLGE_DBG_BUF_LEN);
+		snprintf(printf_buf, HCLGE_DBG_BUF_LEN,
+			 "|%04u  |%02x:%02x:%02x:%02x:%02x:%02x |",
+			 mc_mac_tbl[i].index, mc_mac_tbl[i].mac_add[0],
+			 mc_mac_tbl[i].mac_add[1], mc_mac_tbl[i].mac_add[2],
+			 mc_mac_tbl[i].mac_add[3], mc_mac_tbl[i].mac_add[4],
+			 mc_mac_tbl[i].mac_add[5]);
+
+		for (j = 31; j >= 3; j -= 4)
+			snprintf(printf_buf + strlen(printf_buf),
+				 HCLGE_DBG_BUF_LEN - strlen(printf_buf),
+				 "%02x%02x%02x%02x:", mc_mac_tbl[i].mg_vf_mb[j],
+				 mc_mac_tbl[i].mg_vf_mb[j - 1],
+				 mc_mac_tbl[i].mg_vf_mb[j - 2],
+				 mc_mac_tbl[i].mg_vf_mb[j - 3]);
+
+		printf_buf[strlen(printf_buf) - 1] = '\n';
+		dev_info(&hdev->pdev->dev, "%s", printf_buf);
+	}
+
+	kfree(mc_mac_tbl);
+}
+
 static void hclge_dbg_fd_tcam_read(struct hclge_dev *hdev, u8 stage,
 				   bool sel_x, u32 loc)
 {
@@ -478,6 +601,8 @@ int hclge_dbg_run_cmd(struct hnae3_handle *handle, char *cmd_buf)
 		hclge_dbg_dump_qos_pri_map(hdev);
 	} else if (strncmp(cmd_buf, "dump qos buf cfg", 16) == 0) {
 		hclge_dbg_dump_qos_buf_cfg(hdev);
+	} else if (strncmp(cmd_buf, "dump mac tbl", 12) == 0) {
+		hclge_dbg_dump_mac_table(hdev);
 	} else {
 		dev_info(&hdev->pdev->dev, "unknown command\n");
 		return -EINVAL;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
index 50fd0b15fb8e..b5a784506b9a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
@@ -4,6 +4,16 @@
 #ifndef __HCLGE_DEBUGFS_H
 #define __HCLGE_DEBUGFS_H
 
+#define HCLGE_DBG_MAC_TBL_MAX	   4223
+#define HCLGE_DBG_BUF_LEN	   256
+#define HCLGE_DBG_MAC_MC_TBL	   2
+#define HCLGE_DBG_MAC_TBL_EN_TYPE  0x01
+#define HCLGE_DBG_MAC_TBL_MC_TYPE  0x02
+#define HCLGE_DBG_MAC_TBL_MAC_EN   0x01
+#define HCLGE_DBG_MAC_TBL_IN_PORT  0x07
+#define HCLGE_DBG_MAC_TBL_E_PORT   0x3FF
+#define HCLGE_DBG_MAC_TBL_E_PORT_B BIT(11)
+
 #pragma pack(1)
 
 struct hclge_qos_pri_map_cmd {
@@ -19,5 +29,11 @@ struct hclge_qos_pri_map_cmd {
 	   rev	    : 4;
 };
 
+struct hclge_mac_vlan_idx_rd_mc {
+	u32 index;
+	u8  mac_add[8];
+	u8  mg_vf_mb[32];
+};
+
 #pragma pack()
 #endif
-- 
2.11.0


