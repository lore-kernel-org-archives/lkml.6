Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935133AbeCHCnO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:43:14 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5748 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934784AbeCHCe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:34:59 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 12/23] {topost} net: hns3: fix for RSS configuration loss problem during reset
Date: Thu, 8 Mar 2018 11:06:37 +0800
Message-ID: <1520478408-116992-13-git-send-email-lipeng321@huawei.com>
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

RSS configuration will be set to default value by hclge_rss_init_hw
during reset, which causes the RSS configuration loss problem.

This patch fixes it by setting the default value in
hclge_rss_init_cfg function, which will not be called in the reset
process.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c |   2 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 107 ++++++++++-----------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |   1 +
 3 files changed, 56 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index c5270b5..955f0e3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -144,6 +144,8 @@ static int hclge_map_update(struct hnae3_handle *h)
 	if (ret)
 		return ret;
 
+	hclge_rss_indir_init_cfg(hdev);
+
 	return hclge_rss_init_hw(hdev);
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 0271960..1d69470 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3329,67 +3329,28 @@ static int hclge_get_tc_size(struct hnae3_handle *handle)
 
 int hclge_rss_init_hw(struct hclge_dev *hdev)
 {
-	const  u8 hfunc = HCLGE_RSS_HASH_ALGO_TOEPLITZ;
 	struct hclge_vport *vport = hdev->vport;
+	u8 *rss_indir = vport[0].rss_indirection_tbl;
+	u16 rss_size = vport[0].alloc_rss_size;
+	u8 *key = vport[0].rss_hash_key;
+	u8 hfunc = vport[0].rss_algo;
 	u16 tc_offset[HCLGE_MAX_TC_NUM];
-	u8 rss_key[HCLGE_RSS_KEY_SIZE];
 	u16 tc_valid[HCLGE_MAX_TC_NUM];
 	u16 tc_size[HCLGE_MAX_TC_NUM];
-	u32 *rss_indir = NULL;
-	u16 rss_size = 0, roundup_size;
-	const u8 *key;
-	int i, ret, j;
-
-	rss_indir = kcalloc(HCLGE_RSS_IND_TBL_SIZE, sizeof(u32), GFP_KERNEL);
-	if (!rss_indir)
-		return -ENOMEM;
-
-	/* Get default RSS key */
-	netdev_rss_key_fill(rss_key, HCLGE_RSS_KEY_SIZE);
-
-	/* Initialize RSS indirect table for each vport */
-	for (j = 0; j < hdev->num_vmdq_vport + 1; j++) {
-		vport[j].rss_tuple_sets.ipv4_tcp_en =
-			HCLGE_RSS_INPUT_TUPLE_OTHER;
-		vport[j].rss_tuple_sets.ipv4_udp_en =
-			HCLGE_RSS_INPUT_TUPLE_OTHER;
-		vport[j].rss_tuple_sets.ipv4_sctp_en =
-			HCLGE_RSS_INPUT_TUPLE_SCTP;
-		vport[j].rss_tuple_sets.ipv4_fragment_en =
-			HCLGE_RSS_INPUT_TUPLE_OTHER;
-		vport[j].rss_tuple_sets.ipv6_tcp_en =
-			HCLGE_RSS_INPUT_TUPLE_OTHER;
-		vport[j].rss_tuple_sets.ipv6_udp_en =
-			HCLGE_RSS_INPUT_TUPLE_OTHER;
-		vport[j].rss_tuple_sets.ipv6_sctp_en =
-			HCLGE_RSS_INPUT_TUPLE_SCTP;
-		vport[j].rss_tuple_sets.ipv6_fragment_en =
-			HCLGE_RSS_INPUT_TUPLE_OTHER;
-
-		for (i = 0; i < HCLGE_RSS_IND_TBL_SIZE; i++) {
-			vport[j].rss_indirection_tbl[i] =
-				i % vport[j].alloc_rss_size;
-
-			/* vport 0 is for PF */
-			if (j != 0)
-				continue;
+	u16 roundup_size;
+	int i, ret;
 
-			rss_size = vport[j].alloc_rss_size;
-			rss_indir[i] = vport[j].rss_indirection_tbl[i];
-		}
-	}
 	ret = hclge_set_rss_indir_table(hdev, rss_indir);
 	if (ret)
-		goto err;
+		return ret;
 
-	key = rss_key;
 	ret = hclge_set_rss_algo_key(hdev, hfunc, key);
 	if (ret)
-		goto err;
+		return ret;
 
 	ret = hclge_set_rss_input_tuple(hdev);
 	if (ret)
-		goto err;
+		return ret;
 
 	/* Each TC have the same queue size, and tc_size set to hardware is
 	 * the log2 of roundup power of two of rss_size, the acutal queue
@@ -3399,8 +3360,7 @@ int hclge_rss_init_hw(struct hclge_dev *hdev)
 		dev_err(&hdev->pdev->dev,
 			"Configure rss tc size failed, invalid TC_SIZE = %d\n",
 			rss_size);
-		ret = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
 	roundup_size = roundup_pow_of_two(rss_size);
@@ -3417,12 +3377,50 @@ int hclge_rss_init_hw(struct hclge_dev *hdev)
 		tc_offset[i] = rss_size * i;
 	}
 
-	ret = hclge_set_rss_tc_mode(hdev, tc_valid, tc_size, tc_offset);
+	return hclge_set_rss_tc_mode(hdev, tc_valid, tc_size, tc_offset);
+}
 
-err:
-	kfree(rss_indir);
+void hclge_rss_indir_init_cfg(struct hclge_dev *hdev)
+{
+	struct hclge_vport *vport = hdev->vport;
+	int i, j;
 
-	return ret;
+	for (j = 0; j < hdev->num_vmdq_vport + 1; j++) {
+		for (i = 0; i < HCLGE_RSS_IND_TBL_SIZE; i++)
+			vport[j].rss_indirection_tbl[i] =
+				i % vport[j].alloc_rss_size;
+	}
+}
+
+static void hclge_rss_init_cfg(struct hclge_dev *hdev)
+{
+	struct hclge_vport *vport = hdev->vport;
+	int i;
+
+	netdev_rss_key_fill(vport->rss_hash_key, HCLGE_RSS_KEY_SIZE);
+
+	for (i = 0; i < hdev->num_vmdq_vport + 1; i++) {
+		vport[i].rss_tuple_sets.ipv4_tcp_en =
+			HCLGE_RSS_INPUT_TUPLE_OTHER;
+		vport[i].rss_tuple_sets.ipv4_udp_en =
+			HCLGE_RSS_INPUT_TUPLE_OTHER;
+		vport[i].rss_tuple_sets.ipv4_sctp_en =
+			HCLGE_RSS_INPUT_TUPLE_SCTP;
+		vport[i].rss_tuple_sets.ipv4_fragment_en =
+			HCLGE_RSS_INPUT_TUPLE_OTHER;
+		vport[i].rss_tuple_sets.ipv6_tcp_en =
+			HCLGE_RSS_INPUT_TUPLE_OTHER;
+		vport[i].rss_tuple_sets.ipv6_udp_en =
+			HCLGE_RSS_INPUT_TUPLE_OTHER;
+		vport[i].rss_tuple_sets.ipv6_sctp_en =
+			HCLGE_RSS_INPUT_TUPLE_SCTP;
+		vport[i].rss_tuple_sets.ipv6_fragment_en =
+			HCLGE_RSS_INPUT_TUPLE_OTHER;
+
+		vport[i].rss_algo = HCLGE_RSS_HASH_ALGO_TOEPLITZ;
+	}
+
+	hclge_rss_indir_init_cfg(hdev);
 }
 
 int hclge_bind_ring_with_vector(struct hclge_vport *vport,
@@ -5392,6 +5390,7 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 		return ret;
 	}
 
+	hclge_rss_init_cfg(hdev);
 	ret = hclge_rss_init_hw(hdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Rss init fail, ret =%d\n", ret);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 13d3999..7bff6ef 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -642,6 +642,7 @@ int hclge_set_vf_vlan_common(struct hclge_dev *vport, int vfid,
 
 int hclge_buffer_alloc(struct hclge_dev *hdev);
 int hclge_rss_init_hw(struct hclge_dev *hdev);
+void hclge_rss_indir_init_cfg(struct hclge_dev *hdev);
 
 void hclge_mbx_handler(struct hclge_dev *hdev);
 void hclge_reset_tqp(struct hnae3_handle *handle, u16 queue_id);
-- 
2.9.3
