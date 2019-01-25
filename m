Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E8DC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648F9218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfAYOWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:22:15 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2764 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728936AbfAYOWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:22:10 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 53177ACC1C4F67D353C1;
        Fri, 25 Jan 2019 22:21:59 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Fri, 25 Jan 2019 22:21:53 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        Luo Jiaxing <luojiaxing@huawei.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 10/13] scsi: hisi_sas: Correct memory allocation size for DQ debugfs
Date:   Fri, 25 Jan 2019 22:22:36 +0800
Message-ID: <1548426159-225679-11-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1548426159-225679-1-git-send-email-john.garry@huawei.com>
References: <1548426159-225679-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo Jiaxing <luojiaxing@huawei.com>

Some sizes we allocate for debugfs structure is incorrect, so fix them.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 0a817e9..89f1bc5 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2502,7 +2502,7 @@ static void hisi_sas_debugfs_snapshot_cq_reg(struct hisi_hba *hisi_hba)
 
 static void hisi_sas_debugfs_snapshot_dq_reg(struct hisi_hba *hisi_hba)
 {
-	int queue_entry_size = hisi_hba->hw->complete_hdr_size;
+	int queue_entry_size = sizeof(struct hisi_sas_cmd_hdr);
 	int i;
 
 	for (i = 0; i < hisi_hba->queue_count; i++)
@@ -2945,7 +2945,7 @@ void hisi_sas_debugfs_init(struct hisi_hba *hisi_hba)
 	}
 
 	/* Alloc buffer for dq */
-	sz = hisi_hba->hw->complete_hdr_size * HISI_SAS_QUEUE_SLOTS;
+	sz = sizeof(struct hisi_sas_cmd_hdr) * HISI_SAS_QUEUE_SLOTS;
 	for (d = 0; d < hisi_hba->queue_count; d++) {
 		hisi_hba->debugfs_cmd_hdr[d] =
 			devm_kmalloc(dev, sz, GFP_KERNEL);
-- 
1.9.1

