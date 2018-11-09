Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB19C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F01020825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F01020825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbeKIXsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:48:51 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15070 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727955AbeKIXsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:48:50 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0470C19F96A1E;
        Fri,  9 Nov 2018 22:07:50 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Fri, 9 Nov 2018 22:07:45 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>
Subject: [Patch net-next 05/11] net: hns3: stop handling command queue while resetting VF
Date:   Fri, 9 Nov 2018 22:07:50 +0800
Message-ID: <1541772476-41478-6-git-send-email-tanhuazhong@huawei.com>
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

According to hardware's description, after the reset occurs, the driver
needs to re-initialize the command queue before sending and receiving
any commands. Therefore, the VF's driver needs to identify the command
queue needs to re-initialize with HCLGEVF_STATE_CMD_DISABLE, and does
not allow sending or receiving commands before the re-initialization.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c  | 13 ++++++++++++-
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c |  3 +++
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h |  6 ++++++
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c  | 14 ++++++++++++++
 4 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
index b917acf..d5765c8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
@@ -189,7 +189,8 @@ int hclgevf_cmd_send(struct hclgevf_hw *hw, struct hclgevf_desc *desc, int num)
 
 	spin_lock_bh(&hw->cmq.csq.lock);
 
-	if (num > hclgevf_ring_space(&hw->cmq.csq)) {
+	if (num > hclgevf_ring_space(&hw->cmq.csq) ||
+	    test_bit(HCLGEVF_STATE_CMD_DISABLE, &hdev->state)) {
 		spin_unlock_bh(&hw->cmq.csq.lock);
 		return -EBUSY;
 	}
@@ -338,6 +339,16 @@ int hclgevf_cmd_init(struct hclgevf_dev *hdev)
 	spin_unlock_bh(&hdev->hw.cmq.crq.lock);
 	spin_unlock_bh(&hdev->hw.cmq.csq.lock);
 
+	clear_bit(HCLGEVF_STATE_CMD_DISABLE, &hdev->state);
+
+	/* Check if there is new reset pending, because the higher level
+	 * reset may happen when lower level reset is being processed.
+	 */
+	if (hclgevf_is_reset_pending(hdev)) {
+		set_bit(HCLGEVF_STATE_CMD_DISABLE, &hdev->state);
+		return -EBUSY;
+	}
+
 	/* get firmware version */
 	ret = hclgevf_cmd_query_firmware_version(&hdev->hw, &version);
 	if (ret) {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index fe97cc7..5da9053 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1162,6 +1162,8 @@ static int hclgevf_reset_prepare_wait(struct hclgevf_dev *hdev)
 		break;
 	}
 
+	set_bit(HCLGEVF_STATE_CMD_DISABLE, &hdev->state);
+
 	dev_info(&hdev->pdev->dev, "prepare reset(%d) wait done, ret:%d\n",
 		 hdev->reset_type, ret);
 
@@ -1467,6 +1469,7 @@ static enum hclgevf_evt_cause hclgevf_check_evt_cause(struct hclgevf_dev *hdev,
 			 "receive reset interrupt 0x%x!\n", rst_ing_reg);
 		set_bit(HNAE3_VF_RESET, &hdev->reset_pending);
 		set_bit(HCLGEVF_RESET_PENDING, &hdev->reset_state);
+		set_bit(HCLGEVF_STATE_CMD_DISABLE, &hdev->state);
 		cmdq_src_reg &= ~BIT(HCLGEVF_VECTOR0_RST_INT_B);
 		*clearval = cmdq_src_reg;
 		return HCLGEVF_VECTOR0_EVENT_RST;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index e37897d..ffe3d49 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -79,6 +79,7 @@ enum hclgevf_states {
 	HCLGEVF_STATE_RST_HANDLING,
 	HCLGEVF_STATE_MBX_SERVICE_SCHED,
 	HCLGEVF_STATE_MBX_HANDLING,
+	HCLGEVF_STATE_CMD_DISABLE,
 };
 
 #define HCLGEVF_MPF_ENBALE 1
@@ -212,6 +213,11 @@ struct hclgevf_dev {
 	u32 flag;
 };
 
+static inline bool hclgevf_is_reset_pending(struct hclgevf_dev *hdev)
+{
+	return !!hdev->reset_pending;
+}
+
 int hclgevf_send_mbx_msg(struct hclgevf_dev *hdev, u16 code, u16 subcode,
 			 const u8 *msg_data, u8 msg_len, bool need_resp,
 			 u8 *resp_data, u16 resp_len);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
index 01a028a..ef9c8e6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
@@ -40,6 +40,9 @@ static int hclgevf_get_mbx_resp(struct hclgevf_dev *hdev, u16 code0, u16 code1,
 	}
 
 	while ((!hdev->mbx_resp.received_resp) && (i < HCLGEVF_MAX_TRY_TIMES)) {
+		if (test_bit(HCLGEVF_STATE_CMD_DISABLE, &hdev->state))
+			return -EIO;
+
 		udelay(HCLGEVF_SLEEP_USCOEND);
 		i++;
 	}
@@ -148,6 +151,11 @@ void hclgevf_mbx_handler(struct hclgevf_dev *hdev)
 	crq = &hdev->hw.cmq.crq;
 
 	while (!hclgevf_cmd_crq_empty(&hdev->hw)) {
+		if (test_bit(HCLGEVF_STATE_CMD_DISABLE, &hdev->state)) {
+			dev_info(&hdev->pdev->dev, "vf crq need init\n");
+			return;
+		}
+
 		desc = &crq->desc[crq->next_to_use];
 		req = (struct hclge_mbx_pf_to_vf_cmd *)desc->data;
 
@@ -249,6 +257,12 @@ void hclgevf_mbx_async_handler(struct hclgevf_dev *hdev)
 
 	/* process all the async queue messages */
 	while (tail != hdev->arq.head) {
+		if (test_bit(HCLGEVF_STATE_CMD_DISABLE, &hdev->state)) {
+			dev_info(&hdev->pdev->dev,
+				 "vf crq need init in async\n");
+			return;
+		}
+
 		msg_q = hdev->arq.msg_q[hdev->arq.head];
 
 		switch (msg_q[0]) {
-- 
2.7.4

