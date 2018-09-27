Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E555BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A039521564
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A039521564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbeI0Hn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:43:29 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:36000 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbeI0HnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:43:00 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id A5C1229A17; Wed, 26 Sep 2018 21:27:14 -0400 (EDT)
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Ondrey Zary <linux@rainbow-software.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <415637c4234a45a626f293eef60766c244d1edbb.1538011031.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1538011031.git.fthain@telegraphics.com.au>
References: <cover.1538011031.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 08/10] NCR5380: Don't call dsprintk() following reselection
 interrupt
Date:   Thu, 27 Sep 2018 11:17:11 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The X3T9.2 specification (draft) says, under "6.1.4.1 RESELECTION",

    ... The reselected initiator shall then assert the BSY signal
    within a selection abort time of its most recent detection of being
    reselected; this is required for correct operation of the time-out
    procedure.

The selection abort time is only 200 us which may be insufficient time
for a printk() call. Move the diagnostics to the error paths.

Tested-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/scsi/NCR5380.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index 5826421146ba..419033643015 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -2023,8 +2023,6 @@ static void NCR5380_reselect(struct Scsi_Host *instance)
 		return;
 	}
 
-	dsprintk(NDEBUG_RESELECTION, instance, "reselect\n");
-
 	/*
 	 * At this point, we have detected that our SCSI ID is on the bus,
 	 * SEL is true and BSY was false for at least one bus settle delay
@@ -2037,6 +2035,7 @@ static void NCR5380_reselect(struct Scsi_Host *instance)
 	NCR5380_write(INITIATOR_COMMAND_REG, ICR_BASE | ICR_ASSERT_BSY);
 	if (NCR5380_poll_politely(hostdata,
 	                          STATUS_REG, SR_SEL, 0, 2 * HZ) < 0) {
+		shost_printk(KERN_ERR, instance, "reselect: !SEL timeout\n");
 		NCR5380_write(INITIATOR_COMMAND_REG, ICR_BASE);
 		return;
 	}
@@ -2048,6 +2047,7 @@ static void NCR5380_reselect(struct Scsi_Host *instance)
 
 	if (NCR5380_poll_politely(hostdata,
 	                          STATUS_REG, SR_REQ, SR_REQ, 2 * HZ) < 0) {
+		shost_printk(KERN_ERR, instance, "reselect: REQ timeout\n");
 		do_abort(instance);
 		return;
 	}
-- 
2.16.4

