Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB446C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5858120855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5858120855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbeIHOjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 10:39:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40309 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726307AbeIHOjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 10:39:12 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 31FD0794FE39D;
        Sat,  8 Sep 2018 17:53:58 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.399.0; Sat, 8 Sep 2018 17:53:55 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <maier@linux.ibm.com>, <bblock@linux.ibm.com>,
        <schwidefsky@de.ibm.com>, <heiko.carstens@de.ibm.com>
CC:     <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] s390: zfcp_aux: remove unnecessary null pointer check before mempool_destroy
Date:   Sat, 8 Sep 2018 17:41:45 +0800
Message-ID: <1536399705-21676-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mempool_destroy has taken null pointer check into account. so remove the
redundant check.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/s390/scsi/zfcp_aux.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
index 94f4d8f..e06c3f2 100644
--- a/drivers/s390/scsi/zfcp_aux.c
+++ b/drivers/s390/scsi/zfcp_aux.c
@@ -248,20 +248,13 @@ static int zfcp_allocate_low_mem_buffers(struct zfcp_adapter *adapter)
 
 static void zfcp_free_low_mem_buffers(struct zfcp_adapter *adapter)
 {
-	if (adapter->pool.erp_req)
-		mempool_destroy(adapter->pool.erp_req);
-	if (adapter->pool.scsi_req)
-		mempool_destroy(adapter->pool.scsi_req);
-	if (adapter->pool.scsi_abort)
-		mempool_destroy(adapter->pool.scsi_abort);
-	if (adapter->pool.qtcb_pool)
-		mempool_destroy(adapter->pool.qtcb_pool);
-	if (adapter->pool.status_read_req)
-		mempool_destroy(adapter->pool.status_read_req);
-	if (adapter->pool.sr_data)
-		mempool_destroy(adapter->pool.sr_data);
-	if (adapter->pool.gid_pn)
-		mempool_destroy(adapter->pool.gid_pn);
+	mempool_destroy(adapter->pool.erp_req);
+	mempool_destroy(adapter->pool.scsi_req);
+	mempool_destroy(adapter->pool.scsi_abort);
+	mempool_destroy(adapter->pool.qtcb_pool);
+	mempool_destroy(adapter->pool.status_read_req);
+	mempool_destroy(adapter->pool.sr_data);
+	mempool_destroy(adapter->pool.gid_pn);
 }
 
 /**
-- 
1.7.12.4

