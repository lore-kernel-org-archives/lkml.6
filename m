Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA33EC282C8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54A2214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfAZQuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 11:50:06 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2679 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726398AbfAZQuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 11:50:03 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E52C6F1CB3A14CFC21DB;
        Sun, 27 Jan 2019 00:49:58 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.143.145) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Sun, 27 Jan 2019 00:49:52 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Jian Shen <shenjian15@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 11/12] net: hns3: add initialization for nic state
Date:   Sun, 27 Jan 2019 00:49:20 +0800
Message-ID: <20190126164921.3872-12-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190126164921.3872-1-tanhuazhong@huawei.com>
References: <20190126164921.3872-1-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.143.145]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

This patch adds initialization for nic state, sets flag
HNS3_NIC_STATE_DOWN when initialize, clears it before
vectors and napi being enabled in the hns3_nic_net_up(),
and sets it back in the error handler.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 216f3dd25cd6..4b38c37eef8f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -348,6 +348,8 @@ static int hns3_nic_net_up(struct net_device *netdev)
 		return ret;
 	}
 
+	clear_bit(HNS3_NIC_STATE_DOWN, &priv->state);
+
 	/* enable the vectors */
 	for (i = 0; i < priv->vector_num; i++)
 		hns3_vector_enable(&priv->tqp_vector[i]);
@@ -361,11 +363,10 @@ static int hns3_nic_net_up(struct net_device *netdev)
 	if (ret)
 		goto out_start_err;
 
-	clear_bit(HNS3_NIC_STATE_DOWN, &priv->state);
-
 	return 0;
 
 out_start_err:
+	set_bit(HNS3_NIC_STATE_DOWN, &priv->state);
 	while (j--)
 		hns3_tqp_disable(h->kinfo.tqp[j]);
 
@@ -3614,6 +3615,7 @@ static int hns3_client_init(struct hnae3_handle *handle)
 	priv->netdev = netdev;
 	priv->ae_handle = handle;
 	priv->tx_timeout_count = 0;
+	set_bit(HNS3_NIC_STATE_DOWN, &priv->state);
 
 	handle->kinfo.netdev = netdev;
 	handle->priv = (void *)priv;
-- 
2.20.1


