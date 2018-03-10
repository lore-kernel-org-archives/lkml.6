Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932950AbeCJC5o (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 21:57:44 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6228 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751893AbeCJC5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 21:57:40 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 08/12] net: hns3: fix for buffer overflow smatch warning
Date: Sat, 10 Mar 2018 11:29:29 +0800
Message-ID: <1520652573-75644-9-git-send-email-lipeng321@huawei.com>
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

From: Yunsheng Lin <linyunsheng@huawei.com>

This patch fixes the buffer overflow warning by refactoring
hclgevf_bind_ring_to_vector and hclge_get_ring_chain_from_mbx.

Fixes: e2cb1dec9779 ("net: hns3: Add HNS3 VF HCL(Hardware Compatibility Layer) Support")
Fixes: dde1a86e93ca ("net: hns3: Add mailbox support to PF driver")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h    |  2 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c | 19 ++++---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 60 ++++++++++------------
 3 files changed, 39 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
index 3e9203e..e6e1d22 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
@@ -57,6 +57,8 @@ enum hclge_mbx_vlan_cfg_subcode {
 
 #define HCLGE_MBX_MAX_MSG_SIZE	16
 #define HCLGE_MBX_MAX_RESP_DATA_SIZE	8
+#define HCLGE_MBX_RING_MAP_BASIC_MSG_NUM	3
+#define HCLGE_MBX_RING_NODE_VARIABLE_NUM	3
 
 struct hclgevf_mbx_resp_status {
 	struct mutex mbx_mutex; /* protects against contending sync cmd resp */
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index ed34ca3..e3e4ded 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -105,14 +105,17 @@ static int hclge_get_ring_chain_from_mbx(
 			struct hnae3_ring_chain_node *ring_chain,
 			struct hclge_vport *vport)
 {
-#define HCLGE_RING_NODE_VARIABLE_NUM		3
-#define HCLGE_RING_MAP_MBX_BASIC_MSG_NUM	3
 	struct hnae3_ring_chain_node *cur_chain, *new_chain;
 	int ring_num;
 	int i;
 
 	ring_num = req->msg[2];
 
+	if (ring_num > ((HCLGE_MBX_VF_MSG_DATA_NUM -
+		HCLGE_MBX_RING_MAP_BASIC_MSG_NUM) /
+		HCLGE_MBX_RING_NODE_VARIABLE_NUM))
+		return -ENOMEM;
+
 	hnae_set_bit(ring_chain->flag, HNAE3_RING_TYPE_B, req->msg[3]);
 	ring_chain->tqp_index =
 			hclge_get_queue_id(vport->nic.kinfo.tqp[req->msg[4]]);
@@ -128,18 +131,18 @@ static int hclge_get_ring_chain_from_mbx(
 			goto err;
 
 		hnae_set_bit(new_chain->flag, HNAE3_RING_TYPE_B,
-			     req->msg[HCLGE_RING_NODE_VARIABLE_NUM * i +
-			     HCLGE_RING_MAP_MBX_BASIC_MSG_NUM]);
+			     req->msg[HCLGE_MBX_RING_NODE_VARIABLE_NUM * i +
+			     HCLGE_MBX_RING_MAP_BASIC_MSG_NUM]);
 
 		new_chain->tqp_index =
 		hclge_get_queue_id(vport->nic.kinfo.tqp
-			[req->msg[HCLGE_RING_NODE_VARIABLE_NUM * i +
-			HCLGE_RING_MAP_MBX_BASIC_MSG_NUM + 1]]);
+			[req->msg[HCLGE_MBX_RING_NODE_VARIABLE_NUM * i +
+			HCLGE_MBX_RING_MAP_BASIC_MSG_NUM + 1]]);
 
 		hnae_set_field(new_chain->int_gl_idx, HCLGE_INT_GL_IDX_M,
 			       HCLGE_INT_GL_IDX_S,
-			       req->msg[HCLGE_RING_NODE_VARIABLE_NUM * i +
-			       HCLGE_RING_MAP_MBX_BASIC_MSG_NUM + 2]);
+			       req->msg[HCLGE_MBX_RING_NODE_VARIABLE_NUM * i +
+			       HCLGE_MBX_RING_MAP_BASIC_MSG_NUM + 2]);
 
 		cur_chain->next = new_chain;
 		cur_chain = new_chain;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index c80a604..6c240d6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -533,13 +533,11 @@ static int hclgevf_bind_ring_to_vector(struct hnae3_handle *handle, bool en,
 				       int vector,
 				       struct hnae3_ring_chain_node *ring_chain)
 {
-#define HCLGEVF_RING_NODE_VARIABLE_NUM		3
-#define HCLGEVF_RING_MAP_MBX_BASIC_MSG_NUM	3
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
 	struct hnae3_ring_chain_node *node;
 	struct hclge_mbx_vf_to_pf_cmd *req;
 	struct hclgevf_desc desc;
-	int i, vector_id;
+	int i = 0, vector_id;
 	int status;
 	u8 type;
 
@@ -551,28 +549,33 @@ static int hclgevf_bind_ring_to_vector(struct hnae3_handle *handle, bool en,
 		return vector_id;
 	}
 
-	hclgevf_cmd_setup_basic_desc(&desc, HCLGEVF_OPC_MBX_VF_TO_PF, false);
-	type = en ?
-		HCLGE_MBX_MAP_RING_TO_VECTOR : HCLGE_MBX_UNMAP_RING_TO_VECTOR;
-	req->msg[0] = type;
-	req->msg[1] = vector_id; /* vector_id should be id in VF */
-
-	i = 0;
 	for (node = ring_chain; node; node = node->next) {
-		i++;
-		/* msg[2] is cause num */
-		req->msg[HCLGEVF_RING_NODE_VARIABLE_NUM * i] =
+		int idx_offset = HCLGE_MBX_RING_MAP_BASIC_MSG_NUM +
+					HCLGE_MBX_RING_NODE_VARIABLE_NUM * i;
+
+		if (i == 0) {
+			hclgevf_cmd_setup_basic_desc(&desc,
+						     HCLGEVF_OPC_MBX_VF_TO_PF,
+						     false);
+			type = en ?
+				HCLGE_MBX_MAP_RING_TO_VECTOR :
+				HCLGE_MBX_UNMAP_RING_TO_VECTOR;
+			req->msg[0] = type;
+			req->msg[1] = vector_id;
+		}
+
+		req->msg[idx_offset] =
 				hnae_get_bit(node->flag, HNAE3_RING_TYPE_B);
-		req->msg[HCLGEVF_RING_NODE_VARIABLE_NUM * i + 1] =
-				node->tqp_index;
-		req->msg[HCLGEVF_RING_NODE_VARIABLE_NUM * i + 2] =
-				hnae_get_field(node->int_gl_idx,
-					       HNAE3_RING_GL_IDX_M,
-					       HNAE3_RING_GL_IDX_S);
-
-		if (i == (HCLGE_MBX_VF_MSG_DATA_NUM -
-		    HCLGEVF_RING_MAP_MBX_BASIC_MSG_NUM) /
-		    HCLGEVF_RING_NODE_VARIABLE_NUM) {
+		req->msg[idx_offset + 1] = node->tqp_index;
+		req->msg[idx_offset + 2] = hnae_get_field(node->int_gl_idx,
+							  HNAE3_RING_GL_IDX_M,
+							  HNAE3_RING_GL_IDX_S);
+
+		i++;
+		if ((i == (HCLGE_MBX_VF_MSG_DATA_NUM -
+		     HCLGE_MBX_RING_MAP_BASIC_MSG_NUM) /
+		     HCLGE_MBX_RING_NODE_VARIABLE_NUM) ||
+		    !node->next) {
 			req->msg[2] = i;
 
 			status = hclgevf_cmd_send(&hdev->hw, &desc, 1);
@@ -591,17 +594,6 @@ static int hclgevf_bind_ring_to_vector(struct hnae3_handle *handle, bool en,
 		}
 	}
 
-	if (i > 0) {
-		req->msg[2] = i;
-
-		status = hclgevf_cmd_send(&hdev->hw, &desc, 1);
-		if (status) {
-			dev_err(&hdev->pdev->dev,
-				"Map TQP fail, status is %d.\n", status);
-			return status;
-		}
-	}
-
 	return 0;
 }
 
-- 
2.9.3
