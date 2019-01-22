Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F86C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE36B2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbfAVQlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:41:51 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:58492 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729037AbfAVQkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:40:09 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 09F67E04762200A1FB4E;
        Wed, 23 Jan 2019 00:40:05 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.54.154) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Wed, 23 Jan 2019 00:39:57 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 04/12] net: hns3: fix rss configuration lost problem when setting channel
Date:   Wed, 23 Jan 2019 00:39:32 +0800
Message-ID: <20190122163940.7876-5-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190122163940.7876-1-tanhuazhong@huawei.com>
References: <20190122163940.7876-1-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.54.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

Currently rss configuration set by user will be lost when setting
channel.

This patch fixes it by not setting rss configuration to default
if user has configured the rss.

Fixes: 09f2af6405b8 ("net: hns3: add support to modify tqps number")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h             | 3 ++-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c         | 6 ++++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 8 +++++++-
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index d486748d5883..dc3db45361d3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -433,7 +433,8 @@ struct hnae3_ae_ops {
 			     struct ethtool_channels *ch);
 	void (*get_tqps_and_rss_info)(struct hnae3_handle *h,
 				      u16 *alloc_tqps, u16 *max_rss_size);
-	int (*set_channels)(struct hnae3_handle *handle, u32 new_tqps_num);
+	int (*set_channels)(struct hnae3_handle *handle, u32 new_tqps_num,
+			    bool rxfh_configured);
 	void (*get_flowctrl_adv)(struct hnae3_handle *handle,
 				 u32 *flowctrl_adv);
 	int (*set_led_id)(struct hnae3_handle *handle,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 2b4199fe0e57..0a546ee03f92 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -4166,6 +4166,7 @@ int hns3_set_channels(struct net_device *netdev,
 {
 	struct hnae3_handle *h = hns3_get_handle(netdev);
 	struct hnae3_knic_private_info *kinfo = &h->kinfo;
+	bool rxfh_configured = netif_is_rxfh_configured(netdev);
 	u32 new_tqp_num = ch->combined_count;
 	u16 org_tqp_num;
 	int ret;
@@ -4193,9 +4194,10 @@ int hns3_set_channels(struct net_device *netdev,
 		return ret;
 
 	org_tqp_num = h->kinfo.num_tqps;
-	ret = h->ae_algo->ops->set_channels(h, new_tqp_num);
+	ret = h->ae_algo->ops->set_channels(h, new_tqp_num, rxfh_configured);
 	if (ret) {
-		ret = h->ae_algo->ops->set_channels(h, org_tqp_num);
+		ret = h->ae_algo->ops->set_channels(h, org_tqp_num,
+						    rxfh_configured);
 		if (ret) {
 			/* If revert to old tqp failed, fatal error occurred */
 			dev_err(&netdev->dev,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index bf0931c6764f..3ba8de93bc3d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -7518,7 +7518,8 @@ static void hclge_get_tqps_and_rss_info(struct hnae3_handle *handle,
 	*max_rss_size = hdev->rss_size_max;
 }
 
-static int hclge_set_channels(struct hnae3_handle *handle, u32 new_tqps_num)
+static int hclge_set_channels(struct hnae3_handle *handle, u32 new_tqps_num,
+			      bool rxfh_configured)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hnae3_knic_private_info *kinfo = &vport->nic.kinfo;
@@ -7557,6 +7558,10 @@ static int hclge_set_channels(struct hnae3_handle *handle, u32 new_tqps_num)
 	if (ret)
 		return ret;
 
+	/* RSS indirection table has been configuared by user */
+	if (rxfh_configured)
+		goto out;
+
 	/* Reinitializes the rss indirect table according to the new RSS size */
 	rss_indir = kcalloc(HCLGE_RSS_IND_TBL_SIZE, sizeof(u32), GFP_KERNEL);
 	if (!rss_indir)
@@ -7572,6 +7577,7 @@ static int hclge_set_channels(struct hnae3_handle *handle, u32 new_tqps_num)
 
 	kfree(rss_indir);
 
+out:
 	if (!ret)
 		dev_info(&hdev->pdev->dev,
 			 "Channels changed, rss_size from %d to %d, tqps from %d to %d",
-- 
2.20.1


