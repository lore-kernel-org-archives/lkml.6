Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A70C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7B32086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfARIOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:14:23 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:33940 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727568AbfARIN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:13:57 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B531C1F6C6C7FC470E7A;
        Fri, 18 Jan 2019 16:13:54 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Fri, 18 Jan 2019 16:13:44 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [PATCH net-next 10/12] net: hns3: fix wrong combined count returned by ethtool -l
Date:   Fri, 18 Jan 2019 16:13:12 +0800
Message-ID: <1547799194-38212-11-git-send-email-tanhuazhong@huawei.com>
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

The current code returns the number of all queues that can be used and
the number of queues that have been allocated, which is incorrect.
What should be returned is the number of queues allocated for each enabled
TC and the number of queues that can be allocated.

This patch fixes it.

Fixes: 482d2e9c1cc7 ("net: hns3: add support to query tqps number")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 9506c52..450094c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -7510,18 +7510,17 @@ static u32 hclge_get_max_channels(struct hnae3_handle *handle)
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
 
-	return min_t(u32, hdev->rss_size_max * kinfo->num_tc, hdev->num_tqps);
+	return min_t(u32, hdev->rss_size_max,
+		     vport->alloc_tqps / kinfo->num_tc);
 }
 
 static void hclge_get_channels(struct hnae3_handle *handle,
 			       struct ethtool_channels *ch)
 {
-	struct hclge_vport *vport = hclge_get_vport(handle);
-
 	ch->max_combined = hclge_get_max_channels(handle);
 	ch->other_count = 1;
 	ch->max_other = 1;
-	ch->combined_count = vport->alloc_tqps;
+	ch->combined_count = handle->kinfo.rss_size;
 }
 
 static void hclge_get_tqps_and_rss_info(struct hnae3_handle *handle,
-- 
2.7.4

