Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965555AbeEIQ0V (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 12:26:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42819 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S965532AbeEIQ0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 12:26:17 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next 4/4] net: hns3: refactor the loopback related function
Date: Wed, 9 May 2018 17:24:41 +0100
Message-ID: <20180509162441.18068-5-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180509162441.18068-1-salil.mehta@huawei.com>
References: <20180509162441.18068-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

This patch refactors the loopback related function in order
to support the serdes loopback.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 21 +++----
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 68 +++++++++++-----------
 2 files changed, 42 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index eb3c34f..c16bb6c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -74,7 +74,7 @@ struct hns3_link_mode_mapping {
 	u32 ethtool_link_mode;
 };
 
-static int hns3_lp_setup(struct net_device *ndev, enum hnae3_loop loop)
+static int hns3_lp_setup(struct net_device *ndev, enum hnae3_loop loop, bool en)
 {
 	struct hnae3_handle *h = hns3_get_handle(ndev);
 	int ret;
@@ -85,11 +85,7 @@ static int hns3_lp_setup(struct net_device *ndev, enum hnae3_loop loop)
 
 	switch (loop) {
 	case HNAE3_MAC_INTER_LOOP_MAC:
-		ret = h->ae_algo->ops->set_loopback(h, loop, true);
-		break;
-	case HNAE3_MAC_LOOP_NONE:
-		ret = h->ae_algo->ops->set_loopback(h,
-			HNAE3_MAC_INTER_LOOP_MAC, false);
+		ret = h->ae_algo->ops->set_loopback(h, loop, en);
 		break;
 	default:
 		ret = -ENOTSUPP;
@@ -99,10 +95,7 @@ static int hns3_lp_setup(struct net_device *ndev, enum hnae3_loop loop)
 	if (ret)
 		return ret;
 
-	if (loop == HNAE3_MAC_LOOP_NONE)
-		h->ae_algo->ops->set_promisc_mode(h, ndev->flags & IFF_PROMISC);
-	else
-		h->ae_algo->ops->set_promisc_mode(h, 1);
+	h->ae_algo->ops->set_promisc_mode(h, en);
 
 	return ret;
 }
@@ -122,13 +115,13 @@ static int hns3_lp_up(struct net_device *ndev, enum hnae3_loop loop_mode)
 		return ret;
 	}
 
-	ret = hns3_lp_setup(ndev, loop_mode);
+	ret = hns3_lp_setup(ndev, loop_mode, true);
 	usleep_range(10000, 20000);
 
 	return ret;
 }
 
-static int hns3_lp_down(struct net_device *ndev)
+static int hns3_lp_down(struct net_device *ndev, enum hnae3_loop loop_mode)
 {
 	struct hnae3_handle *h = hns3_get_handle(ndev);
 	int ret;
@@ -136,7 +129,7 @@ static int hns3_lp_down(struct net_device *ndev)
 	if (!h->ae_algo->ops->stop)
 		return -EOPNOTSUPP;
 
-	ret = hns3_lp_setup(ndev, HNAE3_MAC_LOOP_NONE);
+	ret = hns3_lp_setup(ndev, loop_mode, false);
 	if (ret) {
 		netdev_err(ndev, "lb_setup return error: %d\n", ret);
 		return ret;
@@ -332,7 +325,7 @@ static void hns3_self_test(struct net_device *ndev,
 		data[test_index] = hns3_lp_up(ndev, loop_type);
 		if (!data[test_index]) {
 			data[test_index] = hns3_lp_run_test(ndev, loop_type);
-			hns3_lp_down(ndev);
+			hns3_lp_down(ndev, loop_type);
 		}
 
 		if (data[test_index])
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 084b904..316ec842 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3682,48 +3682,50 @@ static void hclge_cfg_mac_mode(struct hclge_dev *hdev, bool enable)
 			"mac enable fail, ret =%d.\n", ret);
 }
 
-static int hclge_set_loopback(struct hnae3_handle *handle,
-			      enum hnae3_loop loop_mode, bool en)
+static int hclge_set_mac_loopback(struct hclge_dev *hdev, bool en)
 {
-	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_config_mac_mode_cmd *req;
-	struct hclge_dev *hdev = vport->back;
 	struct hclge_desc desc;
 	u32 loop_en;
 	int ret;
 
-	switch (loop_mode) {
-	case HNAE3_MAC_INTER_LOOP_MAC:
-		req = (struct hclge_config_mac_mode_cmd *)&desc.data[0];
-		/* 1 Read out the MAC mode config at first */
-		hclge_cmd_setup_basic_desc(&desc,
-					   HCLGE_OPC_CONFIG_MAC_MODE,
-					   true);
-		ret = hclge_cmd_send(&hdev->hw, &desc, 1);
-		if (ret) {
-			dev_err(&hdev->pdev->dev,
-				"mac loopback get fail, ret =%d.\n",
-				ret);
-			return ret;
-		}
+	req = (struct hclge_config_mac_mode_cmd *)&desc.data[0];
+	/* 1 Read out the MAC mode config at first */
+	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_CONFIG_MAC_MODE, true);
+	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+	if (ret) {
+		dev_err(&hdev->pdev->dev,
+			"mac loopback get fail, ret =%d.\n", ret);
+		return ret;
+	}
 
-		/* 2 Then setup the loopback flag */
-		loop_en = le32_to_cpu(req->txrx_pad_fcs_loop_en);
-		if (en)
-			hnae_set_bit(loop_en, HCLGE_MAC_APP_LP_B, 1);
-		else
-			hnae_set_bit(loop_en, HCLGE_MAC_APP_LP_B, 0);
+	/* 2 Then setup the loopback flag */
+	loop_en = le32_to_cpu(req->txrx_pad_fcs_loop_en);
+	hnae_set_bit(loop_en, HCLGE_MAC_APP_LP_B, en ? 1 : 0);
 
-		req->txrx_pad_fcs_loop_en = cpu_to_le32(loop_en);
+	req->txrx_pad_fcs_loop_en = cpu_to_le32(loop_en);
 
-		/* 3 Config mac work mode with loopback flag
-		 * and its original configure parameters
-		 */
-		hclge_cmd_reuse_desc(&desc, false);
-		ret = hclge_cmd_send(&hdev->hw, &desc, 1);
-		if (ret)
-			dev_err(&hdev->pdev->dev,
-				"mac loopback set fail, ret =%d.\n", ret);
+	/* 3 Config mac work mode with loopback flag
+	 * and its original configure parameters
+	 */
+	hclge_cmd_reuse_desc(&desc, false);
+	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+	if (ret)
+		dev_err(&hdev->pdev->dev,
+			"mac loopback set fail, ret =%d.\n", ret);
+	return ret;
+}
+
+static int hclge_set_loopback(struct hnae3_handle *handle,
+			      enum hnae3_loop loop_mode, bool en)
+{
+	struct hclge_vport *vport = hclge_get_vport(handle);
+	struct hclge_dev *hdev = vport->back;
+	int ret;
+
+	switch (loop_mode) {
+	case HNAE3_MAC_INTER_LOOP_MAC:
+		ret = hclge_set_mac_loopback(hdev, en);
 		break;
 	default:
 		ret = -ENOTSUPP;
-- 
2.7.4
