Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF92C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB3B2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbfABG0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 01:26:09 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:55771 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728184AbfABG0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 01:26:09 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EF04A8D10666C;
        Wed,  2 Jan 2019 14:26:03 +0800 (CST)
Received: from huawei.com (10.175.104.208) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Wed, 2 Jan 2019
 14:25:57 +0800
From:   liujian <liujian56@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <xiubli@redhat.com>, <liujian56@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] driver: uio: fix possible memory leak in uio_open
Date:   Thu, 3 Jan 2019 00:26:56 +0800
Message-ID: <1546446416-40831-1-git-send-email-liujian56@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.208]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 57c5f4df0a5a ("uio: fix crash after the device is unregistered")
Signed-off-by: liujian <liujian56@huawei.com>
---
 drivers/uio/uio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 5c10fc7..bde7d7a 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -496,7 +496,7 @@ static int uio_open(struct inode *inode, struct file *filep)
 	if (!idev->info) {
 		mutex_unlock(&idev->info_lock);
 		ret = -EINVAL;
-		goto err_alloc_listener;
+		goto err_infoopen;
 	}
 
 	if (idev->info && idev->info->open)
@@ -508,6 +508,7 @@ static int uio_open(struct inode *inode, struct file *filep)
 	return 0;
 
 err_infoopen:
+	filep->private_data = NULL;
 	kfree(listener);
 
 err_alloc_listener:
-- 
2.7.4

