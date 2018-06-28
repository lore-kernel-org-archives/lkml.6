Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00685C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B851E25928
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B851E25928
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753344AbeF1DlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 23:41:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9179 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753199AbeF1DlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 23:41:14 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8B297641A989;
        Thu, 28 Jun 2018 11:40:58 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.382.0; Thu, 28 Jun 2018 11:40:52 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 01/11] net: hns3: remove hclge_get_vector_index from hclge_bind_ring_with_vector
Date:   Thu, 28 Jun 2018 12:12:19 +0800
Message-ID: <1530159149-122284-2-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530159149-122284-1-git-send-email-lipeng321@huawei.com>
References: <1530159149-122284-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In hclge_unmap_ring_frm_vector, there are 2 steps:
step 1: get vector index.
step 2 unbind ring with vector.

But it gets vector id again in step 2 interface. This patch
removes hclge_get_vector_index from hclge_bind_ring_with_vector,
and make the step the same with hns3 PF driver.

Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 24 +++++++++++++---------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index a17872a..b3d8237 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -547,24 +547,18 @@ static int hclgevf_get_tc_size(struct hnae3_handle *handle)
 }
 
 static int hclgevf_bind_ring_to_vector(struct hnae3_handle *handle, bool en,
-				       int vector,
+				       int vector_id,
 				       struct hnae3_ring_chain_node *ring_chain)
 {
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
 	struct hnae3_ring_chain_node *node;
 	struct hclge_mbx_vf_to_pf_cmd *req;
 	struct hclgevf_desc desc;
-	int i = 0, vector_id;
+	int i = 0;
 	int status;
 	u8 type;
 
 	req = (struct hclge_mbx_vf_to_pf_cmd *)desc.data;
-	vector_id = hclgevf_get_vector_index(hdev, vector);
-	if (vector_id < 0) {
-		dev_err(&handle->pdev->dev,
-			"Get vector index fail. ret =%d\n", vector_id);
-		return vector_id;
-	}
 
 	for (node = ring_chain; node; node = node->next) {
 		int idx_offset = HCLGE_MBX_RING_MAP_BASIC_MSG_NUM +
@@ -617,7 +611,17 @@ static int hclgevf_bind_ring_to_vector(struct hnae3_handle *handle, bool en,
 static int hclgevf_map_ring_to_vector(struct hnae3_handle *handle, int vector,
 				      struct hnae3_ring_chain_node *ring_chain)
 {
-	return hclgevf_bind_ring_to_vector(handle, true, vector, ring_chain);
+	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
+	int vector_id;
+
+	vector_id = hclgevf_get_vector_index(hdev, vector);
+	if (vector_id < 0) {
+		dev_err(&handle->pdev->dev,
+			"Get vector index fail. ret =%d\n", vector_id);
+		return vector_id;
+	}
+
+	return hclgevf_bind_ring_to_vector(handle, true, vector_id, ring_chain);
 }
 
 static int hclgevf_unmap_ring_from_vector(
@@ -635,7 +639,7 @@ static int hclgevf_unmap_ring_from_vector(
 		return vector_id;
 	}
 
-	ret = hclgevf_bind_ring_to_vector(handle, false, vector, ring_chain);
+	ret = hclgevf_bind_ring_to_vector(handle, false, vector_id, ring_chain);
 	if (ret)
 		dev_err(&handle->pdev->dev,
 			"Unmap ring from vector fail. vector=%d, ret =%d\n",
-- 
2.9.3

