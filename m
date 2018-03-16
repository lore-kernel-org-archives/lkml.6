Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3328118-1521215514-2-1051159608703646408
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
    t=1521215513; b=NM24+2eGLAAfOQJLdb8WiGykdwf7wUzXN7hw+kRHvDwZ/P2
    hgJTnMaRzsZ6NgoaLS5QpUNdzsJXtqkjA5qPQE07wwzeE9q0jMVPnPkJ53wz5rCF
    4e1MvrncuX22wWylzOAIPfEUk2gpXn39aHi2BnHo5KEzIhWkmqqc7BQk/hriqfhh
    +aGDDryVG0aBLDZPmUrOx/5uEdJVKpjeiPNkyZv3ZJc4CGOzUNTziys94VFJZt3F
    6oqr3ic+gaGoV66fgkeJLg4w+PC2HJkgEhM8OdGU1BBSx28JQkPMp4Ll2FV4i1hI
    9MLWd8dzsmkRY1jXpWrEOL1pWydt1nS6TcnrRnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521215513; bh=cTqJJ74otfNfjgnJrsaSKw32X6
    v+rANMKNsBkvrPmxI=; b=VHleXtKWIvgaMk1wq6JocWb/uBvFLVZW5v/PxuLt1I
    IuyYNV7PYyz8iZor6/PJ+TIM2Se13phQsMZ8CN782PAbgwVw6Nx/OnZyS0MEdSAl
    CoY6vcijSzPosMm5jAJqtyQmtBtFRUt6Jh4i71aZ/qr1ouMWADoU1DSE/b7tEDu2
    GRfXl+cc8Zl4zXYg5dOp92qtbHwsVZli6bFws/1i6yIJalAm5rwJIRDCgQl2PxyA
    Tfdrk1TCAJXBucCvXM9Q+Ww/5jCeZkB1RzkROxSEY2vghrebF0p1hXVMB/DMuESN
    BZiQ7om0E6ew9BMANWGkupA48PAeRdI2VCnU+c9FjkZQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754102AbeCPPoc (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:44:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45962 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934548AbeCPPo2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:44:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 081/128] scsi: lpfc: Fix crash during driver unload with running nvme traffic
Date: Fri, 16 Mar 2018 16:23:42 +0100
Message-Id: <20180316152340.674900786@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Smart <jsmart2021@gmail.com>


[ Upstream commit 3386f4bdd243ad5a9094d390297602543abe9902 ]

When the driver is unloading, the nvme transport could be in the process
of submitting new requests, will send abort requests to terminate
associations, or may make LS-related requests.  The driver's abort and
request entry points currently is ignorant of the unloading state and is
starting the requests even though the infrastructure to complete them
continues to teardown.

Change the entry points for new requests to check whether unloading and
if so, reject the requests. Abort routines check unloading, and if so,
noop the request. An abort is noop'd as the teardown paths are already
aborting/terminating the io outstanding at the time the teardown
initiated.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_nvme.c  |   14 ++++++++++++++
 drivers/scsi/lpfc/lpfc_nvmet.c |   11 +++++++++++
 2 files changed, 25 insertions(+)

--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -419,6 +419,9 @@ lpfc_nvme_ls_req(struct nvme_fc_local_po
 	if (vport->load_flag & FC_UNLOADING)
 		return -ENODEV;
 
+	if (vport->load_flag & FC_UNLOADING)
+		return -ENODEV;
+
 	ndlp = lpfc_findnode_did(vport, pnvme_rport->port_id);
 	if (!ndlp || !NLP_CHK_NODE_ACT(ndlp)) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_NODE | LOG_NVME_IOERR,
@@ -534,6 +537,9 @@ lpfc_nvme_ls_abort(struct nvme_fc_local_
 	vport = lport->vport;
 	phba = vport->phba;
 
+	if (vport->load_flag & FC_UNLOADING)
+		return;
+
 	ndlp = lpfc_findnode_did(vport, pnvme_rport->port_id);
 	if (!ndlp) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_ABTS,
@@ -1260,6 +1266,11 @@ lpfc_nvme_fcp_io_submit(struct nvme_fc_l
 		goto out_fail;
 	}
 
+	if (vport->load_flag & FC_UNLOADING) {
+		ret = -ENODEV;
+		goto out_fail;
+	}
+
 	/* Validate pointers. */
 	if (!pnvme_lport || !pnvme_rport || !freqpriv) {
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_IOERR | LOG_NODE,
@@ -1487,6 +1498,9 @@ lpfc_nvme_fcp_abort(struct nvme_fc_local
 	vport = lport->vport;
 	phba = vport->phba;
 
+	if (vport->load_flag & FC_UNLOADING)
+		return;
+
 	/* Announce entry to new IO submit field. */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_ABTS,
 			 "6002 Abort Request to rport DID x%06x "
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -635,6 +635,9 @@ lpfc_nvmet_xmt_ls_rsp(struct nvmet_fc_ta
 	if (phba->pport->load_flag & FC_UNLOADING)
 		return -ENODEV;
 
+	if (phba->pport->load_flag & FC_UNLOADING)
+		return -ENODEV;
+
 	lpfc_printf_log(phba, KERN_INFO, LOG_NVME_DISC,
 			"6023 NVMET LS rsp oxid x%x\n", ctxp->oxid);
 
@@ -721,6 +724,11 @@ lpfc_nvmet_xmt_fcp_op(struct nvmet_fc_ta
 		goto aerr;
 	}
 
+	if (phba->pport->load_flag & FC_UNLOADING) {
+		rc = -ENODEV;
+		goto aerr;
+	}
+
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	if (ctxp->ts_cmd_nvme) {
 		if (rsp->op == NVMET_FCOP_RSP)
@@ -822,6 +830,9 @@ lpfc_nvmet_xmt_fcp_abort(struct nvmet_fc
 
 	if (phba->pport->load_flag & FC_UNLOADING)
 		return;
+
+	if (phba->pport->load_flag & FC_UNLOADING)
+		return;
 
 	lpfc_printf_log(phba, KERN_INFO, LOG_NVME_ABTS,
 			"6103 NVMET Abort op: oxri x%x flg x%x ste %d\n",
