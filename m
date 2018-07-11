Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D8CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002DC20C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002DC20C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388185AbeGKNtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:49:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50018 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388040AbeGKNtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:49:05 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fdFQ4-0004Xr-Co; Wed, 11 Jul 2018 13:44:36 +0000
From:   Colin King <colin.king@canonical.com>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][scsi-next] scsi: lpfc: fix null pointer dereference on nvmebuf
Date:   Wed, 11 Jul 2018 14:44:36 +0100
Message-Id: <20180711134436.21963-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The check of nvmebuf suggests that it can be null, however a recent
change dereferences it to determine oxid before it is null checked,
hence there is a potential null deference on the pointer.  Fix this
by performing the null check first.  Also remove the oxid from the
debug log message as this is no longer valid.  I considered an early
fetch of oxid if nvmebuf was valid, however, what oxid should be set
to if nvembuf is null could lead to an ambiguous logging of an invalid
oxid, so I thought just removing it from the logging was the least
confusion solution.

Detected by CoverityScan, CID#1471753 ("Dereference before null check")

Fixes: 68c9b55deea5 ("scsi: lpfc: Fix abort error path for NVMET")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/lpfc/lpfc_nvmet.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 22f8a204b69f..01652d9ac619 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1742,12 +1742,9 @@ lpfc_nvmet_unsol_ls_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	uint32_t *payload;
 	uint32_t size, oxid, sid, rc;
 
-	fc_hdr = (struct fc_frame_header *)(nvmebuf->hbuf.virt);
-	oxid = be16_to_cpu(fc_hdr->fh_ox_id);
-
 	if (!nvmebuf || !phba->targetport) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
-				"6154 LS Drop IO x%x\n", oxid);
+				"6154 LS Drop IO\n");
 		oxid = 0;
 		size = 0;
 		sid = 0;
@@ -1755,6 +1752,9 @@ lpfc_nvmet_unsol_ls_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		goto dropit;
 	}
 
+	fc_hdr = (struct fc_frame_header *)(nvmebuf->hbuf.virt);
+	oxid = be16_to_cpu(fc_hdr->fh_ox_id);
+
 	tgtp = (struct lpfc_nvmet_tgtport *)phba->targetport->private;
 	payload = (uint32_t *)(nvmebuf->dbuf.virt);
 	size = bf_get(lpfc_rcqe_length,  &nvmebuf->cq_event.cqe.rcqe_cmpl);
-- 
2.17.1

