Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D91C10F07
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9919F206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfBWJYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 04:24:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4271 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727692AbfBWJXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 04:23:12 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 99EF51CB9A3163166F42;
        Sat, 23 Feb 2019 17:23:07 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Sat, 23 Feb 2019 17:23:01 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "Huazhong Tan" <tanhuazhong@huawei.com>
Subject: [Patch net-next 10/12] net: hns3: fix get VF RSS issue
Date:   Sat, 23 Feb 2019 17:22:17 +0800
Message-ID: <1550913739-13232-11-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550913739-13232-1-git-send-email-tanhuazhong@huawei.com>
References: <1550913739-13232-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

For revision 0x20, VF shares the same RSS config with PF.
In original codes, it always return 0 when query RSS hash
key for VF. This patch fixes it by return the hash key
got from PF.

Fixes: 374ad291762a ("net: hns3: net: hns3: Add RSS general configuration support for VF")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c | 25 +++++++++++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 50 +++++++++++++++++++++-
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index ca056b3..306a23e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -490,6 +490,24 @@ static int hclge_get_queue_id_in_pf(struct hclge_vport *vport,
 	return hclge_gen_resp_to_vf(vport, mbx_req, 0, resp_data, 2);
 }
 
+static int hclge_get_rss_key(struct hclge_vport *vport,
+			     struct hclge_mbx_vf_to_pf_cmd *mbx_req)
+{
+#define HCLGE_RSS_MBX_RESP_LEN	8
+	u8 resp_data[HCLGE_RSS_MBX_RESP_LEN];
+	struct hclge_dev *hdev = vport->back;
+	u8 index;
+
+	index = mbx_req->msg[2];
+
+	memcpy(&resp_data[0],
+	       &hdev->vport[0].rss_hash_key[index * HCLGE_RSS_MBX_RESP_LEN],
+	       HCLGE_RSS_MBX_RESP_LEN);
+
+	return hclge_gen_resp_to_vf(vport, mbx_req, 0, resp_data,
+				    HCLGE_RSS_MBX_RESP_LEN);
+}
+
 static bool hclge_cmd_crq_empty(struct hclge_hw *hw)
 {
 	u32 tail = hclge_read_dev(hw, HCLGE_NIC_CRQ_TAIL_REG);
@@ -625,6 +643,13 @@ void hclge_mbx_handler(struct hclge_dev *hdev)
 					"PF failed(%d) to get qid for VF\n",
 					ret);
 			break;
+		case HCLGE_MBX_GET_RSS_KEY:
+			ret = hclge_get_rss_key(vport, req);
+			if (ret)
+				dev_err(&hdev->pdev->dev,
+					"PF fail(%d) to get rss key for VF\n",
+					ret);
+			break;
 		case HCLGE_MBX_GET_LINK_MODE:
 			hclge_get_link_mode(vport, req);
 			break;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 12f16b9..8bc28e6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -620,12 +620,50 @@ static int hclgevf_set_rss_tc_mode(struct hclgevf_dev *hdev,  u16 rss_size)
 	return status;
 }
 
+/* for revision 0x20, vf shared the same rss config with pf */
+static int hclgevf_get_rss_hash_key(struct hclgevf_dev *hdev)
+{
+#define HCLGEVF_RSS_MBX_RESP_LEN	8
+
+	struct hclgevf_rss_cfg *rss_cfg = &hdev->rss_cfg;
+	u8 resp_msg[HCLGEVF_RSS_MBX_RESP_LEN];
+	u16 msg_num, hash_key_index;
+	u8 index;
+	int ret;
+
+	msg_num = (HCLGEVF_RSS_KEY_SIZE + HCLGEVF_RSS_MBX_RESP_LEN - 1) /
+			HCLGEVF_RSS_MBX_RESP_LEN;
+	for (index = 0; index < msg_num; index++) {
+		ret = hclgevf_send_mbx_msg(hdev, HCLGE_MBX_GET_RSS_KEY, 0,
+					   &index, sizeof(index),
+					   true, resp_msg,
+					   HCLGEVF_RSS_MBX_RESP_LEN);
+		if (ret) {
+			dev_err(&hdev->pdev->dev,
+				"VF get rss hash key from PF failed, ret=%d",
+				ret);
+			return ret;
+		}
+
+		hash_key_index = HCLGEVF_RSS_MBX_RESP_LEN * index;
+		if (index == msg_num - 1)
+			memcpy(&rss_cfg->rss_hash_key[hash_key_index],
+			       &resp_msg[0],
+			       HCLGEVF_RSS_KEY_SIZE - hash_key_index);
+		else
+			memcpy(&rss_cfg->rss_hash_key[hash_key_index],
+			       &resp_msg[0], HCLGEVF_RSS_MBX_RESP_LEN);
+	}
+
+	return 0;
+}
+
 static int hclgevf_get_rss(struct hnae3_handle *handle, u32 *indir, u8 *key,
 			   u8 *hfunc)
 {
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
 	struct hclgevf_rss_cfg *rss_cfg = &hdev->rss_cfg;
-	int i;
+	int i, ret;
 
 	if (handle->pdev->revision >= 0x21) {
 		/* Get hash algorithm */
@@ -647,6 +685,16 @@ static int hclgevf_get_rss(struct hnae3_handle *handle, u32 *indir, u8 *key,
 		if (key)
 			memcpy(key, rss_cfg->rss_hash_key,
 			       HCLGEVF_RSS_KEY_SIZE);
+	} else {
+		if (hfunc)
+			*hfunc = ETH_RSS_HASH_TOP;
+		if (key) {
+			ret = hclgevf_get_rss_hash_key(hdev);
+			if (ret)
+				return ret;
+			memcpy(key, rss_cfg->rss_hash_key,
+			       HCLGEVF_RSS_KEY_SIZE);
+		}
 	}
 
 	if (indir)
-- 
2.7.4

