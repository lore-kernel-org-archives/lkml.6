Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C9CC32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 02:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060172085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 02:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060172085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389369AbeKGLwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 06:52:35 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14186 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389008AbeKGLwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 06:52:35 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 62A5ED2829738;
        Wed,  7 Nov 2018 10:24:15 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Wed, 7 Nov 2018 10:24:05 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Shiju Jose <shiju.jose@huawei.com>, <davem@davemloft.net>,
        Colin Ian King <colin.king@canonical.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH net-next] net: hns3: Remove set but not used variable 'reset_level'
Date:   Wed, 7 Nov 2018 02:33:53 +0000
Message-ID: <1541558033-100068-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c: In function 'hclge_log_and_clear_ppp_error':
drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c:821:24: warning:
 variable 'reset_level' set but not used [-Wunused-but-set-variable]
  enum hnae3_reset_type reset_level = HNAE3_NONE_RESET;

It never used since introduction in commit
01865a50d78f ("net: hns3: Add enable and process hw errors of TM scheduler")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index 123c37e..6da9e22 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -818,7 +818,6 @@ static void hclge_process_igu_egu_error(struct hclge_dev *hdev,
 static int hclge_log_and_clear_ppp_error(struct hclge_dev *hdev, u32 cmd,
 					 enum hclge_err_int_type int_type)
 {
-	enum hnae3_reset_type reset_level = HNAE3_NONE_RESET;
 	struct device *dev = &hdev->pdev->dev;
 	const struct hclge_hw_error *hw_err_lst1, *hw_err_lst2, *hw_err_lst3;
 	struct hclge_desc desc[2];
@@ -848,23 +847,17 @@ static int hclge_log_and_clear_ppp_error(struct hclge_dev *hdev, u32 cmd,
 	}
 
 	err_sts = le32_to_cpu(desc[0].data[2]);
-	if (err_sts) {
+	if (err_sts)
 		hclge_log_error(dev, hw_err_lst1, err_sts);
-		reset_level = HNAE3_FUNC_RESET;
-	}
 
 	err_sts = le32_to_cpu(desc[0].data[3]);
-	if (err_sts) {
+	if (err_sts)
 		hclge_log_error(dev, hw_err_lst2, err_sts);
-		reset_level = HNAE3_FUNC_RESET;
-	}
 
 	if (cmd == HCLGE_PPP_CMD0_INT_CMD) {
 		err_sts = (le32_to_cpu(desc[0].data[4]) >> 8) & 0x3;
-		if (err_sts) {
+		if (err_sts)
 			hclge_log_error(dev, hw_err_lst3, err_sts);
-			reset_level = HNAE3_FUNC_RESET;
-		}
 	}
 
 	/* clear PPP INT */



