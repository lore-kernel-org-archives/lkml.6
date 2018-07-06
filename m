Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE80C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E7923F04
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E7923F04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932802AbeGFK3a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:29:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36163 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932614AbeGFK3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:29:25 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2EF3CCAD09844;
        Fri,  6 Jul 2018 18:29:21 +0800 (CST)
Received: from S00293818-DELL1.huawei.com (10.202.226.54) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.382.0; Fri, 6 Jul 2018 18:29:15 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 10/10] net: hns3: Prevent sending command during global or core reset
Date:   Fri, 6 Jul 2018 11:28:04 +0100
Message-ID: <20180706102804.196-11-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180706102804.196-1-salil.mehta@huawei.com>
References: <20180706102804.196-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

According to hardware's description, driver should not send command to
IMP while hardware doing global or core reset.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c  | 4 +++-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 2 ++
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
index 82cf12a..eca4b23 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -206,7 +206,8 @@ int hclge_cmd_send(struct hclge_hw *hw, struct hclge_desc *desc, int num)
 
 	spin_lock_bh(&hw->cmq.csq.lock);
 
-	if (num > hclge_ring_space(&hw->cmq.csq)) {
+	if (num > hclge_ring_space(&hw->cmq.csq) ||
+	    test_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state)) {
 		spin_unlock_bh(&hw->cmq.csq.lock);
 		return -EBUSY;
 	}
@@ -346,6 +347,7 @@ int hclge_cmd_init(struct hclge_dev *hdev)
 	spin_lock_init(&hdev->hw.cmq.crq.lock);
 
 	hclge_cmd_init_regs(&hdev->hw);
+	clear_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
 
 	ret = hclge_cmd_query_firmware_version(&hdev->hw, &version);
 	if (ret) {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 4ca3e6b..8bbf4e5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2507,12 +2507,14 @@ static u32 hclge_check_event_cause(struct hclge_dev *hdev, u32 *clearval)
 
 	/* check for vector0 reset event sources */
 	if (BIT(HCLGE_VECTOR0_GLOBALRESET_INT_B) & rst_src_reg) {
+		set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
 		set_bit(HNAE3_GLOBAL_RESET, &hdev->reset_pending);
 		*clearval = BIT(HCLGE_VECTOR0_GLOBALRESET_INT_B);
 		return HCLGE_VECTOR0_EVENT_RST;
 	}
 
 	if (BIT(HCLGE_VECTOR0_CORERESET_INT_B) & rst_src_reg) {
+		set_bit(HCLGE_STATE_CMD_DISABLE, &hdev->state);
 		set_bit(HNAE3_CORE_RESET, &hdev->reset_pending);
 		*clearval = BIT(HCLGE_VECTOR0_CORERESET_INT_B);
 		return HCLGE_VECTOR0_EVENT_RST;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 71d38b8..20abe82 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -128,6 +128,7 @@ enum HCLGE_DEV_STATE {
 	HCLGE_STATE_MBX_SERVICE_SCHED,
 	HCLGE_STATE_MBX_HANDLING,
 	HCLGE_STATE_STATISTICS_UPDATING,
+	HCLGE_STATE_CMD_DISABLE,
 	HCLGE_STATE_MAX
 };
 
-- 
2.7.4


