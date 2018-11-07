Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3033BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECAF22086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECAF22086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbeKGNex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 08:34:53 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:14609 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730927AbeKGNew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 08:34:52 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CDF54B3ED92A9;
        Wed,  7 Nov 2018 12:06:11 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Wed, 7 Nov 2018 12:06:06 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>
Subject: [Patch net-next 07/12] net: hns3: ignore new coming low-level reset while doing high-level reset
Date:   Wed, 7 Nov 2018 12:06:13 +0800
Message-ID: <1541563578-28973-8-git-send-email-tanhuazhong@huawei.com>
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

When processing a higher level reset, the pending lower level reset
does not have to be processed anymore, because the higher level
reset is the superset of the lower level reset.

Therefore, when processing an higher level reset, the request of
lower level reset needs to be cleared.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 27 +++++++++++++---------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index b784db0..62022d55 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2414,20 +2414,25 @@ static enum hnae3_reset_type hclge_get_reset_level(struct hclge_dev *hdev,
 	enum hnae3_reset_type rst_level = HNAE3_NONE_RESET;
 
 	/* return the highest priority reset level amongst all */
-	if (test_bit(HNAE3_GLOBAL_RESET, addr))
+	if (test_bit(HNAE3_IMP_RESET, addr)) {
+		rst_level = HNAE3_IMP_RESET;
+		clear_bit(HNAE3_IMP_RESET, addr);
+		clear_bit(HNAE3_GLOBAL_RESET, addr);
+		clear_bit(HNAE3_CORE_RESET, addr);
+		clear_bit(HNAE3_FUNC_RESET, addr);
+	} else if (test_bit(HNAE3_GLOBAL_RESET, addr)) {
 		rst_level = HNAE3_GLOBAL_RESET;
-	else if (test_bit(HNAE3_CORE_RESET, addr))
+		clear_bit(HNAE3_GLOBAL_RESET, addr);
+		clear_bit(HNAE3_CORE_RESET, addr);
+		clear_bit(HNAE3_FUNC_RESET, addr);
+	} else if (test_bit(HNAE3_CORE_RESET, addr)) {
 		rst_level = HNAE3_CORE_RESET;
-	else if (test_bit(HNAE3_IMP_RESET, addr))
-		rst_level = HNAE3_IMP_RESET;
-	else if (test_bit(HNAE3_FUNC_RESET, addr))
+		clear_bit(HNAE3_CORE_RESET, addr);
+		clear_bit(HNAE3_FUNC_RESET, addr);
+	} else if (test_bit(HNAE3_FUNC_RESET, addr)) {
 		rst_level = HNAE3_FUNC_RESET;
-
-	/* now, clear all other resets */
-	clear_bit(HNAE3_GLOBAL_RESET, addr);
-	clear_bit(HNAE3_CORE_RESET, addr);
-	clear_bit(HNAE3_IMP_RESET, addr);
-	clear_bit(HNAE3_FUNC_RESET, addr);
+		clear_bit(HNAE3_FUNC_RESET, addr);
+	}
 
 	return rst_level;
 }
-- 
2.7.4

