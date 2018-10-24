Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A9FC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8C8207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8C8207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeJXXBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:01:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14115 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726423AbeJXXBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 19:01:54 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 01584DE31AC1C;
        Wed, 24 Oct 2018 22:33:28 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.83.247) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Wed, 24 Oct 2018 22:33:19 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <dan.carpenter@oracle.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH net-next] net: hns3: Fix for warning uninitialized symbol hw_err_lst3
Date:   Wed, 24 Oct 2018 15:32:18 +0100
Message-ID: <20181024143218.4204-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.83.247]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

This patch fixes the smatch warning,

drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c:700
hclge_log_and_clear_ppp_error() error: uninitialized symbol
'hw_err_lst3'

Link: https://lkml.org/lkml/2018/10/23/430

Fixes: da2d072a9ea7 ("net: hns3: Add enable and process hw errors from PPP")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index f7e363b..dca6f23 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -859,10 +859,12 @@ static int hclge_log_and_clear_ppp_error(struct hclge_dev *hdev, u32 cmd,
 		reset_level = HNAE3_FUNC_RESET;
 	}
 
-	err_sts = (le32_to_cpu(desc[0].data[4]) >> 8) & 0x3;
-	if (err_sts) {
-		hclge_log_error(dev, hw_err_lst3, err_sts);
-		reset_level = HNAE3_FUNC_RESET;
+	if (cmd == HCLGE_PPP_CMD0_INT_CMD) {
+		err_sts = (le32_to_cpu(desc[0].data[4]) >> 8) & 0x3;
+		if (err_sts) {
+			hclge_log_error(dev, hw_err_lst3, err_sts);
+			reset_level = HNAE3_FUNC_RESET;
+		}
 	}
 
 	/* clear PPP INT */
-- 
1.9.1


