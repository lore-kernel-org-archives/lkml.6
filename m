Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9A1C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5D120834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5D120834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeJZPxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 11:53:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13696 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726367AbeJZPxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 11:53:53 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A2EA992BFA2E3;
        Fri, 26 Oct 2018 15:17:58 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Fri, 26 Oct 2018
 15:17:53 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <john.garry@huawei.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] scsi: hisi_sas: Remove set but not used variable 'dq_list'
Date:   Fri, 26 Oct 2018 15:07:31 +0800
Message-ID: <20181026070731.20024-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/scsi/hisi_sas/hisi_sas_v1_hw.c: In function 'start_delivery_v1_hw':
drivers/scsi/hisi_sas/hisi_sas_v1_hw.c:907:20: warning:
 variable 'dq_list' set but not used [-Wunused-but-set-variable]

drivers/scsi/hisi_sas/hisi_sas_v2_hw.c: In function 'start_delivery_v2_hw':
drivers/scsi/hisi_sas/hisi_sas_v2_hw.c:1671:20: warning:
 variable 'dq_list' set but not used [-Wunused-but-set-variable]

drivers/scsi/hisi_sas/hisi_sas_v3_hw.c: In function 'start_delivery_v3_hw':
drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:889:20: warning:
 variable 'dq_list' set but not used [-Wunused-but-set-variable]

It never used since introduction in commit
fa222db0b036 ("scsi: hisi_sas: Don't lock DQ for complete task sending")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 2 --
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 2 --
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 2 --
 3 files changed, 6 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index f0e457e..8df822a 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -904,11 +904,9 @@ static void start_delivery_v1_hw(struct hisi_sas_dq *dq)
 {
 	struct hisi_hba *hisi_hba = dq->hisi_hba;
 	struct hisi_sas_slot *s, *s1, *s2 = NULL;
-	struct list_head *dq_list;
 	int dlvry_queue = dq->id;
 	int wp;
 
-	dq_list = &dq->list;
 	list_for_each_entry_safe(s, s1, &dq->list, delivery) {
 		if (!s->ready)
 			break;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index cc36b64..77a85ea 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -1670,11 +1670,9 @@ static void start_delivery_v2_hw(struct hisi_sas_dq *dq)
 {
 	struct hisi_hba *hisi_hba = dq->hisi_hba;
 	struct hisi_sas_slot *s, *s1, *s2 = NULL;
-	struct list_head *dq_list;
 	int dlvry_queue = dq->id;
 	int wp;
 
-	dq_list = &dq->list;
 	list_for_each_entry_safe(s, s1, &dq->list, delivery) {
 		if (!s->ready)
 			break;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index bd4ce38..a369450 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -886,11 +886,9 @@ static void start_delivery_v3_hw(struct hisi_sas_dq *dq)
 {
 	struct hisi_hba *hisi_hba = dq->hisi_hba;
 	struct hisi_sas_slot *s, *s1, *s2 = NULL;
-	struct list_head *dq_list;
 	int dlvry_queue = dq->id;
 	int wp;
 
-	dq_list = &dq->list;
 	list_for_each_entry_safe(s, s1, &dq->list, delivery) {
 		if (!s->ready)
 			break;
-- 
2.7.0


