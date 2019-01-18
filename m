Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B956C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5928B20883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfARIOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:14:25 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2198 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727579AbfARIN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:13:57 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DB2BD670F80899C2A5C3;
        Fri, 18 Jan 2019 16:13:54 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Fri, 18 Jan 2019 16:13:44 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [PATCH net-next 11/12] net: hns3: do reinitialization while ETS configuration changed
Date:   Fri, 18 Jan 2019 16:13:13 +0800
Message-ID: <1547799194-38212-12-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547799194-38212-1-git-send-email-tanhuazhong@huawei.com>
References: <1547799194-38212-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the ETS information is changed, the network device needs to be
re-initialized, otherwise the information such as the receiving queue
will be incorrect.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c         | 14 +-------------
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c  | 17 +++++++++++++++++
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c |  4 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h |  2 ++
 4 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 0bda9bd..10cc865 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3728,7 +3728,6 @@ static int hns3_client_setup_tc(struct hnae3_handle *handle, u8 tc)
 {
 	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
 	struct net_device *ndev = kinfo->netdev;
-	bool if_running;
 	int ret;
 
 	if (tc > HNAE3_MAX_TC)
@@ -3737,24 +3736,13 @@ static int hns3_client_setup_tc(struct hnae3_handle *handle, u8 tc)
 	if (!ndev)
 		return -ENODEV;
 
-	if_running = netif_running(ndev);
-
-	if (if_running) {
-		(void)hns3_nic_net_stop(ndev);
-		msleep(100);
-	}
-
 	ret = (kinfo->dcb_ops && kinfo->dcb_ops->map_update) ?
 		kinfo->dcb_ops->map_update(handle) : -EOPNOTSUPP;
 	if (ret)
-		goto err_out;
+		return ret;
 
 	ret = hns3_nic_set_real_num_queue(ndev);
 
-err_out:
-	if (if_running)
-		(void)hns3_nic_net_open(ndev);
-
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index f6323b2..4ec0b9c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -222,6 +222,16 @@ static int hclge_ieee_setets(struct hnae3_handle *h, struct ieee_ets *ets)
 	if (ret)
 		return ret;
 
+	if (map_changed) {
+		ret = hclge_notify_client(hdev, HNAE3_DOWN_CLIENT);
+		if (ret)
+			return ret;
+
+		ret = hclge_notify_client(hdev, HNAE3_UNINIT_CLIENT);
+		if (ret)
+			return ret;
+	}
+
 	hclge_tm_schd_info_update(hdev, num_tc);
 
 	ret = hclge_ieee_ets_to_tm_info(hdev, ets);
@@ -232,6 +242,13 @@ static int hclge_ieee_setets(struct hnae3_handle *h, struct ieee_ets *ets)
 		ret = hclge_client_setup_tc(hdev);
 		if (ret)
 			return ret;
+		ret = hclge_notify_client(hdev, HNAE3_INIT_CLIENT);
+		if (ret)
+			return ret;
+
+		ret = hclge_notify_client(hdev, HNAE3_UP_CLIENT);
+		if (ret)
+			return ret;
 	}
 
 	return hclge_tm_dwrr_cfg(hdev);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 450094c..97683a7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2401,8 +2401,8 @@ static void hclge_misc_irq_uninit(struct hclge_dev *hdev)
 	hclge_free_vector(hdev, 0);
 }
 
-static int hclge_notify_client(struct hclge_dev *hdev,
-			       enum hnae3_reset_notify_type type)
+int hclge_notify_client(struct hclge_dev *hdev,
+			enum hnae3_reset_notify_type type)
 {
 	struct hnae3_client *client = hdev->nic_client;
 	u16 i;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 6615b85..279ed2d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -878,4 +878,6 @@ void hclge_vport_stop(struct hclge_vport *vport);
 int hclge_set_vport_mtu(struct hclge_vport *vport, int new_mtu);
 int hclge_dbg_run_cmd(struct hnae3_handle *handle, char *cmd_buf);
 u16 hclge_covert_handle_qid_global(struct hnae3_handle *handle, u16 queue_id);
+int hclge_notify_client(struct hclge_dev *hdev,
+			enum hnae3_reset_notify_type type);
 #endif
-- 
2.7.4

