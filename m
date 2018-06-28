Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2F0C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D02325ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D02325ED9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932239AbeF1DnM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 23:43:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8739 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753060AbeF1DlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 23:41:12 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 381AD8D5767BA;
        Thu, 28 Jun 2018 11:40:58 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.382.0; Thu, 28 Jun 2018 11:40:54 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 08/11] net: hns3: print the ret value in error information
Date:   Thu, 28 Jun 2018 12:12:26 +0800
Message-ID: <1530159149-122284-9-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530159149-122284-1-git-send-email-lipeng321@huawei.com>
References: <1530159149-122284-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print the ret value in error information can help find the reason.

Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.c b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
index 3e5c83f..1a02620 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
@@ -94,7 +94,7 @@ static int hnae3_match_n_instantiate(struct hnae3_client *client,
 		ret = ae_dev->ops->init_client_instance(client, ae_dev);
 		if (ret) {
 			dev_err(&ae_dev->pdev->dev,
-				"fail to instantiate client\n");
+				"fail to instantiate client, ret = %d\n", ret);
 			return ret;
 		}
 
@@ -134,7 +134,8 @@ int hnae3_register_client(struct hnae3_client *client)
 		ret = hnae3_match_n_instantiate(client, ae_dev, true);
 		if (ret)
 			dev_err(&ae_dev->pdev->dev,
-				"match and instantiation failed for port\n");
+				"match and instantiation failed for port, ret = %d\n",
+				ret);
 	}
 
 exit:
@@ -184,7 +185,8 @@ void hnae3_register_ae_algo(struct hnae3_ae_algo *ae_algo)
 		ae_dev->ops = ae_algo->ops;
 		ret = ae_algo->ops->init_ae_dev(ae_dev);
 		if (ret) {
-			dev_err(&ae_dev->pdev->dev, "init ae_dev error.\n");
+			dev_err(&ae_dev->pdev->dev,
+				"init ae_dev error, ret = %d\n", ret);
 			continue;
 		}
 
@@ -197,7 +199,8 @@ void hnae3_register_ae_algo(struct hnae3_ae_algo *ae_algo)
 			ret = hnae3_match_n_instantiate(client, ae_dev, true);
 			if (ret)
 				dev_err(&ae_dev->pdev->dev,
-					"match and instantiation failed\n");
+					"match and instantiation failed, ret = %d\n",
+					ret);
 		}
 	}
 
@@ -270,7 +273,8 @@ void hnae3_register_ae_dev(struct hnae3_ae_dev *ae_dev)
 		/* ae_dev init should set flag */
 		ret = ae_dev->ops->init_ae_dev(ae_dev);
 		if (ret) {
-			dev_err(&ae_dev->pdev->dev, "init ae_dev error\n");
+			dev_err(&ae_dev->pdev->dev,
+				"init ae_dev error, ret = %d\n", ret);
 			goto out_err;
 		}
 
@@ -285,7 +289,8 @@ void hnae3_register_ae_dev(struct hnae3_ae_dev *ae_dev)
 		ret = hnae3_match_n_instantiate(client, ae_dev, true);
 		if (ret)
 			dev_err(&ae_dev->pdev->dev,
-				"match and instantiation failed\n");
+				"match and instantiation failed, ret = %d\n",
+				ret);
 	}
 
 out_err:
-- 
2.9.3

