Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583B7C282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1A02173C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690264;
	bh=knFEJcZFbKzS9njNVwXKqCcmtNUoSQI160ph0QycVFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N4DK0sTI0jaRsWStKpzyE6C0Z+sRC/t48C0Ykd7r1dDQpQPGU9GWzvpAdVb/K3yuw
	 7zD6hcjiZ+v1voIkZYdhKtxrPN2/YfXcndOdh51IGu9BczxX8XgCi0NoXXl1zBT1A7
	 CkSaoO+QoRwf3253ahhDY2NY5YNWLif8sj1lTM/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfA1PoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:44:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:57630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfA1PoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:44:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DF8720880;
        Mon, 28 Jan 2019 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690258;
        bh=knFEJcZFbKzS9njNVwXKqCcmtNUoSQI160ph0QycVFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cf4SDxQkK2WqnDSUQEwh4xuhagB2HayPWcp0H3S8jq7N1byOuz388d4E1YfbkzmmY
         GM63RX49DYcPT0dqtJz6S/gTamTduxK0L56KpoAvCr5mkHLuwzQsypgbVjF62l7XHy
         7n6Nzu+w7oZ5ZukSbqw2bykCqAFEGUUO5GjUwefc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 021/304] scsi: lpfc: Fix LOGO/PLOGI handling when triggerd by ABTS Timeout event
Date:   Mon, 28 Jan 2019 10:38:58 -0500
Message-Id: <20190128154341.47195-21-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

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

