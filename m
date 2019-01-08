Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7523C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CB6206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfAHDiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 22:38:06 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:50758 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727030AbfAHDiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 22:38:06 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 376BE17A2E0A2CA9A783;
        Tue,  8 Jan 2019 11:38:04 +0800 (CST)
Received: from huawei.com (10.175.104.208) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Tue, 8 Jan 2019
 11:37:54 +0800
From:   Liu Jian <liujian56@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <xiubli@redhat.com>, <liujian56@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] driver: uio: fix possible memory leak in uio_open
Date:   Tue, 8 Jan 2019 21:38:43 +0800
Message-ID: <1546954723-197902-1-git-send-email-liujian56@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.208]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'idev->info' is NULL, we need to  free 'listerner'

Fixes: 57c5f4df0a5a ("uio: fix crash after the device is unregistered")
Signed-off-by: Liu Jian <liujian56@huawei.com>
---
v1->v2:
rename the "err_infoopen" to "err_idev_info"
v2->3:
put the extra info after the "--"
v3-v4:
add git log

 drivers/uio/uio.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 1313422..b4ae2d9 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -491,18 +491,19 @@ static int uio_open(struct inode *inode, struct file *filep)
 	if (!idev->info) {
 		mutex_unlock(&idev->info_lock);
 		ret = -EINVAL;
-		goto err_alloc_listener;
+		goto err_idev_info;
 	}
 
 	if (idev->info && idev->info->open)
 		ret = idev->info->open(idev->info, inode);
 	mutex_unlock(&idev->info_lock);
 	if (ret)
-		goto err_infoopen;
+		goto err_idev_info;
 
 	return 0;
 
-err_infoopen:
+err_idev_info:
+	filep->private_data = NULL;
 	kfree(listener);
 
 err_alloc_listener:
-- 
2.7.4

