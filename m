Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeCICHh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 21:07:37 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38063 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751008AbeCICFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 21:05:04 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 1/9] net: hns3: refactor the hclge_get/set_rss function
Date: Fri, 9 Mar 2018 10:36:56 +0800
Message-ID: <1520563024-94811-2-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520563024-94811-1-git-send-email-lipeng321@huawei.com>
References: <1520563024-94811-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

This patch refactors the hclge_get/set_rss function in
order to fix the rss configuration loss problem during
reset process.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 39 ++++------------------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  2 ++
 2 files changed, 9 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 39bc0e6..cd5b040 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2979,31 +2979,6 @@ static u32 hclge_get_rss_indir_size(struct hnae3_handle *handle)
 	return HCLGE_RSS_IND_TBL_SIZE;
 }
 
-static int hclge_get_rss_algo(struct hclge_dev *hdev)
-{
-	struct hclge_rss_config_cmd *req;
-	struct hclge_desc desc;
-	int rss_hash_algo;
-	int ret;
-
-	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_RSS_GENERIC_CONFIG, true);
-
-	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
-	if (ret) {
-		dev_err(&hdev->pdev->dev,
-			"Get link status error, status =%d\n", ret);
-		return ret;
-	}
-
-	req = (struct hclge_rss_config_cmd *)desc.data;
-	rss_hash_algo = (req->hash_config & HCLGE_RSS_HASH_ALGO_MASK);
-
-	if (rss_hash_algo == HCLGE_RSS_HASH_ALGO_TOEPLITZ)
-		return ETH_RSS_HASH_TOP;
-
-	return -EINVAL;
-}
-
 static int hclge_set_rss_algo_key(struct hclge_dev *hdev,
 				  const u8 hfunc, const u8 *key)
 {
@@ -3042,7 +3017,7 @@ static int hclge_set_rss_algo_key(struct hclge_dev *hdev,
 	return 0;
 }
 
-static int hclge_set_rss_indir_table(struct hclge_dev *hdev, const u32 *indir)
+static int hclge_set_rss_indir_table(struct hclge_dev *hdev, const u8 *indir)
 {
 	struct hclge_rss_indirection_table_cmd *req;
 	struct hclge_desc desc;
@@ -3138,12 +3113,11 @@ static int hclge_get_rss(struct hnae3_handle *handle, u32 *indir,
 			 u8 *key, u8 *hfunc)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
-	struct hclge_dev *hdev = vport->back;
 	int i;
 
 	/* Get hash algorithm */
 	if (hfunc)
-		*hfunc = hclge_get_rss_algo(hdev);
+		*hfunc = vport->rss_algo;
 
 	/* Get the RSS Key required by the user */
 	if (key)
@@ -3167,8 +3141,6 @@ static int hclge_set_rss(struct hnae3_handle *handle, const u32 *indir,
 
 	/* Set the RSS Hash Key if specififed by the user */
 	if (key) {
-		/* Update the shadow RSS key with user specified qids */
-		memcpy(vport->rss_hash_key, key, HCLGE_RSS_KEY_SIZE);
 
 		if (hfunc == ETH_RSS_HASH_TOP ||
 		    hfunc == ETH_RSS_HASH_NO_CHANGE)
@@ -3178,6 +3150,10 @@ static int hclge_set_rss(struct hnae3_handle *handle, const u32 *indir,
 		ret = hclge_set_rss_algo_key(hdev, hash_algo, key);
 		if (ret)
 			return ret;
+
+		/* Update the shadow RSS key with user specified qids */
+		memcpy(vport->rss_hash_key, key, HCLGE_RSS_KEY_SIZE);
+		vport->rss_algo = hash_algo;
 	}
 
 	/* Update the shadow RSS table with user specified qids */
@@ -3185,8 +3161,7 @@ static int hclge_set_rss(struct hnae3_handle *handle, const u32 *indir,
 		vport->rss_indirection_tbl[i] = indir[i];
 
 	/* Update the hardware */
-	ret = hclge_set_rss_indir_table(hdev, indir);
-	return ret;
+	return hclge_set_rss_indir_table(hdev, vport->rss_indirection_tbl);
 }
 
 static u8 hclge_get_rss_hash_bits(struct ethtool_rxnfc *nfc)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index d99a76a..7e762c4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -579,6 +579,8 @@ struct hclge_vport {
 	u8  rss_hash_key[HCLGE_RSS_KEY_SIZE]; /* User configured hash keys */
 	/* User configured lookup table entries */
 	u8  rss_indirection_tbl[HCLGE_RSS_IND_TBL_SIZE];
+	int rss_algo;		/* User configured hash algorithm */
+
 	u16 alloc_rss_size;
 
 	u16 qs_offset;
-- 
2.9.3
