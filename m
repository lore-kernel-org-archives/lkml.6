Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbeA3Ey5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 23:54:57 -0500
Received: from sabertooth01.qualcomm.com ([65.197.215.72]:10389 "EHLO
        sabertooth01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752232AbeA3Eyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 23:54:55 -0500
X-IronPort-AV: E=Sophos;i="5.46,433,1511856000";
   d="scan'208";a="123125336"
X-IronPort-AV: E=McAfee;i="5900,7806,8789"; a="277583"
X-MGA-submission: =?us-ascii?q?MDHN36voq5YcN9RlbVs3vGTZdxrFI1MdNsx+qY?=
 =?us-ascii?q?MCOfmmbwONVTJ3Aykgos8FladgNZ/p15FzaDX83VM1FdBQEawFYnEKue?=
 =?us-ascii?q?toGOBVdN4KMd5C+CczNreu5FvBmjGRP4VTuCjZY6o2FdEFXo6XYBNx1F?=
 =?us-ascii?q?ZZ?=
From: Asutosh Das <asutoshd@codeaurora.org>
To: subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] scsi: ufs: make sure all interrupts are processed
Date: Tue, 30 Jan 2018 10:24:26 +0530
Message-Id: <1517288066-13171-1-git-send-email-asutoshd@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Venkat Gopalakrishnan <venkatg@codeaurora.org>

As multiple requests are submitted to the ufs host controller in
parallel there could be instances where the command completion
interrupt arrives later for a request that is already processed
earlier as the corresponding doorbell was cleared when handling
the previous interrupt. Read the interrupt status in a loop after
processing the received interrupt to catch such interrupts and
handle it.

Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 8af2af3..58d81de 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -5357,19 +5357,30 @@ static irqreturn_t ufshcd_intr(int irq, void *__hba)
 	u32 intr_status, enabled_intr_status;
 	irqreturn_t retval = IRQ_NONE;
 	struct ufs_hba *hba = __hba;
+	int retries = hba->nutrs;
 
 	spin_lock(hba->host->host_lock);
 	intr_status = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
-	enabled_intr_status =
-		intr_status & ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
 
-	if (intr_status)
-		ufshcd_writel(hba, intr_status, REG_INTERRUPT_STATUS);
+	/*
+	 * There could be max of hba->nutrs reqs in flight and in worst case
+	 * if the reqs get finished 1 by 1 after the interrupt status is
+	 * read, make sure we handle them by checking the interrupt status
+	 * again in a loop until we process all of the reqs before returning.
+	 */
+	do {
+		enabled_intr_status =
+			intr_status & ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
+		if (intr_status)
+			ufshcd_writel(hba, intr_status, REG_INTERRUPT_STATUS);
+		if (enabled_intr_status) {
+			ufshcd_sl_intr(hba, enabled_intr_status);
+			retval = IRQ_HANDLED;
+		}
+
+		intr_status = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
+	} while (intr_status && --retries);
 
-	if (enabled_intr_status) {
-		ufshcd_sl_intr(hba, enabled_intr_status);
-		retval = IRQ_HANDLED;
-	}
 	spin_unlock(hba->host->host_lock);
 	return retval;
 }
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
