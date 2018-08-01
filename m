Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7511BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005CE20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005CE20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389468AbeHAPX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:23:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56981 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389372AbeHAPXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:23:55 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D9580BB9146CE;
        Wed,  1 Aug 2018 21:38:00 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.399.0; Wed, 1 Aug 2018 21:37:53 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <john.garry@huawei.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>, <aacraid@microsemi.com>
CC:     <andy.shevchenko@gmail.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] driver/scsi/fnic/fnic_trace: Use vzalloc to zero instead of vmalloc+memset
Date:   Wed, 1 Aug 2018 21:26:13 +0800
Message-ID: <1533129976-51930-2-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1533129976-51930-1-git-send-email-zhongjiang@huawei.com>
References: <1533129976-51930-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vzalloc is better than vmalloc+memset, so replace them to make
the code concise.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/scsi/fnic/fnic_trace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_trace.c b/drivers/scsi/fnic/fnic_trace.c
index 8271785..1c42556 100644
--- a/drivers/scsi/fnic/fnic_trace.c
+++ b/drivers/scsi/fnic/fnic_trace.c
@@ -468,14 +468,13 @@ int fnic_trace_buf_init(void)
 	fnic_max_trace_entries = (trace_max_pages * PAGE_SIZE)/
 					  FNIC_ENTRY_SIZE_BYTES;
 
-	fnic_trace_buf_p = (unsigned long)vmalloc((trace_max_pages * PAGE_SIZE));
+	fnic_trace_buf_p = (unsigned long)vzalloc((trace_max_pages * PAGE_SIZE));
 	if (!fnic_trace_buf_p) {
 		printk(KERN_ERR PFX "Failed to allocate memory "
 				  "for fnic_trace_buf_p\n");
 		err = -ENOMEM;
 		goto err_fnic_trace_buf_init;
 	}
-	memset((void *)fnic_trace_buf_p, 0, (trace_max_pages * PAGE_SIZE));
 
 	fnic_trace_entries.page_offset =
 		vmalloc(array_size(fnic_max_trace_entries,
-- 
1.7.12.4

