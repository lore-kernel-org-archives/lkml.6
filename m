Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AA4C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47A22064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ql2xjsmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47A22064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbeKAIJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:09:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730659AbeKAIJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:09:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58BE920664;
        Wed, 31 Oct 2018 23:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027382;
        bh=T8OeCwzhTo+0rk4FgpOODPVJ89RJlS63o8OhJiFlr4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ql2xjsmfeJjC6GYzAQLPVumrrDyZtp8UC1DU5GAe1P2P1Iv/HarHw6cRuqiRVbyW5
         ZnbI62L5qPy7gvDbV5X0AIe9MTDLKGmwE1QbTqmGGaetANbZUTbI4mRJZorSPI9cxA
         THxe5XVG7AyD3Z8m6b69iBYTC4/QhLAnsub8sZj0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 119/126] scsi: lpfc: Correct race with abort on completion path
Date:   Wed, 31 Oct 2018 19:07:47 -0400
Message-Id: <20181031230754.29029-119-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit ca7fb76e091f889cfda1287c07a9358f73832b39 ]

On io completion, the driver is taking an adapter wide lock and nulling the
scsi command back pointer.  The nulling of the back pointer is to signify the
io was completed and the scsi_done() routine was called.  However, the routine
makes no check to see if the abort routine had done the same thing and
possibly nulled the pointer. Thus it may doubly-complete the io.

Make the following mods:

- Check to make sure forward progress (call scsi_done()) only happens if the
  command pointer was non-null.

- As the taking of the lock, which is adapter wide, is very costly on a system
  under load, null the pointer using an xchg operation rather than under lock.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_scsi.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index a94fb9f8bb44..3b3af1459008 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -4140,9 +4140,17 @@ lpfc_scsi_cmd_iocb_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pIocbIn,
 	}
 	lpfc_scsi_unprep_dma_buf(phba, lpfc_cmd);
 
-	spin_lock_irqsave(&phba->hbalock, flags);
-	lpfc_cmd->pCmd = NULL;
-	spin_unlock_irqrestore(&phba->hbalock, flags);
+	/* If pCmd was set to NULL from abort path, do not call scsi_done */
+	if (xchg(&lpfc_cmd->pCmd, NULL) == NULL) {
+		lpfc_printf_vlog(vport, KERN_INFO, LOG_FCP,
+				 "0711 FCP cmd already NULL, sid: 0x%06x, "
+				 "did: 0x%06x, oxid: 0x%04x\n",
+				 vport->fc_myDID,
+				 (pnode) ? pnode->nlp_DID : 0,
+				 phba->sli_rev == LPFC_SLI_REV4 ?
+				 lpfc_cmd->cur_iocbq.sli4_xritag : 0xffff);
+		return;
+	}
 
 	/* The sdev is not guaranteed to be valid post scsi_done upcall. */
 	cmd->scsi_done(cmd);
-- 
2.17.1

