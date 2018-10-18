Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508DAC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0014021479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTTBW+pk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0014021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbeJSB7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:59:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727605AbeJSB7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:59:51 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F322621476;
        Thu, 18 Oct 2018 17:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885465;
        bh=GDXlObqnV+Cj8wc+A+0el9/9eGvoUkvqExmhOdRAi8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NTTBW+pk1tP76+qCzCKPIvEZgkpoELZPmOI69swGo7n4m3k1Pgu39tKpUr92ZF2dk
         rj1k2OWmQYdHZLH6liTyDmvXjBRhkWByrTtLn3QBplpwz1p62AAAxJyzH/f0EP8JZh
         tWvw2HKhYqU6e91b5OnMp8CzX0cXYWvdpSYMDdIM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 32/53] scsi: lpfc: Synchronize access to remoteport via rport
Date:   Thu, 18 Oct 2018 19:54:25 +0200
Message-Id: <20181018175422.370832021@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.561567978@linuxfoundation.org>
References: <20181018175416.561567978@linuxfoundation.org>
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

[ Upstream commit 9e210178267b80c4eeb832fade7e146a18c84915 ]

The driver currently uses the ndlp to get the local rport which is then used
to get the nvme transport remoteport pointer. There can be cases where a stale
remoteport pointer is obtained as synchronization isn't done through the
different dereferences.

Correct by using locks to synchronize the dereferences.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_attr.c    |   15 ++++++++++-----
 drivers/scsi/lpfc/lpfc_debugfs.c |   10 +++++-----
 drivers/scsi/lpfc/lpfc_nvme.c    |   11 ++++++++---
 3 files changed, 23 insertions(+), 13 deletions(-)

--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -320,12 +320,12 @@ lpfc_nvme_info_show(struct device *dev,
 			localport->port_id, statep);
 
 	list_for_each_entry(ndlp, &vport->fc_nodes, nlp_listp) {
+		nrport = NULL;
+		spin_lock(&vport->phba->hbalock);
 		rport = lpfc_ndlp_get_nrport(ndlp);
-		if (!rport)
-			continue;
-
-		/* local short-hand pointer. */
-		nrport = rport->remoteport;
+		if (rport)
+			nrport = rport->remoteport;
+		spin_unlock(&vport->phba->hbalock);
 		if (!nrport)
 			continue;
 
@@ -3304,6 +3304,7 @@ lpfc_update_rport_devloss_tmo(struct lpf
 	struct lpfc_nodelist  *ndlp;
 #if (IS_ENABLED(CONFIG_NVME_FC))
 	struct lpfc_nvme_rport *rport;
+	struct nvme_fc_remote_port *remoteport = NULL;
 #endif
 
 	shost = lpfc_shost_from_vport(vport);
@@ -3314,8 +3315,12 @@ lpfc_update_rport_devloss_tmo(struct lpf
 		if (ndlp->rport)
 			ndlp->rport->dev_loss_tmo = vport->cfg_devloss_tmo;
 #if (IS_ENABLED(CONFIG_NVME_FC))
+		spin_lock(&vport->phba->hbalock);
 		rport = lpfc_ndlp_get_nrport(ndlp);
 		if (rport)
+			remoteport = rport->remoteport;
+		spin_unlock(&vport->phba->hbalock);
+		if (remoteport)
 			nvme_fc_set_remoteport_devloss(rport->remoteport,
 						       vport->cfg_devloss_tmo);
 #endif
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -551,7 +551,7 @@ lpfc_debugfs_nodelist_data(struct lpfc_v
 	unsigned char *statep;
 	struct nvme_fc_local_port *localport;
 	struct lpfc_nvmet_tgtport *tgtp;
-	struct nvme_fc_remote_port *nrport;
+	struct nvme_fc_remote_port *nrport = NULL;
 	struct lpfc_nvme_rport *rport;
 
 	cnt = (LPFC_NODELIST_SIZE / LPFC_NODELIST_ENTRY_SIZE);
@@ -696,11 +696,11 @@ lpfc_debugfs_nodelist_data(struct lpfc_v
 	len += snprintf(buf + len, size - len, "\tRport List:\n");
 	list_for_each_entry(ndlp, &vport->fc_nodes, nlp_listp) {
 		/* local short-hand pointer. */
+		spin_lock(&phba->hbalock);
 		rport = lpfc_ndlp_get_nrport(ndlp);
-		if (!rport)
-			continue;
-
-		nrport = rport->remoteport;
+		if (rport)
+			nrport = rport->remoteport;
+		spin_unlock(&phba->hbalock);
 		if (!nrport)
 			continue;
 
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -2718,7 +2718,9 @@ lpfc_nvme_register_port(struct lpfc_vpor
 	rpinfo.port_name = wwn_to_u64(ndlp->nlp_portname.u.wwn);
 	rpinfo.node_name = wwn_to_u64(ndlp->nlp_nodename.u.wwn);
 
+	spin_lock_irq(&vport->phba->hbalock);
 	oldrport = lpfc_ndlp_get_nrport(ndlp);
+	spin_unlock_irq(&vport->phba->hbalock);
 	if (!oldrport)
 		lpfc_nlp_get(ndlp);
 
@@ -2833,7 +2835,7 @@ lpfc_nvme_unregister_port(struct lpfc_vp
 	struct nvme_fc_local_port *localport;
 	struct lpfc_nvme_lport *lport;
 	struct lpfc_nvme_rport *rport;
-	struct nvme_fc_remote_port *remoteport;
+	struct nvme_fc_remote_port *remoteport = NULL;
 
 	localport = vport->localport;
 
@@ -2847,11 +2849,14 @@ lpfc_nvme_unregister_port(struct lpfc_vp
 	if (!lport)
 		goto input_err;
 
+	spin_lock_irq(&vport->phba->hbalock);
 	rport = lpfc_ndlp_get_nrport(ndlp);
-	if (!rport)
+	if (rport)
+		remoteport = rport->remoteport;
+	spin_unlock_irq(&vport->phba->hbalock);
+	if (!remoteport)
 		goto input_err;
 
-	remoteport = rport->remoteport;
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_DISC,
 			 "6033 Unreg nvme remoteport %p, portname x%llx, "
 			 "port_id x%06x, portstate x%x port type x%x\n",


