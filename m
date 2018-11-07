Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A30C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFA12086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDFA12086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbeKGNeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 08:34:50 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:14601 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727289AbeKGNeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 08:34:50 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A50AEAE1939A;
        Wed,  7 Nov 2018 12:06:11 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Wed, 7 Nov 2018 12:06:07 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>
Subject: [Patch net-next 10/12] net: hns3: call roce's reset notify callback when resetting
Date:   Wed, 7 Nov 2018 12:06:16 +0800
Message-ID: <1541563578-28973-11-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541563578-28973-1-git-send-email-tanhuazhong@huawei.com>
References: <1541563578-28973-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While doing resetting, roce should do its uninitailization part
before nic's, and do its initialization part after nic's.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 3c327f8..0c0327b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2315,6 +2315,34 @@ static int hclge_notify_client(struct hclge_dev *hdev,
 	return 0;
 }
 
+static int hclge_notify_roce_client(struct hclge_dev *hdev,
+				    enum hnae3_reset_notify_type type)
+{
+	struct hnae3_client *client = hdev->roce_client;
+	int ret = 0;
+	u16 i;
+
+	if (!client)
+		return 0;
+
+	if (!client->ops->reset_notify)
+		return -EOPNOTSUPP;
+
+	for (i = 0; i < hdev->num_vmdq_vport + 1; i++) {
+		struct hnae3_handle *handle = &hdev->vport[i].roce;
+
+		ret = client->ops->reset_notify(handle, type);
+		if (ret) {
+			dev_err(&hdev->pdev->dev,
+				"notify roce client failed %d(%d)",
+				type, ret);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
 static int hclge_reset_wait(struct hclge_dev *hdev)
 {
 #define HCLGE_RESET_WATI_MS	100
@@ -2501,6 +2529,7 @@ static void hclge_reset(struct hclge_dev *hdev)
 	hdev->reset_count++;
 	hdev->last_reset_time = jiffies;
 	/* perform reset of the stack & ae device for a client */
+	hclge_notify_roce_client(hdev, HNAE3_DOWN_CLIENT);
 	rtnl_lock();
 	hclge_notify_client(hdev, HNAE3_DOWN_CLIENT);
 	rtnl_unlock();
@@ -2508,6 +2537,7 @@ static void hclge_reset(struct hclge_dev *hdev)
 	hclge_reset_prepare_wait(hdev);
 
 	if (!hclge_reset_wait(hdev)) {
+		hclge_notify_roce_client(hdev, HNAE3_UNINIT_CLIENT);
 		rtnl_lock();
 		hclge_notify_client(hdev, HNAE3_UNINIT_CLIENT);
 		hclge_reset_ae_dev(hdev->ae_dev);
@@ -2524,6 +2554,9 @@ static void hclge_reset(struct hclge_dev *hdev)
 	hclge_notify_client(hdev, HNAE3_UP_CLIENT);
 	rtnl_unlock();
 	ae_dev->reset_type = HNAE3_NONE_RESET;
+
+	hclge_notify_roce_client(hdev, HNAE3_INIT_CLIENT);
+	hclge_notify_roce_client(hdev, HNAE3_UP_CLIENT);
 }
 
 static void hclge_reset_event(struct pci_dev *pdev, struct hnae3_handle *handle)
-- 
2.7.4

