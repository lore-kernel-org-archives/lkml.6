Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752001AbeCUHUL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 03:20:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6663 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751539AbeCUHSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 03:18:20 -0400
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 01/11] net: hns3: reallocate tx/rx buffer after changing mtu
Date: Wed, 21 Mar 2018 15:49:20 +0800
Message-ID: <1521618570-129694-2-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521618570-129694-1-git-send-email-lipeng321@huawei.com>
References: <1521618570-129694-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuyun Liang <liangfuyun1@huawei.com>

When changing the mtu, the max frame size also will be changed. The tx
buffer size and the rx buffer size to be allocated are determined by max
frame size. So when max frame size is changed, the tx buffer and rx buffer
need to be reallocated.

When the tc_num is changed, the tx buffer and rx buffer need to be
reallocated too. So calling set_mtu and buffer_alloc separately is better.

Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 36 +++++++++++++---------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index d70619b..e110c65 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -4772,11 +4772,9 @@ static int hclge_en_hw_strip_rxvtag(struct hnae3_handle *handle, bool enable)
 	return hclge_set_vlan_rx_offload_cfg(vport);
 }
 
-static int hclge_set_mtu(struct hnae3_handle *handle, int new_mtu)
+static int hclge_set_mac_mtu(struct hclge_dev *hdev, int new_mtu)
 {
-	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_config_max_frm_size_cmd *req;
-	struct hclge_dev *hdev = vport->back;
 	struct hclge_desc desc;
 	int max_frm_size;
 	int ret;
@@ -4805,6 +4803,27 @@ static int hclge_set_mtu(struct hnae3_handle *handle, int new_mtu)
 	return 0;
 }
 
+static int hclge_set_mtu(struct hnae3_handle *handle, int new_mtu)
+{
+	struct hclge_vport *vport = hclge_get_vport(handle);
+	struct hclge_dev *hdev = vport->back;
+	int ret;
+
+	ret = hclge_set_mac_mtu(hdev, new_mtu);
+	if (ret) {
+		dev_err(&hdev->pdev->dev,
+			"Change mtu fail, ret =%d\n", ret);
+		return ret;
+	}
+
+	ret = hclge_buffer_alloc(hdev);
+	if (ret)
+		dev_err(&hdev->pdev->dev,
+			"Allocate buffer fail, ret =%d\n", ret);
+
+	return ret;
+}
+
 static int hclge_send_reset_tqp_cmd(struct hclge_dev *hdev, u16 queue_id,
 				    bool enable)
 {
@@ -5392,11 +5411,6 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 		dev_err(&pdev->dev, "Mac init error, ret = %d\n", ret);
 		return ret;
 	}
-	ret = hclge_buffer_alloc(hdev);
-	if (ret) {
-		dev_err(&pdev->dev, "Buffer allocate fail, ret =%d\n", ret);
-		return  ret;
-	}
 
 	ret = hclge_config_tso(hdev, HCLGE_TSO_MSS_MIN, HCLGE_TSO_MSS_MAX);
 	if (ret) {
@@ -5503,12 +5517,6 @@ static int hclge_reset_ae_dev(struct hnae3_ae_dev *ae_dev)
 		return ret;
 	}
 
-	ret = hclge_buffer_alloc(hdev);
-	if (ret) {
-		dev_err(&pdev->dev, "Buffer allocate fail, ret =%d\n", ret);
-		return ret;
-	}
-
 	ret = hclge_config_tso(hdev, HCLGE_TSO_MSS_MIN, HCLGE_TSO_MSS_MAX);
 	if (ret) {
 		dev_err(&pdev->dev, "Enable tso fail, ret =%d\n", ret);
-- 
2.9.3
