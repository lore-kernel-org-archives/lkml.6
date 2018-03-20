Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752400AbeCTCun (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 22:50:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35578 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752130AbeCTCu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 22:50:26 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C59DC60FEF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-scsi@vger.kernel.org, timur@codeaurora.org,
        sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/7] scsi: lpfc: Eliminate duplicate barriers on weakly-ordered archs
Date: Mon, 19 Mar 2018 22:50:04 -0400
Message-Id: <1521514207-10695-5-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521514207-10695-1-git-send-email-okaya@codeaurora.org>
References: <1521514207-10695-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code includes barrier() followed by writel(). writel() already has a
barrier
on some architectures like arm64.

This ends up CPU observing two barriers back to back before executing the
register write.

Since code already has an explicit barrier call, changing writel() to
writel_relaxed().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/scsi/lpfc/lpfc_sli.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 5f5528a..7dae7d3 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -1647,7 +1647,7 @@ lpfc_sli_update_full_ring(struct lpfc_hba *phba, struct lpfc_sli_ring *pring)
 	 * Set ring 'ringno' to SET R0CE_REQ in Chip Att register.
 	 * The HBA will tell us when an IOCB entry is available.
 	 */
-	writel((CA_R0ATT|CA_R0CE_REQ) << (ringno*4), phba->CAregaddr);
+	writel_relaxed((CA_R0ATT|CA_R0CE_REQ) << (ringno*4), phba->CAregaddr);
 	readl(phba->CAregaddr); /* flush */
 
 	pring->stats.iocb_cmd_full++;
@@ -1672,7 +1672,7 @@ lpfc_sli_update_ring(struct lpfc_hba *phba, struct lpfc_sli_ring *pring)
 	 */
 	if (!(phba->sli3_options & LPFC_SLI3_CRP_ENABLED)) {
 		wmb();
-		writel(CA_R0ATT << (ringno * 4), phba->CAregaddr);
+		writel_relaxed(CA_R0ATT << (ringno * 4), phba->CAregaddr);
 		readl(phba->CAregaddr); /* flush */
 	}
 }
-- 
2.7.4
