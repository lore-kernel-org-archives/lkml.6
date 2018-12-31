Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F05C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 02:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DFD20828
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 02:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeLaC6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 21:58:49 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:17072 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbeLaC6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 21:58:49 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9E908C455EE15;
        Mon, 31 Dec 2018 10:58:45 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.408.0; Mon, 31 Dec 2018 10:58:40 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <mehta.salil@opnsrc.net>
Subject: [PATCH net] net: hns3: call hns3_nic_net_open() while doing HNAE3_UP_CLIENT
Date:   Mon, 31 Dec 2018 10:58:29 +0800
Message-ID: <1546225109-19631-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For HNAE3_DOWN_CLIENT calling hns3_nic_net_stop(), HNAE3_UP_CLIENT
should call hns3_nic_net_open(), since if the number of queue or
the map of TC has is changed before HHAE3_UP_CLIENT is called,
it will cause problem.

Also the HNS3_NIC_STATE_RESETTING flag needs to be cleared before
hns3_nic_net_open() called, and set it back while hns3_nic_net_open()
failed.

Fixes: bb6b94a896d4 ("net: hns3: Add reset interface implementation in client")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index d3b9aaf..07cd587 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3995,17 +3995,18 @@ static int hns3_reset_notify_up_enet(struct hnae3_handle *handle)
 	struct hns3_nic_priv *priv = netdev_priv(kinfo->netdev);
 	int ret = 0;
 
+	clear_bit(HNS3_NIC_STATE_RESETTING, &priv->state);
+
 	if (netif_running(kinfo->netdev)) {
-		ret = hns3_nic_net_up(kinfo->netdev);
+		ret = hns3_nic_net_open(kinfo->netdev);
 		if (ret) {
+			set_bit(HNS3_NIC_STATE_RESETTING, &priv->state);
 			netdev_err(kinfo->netdev,
 				   "hns net up fail, ret=%d!\n", ret);
 			return ret;
 		}
 	}
 
-	clear_bit(HNS3_NIC_STATE_RESETTING, &priv->state);
-
 	return ret;
 }
 
-- 
2.7.4

