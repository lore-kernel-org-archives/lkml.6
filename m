Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C03FC282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5A6218D9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387858AbfA3U4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 15:56:24 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:42734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727977AbfA3U4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 15:56:23 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 017F67AE46BCA23BC981;
        Thu, 31 Jan 2019 04:56:20 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.134.27) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Thu, 31 Jan 2019 04:56:13 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [PATCH net-next 04/12] net: hns3: change hnae3_register_ae_dev() to int
Date:   Thu, 31 Jan 2019 04:55:44 +0800
Message-ID: <20190130205552.8512-5-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190130205552.8512-1-tanhuazhong@huawei.com>
References: <20190130205552.8512-1-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.134.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hnae3_register_ae_dev() may fail, and it should return a error code
to its caller, so change hnae3_register_ae_dev() return type to int.

Also, when hnae3_register_ae_dev() return error, hns3_probe() should
do some error handling and return the error code.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.c     | 10 +++++++++-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h     |  2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c |  8 ++++++--
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.c b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
index 781e5dee3c70..50011aafbae4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
@@ -238,7 +238,7 @@ EXPORT_SYMBOL(hnae3_unregister_ae_algo);
  * @ae_dev: the AE device
  * NOTE: the duplicated name will not be checked
  */
-void hnae3_register_ae_dev(struct hnae3_ae_dev *ae_dev)
+int hnae3_register_ae_dev(struct hnae3_ae_dev *ae_dev)
 {
 	const struct pci_device_id *id;
 	struct hnae3_ae_algo *ae_algo;
@@ -259,6 +259,7 @@ void hnae3_register_ae_dev(struct hnae3_ae_dev *ae_dev)
 
 		if (!ae_dev->ops) {
 			dev_err(&ae_dev->pdev->dev, "ae_dev ops are null\n");
+			ret = -EOPNOTSUPP;
 			goto out_err;
 		}
 
@@ -285,8 +286,15 @@ void hnae3_register_ae_dev(struct hnae3_ae_dev *ae_dev)
 				ret);
 	}
 
+	mutex_unlock(&hnae3_common_lock);
+
+	return 0;
+
 out_err:
+	list_del(&ae_dev->node);
 	mutex_unlock(&hnae3_common_lock);
+
+	return ret;
 }
 EXPORT_SYMBOL(hnae3_register_ae_dev);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 585800e634e6..c29f82aa5ba1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -587,7 +587,7 @@ struct hnae3_handle {
 #define hnae3_get_bit(origin, shift) \
 	hnae3_get_field((origin), (0x1 << (shift)), (shift))
 
-void hnae3_register_ae_dev(struct hnae3_ae_dev *ae_dev);
+int hnae3_register_ae_dev(struct hnae3_ae_dev *ae_dev);
 void hnae3_unregister_ae_dev(struct hnae3_ae_dev *ae_dev);
 
 void hnae3_unregister_ae_algo(struct hnae3_ae_algo *ae_algo);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 048b5fbdf8fa..6520e1c1a837 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1752,9 +1752,13 @@ static int hns3_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	hns3_get_dev_capability(pdev, ae_dev);
 	pci_set_drvdata(pdev, ae_dev);
 
-	hnae3_register_ae_dev(ae_dev);
+	ret = hnae3_register_ae_dev(ae_dev);
+	if (ret) {
+		devm_kfree(&pdev->dev, ae_dev);
+		pci_set_drvdata(pdev, NULL);
+	}
 
-	return 0;
+	return ret;
 }
 
 /* hns3_remove - Device removal routine
-- 
2.20.1


