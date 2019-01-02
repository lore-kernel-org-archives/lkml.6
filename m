Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADF0C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 05:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F82218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 05:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfABFle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 00:41:34 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16672 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727265AbfABFle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 00:41:34 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F0C3FCFFBA121;
        Wed,  2 Jan 2019 13:41:26 +0800 (CST)
Received: from huawei.com (10.175.104.208) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Wed, 2 Jan 2019
 13:41:21 +0800
From:   liujian <liujian56@huawei.com>
To:     <gregkh@linuxfoundation.org>, <hamish.martin@alliedtelesis.co.nz>
CC:     <liujian56@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] driver: uio: fix possible memory leak and use-after-free in __uio_register_device
Date:   Wed, 2 Jan 2019 23:42:20 +0800
Message-ID: <1546443740-22370-1-git-send-email-liujian56@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.208]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before device_register, if something goes wrong, we need to manually
 free idev.

In the error handling path, after device_unregister, idev maybe have been
 released, we should not use it anymore.

Signed-off-by: liujian <liujian56@huawei.com>
---
 drivers/uio/uio.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 1313422..5c10fc7 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -413,13 +413,18 @@ static int uio_get_minor(struct uio_device *idev)
 	return retval;
 }
 
-static void uio_free_minor(struct uio_device *idev)
+static void __uio_free_minor(int id)
 {
 	mutex_lock(&minor_lock);
-	idr_remove(&uio_idr, idev->minor);
+	idr_remove(&uio_idr, id);
 	mutex_unlock(&minor_lock);
 }
 
+static void uio_free_minor(struct uio_device *idev)
+{
+	__uio_free_minor(idev->minor);
+}
+
 /**
  * uio_event_notify - trigger an interrupt event
  * @info: UIO device capabilities
@@ -919,6 +924,7 @@ int __uio_register_device(struct module *owner,
 {
 	struct uio_device *idev;
 	int ret = 0;
+	int uio_minor;
 
 	if (!uio_class_registered)
 		return -EPROBE_DEFER;
@@ -940,8 +946,12 @@ int __uio_register_device(struct module *owner,
 	atomic_set(&idev->event, 0);
 
 	ret = uio_get_minor(idev);
-	if (ret)
+	if (ret) {
+		kfree(idev);
 		return ret;
+	}
+
+	uio_minor = idev->minor;
 
 	idev->dev.devt = MKDEV(uio_major, idev->minor);
 	idev->dev.class = &uio_class;
@@ -950,8 +960,11 @@ int __uio_register_device(struct module *owner,
 	dev_set_drvdata(&idev->dev, idev);
 
 	ret = dev_set_name(&idev->dev, "uio%d", idev->minor);
-	if (ret)
-		goto err_device_create;
+	if (ret) {
+		__uio_free_minor(uio_minor);
+		kfree(idev);
+		return ret;
+	}
 
 	ret = device_register(&idev->dev);
 	if (ret)
@@ -987,7 +1000,7 @@ int __uio_register_device(struct module *owner,
 err_uio_dev_add_attributes:
 	device_unregister(&idev->dev);
 err_device_create:
-	uio_free_minor(idev);
+	__uio_free_minor(uio_minor);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(__uio_register_device);
-- 
2.7.4

