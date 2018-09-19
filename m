Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883D9C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423D82151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423D82151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733289AbeISXK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:10:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12212 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733278AbeISXK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:10:29 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7227C1B4826B6;
        Thu, 20 Sep 2018 01:31:28 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Thu, 20 Sep 2018 01:31:23 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 11/12] net: hns3: Fix client initialize state issue when roce client initialize failed
Date:   Wed, 19 Sep 2018 18:29:57 +0100
Message-ID: <20180919172958.12992-12-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180919172958.12992-1-salil.mehta@huawei.com>
References: <20180919172958.12992-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

When roce is loaded before nic, the roce client will not be initialized
until nic client is initialized, but roce init flag is set before it.
Furthermore, in this case of nic initialized success and roce failed,
the nic init flag is not set, and roce init flag is not cleared.

This patch fixes it by set init flag only after the client is initialized
successfully.

Fixes: e2cb1dec9779 ("net: hns3: Add HNS3 VF HCL(Hardware Compatibility Layer) Support")
Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.c               | 12 +++++-------
 drivers/net/ethernet/hisilicon/hns3/hnae3.h               |  3 +++
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   |  9 +++++++++
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c |  9 +++++++++
 4 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.c b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
index fff5be8..781e5de 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
@@ -29,8 +29,8 @@ static bool hnae3_client_match(enum hnae3_client_type client_type,
 	return false;
 }
 
-static void hnae3_set_client_init_flag(struct hnae3_client *client,
-				       struct hnae3_ae_dev *ae_dev, int inited)
+void hnae3_set_client_init_flag(struct hnae3_client *client,
+				struct hnae3_ae_dev *ae_dev, int inited)
 {
 	switch (client->type) {
 	case HNAE3_CLIENT_KNIC:
@@ -46,6 +46,7 @@ static void hnae3_set_client_init_flag(struct hnae3_client *client,
 		break;
 	}
 }
+EXPORT_SYMBOL(hnae3_set_client_init_flag);
 
 static int hnae3_get_client_init_flag(struct hnae3_client *client,
 				       struct hnae3_ae_dev *ae_dev)
@@ -86,14 +87,11 @@ static int hnae3_match_n_instantiate(struct hnae3_client *client,
 	/* now, (un-)instantiate client by calling lower layer */
 	if (is_reg) {
 		ret = ae_dev->ops->init_client_instance(client, ae_dev);
-		if (ret) {
+		if (ret)
 			dev_err(&ae_dev->pdev->dev,
 				"fail to instantiate client, ret = %d\n", ret);
-			return ret;
-		}
 
-		hnae3_set_client_init_flag(client, ae_dev, 1);
-		return 0;
+		return ret;
 	}
 
 	if (hnae3_get_client_init_flag(client, ae_dev)) {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index c48c187..17db631 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -523,4 +523,7 @@ void hnae3_register_ae_algo(struct hnae3_ae_algo *ae_algo);
 
 void hnae3_unregister_client(struct hnae3_client *client);
 int hnae3_register_client(struct hnae3_client *client);
+
+void hnae3_set_client_init_flag(struct hnae3_client *client,
+				struct hnae3_ae_dev *ae_dev, int inited);
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 141da18..cf365d4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5171,6 +5171,8 @@ static int hclge_init_client_instance(struct hnae3_client *client,
 				goto clear_nic;
 			}
 
+			hnae3_set_client_init_flag(client, ae_dev, 1);
+
 			if (hdev->roce_client &&
 			    hnae3_dev_roce_supported(hdev)) {
 				struct hnae3_client *rc = hdev->roce_client;
@@ -5182,6 +5184,9 @@ static int hclge_init_client_instance(struct hnae3_client *client,
 				ret = rc->ops->init_instance(&vport->roce);
 				if (ret)
 					goto clear_roce;
+
+				hnae3_set_client_init_flag(hdev->roce_client,
+							   ae_dev, 1);
 			}
 
 			break;
@@ -5193,6 +5198,8 @@ static int hclge_init_client_instance(struct hnae3_client *client,
 			if (ret)
 				goto clear_nic;
 
+			hnae3_set_client_init_flag(client, ae_dev, 1);
+
 			break;
 		case HNAE3_CLIENT_ROCE:
 			if (hnae3_dev_roce_supported(hdev)) {
@@ -5208,6 +5215,8 @@ static int hclge_init_client_instance(struct hnae3_client *client,
 				ret = client->ops->init_instance(&vport->roce);
 				if (ret)
 					goto clear_roce;
+
+				hnae3_set_client_init_flag(client, ae_dev, 1);
 			}
 		}
 	}
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 88cff5f..166a2cf 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1626,6 +1626,8 @@ static int hclgevf_init_client_instance(struct hnae3_client *client,
 		if (ret)
 			goto clear_nic;
 
+		hnae3_set_client_init_flag(client, ae_dev, 1);
+
 		if (hdev->roce_client && hnae3_dev_roce_supported(hdev)) {
 			struct hnae3_client *rc = hdev->roce_client;
 
@@ -1635,6 +1637,9 @@ static int hclgevf_init_client_instance(struct hnae3_client *client,
 			ret = rc->ops->init_instance(&hdev->roce);
 			if (ret)
 				goto clear_roce;
+
+			hnae3_set_client_init_flag(hdev->roce_client, ae_dev,
+						   1);
 		}
 		break;
 	case HNAE3_CLIENT_UNIC:
@@ -1644,6 +1649,8 @@ static int hclgevf_init_client_instance(struct hnae3_client *client,
 		ret = client->ops->init_instance(&hdev->nic);
 		if (ret)
 			goto clear_nic;
+
+		hnae3_set_client_init_flag(client, ae_dev, 1);
 		break;
 	case HNAE3_CLIENT_ROCE:
 		if (hnae3_dev_roce_supported(hdev)) {
@@ -1660,6 +1667,8 @@ static int hclgevf_init_client_instance(struct hnae3_client *client,
 			if (ret)
 				goto clear_roce;
 		}
+
+		hnae3_set_client_init_flag(client, ae_dev, 1);
 	}
 
 	return 0;
-- 
2.7.4


