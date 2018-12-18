Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C912C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3347D217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeLRLCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:02:11 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38229 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726704AbeLRLCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:02:09 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EEB7D105ED591;
        Tue, 18 Dec 2018 19:02:03 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Tue, 18 Dec 2018 19:01:57 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 04/12] net: hns3: update some variables while hclge_reset()/hclgevf_reset() done
Date:   Tue, 18 Dec 2018 19:37:51 +0800
Message-ID: <1545133079-79605-5-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545133079-79605-1-git-send-email-lipeng321@huawei.com>
References: <1545133079-79605-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

When hclge_reset() completes successfully, it should update the
last_reset_time, set reset_fail_cnt to 0, and set reset_type of
hnae3_ae_dev to HNAE3_NONE_RESET.

Also when hclgevf_reset() completes successfully, it should update
the last_reset_time, and set reset_type of hnae3_ae_dev to
HNAE3_NONE_RESET.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 5 ++++-
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 3fe08cf..a8a2ccf 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2810,7 +2810,6 @@ static void hclge_reset(struct hclge_dev *hdev)
 	 */
 	ae_dev->reset_type = hdev->reset_type;
 	hdev->reset_count++;
-	hdev->last_reset_time = jiffies;
 	/* perform reset of the stack & ae device for a client */
 	ret = hclge_notify_roce_client(hdev, HNAE3_DOWN_CLIENT);
 	if (ret)
@@ -2873,6 +2872,10 @@ static void hclge_reset(struct hclge_dev *hdev)
 	if (ret)
 		goto err_reset;
 
+	hdev->last_reset_time = jiffies;
+	hdev->reset_fail_cnt = 0;
+	ae_dev->reset_type = HNAE3_NONE_RESET;
+
 	return;
 
 err_reset_lock:
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 86596ee..54ba93a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1342,6 +1342,9 @@ static int hclgevf_reset(struct hclgevf_dev *hdev)
 
 	rtnl_unlock();
 
+	hdev->last_reset_time = jiffies;
+	ae_dev->reset_type = HNAE3_NONE_RESET;
+
 	return ret;
 err_reset_lock:
 	rtnl_unlock();
-- 
1.9.1

