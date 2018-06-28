Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B837C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1E925EB0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1E925EB0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753187AbeF1DlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 23:41:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52488 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751107AbeF1DlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 23:41:07 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 83B2965CD79E7;
        Thu, 28 Jun 2018 11:41:02 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.382.0; Thu, 28 Jun 2018 11:40:54 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 10/11] net: hns3: remove back in struct hclge_hw
Date:   Thu, 28 Jun 2018 12:12:28 +0800
Message-ID: <1530159149-122284-11-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530159149-122284-1-git-send-email-lipeng321@huawei.com>
References: <1530159149-122284-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

hclge_hw is embedded in hclge_dev, so use container_of instead of
back to get hclge_dev.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c  | 4 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 1 -
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h | 1 -
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
index c36d647..7049d0b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -152,7 +152,7 @@ static void hclge_cmd_init_regs(struct hclge_hw *hw)
 
 static int hclge_cmd_csq_clean(struct hclge_hw *hw)
 {
-	struct hclge_dev *hdev = (struct hclge_dev *)hw->back;
+	struct hclge_dev *hdev = container_of(hw, struct hclge_dev, hw);
 	struct hclge_cmq_ring *csq = &hw->cmq.csq;
 	u16 ntc = csq->next_to_clean;
 	struct hclge_desc *desc;
@@ -216,7 +216,7 @@ static bool hclge_is_special_opcode(u16 opcode)
  **/
 int hclge_cmd_send(struct hclge_hw *hw, struct hclge_desc *desc, int num)
 {
-	struct hclge_dev *hdev = (struct hclge_dev *)hw->back;
+	struct hclge_dev *hdev = container_of(hw, struct hclge_dev, hw);
 	struct hclge_desc *desc_to_use;
 	bool complete = false;
 	u32 timeout = 0;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 805c780..14a6991 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5537,7 +5537,6 @@ static int hclge_pci_init(struct hclge_dev *hdev)
 
 	pci_set_master(pdev);
 	hw = &hdev->hw;
-	hw->back = hdev;
 	hw->io_base = pcim_iomap(pdev, 2, 0);
 	if (!hw->io_base) {
 		dev_err(&pdev->dev, "Can't map configuration register space\n");
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 7488534..71d38b8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -190,7 +190,6 @@ struct hclge_hw {
 	int num_vec;
 	struct hclge_cmq cmq;
 	struct hclge_caps caps;
-	void *back;
 };
 
 /* TQP stats */
-- 
2.9.3

