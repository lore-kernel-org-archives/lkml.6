Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27624C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 14:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB82820880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 14:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB82820880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbeI2V1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 17:27:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13585 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728298AbeI2V1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 17:27:50 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6610055FA0BDC;
        Sat, 29 Sep 2018 22:59:02 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.85.66) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.399.0; Sat, 29 Sep 2018 22:58:54 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH V2 net-next 09/10] net: hns3: Modify hns3_get_max_available_channels
Date:   Sat, 29 Sep 2018 15:56:21 +0100
Message-ID: <20180929145622.5448-10-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180929145622.5448-1-salil.mehta@huawei.com>
References: <20180929145622.5448-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.85.66]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

The current hns3_get_max_available_channels returns the total number
of queues for the device, which makes ethtool -L set the number of queues
per channel queues incorrectly, so hns3_get_max_available_channels should
return the maximum available number of queues per channel, depending on
the total number of queues allocated and the hardware configurations.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h               |  2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c           | 14 ++++++++------
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 10 ++--------
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c |  4 ++--
 4 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 8581e16ec2f1..dea422c53738 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -403,7 +403,7 @@ struct hnae3_ae_ops {
 	void (*get_channels)(struct hnae3_handle *handle,
 			     struct ethtool_channels *ch);
 	void (*get_tqps_and_rss_info)(struct hnae3_handle *h,
-				      u16 *free_tqps, u16 *max_rss_size);
+				      u16 *alloc_tqps, u16 *max_rss_size);
 	int (*set_channels)(struct hnae3_handle *handle, u32 new_tqps_num);
 	void (*get_flowctrl_adv)(struct hnae3_handle *handle,
 				 u32 *flowctrl_adv);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 545777ae2bc6..8273c03bbb4a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -307,12 +307,12 @@ static int hns3_nic_set_real_num_queue(struct net_device *netdev)
 
 static u16 hns3_get_max_available_channels(struct hnae3_handle *h)
 {
-	u16 free_tqps, max_rss_size, max_tqps;
+	u16 alloc_tqps, max_rss_size, rss_size;
 
-	h->ae_algo->ops->get_tqps_and_rss_info(h, &free_tqps, &max_rss_size);
-	max_tqps = h->kinfo.num_tc * max_rss_size;
+	h->ae_algo->ops->get_tqps_and_rss_info(h, &alloc_tqps, &max_rss_size);
+	rss_size = alloc_tqps / h->kinfo.num_tc;
 
-	return min_t(u16, max_tqps, (free_tqps + h->kinfo.num_tqps));
+	return min_t(u16, rss_size, max_rss_size);
 }
 
 static int hns3_nic_net_up(struct net_device *netdev)
@@ -3164,12 +3164,14 @@ static void hns3_nic_set_priv_ops(struct net_device *netdev)
 static int hns3_client_init(struct hnae3_handle *handle)
 {
 	struct pci_dev *pdev = handle->pdev;
+	u16 alloc_tqps, max_rss_size;
 	struct hns3_nic_priv *priv;
 	struct net_device *netdev;
 	int ret;
 
-	netdev = alloc_etherdev_mq(sizeof(struct hns3_nic_priv),
-				   hns3_get_max_available_channels(handle));
+	handle->ae_algo->ops->get_tqps_and_rss_info(handle, &alloc_tqps,
+						    &max_rss_size);
+	netdev = alloc_etherdev_mq(sizeof(struct hns3_nic_priv), alloc_tqps);
 	if (!netdev)
 		return -ENOMEM;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index e2dc45c9c950..7c8b686b1ce1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5659,18 +5659,12 @@ static void hclge_get_channels(struct hnae3_handle *handle,
 }
 
 static void hclge_get_tqps_and_rss_info(struct hnae3_handle *handle,
-					u16 *free_tqps, u16 *max_rss_size)
+					u16 *alloc_tqps, u16 *max_rss_size)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
-	u16 temp_tqps = 0;
-	int i;
 
-	for (i = 0; i < hdev->num_tqps; i++) {
-		if (!hdev->htqp[i].alloced)
-			temp_tqps++;
-	}
-	*free_tqps = temp_tqps;
+	*alloc_tqps = vport->alloc_tqps;
 	*max_rss_size = hdev->rss_size_max;
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 978193123c71..8f858cb2a67b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1975,11 +1975,11 @@ static void hclgevf_get_channels(struct hnae3_handle *handle,
 }
 
 static void hclgevf_get_tqps_and_rss_info(struct hnae3_handle *handle,
-					  u16 *free_tqps, u16 *max_rss_size)
+					  u16 *alloc_tqps, u16 *max_rss_size)
 {
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
 
-	*free_tqps = 0;
+	*alloc_tqps = hdev->num_tqps;
 	*max_rss_size = hdev->rss_size_max;
 }
 
-- 
2.11.0


