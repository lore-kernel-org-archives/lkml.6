Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9DFC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21BC214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21BC214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387483AbeHBNbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:31:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41265 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387403AbeHBNbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:31:05 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 49154A13FC20F;
        Thu,  2 Aug 2018 19:40:15 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.399.0; Thu, 2 Aug 2018 19:40:13 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <aacraid@microsemi.com>
CC:     <andy.shevchenko@gmail.com>, <joe@perches.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/4] drivers/scsi/snic/snic_trc: Use kvcalloc instead of vmalloc+memset
Date:   Thu, 2 Aug 2018 19:28:33 +0800
Message-ID: <1533209314-1074-4-git-send-email-zhongjiang@huawei.com>
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

The kvcalloc is better than vmalloc() + memset() , So replace them.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/scsi/snic/snic_trc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/snic/snic_trc.c b/drivers/scsi/snic/snic_trc.c
index fc60c93..e766fa2 100644
--- a/drivers/scsi/snic/snic_trc.c
+++ b/drivers/scsi/snic/snic_trc.c
@@ -125,8 +125,8 @@ struct snic_trc_data *
 	void *tbuf = NULL;
 	int tbuf_sz = 0, ret;
 
-	tbuf_sz = (snic_trace_max_pages * PAGE_SIZE);
-	tbuf = vmalloc(tbuf_sz);
+	tbuf_sz = snic_trace_max_pages * PAGE_SIZE;
+	tbuf = kvcalloc(snic_trace_max_pages, PAGE_SIZE, GFP_KERNEL);
 	if (!tbuf) {
 		SNIC_ERR("Failed to Allocate Trace Buffer Size. %d\n", tbuf_sz);
 		SNIC_ERR("Trace Facility not enabled.\n");
@@ -135,7 +135,6 @@ struct snic_trc_data *
 		return ret;
 	}
 
-	memset(tbuf, 0, tbuf_sz);
 	trc->buf = (struct snic_trc_data *) tbuf;
 	spin_lock_init(&trc->lock);
 
@@ -173,7 +172,7 @@ struct snic_trc_data *
 	snic_trc_debugfs_term();
 
 	if (trc->buf) {
-		vfree(trc->buf);
+		kvfree(trc->buf);
 		trc->buf = NULL;
 	}
 
-- 
1.7.12.4

