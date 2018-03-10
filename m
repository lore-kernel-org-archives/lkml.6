Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932696AbeCJC5g (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 21:57:36 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6220 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751347AbeCJC5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 21:57:35 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 04/12] net: hns3: unify the pause params setup function
Date: Sat, 10 Mar 2018 11:29:25 +0800
Message-ID: <1520652573-75644-5-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520652573-75644-1-git-send-email-lipeng321@huawei.com>
References: <1520652573-75644-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuyun Liang <liangfuyun1@huawei.com>

Since the firmware cmd to setup mac pause params is the same as the
firmware cmd to pfc pause params, this patch unifies the pause params
setup function.

Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  | 23 +++++++++++-----------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  |  2 +-
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index cc60407..ea33cc5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -4417,7 +4417,7 @@ static int hclge_set_mac_addr(struct hnae3_handle *handle, void *p,
 		return -EIO;
 	}
 
-	ret = hclge_mac_pause_addr_cfg(hdev, new_addr);
+	ret = hclge_pause_addr_cfg(hdev, new_addr);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"configure mac pause address fail, ret =%d.\n",
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index 36bd79a..4134a82 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -138,8 +138,8 @@ static int hclge_pfc_pause_en_cfg(struct hclge_dev *hdev, u8 tx_rx_bitmap,
 	return hclge_cmd_send(&hdev->hw, &desc, 1);
 }
 
-static int hclge_mac_pause_param_cfg(struct hclge_dev *hdev, const u8 *addr,
-				     u8 pause_trans_gap, u16 pause_trans_time)
+static int hclge_pause_param_cfg(struct hclge_dev *hdev, const u8 *addr,
+				 u8 pause_trans_gap, u16 pause_trans_time)
 {
 	struct hclge_cfg_pause_param_cmd *pause_param;
 	struct hclge_desc desc;
@@ -155,7 +155,7 @@ static int hclge_mac_pause_param_cfg(struct hclge_dev *hdev, const u8 *addr,
 	return hclge_cmd_send(&hdev->hw, &desc, 1);
 }
 
-int hclge_mac_pause_addr_cfg(struct hclge_dev *hdev, const u8 *mac_addr)
+int hclge_pause_addr_cfg(struct hclge_dev *hdev, const u8 *mac_addr)
 {
 	struct hclge_cfg_pause_param_cmd *pause_param;
 	struct hclge_desc desc;
@@ -174,7 +174,7 @@ int hclge_mac_pause_addr_cfg(struct hclge_dev *hdev, const u8 *mac_addr)
 	trans_gap = pause_param->pause_trans_gap;
 	trans_time = le16_to_cpu(pause_param->pause_trans_time);
 
-	return hclge_mac_pause_param_cfg(hdev, mac_addr, trans_gap,
+	return hclge_pause_param_cfg(hdev, mac_addr, trans_gap,
 					 trans_time);
 }
 
@@ -1096,11 +1096,11 @@ static int hclge_tm_schd_setup_hw(struct hclge_dev *hdev)
 	return hclge_tm_schd_mode_hw(hdev);
 }
 
-static int hclge_mac_pause_param_setup_hw(struct hclge_dev *hdev)
+static int hclge_pause_param_setup_hw(struct hclge_dev *hdev)
 {
 	struct hclge_mac *mac = &hdev->hw.mac;
 
-	return hclge_mac_pause_param_cfg(hdev, mac->mac_addr,
+	return hclge_pause_param_cfg(hdev, mac->mac_addr,
 					 HCLGE_DEFAULT_PAUSE_TRANS_GAP,
 					 HCLGE_DEFAULT_PAUSE_TRANS_TIME);
 }
@@ -1151,13 +1151,12 @@ int hclge_pause_setup_hw(struct hclge_dev *hdev)
 	int ret;
 	u8 i;
 
-	if (hdev->tm_info.fc_mode != HCLGE_FC_PFC) {
-		ret = hclge_mac_pause_setup_hw(hdev);
-		if (ret)
-			return ret;
+	ret = hclge_pause_param_setup_hw(hdev);
+	if (ret)
+		return ret;
 
-		return hclge_mac_pause_param_setup_hw(hdev);
-	}
+	if (hdev->tm_info.fc_mode != HCLGE_FC_PFC)
+		return hclge_mac_pause_setup_hw(hdev);
 
 	/* Only DCB-supported dev supports qset back pressure and pfc cmd */
 	if (!hnae3_dev_dcb_supported(hdev))
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
index 5401e75..c30c85b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
@@ -129,5 +129,5 @@ int hclge_tm_dwrr_cfg(struct hclge_dev *hdev);
 int hclge_tm_map_cfg(struct hclge_dev *hdev);
 int hclge_tm_init_hw(struct hclge_dev *hdev);
 int hclge_mac_pause_en_cfg(struct hclge_dev *hdev, bool tx, bool rx);
-int hclge_mac_pause_addr_cfg(struct hclge_dev *hdev, const u8 *mac_addr);
+int hclge_pause_addr_cfg(struct hclge_dev *hdev, const u8 *mac_addr);
 #endif
-- 
2.9.3
