Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2D4C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1E520825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1E520825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbeKIXss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:48:48 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:48883 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727793AbeKIXsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:48:47 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DFF389775CB52;
        Fri,  9 Nov 2018 22:07:55 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Fri, 9 Nov 2018 22:07:46 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>
Subject: [Patch net-next 07/11] net: hns3: stop napi polling when HNS3_NIC_STATE_DOWN is set
Date:   Fri, 9 Nov 2018 22:07:52 +0800
Message-ID: <1541772476-41478-8-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541772476-41478-1-git-send-email-tanhuazhong@huawei.com>
References: <1541772476-41478-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling napi_disable during reset down process, if NAPIF_STATE_MISSED
is set, napi_complete will call __napi_schedule to do the polling again.
So this patch uses HNS3_NIC_STATE_DOWN to ensure the polling is not
scheduled again.

Also, when napi_complete returns true, it means polling is scheduled
again, it is not neccssary to enable the interrupt.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index a42c8e5..0cd397c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -415,9 +415,6 @@ static void hns3_nic_net_down(struct net_device *netdev)
 	const struct hnae3_ae_ops *ops;
 	int i;
 
-	if (test_and_set_bit(HNS3_NIC_STATE_DOWN, &priv->state))
-		return;
-
 	/* disable vectors */
 	for (i = 0; i < priv->vector_num; i++)
 		hns3_vector_disable(&priv->tqp_vector[i]);
@@ -439,6 +436,11 @@ static void hns3_nic_net_down(struct net_device *netdev)
 
 static int hns3_nic_net_stop(struct net_device *netdev)
 {
+	struct hns3_nic_priv *priv = netdev_priv(netdev);
+
+	if (test_and_set_bit(HNS3_NIC_STATE_DOWN, &priv->state))
+		return 0;
+
 	netif_tx_stop_all_queues(netdev);
 	netif_carrier_off(netdev);
 
@@ -2699,6 +2701,7 @@ static void hns3_update_new_int_gl(struct hns3_enet_tqp_vector *tqp_vector)
 
 static int hns3_nic_common_poll(struct napi_struct *napi, int budget)
 {
+	struct hns3_nic_priv *priv = netdev_priv(napi->dev);
 	struct hns3_enet_ring *ring;
 	int rx_pkt_total = 0;
 
@@ -2707,6 +2710,11 @@ static int hns3_nic_common_poll(struct napi_struct *napi, int budget)
 	bool clean_complete = true;
 	int rx_budget;
 
+	if (unlikely(test_bit(HNS3_NIC_STATE_DOWN, &priv->state))) {
+		napi_complete(napi);
+		return 0;
+	}
+
 	/* Since the actual Tx work is minimal, we can give the Tx a larger
 	 * budget and be more aggressive about cleaning up the Tx descriptors.
 	 */
@@ -2731,9 +2739,11 @@ static int hns3_nic_common_poll(struct napi_struct *napi, int budget)
 	if (!clean_complete)
 		return budget;
 
-	napi_complete(napi);
-	hns3_update_new_int_gl(tqp_vector);
-	hns3_mask_vector_irq(tqp_vector, 1);
+	if (likely(!test_bit(HNS3_NIC_STATE_DOWN, &priv->state)) &&
+	    napi_complete(napi)) {
+		hns3_update_new_int_gl(tqp_vector);
+		hns3_mask_vector_irq(tqp_vector, 1);
+	}
 
 	return rx_pkt_total;
 }
-- 
2.7.4

