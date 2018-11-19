Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F85C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7330620851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7330620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbeKSWwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:52:00 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:60300 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728701AbeKSWwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:52:00 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 66F0AE41B638F;
        Mon, 19 Nov 2018 20:28:28 +0800 (CST)
Received: from huawei.com (10.175.102.38) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Mon, 19 Nov 2018
 20:28:21 +0800
From:   Tan Xiaojun <tanxiaojun@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <lipeng321@huawei.com>,
        <linyunsheng@huawei.com>, <shenjian15@huawei.com>,
        <tanhuazhong@huawei.com>, <liangfuyun1@huawei.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net: hns3: add common validation in hclge_dcb
Date:   Mon, 19 Nov 2018 21:02:15 +0800
Message-ID: <1542632535-18210-1-git-send-email-tanxiaojun@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

Before setting tm related configuration to hardware, driver
needs to check the configuration provided by user is valid.
Currently hclge_ieee_setets and hclge_setup_tc both implement
their own checking, which has a lot in common.

This patch addes hclge_dcb_common_validate to do the common
checking. The checking in hclge_tm_prio_tc_info_update
and hclge_tm_schd_info_update is unnecessary now, so change
the return type to void, which removes the need to do error
handling when one of the checking fails.

Also, ets->prio_tc is indexed by user prio and ets->tc_tsa is
indexed by tc num, so this patch changes them to use different
index.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c | 70 +++++++++++++++-------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  | 14 +----
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  |  4 +-
 3 files changed, 53 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index e72f724..f6323b2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -35,7 +35,9 @@ static int hclge_ieee_ets_to_tm_info(struct hclge_dev *hdev,
 		}
 	}
 
-	return hclge_tm_prio_tc_info_update(hdev, ets->prio_tc);
+	hclge_tm_prio_tc_info_update(hdev, ets->prio_tc);
+
+	return 0;
 }
 
 static void hclge_tm_info_to_ieee_ets(struct hclge_dev *hdev,
@@ -70,25 +72,61 @@ static int hclge_ieee_getets(struct hnae3_handle *h, struct ieee_ets *ets)
 	return 0;
 }
 
+static int hclge_dcb_common_validate(struct hclge_dev *hdev, u8 num_tc,
+				     u8 *prio_tc)
+{
+	int i;
+
+	if (num_tc > hdev->tc_max) {
+		dev_err(&hdev->pdev->dev,
+			"tc num checking failed, %u > tc_max(%u)\n",
+			num_tc, hdev->tc_max);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < HNAE3_MAX_USER_PRIO; i++) {
+		if (prio_tc[i] >= num_tc) {
+			dev_err(&hdev->pdev->dev,
+				"prio_tc[%u] checking failed, %u >= num_tc(%u)\n",
+				i, prio_tc[i], num_tc);
+			return -EINVAL;
+		}
+	}
+
+	for (i = 0; i < hdev->num_alloc_vport; i++) {
+		if (num_tc > hdev->vport[i].alloc_tqps) {
+			dev_err(&hdev->pdev->dev,
+				"allocated tqp(%u) checking failed, %u > tqp(%u)\n",
+				i, num_tc, hdev->vport[i].alloc_tqps);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int hclge_ets_validate(struct hclge_dev *hdev, struct ieee_ets *ets,
 			      u8 *tc, bool *changed)
 {
 	bool has_ets_tc = false;
 	u32 total_ets_bw = 0;
 	u8 max_tc = 0;
+	int ret;
 	u8 i;
 
-	for (i = 0; i < HNAE3_MAX_TC; i++) {
-		if (ets->prio_tc[i] >= hdev->tc_max ||
-		    i >= hdev->tc_max)
-			return -EINVAL;
-
+	for (i = 0; i < HNAE3_MAX_USER_PRIO; i++) {
 		if (ets->prio_tc[i] != hdev->tm_info.prio_tc[i])
 			*changed = true;
 
 		if (ets->prio_tc[i] > max_tc)
 			max_tc = ets->prio_tc[i];
+	}
 
+	ret = hclge_dcb_common_validate(hdev, max_tc + 1, ets->prio_tc);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < HNAE3_MAX_TC; i++) {
 		switch (ets->tc_tsa[i]) {
 		case IEEE_8021QAZ_TSA_STRICT:
 			if (hdev->tm_info.tc_info[i].tc_sch_mode !=
@@ -184,9 +222,7 @@ static int hclge_ieee_setets(struct hnae3_handle *h, struct ieee_ets *ets)
 	if (ret)
 		return ret;
 
-	ret = hclge_tm_schd_info_update(hdev, num_tc);
-	if (ret)
-		return ret;
+	hclge_tm_schd_info_update(hdev, num_tc);
 
 	ret = hclge_ieee_ets_to_tm_info(hdev, ets);
 	if (ret)
@@ -305,20 +341,12 @@ static int hclge_setup_tc(struct hnae3_handle *h, u8 tc, u8 *prio_tc)
 	if (hdev->flag & HCLGE_FLAG_DCB_ENABLE)
 		return -EINVAL;
 
-	if (tc > hdev->tc_max) {
-		dev_err(&hdev->pdev->dev,
-			"setup tc failed, tc(%u) > tc_max(%u)\n",
-			tc, hdev->tc_max);
-		return -EINVAL;
-	}
-
-	ret = hclge_tm_schd_info_update(hdev, tc);
+	ret = hclge_dcb_common_validate(hdev, tc, prio_tc);
 	if (ret)
-		return ret;
+		return -EINVAL;
 
-	ret = hclge_tm_prio_tc_info_update(hdev, prio_tc);
-	if (ret)
-		return ret;
+	hclge_tm_schd_info_update(hdev, tc);
+	hclge_tm_prio_tc_info_update(hdev, prio_tc);
 
 	ret = hclge_tm_init_hw(hdev);
 	if (ret)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index 494e562..00458da 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -1259,15 +1259,13 @@ int hclge_pause_setup_hw(struct hclge_dev *hdev)
 	return 0;
 }
 
-int hclge_tm_prio_tc_info_update(struct hclge_dev *hdev, u8 *prio_tc)
+void hclge_tm_prio_tc_info_update(struct hclge_dev *hdev, u8 *prio_tc)
 {
 	struct hclge_vport *vport = hdev->vport;
 	struct hnae3_knic_private_info *kinfo;
 	u32 i, k;
 
 	for (i = 0; i < HNAE3_MAX_USER_PRIO; i++) {
-		if (prio_tc[i] >= hdev->tm_info.num_tc)
-			return -EINVAL;
 		hdev->tm_info.prio_tc[i] = prio_tc[i];
 
 		for (k = 0;  k < hdev->num_alloc_vport; k++) {
@@ -1275,18 +1273,12 @@ int hclge_tm_prio_tc_info_update(struct hclge_dev *hdev, u8 *prio_tc)
 			kinfo->prio_tc[i] = prio_tc[i];
 		}
 	}
-	return 0;
 }
 
-int hclge_tm_schd_info_update(struct hclge_dev *hdev, u8 num_tc)
+void hclge_tm_schd_info_update(struct hclge_dev *hdev, u8 num_tc)
 {
 	u8 i, bit_map = 0;
 
-	for (i = 0; i < hdev->num_alloc_vport; i++) {
-		if (num_tc > hdev->vport[i].alloc_tqps)
-			return -EINVAL;
-	}
-
 	hdev->tm_info.num_tc = num_tc;
 
 	for (i = 0; i < hdev->tm_info.num_tc; i++)
@@ -1300,8 +1292,6 @@ int hclge_tm_schd_info_update(struct hclge_dev *hdev, u8 num_tc)
 	hdev->hw_tc_map = bit_map;
 
 	hclge_tm_schd_info_init(hdev);
-
-	return 0;
 }
 
 int hclge_tm_init_hw(struct hclge_dev *hdev)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
index 25eef13..4bd916a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
@@ -131,8 +131,8 @@ struct hclge_port_shapping_cmd {
 int hclge_tm_schd_init(struct hclge_dev *hdev);
 int hclge_pause_setup_hw(struct hclge_dev *hdev);
 int hclge_tm_schd_mode_hw(struct hclge_dev *hdev);
-int hclge_tm_prio_tc_info_update(struct hclge_dev *hdev, u8 *prio_tc);
-int hclge_tm_schd_info_update(struct hclge_dev *hdev, u8 num_tc);
+void hclge_tm_prio_tc_info_update(struct hclge_dev *hdev, u8 *prio_tc);
+void hclge_tm_schd_info_update(struct hclge_dev *hdev, u8 num_tc);
 int hclge_tm_dwrr_cfg(struct hclge_dev *hdev);
 int hclge_tm_map_cfg(struct hclge_dev *hdev);
 int hclge_tm_init_hw(struct hclge_dev *hdev);
-- 
2.7.4

