Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B61ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D2F208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D2F208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbeGPQFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:05:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46269 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727957AbeGPQFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:05:21 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BE95CA4782E65;
        Mon, 16 Jul 2018 23:37:18 +0800 (CST)
Received: from S00293818-DELL1.huawei.com (10.202.226.54) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.382.0; Mon, 16 Jul 2018 23:37:12 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 4/9] net: hns3: Correct reset event status register
Date:   Mon, 16 Jul 2018 16:36:22 +0100
Message-ID: <20180716153627.476-5-salil.mehta@huawei.com>
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

According to hardware's description, driver should get reset event
from VECTOR0_PF_OTHER_INT_ST(0x20800) instead of
VECTOR0_PF_OTHER_INT_SRC(0x20700).

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index a1886a3..266c686 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2495,7 +2495,7 @@ static u32 hclge_check_event_cause(struct hclge_dev *hdev, u32 *clearval)
 	u32 cmdq_src_reg;
 
 	/* fetch the events from their corresponding regs */
-	rst_src_reg = hclge_read_dev(&hdev->hw, HCLGE_MISC_RESET_STS_REG);
+	rst_src_reg = hclge_read_dev(&hdev->hw, HCLGE_MISC_VECTOR_INT_STS);
 	cmdq_src_reg = hclge_read_dev(&hdev->hw, HCLGE_VECTOR0_CMDQ_SRC_REG);
 
 	/* Assumption: If by any chance reset and mailbox events are reported
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 20abe82..a5abf8e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -89,6 +89,7 @@
 
 /* Reset related Registers */
 #define HCLGE_MISC_RESET_STS_REG	0x20700
+#define HCLGE_MISC_VECTOR_INT_STS	0x20800
 #define HCLGE_GLOBAL_RESET_REG		0x20A00
 #define HCLGE_GLOBAL_RESET_BIT		0x0
 #define HCLGE_CORE_RESET_BIT		0x1
-- 
2.7.4


