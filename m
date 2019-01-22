Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD10C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2921421726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfAVXk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:40:29 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2291 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726207AbfAVXkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 18:40:15 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1539E6B6CAF9E1A9F65F;
        Wed, 23 Jan 2019 07:40:13 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.143.16) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Wed, 23 Jan 2019 07:40:03 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>, <eric.dumazet@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        liuzhongzhu <liuzhongzhu@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 11/12] net: hns3: add statistics for PFC frames and MAC control frames
Date:   Wed, 23 Jan 2019 07:39:37 +0800
Message-ID: <20190122233938.7188-12-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190122233938.7188-1-tanhuazhong@huawei.com>
References: <20190122233938.7188-1-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.143.16]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: liuzhongzhu <liuzhongzhu@huawei.com>

In the old firmware version, statistics acquisition of
PFC frames and MAC control frames is not supported.
Add command retrieves statistics for PFC frames and
MAC control frames from the firmware.

Signed-off-by: liuzhongzhu <liuzhongzhu@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../hisilicon/hns3/hns3pf/hclge_cmd.c         | 10 +-
 .../hisilicon/hns3/hns3pf/hclge_cmd.h         |  2 +
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 97 ++++++++++++++++++-
 .../hisilicon/hns3/hns3pf/hclge_main.h        |  7 ++
 4 files changed, 109 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
index b0ee070884eb..81dbe1b6abb0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -170,8 +170,12 @@ static bool hclge_is_special_opcode(u16 opcode)
 	/* these commands have several descriptors,
 	 * and use the first one to save opcode and return value
 	 */
-	u16 spec_opcode[3] = {HCLGE_OPC_STATS_64_BIT,
-		HCLGE_OPC_STATS_32_BIT, HCLGE_OPC_STATS_MAC};
+	u16 spec_opcode[] = {HCLGE_OPC_STATS_64_BIT,
+			     HCLGE_OPC_STATS_32_BIT,
+			     HCLGE_OPC_STATS_MAC,
+			     HCLGE_OPC_STATS_MAC_ALL,
+			     HCLGE_OPC_QUERY_32_BIT_REG,
+			     HCLGE_OPC_QUERY_64_BIT_REG};
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(spec_opcode); i++) {
@@ -259,6 +263,8 @@ int hclge_cmd_send(struct hclge_hw *hw, struct hclge_desc *desc, int num)
 
 			if (desc_ret == HCLGE_CMD_EXEC_SUCCESS)
 				retval = 0;
+			else if (desc_ret == HCLGE_CMD_NO_AUTH)
+				retval = -EPERM;
 			else if (desc_ret == HCLGE_CMD_NOT_SUPPORTED)
 				retval = -EOPNOTSUPP;
 			else
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 9f07279513b7..e26a25128693 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -82,6 +82,8 @@ enum hclge_opcode_type {
 	HCLGE_OPC_STATS_64_BIT		= 0x0030,
 	HCLGE_OPC_STATS_32_BIT		= 0x0031,
 	HCLGE_OPC_STATS_MAC		= 0x0032,
+	HCLGE_OPC_QUERY_MAC_REG_NUM	= 0x0033,
+	HCLGE_OPC_STATS_MAC_ALL		= 0x0034,
 
 	HCLGE_OPC_QUERY_REG_NUM		= 0x0040,
 	HCLGE_OPC_QUERY_32_BIT_REG	= 0x0041,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 6fb3144eb79d..64b1589e549f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -118,6 +118,12 @@ static const struct hclge_comm_stats_str g_mac_stats_string[] = {
 		HCLGE_MAC_STATS_FIELD_OFF(mac_tx_mac_pause_num)},
 	{"mac_rx_mac_pause_num",
 		HCLGE_MAC_STATS_FIELD_OFF(mac_rx_mac_pause_num)},
+	{"mac_tx_control_pkt_num",
+		HCLGE_MAC_STATS_FIELD_OFF(mac_tx_ctrl_pkt_num)},
+	{"mac_rx_control_pkt_num",
+		HCLGE_MAC_STATS_FIELD_OFF(mac_rx_ctrl_pkt_num)},
+	{"mac_tx_pfc_pkt_num",
+		HCLGE_MAC_STATS_FIELD_OFF(mac_tx_pfc_pause_pkt_num)},
 	{"mac_tx_pfc_pri0_pkt_num",
 		HCLGE_MAC_STATS_FIELD_OFF(mac_tx_pfc_pri0_pkt_num)},
 	{"mac_tx_pfc_pri1_pkt_num",
@@ -134,6 +140,8 @@ static const struct hclge_comm_stats_str g_mac_stats_string[] = {
 		HCLGE_MAC_STATS_FIELD_OFF(mac_tx_pfc_pri6_pkt_num)},
 	{"mac_tx_pfc_pri7_pkt_num",
 		HCLGE_MAC_STATS_FIELD_OFF(mac_tx_pfc_pri7_pkt_num)},
+	{"mac_rx_pfc_pkt_num",
+		HCLGE_MAC_STATS_FIELD_OFF(mac_rx_pfc_pause_pkt_num)},
 	{"mac_rx_pfc_pri0_pkt_num",
 		HCLGE_MAC_STATS_FIELD_OFF(mac_rx_pfc_pri0_pkt_num)},
 	{"mac_rx_pfc_pri1_pkt_num",
@@ -287,10 +295,9 @@ static const struct hclge_mac_mgr_tbl_entry_cmd hclge_mgr_table[] = {
 	},
 };
 
-static int hclge_mac_update_stats(struct hclge_dev *hdev)
+static int hclge_mac_update_stats_defective(struct hclge_dev *hdev)
 {
 #define HCLGE_MAC_CMD_NUM 21
-#define HCLGE_RTN_DATA_NUM 4
 
 	u64 *data = (u64 *)(&hdev->hw_stats.mac_stats);
 	struct hclge_desc desc[HCLGE_MAC_CMD_NUM];
@@ -308,22 +315,102 @@ static int hclge_mac_update_stats(struct hclge_dev *hdev)
 	}
 
 	for (i = 0; i < HCLGE_MAC_CMD_NUM; i++) {
+		/* for special opcode 0032, only the first desc has the head */
 		if (unlikely(i == 0)) {
 			desc_data = (__le64 *)(&desc[i].data[0]);
-			n = HCLGE_RTN_DATA_NUM - 2;
+			n = HCLGE_RD_FIRST_STATS_NUM;
 		} else {
 			desc_data = (__le64 *)(&desc[i]);
-			n = HCLGE_RTN_DATA_NUM;
+			n = HCLGE_RD_OTHER_STATS_NUM;
 		}
+
+		for (k = 0; k < n; k++) {
+			*data += le64_to_cpu(*desc_data);
+			data++;
+			desc_data++;
+		}
+	}
+
+	return 0;
+}
+
+static int hclge_mac_update_stats_complete(struct hclge_dev *hdev, u32 desc_num)
+{
+	u64 *data = (u64 *)(&hdev->hw_stats.mac_stats);
+	struct hclge_desc *desc;
+	__le64 *desc_data;
+	u16 i, k, n;
+	int ret;
+
+	desc = kcalloc(desc_num, sizeof(struct hclge_desc), GFP_KERNEL);
+	hclge_cmd_setup_basic_desc(&desc[0], HCLGE_OPC_STATS_MAC_ALL, true);
+	ret = hclge_cmd_send(&hdev->hw, desc, desc_num);
+	if (ret) {
+		kfree(desc);
+		return ret;
+	}
+
+	for (i = 0; i < desc_num; i++) {
+		/* for special opcode 0034, only the first desc has the head */
+		if (i == 0) {
+			desc_data = (__le64 *)(&desc[i].data[0]);
+			n = HCLGE_RD_FIRST_STATS_NUM;
+		} else {
+			desc_data = (__le64 *)(&desc[i]);
+			n = HCLGE_RD_OTHER_STATS_NUM;
+		}
+
 		for (k = 0; k < n; k++) {
-			*data++ += le64_to_cpu(*desc_data);
+			*data += le64_to_cpu(*desc_data);
+			data++;
 			desc_data++;
 		}
 	}
 
+	kfree(desc);
+
 	return 0;
 }
 
+static int hclge_mac_query_reg_num(struct hclge_dev *hdev, u32 *desc_num)
+{
+	struct hclge_desc desc;
+	__le32 *desc_data;
+	u32 reg_num;
+	int ret;
+
+	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_QUERY_MAC_REG_NUM, true);
+	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+	if (ret)
+		return ret;
+
+	desc_data = (__le32 *)(&desc.data[0]);
+	reg_num = le32_to_cpu(*desc_data);
+
+	*desc_num = 1 + ((reg_num - 3) >> 2) +
+		    (u32)(((reg_num - 3) & 0x3) ? 1 : 0);
+
+	return 0;
+}
+
+static int hclge_mac_update_stats(struct hclge_dev *hdev)
+{
+	u32 desc_num;
+	int ret;
+
+	ret = hclge_mac_query_reg_num(hdev, &desc_num);
+
+	/* The firmware supports the new statistics acquisition method */
+	if (!ret)
+		ret = hclge_mac_update_stats_complete(hdev, desc_num);
+	else if (ret == -EOPNOTSUPP)
+		ret = hclge_mac_update_stats_defective(hdev);
+	else
+		dev_err(&hdev->pdev->dev, "query mac reg num fail!\n");
+
+	return ret;
+}
+
 static int hclge_tqps_update_stats(struct hnae3_handle *handle)
 {
 	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 279ed2d83cb8..b5a38fc1af91 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -16,6 +16,9 @@
 
 #define HCLGE_MAX_PF_NUM		8
 
+#define HCLGE_RD_FIRST_STATS_NUM        2
+#define HCLGE_RD_OTHER_STATS_NUM        4
+
 #define HCLGE_INVALID_VPORT 0xffff
 
 #define HCLGE_PF_CFG_BLOCK_SIZE		32
@@ -415,6 +418,10 @@ struct hclge_mac_stats {
 	u64 mac_rx_fcs_err_pkt_num;
 	u64 mac_rx_send_app_good_pkt_num;
 	u64 mac_rx_send_app_bad_pkt_num;
+	u64 mac_tx_pfc_pause_pkt_num;
+	u64 mac_rx_pfc_pause_pkt_num;
+	u64 mac_tx_ctrl_pkt_num;
+	u64 mac_rx_ctrl_pkt_num;
 };
 
 #define HCLGE_STATS_TIMER_INTERVAL	(60 * 5)
-- 
2.20.1


