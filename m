Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21459C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9902085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbfAVQkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:40:47 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:41520 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729521AbfAVQkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:40:15 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 236AC7E0496BC4A47BB8;
        Wed, 23 Jan 2019 00:40:10 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.54.154) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Wed, 23 Jan 2019 00:40:01 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 12/12] net: hns3: fix PFC not setting problem for DCB module
Date:   Wed, 23 Jan 2019 00:39:40 +0800
Message-ID: <20190122163940.7876-13-tanhuazhong@huawei.com>
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

The PFC enabling is based on user priority, currently it is
based on TC, which may cause PFC not setting correctly when pri
to TC mapping is not one to one relation.

This patch adds pfc_en in tm_info to fix it.

Fixes: cacde272dd00 ("net: hns3: Add hclge_dcb module for the support of DCB feature")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c  | 7 ++++---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h | 1 +
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c   | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index 7db491086fea..3a4a54ee5204 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -296,6 +296,9 @@ static int hclge_ieee_setpfc(struct hnae3_handle *h, struct ieee_pfc *pfc)
 	    hdev->flag & HCLGE_FLAG_MQPRIO_ENABLE)
 		return -EINVAL;
 
+	if (pfc->pfc_en == hdev->tm_info.pfc_en)
+		return 0;
+
 	prio_tc = hdev->tm_info.prio_tc;
 	pfc_map = 0;
 
@@ -308,10 +311,8 @@ static int hclge_ieee_setpfc(struct hnae3_handle *h, struct ieee_pfc *pfc)
 		}
 	}
 
-	if (pfc_map == hdev->tm_info.hw_pfc_map)
-		return 0;
-
 	hdev->tm_info.hw_pfc_map = pfc_map;
+	hdev->tm_info.pfc_en = pfc->pfc_en;
 
 	return hclge_pause_setup_hw(hdev, false);
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index b5a38fc1af91..2c413c63c6c9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -325,6 +325,7 @@ struct hclge_tm_info {
 	struct hclge_tc_info tc_info[HNAE3_MAX_TC];
 	enum hclge_fc_mode fc_mode;
 	u8 hw_pfc_map; /* Allow for packet drop or not on this TC */
+	u8 pfc_en;	/* PFC enabled or not for user priority */
 };
 
 struct hclge_comm_stats_str {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index bad975ebe137..9f4069fb786b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -1215,7 +1215,7 @@ static int hclge_pfc_setup_hw(struct hclge_dev *hdev)
 				HCLGE_RX_MAC_PAUSE_EN_MSK;
 
 	return hclge_pfc_pause_en_cfg(hdev, enable_bitmap,
-				      hdev->tm_info.hw_pfc_map);
+				      hdev->tm_info.pfc_en);
 }
 
 /* Each Tc has a 1024 queue sets to backpress, it divides to
-- 
2.20.1


