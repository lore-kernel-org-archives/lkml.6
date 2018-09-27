Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534C9C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1942156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1942156D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbeI0HnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:43:01 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:35904 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbeI0Hm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:42:59 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 35B0629A10; Wed, 26 Sep 2018 21:27:14 -0400 (EDT)
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Ondrey Zary <linux@rainbow-software.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <b5b6ec6689d57bcb5ee4be1aa053a0a83fdc5dcd.1538011031.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1538011031.git.fthain@telegraphics.com.au>
References: <cover.1538011031.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 02/10] NCR5380: Reduce goto statements in NCR5380_select()
Date:   Thu, 27 Sep 2018 11:17:11 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a 'goto' statement with a simple 'return' where possible.
This improves readability. No functional change.

Tested-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/scsi/NCR5380.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index 80c20ab4fc53..c6d10780febe 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -984,7 +984,7 @@ static struct scsi_cmnd *NCR5380_select(struct Scsi_Host *instance,
 	if (!hostdata->selecting) {
 		/* Command was aborted */
 		NCR5380_write(MODE_REG, MR_BASE);
-		goto out;
+		return NULL;
 	}
 	if (err < 0) {
 		NCR5380_write(MODE_REG, MR_BASE);
@@ -1033,7 +1033,7 @@ static struct scsi_cmnd *NCR5380_select(struct Scsi_Host *instance,
 	if (!hostdata->selecting) {
 		NCR5380_write(MODE_REG, MR_BASE);
 		NCR5380_write(INITIATOR_COMMAND_REG, ICR_BASE);
-		goto out;
+		return NULL;
 	}
 
 	dsprintk(NDEBUG_ARBITRATION, instance, "won arbitration\n");
@@ -1116,13 +1116,16 @@ static struct scsi_cmnd *NCR5380_select(struct Scsi_Host *instance,
 		spin_lock_irq(&hostdata->lock);
 		NCR5380_write(INITIATOR_COMMAND_REG, ICR_BASE);
 		NCR5380_write(SELECT_ENABLE_REG, hostdata->id_mask);
+
 		/* Can't touch cmd if it has been reclaimed by the scsi ML */
-		if (hostdata->selecting) {
-			cmd->result = DID_BAD_TARGET << 16;
-			complete_cmd(instance, cmd);
-			dsprintk(NDEBUG_SELECTION, instance, "target did not respond within 250ms\n");
-			cmd = NULL;
-		}
+		if (!hostdata->selecting)
+			return NULL;
+
+		cmd->result = DID_BAD_TARGET << 16;
+		complete_cmd(instance, cmd);
+		dsprintk(NDEBUG_SELECTION, instance,
+			"target did not respond within 250ms\n");
+		cmd = NULL;
 		goto out;
 	}
 
@@ -1155,7 +1158,7 @@ static struct scsi_cmnd *NCR5380_select(struct Scsi_Host *instance,
 	}
 	if (!hostdata->selecting) {
 		do_abort(instance);
-		goto out;
+		return NULL;
 	}
 
 	dsprintk(NDEBUG_SELECTION, instance, "target %d selected, going into MESSAGE OUT phase.\n",
-- 
2.16.4

