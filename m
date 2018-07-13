Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAEFECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F109208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F109208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeGMIxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 04:53:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58518 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeGMIxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 04:53:37 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fdtcI-0000z1-Ty; Fri, 13 Jul 2018 08:39:54 +0000
From:   Colin King <colin.king@canonical.com>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] scsi: lpfc: remove null check on nvmebuf
Date:   Fri, 13 Jul 2018 09:39:54 +0100
Message-Id: <20180713083954.26877-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The null checks on nvmebuf are redundant as nvmebuf is always obtained
from a container_of() and hence can never be null. Remove all the
redundant null checks. This also cleans up a static analysis warning.

Detected by CoverityScan, CID#1471753 ("Dereference before null check")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: Remove null pointer checks thanks to James Bottomley for spotting
that the caller obtains nvmebuf from container_of().

---
 drivers/scsi/lpfc/lpfc_nvmet.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 22f8a204b69f..b766afe10d3d 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1745,7 +1745,7 @@ lpfc_nvmet_unsol_ls_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	fc_hdr = (struct fc_frame_header *)(nvmebuf->hbuf.virt);
 	oxid = be16_to_cpu(fc_hdr->fh_ox_id);
 
-	if (!nvmebuf || !phba->targetport) {
+	if (!phba->targetport) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
 				"6154 LS Drop IO x%x\n", oxid);
 		oxid = 0;
@@ -1770,8 +1770,7 @@ lpfc_nvmet_unsol_ls_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		lpfc_nvmeio_data(phba, "NVMET LS  DROP: "
 				 "xri x%x sz %d from %06x\n",
 				 oxid, size, sid);
-		if (nvmebuf)
-			lpfc_in_buf_free(phba, &nvmebuf->dbuf);
+		lpfc_in_buf_free(phba, &nvmebuf->dbuf);
 		return;
 	}
 	ctxp->phba = phba;
@@ -1814,8 +1813,7 @@ lpfc_nvmet_unsol_ls_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 			ctxp->oxid, rc);
 
 	/* We assume a rcv'ed cmd ALWAYs fits into 1 buffer */
-	if (nvmebuf)
-		lpfc_in_buf_free(phba, &nvmebuf->dbuf);
+	lpfc_in_buf_free(phba, &nvmebuf->dbuf);
 
 	atomic_inc(&tgtp->xmt_ls_abort);
 	lpfc_nvmet_unsol_ls_issue_abort(phba, ctxp, sid, oxid);
-- 
2.17.1

