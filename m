Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D8AC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F8223F04
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F8223F04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932598AbeGFK3W (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:29:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9160 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932310AbeGFK3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:29:19 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 855D3DEFA62C6;
        Fri,  6 Jul 2018 18:29:05 +0800 (CST)
Received: from S00293818-DELL1.huawei.com (10.202.226.54) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.382.0; Fri, 6 Jul 2018 18:29:01 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Fuyun Liang <liangfuyun1@huawei.com>
Subject: [PATCH net-next 05/10] net: hns3: Fix for mailbox message truncated problem
Date:   Fri, 6 Jul 2018 11:27:59 +0100
Message-ID: <20180706102804.196-6-salil.mehta@huawei.com>
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

From: Fuyun Liang <liangfuyun1@huawei.com>

The payload of mailbox message is 16 byte and the value of
HCLGE_MBX_MAX_ARQ_MSG_SIZE is 8. A message truncated problem will
happen when mailbox message is converted to ARQ message. This patch
replaces HCLGE_MBX_MAX_ARQ_MSG_SIZE with the size of ARQ message in
hclgevf_mbx_handler to fix this problem.

Fixes: b11a0bb231f3 ("net: hns3: Add mailbox support to VF driver")
Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
index 173ca27..e9d5a4f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
@@ -208,7 +208,8 @@ void hclgevf_mbx_handler(struct hclgevf_dev *hdev)
 
 			/* tail the async message in arq */
 			msg_q = hdev->arq.msg_q[hdev->arq.tail];
-			memcpy(&msg_q[0], req->msg, HCLGE_MBX_MAX_ARQ_MSG_SIZE);
+			memcpy(&msg_q[0], req->msg,
+			       HCLGE_MBX_MAX_ARQ_MSG_SIZE * sizeof(u16));
 			hclge_mbx_tail_ptr_move_arq(hdev->arq);
 			hdev->arq.count++;
 
-- 
2.7.4


