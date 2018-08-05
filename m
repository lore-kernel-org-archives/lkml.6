Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4323FC46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 13:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE77B208E6
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 13:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE77B208E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeHEP6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 11:58:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10227 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbeHEP6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 11:58:19 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 88E02A1FCB2CF;
        Sun,  5 Aug 2018 21:53:31 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.399.0; Sun, 5 Aug 2018 21:53:27 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.vnet.ibm.com>
CC:     <kartilak@cisco.com>, <john.garry@huawei.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/scsi/fnic/fnic_trace: Use kvcalloc to replace vmalloc+memset
Date:   Sun, 5 Aug 2018 21:41:47 +0800
Message-ID: <1533476507-16642-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The open code vmalloc() + memset() should be replaced by kvcalloc.
It make the code concise.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/scsi/fnic/fnic_trace.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_trace.c b/drivers/scsi/fnic/fnic_trace.c
index 57f67af..e775774 100644
--- a/drivers/scsi/fnic/fnic_trace.c
+++ b/drivers/scsi/fnic/fnic_trace.c
@@ -477,8 +477,8 @@ int fnic_trace_buf_init(void)
 	}
 
 	fnic_trace_entries.page_offset =
-		vmalloc(array_size(fnic_max_trace_entries,
-				   sizeof(unsigned long)));
+			kvcalloc(fnic_max_trace_entries,
+				   sizeof(unsigned long), GFP_KERNEL);
 	if (!fnic_trace_entries.page_offset) {
 		printk(KERN_ERR PFX "Failed to allocate memory for"
 				  " page_offset\n");
@@ -489,8 +489,6 @@ int fnic_trace_buf_init(void)
 		err = -ENOMEM;
 		goto err_fnic_trace_buf_init;
 	}
-	memset((void *)fnic_trace_entries.page_offset, 0,
-		  (fnic_max_trace_entries * sizeof(unsigned long)));
 	fnic_trace_entries.wr_idx = fnic_trace_entries.rd_idx = 0;
 	fnic_buf_head = fnic_trace_buf_p;
 
@@ -524,7 +522,7 @@ void fnic_trace_free(void)
 	fnic_tracing_enabled = 0;
 	fnic_trace_debugfs_terminate();
 	if (fnic_trace_entries.page_offset) {
-		vfree((void *)fnic_trace_entries.page_offset);
+		kvfree((void *)fnic_trace_entries.page_offset);
 		fnic_trace_entries.page_offset = NULL;
 	}
 	if (fnic_trace_buf_p) {
@@ -556,8 +554,8 @@ int fnic_fc_trace_init(void)
 	fc_trace_max_entries = (fnic_fc_trace_max_pages * PAGE_SIZE)/
 				FC_TRC_SIZE_BYTES;
 	fnic_fc_ctlr_trace_buf_p =
-		(unsigned long)vmalloc(array_size(PAGE_SIZE,
-						  fnic_fc_trace_max_pages));
+		(unsigned long)kvcalloc(fnic_fc_trace_max_pages,
+					PAGE_SIZE, GFP_KERNEL);
 	if (!fnic_fc_ctlr_trace_buf_p) {
 		pr_err("fnic: Failed to allocate memory for "
 		       "FC Control Trace Buf\n");
@@ -565,25 +563,20 @@ int fnic_fc_trace_init(void)
 		goto err_fnic_fc_ctlr_trace_buf_init;
 	}
 
-	memset((void *)fnic_fc_ctlr_trace_buf_p, 0,
-			fnic_fc_trace_max_pages * PAGE_SIZE);
-
 	/* Allocate memory for page offset */
 	fc_trace_entries.page_offset =
-		vmalloc(array_size(fc_trace_max_entries,
-				   sizeof(unsigned long)));
+				kvcalloc(fc_trace_max_entries,
+					sizeof(unsigned long), GFP_KERNEL);
 	if (!fc_trace_entries.page_offset) {
 		pr_err("fnic:Failed to allocate memory for page_offset\n");
 		if (fnic_fc_ctlr_trace_buf_p) {
 			pr_err("fnic: Freeing FC Control Trace Buf\n");
-			vfree((void *)fnic_fc_ctlr_trace_buf_p);
+			kvfree((void *)fnic_fc_ctlr_trace_buf_p);
 			fnic_fc_ctlr_trace_buf_p = 0;
 		}
 		err = -ENOMEM;
 		goto err_fnic_fc_ctlr_trace_buf_init;
 	}
-	memset((void *)fc_trace_entries.page_offset, 0,
-	       (fc_trace_max_entries * sizeof(unsigned long)));
 
 	fc_trace_entries.rd_idx = fc_trace_entries.wr_idx = 0;
 	fc_trace_buf_head = fnic_fc_ctlr_trace_buf_p;
@@ -618,11 +611,11 @@ void fnic_fc_trace_free(void)
 	fnic_fc_tracing_enabled = 0;
 	fnic_fc_trace_debugfs_terminate();
 	if (fc_trace_entries.page_offset) {
-		vfree((void *)fc_trace_entries.page_offset);
+		kvfree((void *)fc_trace_entries.page_offset);
 		fc_trace_entries.page_offset = NULL;
 	}
 	if (fnic_fc_ctlr_trace_buf_p) {
-		vfree((void *)fnic_fc_ctlr_trace_buf_p);
+		kvfree((void *)fnic_fc_ctlr_trace_buf_p);
 		fnic_fc_ctlr_trace_buf_p = 0;
 	}
 	pr_info("fnic:Successfully FC_CTLR Freed Trace Buffer\n");
-- 
1.7.12.4

