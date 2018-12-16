Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842AFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536A0217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbeLQG0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 01:26:34 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16141 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726256AbeLQG0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 01:26:34 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 71010EBA08F52;
        Mon, 17 Dec 2018 14:26:29 +0800 (CST)
Received: from localhost.localdomain (10.175.34.53) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Mon, 17 Dec 2018 14:26:22 +0800
From:   Xue Chaojing <xuechaojing@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <xuechaojing@huawei.com>,
        <netdev@vger.kernel.org>, <wulike1@huawei.com>,
        <chiqijun@huawei.com>, <fy.wang@huawei.com>, <tony.qu@huawei.com>,
        <luoshaokai@huawei.com>, <nhorman@redhat.com>
Subject: [PATCH 1/1] net-next/hinic:optmize rx refill buffer mechanism
Date:   Sun, 16 Dec 2018 22:32:34 +0000
Message-ID: <20181216223234.24031-1-xuechaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.34.53]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In rx_alloc_pkts(), there is no need to schedule a different tasklet for
refill and it will cause some extra overhead. this patch remove it.

Suggested-by: Neil Horman <nhorman@redhat.com>
Signed-off-by: Xue Chaojing <xuechaojing@huawei.com>
---
 drivers/net/ethernet/huawei/hinic/hinic_rx.c | 23 +++++---------------
 drivers/net/ethernet/huawei/hinic/hinic_rx.h |  2 --
 2 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_rx.c b/drivers/net/ethernet/huawei/hinic/hinic_rx.c
index f86f2e693224..0098b206e7e9 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_rx.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_rx.c
@@ -43,6 +43,7 @@
 #define RX_IRQ_NO_LLI_TIMER             0
 #define RX_IRQ_NO_CREDIT                0
 #define RX_IRQ_NO_RESEND_TIMER          0
+#define HINIC_RX_BUFFER_WRITE           16
 
 /**
  * hinic_rxq_clean_stats - Clean the statistics of specific queue
@@ -229,7 +230,6 @@ static int rx_alloc_pkts(struct hinic_rxq *rxq)
 		wmb();  /* write all the wqes before update PI */
 
 		hinic_rq_update(rxq->rq, prod_idx);
-		tasklet_schedule(&rxq->rx_task);
 	}
 
 	return i;
@@ -258,17 +258,6 @@ static void free_all_rx_skbs(struct hinic_rxq *rxq)
 	}
 }
 
-/**
- * rx_alloc_task - tasklet for queue allocation
- * @data: rx queue
- **/
-static void rx_alloc_task(unsigned long data)
-{
-	struct hinic_rxq *rxq = (struct hinic_rxq *)data;
-
-	(void)rx_alloc_pkts(rxq);
-}
-
 /**
  * rx_recv_jumbo_pkt - Rx handler for jumbo pkt
  * @rxq: rx queue
@@ -333,6 +322,7 @@ static int rxq_recv(struct hinic_rxq *rxq, int budget)
 	struct hinic_qp *qp = container_of(rxq->rq, struct hinic_qp, rq);
 	u64 pkt_len = 0, rx_bytes = 0;
 	struct hinic_rq_wqe *rq_wqe;
+	unsigned int free_wqebbs;
 	int num_wqes, pkts = 0;
 	struct hinic_sge sge;
 	struct sk_buff *skb;
@@ -376,8 +366,9 @@ static int rxq_recv(struct hinic_rxq *rxq, int budget)
 		rx_bytes += pkt_len;
 	}
 
-	if (pkts)
-		tasklet_schedule(&rxq->rx_task); /* rx_alloc_pkts */
+	free_wqebbs = hinic_get_rq_free_wqebbs(rxq->rq);
+	if (free_wqebbs > HINIC_RX_BUFFER_WRITE)
+		rx_alloc_pkts(rxq);
 
 	u64_stats_update_begin(&rxq->rxq_stats.syncp);
 	rxq->rxq_stats.pkts += pkts;
@@ -494,8 +485,6 @@ int hinic_init_rxq(struct hinic_rxq *rxq, struct hinic_rq *rq,
 
 	sprintf(rxq->irq_name, "hinic_rxq%d", qp->q_id);
 
-	tasklet_init(&rxq->rx_task, rx_alloc_task, (unsigned long)rxq);
-
 	pkts = rx_alloc_pkts(rxq);
 	if (!pkts) {
 		err = -ENOMEM;
@@ -512,7 +501,6 @@ int hinic_init_rxq(struct hinic_rxq *rxq, struct hinic_rq *rq,
 
 err_req_rx_irq:
 err_rx_pkts:
-	tasklet_kill(&rxq->rx_task);
 	free_all_rx_skbs(rxq);
 	devm_kfree(&netdev->dev, rxq->irq_name);
 	return err;
@@ -528,7 +516,6 @@ void hinic_clean_rxq(struct hinic_rxq *rxq)
 
 	rx_free_irq(rxq);
 
-	tasklet_kill(&rxq->rx_task);
 	free_all_rx_skbs(rxq);
 	devm_kfree(&netdev->dev, rxq->irq_name);
 }
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_rx.h b/drivers/net/ethernet/huawei/hinic/hinic_rx.h
index ab3fabab91b2..f8ed3fa6c8ee 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_rx.h
+++ b/drivers/net/ethernet/huawei/hinic/hinic_rx.h
@@ -42,8 +42,6 @@ struct hinic_rxq {
 
 	char                    *irq_name;
 
-	struct tasklet_struct   rx_task;
-
 	struct napi_struct      napi;
 };
 
-- 
2.17.1

