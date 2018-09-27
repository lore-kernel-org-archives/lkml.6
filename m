Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6157CC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C6221564
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C6221564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeI0Hn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:43:29 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:36004 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbeI0HnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:43:00 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id AEC3729A16; Wed, 26 Sep 2018 21:27:14 -0400 (EDT)
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Ondrey Zary <linux@rainbow-software.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <2d3935168bd7345cb60aba5b3f08d45f6e6cc0eb.1538011031.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1538011031.git.fthain@telegraphics.com.au>
References: <cover.1538011031.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 09/10] NCR5380: Handle BUS FREE during reselection
Date:   Thu, 27 Sep 2018 11:17:11 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The X3T9.2 specification (draft) says, under "6.1.4.2 RESELECTION
time-out procedure", that a target may assert RST or go to BUS FREE
phase if the initiator does not respond within 200 us. Something
like this has been observed with AztecMonster II target. When it
happens, all we can do is wait for the target to try again.

Tested-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/scsi/NCR5380.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index 419033643015..b9a3eb0647e4 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -2047,6 +2047,9 @@ static void NCR5380_reselect(struct Scsi_Host *instance)
 
 	if (NCR5380_poll_politely(hostdata,
 	                          STATUS_REG, SR_REQ, SR_REQ, 2 * HZ) < 0) {
+		if ((NCR5380_read(STATUS_REG) & (SR_BSY | SR_SEL)) == 0)
+			/* BUS FREE phase */
+			return;
 		shost_printk(KERN_ERR, instance, "reselect: REQ timeout\n");
 		do_abort(instance);
 		return;
-- 
2.16.4

