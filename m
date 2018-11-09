Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6963BC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF0220840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF0220840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbeKIXso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:48:44 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:48890 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728422AbeKIXso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:48:44 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E4533B20DE9F6;
        Fri,  9 Nov 2018 22:07:55 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Fri, 9 Nov 2018 22:07:46 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>
Subject: [Patch net-next 08/11] net: hns3: implement the IMP reset processing for PF
Date:   Fri, 9 Nov 2018 22:07:53 +0800
Message-ID: <1541772476-41478-9-git-send-email-tanhuazhong@huawei.com>
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

The current code only print the prompt message after receiving
the IMP reset interrupt and does not perform the corresponding driver
reset operation. This patch implements the missing IMP reset handling
in the driver.
1. The driver sets the HCLGE_STATE_CMD_DISABLE to stop sending command
   after receiving the IMP reset interrupt.
2. The driver needs to notify the hardware to reload the IMP firmware.
3. The IMP firmware reloading makes the reset time of hardware longer,
   so it is necessary to extend the driver's waiting time to wait for
   the hardware reset to complete.
4. In hclge_check_event_cause, IMP reset event should have higher
   priority than other events.

Also, after clearing HCLGE_STATE_CMD_DISABLE in the hclge_cmd_init(),
it needs to check whether there is a pending reset, if so, just set
the HCLGE_STATE_CMD_DISABLE back and return.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c | 11 ++++++++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 27 +++++++++++++++-------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  8 +++++++
 3 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
index 690f62e..8af0cef 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -350,11 +350,20 @@ int hclge_cmd_init(struct hclge_dev *hdev)
 	hdev->hw.cmq.crq.next_to_use = 0;
 
 	hclge_cmd_init_regs(&hdev->hw);
-	clear_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
 
 	spin_unlock_bh(&hdev->hw.cmq.crq.lock);
 	spin_unlock_bh(&hdev->hw.cmq.csq.lock);
 
+	clear_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
+
+	/* Check if there is new reset pending, because the higher level
+	 * reset may happen when lower level reset is being processed.
+	 */
+	if ((hclge_is_reset_pending(hdev))) {
+		set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
+		return -EBUSY;
+	}
+
 	ret = hclge_cmd_query_firmware_version(&hdev->hw, &version);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index ba6ea6b..7dbab29 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2144,6 +2144,14 @@ static u32 hclge_check_event_cause(struct hclge_dev *hdev, u32 *clearval)
 	 */
 
 	/* check for vector0 reset event sources */
+	if (BIT(HCLGE_VECTOR0_IMPRESET_INT_B) & rst_src_reg) {
+		dev_info(&hdev->pdev->dev, "IMP reset interrupt\n");
+		set_bit(HNAE3_IMP_RESET, &hdev->reset_pending);
+		set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
+		*clearval = BIT(HCLGE_VECTOR0_IMPRESET_INT_B);
+		return HCLGE_VECTOR0_EVENT_RST;
+	}
+
 	if (BIT(HCLGE_VECTOR0_GLOBALRESET_INT_B) & rst_src_reg) {
 		dev_info(&hdev->pdev->dev, "global reset interrupt\n");
 		set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
@@ -2160,13 +2168,6 @@ static u32 hclge_check_event_cause(struct hclge_dev *hdev, u32 *clearval)
 		return HCLGE_VECTOR0_EVENT_RST;
 	}
 
-	if (BIT(HCLGE_VECTOR0_IMPRESET_INT_B) & rst_src_reg) {
-		dev_info(&hdev->pdev->dev, "IMP reset interrupt\n");
-		set_bit(HNAE3_IMP_RESET, &hdev->reset_pending);
-		*clearval = BIT(HCLGE_VECTOR0_IMPRESET_INT_B);
-		return HCLGE_VECTOR0_EVENT_RST;
-	}
-
 	/* check for vector0 mailbox(=CMDQ RX) event source */
 	if (BIT(HCLGE_VECTOR0_RX_CMDQ_INT_B) & cmdq_src_reg) {
 		cmdq_src_reg &= ~BIT(HCLGE_VECTOR0_RX_CMDQ_INT_B);
@@ -2352,11 +2353,15 @@ static int hclge_notify_roce_client(struct hclge_dev *hdev,
 static int hclge_reset_wait(struct hclge_dev *hdev)
 {
 #define HCLGE_RESET_WATI_MS	100
-#define HCLGE_RESET_WAIT_CNT	5
+#define HCLGE_RESET_WAIT_CNT	200
 	u32 val, reg, reg_bit;
 	u32 cnt = 0;
 
 	switch (hdev->reset_type) {
+	case HNAE3_IMP_RESET:
+		reg = HCLGE_GLOBAL_RESET_REG;
+		reg_bit = HCLGE_IMP_RESET_BIT;
+		break;
 	case HNAE3_GLOBAL_RESET:
 		reg = HCLGE_GLOBAL_RESET_REG;
 		reg_bit = HCLGE_GLOBAL_RESET_BIT;
@@ -2561,6 +2566,7 @@ static int hclge_reset_prepare_down(struct hclge_dev *hdev)
 
 static int hclge_reset_prepare_wait(struct hclge_dev *hdev)
 {
+	u32 reg_val;
 	int ret = 0;
 
 	switch (hdev->reset_type) {
@@ -2583,6 +2589,11 @@ static int hclge_reset_prepare_wait(struct hclge_dev *hdev)
 		 */
 		set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
 		break;
+	case HNAE3_IMP_RESET:
+		reg_val = hclge_read_dev(&hdev->hw, HCLGE_PF_OTHER_INT_REG);
+		hclge_write_dev(&hdev->hw, HCLGE_PF_OTHER_INT_REG,
+				BIT(HCLGE_VECTOR0_IMP_RESET_INT_B) | reg_val);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 8ab974c..b0e683e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -97,6 +97,7 @@ enum HLCGE_PORT_TYPE {
 #define HCLGE_NETWORK_PORT_ID_M		GENMASK(3, 0)
 
 /* Reset related Registers */
+#define HCLGE_PF_OTHER_INT_REG		0x20600
 #define HCLGE_MISC_RESET_STS_REG	0x20700
 #define HCLGE_MISC_VECTOR_INT_STS	0x20800
 #define HCLGE_GLOBAL_RESET_REG		0x20A00
@@ -116,6 +117,8 @@ enum HLCGE_PORT_TYPE {
 /* CMDQ register bits for RX event(=MBX event) */
 #define HCLGE_VECTOR0_RX_CMDQ_INT_B	1
 
+#define HCLGE_VECTOR0_IMP_RESET_INT_B	1
+
 #define HCLGE_MAC_DEFAULT_FRAME \
 	(ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN + ETH_DATA_LEN)
 #define HCLGE_MAC_MIN_FRAME		64
@@ -775,6 +778,11 @@ static inline int hclge_get_queue_id(struct hnae3_queue *queue)
 	return tqp->index;
 }
 
+static inline bool hclge_is_reset_pending(struct hclge_dev *hdev)
+{
+	return !!hdev->reset_pending;
+}
+
 int hclge_inform_reset_assert_to_vf(struct hclge_vport *vport);
 int hclge_cfg_mac_speed_dup(struct hclge_dev *hdev, int speed, u8 duplex);
 int hclge_set_vlan_filter(struct hnae3_handle *handle, __be16 proto,
-- 
2.7.4

