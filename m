Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F013AC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 14:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF58620880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 14:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF58620880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbeI2V1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 17:27:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13584 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728541AbeI2V1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 17:27:50 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6348F95FEA6A4;
        Sat, 29 Sep 2018 22:58:57 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.85.66) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.399.0; Sat, 29 Sep 2018 22:58:51 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH V2 net-next 08/10] net: hns3: Change return type of hclge_tm_schd_info_update()
Date:   Sat, 29 Sep 2018 15:56:20 +0100
Message-ID: <20180929145622.5448-9-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180929145622.5448-1-salil.mehta@huawei.com>
References: <20180929145622.5448-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.85.66]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

hclge_tm_schd_info_update should return an error when num_tc is greater
than alloc_tqps.

This patch changes the return type of hnae3_register_ae_algo from void
to int.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c | 8 ++++++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  | 9 ++++++++-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  | 2 +-
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index 92f19384e258..e72f724123d7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -184,7 +184,9 @@ static int hclge_ieee_setets(struct hnae3_handle *h, struct ieee_ets *ets)
 	if (ret)
 		return ret;
 
-	hclge_tm_schd_info_update(hdev, num_tc);
+	ret = hclge_tm_schd_info_update(hdev, num_tc);
+	if (ret)
+		return ret;
 
 	ret = hclge_ieee_ets_to_tm_info(hdev, ets);
 	if (ret)
@@ -310,7 +312,9 @@ static int hclge_setup_tc(struct hnae3_handle *h, u8 tc, u8 *prio_tc)
 		return -EINVAL;
 	}
 
-	hclge_tm_schd_info_update(hdev, tc);
+	ret = hclge_tm_schd_info_update(hdev, tc);
+	if (ret)
+		return ret;
 
 	ret = hclge_tm_prio_tc_info_update(hdev, prio_tc);
 	if (ret)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index ab7280d7f79c..aa5cb9834d73 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -1280,10 +1280,15 @@ int hclge_tm_prio_tc_info_update(struct hclge_dev *hdev, u8 *prio_tc)
 	return 0;
 }
 
-void hclge_tm_schd_info_update(struct hclge_dev *hdev, u8 num_tc)
+int hclge_tm_schd_info_update(struct hclge_dev *hdev, u8 num_tc)
 {
 	u8 i, bit_map = 0;
 
+	for (i = 0; i < hdev->num_alloc_vport; i++) {
+		if (num_tc > hdev->vport[i].alloc_tqps)
+			return -EINVAL;
+	}
+
 	hdev->tm_info.num_tc = num_tc;
 
 	for (i = 0; i < hdev->tm_info.num_tc; i++)
@@ -1297,6 +1302,8 @@ void hclge_tm_schd_info_update(struct hclge_dev *hdev, u8 num_tc)
 	hdev->hw_tc_map = bit_map;
 
 	hclge_tm_schd_info_init(hdev);
+
+	return 0;
 }
 
 int hclge_tm_init_hw(struct hclge_dev *hdev)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
index e1568b826aac..25eef13a3e14 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
@@ -132,7 +132,7 @@ int hclge_tm_schd_init(struct hclge_dev *hdev);
 int hclge_pause_setup_hw(struct hclge_dev *hdev);
 int hclge_tm_schd_mode_hw(struct hclge_dev *hdev);
 int hclge_tm_prio_tc_info_update(struct hclge_dev *hdev, u8 *prio_tc);
-void hclge_tm_schd_info_update(struct hclge_dev *hdev, u8 num_tc);
+int hclge_tm_schd_info_update(struct hclge_dev *hdev, u8 num_tc);
 int hclge_tm_dwrr_cfg(struct hclge_dev *hdev);
 int hclge_tm_map_cfg(struct hclge_dev *hdev);
 int hclge_tm_init_hw(struct hclge_dev *hdev);
-- 
2.11.0


