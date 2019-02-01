Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D122FC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A539C20869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfBAG77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 01:59:59 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:50292 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725763AbfBAG77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 01:59:59 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3AEC679FD9DA40BD5BD1;
        Fri,  1 Feb 2019 14:59:57 +0800 (CST)
Received: from huawei.com (10.141.125.218) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Fri, 1 Feb 2019
 14:59:46 +0800
From:   Qing Xia <saberlily.xia@hisilicon.com>
To:     <labbott@redhat.com>, <sumit.semwal@linaro.org>,
        <gregkh@linuxfoundation.org>, <arve@android.com>,
        <tkjos@android.com>, <maco@android.com>
CC:     <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <devel@driverdev.osuosl.org>,
        <daniel.liuyi@hisilicon.com>, <yudongbin@hisilicon.com>,
        <kongfei@hisilicon.com>, <puck.chen@hisilicon.com>
Subject: [PATCH] staging: android: ion: fix sys heap pool's gfp_flags
Date:   Fri, 1 Feb 2019 14:59:46 +0800
Message-ID: <1549004386-38778-1-git-send-email-saberlily.xia@hisilicon.com>
X-Mailer: git-send-email 2.7.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.141.125.218]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the first loop, gfp_flags will be modified to high_order_gfp_flags,
and there will be no chance to change back to low_order_gfp_flags.

Fixes: e7f63771 ("ION: Sys_heap: Add cached pool to spead up cached buffer alloc")
Signed-off-by: Qing Xia <saberlily.xia@hisilicon.com>
---
 drivers/staging/android/ion/ion_system_heap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
index 0383f75..20f2103 100644
--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -223,10 +223,10 @@ static void ion_system_heap_destroy_pools(struct ion_page_pool **pools)
 static int ion_system_heap_create_pools(struct ion_page_pool **pools)
 {
 	int i;
-	gfp_t gfp_flags = low_order_gfp_flags;
 
 	for (i = 0; i < NUM_ORDERS; i++) {
 		struct ion_page_pool *pool;
+		gfp_t gfp_flags = low_order_gfp_flags;
 
 		if (orders[i] > 4)
 			gfp_flags = high_order_gfp_flags;
-- 
2.7.3

