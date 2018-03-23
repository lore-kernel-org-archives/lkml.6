Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521805794-2-10144346087537532143
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521805792; b=RMbDkIRO+mDqLozr5knL04+fbBp0jTNm+NTi6l+M08eerYo
    0p+L4hGqOTiOUr1wxOBZk9LVlRUvApzvukDY6ExoOfHKwMwGbZwUcsn4cFZ9nTgV
    miBySLhjlAlAlaCPiUmEaxWgQs3avPMx2eGBSM4C97ZrHA6nhkZCF38/at3XgKuN
    tn8ka5gIfZoa0QoCw/8yEJjhAuJghrmd8fKV9Av4yn0ugbeAlfidl3bwlFYMJikR
    BSP8ct75TlaCeb6uI9JS8dZG1/lrSo0i7qd5aKw+1qcmlo62ZJj5TtrLCRzfZ/Zv
    0e4QP1d+PzlP4M875cBZgNnfvC6gjm0vqMMidiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805792; bh=pe48rXlQ+8OXbC3L+lIjHeqCv7
    ot4hIexmx7Z8gN3lk=; b=guYZDMXKLjbUGBMumiLMxkVYFZHRyOu7lv+4WSS5Rh
    gIFnalERKagwQd4ezq5hj+khUsywWJHW4tndlUEoyphl4jK/NqPlQT9g94+v4tF4
    nxaxmitfuN2deo33UQ0YVsrVHcJqHD14nh4Ir2c0CvKQOuQrhwBvPwLLdgVz+aRC
    pkx4omGBhv/W7LNt5rvrwpaOxI8nMFO29YvUe2K9r++DK7F6tRpki7ulP2/My/qS
    1GoGSJApVXuDGuF0L/bJANHBy6qF2czgYLO+rV/B70iqqZGB5oIStVfCwfNy51CU
    4UHiM6vt7kwecy9ek3r+L+zkFpIXdn3hrdGW8WLcNoXw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754268AbeCWKCk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:02:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38394 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753828AbeCWKCi (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:02:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 56/77] scsi: lpfc: Fix SCSI LUN discovery when SCSI and NVME enabled
Date: Fri, 23 Mar 2018 10:54:30 +0100
Message-Id: <20180323094146.041649269@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Smart <jsmart2021@gmail.com>


[ Upstream commit 9de416ac67b54d666327ba927a190f4b7259f4a0 ]

When enabled for both SCSI and NVME support, and connected pt2pt to a
SCSI only target, the driver nodelist entry for the remote port is left
in PRLI_ISSUE state and no SCSI LUNs are discovered. Works fine if only
configured for SCSI support.

Error was due to some of the prli points still reflecting the need to
send only 1 PRLI. On a lot of fabric configs, targets were NVME only,
which meant the fabric-reported protocol attributes were only telling
the driver one protocol or the other. Thus things worked fine. With
pt2pt, the driver must send a PRLI for both protocols as there are no
hints on what the target supports. Thus pt2pt targets were hitting the
multiple PRLI issues.

Complete the dual PRLI support. Track explicitly whether scsi (fcp) or
nvme prli's have been sent. Accurately track protocol support detected
on each node as reported by the fabric or probed by PRLI traffic.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_ct.c        |    1 +
 drivers/scsi/lpfc/lpfc_els.c       |   30 ++++++++++++++++++++----------
 drivers/scsi/lpfc/lpfc_nportdisc.c |   30 +++++++++++++-----------------
 3 files changed, 34 insertions(+), 27 deletions(-)

--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -471,6 +471,7 @@ lpfc_prep_node_fc4type(struct lpfc_vport
 				"Parse GID_FTrsp: did:x%x flg:x%x x%x",
 				Did, ndlp->nlp_flag, vport->fc_flag);
 
+			ndlp->nlp_fc4_type &= ~(NLP_FC4_FCP | NLP_FC4_NVME);
 			/* By default, the driver expects to support FCP FC4 */
 			if (fc4_type == FC_TYPE_FCP)
 				ndlp->nlp_fc4_type |= NLP_FC4_FCP;
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -2088,6 +2088,10 @@ lpfc_cmpl_els_prli(struct lpfc_hba *phba
 	ndlp = (struct lpfc_nodelist *) cmdiocb->context1;
 	spin_lock_irq(shost->host_lock);
 	ndlp->nlp_flag &= ~NLP_PRLI_SND;
+
+	/* Driver supports multiple FC4 types.  Counters matter. */
+	vport->fc_prli_sent--;
+	ndlp->fc4_prli_sent--;
 	spin_unlock_irq(shost->host_lock);
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_CMD,
@@ -2095,9 +2099,6 @@ lpfc_cmpl_els_prli(struct lpfc_hba *phba
 		irsp->ulpStatus, irsp->un.ulpWord[4],
 		ndlp->nlp_DID);
 
-	/* Ddriver supports multiple FC4 types.  Counters matter. */
-	vport->fc_prli_sent--;
-
 	/* PRLI completes to NPort <nlp_DID> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "0103 PRLI completes to NPort x%06x "
@@ -2111,7 +2112,6 @@ lpfc_cmpl_els_prli(struct lpfc_hba *phba
 
 	if (irsp->ulpStatus) {
 		/* Check for retry */
-		ndlp->fc4_prli_sent--;
 		if (lpfc_els_retry(phba, cmdiocb, rspiocb)) {
 			/* ELS command is being retried */
 			goto out;
@@ -2190,6 +2190,15 @@ lpfc_issue_els_prli(struct lpfc_vport *v
 		ndlp->nlp_fc4_type |= NLP_FC4_NVME;
 	local_nlp_type = ndlp->nlp_fc4_type;
 
+	/* This routine will issue 1 or 2 PRLIs, so zero all the ndlp
+	 * fields here before any of them can complete.
+	 */
+	ndlp->nlp_type &= ~(NLP_FCP_TARGET | NLP_FCP_INITIATOR);
+	ndlp->nlp_type &= ~(NLP_NVME_TARGET | NLP_NVME_INITIATOR);
+	ndlp->nlp_fcp_info &= ~NLP_FCP_2_DEVICE;
+	ndlp->nlp_flag &= ~NLP_FIRSTBURST;
+	ndlp->nvme_fb_size = 0;
+
  send_next_prli:
 	if (local_nlp_type & NLP_FC4_FCP) {
 		/* Payload is 4 + 16 = 20 x14 bytes. */
@@ -2298,6 +2307,13 @@ lpfc_issue_els_prli(struct lpfc_vport *v
 	elsiocb->iocb_cmpl = lpfc_cmpl_els_prli;
 	spin_lock_irq(shost->host_lock);
 	ndlp->nlp_flag |= NLP_PRLI_SND;
+
+	/* The vport counters are used for lpfc_scan_finished, but
+	 * the ndlp is used to track outstanding PRLIs for different
+	 * FC4 types.
+	 */
+	vport->fc_prli_sent++;
+	ndlp->fc4_prli_sent++;
 	spin_unlock_irq(shost->host_lock);
 	if (lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0) ==
 	    IOCB_ERROR) {
@@ -2308,12 +2324,6 @@ lpfc_issue_els_prli(struct lpfc_vport *v
 		return 1;
 	}
 
-	/* The vport counters are used for lpfc_scan_finished, but
-	 * the ndlp is used to track outstanding PRLIs for different
-	 * FC4 types.
-	 */
-	vport->fc_prli_sent++;
-	ndlp->fc4_prli_sent++;
 
 	/* The driver supports 2 FC4 types.  Make sure
 	 * a PRLI is issued for all types before exiting.
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -390,6 +390,11 @@ lpfc_rcv_plogi(struct lpfc_vport *vport,
 		break;
 	}
 
+	ndlp->nlp_type &= ~(NLP_FCP_TARGET | NLP_FCP_INITIATOR);
+	ndlp->nlp_type &= ~(NLP_NVME_TARGET | NLP_NVME_INITIATOR);
+	ndlp->nlp_fcp_info &= ~NLP_FCP_2_DEVICE;
+	ndlp->nlp_flag &= ~NLP_FIRSTBURST;
+
 	/* Check for Nport to NPort pt2pt protocol */
 	if ((vport->fc_flag & FC_PT2PT) &&
 	    !(vport->fc_flag & FC_PT2PT_PLOGI)) {
@@ -742,9 +747,6 @@ lpfc_rcv_prli(struct lpfc_vport *vport,
 	lp = (uint32_t *) pcmd->virt;
 	npr = (PRLI *) ((uint8_t *) lp + sizeof (uint32_t));
 
-	ndlp->nlp_type &= ~(NLP_FCP_TARGET | NLP_FCP_INITIATOR);
-	ndlp->nlp_fcp_info &= ~NLP_FCP_2_DEVICE;
-	ndlp->nlp_flag &= ~NLP_FIRSTBURST;
 	if ((npr->prliType == PRLI_FCP_TYPE) ||
 	    (npr->prliType == PRLI_NVME_TYPE)) {
 		if (npr->initiatorFunc) {
@@ -769,8 +771,12 @@ lpfc_rcv_prli(struct lpfc_vport *vport,
 		 * type.  Target mode does not issue gft_id so doesn't get
 		 * the fc4 type set until now.
 		 */
-		if ((phba->nvmet_support) && (npr->prliType == PRLI_NVME_TYPE))
+		if (phba->nvmet_support && (npr->prliType == PRLI_NVME_TYPE)) {
 			ndlp->nlp_fc4_type |= NLP_FC4_NVME;
+			lpfc_nlp_set_state(vport, ndlp, NLP_STE_UNMAPPED_NODE);
+		}
+		if (npr->prliType == PRLI_FCP_TYPE)
+			ndlp->nlp_fc4_type |= NLP_FC4_FCP;
 	}
 	if (rport) {
 		/* We need to update the rport role values */
@@ -1552,7 +1558,6 @@ lpfc_rcv_prli_reglogin_issue(struct lpfc
 		if (ndlp->nlp_flag & NLP_RPI_REGISTERED) {
 			lpfc_rcv_prli(vport, ndlp, cmdiocb);
 			lpfc_els_rsp_prli_acc(vport, cmdiocb, ndlp);
-			lpfc_nlp_set_state(vport, ndlp, NLP_STE_UNMAPPED_NODE);
 		} else {
 			/* RPI registration has not completed. Reject the PRLI
 			 * to prevent an illegal state transition when the
@@ -1568,6 +1573,7 @@ lpfc_rcv_prli_reglogin_issue(struct lpfc
 			stat.un.b.lsRjtRsnCodeExp = LSEXP_CMD_IN_PROGRESS;
 			lpfc_els_rsp_reject(vport, stat.un.lsRjtError, cmdiocb,
 					    ndlp, NULL);
+			return ndlp->nlp_state;
 		}
 	} else {
 		/* Initiator mode. */
@@ -1922,13 +1928,6 @@ lpfc_cmpl_prli_prli_issue(struct lpfc_vp
 		return ndlp->nlp_state;
 	}
 
-	/* Check out PRLI rsp */
-	ndlp->nlp_type &= ~(NLP_FCP_TARGET | NLP_FCP_INITIATOR);
-	ndlp->nlp_fcp_info &= ~NLP_FCP_2_DEVICE;
-
-	/* NVME or FCP first burst must be negotiated for each PRLI. */
-	ndlp->nlp_flag &= ~NLP_FIRSTBURST;
-	ndlp->nvme_fb_size = 0;
 	if (npr && (npr->acceptRspCode == PRLI_REQ_EXECUTED) &&
 	    (npr->prliType == PRLI_FCP_TYPE)) {
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_DISC,
@@ -1945,8 +1944,6 @@ lpfc_cmpl_prli_prli_issue(struct lpfc_vp
 		if (npr->Retry)
 			ndlp->nlp_fcp_info |= NLP_FCP_2_DEVICE;
 
-		/* PRLI completed.  Decrement count. */
-		ndlp->fc4_prli_sent--;
 	} else if (nvpr &&
 		   (bf_get_be32(prli_acc_rsp_code, nvpr) ==
 		    PRLI_REQ_EXECUTED) &&
@@ -1991,8 +1988,6 @@ lpfc_cmpl_prli_prli_issue(struct lpfc_vp
 				 be32_to_cpu(nvpr->word5),
 				 ndlp->nlp_flag, ndlp->nlp_fcp_info,
 				 ndlp->nlp_type);
-		/* PRLI completed.  Decrement count. */
-		ndlp->fc4_prli_sent--;
 	}
 	if (!(ndlp->nlp_type & NLP_FCP_TARGET) &&
 	    (vport->port_type == LPFC_NPIV_PORT) &&
@@ -2016,7 +2011,8 @@ out_err:
 		ndlp->nlp_prev_state = NLP_STE_PRLI_ISSUE;
 		if (ndlp->nlp_type & (NLP_FCP_TARGET | NLP_NVME_TARGET))
 			lpfc_nlp_set_state(vport, ndlp, NLP_STE_MAPPED_NODE);
-		else
+		else if (ndlp->nlp_type &
+			 (NLP_FCP_INITIATOR | NLP_NVME_INITIATOR))
 			lpfc_nlp_set_state(vport, ndlp, NLP_STE_UNMAPPED_NODE);
 	} else
 		lpfc_printf_vlog(vport,
