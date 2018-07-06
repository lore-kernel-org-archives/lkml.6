Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97697C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17EAC23F04
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17EAC23F04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932265AbeGFK3C (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:29:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55983 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753348AbeGFK27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:28:59 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2EA2AE23E89A4;
        Fri,  6 Jul 2018 18:28:56 +0800 (CST)
Received: from S00293818-DELL1.huawei.com (10.202.226.54) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.382.0; Fri, 6 Jul 2018 18:28:49 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next 01/10] net: hns3: Fix tc setup when netdev is first up
Date:   Fri, 6 Jul 2018 11:27:55 +0100
Message-ID: <20180706102804.196-2-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180706102804.196-1-salil.mehta@huawei.com>
References: <20180706102804.196-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

Currently, tc related configuration is not setup when the
netdev is first up, which cause the stack only using tc 0
problem.

This patch fixes it by setting the tc related configuration
using the info from NCL_CONFIG when netdev is first up.

Fixes: 76ad4f0ee747 ("net: hns3: Add support of HNS3 Ethernet Driver for hip08 SoC")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 78 ++++++++++---------------
 1 file changed, 31 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index f73c9df..e5e51e8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -239,7 +239,28 @@ static int hns3_nic_set_real_num_queue(struct net_device *netdev)
 	struct hnae3_handle *h = hns3_get_handle(netdev);
 	struct hnae3_knic_private_info *kinfo = &h->kinfo;
 	unsigned int queue_size = kinfo->rss_size * kinfo->num_tc;
-	int ret;
+	int i, ret;
+
+	if (kinfo->num_tc <= 1) {
+		netdev_reset_tc(netdev);
+	} else {
+		ret = netdev_set_num_tc(netdev, kinfo->num_tc);
+		if (ret) {
+			netdev_err(netdev,
+				   "netdev_set_num_tc fail, ret=%d!\n", ret);
+			return ret;
+		}
+
+		for (i = 0; i < HNAE3_MAX_TC; i++) {
+			if (!kinfo->tc_info[i].enable)
+				continue;
+
+			netdev_set_tc_queue(netdev,
+					    kinfo->tc_info[i].tc,
+					    kinfo->tc_info[i].tqp_count,
+					    kinfo->tc_info[i].tqp_offset);
+		}
+	}
 
 	ret = netif_set_real_num_tx_queues(netdev, queue_size);
 	if (ret) {
@@ -312,7 +333,9 @@ static int hns3_nic_net_up(struct net_device *netdev)
 static int hns3_nic_net_open(struct net_device *netdev)
 {
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
-	int ret;
+	struct hnae3_handle *h = hns3_get_handle(netdev);
+	struct hnae3_knic_private_info *kinfo;
+	int i, ret;
 
 	netif_carrier_off(netdev);
 
@@ -327,6 +350,12 @@ static int hns3_nic_net_open(struct net_device *netdev)
 		return ret;
 	}
 
+	kinfo = &h->kinfo;
+	for (i = 0; i < HNAE3_MAX_USER_PRIO; i++) {
+		netdev_set_prio_tc_map(netdev, i,
+				       kinfo->prio_tc[i]);
+	}
+
 	priv->ae_handle->last_reset_time = jiffies;
 	return 0;
 }
@@ -1307,7 +1336,6 @@ static int hns3_setup_tc(struct net_device *netdev, void *type_data)
 	u16 mode = mqprio_qopt->mode;
 	u8 hw = mqprio_qopt->qopt.hw;
 	bool if_running;
-	unsigned int i;
 	int ret;
 
 	if (!((hw == TC_MQPRIO_HW_OFFLOAD_TCS &&
@@ -1331,24 +1359,6 @@ static int hns3_setup_tc(struct net_device *netdev, void *type_data)
 	if (ret)
 		goto out;
 
-	if (tc <= 1) {
-		netdev_reset_tc(netdev);
-	} else {
-		ret = netdev_set_num_tc(netdev, tc);
-		if (ret)
-			goto out;
-
-		for (i = 0; i < HNAE3_MAX_TC; i++) {
-			if (!kinfo->tc_info[i].enable)
-				continue;
-
-			netdev_set_tc_queue(netdev,
-					    kinfo->tc_info[i].tc,
-					    kinfo->tc_info[i].tqp_count,
-					    kinfo->tc_info[i].tqp_offset);
-		}
-	}
-
 	ret = hns3_nic_set_real_num_queue(netdev);
 
 out:
@@ -3202,7 +3212,6 @@ static int hns3_client_setup_tc(struct hnae3_handle *handle, u8 tc)
 	struct net_device *ndev = kinfo->netdev;
 	bool if_running;
 	int ret;
-	u8 i;
 
 	if (tc > HNAE3_MAX_TC)
 		return -EINVAL;
@@ -3212,10 +3221,6 @@ static int hns3_client_setup_tc(struct hnae3_handle *handle, u8 tc)
 
 	if_running = netif_running(ndev);
 
-	ret = netdev_set_num_tc(ndev, tc);
-	if (ret)
-		return ret;
-
 	if (if_running) {
 		(void)hns3_nic_net_stop(ndev);
 		msleep(100);
@@ -3226,27 +3231,6 @@ static int hns3_client_setup_tc(struct hnae3_handle *handle, u8 tc)
 	if (ret)
 		goto err_out;
 
-	if (tc <= 1) {
-		netdev_reset_tc(ndev);
-		goto out;
-	}
-
-	for (i = 0; i < HNAE3_MAX_TC; i++) {
-		struct hnae3_tc_info *tc_info = &kinfo->tc_info[i];
-
-		if (tc_info->enable)
-			netdev_set_tc_queue(ndev,
-					    tc_info->tc,
-					    tc_info->tqp_count,
-					    tc_info->tqp_offset);
-	}
-
-	for (i = 0; i < HNAE3_MAX_USER_PRIO; i++) {
-		netdev_set_prio_tc_map(ndev, i,
-				       kinfo->prio_tc[i]);
-	}
-
-out:
 	ret = hns3_nic_set_real_num_queue(ndev);
 
 err_out:
-- 
2.7.4


