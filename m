Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18198C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9632229F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550196761;
	bh=0fmo/1hOLW33BUoilBlv5AbObiuoEGlO3BNVFrK7Al8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1m7CUNiP0dLIsLIMNQzmL/gldu2pk1LQQBoWHYlhkdGHBXseqmXzKSYHMHTB6OgxC
	 vmEMTJy4zvGAIZC3PHmm7/gAiFEfTD8EyjIW9Ix2JbXpWypB4iZ9Oug4UaKKBhmv5t
	 EXTlbFMpsoO0N2CzxkMvKQdwGTlOIlHAlszUBSMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391180AbfBOCMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:12:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:52558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391133AbfBOCMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:12:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC6DD21B1C;
        Fri, 15 Feb 2019 02:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196752;
        bh=0fmo/1hOLW33BUoilBlv5AbObiuoEGlO3BNVFrK7Al8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eLVM75I+LRrRUiaci16smyjD2Z3CdM+eflARkmQhRE6Ld2Rqgmj4AKSQ3Nxa7FW3k
         g+7AlW2noL2cfw7u/xLIj9idzwgdvHsfQMNs0CpRt0d8r5XAJLowyhywqVGcpJIF1D
         3anHh+YxK0uRpbDYw5Vh6kw1gB+pbAKDmNVNdIys=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Ewan D. Milne" <emilne@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 43/65] scsi: lpfc: nvme: avoid hang / use-after-free when destroying localport
Date:   Thu, 14 Feb 2019 21:10:59 -0500
Message-Id: <20190215021121.177674-43-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
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
index 918ae18ef8a8..ca62117a2d13 100644
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
@@ -2556,7 +2557,8 @@ lpfc_nvme_create_localport(struct lpfc_vport *vport)
  */
 void
 lpfc_nvme_lport_unreg_wait(struct lpfc_vport *vport,
-			   struct lpfc_nvme_lport *lport)
+			   struct lpfc_nvme_lport *lport,
+			   struct completion *lport_unreg_cmp)
 {
 #if (IS_ENABLED(CONFIG_NVME_FC))
 	u32 wait_tmo;
@@ -2568,8 +2570,7 @@ lpfc_nvme_lport_unreg_wait(struct lpfc_vport *vport,
 	 */
 	wait_tmo = msecs_to_jiffies(LPFC_NVME_WAIT_TMO * 1000);
 	while (true) {
-		ret = wait_for_completion_timeout(&lport->lport_unreg_done,
-						  wait_tmo);
+		ret = wait_for_completion_timeout(lport_unreg_cmp, wait_tmo);
 		if (unlikely(!ret)) {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_IOERR,
 					 "6176 Lport %p Localport %p wait "
@@ -2603,12 +2604,12 @@ lpfc_nvme_destroy_localport(struct lpfc_vport *vport)
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
 
@@ -2619,13 +2620,14 @@ lpfc_nvme_destroy_localport(struct lpfc_vport *vport)
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

