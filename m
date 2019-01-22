Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACCDC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE3E21726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfAVXlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:41:23 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60036 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726309AbfAVXkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 18:40:10 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0113586668EED81D1B7B;
        Wed, 23 Jan 2019 07:40:08 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.143.16) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Wed, 23 Jan 2019 07:39:59 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>, <eric.dumazet@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 05/12] net: hns3: fix for shaper not setting when TC num changes
Date:   Wed, 23 Jan 2019 07:39:31 +0800
Message-ID: <20190122233938.7188-6-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190122233938.7188-1-tanhuazhong@huawei.com>
References: <20190122233938.7188-1-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.143.16]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

Shaper setting does not change currently, when TC num changes,
which may cause shaper parameter not setting problem.

This patch fixes it by setting the shaper parameter when TC num
changes.

Fixes: cacde272dd00 ("net: hns3: Add hclge_dcb module for the support of DCB feature")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c | 6 +-----
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  | 6 +++---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  | 3 +--
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index 4ec0b9cd15ae..5f7ac63707b8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -162,11 +162,7 @@ static int hclge_map_update(struct hnae3_handle *h)
 	struct hclge_dev *hdev = vport->back;
 	int ret;
 
-	ret = hclge_tm_map_cfg(hdev);
-	if (ret)
-		return ret;
-
-	ret = hclge_tm_schd_mode_hw(hdev);
+	ret = hclge_tm_schd_setup_hw(hdev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index fb8596a3e5e4..d057c9f03175 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -1005,7 +1005,7 @@ static int hclge_tm_pri_dwrr_cfg(struct hclge_dev *hdev)
 	return 0;
 }
 
-int hclge_tm_map_cfg(struct hclge_dev *hdev)
+static int hclge_tm_map_cfg(struct hclge_dev *hdev)
 {
 	int ret;
 
@@ -1120,7 +1120,7 @@ static int hclge_tm_lvl34_schd_mode_cfg(struct hclge_dev *hdev)
 	return 0;
 }
 
-int hclge_tm_schd_mode_hw(struct hclge_dev *hdev)
+static int hclge_tm_schd_mode_hw(struct hclge_dev *hdev)
 {
 	int ret;
 
@@ -1131,7 +1131,7 @@ int hclge_tm_schd_mode_hw(struct hclge_dev *hdev)
 	return hclge_tm_lvl34_schd_mode_cfg(hdev);
 }
 
-static int hclge_tm_schd_setup_hw(struct hclge_dev *hdev)
+int hclge_tm_schd_setup_hw(struct hclge_dev *hdev)
 {
 	int ret;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
index 898163c4d400..ef3f93b70c22 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
@@ -144,11 +144,10 @@ struct hclge_port_shapping_cmd {
 int hclge_tm_schd_init(struct hclge_dev *hdev);
 int hclge_tm_vport_map_update(struct hclge_dev *hdev);
 int hclge_pause_setup_hw(struct hclge_dev *hdev);
-int hclge_tm_schd_mode_hw(struct hclge_dev *hdev);
+int hclge_tm_schd_setup_hw(struct hclge_dev *hdev);
 void hclge_tm_prio_tc_info_update(struct hclge_dev *hdev, u8 *prio_tc);
 void hclge_tm_schd_info_update(struct hclge_dev *hdev, u8 num_tc);
 int hclge_tm_dwrr_cfg(struct hclge_dev *hdev);
-int hclge_tm_map_cfg(struct hclge_dev *hdev);
 int hclge_tm_init_hw(struct hclge_dev *hdev);
 int hclge_mac_pause_en_cfg(struct hclge_dev *hdev, bool tx, bool rx);
 int hclge_pause_addr_cfg(struct hclge_dev *hdev, const u8 *mac_addr);
-- 
2.20.1


