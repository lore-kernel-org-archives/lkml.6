Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB937C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6EBA20892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6EBA20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbeLGVJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 16:09:34 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15661 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726218AbeLGVJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 16:09:32 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EAD7669D3D546;
        Sat,  8 Dec 2018 05:09:29 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Sat, 8 Dec 2018 05:09:22 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH net-next 04/14] net: hns3: deletes unnecessary settings of the descriptor data
Date:   Fri, 7 Dec 2018 21:08:01 +0000
Message-ID: <20181207210811.23844-5-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181207210811.23844-1-salil.mehta@huawei.com>
References: <20181207210811.23844-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

This patch deletes unnecessary setting of the descriptor data
to 0 for disabling error interrupts because
it is already done by the hclge_cmd_setup_basic_desc function.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 27 ++++------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index 7e23d36..62fab23 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -390,13 +390,8 @@ static int hclge_config_common_hw_err_int(struct hclge_dev *hdev, bool en)
 		desc[0].data[3] = cpu_to_le32(HCLGE_IMP_RD_POISON_ERR_INT_EN);
 		desc[0].data[4] = cpu_to_le32(HCLGE_TQP_ECC_ERR_INT_EN);
 		desc[0].data[5] = cpu_to_le32(HCLGE_IMP_ITCM4_ECC_ERR_INT_EN);
-	} else {
-		desc[0].data[0] = 0;
-		desc[0].data[2] = 0;
-		desc[0].data[3] = 0;
-		desc[0].data[4] = 0;
-		desc[0].data[5] = 0;
 	}
+
 	desc[1].data[0] = cpu_to_le32(HCLGE_IMP_TCM_ECC_ERR_INT_EN_MASK);
 	desc[1].data[2] = cpu_to_le32(HCLGE_CMDQ_NIC_ECC_ERR_INT_EN_MASK |
 				HCLGE_CMDQ_ROCEE_ECC_ERR_INT_EN_MASK);
@@ -425,8 +420,6 @@ static int hclge_config_ncsi_hw_err_int(struct hclge_dev *hdev, bool en)
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_NCSI_INT_EN, false);
 	if (en)
 		desc.data[0] = cpu_to_le32(HCLGE_NCSI_ERR_INT_EN);
-	else
-		desc.data[0] = 0;
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
 	if (ret)
@@ -446,8 +439,7 @@ static int hclge_config_igu_egu_hw_err_int(struct hclge_dev *hdev, bool en)
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_IGU_COMMON_INT_EN, false);
 	if (en)
 		desc.data[0] = cpu_to_le32(HCLGE_IGU_ERR_INT_EN);
-	else
-		desc.data[0] = 0;
+
 	desc.data[1] = cpu_to_le32(HCLGE_IGU_ERR_INT_EN_MASK);
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
@@ -460,8 +452,7 @@ static int hclge_config_igu_egu_hw_err_int(struct hclge_dev *hdev, bool en)
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_IGU_EGU_TNL_INT_EN, false);
 	if (en)
 		desc.data[0] = cpu_to_le32(HCLGE_IGU_TNL_ERR_INT_EN);
-	else
-		desc.data[0] = 0;
+
 	desc.data[1] = cpu_to_le32(HCLGE_IGU_TNL_ERR_INT_EN_MASK);
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
@@ -494,10 +485,8 @@ static int hclge_config_ppp_error_interrupt(struct hclge_dev *hdev, u32 cmd,
 				cpu_to_le32(HCLGE_PPP_MPF_ECC_ERR_INT0_EN);
 			desc[0].data[1] =
 				cpu_to_le32(HCLGE_PPP_MPF_ECC_ERR_INT1_EN);
-		} else {
-			desc[0].data[0] = 0;
-			desc[0].data[1] = 0;
 		}
+
 		desc[1].data[0] =
 			cpu_to_le32(HCLGE_PPP_MPF_ECC_ERR_INT0_EN_MASK);
 		desc[1].data[1] =
@@ -508,10 +497,8 @@ static int hclge_config_ppp_error_interrupt(struct hclge_dev *hdev, u32 cmd,
 				cpu_to_le32(HCLGE_PPP_MPF_ECC_ERR_INT2_EN);
 			desc[0].data[1] =
 				cpu_to_le32(HCLGE_PPP_MPF_ECC_ERR_INT3_EN);
-		} else {
-			desc[0].data[0] = 0;
-			desc[0].data[1] = 0;
 		}
+
 		desc[1].data[0] =
 				cpu_to_le32(HCLGE_PPP_MPF_ECC_ERR_INT2_EN_MASK);
 		desc[1].data[1] =
@@ -550,8 +537,6 @@ static int hclge_config_tm_hw_err_int(struct hclge_dev *hdev, bool en)
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_TM_SCH_ECC_INT_EN, false);
 	if (en)
 		desc.data[0] = cpu_to_le32(HCLGE_TM_SCH_ECC_ERR_INT_EN);
-	else
-		desc.data[0] = 0;
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
 	if (ret) {
@@ -570,8 +555,6 @@ static int hclge_config_tm_hw_err_int(struct hclge_dev *hdev, bool en)
 	hclge_cmd_reuse_desc(&desc, false);
 	if (en)
 		desc.data[1] = cpu_to_le32(HCLGE_TM_QCN_MEM_ERR_INT_EN);
-	else
-		desc.data[1] = 0;
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
 	if (ret)
-- 
2.7.4


