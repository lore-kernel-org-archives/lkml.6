Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C54AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8ABA2070C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfAHDBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 22:01:11 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:17121 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727052AbfAHDBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 22:01:10 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 34A37CF87FCD97B93580;
        Tue,  8 Jan 2019 11:01:08 +0800 (CST)
Received: from huawei.com (10.175.104.208) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Tue, 8 Jan 2019
 11:01:02 +0800
From:   Liu Jian <liujian56@huawei.com>
To:     <gregkh@linuxfoundation.org>, <hamish.martin@alliedtelesis.co.nz>
CC:     <liujian56@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] driver: uio: fix possible use-after-free in __uio_register_device
Date:   Tue, 8 Jan 2019 21:01:48 +0800
Message-ID: <1546952508-186003-3-git-send-email-liujian56@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546952508-186003-1-git-send-email-liujian56@huawei.com>
References: <1546952508-186003-1-git-send-email-liujian56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.208]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: liujian <liujian56@huawei.com>

In uio_dev_add_attributes() error handing case, idev is used after
device_unregister(), in which 'idev' has been released, touch idev cause
use-after-free.

Fixes: a93e7b331568 ("uio: Prevent device destruction while fds are
open")

Signed-off-by: Liu Jian <liujian56@huawei.com>
Reviewed-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
---
 drivers/uio/uio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 7280552..be2a943 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -945,6 +945,7 @@ int __uio_register_device(struct module *owner,
 		return ret;
 	}
 
+	device_initialize(&idev->dev);
 	idev->dev.devt = MKDEV(uio_major, idev->minor);
 	idev->dev.class = &uio_class;
 	idev->dev.parent = parent;
@@ -955,7 +956,7 @@ int __uio_register_device(struct module *owner,
 	if (ret)
 		goto err_device_create;
 
-	ret = device_register(&idev->dev);
+	ret = device_add(&idev->dev);
 	if (ret)
 		goto err_device_create;
 
@@ -987,9 +988,10 @@ int __uio_register_device(struct module *owner,
 err_request_irq:
 	uio_dev_del_attributes(idev);
 err_uio_dev_add_attributes:
-	device_unregister(&idev->dev);
+	device_del(&idev->dev);
 err_device_create:
 	uio_free_minor(idev);
+	put_device(&idev->dev);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(__uio_register_device);
-- 
2.7.4

