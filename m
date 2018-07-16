Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC524ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61820208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61820208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbeGPQFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:05:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46263 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727653AbeGPQFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:05:19 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AFF36F0AC063D;
        Mon, 16 Jul 2018 23:37:18 +0800 (CST)
Received: from S00293818-DELL1.huawei.com (10.202.226.54) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.382.0; Mon, 16 Jul 2018 23:37:10 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 3/9] net: hns3: Prevent to request reset frequently
Date:   Mon, 16 Jul 2018 16:36:21 +0100
Message-ID: <20180716153627.476-4-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716153627.476-1-salil.mehta@huawei.com>
References: <20180716153627.476-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

Netdevice reset should not be requested frequently, a new one
must wait a moment since there may be some work not completed.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 3886290..a1886a3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2819,7 +2819,10 @@ static void hclge_clear_reset_cause(struct hclge_dev *hdev)
 
 static void hclge_reset(struct hclge_dev *hdev)
 {
+	struct hnae3_handle *handle;
+
 	/* perform reset of the stack & ae device for a client */
+	handle = &hdev->vport[0].nic;
 	rtnl_lock();
 	hclge_notify_client(hdev, HNAE3_DOWN_CLIENT);
 
@@ -2836,6 +2839,7 @@ static void hclge_reset(struct hclge_dev *hdev)
 	}
 
 	hclge_notify_client(hdev, HNAE3_UP_CLIENT);
+	handle->last_reset_time = jiffies;
 	rtnl_unlock();
 }
 
@@ -2849,8 +2853,13 @@ static void hclge_reset_event(struct hnae3_handle *handle)
 	 * know this if last reset request did not occur very recently (watchdog
 	 * timer = 5*HZ, let us check after sufficiently large time, say 4*5*Hz)
 	 * In case of new request we reset the "reset level" to PF reset.
+	 * And if it is a repeat reset request of the most recent one then we
+	 * want to make sure we throttle the reset request. Therefore, we will
+	 * not allow it again before 3*HZ times.
 	 */
-	if (time_after(jiffies, (handle->last_reset_time + 4 * 5 * HZ)))
+	if (time_before(jiffies, (handle->last_reset_time + 3 * HZ)))
+		return;
+	else if (time_after(jiffies, (handle->last_reset_time + 4 * 5 * HZ)))
 		handle->reset_level = HNAE3_FUNC_RESET;
 
 	dev_info(&hdev->pdev->dev, "received reset event , reset type is %d",
@@ -2862,8 +2871,6 @@ static void hclge_reset_event(struct hnae3_handle *handle)
 
 	if (handle->reset_level < HNAE3_GLOBAL_RESET)
 		handle->reset_level++;
-
-	handle->last_reset_time = jiffies;
 }
 
 static void hclge_reset_subtask(struct hclge_dev *hdev)
-- 
2.7.4


