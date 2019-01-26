Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BB7C282C8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A68214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfAZQuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 11:50:14 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2678 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726070AbfAZQuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 11:50:03 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E004ADC3C9BAE3B3A471;
        Sun, 27 Jan 2019 00:49:58 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.143.145) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Sun, 27 Jan 2019 00:49:50 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 07/12] net: hns3: do reinitialization while mqprio configuration changed
Date:   Sun, 27 Jan 2019 00:49:16 +0800
Message-ID: <20190126164921.3872-8-tanhuazhong@huawei.com>
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

From: Yunsheng Lin <linyunsheng@huawei.com>

When user changes the mqprio configuration, enet need to be
uninited and inited besides down'ed and up'ed, because the queue
num may change when the TC num changes.

Also, it is more suitable to do the down/unint/init/up operation
in hclge module using hclge_notify_client, because this config
change may affect PF and its VF.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 17 ++-------------
 .../hisilicon/hns3/hns3pf/hclge_dcb.c         | 21 +++++++++++++++++--
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 322af28ab4b5..927a980fc211 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1482,7 +1482,6 @@ static int hns3_setup_tc(struct net_device *netdev, void *type_data)
 	u8 tc = mqprio_qopt->qopt.num_tc;
 	u16 mode = mqprio_qopt->mode;
 	u8 hw = mqprio_qopt->qopt.hw;
-	bool if_running;
 	int ret;
 
 	if (!((hw == TC_MQPRIO_HW_OFFLOAD_TCS &&
@@ -1495,24 +1494,12 @@ static int hns3_setup_tc(struct net_device *netdev, void *type_data)
 	if (!netdev)
 		return -EINVAL;
 
-	if_running = netif_running(netdev);
-	if (if_running) {
-		hns3_nic_net_stop(netdev);
-		msleep(100);
-	}
-
 	ret = (kinfo->dcb_ops && kinfo->dcb_ops->setup_tc) ?
 		kinfo->dcb_ops->setup_tc(h, tc, prio_tc) : -EOPNOTSUPP;
 	if (ret)
-		goto out;
-
-	ret = hns3_nic_set_real_num_queue(netdev);
-
-out:
-	if (if_running)
-		hns3_nic_net_open(netdev);
+		return ret;
 
-	return ret;
+	return hns3_nic_set_real_num_queue(netdev);
 }
 
 static int hns3_nic_setup_tc(struct net_device *dev, enum tc_setup_type type,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index 90b566e8e454..6c387b21f882 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -370,12 +370,25 @@ static int hclge_setup_tc(struct hnae3_handle *h, u8 tc, u8 *prio_tc)
 	if (ret)
 		return -EINVAL;
 
+	ret = hclge_notify_client(hdev, HNAE3_DOWN_CLIENT);
+	if (ret)
+		return ret;
+
+	ret = hclge_notify_client(hdev, HNAE3_UNINIT_CLIENT);
+	if (ret)
+		return ret;
+
 	hclge_tm_schd_info_update(hdev, tc);
 	hclge_tm_prio_tc_info_update(hdev, prio_tc);
 
 	ret = hclge_tm_init_hw(hdev, false);
-	if (ret)
+	if (ret) {
+		if (hclge_notify_client(hdev, HNAE3_INIT_CLIENT))
+			return ret;
+
+		hclge_notify_client(hdev, HNAE3_UP_CLIENT);
 		return ret;
+	}
 
 	hdev->flag &= ~HCLGE_FLAG_DCB_ENABLE;
 
@@ -384,7 +397,11 @@ static int hclge_setup_tc(struct hnae3_handle *h, u8 tc, u8 *prio_tc)
 	else
 		hdev->flag &= ~HCLGE_FLAG_MQPRIO_ENABLE;
 
-	return 0;
+	ret = hclge_notify_client(hdev, HNAE3_INIT_CLIENT);
+	if (ret)
+		return ret;
+
+	return hclge_notify_client(hdev, HNAE3_UP_CLIENT);
 }
 
 static const struct hnae3_dcb_ops hns3_dcb_ops = {
-- 
2.20.1


