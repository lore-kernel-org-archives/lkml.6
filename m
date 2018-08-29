Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A30C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 03:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E972420850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 03:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E972420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeH2HA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 03:00:58 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:10422 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeH2HA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 03:00:58 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec5b860da9967-3c80d; Wed, 29 Aug 2018 11:06:17 +0800 (CST)
X-RM-TRANSID: 2eec5b860da9967-3c80d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee55b860da7388-9e139;
        Wed, 29 Aug 2018 11:06:17 +0800 (CST)
X-RM-TRANSID: 2ee55b860da7388-9e139
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     sathya.prakash@broadcom.com, chaitra.basappa@broadcom.com,
        suganath-prabu.subramani@broadcom.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: mpt3sas: use zalloc function for alloc and  memset
Date:   Wed, 29 Aug 2018 11:06:13 +0800
Message-Id: <1535511973-25199-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use dma_pool_zalloc replace dma_pool_alloc and memset

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 59d7844..d7ef671 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -4516,7 +4516,7 @@ void mpt3sas_base_clear_st(struct MPT3SAS_ADAPTER *ioc,
 	i = 0;
 	do {
 		ioc->reply_post[i].reply_post_free =
-		    dma_pool_alloc(ioc->reply_post_free_dma_pool,
+		    dma_pool_zalloc(ioc->reply_post_free_dma_pool,
 		    GFP_KERNEL,
 		    &ioc->reply_post[i].reply_post_free_dma);
 		if (!ioc->reply_post[i].reply_post_free) {
@@ -4525,7 +4525,6 @@ void mpt3sas_base_clear_st(struct MPT3SAS_ADAPTER *ioc,
 			ioc->name);
 			goto out;
 		}
-		memset(ioc->reply_post[i].reply_post_free, 0, sz);
 		dinitprintk(ioc, pr_info(MPT3SAS_FMT
 		    "reply post free pool (0x%p): depth(%d),"
 		    "element_size(%d), pool_size(%d kB)\n", ioc->name,
@@ -4852,14 +4851,13 @@ void mpt3sas_base_clear_st(struct MPT3SAS_ADAPTER *ioc,
 			ioc->name);
 		goto out;
 	}
-	ioc->reply_free = dma_pool_alloc(ioc->reply_free_dma_pool, GFP_KERNEL,
+	ioc->reply_free = dma_pool_zalloc(ioc->reply_free_dma_pool, GFP_KERNEL,
 	    &ioc->reply_free_dma);
 	if (!ioc->reply_free) {
 		pr_err(MPT3SAS_FMT "reply_free pool: dma_pool_alloc failed\n",
 			ioc->name);
 		goto out;
 	}
-	memset(ioc->reply_free, 0, sz);
 	dinitprintk(ioc, pr_info(MPT3SAS_FMT "reply_free pool(0x%p): " \
 	    "depth(%d), element_size(%d), pool_size(%d kB)\n", ioc->name,
 	    ioc->reply_free, ioc->reply_free_queue_depth, 4, sz/1024));
-- 
1.9.1



