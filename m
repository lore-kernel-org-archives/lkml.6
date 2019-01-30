Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1FFC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4072184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387953AbfA3U4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 15:56:35 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3252 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387878AbfA3U41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 15:56:27 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3F2A17A37204E1F3160C;
        Thu, 31 Jan 2019 04:56:25 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.134.27) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Thu, 31 Jan 2019 04:56:14 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 05/12] net: hns3: only support tc 0 for VF
Date:   Thu, 31 Jan 2019 04:55:45 +0800
Message-ID: <20190130205552.8512-6-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190130205552.8512-1-tanhuazhong@huawei.com>
References: <20190130205552.8512-1-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.134.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

When the VF shares the same TC config as PF, the business
running on PF and VF must have samiliar module.

For simplicity, we are not considering VF sharing the same tc
configuration as PF use case, so this patch removes the support
of TC configuration from VF and forcing VF to just use single
TC.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../hisilicon/hns3/hns3pf/hclge_dcb.c         | 12 +++++-----
 .../hisilicon/hns3/hns3pf/hclge_mbx.c         | 10 ++++++---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_tm.c | 22 ++++++++++++++-----
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index 961aedb0e20f..1161361a973b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -93,13 +93,11 @@ static int hclge_dcb_common_validate(struct hclge_dev *hdev, u8 num_tc,
 		}
 	}
 
-	for (i = 0; i < hdev->num_alloc_vport; i++) {
-		if (num_tc > hdev->vport[i].alloc_tqps) {
-			dev_err(&hdev->pdev->dev,
-				"allocated tqp(%u) checking failed, %u > tqp(%u)\n",
-				i, num_tc, hdev->vport[i].alloc_tqps);
-			return -EINVAL;
-		}
+	if (num_tc > hdev->vport[0].alloc_tqps) {
+		dev_err(&hdev->pdev->dev,
+			"allocated tqp checking failed, %u > tqp(%u)\n",
+			num_tc, hdev->vport[0].alloc_tqps);
+		return -EINVAL;
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index 3603034aa45c..6afb0a4b73f7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -319,10 +319,14 @@ static int hclge_get_vf_tcinfo(struct hclge_vport *vport,
 			       struct hclge_mbx_vf_to_pf_cmd *mbx_req,
 			       bool gen_resp)
 {
-	struct hclge_dev *hdev = vport->back;
-	int ret;
+	struct hnae3_knic_private_info *kinfo = &vport->nic.kinfo;
+	u8 vf_tc_map = 0;
+	int i, ret;
+
+	for (i = 0; i < kinfo->num_tc; i++)
+		vf_tc_map |= BIT(i);
 
-	ret = hclge_gen_resp_to_vf(vport, mbx_req, 0, &hdev->hw_tc_map,
+	ret = hclge_gen_resp_to_vf(vport, mbx_req, 0, &vf_tc_map,
 				   sizeof(u8));
 
 	return ret;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index 9f4069fb786b..aafc69f4bfdd 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -520,8 +520,14 @@ static void hclge_tm_vport_tc_info_update(struct hclge_vport *vport)
 	u16 max_rss_size;
 	u8 i;
 
-	vport->bw_limit = hdev->tm_info.pg_info[0].bw_limit;
-	kinfo->num_tc = min_t(u16, vport->alloc_tqps, hdev->tm_info.num_tc);
+	/* TC configuration is shared by PF/VF in one port, only allow
+	 * one tc for VF for simplicity. VF's vport_id is non zero.
+	 */
+	kinfo->num_tc = vport->vport_id ? 1 :
+			min_t(u16, vport->alloc_tqps, hdev->tm_info.num_tc);
+	vport->qs_offset = (vport->vport_id ? hdev->tm_info.num_tc : 0) +
+				(vport->vport_id ? (vport->vport_id - 1) : 0);
+
 	max_rss_size = min_t(u16, hdev->rss_size_max,
 			     vport->alloc_tqps / kinfo->num_tc);
 
@@ -538,12 +544,12 @@ static void hclge_tm_vport_tc_info_update(struct hclge_vport *vport)
 	}
 
 	kinfo->num_tqps = kinfo->num_tc * kinfo->rss_size;
-	vport->qs_offset = hdev->tm_info.num_tc * vport->vport_id;
 	vport->dwrr = 100;  /* 100 percent as init */
 	vport->alloc_rss_size = kinfo->rss_size;
+	vport->bw_limit = hdev->tm_info.pg_info[0].bw_limit;
 
 	for (i = 0; i < HNAE3_MAX_TC; i++) {
-		if (hdev->hw_tc_map & BIT(i)) {
+		if (hdev->hw_tc_map & BIT(i) && i < kinfo->num_tc) {
 			kinfo->tc_info[i].enable = true;
 			kinfo->tc_info[i].tqp_offset = i * kinfo->rss_size;
 			kinfo->tc_info[i].tqp_count = kinfo->rss_size;
@@ -766,13 +772,17 @@ static int hclge_tm_pri_q_qs_cfg(struct hclge_dev *hdev)
 
 	if (hdev->tx_sch_mode == HCLGE_FLAG_TC_BASE_SCH_MODE) {
 		/* Cfg qs -> pri mapping, one by one mapping */
-		for (k = 0; k < hdev->num_alloc_vport; k++)
-			for (i = 0; i < hdev->tm_info.num_tc; i++) {
+		for (k = 0; k < hdev->num_alloc_vport; k++) {
+			struct hnae3_knic_private_info *kinfo =
+				&vport[k].nic.kinfo;
+
+			for (i = 0; i < kinfo->num_tc; i++) {
 				ret = hclge_tm_qs_to_pri_map_cfg(
 					hdev, vport[k].qs_offset + i, i);
 				if (ret)
 					return ret;
 			}
+		}
 	} else if (hdev->tx_sch_mode == HCLGE_FLAG_VNET_BASE_SCH_MODE) {
 		/* Cfg qs -> pri mapping,  qs = tc, pri = vf, 8 qs -> 1 pri */
 		for (k = 0; k < hdev->num_alloc_vport; k++)
-- 
2.20.1


