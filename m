Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEDEC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7FB6214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7FB6214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387453AbeHBNbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:31:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41263 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387425AbeHBNbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:31:06 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4E510A5FD3DE1;
        Thu,  2 Aug 2018 19:40:15 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.399.0; Thu, 2 Aug 2018 19:40:12 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <aacraid@microsemi.com>
CC:     <andy.shevchenko@gmail.com>, <joe@perches.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/4] driver/scsi/fnic/fnic_trace: Use kvcalloc instead of vmalloc+memset
Date:   Thu, 2 Aug 2018 19:28:31 +0800
Message-ID: <1533209314-1074-2-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1533209314-1074-1-git-send-email-zhongjiang@huawei.com>
References: <1533209314-1074-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kvcalloc is better than vmalloc() + memset(), So replace them to make
the code concise.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/scsi/fnic/fnic_trace.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_trace.c b/drivers/scsi/fnic/fnic_trace.c
index 8271785..57f67af 100644
--- a/drivers/scsi/fnic/fnic_trace.c
+++ b/drivers/scsi/fnic/fnic_trace.c
@@ -468,14 +468,13 @@ int fnic_trace_buf_init(void)
 	fnic_max_trace_entries = (trace_max_pages * PAGE_SIZE)/
 					  FNIC_ENTRY_SIZE_BYTES;
 
-	fnic_trace_buf_p = (unsigned long)vmalloc((trace_max_pages * PAGE_SIZE));
+	fnic_trace_buf_p = (unsigned long)kvcalloc(trace_max_pages, PAGE_SIZE, GFP_KERNEL);
 	if (!fnic_trace_buf_p) {
 		printk(KERN_ERR PFX "Failed to allocate memory "
 				  "for fnic_trace_buf_p\n");
 		err = -ENOMEM;
 		goto err_fnic_trace_buf_init;
 	}
-	memset((void *)fnic_trace_buf_p, 0, (trace_max_pages * PAGE_SIZE));
 
 	fnic_trace_entries.page_offset =
 		vmalloc(array_size(fnic_max_trace_entries,
@@ -484,7 +483,7 @@ int fnic_trace_buf_init(void)
 		printk(KERN_ERR PFX "Failed to allocate memory for"
 				  " page_offset\n");
 		if (fnic_trace_buf_p) {
-			vfree((void *)fnic_trace_buf_p);
+			kvfree((void *)fnic_trace_buf_p);
 			fnic_trace_buf_p = 0;
 		}
 		err = -ENOMEM;
@@ -529,7 +528,7 @@ void fnic_trace_free(void)
 		fnic_trace_entries.page_offset = NULL;
 	}
 	if (fnic_trace_buf_p) {
-		vfree((void *)fnic_trace_buf_p);
+		kvfree((void *)fnic_trace_buf_p);
 		fnic_trace_buf_p = 0;
 	}
 	printk(KERN_INFO PFX "Successfully Freed Trace Buffer\n");
-- 
1.7.12.4

