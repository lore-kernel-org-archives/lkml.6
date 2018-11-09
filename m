Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5012C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A30620825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A30620825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbeKIXtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:49:03 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15071 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728422AbeKIXtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:49:02 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 099F0A49D6DC5;
        Fri,  9 Nov 2018 22:07:50 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Fri, 9 Nov 2018 22:07:45 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>
Subject: [Patch net-next 04/11] net: hns3: add reset handling for VF when doing Core/Global/IMP reset
Date:   Fri, 9 Nov 2018 22:07:49 +0800
Message-ID: <1541772476-41478-5-git-send-email-tanhuazhong@huawei.com>
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

When a Core/Global/IMP reset occurs, the hardware sets the reset status
register of all PF/VF and reports a reset interrupt to all PF/VF and
firmware.

When receiving the reset interrupt:
1. The firmware will wait for 100 ms before resetting the hardware and
   clear the reset status register of all PF when hardware reset is done.
2. The PF/VF driver needs to down the netdev within 100 ms and then wait
   for hardware reset to finish.
3. After firmware clearing the reset status register of all PF, the PF
   driver reinitializes the hardware and clear the reset status register
   of it's VF.
4. After PF driver clearing the reset status register of VF, the VF driver
   reinitializes the hardware.

This patch mainly add handling for the step 4.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 50 ++++++++++++++++------
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |  8 ++++
 2 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 9405517..fe97cc7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1226,7 +1226,12 @@ static enum hnae3_reset_type hclgevf_get_reset_level(struct hclgevf_dev *hdev,
 	enum hnae3_reset_type rst_level = HNAE3_NONE_RESET;
 
 	/* return the highest priority reset level amongst all */
-	if (test_bit(HNAE3_VF_FULL_RESET, addr)) {
+	if (test_bit(HNAE3_VF_RESET, addr)) {
+		rst_level = HNAE3_VF_RESET;
+		clear_bit(HNAE3_VF_RESET, addr);
+		clear_bit(HNAE3_VF_PF_FUNC_RESET, addr);
+		clear_bit(HNAE3_VF_FUNC_RESET, addr);
+	} else if (test_bit(HNAE3_VF_FULL_RESET, addr)) {
 		rst_level = HNAE3_VF_FULL_RESET;
 		clear_bit(HNAE3_VF_FULL_RESET, addr);
 		clear_bit(HNAE3_VF_FUNC_RESET, addr);
@@ -1447,24 +1452,36 @@ static void hclgevf_clear_event_cause(struct hclgevf_dev *hdev, u32 regclr)
 	hclgevf_write_dev(&hdev->hw, HCLGEVF_VECTOR0_CMDQ_SRC_REG, regclr);
 }
 
-static bool hclgevf_check_event_cause(struct hclgevf_dev *hdev, u32 *clearval)
+static enum hclgevf_evt_cause hclgevf_check_evt_cause(struct hclgevf_dev *hdev,
+						      u32 *clearval)
 {
-	u32 cmdq_src_reg;
+	u32 cmdq_src_reg, rst_ing_reg;
 
 	/* fetch the events from their corresponding regs */
 	cmdq_src_reg = hclgevf_read_dev(&hdev->hw,
 					HCLGEVF_VECTOR0_CMDQ_SRC_REG);
 
+	if (BIT(HCLGEVF_VECTOR0_RST_INT_B) & cmdq_src_reg) {
+		rst_ing_reg = hclgevf_read_dev(&hdev->hw, HCLGEVF_RST_ING);
+		dev_info(&hdev->pdev->dev,
+			 "receive reset interrupt 0x%x!\n", rst_ing_reg);
+		set_bit(HNAE3_VF_RESET, &hdev->reset_pending);
+		set_bit(HCLGEVF_RESET_PENDING, &hdev->reset_state);
+		cmdq_src_reg &= ~BIT(HCLGEVF_VECTOR0_RST_INT_B);
+		*clearval = cmdq_src_reg;
+		return HCLGEVF_VECTOR0_EVENT_RST;
+	}
+
 	/* check for vector0 mailbox(=CMDQ RX) event source */
 	if (BIT(HCLGEVF_VECTOR0_RX_CMDQ_INT_B) & cmdq_src_reg) {
 		cmdq_src_reg &= ~BIT(HCLGEVF_VECTOR0_RX_CMDQ_INT_B);
 		*clearval = cmdq_src_reg;
-		return true;
+		return HCLGEVF_VECTOR0_EVENT_MBX;
 	}
 
 	dev_dbg(&hdev->pdev->dev, "vector 0 interrupt from unknown source\n");
 
-	return false;
+	return HCLGEVF_VECTOR0_EVENT_OTHER;
 }
 
 static void hclgevf_enable_vector(struct hclgevf_misc_vector *vector, bool en)
@@ -1474,19 +1491,28 @@ static void hclgevf_enable_vector(struct hclgevf_misc_vector *vector, bool en)
 
 static irqreturn_t hclgevf_misc_irq_handle(int irq, void *data)
 {
+	enum hclgevf_evt_cause event_cause;
 	struct hclgevf_dev *hdev = data;
 	u32 clearval;
 
 	hclgevf_enable_vector(&hdev->misc_vector, false);
-	if (!hclgevf_check_event_cause(hdev, &clearval))
-		goto skip_sched;
-
-	hclgevf_mbx_handler(hdev);
+	event_cause = hclgevf_check_evt_cause(hdev, &clearval);
 
-	hclgevf_clear_event_cause(hdev, clearval);
+	switch (event_cause) {
+	case HCLGEVF_VECTOR0_EVENT_RST:
+		hclgevf_reset_task_schedule(hdev);
+		break;
+	case HCLGEVF_VECTOR0_EVENT_MBX:
+		hclgevf_mbx_handler(hdev);
+		break;
+	default:
+		break;
+	}
 
-skip_sched:
-	hclgevf_enable_vector(&hdev->misc_vector, true);
+	if (event_cause != HCLGEVF_VECTOR0_EVENT_OTHER) {
+		hclgevf_clear_event_cause(hdev, clearval);
+		hclgevf_enable_vector(&hdev->misc_vector, true);
+	}
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index 2735414..e37897d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -31,6 +31,8 @@
 #define HCLGEVF_VECTOR0_CMDQ_SRC_REG	0x27100
 /* CMDQ register bits for RX event(=MBX event) */
 #define HCLGEVF_VECTOR0_RX_CMDQ_INT_B	1
+/* RST register bits for RESET event */
+#define HCLGEVF_VECTOR0_RST_INT_B	2
 
 #define HCLGEVF_TQP_RESET_TRY_TIMES	10
 /* Reset related Registers */
@@ -60,6 +62,12 @@
 #define HCLGEVF_S_IP_BIT		BIT(3)
 #define HCLGEVF_V_TAG_BIT		BIT(4)
 
+enum hclgevf_evt_cause {
+	HCLGEVF_VECTOR0_EVENT_RST,
+	HCLGEVF_VECTOR0_EVENT_MBX,
+	HCLGEVF_VECTOR0_EVENT_OTHER,
+};
+
 /* states of hclgevf device & tasks */
 enum hclgevf_states {
 	/* device states */
-- 
2.7.4

