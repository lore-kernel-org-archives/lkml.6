Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0467ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6485C208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6485C208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbeGPQFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:05:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9629 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727403AbeGPQFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:05:40 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 583779E115361;
        Mon, 16 Jul 2018 23:37:29 +0800 (CST)
Received: from S00293818-DELL1.huawei.com (10.202.226.54) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.382.0; Mon, 16 Jul 2018 23:37:21 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next 7/9] net: hns3: Fix for reset_level default assignment probelm
Date:   Mon, 16 Jul 2018 16:36:25 +0100
Message-ID: <20180716153627.476-8-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716153627.476-1-salil.mehta@huawei.com>
References: <20180716153627.476-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

handle->reset_level is assigned to HNAE3_NONE_RESET when client is
initialized, if a tx timeout happens right after initialization,
then handle->reset_level is not resetted to HNAE3_FUNC_RESET in
hclge_reset_event, which will cause reset event not properly
handled problem.

This patch fixes it by setting handle->reset_level properly when
client is initialized.

Fixes: 6d4c3981a8d8 ("net: hns3: Changes to make enet watchdog timeout func common for PF/VF")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 24f82b7..29be96e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3085,7 +3085,6 @@ static int hns3_client_init(struct hnae3_handle *handle)
 	priv->dev = &pdev->dev;
 	priv->netdev = netdev;
 	priv->ae_handle = handle;
-	priv->ae_handle->reset_level = HNAE3_NONE_RESET;
 	priv->ae_handle->last_reset_time = jiffies;
 	priv->tx_timeout_count = 0;
 
@@ -3106,6 +3105,11 @@ static int hns3_client_init(struct hnae3_handle *handle)
 	/* Carrier off reporting is important to ethtool even BEFORE open */
 	netif_carrier_off(netdev);
 
+	if (handle->flags & HNAE3_SUPPORT_VF)
+		handle->reset_level = HNAE3_VF_RESET;
+	else
+		handle->reset_level = HNAE3_FUNC_RESET;
+
 	ret = hns3_get_ring_config(priv);
 	if (ret) {
 		ret = -ENOMEM;
-- 
2.7.4


