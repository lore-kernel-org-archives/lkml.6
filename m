Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2ACCC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A2E20855
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfAVMpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 07:45:35 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2211 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728215AbfAVMpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 07:45:34 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7AEF99E715B572238205;
        Tue, 22 Jan 2019 20:45:25 +0800 (CST)
Received: from huawei.com (10.175.104.208) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Tue, 22 Jan 2019
 20:45:22 +0800
From:   Liu Jian <liujian56@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <hamish.martin@alliedtelesis.co.nz>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] driver: uio: fix possible memory leak in __uio_register_device
Date:   Wed, 23 Jan 2019 06:45:37 +0800
Message-ID: <1548197138-352285-2-git-send-email-liujian56@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548197138-352285-1-git-send-email-liujian56@huawei.com>
References: <1548197138-352285-1-git-send-email-liujian56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.208]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'idev' is malloced in __uio_register_device() and leak free it before
leaving from the uio_get_minor() error handing case, it will cause
memory leak.

Fixes: a93e7b331568 ("uio: Prevent device destruction while fds are
open")
Signed-off-by: Liu Jian <liujian56@huawei.com>
Reviewed-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
---
 drivers/uio/uio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index b4ae2d9..4d20220 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -941,8 +941,10 @@ int __uio_register_device(struct module *owner,
 	atomic_set(&idev->event, 0);
 
 	ret = uio_get_minor(idev);
-	if (ret)
+	if (ret) {
+		kfree(idev);
 		return ret;
+	}
 
 	idev->dev.devt = MKDEV(uio_major, idev->minor);
 	idev->dev.class = &uio_class;
-- 
2.7.4

