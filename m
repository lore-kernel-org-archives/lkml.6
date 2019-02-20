Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6157BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C7A2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbfBTCeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:34:16 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4228 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730390AbfBTCdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:33:44 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0D4E7B9F264A31AC07C7;
        Wed, 20 Feb 2019 10:33:42 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Wed, 20 Feb 2019 10:33:31 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [Patch net-next 12/12] net: hns3: clear command queue's registers when unloading VF driver
Date:   Wed, 20 Feb 2019 10:32:51 +0800
Message-ID: <1550629971-23999-13-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550629971-23999-1-git-send-email-tanhuazhong@huawei.com>
References: <1550629971-23999-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the hardware's description, the driver should clear
the command queue's registers when uloading VF driver. Otherwise,
these existing value may lead the IMP get into a wrong state.

Fixes: fedd0c15d288 ("net: hns3: Add HNS3 VF IMP(Integrated Management Proc) cmd interface")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
index 4e78e88..9441b45 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
@@ -362,8 +362,28 @@ int hclgevf_cmd_init(struct hclgevf_dev *hdev)
 	return 0;
 }
 
+static void hclgevf_cmd_uninit_regs(struct hclgevf_hw *hw)
+{
+	hclgevf_write_dev(hw, HCLGEVF_NIC_CSQ_BASEADDR_L_REG, 0);
+	hclgevf_write_dev(hw, HCLGEVF_NIC_CSQ_BASEADDR_H_REG, 0);
+	hclgevf_write_dev(hw, HCLGEVF_NIC_CSQ_DEPTH_REG, 0);
+	hclgevf_write_dev(hw, HCLGEVF_NIC_CSQ_HEAD_REG, 0);
+	hclgevf_write_dev(hw, HCLGEVF_NIC_CSQ_TAIL_REG, 0);
+	hclgevf_write_dev(hw, HCLGEVF_NIC_CRQ_BASEADDR_L_REG, 0);
+	hclgevf_write_dev(hw, HCLGEVF_NIC_CRQ_BASEADDR_H_REG, 0);
+	hclgevf_write_dev(hw, HCLGEVF_NIC_CRQ_DEPTH_REG, 0);
+	hclgevf_write_dev(hw, HCLGEVF_NIC_CRQ_HEAD_REG, 0);
+	hclgevf_write_dev(hw, HCLGEVF_NIC_CRQ_TAIL_REG, 0);
+}
+
 void hclgevf_cmd_uninit(struct hclgevf_dev *hdev)
 {
+	spin_lock_bh(&hdev->hw.cmq.csq.lock);
+	spin_lock(&hdev->hw.cmq.crq.lock);
+	clear_bit(HCLGEVF_STATE_CMD_DISABLE, &hdev->state);
+	hclgevf_cmd_uninit_regs(&hdev->hw);
+	spin_unlock(&hdev->hw.cmq.crq.lock);
+	spin_unlock_bh(&hdev->hw.cmq.csq.lock);
 	hclgevf_free_cmd_desc(&hdev->hw.cmq.csq);
 	hclgevf_free_cmd_desc(&hdev->hw.cmq.crq);
 }
-- 
2.7.4

