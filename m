Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB824C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802C520842
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802C520842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389418AbeIXSsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:48:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59886 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730401AbeIXSsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:48:09 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 373CF109A;
        Mon, 24 Sep 2018 12:46:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 215/235] scsi: lpfc: Fix NVME Target crash in defer rcv logic
Date:   Mon, 24 Sep 2018 13:53:21 +0200
Message-Id: <20180924113125.096745368@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 6871e8144f935a1f08e7fc6269c894861ce494aa ]

Kernel occasionally crashed with the following
ops on NVME Target:
  BUG: unable to handle kernel NULL pointer dereference at 0000000000000058
  IP: [<ffffffffa042ee50>] lpfc_nvmet_defer_rcv+0x50/0x70 [lpfc]

Callback routine was called for deferred rcv when it should be treated as a
normal rcv.

Added code in callback routine to detect this condition and log a message,
then bail.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_nvmet.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -402,6 +402,7 @@ lpfc_nvmet_ctxbuf_post(struct lpfc_hba *
 
 		/* Process FCP command */
 		if (rc == 0) {
+			ctxp->rqb_buffer = NULL;
 			atomic_inc(&tgtp->rcv_fcp_cmd_out);
 			nvmebuf->hrq->rqbp->rqb_free_buffer(phba, nvmebuf);
 			return;
@@ -1116,8 +1117,17 @@ lpfc_nvmet_defer_rcv(struct nvmet_fc_tar
 	lpfc_nvmeio_data(phba, "NVMET DEFERRCV: xri x%x sz %d CPU %02x\n",
 			 ctxp->oxid, ctxp->size, smp_processor_id());
 
+	if (!nvmebuf) {
+		lpfc_printf_log(phba, KERN_INFO, LOG_NVME_IOERR,
+				"6425 Defer rcv: no buffer xri x%x: "
+				"flg %x ste %x\n",
+				ctxp->oxid, ctxp->flag, ctxp->state);
+		return;
+	}
+
 	tgtp = phba->targetport->private;
-	atomic_inc(&tgtp->rcv_fcp_cmd_defer);
+	if (tgtp)
+		atomic_inc(&tgtp->rcv_fcp_cmd_defer);
 
 	/* Free the nvmebuf since a new buffer already replaced it */
 	nvmebuf->hrq->rqbp->rqb_free_buffer(phba, nvmebuf);


