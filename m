Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33353C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F2E27D68
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F2E27D68
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935140AbeF2Kyw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 06:54:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49214 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932696AbeF2Kyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 06:54:49 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1ADC29690CF50;
        Fri, 29 Jun 2018 18:54:46 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.382.0; Fri, 29 Jun 2018 18:51:22 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 02/10] net: hns3: remove useless code in hclge_cmd_send
Date:   Fri, 29 Jun 2018 19:22:57 +0800
Message-ID: <1530271385-49668-3-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530271385-49668-1-git-send-email-lipeng321@huawei.com>
References: <1530271385-49668-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

There are some useless type cast, print in hclge_cmd_send.
This patch removes them.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
index 6a9576b..969966c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -269,19 +269,17 @@ int hclge_cmd_send(struct hclge_hw *hw, struct hclge_desc *desc, int num)
 			/* Get the result of hardware write back */
 			desc_to_use = &hw->cmq.csq.desc[ntc];
 			desc[handle] = *desc_to_use;
-			pr_debug("Get cmd desc:\n");
 
 			if (likely(!hclge_is_special_opcode(opcode)))
 				desc_ret = le16_to_cpu(desc[handle].retval);
 			else
 				desc_ret = le16_to_cpu(desc[0].retval);
 
-			if ((enum hclge_cmd_return_status)desc_ret ==
-			    HCLGE_CMD_EXEC_SUCCESS)
+			if (desc_ret == HCLGE_CMD_EXEC_SUCCESS)
 				retval = 0;
 			else
 				retval = -EIO;
-			hw->cmq.last_status = (enum hclge_cmd_status)desc_ret;
+			hw->cmq.last_status = desc_ret;
 			ntc++;
 			handle++;
 			if (ntc == hw->cmq.csq.desc_num)
-- 
1.9.1

