Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934945AbeCHCfF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:35:05 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5743 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934612AbeCHCe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:34:58 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 09/23] {topost} net: hns3: add support for querying pfc puase packets statistic
Date: Thu, 8 Mar 2018 11:06:34 +0800
Message-ID: <1520478408-116992-10-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520478408-116992-1-git-send-email-lipeng321@huawei.com>
References: <1520478408-116992-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for querying pfc puase packets statistic
in hclge_ieee_getpfc, which is used to tell user how many pfc
puase packets have been sent and received by this mac port.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c | 14 ++++++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  | 53 ++++++++++++++++++++++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  |  6 +++
 3 files changed, 73 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index 5018d66..c5270b5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -203,9 +203,11 @@ static int hclge_ieee_setets(struct hnae3_handle *h, struct ieee_ets *ets)
 
 static int hclge_ieee_getpfc(struct hnae3_handle *h, struct ieee_pfc *pfc)
 {
+	u64 requests[HNAE3_MAX_TC], indications[HNAE3_MAX_TC];
 	struct hclge_vport *vport = hclge_get_vport(h);
 	struct hclge_dev *hdev = vport->back;
 	u8 i, j, pfc_map, *prio_tc;
+	int ret;
 
 	memset(pfc, 0, sizeof(*pfc));
 	pfc->pfc_cap = hdev->pfc_max;
@@ -220,6 +222,18 @@ static int hclge_ieee_getpfc(struct hnae3_handle *h, struct ieee_pfc *pfc)
 		}
 	}
 
+	ret = hclge_pfc_tx_stats_get(hdev, requests);
+	if (ret)
+		return ret;
+
+	ret = hclge_pfc_rx_stats_get(hdev, indications);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < HCLGE_MAX_TC_NUM; i++) {
+		pfc->requests[i] = requests[i];
+		pfc->indications[i] = indications[i];
+	}
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index 4134a82..885f25c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -23,6 +23,9 @@ enum hclge_shaper_level {
 	HCLGE_SHAPER_LVL_PF	= 1,
 };
 
+#define HCLGE_TM_PFC_PKT_GET_CMD_NUM	3
+#define HCLGE_TM_PFC_NUM_GET_PER_CMD	3
+
 #define HCLGE_SHAPER_BS_U_DEF	5
 #define HCLGE_SHAPER_BS_S_DEF	20
 
@@ -112,6 +115,56 @@ static int hclge_shaper_para_calc(u32 ir, u8 shaper_level,
 	return 0;
 }
 
+static int hclge_pfc_stats_get(struct hclge_dev *hdev,
+			       enum hclge_opcode_type opcode, u64 *stats)
+{
+	struct hclge_desc desc[HCLGE_TM_PFC_PKT_GET_CMD_NUM];
+	int ret, i, j;
+
+	if (!(opcode == HCLGE_OPC_QUERY_PFC_RX_PKT_CNT ||
+	      opcode == HCLGE_OPC_QUERY_PFC_TX_PKT_CNT))
+		return -EINVAL;
+
+	for (i = 0; i < HCLGE_TM_PFC_PKT_GET_CMD_NUM; i++) {
+		hclge_cmd_setup_basic_desc(&desc[i], opcode, true);
+		if (i != (HCLGE_TM_PFC_PKT_GET_CMD_NUM - 1))
+			desc[i].flag |= cpu_to_le16(HCLGE_CMD_FLAG_NEXT);
+		else
+			desc[i].flag &= ~cpu_to_le16(HCLGE_CMD_FLAG_NEXT);
+	}
+
+	ret = hclge_cmd_send(&hdev->hw, desc, HCLGE_TM_PFC_PKT_GET_CMD_NUM);
+	if (ret) {
+		dev_err(&hdev->pdev->dev,
+			"Get pfc pause stats fail, ret = %d.\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < HCLGE_TM_PFC_PKT_GET_CMD_NUM; i++) {
+		struct hclge_pfc_stats_cmd *pfc_stats =
+				(struct hclge_pfc_stats_cmd *)desc[i].data;
+
+		for (j = 0; j < HCLGE_TM_PFC_NUM_GET_PER_CMD; j++) {
+			u32 index = i * HCLGE_TM_PFC_PKT_GET_CMD_NUM + j;
+
+			if (index < HCLGE_MAX_TC_NUM)
+				stats[index] =
+					le64_to_cpu(pfc_stats->pkt_num[j]);
+		}
+	}
+	return 0;
+}
+
+int hclge_pfc_rx_stats_get(struct hclge_dev *hdev, u64 *stats)
+{
+	return hclge_pfc_stats_get(hdev, HCLGE_OPC_QUERY_PFC_RX_PKT_CNT, stats);
+}
+
+int hclge_pfc_tx_stats_get(struct hclge_dev *hdev, u64 *stats)
+{
+	return hclge_pfc_stats_get(hdev, HCLGE_OPC_QUERY_PFC_TX_PKT_CNT, stats);
+}
+
 int hclge_mac_pause_en_cfg(struct hclge_dev *hdev, bool tx, bool rx)
 {
 	struct hclge_desc desc;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
index c30c85b..2dbe177 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
@@ -109,6 +109,10 @@ struct hclge_cfg_pause_param_cmd {
 	__le16 pause_trans_time;
 };
 
+struct hclge_pfc_stats_cmd {
+	__le64 pkt_num[3];
+};
+
 struct hclge_port_shapping_cmd {
 	__le32 port_shapping_para;
 };
@@ -130,4 +134,6 @@ int hclge_tm_map_cfg(struct hclge_dev *hdev);
 int hclge_tm_init_hw(struct hclge_dev *hdev);
 int hclge_mac_pause_en_cfg(struct hclge_dev *hdev, bool tx, bool rx);
 int hclge_pause_addr_cfg(struct hclge_dev *hdev, const u8 *mac_addr);
+int hclge_pfc_rx_stats_get(struct hclge_dev *hdev, u64 *stats);
+int hclge_pfc_tx_stats_get(struct hclge_dev *hdev, u64 *stats);
 #endif
-- 
2.9.3
