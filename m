Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAB0C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035EB25968
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035EB25968
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933239AbeGBHUd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:20:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9148 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753411AbeGBHTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:19:14 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 838036E6AEEE0;
        Mon,  2 Jul 2018 15:18:57 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.382.0; Mon, 2 Jul 2018 15:18:50 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH V2 net-next 5/9] net: hns3: remove a redundant hclge_cmd_csq_done
Date:   Mon, 2 Jul 2018 15:50:22 +0800
Message-ID: <1530517826-69226-6-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530517826-69226-1-git-send-email-lipeng321@huawei.com>
References: <1530517826-69226-1-git-send-email-lipeng321@huawei.com>
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
index 0839e84..db80485 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -242,15 +242,18 @@ int hclge_cmd_send(struct hclge_hw *hw, struct hclge_desc *desc, int num)
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
@@ -274,9 +277,6 @@ int hclge_cmd_send(struct hclge_hw *hw, struct hclge_desc *desc, int num)
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

