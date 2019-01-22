Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED456C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71122085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbfAVQkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:40:12 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:58496 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729473AbfAVQkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:40:10 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 05F75CFC1DDC206A52C3;
        Wed, 23 Jan 2019 00:40:05 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.54.154) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Wed, 23 Jan 2019 00:39:58 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [PATCH net-next 06/12] net: hns3: fix bug of ethtool_ops.get_channels for VF
Date:   Wed, 23 Jan 2019 00:39:34 +0800
Message-ID: <20190122163940.7876-7-tanhuazhong@huawei.com>
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

The current code returns the number of all queues that can be used and
the number of queues that have been allocated, which is incorrect.
What should be returned is the number of queues allocated for each enabled
TC and the number of queues that can be allocated.

This patch fixes it.

Fixes: 849e46077689 ("net: hns3: add ethtool_ops.get_channels support for VF")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 989f08377d58..24b54083b5f9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -2466,7 +2466,8 @@ static u32 hclgevf_get_max_channels(struct hclgevf_dev *hdev)
 	struct hnae3_handle *nic = &hdev->nic;
 	struct hnae3_knic_private_info *kinfo = &nic->kinfo;
 
-	return min_t(u32, hdev->rss_size_max * kinfo->num_tc, hdev->num_tqps);
+	return min_t(u32, hdev->rss_size_max,
+		     hdev->num_tqps / kinfo->num_tc);
 }
 
 /**
@@ -2487,7 +2488,7 @@ static void hclgevf_get_channels(struct hnae3_handle *handle,
 	ch->max_combined = hclgevf_get_max_channels(hdev);
 	ch->other_count = 0;
 	ch->max_other = 0;
-	ch->combined_count = hdev->num_tqps;
+	ch->combined_count = handle->kinfo.rss_size;
 }
 
 static void hclgevf_get_tqps_and_rss_info(struct hnae3_handle *handle,
-- 
2.20.1


