Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21F4C10F04
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF9B21927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198301;
	bh=yZNbZjN7ovG387jir/AvXsVTD4boIgpK7fDBSrNLyHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Na1YbCTPSxDpZG49lp1wgOYEDy8K/pvLZQiVy6JiIDOBnJVwIfa1NOHvXnsqZyoqD
	 IRjbBO/R8PPA55zr2z/DnOr6Bzc/IcLGn+8H43YNVpbqyCCkz8joQLcm7Dhh5cfGlm
	 xyHZJ8MV/xU//SNvkwtWoPrZXToaMjgRH6gFlwEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390418AbfBOCK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:10:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:50516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390248AbfBOCKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:10:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 362F0206BA;
        Fri, 15 Feb 2019 02:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196622;
        bh=yZNbZjN7ovG387jir/AvXsVTD4boIgpK7fDBSrNLyHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FDzfQMhwnf0gRRU+Ecj2pD2qUez6dbPHMD/ib01EwW0OA0WBJ1IHSIrnhufzcr2Dg
         fWJhvUhzG9//bV8YFfX1kbGqkYDfJ1QCmDrCP3Vo5rR6dVmMkBeOzIEH36Ik3f1t1N
         donsxWb0/bfCwey2zbso7JEsobNzzyvL+xS2GZv4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Ewan D. Milne" <emilne@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 51/77] scsi: lpfc: nvme: avoid hang / use-after-free when destroying localport
Date:   Thu, 14 Feb 2019 21:08:29 -0500
Message-Id: <20190215020855.176727-51-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Ewan D. Milne" <emilne@redhat.com>

[ Upstream commit 7961cba6f7d8215fa632df3d220e5154bb825249 ]

We cannot wait on a completion object in the lpfc_nvme_lport structure in
the _destroy_localport() code path because the NVMe/fc transport will free
that structure immediately after the .localport_delete() callback.  This
results in a use-after-free, and a hang if slub_debug=FZPU is enabled.

Fix this by putting the completion on the stack.

Signed-off-by: Ewan D. Milne <emilne@redhat.com>
Acked-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_nvme.c | 16 +++++++++-------
 drivers/scsi/lpfc/lpfc_nvme.h |  2 +-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index ba831def9301..b6fe88de372a 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -297,7 +297,8 @@ lpfc_nvme_localport_delete(struct nvme_fc_local_port *localport)
 			 lport);
 
 	/* release any threads waiting for the unreg to complete */
-	complete(&lport->lport_unreg_done);
+	if (lport->vport->localport)
+		complete(lport->lport_unreg_cmp);
 }
 
 /* lpfc_nvme_remoteport_delete
@@ -2547,7 +2548,8 @@ lpfc_nvme_create_localport(struct lpfc_vport *vport)
  */
 void
 lpfc_nvme_lport_unreg_wait(struct lpfc_vport *vport,
-			   struct lpfc_nvme_lport *lport)
+			   struct lpfc_nvme_lport *lport,
+			   struct completion *lport_unreg_cmp)
 {
 #if (IS_ENABLED(CONFIG_NVME_FC))
 	u32 wait_tmo;
@@ -2559,8 +2561,7 @@ lpfc_nvme_lport_unreg_wait(struct lpfc_vport *vport,
 	 */
 	wait_tmo = msecs_to_jiffies(LPFC_NVME_WAIT_TMO * 1000);
 	while (true) {
-		ret = wait_for_completion_timeout(&lport->lport_unreg_done,
-						  wait_tmo);
+		ret = wait_for_completion_timeout(lport_unreg_cmp, wait_tmo);
 		if (unlikely(!ret)) {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_IOERR,
 					 "6176 Lport %p Localport %p wait "
@@ -2594,12 +2595,12 @@ lpfc_nvme_destroy_localport(struct lpfc_vport *vport)
 	struct lpfc_nvme_lport *lport;
 	struct lpfc_nvme_ctrl_stat *cstat;
 	int ret;
+	DECLARE_COMPLETION_ONSTACK(lport_unreg_cmp);
 
 	if (vport->nvmei_support == 0)
 		return;
 
 	localport = vport->localport;
-	vport->localport = NULL;
 	lport = (struct lpfc_nvme_lport *)localport->private;
 	cstat = lport->cstat;
 
@@ -2610,13 +2611,14 @@ lpfc_nvme_destroy_localport(struct lpfc_vport *vport)
 	/* lport's rport list is clear.  Unregister
 	 * lport and release resources.
 	 */
-	init_completion(&lport->lport_unreg_done);
+	lport->lport_unreg_cmp = &lport_unreg_cmp;
 	ret = nvme_fc_unregister_localport(localport);
 
 	/* Wait for completion.  This either blocks
 	 * indefinitely or succeeds
 	 */
-	lpfc_nvme_lport_unreg_wait(vport, lport);
+	lpfc_nvme_lport_unreg_wait(vport, lport, &lport_unreg_cmp);
+	vport->localport = NULL;
 	kfree(cstat);
 
 	/* Regardless of the unregister upcall response, clear
diff --git a/drivers/scsi/lpfc/lpfc_nvme.h b/drivers/scsi/lpfc/lpfc_nvme.h
index cfd4719be25c..b234d0298994 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.h
+++ b/drivers/scsi/lpfc/lpfc_nvme.h
@@ -50,7 +50,7 @@ struct lpfc_nvme_ctrl_stat {
 /* Declare nvme-based local and remote port definitions. */
 struct lpfc_nvme_lport {
 	struct lpfc_vport *vport;
-	struct completion lport_unreg_done;
+	struct completion *lport_unreg_cmp;
 	/* Add stats counters here */
 	struct lpfc_nvme_ctrl_stat *cstat;
 	atomic_t fc4NvmeLsRequests;
-- 
2.19.1

