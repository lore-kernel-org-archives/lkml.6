Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FF3C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A458D21726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfAVXku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:40:50 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60080 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727064AbfAVXkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 18:40:12 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 184947DFA545853B0641;
        Wed, 23 Jan 2019 07:40:08 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.143.16) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Wed, 23 Jan 2019 07:40:01 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>, <eric.dumazet@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 08/12] net: hns3: Change fw error code NOT_EXEC to NOT_SUPPORTED
Date:   Wed, 23 Jan 2019 07:39:34 +0800
Message-ID: <20190122233938.7188-9-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190122233938.7188-1-tanhuazhong@huawei.com>
References: <20190122233938.7188-1-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.143.16]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

According to firmware error code definition, the error code of 2
means NOT_SUPPORTED, this patch changes it to NOT_SUPPORTED.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c | 2 ++
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
index e483a6e730e6..b0ee070884eb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -259,6 +259,8 @@ int hclge_cmd_send(struct hclge_hw *hw, struct hclge_desc *desc, int num)
 
 			if (desc_ret == HCLGE_CMD_EXEC_SUCCESS)
 				retval = 0;
+			else if (desc_ret == HCLGE_CMD_NOT_SUPPORTED)
+				retval = -EOPNOTSUPP;
 			else
 				retval = -EIO;
 			hw->cmq.last_status = desc_ret;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index f23042b24c09..9f07279513b7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -39,7 +39,7 @@ struct hclge_cmq_ring {
 enum hclge_cmd_return_status {
 	HCLGE_CMD_EXEC_SUCCESS	= 0,
 	HCLGE_CMD_NO_AUTH	= 1,
-	HCLGE_CMD_NOT_EXEC	= 2,
+	HCLGE_CMD_NOT_SUPPORTED	= 2,
 	HCLGE_CMD_QUEUE_FULL	= 3,
 };
 
-- 
2.20.1


