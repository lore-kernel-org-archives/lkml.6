Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC28AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B0721852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbeLRN0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:26:11 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:59649 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726582AbeLRN0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:26:11 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9EBE56931B678;
        Tue, 18 Dec 2018 21:26:07 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Tue, 18 Dec 2018
 21:26:01 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <leobras.c@gmail.co>, <radek.dostal@streamunlimited.co>
CC:     <linux-kernel@vger.kernel.org>, <linux-fbdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] staging: fbtft: use strcmp() instead of strncmp() for
Date:   Tue, 18 Dec 2018 21:25:08 +0800
Message-ID: <20181218132508.18672-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncmp() stops comparing when either the end of one of the first two 
arguments is reached or when 'n' characters have been compared, whichever
comes first.That means that strncmp(s1, s2, n) is equivalent to 
strcmp(s1, s2) if n exceeds the length of s1 or the length of s2.

This patch avoids that the following warning is reported by smatch:

drivers/staging/fbtft/fbtft_device.c:1458
 fbtft_device_init() error: strncmp() '"list"' too small (5 vs 32)

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: fix patch title
---
 drivers/staging/fbtft/fbtft_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft_device.c b/drivers/staging/fbtft/fbtft_device.c
index 50e97da..0e995028 100644
--- a/drivers/staging/fbtft/fbtft_device.c
+++ b/drivers/staging/fbtft/fbtft_device.c
@@ -1455,7 +1455,7 @@ static int __init fbtft_device_init(void)
 	}
 
 	/* name=list lists all supported displays */
-	if (strncmp(name, "list", FBTFT_GPIO_NAME_SIZE) == 0) {
+	if (strcmp(name, "list") == 0) {
 		pr_info("Supported displays:\n");
 
 		for (i = 0; i < ARRAY_SIZE(displays); i++)
-- 
2.7.0


