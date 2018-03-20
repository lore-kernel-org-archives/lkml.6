Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbeCTCu0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 22:50:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35142 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751857AbeCTCuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 22:50:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0165A60FEE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-scsi@vger.kernel.org, timur@codeaurora.org,
        sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/7] scsi: hpsa: Eliminate duplicate barriers on weakly-ordered archs
Date: Mon, 19 Mar 2018 22:50:01 -0400
Message-Id: <1521514207-10695-2-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521514207-10695-1-git-send-email-okaya@codeaurora.org>
References: <1521514207-10695-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code includes wmb() followed by writel(). writel() already has a
barrier on some architectures like arm64.

This ends up CPU observing two barriers back to back before executing
the register write.

Since code already has an explicit barrier call, changing writel() to
writel_relaxed().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/scsi/hpsa.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/hpsa.h b/drivers/scsi/hpsa.h
index 018f980..c7d7e6a 100644
--- a/drivers/scsi/hpsa.h
+++ b/drivers/scsi/hpsa.h
@@ -599,7 +599,7 @@ static unsigned long SA5_ioaccel_mode1_completed(struct ctlr_info *h, u8 q)
 		 * but with current driver design this is easiest.
 		 */
 		wmb();
-		writel((q << 24) | rq->current_entry, h->vaddr +
+		writel_relaxed((q << 24) | rq->current_entry, h->vaddr +
 				IOACCEL_MODE1_CONSUMER_INDEX);
 		atomic_dec(&h->commands_outstanding);
 	}
-- 
2.7.4
