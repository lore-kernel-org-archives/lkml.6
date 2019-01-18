Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2544C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA472086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfARINw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:13:52 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2261 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727259AbfARINv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:13:51 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A57598951E7941F45D25;
        Fri, 18 Jan 2019 16:13:49 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Fri, 18 Jan 2019 16:13:42 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [PATCH net-next 06/12] net: hns3: modify parameter checks in the hns3_set_channels
Date:   Fri, 18 Jan 2019 16:13:08 +0800
Message-ID: <1547799194-38212-7-git-send-email-tanhuazhong@huawei.com>
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

The number of queues for each enabled TC should range from 1 to
the maximum available value, and return directly if the value
is same as the current one.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 0cd70d7..0bda9bd 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -4157,15 +4157,14 @@ int hns3_set_channels(struct net_device *netdev,
 		return -EINVAL;
 
 	if (new_tqp_num > hns3_get_max_available_channels(h) ||
-	    new_tqp_num < kinfo->num_tc) {
+	    new_tqp_num < 1) {
 		dev_err(&netdev->dev,
-			"Change tqps fail, the tqp range is from %d to %d",
-			kinfo->num_tc,
+			"Change tqps fail, the tqp range is from 1 to %d",
 			hns3_get_max_available_channels(h));
 		return -EINVAL;
 	}
 
-	if (kinfo->num_tqps == new_tqp_num)
+	if (kinfo->rss_size == new_tqp_num)
 		return 0;
 
 	ret = hns3_reset_notify(h, HNAE3_DOWN_CLIENT);
-- 
2.7.4

