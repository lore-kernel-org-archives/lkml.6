Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D048EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6EF208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6EF208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbeKGNfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 08:35:46 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:14604 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730915AbeKGNev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 08:34:51 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B412E19AA7220;
        Wed,  7 Nov 2018 12:06:11 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Wed, 7 Nov 2018 12:06:07 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>
Subject: [Patch net-next 09/12] net: hns3: adjust the process of PF reset
Date:   Wed, 7 Nov 2018 12:06:15 +0800
Message-ID: <1541563578-28973-10-git-send-email-tanhuazhong@huawei.com>
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

When doing PF reset, the driver needs to do some preparatory work
before asserting PF reset. Since when hardware is resetting, it
is necessary to stop tx/rx queue, clear hardware table, etc,
otherwise hardware may run into unrecoverable state if there is
still IO running when the hardware is resetting.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 38 ++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index a90c19e..3c327f8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2396,7 +2396,6 @@ static void hclge_do_reset(struct hclge_dev *hdev)
 		break;
 	case HNAE3_FUNC_RESET:
 		dev_info(&pdev->dev, "PF Reset requested\n");
-		hclge_func_reset_cmd(hdev, 0);
 		/* schedule again to check later */
 		set_bit(HNAE3_FUNC_RESET, &hdev->reset_pending);
 		hclge_reset_task_schedule(hdev);
@@ -2462,6 +2461,35 @@ static void hclge_clear_reset_cause(struct hclge_dev *hdev)
 	hclge_enable_vector(&hdev->misc_vector, true);
 }
 
+static int hclge_reset_prepare_wait(struct hclge_dev *hdev)
+{
+	int ret = 0;
+
+	switch (hdev->reset_type) {
+	case HNAE3_FUNC_RESET:
+		ret = hclge_func_reset_cmd(hdev, 0);
+		if (ret) {
+			dev_err(&hdev->pdev->dev,
+				"assertting function reset fail %d!\n", ret);
+			return ret;
+		}
+
+		/* After performaning pf reset, it is not necessary to do the
+		 * mailbox handling or send any command to firmware, because
+		 * any mailbox handling or command to firmware is only valid
+		 * after hclge_cmd_init is called.
+		 */
+		set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
+		break;
+	default:
+		break;
+	}
+
+	dev_info(&hdev->pdev->dev, "prepare wait ok\n");
+
+	return ret;
+}
+
 static void hclge_reset(struct hclge_dev *hdev)
 {
 	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(hdev->pdev);
@@ -2477,6 +2505,8 @@ static void hclge_reset(struct hclge_dev *hdev)
 	hclge_notify_client(hdev, HNAE3_DOWN_CLIENT);
 	rtnl_unlock();
 
+	hclge_reset_prepare_wait(hdev);
+
 	if (!hclge_reset_wait(hdev)) {
 		rtnl_lock();
 		hclge_notify_client(hdev, HNAE3_UNINIT_CLIENT);
@@ -4873,7 +4903,11 @@ static void hclge_ae_stop(struct hnae3_handle *handle)
 	cancel_work_sync(&hdev->service_task);
 	clear_bit(HCLGE_STATE_SERVICE_SCHED, &hdev->state);
 
-	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state)) {
+	/* If it is not PF reset, the firmware will disable the MAC,
+	 * so it only need to stop phy here.
+	 */
+	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state) &&
+	    hdev->reset_type != HNAE3_FUNC_RESET) {
 		hclge_mac_stop_phy(hdev);
 		return;
 	}
-- 
2.7.4

