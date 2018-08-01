Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0BDC46463
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5EBA20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5EBA20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389504AbeHAPX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:23:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56984 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389315AbeHAPX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:23:59 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E2B6F5DE90F98;
        Wed,  1 Aug 2018 21:38:00 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.399.0; Wed, 1 Aug 2018 21:37:54 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <john.garry@huawei.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>, <aacraid@microsemi.com>
CC:     <andy.shevchenko@gmail.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] drivers/scsi/snic/snic_trc: Use vzalloc instead of vmalloc+memset
Date:   Wed, 1 Aug 2018 21:26:15 +0800
Message-ID: <1533129976-51930-4-git-send-email-zhongjiang@huawei.com>
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

The vzmalloc is better than vmalloc+memset, so replace them.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/scsi/snic/snic_trc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/snic/snic_trc.c b/drivers/scsi/snic/snic_trc.c
index fc60c93..876c490 100644
--- a/drivers/scsi/snic/snic_trc.c
+++ b/drivers/scsi/snic/snic_trc.c
@@ -126,7 +126,7 @@ struct snic_trc_data *
 	int tbuf_sz = 0, ret;
 
 	tbuf_sz = (snic_trace_max_pages * PAGE_SIZE);
-	tbuf = vmalloc(tbuf_sz);
+	tbuf = vzmalloc(tbuf_sz);
 	if (!tbuf) {
 		SNIC_ERR("Failed to Allocate Trace Buffer Size. %d\n", tbuf_sz);
 		SNIC_ERR("Trace Facility not enabled.\n");
@@ -135,7 +135,6 @@ struct snic_trc_data *
 		return ret;
 	}
 
-	memset(tbuf, 0, tbuf_sz);
 	trc->buf = (struct snic_trc_data *) tbuf;
 	spin_lock_init(&trc->lock);
 
-- 
1.7.12.4

