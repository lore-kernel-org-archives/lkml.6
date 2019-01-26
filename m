Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CDDC282C9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE0E214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfAZQt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 11:49:58 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42306 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726197AbfAZQt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 11:49:57 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DC9933EA6119B8F4DE49;
        Sun, 27 Jan 2019 00:49:53 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.143.145) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Sun, 27 Jan 2019 00:49:46 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Jian Shen <shenjian15@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 01/12] net: hns3: don't update packet statistics for packets dropped by hardware
Date:   Sun, 27 Jan 2019 00:49:10 +0800
Message-ID: <20190126164921.3872-2-tanhuazhong@huawei.com>
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

Packet statistics for netdev should not include the packets dropped
by hardware.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 327dde2765ab..5ef3bdc7c808 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1425,9 +1425,7 @@ static void hns3_nic_get_stats64(struct net_device *netdev,
 			start = u64_stats_fetch_begin_irq(&ring->syncp);
 			tx_bytes += ring->stats.tx_bytes;
 			tx_pkts += ring->stats.tx_pkts;
-			tx_drop += ring->stats.tx_busy;
 			tx_drop += ring->stats.sw_err_cnt;
-			tx_errors += ring->stats.tx_busy;
 			tx_errors += ring->stats.sw_err_cnt;
 		} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
 
@@ -1438,7 +1436,6 @@ static void hns3_nic_get_stats64(struct net_device *netdev,
 			rx_bytes += ring->stats.rx_bytes;
 			rx_pkts += ring->stats.rx_pkts;
 			rx_drop += ring->stats.non_vld_descs;
-			rx_drop += ring->stats.err_pkt_len;
 			rx_drop += ring->stats.l2_err;
 			rx_errors += ring->stats.non_vld_descs;
 			rx_errors += ring->stats.l2_err;
-- 
2.20.1


