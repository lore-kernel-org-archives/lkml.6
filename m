Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB17DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA7B20840
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197892;
	bh=DEMIOuBcLUP1oyQcFUatrVmvbRNZj1LAyKWt59j2gkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0iH1YyI2Xv+7f0Pckj0Lms6ExzM9FLZz95jOQCaSvYaAqeBFhssHQQPwe9GtbiwW3
	 5jQ48elMUtFheEI2KTrz4bgiduP+q4n8fLJ94y9hxk5MW+8PgcHyJocsA9r4vPigGU
	 uDfkF4jlown6Tc27pjgYiLp9h7H8pBEB/mXvlgNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731864AbfBOCbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:31:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404299AbfBOCMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:12:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E344921934;
        Fri, 15 Feb 2019 02:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196753;
        bh=DEMIOuBcLUP1oyQcFUatrVmvbRNZj1LAyKWt59j2gkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y4ytk3fSx8zr/QwkIEmkYVM4xeBqcKyy0d+YBL5lxRkUOit75/JPcIgkFqBt6Zl3D
         KlI9ivyvNerpF8Qv5ngor3rHzzQ5nGyxuawx5pDYw+OOJW3PJumr6Bp/kgLsdPPaLC
         cmHwdk8DOvbh6qHG5nct/XY4/2HZ4Ao28+KHEoGw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Ewan D. Milne" <emilne@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 44/65] scsi: lpfc: nvmet: avoid hang / use-after-free when destroying targetport
Date:   Thu, 14 Feb 2019 21:11:00 -0500
Message-Id: <20190215021121.177674-44-sashal@kernel.org>
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

[ Upstream commit c41f59884be5cca293ed61f3d64637dbba3a6381 ]

We cannot wait on a completion object in the lpfc_nvme_targetport structure
in the _destroy_targetport() code path because the NVMe/fc transport will
free that structure immediately after the .targetport_delete() callback.
This results in a use-after-free, and a hang if slub_debug=FZPU is enabled.

Fix this by putting the completion on the stack.

Signed-off-by: Ewan D. Milne <emilne@redhat.com>
Acked-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_nvmet.c | 8 +++++---
 drivers/scsi/lpfc/lpfc_nvmet.h | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index b766afe10d3d..e2575c8ec93e 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1003,7 +1003,8 @@ lpfc_nvmet_targetport_delete(struct nvmet_fc_target_port *targetport)
 	struct lpfc_nvmet_tgtport *tport = targetport->private;
 
 	/* release any threads waiting for the unreg to complete */
-	complete(&tport->tport_unreg_done);
+	if (tport->phba->targetport)
+		complete(tport->tport_unreg_cmp);
 }
 
 static void
@@ -1700,6 +1701,7 @@ lpfc_nvmet_destroy_targetport(struct lpfc_hba *phba)
 	struct lpfc_nvmet_tgtport *tgtp;
 	struct lpfc_queue *wq;
 	uint32_t qidx;
+	DECLARE_COMPLETION_ONSTACK(tport_unreg_cmp);
 
 	if (phba->nvmet_support == 0)
 		return;
@@ -1709,9 +1711,9 @@ lpfc_nvmet_destroy_targetport(struct lpfc_hba *phba)
 			wq = phba->sli4_hba.nvme_wq[qidx];
 			lpfc_nvmet_wqfull_flush(phba, wq, NULL);
 		}
-		init_completion(&tgtp->tport_unreg_done);
+		tgtp->tport_unreg_cmp = &tport_unreg_cmp;
 		nvmet_fc_unregister_targetport(phba->targetport);
-		wait_for_completion_timeout(&tgtp->tport_unreg_done, 5);
+		wait_for_completion_timeout(&tport_unreg_cmp, 5);
 		lpfc_nvmet_cleanup_io_context(phba);
 	}
 	phba->targetport = NULL;
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.h b/drivers/scsi/lpfc/lpfc_nvmet.h
index 1aaff63f1f41..0ec1082ce7ef 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.h
+++ b/drivers/scsi/lpfc/lpfc_nvmet.h
@@ -34,7 +34,7 @@
 /* Used for NVME Target */
 struct lpfc_nvmet_tgtport {
 	struct lpfc_hba *phba;
-	struct completion tport_unreg_done;
+	struct completion *tport_unreg_cmp;
 
 	/* Stats counters - lpfc_nvmet_unsol_ls_buffer */
 	atomic_t rcv_ls_req_in;
-- 
2.19.1

