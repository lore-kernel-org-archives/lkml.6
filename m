Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D91C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A201D27D83
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A201D27D83
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933614AbeF2K5R (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 06:57:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49154 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753166AbeF2Kyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 06:54:40 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B574E3CE6654;
        Fri, 29 Jun 2018 18:54:34 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.382.0; Fri, 29 Jun 2018 18:51:23 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 06/10] net: hns3: remove a redundant hclge_cmd_csq_done
Date:   Fri, 29 Jun 2018 19:23:01 +0800
Message-ID: <1530271385-49668-7-git-send-email-lipeng321@huawei.com>
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

Set complete in the first hclge_cmd_csq_done of hclge_cmd_send,
and check if complete later, unnecessary to do hclge_cmd_csq_done
again.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
index 28556a9..facfff6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -241,15 +241,18 @@ int hclge_cmd_send(struct hclge_hw *hw, struct hclge_desc *desc, int num)
 	 */
 	if (HCLGE_SEND_SYNC(le16_to_cpu(desc->flag))) {
 		do {
-			if (hclge_cmd_csq_done(hw))
+			if (hclge_cmd_csq_done(hw)) {
+				complete = true;
 				break;
+			}
 			udelay(1);
 			timeout++;
 		} while (timeout < hw->cmq.tx_timeout);
 	}
 
-	if (hclge_cmd_csq_done(hw)) {
-		complete = true;
+	if (!complete) {
+		retval = -EAGAIN;
+	} else {
 		handle = 0;
 		while (handle < num) {
 			/* Get the result of hardware write back */
@@ -272,9 +275,6 @@ int hclge_cmd_send(struct hclge_hw *hw, struct hclge_desc *desc, int num)
 		}
 	}
 
-	if (!complete)
-		retval = -EAGAIN;
-
 	/* Clean the command send queue */
 	handle = hclge_cmd_csq_clean(hw);
 	if (handle != num) {
-- 
1.9.1

