Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51814C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8122086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfARIPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:15:14 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2260 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727350AbfARINw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:13:52 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A0E7EC9C0E270549F62B;
        Fri, 18 Jan 2019 16:13:49 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Fri, 18 Jan 2019 16:13:43 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [PATCH net-next 07/12] net: hns3: remove redundant codes in hclge_knic_setup
Date:   Fri, 18 Jan 2019 16:13:09 +0800
Message-ID: <1547799194-38212-8-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547799194-38212-1-git-send-email-tanhuazhong@huawei.com>
References: <1547799194-38212-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TC info will be updated in hclge_tm_vport_tc_info_update(),
so hclge_knic_setup() no need to do it again.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 17 +----------------
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c   |  2 +-
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index f7637c0..17b1e33 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1096,7 +1096,7 @@ static int hclge_knic_setup(struct hclge_vport *vport,
 	struct hnae3_handle *nic = &vport->nic;
 	struct hnae3_knic_private_info *kinfo = &nic->kinfo;
 	struct hclge_dev *hdev = vport->back;
-	int i, ret;
+	int ret;
 
 	kinfo->num_desc = num_desc;
 	kinfo->rx_buf_len = hdev->rx_buf_len;
@@ -1105,21 +1105,6 @@ static int hclge_knic_setup(struct hclge_vport *vport,
 		= min_t(u16, hdev->rss_size_max, num_tqps / kinfo->num_tc);
 	kinfo->num_tqps = kinfo->rss_size * kinfo->num_tc;
 
-	for (i = 0; i < HNAE3_MAX_TC; i++) {
-		if (hdev->hw_tc_map & BIT(i)) {
-			kinfo->tc_info[i].enable = true;
-			kinfo->tc_info[i].tqp_offset = i * kinfo->rss_size;
-			kinfo->tc_info[i].tqp_count = kinfo->rss_size;
-			kinfo->tc_info[i].tc = i;
-		} else {
-			/* Set to default queue if TC is disable */
-			kinfo->tc_info[i].enable = false;
-			kinfo->tc_info[i].tqp_offset = 0;
-			kinfo->tc_info[i].tqp_count = 1;
-			kinfo->tc_info[i].tc = 0;
-		}
-	}
-
 	kinfo->tqp = devm_kcalloc(&hdev->pdev->dev, kinfo->num_tqps,
 				  sizeof(struct hnae3_queue *), GFP_KERNEL);
 	if (!kinfo->tqp)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index fda91e5..8c57950 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -529,7 +529,7 @@ static void hclge_tm_vport_tc_info_update(struct hclge_vport *vport)
 	vport->dwrr = 100;  /* 100 percent as init */
 	vport->alloc_rss_size = kinfo->rss_size;
 
-	for (i = 0; i < kinfo->num_tc; i++) {
+	for (i = 0; i < HNAE3_MAX_TC; i++) {
 		if (hdev->hw_tc_map & BIT(i)) {
 			kinfo->tc_info[i].enable = true;
 			kinfo->tc_info[i].tqp_offset = i * kinfo->rss_size;
-- 
2.7.4

