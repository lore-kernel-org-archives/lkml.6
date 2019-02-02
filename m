Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B387C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 14:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272A420856
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 14:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfBBOlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 09:41:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3267 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728079AbfBBOk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 09:40:57 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A29F1F492BAA6AB73CDF;
        Sat,  2 Feb 2019 22:40:55 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.97.63) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Sat, 2 Feb 2019 22:40:46 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Weihang Li <liweihang@hisilicon.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 05/12] net: hns3: add hclge_cmd_check_retval() to parse comman's return value
Date:   Sat, 2 Feb 2019 22:39:30 +0800
Message-ID: <20190202143937.8924-6-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190202143937.8924-1-tanhuazhong@huawei.com>
References: <20190202143937.8924-1-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.97.63]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weihang Li <liweihang@hisilicon.com>

For simplifying the code, this patch adds hclge_cmd_check_retval() to
check the return value of the command.

Also, according the IMP's description, when there are several descriptors
in a command, then the IMP will save the return value on the last
description, so hclge_cmd_check_retval() just check the last one for this
case.

Signed-off-by: Weihang Li <liweihang@hisilicon.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../hisilicon/hns3/hns3pf/hclge_cmd.c         | 60 ++++++++++---------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
index 81dbe1b6abb0..57c50b947857 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -186,6 +186,38 @@ static bool hclge_is_special_opcode(u16 opcode)
 	return false;
 }
 
+static int hclge_cmd_check_retval(struct hclge_hw *hw, struct hclge_desc *desc,
+				  int num, int ntc)
+{
+	u16 opcode, desc_ret;
+	int handle;
+	int retval;
+
+	opcode = le16_to_cpu(desc[0].opcode);
+	for (handle = 0; handle < num; handle++) {
+		desc[handle] = hw->cmq.csq.desc[ntc];
+		ntc++;
+		if (ntc == hw->cmq.csq.desc_num)
+			ntc = 0;
+	}
+	if (likely(!hclge_is_special_opcode(opcode)))
+		desc_ret = le16_to_cpu(desc[num - 1].retval);
+	else
+		desc_ret = le16_to_cpu(desc[0].retval);
+
+	if (desc_ret == HCLGE_CMD_EXEC_SUCCESS)
+		retval = 0;
+	else if (desc_ret == HCLGE_CMD_NO_AUTH)
+		retval = -EPERM;
+	else if (desc_ret == HCLGE_CMD_NOT_SUPPORTED)
+		retval = -EOPNOTSUPP;
+	else
+		retval = -EIO;
+	hw->cmq.last_status = desc_ret;
+
+	return retval;
+}
+
 /**
  * hclge_cmd_send - send command to command queue
  * @hw: pointer to the hw struct
@@ -203,7 +235,6 @@ int hclge_cmd_send(struct hclge_hw *hw, struct hclge_desc *desc, int num)
 	u32 timeout = 0;
 	int handle = 0;
 	int retval = 0;
-	u16 opcode, desc_ret;
 	int ntc;
 
 	spin_lock_bh(&hw->cmq.csq.lock);
@@ -219,7 +250,6 @@ int hclge_cmd_send(struct hclge_hw *hw, struct hclge_desc *desc, int num)
 	 * which will be use for hardware to write back
 	 */
 	ntc = hw->cmq.csq.next_to_use;
-	opcode = le16_to_cpu(desc[0].opcode);
 	while (handle < num) {
 		desc_to_use = &hw->cmq.csq.desc[hw->cmq.csq.next_to_use];
 		*desc_to_use = desc[handle];
@@ -250,31 +280,7 @@ int hclge_cmd_send(struct hclge_hw *hw, struct hclge_desc *desc, int num)
 	if (!complete) {
 		retval = -EAGAIN;
 	} else {
-		handle = 0;
-		while (handle < num) {
-			/* Get the result of hardware write back */
-			desc_to_use = &hw->cmq.csq.desc[ntc];
-			desc[handle] = *desc_to_use;
-
-			if (likely(!hclge_is_special_opcode(opcode)))
-				desc_ret = le16_to_cpu(desc[handle].retval);
-			else
-				desc_ret = le16_to_cpu(desc[0].retval);
-
-			if (desc_ret == HCLGE_CMD_EXEC_SUCCESS)
-				retval = 0;
-			else if (desc_ret == HCLGE_CMD_NO_AUTH)
-				retval = -EPERM;
-			else if (desc_ret == HCLGE_CMD_NOT_SUPPORTED)
-				retval = -EOPNOTSUPP;
-			else
-				retval = -EIO;
-			hw->cmq.last_status = desc_ret;
-			ntc++;
-			handle++;
-			if (ntc == hw->cmq.csq.desc_num)
-				ntc = 0;
-		}
+		retval = hclge_cmd_check_retval(hw, desc, num, ntc);
 	}
 
 	/* Clean the command send queue */
-- 
2.20.1


