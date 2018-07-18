Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59597ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 04:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8F82084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 04:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8F82084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbeGRFFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 01:05:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9640 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725729AbeGRFFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 01:05:23 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 51E4E989A22BC;
        Wed, 18 Jul 2018 12:29:14 +0800 (CST)
Received: from localhost.localdomain (10.175.34.53) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.382.0; Wed, 18 Jul 2018 12:29:09 +0800
From:   Zhao Chen <zhaochen6@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <aviad.krawczyk@huawei.com>, <zhaochen6@huawei.com>,
        <tony.qu@huawei.com>, <yin.yinshi@huawei.com>,
        <luoshaokai@huawei.com>
Subject: [PATCH 1/1] net-next/hinic: fix a problem in hinic_xmit_frame()
Date:   Wed, 18 Jul 2018 00:33:18 -0400
Message-ID: <20180718043318.3211-1-zhaochen6@huawei.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.34.53]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The calculation of "wqe_size" is not correct when the tx queue is busy in
hinic_xmit_frame().

When there are no free WQEs, the tx flow will unmap the skb buffer, then
ring the doobell for the pending packets. But the "wqe_size" which used
to calculate the doorbell address is not correct. The wqe size should be
cleared to 0, otherwise, it will cause a doorbell error.

This patch fixes the problem.

Reported-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Zhao Chen <zhaochen6@huawei.com>
---
 drivers/net/ethernet/huawei/hinic/hinic_tx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_tx.c b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
index 9128858479c4..2353ec829c04 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_tx.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
@@ -229,6 +229,7 @@ netdev_tx_t hinic_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 		txq->txq_stats.tx_busy++;
 		u64_stats_update_end(&txq->txq_stats.syncp);
 		err = NETDEV_TX_BUSY;
+		wqe_size = 0;
 		goto flush_skbs;
 	}
 
-- 
2.17.0

