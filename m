Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C260C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CDB2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23CDB2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733308AbeISXKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:10:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12211 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732840AbeISXK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:10:29 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6D38C40057760;
        Thu, 20 Sep 2018 01:31:28 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Thu, 20 Sep 2018 01:31:20 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 10/12] net: hns3: Clear client pointer when initialize client failed or unintialize finished
Date:   Wed, 19 Sep 2018 18:29:56 +0100
Message-ID: <20180919172958.12992-11-salil.mehta@huawei.com>
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

If initialize client failed or finish uninitializing client, we should
clear the client pointer. It may cause unexpected result when use
uninitialized client. Meanwhile, we also should check whether client
exist when uninitialize it.

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 25 ++++++++++------
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 33 ++++++++++++++++------
 2 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 8a50688..141da18 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5162,13 +5162,13 @@ static int hclge_init_client_instance(struct hnae3_client *client,
 			vport->nic.client = client;
 			ret = client->ops->init_instance(&vport->nic);
 			if (ret)
-				return ret;
+				goto clear_nic;
 
 			ret = hclge_init_instance_hw(hdev);
 			if (ret) {
 			        client->ops->uninit_instance(&vport->nic,
 			                                     0);
-			        return ret;
+				goto clear_nic;
 			}
 
 			if (hdev->roce_client &&
@@ -5177,11 +5177,11 @@ static int hclge_init_client_instance(struct hnae3_client *client,
 
 				ret = hclge_init_roce_base_info(vport);
 				if (ret)
-					return ret;
+					goto clear_roce;
 
 				ret = rc->ops->init_instance(&vport->roce);
 				if (ret)
-					return ret;
+					goto clear_roce;
 			}
 
 			break;
@@ -5191,7 +5191,7 @@ static int hclge_init_client_instance(struct hnae3_client *client,
 
 			ret = client->ops->init_instance(&vport->nic);
 			if (ret)
-				return ret;
+				goto clear_nic;
 
 			break;
 		case HNAE3_CLIENT_ROCE:
@@ -5203,16 +5203,25 @@ static int hclge_init_client_instance(struct hnae3_client *client,
 			if (hdev->roce_client && hdev->nic_client) {
 				ret = hclge_init_roce_base_info(vport);
 				if (ret)
-					return ret;
+					goto clear_roce;
 
 				ret = client->ops->init_instance(&vport->roce);
 				if (ret)
-					return ret;
+					goto clear_roce;
 			}
 		}
 	}
 
 	return 0;
+
+clear_nic:
+	hdev->nic_client = NULL;
+	vport->nic.client = NULL;
+	return ret;
+clear_roce:
+	hdev->roce_client = NULL;
+	vport->roce.client = NULL;
+	return ret;
 }
 
 static void hclge_uninit_client_instance(struct hnae3_client *client,
@@ -5232,7 +5241,7 @@ static void hclge_uninit_client_instance(struct hnae3_client *client,
 		}
 		if (client->type == HNAE3_CLIENT_ROCE)
 			return;
-		if (client->ops->uninit_instance) {
+		if (hdev->nic_client && client->ops->uninit_instance) {
 			hclge_uninit_instance_hw(hdev);
 			client->ops->uninit_instance(&vport->nic, 0);
 			hdev->nic_client = NULL;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 320043e..88cff5f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1624,17 +1624,17 @@ static int hclgevf_init_client_instance(struct hnae3_client *client,
 
 		ret = client->ops->init_instance(&hdev->nic);
 		if (ret)
-			return ret;
+			goto clear_nic;
 
 		if (hdev->roce_client && hnae3_dev_roce_supported(hdev)) {
 			struct hnae3_client *rc = hdev->roce_client;
 
 			ret = hclgevf_init_roce_base_info(hdev);
 			if (ret)
-				return ret;
+				goto clear_roce;
 			ret = rc->ops->init_instance(&hdev->roce);
 			if (ret)
-				return ret;
+				goto clear_roce;
 		}
 		break;
 	case HNAE3_CLIENT_UNIC:
@@ -1643,7 +1643,7 @@ static int hclgevf_init_client_instance(struct hnae3_client *client,
 
 		ret = client->ops->init_instance(&hdev->nic);
 		if (ret)
-			return ret;
+			goto clear_nic;
 		break;
 	case HNAE3_CLIENT_ROCE:
 		if (hnae3_dev_roce_supported(hdev)) {
@@ -1654,15 +1654,24 @@ static int hclgevf_init_client_instance(struct hnae3_client *client,
 		if (hdev->roce_client && hdev->nic_client) {
 			ret = hclgevf_init_roce_base_info(hdev);
 			if (ret)
-				return ret;
+				goto clear_roce;
 
 			ret = client->ops->init_instance(&hdev->roce);
 			if (ret)
-				return ret;
+				goto clear_roce;
 		}
 	}
 
 	return 0;
+
+clear_nic:
+	hdev->nic_client = NULL;
+	hdev->nic.client = NULL;
+	return ret;
+clear_roce:
+	hdev->roce_client = NULL;
+	hdev->roce.client = NULL;
+	return ret;
 }
 
 static void hclgevf_uninit_client_instance(struct hnae3_client *client,
@@ -1671,13 +1680,19 @@ static void hclgevf_uninit_client_instance(struct hnae3_client *client,
 	struct hclgevf_dev *hdev = ae_dev->priv;
 
 	/* un-init roce, if it exists */
-	if (hdev->roce_client)
+	if (hdev->roce_client) {
 		hdev->roce_client->ops->uninit_instance(&hdev->roce, 0);
+		hdev->roce_client = NULL;
+		hdev->roce.client = NULL;
+	}
 
 	/* un-init nic/unic, if this was not called by roce client */
-	if ((client->ops->uninit_instance) &&
-	    (client->type != HNAE3_CLIENT_ROCE))
+	if (client->ops->uninit_instance && hdev->nic_client &&
+	    client->type != HNAE3_CLIENT_ROCE) {
 		client->ops->uninit_instance(&hdev->nic, 0);
+		hdev->nic_client = NULL;
+		hdev->nic.client = NULL;
+	}
 }
 
 static int hclgevf_pci_init(struct hclgevf_dev *hdev)
-- 
2.7.4


