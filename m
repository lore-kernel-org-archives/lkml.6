Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC9AC677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156F62089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oesT8Hoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156F62089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeJHWiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:38:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727524AbeJHWiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7C1621502;
        Mon,  8 Oct 2018 15:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012364;
        bh=uP0j5iX/GsK81IFolQxboZYFiVba3iiLImdNtsF7TA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oesT8HoesTjlWQPwhrmhBPaE9szPhp2i8YKZ4MrSCecg/7UABc1ttoh5MDOV1aq4j
         Or1FoStzbUmaDdEsNyxIvL8zfPCaxoWB4gvKwcDzenqP3mzDCSXKlxNYHb4uzSFoNC
         ogZYH/42ghnDlkpDQB8TIlhfkoLLMu8GPMLw9NWc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 39/58] scsi: lpfc: Synchronize access to remoteport via rport
Date:   Mon,  8 Oct 2018 11:25:04 -0400
Message-Id: <20181008152523.70705-39-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/scsi/lpfc/lpfc_attr.c    | 15 ++++++++++-----
 drivers/scsi/lpfc/lpfc_debugfs.c | 10 +++++-----
 drivers/scsi/lpfc/lpfc_nvme.c    | 11 ++++++++---
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 729d343861f4..de64cbb0e3d5 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -320,12 +320,12 @@ lpfc_nvme_info_show(struct device *dev, struct device_attribute *attr,
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
 
@@ -3304,6 +3304,7 @@ lpfc_update_rport_devloss_tmo(struct lpfc_vport *vport)
 	struct lpfc_nodelist  *ndlp;
 #if (IS_ENABLED(CONFIG_NVME_FC))
 	struct lpfc_nvme_rport *rport;
+	struct nvme_fc_remote_port *remoteport = NULL;
 #endif
 
 	shost = lpfc_shost_from_vport(vport);
@@ -3314,8 +3315,12 @@ lpfc_update_rport_devloss_tmo(struct lpfc_vport *vport)
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
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 9df0c051349f..aec5b10a8c85 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -551,7 +551,7 @@ lpfc_debugfs_nodelist_data(struct lpfc_vport *vport, char *buf, int size)
 	unsigned char *statep;
 	struct nvme_fc_local_port *localport;
 	struct lpfc_nvmet_tgtport *tgtp;
-	struct nvme_fc_remote_port *nrport;
+	struct nvme_fc_remote_port *nrport = NULL;
 	struct lpfc_nvme_rport *rport;
 
 	cnt = (LPFC_NODELIST_SIZE / LPFC_NODELIST_ENTRY_SIZE);
@@ -696,11 +696,11 @@ lpfc_debugfs_nodelist_data(struct lpfc_vport *vport, char *buf, int size)
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
 
diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index cab1fb087e6a..0960dcaf1684 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -2718,7 +2718,9 @@ lpfc_nvme_register_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	rpinfo.port_name = wwn_to_u64(ndlp->nlp_portname.u.wwn);
 	rpinfo.node_name = wwn_to_u64(ndlp->nlp_nodename.u.wwn);
 
+	spin_lock_irq(&vport->phba->hbalock);
 	oldrport = lpfc_ndlp_get_nrport(ndlp);
+	spin_unlock_irq(&vport->phba->hbalock);
 	if (!oldrport)
 		lpfc_nlp_get(ndlp);
 
@@ -2833,7 +2835,7 @@ lpfc_nvme_unregister_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	struct nvme_fc_local_port *localport;
 	struct lpfc_nvme_lport *lport;
 	struct lpfc_nvme_rport *rport;
-	struct nvme_fc_remote_port *remoteport;
+	struct nvme_fc_remote_port *remoteport = NULL;
 
 	localport = vport->localport;
 
@@ -2847,11 +2849,14 @@ lpfc_nvme_unregister_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
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
-- 
2.17.1

