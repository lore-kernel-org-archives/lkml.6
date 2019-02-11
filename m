Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79449C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4099321B1C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549901679;
	bh=SvBp0pF38jr9KLeLFMmwaXD2Kyfj597RMq0tJFrO17o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JUuKZfBdEicpJtREG0nilmfDhq5LxtPvycCPwXKhoMLENISUjqvtUsrRv+ZyqPuAT
	 uFtFjMY/JbS/4Z24lgh95F3/OSlTBEsquQxqNngobbCAN1kszWp5yLI02CAhSsRVZ7
	 cNTVK6DmFgHrjVjpkLLHv0MGZGyee6IjF0K8Cc2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfBKQOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:14:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:54238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727224AbfBKOVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:21:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B212A20844;
        Mon, 11 Feb 2019 14:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549894884;
        bh=SvBp0pF38jr9KLeLFMmwaXD2Kyfj597RMq0tJFrO17o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JdOumUZc5BNHDcB++h+ZOEWQV+QQx1qj9YXjITv6TVF/aNWi6dzIxb4D9O6pqyol7
         7h+m7I7z8EBVk6ljdUsQAThdXRM8GbeeC09xpRoGg8XYQUu5D4svA1w+igd+s3r4nA
         f8k7k51j9VIRklFjTB57e8u0qYBCRZBZYre1qrng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 021/352] scsi: lpfc: Fix LOGO/PLOGI handling when triggerd by ABTS Timeout event
Date:   Mon, 11 Feb 2019 15:14:08 +0100
Message-Id: <20190211141847.709332728@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 30e196cacefdd9a38c857caed23cefc9621bc5c1 ]

After a LOGO in response to an ABTS timeout, a PLOGI wasn't issued to
re-establish the login.  An nlp_type check in the LOGO completion
handler failed to restart discovery for NVME targets.  Revised the
nlp_type check for NVME as well as SCSI.

While reviewing the LOGO handling a few other issues were seen and
were addressed:

- Better lock synchronization around ndlp data types

- When the ABTS times out, unregister the RPI before sending the LOGO
  so that all local exchange contexts are cleared and nothing received
  while awaiting LOGO/PLOGI handling will be accepted.

- LOGO handling optimized to:
   Wait only R_A_TOV for a response.
   It doesn't need to be retried on timeout. If there wasn't a
     response, a PLOGI will be sent, thus an implicit logout
     applies as well when the other port sees it.
   If there is a response, any kind of response is considered "good"
     and the XRI quarantined for a exchange qualifier window.

- PLOGI is issued as soon a LOGO state is resolved.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_els.c       | 49 +++++++++++++-----------------
 drivers/scsi/lpfc/lpfc_nportdisc.c |  5 +++
 2 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 96e2f542734a..c2dae02f193e 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -242,6 +242,8 @@ lpfc_prep_els_iocb(struct lpfc_vport *vport, uint8_t expectRsp,
 		icmd->ulpCommand = CMD_ELS_REQUEST64_CR;
 		if (elscmd == ELS_CMD_FLOGI)
 			icmd->ulpTimeout = FF_DEF_RATOV * 2;
+		else if (elscmd == ELS_CMD_LOGO)
+			icmd->ulpTimeout = phba->fc_ratov;
 		else
 			icmd->ulpTimeout = phba->fc_ratov * 2;
 	} else {
@@ -2682,16 +2684,15 @@ lpfc_cmpl_els_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		goto out;
 	}
 
+	/* The LOGO will not be retried on failure.  A LOGO was
+	 * issued to the remote rport and a ACC or RJT or no Answer are
+	 * all acceptable.  Note the failure and move forward with
+	 * discovery.  The PLOGI will retry.
+	 */
 	if (irsp->ulpStatus) {
-		/* Check for retry */
-		if (lpfc_els_retry(phba, cmdiocb, rspiocb)) {
-			/* ELS command is being retried */
-			skip_recovery = 1;
-			goto out;
-		}
 		/* LOGO failed */
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
-				 "2756 LOGO failure DID:%06X Status:x%x/x%x\n",
+				 "2756 LOGO failure, No Retry DID:%06X Status:x%x/x%x\n",
 				 ndlp->nlp_DID, irsp->ulpStatus,
 				 irsp->un.ulpWord[4]);
 		/* Do not call DSM for lpfc_els_abort'ed ELS cmds */
@@ -2737,7 +2738,8 @@ out:
 	 * For any other port type, the rpi is unregistered as an implicit
 	 * LOGO.
 	 */
-	if ((ndlp->nlp_type & NLP_FCP_TARGET) && (skip_recovery == 0)) {
+	if (ndlp->nlp_type & (NLP_FCP_TARGET | NLP_NVME_TARGET) &&
+	    skip_recovery == 0) {
 		lpfc_cancel_retry_delay_tmo(vport, ndlp);
 		spin_lock_irqsave(shost->host_lock, flags);
 		ndlp->nlp_flag |= NLP_NPR_2B_DISC;
@@ -2770,6 +2772,8 @@ out:
  * will be stored into the context1 field of the IOCB for the completion
  * callback function to the LOGO ELS command.
  *
+ * Callers of this routine are expected to unregister the RPI first
+ *
  * Return code
  *   0 - successfully issued logo
  *   1 - failed to issue logo
@@ -2811,22 +2815,6 @@ lpfc_issue_els_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		"Issue LOGO:      did:x%x",
 		ndlp->nlp_DID, 0, 0);
 
-	/*
-	 * If we are issuing a LOGO, we may try to recover the remote NPort
-	 * by issuing a PLOGI later. Even though we issue ELS cmds by the
-	 * VPI, if we have a valid RPI, and that RPI gets unreg'ed while
-	 * that ELS command is in-flight, the HBA returns a IOERR_INVALID_RPI
-	 * for that ELS cmd. To avoid this situation, lets get rid of the
-	 * RPI right now, before any ELS cmds are sent.
-	 */
-	spin_lock_irq(shost->host_lock);
-	ndlp->nlp_flag |= NLP_ISSUE_LOGO;
-	spin_unlock_irq(shost->host_lock);
-	if (lpfc_unreg_rpi(vport, ndlp)) {
-		lpfc_els_free_iocb(phba, elsiocb);
-		return 0;
-	}
-
 	phba->fc_stat.elsXmitLOGO++;
 	elsiocb->iocb_cmpl = lpfc_cmpl_els_logo;
 	spin_lock_irq(shost->host_lock);
@@ -2834,7 +2822,6 @@ lpfc_issue_els_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	ndlp->nlp_flag &= ~NLP_ISSUE_LOGO;
 	spin_unlock_irq(shost->host_lock);
 	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
-
 	if (rc == IOCB_ERROR) {
 		spin_lock_irq(shost->host_lock);
 		ndlp->nlp_flag &= ~NLP_LOGO_SND;
@@ -2842,6 +2829,11 @@ lpfc_issue_els_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		lpfc_els_free_iocb(phba, elsiocb);
 		return 1;
 	}
+
+	spin_lock_irq(shost->host_lock);
+	ndlp->nlp_prev_state = ndlp->nlp_state;
+	spin_unlock_irq(shost->host_lock);
+	lpfc_nlp_set_state(vport, ndlp, NLP_STE_LOGO_ISSUE);
 	return 0;
 }
 
@@ -9508,7 +9500,8 @@ lpfc_sli_abts_recover_port(struct lpfc_vport *vport,
 				"rport in state 0x%x\n", ndlp->nlp_state);
 		return;
 	}
-	lpfc_printf_log(phba, KERN_INFO, LOG_SLI,
+	lpfc_printf_log(phba, KERN_ERR,
+			LOG_ELS | LOG_FCP_ERROR | LOG_NVME_IOERR,
 			"3094 Start rport recovery on shost id 0x%x "
 			"fc_id 0x%06x vpi 0x%x rpi 0x%x state 0x%x "
 			"flags 0x%x\n",
@@ -9521,8 +9514,8 @@ lpfc_sli_abts_recover_port(struct lpfc_vport *vport,
 	 */
 	spin_lock_irqsave(shost->host_lock, flags);
 	ndlp->nlp_fcp_info &= ~NLP_FCP_2_DEVICE;
+	ndlp->nlp_flag |= NLP_ISSUE_LOGO;
 	spin_unlock_irqrestore(shost->host_lock, flags);
-	lpfc_issue_els_logo(vport, ndlp, 0);
-	lpfc_nlp_set_state(vport, ndlp, NLP_STE_LOGO_ISSUE);
+	lpfc_unreg_rpi(vport, ndlp);
 }
 
diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index 269808e8480f..394ffbe9cb6d 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -836,7 +836,9 @@ lpfc_disc_set_adisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	struct Scsi_Host *shost = lpfc_shost_from_vport(vport);
 
 	if (!(ndlp->nlp_flag & NLP_RPI_REGISTERED)) {
+		spin_lock_irq(shost->host_lock);
 		ndlp->nlp_flag &= ~NLP_NPR_ADISC;
+		spin_unlock_irq(shost->host_lock);
 		return 0;
 	}
 
@@ -851,7 +853,10 @@ lpfc_disc_set_adisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 			return 1;
 		}
 	}
+
+	spin_lock_irq(shost->host_lock);
 	ndlp->nlp_flag &= ~NLP_NPR_ADISC;
+	spin_unlock_irq(shost->host_lock);
 	lpfc_unreg_rpi(vport, ndlp);
 	return 0;
 }
-- 
2.19.1



