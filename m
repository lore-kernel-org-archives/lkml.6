Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA1CC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9F227D87
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9F227D87
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754020AbeF2Kyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 06:54:39 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59877 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750761AbeF2Kyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 06:54:38 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EF7C6EBE85CF0;
        Fri, 29 Jun 2018 18:54:13 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.382.0; Fri, 29 Jun 2018 18:51:23 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 04/10] net: hns3: simplify hclge_cmd_csq_clean
Date:   Fri, 29 Jun 2018 19:22:59 +0800
Message-ID: <1530271385-49668-5-git-send-email-lipeng321@huawei.com>
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

csq is used as a ring buffer, the value of the desc will be replaced
in next use. This patch removes the unnecessary memset, and just
updates the next_to_clean.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c  | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
index 054a913..0839e84 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -151,31 +151,20 @@ static int hclge_cmd_csq_clean(struct hclge_hw *hw)
 {
 	struct hclge_dev *hdev = container_of(hw, struct hclge_dev, hw);
 	struct hclge_cmq_ring *csq = &hw->cmq.csq;
-	u16 ntc = csq->next_to_clean;
-	struct hclge_desc *desc;
-	int clean = 0;
 	u32 head;
+	int clean;
 
-	desc = &csq->desc[ntc];
 	head = hclge_read_dev(hw, HCLGE_NIC_CSQ_HEAD_REG);
 	rmb(); /* Make sure head is ready before touch any data */
 
 	if (!is_valid_csq_clean_head(csq, head)) {
-		dev_warn(&hdev->pdev->dev, "wrong head (%d, %d-%d)\n", head,
-			   csq->next_to_use, csq->next_to_clean);
+		dev_warn(&hdev->pdev->dev, "wrong cmd head (%d, %d-%d)\n", head,
+			 csq->next_to_use, csq->next_to_clean);
 		return 0;
 	}
 
-	while (head != ntc) {
-		memset(desc, 0, sizeof(*desc));
-		ntc++;
-		if (ntc == csq->desc_num)
-			ntc = 0;
-		desc = &csq->desc[ntc];
-		clean++;
-	}
-	csq->next_to_clean = ntc;
-
+	clean = (head - csq->next_to_clean + csq->desc_num) % csq->desc_num;
+	csq->next_to_clean = head;
 	return clean;
 }
 
-- 
1.9.1

