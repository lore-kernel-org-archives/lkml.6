Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CFCC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4804521564
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4804521564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeI0HnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:43:10 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:36006 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeI0HnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:43:01 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id BF28A29A18; Wed, 26 Sep 2018 21:27:14 -0400 (EDT)
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Ondrey Zary <linux@rainbow-software.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <9258c41a3e7f30e551cb6817e60816919f4e99d0.1538011031.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1538011031.git.fthain@telegraphics.com.au>
References: <cover.1538011031.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 10/10] NCR5380: Check for bus reset
Date:   Thu, 27 Sep 2018 11:17:11 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SR_RST bit isn't latched. Hence, detecting a bus reset isn't reliable.
When it is detected, the right thing to do is to drop all connected and
disconnected commands. The code for that is already present so refactor
it and call it when SR_RST is set.

Tested-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/scsi/NCR5380.c | 74 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 29 deletions(-)

diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index b9a3eb0647e4..8429c855701f 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -131,6 +131,7 @@
 
 static int do_abort(struct Scsi_Host *);
 static void do_reset(struct Scsi_Host *);
+static void bus_reset_cleanup(struct Scsi_Host *);
 
 /**
  * initialize_SCp - init the scsi pointer field
@@ -883,7 +884,14 @@ static irqreturn_t __maybe_unused NCR5380_intr(int irq, void *dev_id)
 			/* Probably Bus Reset */
 			NCR5380_read(RESET_PARITY_INTERRUPT_REG);
 
-			dsprintk(NDEBUG_INTR, instance, "unknown interrupt\n");
+			if (sr & SR_RST) {
+				/* Certainly Bus Reset */
+				shost_printk(KERN_WARNING, instance,
+					     "bus reset interrupt\n");
+				bus_reset_cleanup(instance);
+			} else {
+				dsprintk(NDEBUG_INTR, instance, "unknown interrupt\n");
+			}
 #ifdef SUN3_SCSI_VME
 			dregs->csr |= CSR_DMA_ENABLE;
 #endif
@@ -2305,31 +2313,12 @@ static int NCR5380_abort(struct scsi_cmnd *cmd)
 }
 
 
-/**
- * NCR5380_host_reset - reset the SCSI host
- * @cmd: SCSI command undergoing EH
- *
- * Returns SUCCESS
- */
-
-static int NCR5380_host_reset(struct scsi_cmnd *cmd)
+static void bus_reset_cleanup(struct Scsi_Host *instance)
 {
-	struct Scsi_Host *instance = cmd->device->host;
 	struct NCR5380_hostdata *hostdata = shost_priv(instance);
 	int i;
-	unsigned long flags;
 	struct NCR5380_cmd *ncmd;
 
-	spin_lock_irqsave(&hostdata->lock, flags);
-
-#if (NDEBUG & NDEBUG_ANY)
-	shost_printk(KERN_INFO, instance, __func__);
-#endif
-	NCR5380_dprint(NDEBUG_ANY, instance);
-	NCR5380_dprint_phase(NDEBUG_ANY, instance);
-
-	do_reset(instance);
-
 	/* reset NCR registers */
 	NCR5380_write(MODE_REG, MR_BASE);
 	NCR5380_write(TARGET_COMMAND_REG, 0);
@@ -2341,14 +2330,6 @@ static int NCR5380_host_reset(struct scsi_cmnd *cmd)
 	 * commands!
 	 */
 
-	list_for_each_entry(ncmd, &hostdata->unissued, list) {
-		struct scsi_cmnd *cmd = NCR5380_to_scmd(ncmd);
-
-		cmd->result = DID_RESET << 16;
-		cmd->scsi_done(cmd);
-	}
-	INIT_LIST_HEAD(&hostdata->unissued);
-
 	if (hostdata->selecting) {
 		hostdata->selecting->result = DID_RESET << 16;
 		complete_cmd(instance, hostdata->selecting);
@@ -2382,6 +2363,41 @@ static int NCR5380_host_reset(struct scsi_cmnd *cmd)
 
 	queue_work(hostdata->work_q, &hostdata->main_task);
 	maybe_release_dma_irq(instance);
+}
+
+/**
+ * NCR5380_host_reset - reset the SCSI host
+ * @cmd: SCSI command undergoing EH
+ *
+ * Returns SUCCESS
+ */
+
+static int NCR5380_host_reset(struct scsi_cmnd *cmd)
+{
+	struct Scsi_Host *instance = cmd->device->host;
+	struct NCR5380_hostdata *hostdata = shost_priv(instance);
+	unsigned long flags;
+	struct NCR5380_cmd *ncmd;
+
+	spin_lock_irqsave(&hostdata->lock, flags);
+
+#if (NDEBUG & NDEBUG_ANY)
+	shost_printk(KERN_INFO, instance, __func__);
+#endif
+	NCR5380_dprint(NDEBUG_ANY, instance);
+	NCR5380_dprint_phase(NDEBUG_ANY, instance);
+
+	list_for_each_entry(ncmd, &hostdata->unissued, list) {
+		struct scsi_cmnd *scmd = NCR5380_to_scmd(ncmd);
+
+		scmd->result = DID_RESET << 16;
+		scmd->scsi_done(scmd);
+	}
+	INIT_LIST_HEAD(&hostdata->unissued);
+
+	do_reset(instance);
+	bus_reset_cleanup(instance);
+
 	spin_unlock_irqrestore(&hostdata->lock, flags);
 
 	return SUCCESS;
-- 
2.16.4

