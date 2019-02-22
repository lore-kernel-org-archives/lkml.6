Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6496AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 05:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C426207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 05:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfBVFch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 00:32:37 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:47258 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725821AbfBVFch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 00:32:37 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 77F8128CB02EC6C4A819;
        Fri, 22 Feb 2019 13:32:33 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Fri, 22 Feb 2019 13:32:25 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Omer Shpigelman <oshpigelman@habana.ai>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] habanalabs: use GFP_ATOMIC under spin lock
Date:   Fri, 22 Feb 2019 05:46:01 +0000
Message-ID: <20190222054601.4396-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A spin lock is taken here so we should use GFP_ATOMIC.

Fixes: 0feaf86d4e69 ("habanalabs: add virtual memory and MMU modules")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/misc/habanalabs/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
index 9236e52852c6..9e3491dc3b55 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -120,7 +120,7 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 
 	spin_lock(&vm->idr_lock);
 	handle = idr_alloc(&vm->phys_pg_pack_handles, phys_pg_pack, 1, 0,
-				GFP_KERNEL);
+				GFP_ATOMIC);
 	spin_unlock(&vm->idr_lock);
 
 	if (handle < 0) {



