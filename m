Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4121C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4ED12085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbfAVQkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:40:21 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:41518 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729514AbfAVQkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:40:12 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1E3272CFB87FEFAC23E1;
        Wed, 23 Jan 2019 00:40:10 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.54.154) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Wed, 23 Jan 2019 00:40:00 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 09/12] net: hns3: do not return GE PFC setting err when initializing
Date:   Wed, 23 Jan 2019 00:39:37 +0800
Message-ID: <20190122163940.7876-10-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190122163940.7876-1-tanhuazhong@huawei.com>
References: <20190122163940.7876-1-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.54.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

GE MAC does not support PFC, when driver is initializing and MAC
is in GE Mode, ignore the fw not supported error, otherwise
initialization will fail.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../hisilicon/hns3/hns3pf/hclge_dcb.c         |  6 +++---
 .../hisilicon/hns3/hns3pf/hclge_main.c        |  2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_tm.c | 19 ++++++++++++-------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_tm.h |  4 ++--
 4 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index 5f7ac63707b8..7db491086fea 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -166,7 +166,7 @@ static int hclge_map_update(struct hnae3_handle *h)
 	if (ret)
 		return ret;
 
-	ret = hclge_pause_setup_hw(hdev);
+	ret = hclge_pause_setup_hw(hdev, false);
 	if (ret)
 		return ret;
 
@@ -313,7 +313,7 @@ static int hclge_ieee_setpfc(struct hnae3_handle *h, struct ieee_pfc *pfc)
 
 	hdev->tm_info.hw_pfc_map = pfc_map;
 
-	return hclge_pause_setup_hw(hdev);
+	return hclge_pause_setup_hw(hdev, false);
 }
 
 /* DCBX configuration */
@@ -361,7 +361,7 @@ static int hclge_setup_tc(struct hnae3_handle *h, u8 tc, u8 *prio_tc)
 	hclge_tm_schd_info_update(hdev, tc);
 	hclge_tm_prio_tc_info_update(hdev, prio_tc);
 
-	ret = hclge_tm_init_hw(hdev);
+	ret = hclge_tm_init_hw(hdev, false);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 3ba8de93bc3d..6fb3144eb79d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -7428,7 +7428,7 @@ static int hclge_reset_ae_dev(struct hnae3_ae_dev *ae_dev)
 		return ret;
 	}
 
-	ret = hclge_tm_init_hw(hdev);
+	ret = hclge_tm_init_hw(hdev, true);
 	if (ret) {
 		dev_err(&pdev->dev, "tm init hw fail, ret =%d\n", ret);
 		return ret;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index d057c9f03175..44316602c2fc 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -1255,7 +1255,7 @@ static int hclge_tm_bp_setup(struct hclge_dev *hdev)
 	return ret;
 }
 
-int hclge_pause_setup_hw(struct hclge_dev *hdev)
+int hclge_pause_setup_hw(struct hclge_dev *hdev, bool init)
 {
 	int ret;
 
@@ -1271,10 +1271,15 @@ int hclge_pause_setup_hw(struct hclge_dev *hdev)
 	if (!hnae3_dev_dcb_supported(hdev))
 		return 0;
 
-	/* When MAC is GE Mode, hdev does not support pfc setting */
+	/* GE MAC does not support PFC, when driver is initializing and MAC
+	 * is in GE Mode, ignore the error here, otherwise initialization
+	 * will fail.
+	 */
 	ret = hclge_pfc_setup_hw(hdev);
-	if (ret)
-		dev_warn(&hdev->pdev->dev, "set pfc pause failed:%d\n", ret);
+	if (init && ret == -EOPNOTSUPP)
+		dev_warn(&hdev->pdev->dev, "GE MAC does not support pfc\n");
+	else
+		return ret;
 
 	return hclge_tm_bp_setup(hdev);
 }
@@ -1314,7 +1319,7 @@ void hclge_tm_schd_info_update(struct hclge_dev *hdev, u8 num_tc)
 	hclge_tm_schd_info_init(hdev);
 }
 
-int hclge_tm_init_hw(struct hclge_dev *hdev)
+int hclge_tm_init_hw(struct hclge_dev *hdev, bool init)
 {
 	int ret;
 
@@ -1326,7 +1331,7 @@ int hclge_tm_init_hw(struct hclge_dev *hdev)
 	if (ret)
 		return ret;
 
-	ret = hclge_pause_setup_hw(hdev);
+	ret = hclge_pause_setup_hw(hdev, init);
 	if (ret)
 		return ret;
 
@@ -1345,7 +1350,7 @@ int hclge_tm_schd_init(struct hclge_dev *hdev)
 	if (ret)
 		return ret;
 
-	return hclge_tm_init_hw(hdev);
+	return hclge_tm_init_hw(hdev, true);
 }
 
 int hclge_tm_vport_map_update(struct hclge_dev *hdev)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
index ef3f93b70c22..f60e540c7a62 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
@@ -143,12 +143,12 @@ struct hclge_port_shapping_cmd {
 
 int hclge_tm_schd_init(struct hclge_dev *hdev);
 int hclge_tm_vport_map_update(struct hclge_dev *hdev);
-int hclge_pause_setup_hw(struct hclge_dev *hdev);
+int hclge_pause_setup_hw(struct hclge_dev *hdev, bool init);
 int hclge_tm_schd_setup_hw(struct hclge_dev *hdev);
 void hclge_tm_prio_tc_info_update(struct hclge_dev *hdev, u8 *prio_tc);
 void hclge_tm_schd_info_update(struct hclge_dev *hdev, u8 num_tc);
 int hclge_tm_dwrr_cfg(struct hclge_dev *hdev);
-int hclge_tm_init_hw(struct hclge_dev *hdev);
+int hclge_tm_init_hw(struct hclge_dev *hdev, bool init);
 int hclge_mac_pause_en_cfg(struct hclge_dev *hdev, bool tx, bool rx);
 int hclge_pause_addr_cfg(struct hclge_dev *hdev, const u8 *mac_addr);
 int hclge_pfc_rx_stats_get(struct hclge_dev *hdev, u64 *stats);
-- 
2.20.1


