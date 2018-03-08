Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934990AbeCHCfR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:35:17 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5758 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934900AbeCHCfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:35:03 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 15/23] {topost} net: hns3: refactor the get/put_vector function
Date: Thu, 8 Mar 2018 11:06:40 +0800
Message-ID: <1520478408-116992-16-git-send-email-lipeng321@huawei.com>
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

From: Yunsheng Lin <linyunsheng@huawei.com>

There is a get_vector function, which allocate the vectors
for a client, but there is not a put_vector to free the
vector.

This patch introduces the put_vector function in order to
fix the coalesce configuration lost problem during reset
process.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  3 +++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  4 ++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 28 ++++++++++++++++------
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 12 +++++++---
 4 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 3c653eb..70441d2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -265,6 +265,8 @@ struct hnae3_ae_dev {
  *   Get tc size of handle
  * get_vector()
  *   Get vector number and vector information
+ * put_vector()
+ *   Put the vector in hdev
  * map_ring_to_vector()
  *   Map rings to vector
  * unmap_ring_from_vector()
@@ -376,6 +378,7 @@ struct hnae3_ae_ops {
 
 	int (*get_vector)(struct hnae3_handle *handle, u16 vector_num,
 			  struct hnae3_vector_info *vector_info);
+	int (*put_vector)(struct hnae3_handle *handle, int vector_num);
 	int (*map_ring_to_vector)(struct hnae3_handle *handle,
 				  int vector_num,
 				  struct hnae3_ring_chain_node *vr_chain);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 2bed73e..fef65b9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2709,6 +2709,10 @@ static int hns3_nic_uninit_vector_data(struct hns3_nic_priv *priv)
 		if (ret)
 			return ret;
 
+		ret = h->ae_algo->ops->put_vector(h, tqp_vector->vector_irq);
+		if (ret)
+			return ret;
+
 		hns3_free_vector_ring_chain(tqp_vector, &vector_ring_chain);
 
 		if (priv->tqp_vector[i].irq_init_flag == HNS3_VECTOR_INITED) {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index c0f6939..323f95b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2969,6 +2969,24 @@ static int hclge_get_vector_index(struct hclge_dev *hdev, int vector)
 	return -EINVAL;
 }
 
+static int hclge_put_vector(struct hnae3_handle *handle, int vector)
+{
+	struct hclge_vport *vport = hclge_get_vport(handle);
+	struct hclge_dev *hdev = vport->back;
+	int vector_id;
+
+	vector_id = hclge_get_vector_index(hdev, vector);
+	if (vector_id < 0) {
+		dev_err(&hdev->pdev->dev,
+			"Get vector index fail. vector_id =%d\n", vector_id);
+		return vector_id;
+	}
+
+	hclge_free_vector(hdev, vector_id);
+
+	return 0;
+}
+
 static u32 hclge_get_rss_key_size(struct hnae3_handle *handle)
 {
 	return HCLGE_RSS_KEY_SIZE;
@@ -3523,18 +3541,13 @@ static int hclge_unmap_ring_frm_vector(struct hnae3_handle *handle,
 	}
 
 	ret = hclge_bind_ring_with_vector(vport, vector_id, false, ring_chain);
-	if (ret) {
+	if (ret)
 		dev_err(&handle->pdev->dev,
 			"Unmap ring from vector fail. vectorid=%d, ret =%d\n",
 			vector_id,
 			ret);
-		return ret;
-	}
-
-	/* Free this MSIX or MSI vector */
-	hclge_free_vector(hdev, vector_id);
 
-	return 0;
+	return ret;
 }
 
 int hclge_cmd_set_promisc_mode(struct hclge_dev *hdev,
@@ -5996,6 +6009,7 @@ static const struct hnae3_ae_ops hclge_ops = {
 	.map_ring_to_vector = hclge_map_ring_to_vector,
 	.unmap_ring_from_vector = hclge_unmap_ring_frm_vector,
 	.get_vector = hclge_get_vector,
+	.put_vector = hclge_put_vector,
 	.set_promisc_mode = hclge_set_promisc_mode,
 	.set_loopback = hclge_set_loopback,
 	.start = hclge_ae_start,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index eee5e20..6bce99a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -627,13 +627,18 @@ static int hclgevf_unmap_ring_from_vector(
 	}
 
 	ret = hclgevf_bind_ring_to_vector(handle, false, vector, ring_chain);
-	if (ret) {
+	if (ret)
 		dev_err(&handle->pdev->dev,
 			"Unmap ring from vector fail. vector=%d, ret =%d\n",
 			vector_id,
 			ret);
-		return ret;
-	}
+
+	return ret;
+}
+
+static int hclgevf_put_vector(struct hnae3_handle *handle, int vector)
+{
+	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
 
 	hclgevf_free_vector(hdev, vector);
 
@@ -1464,6 +1469,7 @@ static const struct hnae3_ae_ops hclgevf_ops = {
 	.map_ring_to_vector = hclgevf_map_ring_to_vector,
 	.unmap_ring_from_vector = hclgevf_unmap_ring_from_vector,
 	.get_vector = hclgevf_get_vector,
+	.put_vector = hclgevf_put_vector,
 	.reset_queue = hclgevf_reset_tqp,
 	.set_promisc_mode = hclgevf_set_promisc_mode,
 	.get_mac_addr = hclgevf_get_mac_addr,
-- 
2.9.3
