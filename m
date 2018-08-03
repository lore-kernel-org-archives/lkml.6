Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44381C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085232174B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085232174B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732605AbeHCLwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 07:52:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40178 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732327AbeHCLwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 07:52:38 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C1FCE17CDEC63;
        Fri,  3 Aug 2018 17:57:01 +0800 (CST)
Received: from S00293818-DELL1.huawei.com (10.202.226.54) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.399.0; Fri, 3 Aug 2018 17:56:53 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 2/2] net: hns3: Refine the MSIX allocation for PF
Date:   Fri, 3 Aug 2018 10:56:31 +0100
Message-ID: <20180803095631.798-3-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803095631.798-1-salil.mehta@huawei.com>
References: <20180803095631.798-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

The offset of msix number for roce is different between different
revision id. We should get it from firmware, instead of a fix value.
This patch refines the msix allocation, make it compatible.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h  | 2 ++
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 8 ++++++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h | 3 +--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 5cd22f9..cd0a4f2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -358,6 +358,8 @@ struct hclge_pf_res_cmd {
 	__le16 buf_size;
 	__le16 msixcap_localid_ba_nic;
 	__le16 msixcap_localid_ba_rocee;
+#define HCLGE_MSIX_OFT_ROCEE_S		0
+#define HCLGE_MSIX_OFT_ROCEE_M		GENMASK(15, 0)
 #define HCLGE_PF_VEC_NUM_S		0
 #define HCLGE_PF_VEC_NUM_M		GENMASK(7, 0)
 	__le16 pf_intr_vector_number;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index a9b888f..fc813b7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -932,6 +932,9 @@ static int hclge_query_pf_resource(struct hclge_dev *hdev)
 	hdev->pkt_buf_size = __le16_to_cpu(req->buf_size) << HCLGE_BUF_UNIT_S;
 
 	if (hnae3_dev_roce_supported(hdev)) {
+		hdev->roce_base_msix_offset =
+		hnae3_get_field(__le16_to_cpu(req->msixcap_localid_ba_rocee),
+				HCLGE_MSIX_OFT_ROCEE_M, HCLGE_MSIX_OFT_ROCEE_S);
 		hdev->num_roce_msi =
 		hnae3_get_field(__le16_to_cpu(req->pf_intr_vector_number),
 				HCLGE_PF_VEC_NUM_M, HCLGE_PF_VEC_NUM_S);
@@ -939,7 +942,8 @@ static int hclge_query_pf_resource(struct hclge_dev *hdev)
 		/* PF should have NIC vectors and Roce vectors,
 		 * NIC vectors are queued before Roce vectors.
 		 */
-		hdev->num_msi = hdev->num_roce_msi  + HCLGE_ROCE_VECTOR_OFFSET;
+		hdev->num_msi = hdev->num_roce_msi  +
+				hdev->roce_base_msix_offset;
 	} else {
 		hdev->num_msi =
 		hnae3_get_field(__le16_to_cpu(req->pf_intr_vector_number),
@@ -2037,7 +2041,7 @@ static int hclge_init_msi(struct hclge_dev *hdev)
 	hdev->num_msi_left = vectors;
 	hdev->base_msi_vector = pdev->irq;
 	hdev->roce_base_vector = hdev->base_msi_vector +
-				HCLGE_ROCE_VECTOR_OFFSET;
+				hdev->roce_base_msix_offset;
 
 	hdev->vector_status = devm_kcalloc(&pdev->dev, hdev->num_msi,
 					   sizeof(u16), GFP_KERNEL);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index dfa5c94..1528fb3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -16,8 +16,6 @@
 
 #define HCLGE_INVALID_VPORT 0xffff
 
-#define HCLGE_ROCE_VECTOR_OFFSET	96
-
 #define HCLGE_PF_CFG_BLOCK_SIZE		32
 #define HCLGE_PF_CFG_DESC_NUM \
 	(HCLGE_PF_CFG_BLOCK_SIZE / HCLGE_CFG_RD_LEN_BYTES)
@@ -509,6 +507,7 @@ struct hclge_dev {
 	u16 num_msi;
 	u16 num_msi_left;
 	u16 num_msi_used;
+	u16 roce_base_msix_offset;
 	u32 base_msi_vector;
 	u16 *vector_status;
 	int *vector_irq;
-- 
2.7.4


