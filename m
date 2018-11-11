Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E00C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1152154B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPPudz4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1152154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390868AbeKLIse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:48:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:52752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403761AbeKLIWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:40 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D74A224B3;
        Sun, 11 Nov 2018 22:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975563;
        bh=whBubtctHN0XzGkrB9oquC7z6UDi+Qk+HBPwW0+Ecig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pPPudz4HY7LQLKBxlPpBe3QA39dT85k6t3Da/dGz/fdy+tWkLxW5qzAG1pUKxbINK
         g4BWHRrE241HZXlK0q9G/DeZY+l/nEp3mbtpFRxW5QndjCistIEafbrjILgUU1AxqN
         tVmespqNabQ6LXXuAYm5ko97V1bEQGBzprzq29G8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 102/222] scsi: lpfc: Correct race with abort on completion path
Date:   Sun, 11 Nov 2018 14:23:19 -0800
Message-Id: <20181111221657.031781487@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_scsi.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -4149,9 +4149,17 @@ lpfc_scsi_cmd_iocb_cmpl(struct lpfc_hba
 
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


