Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753741AbeEOSVj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:21:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7690 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751859AbeEOSVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:21:36 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next 07/10] net: hns3: Fixes the back pressure setting When sriov is enabled
Date: Tue, 15 May 2018 19:20:11 +0100
Message-ID: <20180515182014.42196-8-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180515182014.42196-1-salil.mehta@huawei.com>
References: <20180515182014.42196-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

When sriov is enabled, the Qset and tc mapping is not longer one
to one relation.

This patch fixes it by mapping all pf and vf's Qset to tc.

Fixes: 848440544b41 ("net: hns3: Add support of TX Scheduler & Shaper to HNS3 driver")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  | 45 +++++++++++++++++++---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  |  5 +++
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index c69ecab..262c125 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -500,7 +500,8 @@ static int hclge_tm_qs_schd_mode_cfg(struct hclge_dev *hdev, u16 qs_id, u8 mode)
 	return hclge_cmd_send(&hdev->hw, &desc, 1);
 }
 
-static int hclge_tm_qs_bp_cfg(struct hclge_dev *hdev, u8 tc)
+static int hclge_tm_qs_bp_cfg(struct hclge_dev *hdev, u8 tc, u8 grp_id,
+			      u32 bit_map)
 {
 	struct hclge_bp_to_qs_map_cmd *bp_to_qs_map_cmd;
 	struct hclge_desc desc;
@@ -511,9 +512,8 @@ static int hclge_tm_qs_bp_cfg(struct hclge_dev *hdev, u8 tc)
 	bp_to_qs_map_cmd = (struct hclge_bp_to_qs_map_cmd *)desc.data;
 
 	bp_to_qs_map_cmd->tc_id = tc;
-
-	/* Qset and tc is one by one mapping */
-	bp_to_qs_map_cmd->qs_bit_map = cpu_to_le32(1 << tc);
+	bp_to_qs_map_cmd->qs_group_id = grp_id;
+	bp_to_qs_map_cmd->qs_bit_map = cpu_to_le32(bit_map);
 
 	return hclge_cmd_send(&hdev->hw, &desc, 1);
 }
@@ -1167,6 +1167,41 @@ static int hclge_pfc_setup_hw(struct hclge_dev *hdev)
 				      hdev->tm_info.hw_pfc_map);
 }
 
+/* Each Tc has a 1024 queue sets to backpress, it divides to
+ * 32 group, each group contains 32 queue sets, which can be
+ * represented by u32 bitmap.
+ */
+static int hclge_bp_setup_hw(struct hclge_dev *hdev, u8 tc)
+{
+	struct hclge_vport *vport = hdev->vport;
+	u32 i, k, qs_bitmap;
+	int ret;
+
+	for (i = 0; i < HCLGE_BP_GRP_NUM; i++) {
+		qs_bitmap = 0;
+
+		for (k = 0; k < hdev->num_alloc_vport; k++) {
+			u16 qs_id = vport->qs_offset + tc;
+			u8 grp, sub_grp;
+
+			grp = hnae_get_field(qs_id, HCLGE_BP_GRP_ID_M,
+					     HCLGE_BP_GRP_ID_S);
+			sub_grp = hnae_get_field(qs_id, HCLGE_BP_SUB_GRP_ID_M,
+						 HCLGE_BP_SUB_GRP_ID_S);
+			if (i == grp)
+				qs_bitmap |= (1 << sub_grp);
+
+			vport++;
+		}
+
+		ret = hclge_tm_qs_bp_cfg(hdev, tc, i, qs_bitmap);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int hclge_mac_pause_setup_hw(struct hclge_dev *hdev)
 {
 	bool tx_en, rx_en;
@@ -1218,7 +1253,7 @@ int hclge_pause_setup_hw(struct hclge_dev *hdev)
 		dev_warn(&hdev->pdev->dev, "set pfc pause failed:%d\n", ret);
 
 	for (i = 0; i < hdev->tm_info.num_tc; i++) {
-		ret = hclge_tm_qs_bp_cfg(hdev, i);
+		ret = hclge_bp_setup_hw(hdev, i);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
index 2dbe177..c2b6e8a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
@@ -89,6 +89,11 @@ struct hclge_pg_shapping_cmd {
 	__le32 pg_shapping_para;
 };
 
+#define HCLGE_BP_GRP_NUM		32
+#define HCLGE_BP_SUB_GRP_ID_S		0
+#define HCLGE_BP_SUB_GRP_ID_M		GENMASK(4, 0)
+#define HCLGE_BP_GRP_ID_S		5
+#define HCLGE_BP_GRP_ID_M		GENMASK(9, 5)
 struct hclge_bp_to_qs_map_cmd {
 	u8 tc_id;
 	u8 rsvd[2];
-- 
2.7.4
