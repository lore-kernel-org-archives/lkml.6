Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06887C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 04:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9241A2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 04:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9241A2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389107AbeKPOK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 09:10:57 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:36587 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727142AbeKPOK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 09:10:57 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EB46B6FF4EEB;
        Fri, 16 Nov 2018 12:00:10 +0800 (CST)
Received: from localhost.localdomain (10.175.34.53) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.408.0; Fri, 16 Nov 2018 12:00:04 +0800
From:   Xue Chaojing <xuechaojing@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <xuechaojing@huawei.com>,
        <netdev@vger.kernel.org>, <wulike1@huawei.com>,
        <chiqijun@huawei.com>, <fy.wang@huawei.com>, <tony.qu@huawei.com>,
        <luoshaokai@huawei.com>
Subject: [PATCH 3/3] net-next/hinic: fix a bug in rx data flow
Date:   Thu, 15 Nov 2018 20:05:48 +0000
Message-ID: <20181115200548.5326-3-xuechaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181115200548.5326-1-xuechaojing@huawei.com>
References: <20181115200548.5326-1-xuechaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.34.53]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In rx_alloc_pkts(), there is a loop call of tasklet, which causes
100% cpu utilization, even no packets are being received. This patch
fixes this bug.

Signed-off-by: Xue Chaojing <xuechaojing@huawei.com>
---
 drivers/net/ethernet/huawei/hinic/hinic_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_rx.c b/drivers/net/ethernet/huawei/hinic/hinic_rx.c
index 93e8f207f6da..f86f2e693224 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_rx.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_rx.c
@@ -229,9 +229,9 @@ static int rx_alloc_pkts(struct hinic_rxq *rxq)
 		wmb();  /* write all the wqes before update PI */
 
 		hinic_rq_update(rxq->rq, prod_idx);
+		tasklet_schedule(&rxq->rx_task);
 	}
 
-	tasklet_schedule(&rxq->rx_task);
 	return i;
 }
 
-- 
2.17.1

