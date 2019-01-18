Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDF3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D019B2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfARIN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:13:58 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2264 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727245AbfARINx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:13:53 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AFEF537977777D49B059;
        Fri, 18 Jan 2019 16:13:49 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Fri, 18 Jan 2019 16:13:42 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [PATCH net-next 05/12] net: hns3: add interface hclge_tm_bp_setup
Date:   Fri, 18 Jan 2019 16:13:07 +0800
Message-ID: <1547799194-38212-6-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547799194-38212-1-git-send-email-tanhuazhong@huawei.com>
References: <1547799194-38212-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a common interface to complete the back pressure settings
of all enabled TCs. So other functions directly call this interface
to complete the corresponding operation.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  | 23 ++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index 00458da..fda91e5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -1228,10 +1228,23 @@ static int hclge_mac_pause_setup_hw(struct hclge_dev *hdev)
 	return hclge_mac_pause_en_cfg(hdev, tx_en, rx_en);
 }
 
+static int hclge_tm_bp_setup(struct hclge_dev *hdev)
+{
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < hdev->tm_info.num_tc; i++) {
+		ret = hclge_bp_setup_hw(hdev, i);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
 int hclge_pause_setup_hw(struct hclge_dev *hdev)
 {
 	int ret;
-	u8 i;
 
 	ret = hclge_pause_param_setup_hw(hdev);
 	if (ret)
@@ -1250,13 +1263,7 @@ int hclge_pause_setup_hw(struct hclge_dev *hdev)
 	if (ret)
 		dev_warn(&hdev->pdev->dev, "set pfc pause failed:%d\n", ret);
 
-	for (i = 0; i < hdev->tm_info.num_tc; i++) {
-		ret = hclge_bp_setup_hw(hdev, i);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
+	return hclge_tm_bp_setup(hdev);
 }
 
 void hclge_tm_prio_tc_info_update(struct hclge_dev *hdev, u8 *prio_tc)
-- 
2.7.4

