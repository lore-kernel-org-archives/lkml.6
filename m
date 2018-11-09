Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7441C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DA320825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82DA320825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbeKIXtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:49:14 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15072 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728520AbeKIXtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:49:14 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0EA7429F787F6;
        Fri,  9 Nov 2018 22:07:50 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Fri, 9 Nov 2018 22:07:45 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>
Subject: [Patch net-next 06/11] net: hns3: add error handler for hclgevf_reset()
Date:   Fri, 9 Nov 2018 22:07:51 +0800
Message-ID: <1541772476-41478-7-git-send-email-tanhuazhong@huawei.com>
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

Since hclgevf_reset() may fail for some reasons, so it needs an error
handler to deal with it. When VF reset failed, VF can only be restored
by a higher level reset asserted by PF. So, it needs to reinitialize
its command queue, then it can respond to higher level reset.

Also, this patch adds error logging in the hclgevf_notify_client().

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 51 ++++++++++++++++------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 5da9053..4dfac6c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1086,11 +1086,17 @@ static int hclgevf_notify_client(struct hclgevf_dev *hdev,
 {
 	struct hnae3_client *client = hdev->nic_client;
 	struct hnae3_handle *handle = &hdev->nic;
+	int ret;
 
 	if (!client->ops->reset_notify)
 		return -EOPNOTSUPP;
 
-	return client->ops->reset_notify(handle, type);
+	ret = client->ops->reset_notify(handle, type);
+	if (ret)
+		dev_err(&hdev->pdev->dev, "notify nic client failed %d(%d)\n",
+			type, ret);
+
+	return ret;
 }
 
 static int hclgevf_reset_wait(struct hclgevf_dev *hdev)
@@ -1133,7 +1139,9 @@ static int hclgevf_reset_stack(struct hclgevf_dev *hdev)
 	int ret;
 
 	/* uninitialize the nic client */
-	hclgevf_notify_client(hdev, HNAE3_UNINIT_CLIENT);
+	ret = hclgevf_notify_client(hdev, HNAE3_UNINIT_CLIENT);
+	if (ret)
+		return ret;
 
 	/* re-initialize the hclge device */
 	ret = hclgevf_reset_hdev(hdev);
@@ -1144,7 +1152,9 @@ static int hclgevf_reset_stack(struct hclgevf_dev *hdev)
 	}
 
 	/* bring up the nic client again */
-	hclgevf_notify_client(hdev, HNAE3_INIT_CLIENT);
+	ret = hclgevf_notify_client(hdev, HNAE3_INIT_CLIENT);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -1183,11 +1193,15 @@ static int hclgevf_reset(struct hclgevf_dev *hdev)
 	rtnl_lock();
 
 	/* bring down the nic to stop any ongoing TX/RX */
-	hclgevf_notify_client(hdev, HNAE3_DOWN_CLIENT);
+	ret = hclgevf_notify_client(hdev, HNAE3_DOWN_CLIENT);
+	if (ret)
+		goto err_reset_lock;
 
 	rtnl_unlock();
 
-	hclgevf_reset_prepare_wait(hdev);
+	ret = hclgevf_reset_prepare_wait(hdev);
+	if (ret)
+		goto err_reset;
 
 	/* check if VF could successfully fetch the hardware reset completion
 	 * status from the hardware
@@ -1198,28 +1212,37 @@ static int hclgevf_reset(struct hclgevf_dev *hdev)
 		dev_err(&hdev->pdev->dev,
 			"VF failed(=%d) to fetch H/W reset completion status\n",
 			ret);
-
-		dev_warn(&hdev->pdev->dev, "VF reset failed, disabling VF!\n");
-		rtnl_lock();
-		hclgevf_notify_client(hdev, HNAE3_UNINIT_CLIENT);
-
-		rtnl_unlock();
-		return ret;
+		goto err_reset;
 	}
 
 	rtnl_lock();
 
 	/* now, re-initialize the nic client and ae device*/
 	ret = hclgevf_reset_stack(hdev);
-	if (ret)
+	if (ret) {
 		dev_err(&hdev->pdev->dev, "failed to reset VF stack\n");
+		goto err_reset_lock;
+	}
 
 	/* bring up the nic to enable TX/RX again */
-	hclgevf_notify_client(hdev, HNAE3_UP_CLIENT);
+	ret = hclgevf_notify_client(hdev, HNAE3_UP_CLIENT);
+	if (ret)
+		goto err_reset_lock;
 
 	rtnl_unlock();
 
 	return ret;
+err_reset_lock:
+	rtnl_unlock();
+err_reset:
+	/* When VF reset failed, only the higher level reset asserted by PF
+	 * can restore it, so re-initialize the command queue to receive
+	 * this higher reset event.
+	 */
+	hclgevf_cmd_init(hdev);
+	dev_err(&hdev->pdev->dev, "failed to reset VF\n");
+
+	return ret;
 }
 
 static enum hnae3_reset_type hclgevf_get_reset_level(struct hclgevf_dev *hdev,
-- 
2.7.4

