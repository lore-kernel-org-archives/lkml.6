Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6502C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7762E21773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbfBTCdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:33:42 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3690 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727264AbfBTCdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:33:39 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 04045B67CCB7749870D2;
        Wed, 20 Feb 2019 10:33:37 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Wed, 20 Feb 2019 10:33:29 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@hisilicon.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [Patch net-next 06/12] net: hns3: some bugfix of ppu(rcb) ras errors
Date:   Wed, 20 Feb 2019 10:32:45 +0800
Message-ID: <1550629971-23999-7-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550629971-23999-1-git-send-email-tanhuazhong@huawei.com>
References: <1550629971-23999-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weihang Li <liweihang@hisilicon.com>

The 3rd and 4th of PPU(RCB) PF Abnormal is RAS errors instead of MSI-X
like other bits. This patch adds process of handling and logging this
two bits. Otherwise, this patch modifies print message of 28th and 29th
bit of PPU MPF Abnormal errors, which keep same with other errors now.

Fixes: f69b10b317f9 ("net: hns3: handle hw errors of PPU(RCB)")
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 16 +++++++++++-----
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h |  1 +
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index c9c2c85..4951684 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -1038,6 +1038,13 @@ static int hclge_handle_pf_ras_error(struct hclge_dev *hdev,
 		hclge_log_error(dev, "IGU_EGU_TNL_INT_STS",
 				&hclge_igu_egu_tnl_int[0], status);
 
+	/* log PPU(RCB) errors */
+	desc_data = (__le32 *)&desc[3];
+	status = le32_to_cpu(*desc_data) & HCLGE_PPU_PF_INT_RAS_MASK;
+	if (status)
+		hclge_log_error(dev, "PPU_PF_ABNORMAL_INT_ST0",
+				&hclge_ppu_pf_abnormal_int[0], status);
+
 	/* clear all PF RAS errors */
 	hclge_cmd_reuse_desc(&desc[0], false);
 	desc[0].flag |= cpu_to_le16(HCLGE_CMD_FLAG_NEXT);
@@ -1373,14 +1380,13 @@ int hclge_handle_hw_msix_error(struct hclge_dev *hdev,
 		set_bit(HNAE3_GLOBAL_RESET, reset_requests);
 	}
 
-	/* log PPU(RCB) errors */
+	/* log PPU(RCB) MPF errors */
 	desc_data = (__le32 *)&desc[5];
 	status = le32_to_cpu(*(desc_data + 2)) &
 			HCLGE_PPU_MPF_INT_ST2_MSIX_MASK;
 	if (status) {
-		dev_warn(dev,
-			 "PPU_MPF_ABNORMAL_INT_ST2[28:29], err_status(0x%x)\n",
-			 status);
+		hclge_log_error(dev, "PPU_MPF_ABNORMAL_INT_ST2",
+				&hclge_ppu_mpf_abnormal_int_st2[0], status);
 		set_bit(HNAE3_CORE_RESET, reset_requests);
 	}
 
@@ -1427,7 +1433,7 @@ int hclge_handle_hw_msix_error(struct hclge_dev *hdev,
 		hclge_log_error(dev, "PPP_PF_ABNORMAL_INT_ST0",
 				&hclge_ppp_pf_abnormal_int[0], status);
 
-	/* PPU(RCB) PF errors */
+	/* log PPU(RCB) PF errors */
 	desc_data = (__le32 *)&desc[3];
 	status = le32_to_cpu(*desc_data) & HCLGE_PPU_PF_INT_MSIX_MASK;
 	if (status)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
index 51a7d4e..86d6143 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
@@ -79,6 +79,7 @@
 #define HCLGE_PPP_MPF_INT_ST3_MASK	GENMASK(5, 0)
 #define HCLGE_PPU_MPF_INT_ST3_MASK	GENMASK(7, 0)
 #define HCLGE_PPU_MPF_INT_ST2_MSIX_MASK	GENMASK(29, 28)
+#define HCLGE_PPU_PF_INT_RAS_MASK	0x18
 #define HCLGE_PPU_PF_INT_MSIX_MASK	0x27
 #define HCLGE_QCN_FIFO_INT_MASK		GENMASK(17, 0)
 #define HCLGE_QCN_ECC_INT_MASK		GENMASK(21, 0)
-- 
2.7.4

