Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49ABFC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DB6218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfAYOWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:22:25 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56362 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728933AbfAYOWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:22:07 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 422B640F0E0E118A240A;
        Fri, 25 Jan 2019 22:22:04 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Fri, 25 Jan 2019 22:21:54 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 12/13] scsi: hisi_sas: Fix to only call scsi_get_prot_op() for non-NULL scsi_cmnd
Date:   Fri, 25 Jan 2019 22:22:38 +0800
Message-ID: <1548426159-225679-13-git-send-email-john.garry@huawei.com>
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

A NULL-pointer dereference was introduced for TMF SSP commands from the
upstreaming reworking.

Fix this by relocating the scsi_get_prot_op() callsite.

Fixes: d6a9000b81be ("scsi: hisi_sas: Add support for DIF feature for v2 hw")
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index f1009e2..108683b 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -1035,8 +1035,8 @@ static void prep_ssp_v3_hw(struct hisi_hba *hisi_hba,
 	struct sas_ssp_task *ssp_task = &task->ssp_task;
 	struct scsi_cmnd *scsi_cmnd = ssp_task->cmd;
 	struct hisi_sas_tmf_task *tmf = slot->tmf;
-	unsigned char prot_op = scsi_get_prot_op(scsi_cmnd);
 	int has_data = 0, priority = !!tmf;
+	unsigned char prot_op;
 	u8 *buf_cmd;
 	u32 dw1 = 0, dw2 = 0, len = 0;
 
@@ -1051,6 +1051,7 @@ static void prep_ssp_v3_hw(struct hisi_hba *hisi_hba,
 		dw1 |= 2 << CMD_HDR_FRAME_TYPE_OFF;
 		dw1 |= DIR_NO_DATA << CMD_HDR_DIR_OFF;
 	} else {
+		prot_op = scsi_get_prot_op(scsi_cmnd);
 		dw1 |= 1 << CMD_HDR_FRAME_TYPE_OFF;
 		switch (scsi_cmnd->sc_data_direction) {
 		case DMA_TO_DEVICE:
-- 
1.9.1

