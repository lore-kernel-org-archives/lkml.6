Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbeCTCvg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 22:51:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35528 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751915AbeCTCuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 22:50:25 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E47B960C54
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-scsi@vger.kernel.org, timur@codeaurora.org,
        sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/7] scsi: megaraid: eliminate duplicate barriers on weakly-ordered archs
Date: Mon, 19 Mar 2018 22:50:02 -0400
Message-Id: <1521514207-10695-3-git-send-email-okaya@codeaurora.org>
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

Create a new wrapper function with relaxed write operator. Use the new
wrapper when a write is following a barrier().

Since code already has an explicit barrier call, changing writel() to
writel_relaxed().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/scsi/megaraid/megaraid_mbox.c       | 8 ++++----
 drivers/scsi/megaraid/megaraid_mbox.h       | 2 ++
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 4 ++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_mbox.c b/drivers/scsi/megaraid/megaraid_mbox.c
index 530358c..8c4fc6e 100644
--- a/drivers/scsi/megaraid/megaraid_mbox.c
+++ b/drivers/scsi/megaraid/megaraid_mbox.c
@@ -1439,7 +1439,7 @@ mbox_post_cmd(adapter_t *adapter, scb_t *scb)
 	mbox->ack	= 0;
 	wmb();
 
-	WRINDOOR(raid_dev, raid_dev->mbox_dma | 0x1);
+	WRINDOOR_RELAXED(raid_dev, raid_dev->mbox_dma | 0x1);
 
 	spin_unlock_irqrestore(MAILBOX_LOCK(raid_dev), flags);
 
@@ -2752,7 +2752,7 @@ mbox_post_sync_cmd(adapter_t *adapter, uint8_t raw_mbox[])
 	mbox->status		= 0xFF;
 
 	wmb();
-	WRINDOOR(raid_dev, raid_dev->mbox_dma | 0x1);
+	WRINDOOR_RELAXED(raid_dev, raid_dev->mbox_dma | 0x1);
 
 	// wait for maximum 1 second for status to post. If the status is not
 	// available within 1 second, assume FW is initializing and wait
@@ -2877,7 +2877,7 @@ mbox_post_sync_cmd_fast(adapter_t *adapter, uint8_t raw_mbox[])
 	mbox->status		= 0xFF;
 
 	wmb();
-	WRINDOOR(raid_dev, raid_dev->mbox_dma | 0x1);
+	WRINDOOR_RELAXED(raid_dev, raid_dev->mbox_dma | 0x1);
 
 	for (i = 0; i < MBOX_SYNC_WAIT_CNT; i++) {
 		if (mbox->numstatus != 0xFF) break;
@@ -3329,7 +3329,7 @@ megaraid_mbox_fire_sync_cmd(adapter_t *adapter)
 	mbox->status		= 0;
 
 	wmb();
-	WRINDOOR(raid_dev, raid_dev->mbox_dma | 0x1);
+	WRINDOOR_RELAXED(raid_dev, raid_dev->mbox_dma | 0x1);
 
 	/* Wait for maximum 1 min for status to post.
 	 * If the Firmware SUPPORTS the ABOVE COMMAND,
diff --git a/drivers/scsi/megaraid/megaraid_mbox.h b/drivers/scsi/megaraid/megaraid_mbox.h
index c1d86d9..641cbd4 100644
--- a/drivers/scsi/megaraid/megaraid_mbox.h
+++ b/drivers/scsi/megaraid/megaraid_mbox.h
@@ -230,6 +230,8 @@ typedef struct {
 
 #define RDINDOOR(rdev)		readl((rdev)->baseaddr + 0x20)
 #define RDOUTDOOR(rdev)		readl((rdev)->baseaddr + 0x2C)
+#define WRINDOOR_RELAXED(rdev, value)	\
+	writel_relaxed(value, (rdev)->baseaddr + 0x20)
 #define WRINDOOR(rdev, value)	writel(value, (rdev)->baseaddr + 0x20)
 #define WROUTDOOR(rdev, value)	writel(value, (rdev)->baseaddr + 0x2C)
 
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 073ced0..f560496 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -3479,11 +3479,11 @@ complete_cmd_fusion(struct megasas_instance *instance, u32 MSIxIndex)
 
 	wmb();
 	if (instance->msix_combined)
-		writel(((MSIxIndex & 0x7) << 24) |
+		writel_relaxed(((MSIxIndex & 0x7) << 24) |
 			fusion->last_reply_idx[MSIxIndex],
 			instance->reply_post_host_index_addr[MSIxIndex/8]);
 	else
-		writel((MSIxIndex << 24) |
+		writel_relaxed((MSIxIndex << 24) |
 			fusion->last_reply_idx[MSIxIndex],
 			instance->reply_post_host_index_addr[0]);
 	megasas_check_and_restore_queue_depth(instance);
-- 
2.7.4
