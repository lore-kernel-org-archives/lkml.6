Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE65C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CE321773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbfBTCez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:34:55 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3694 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730330AbfBTCdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:33:41 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0DB2BA8747F34846C6A0;
        Wed, 20 Feb 2019 10:33:37 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Wed, 20 Feb 2019 10:33:28 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [Patch net-next 02/12] net: hns3: Check variable is valid before assigning it to another
Date:   Wed, 20 Feb 2019 10:32:41 +0800
Message-ID: <1550629971-23999-3-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550629971-23999-1-git-send-email-tanhuazhong@huawei.com>
References: <1550629971-23999-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

In hnae3_register_ae_dev(), ae_algo->ops is assigned to ae_dev->ops
before check that ae_algo->ops is valid.

And in hnae3_register_ae_algo(), missing check for ae_algo->ops.

This patch fixes them.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.c b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
index 9f5349b..17ab4f4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
@@ -185,8 +185,12 @@ void hnae3_register_ae_algo(struct hnae3_ae_algo *ae_algo)
 		if (!id)
 			continue;
 
-		/* ae_dev init should set flag */
+		if (!ae_algo->ops) {
+			dev_err(&ae_dev->pdev->dev, "ae_algo ops are null\n");
+			continue;
+		}
 		ae_dev->ops = ae_algo->ops;
+
 		ret = ae_algo->ops->init_ae_dev(ae_dev);
 		if (ret) {
 			dev_err(&ae_dev->pdev->dev,
@@ -194,6 +198,7 @@ void hnae3_register_ae_algo(struct hnae3_ae_algo *ae_algo)
 			continue;
 		}
 
+		/* ae_dev init should set flag */
 		hnae3_set_bit(ae_dev->flag, HNAE3_DEV_INITED_B, 1);
 
 		/* check the client list for the match with this ae_dev type and
@@ -273,15 +278,13 @@ int hnae3_register_ae_dev(struct hnae3_ae_dev *ae_dev)
 		if (!id)
 			continue;
 
-		ae_dev->ops = ae_algo->ops;
-
-		if (!ae_dev->ops) {
-			dev_err(&ae_dev->pdev->dev, "ae_dev ops are null\n");
+		if (!ae_algo->ops) {
+			dev_err(&ae_dev->pdev->dev, "ae_algo ops are null\n");
 			ret = -EOPNOTSUPP;
 			goto out_err;
 		}
+		ae_dev->ops = ae_algo->ops;
 
-		/* ae_dev init should set flag */
 		ret = ae_dev->ops->init_ae_dev(ae_dev);
 		if (ret) {
 			dev_err(&ae_dev->pdev->dev,
@@ -289,6 +292,7 @@ int hnae3_register_ae_dev(struct hnae3_ae_dev *ae_dev)
 			goto out_err;
 		}
 
+		/* ae_dev init should set flag */
 		hnae3_set_bit(ae_dev->flag, HNAE3_DEV_INITED_B, 1);
 		break;
 	}
-- 
2.7.4

