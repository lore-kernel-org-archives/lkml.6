Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA1AC6787C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 01:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4DE20865
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 01:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4DE20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeJMIrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 04:47:12 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47204 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbeJMIqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 04:46:53 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id C82C529FC7; Fri, 12 Oct 2018 21:11:48 -0400 (EDT)
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <536cb5d0cc8a091a5b36baa53ff736d56a254724.1539391876.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1539391876.git.fthain@telegraphics.com.au>
References: <cover.1539391876.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 3/6] esp_scsi: Grant disconnect privilege for untagged
 commands
Date:   Sat, 13 Oct 2018 11:51:16 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A SCSI device is not granted disconnect privilege by an esp_scsi host
unless that device has its simple_tags flag set. However, a device may
support disconnect/reselect and not support command queueing. Allow
these devices to disconnect and improve bus utilization.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/scsi/esp_scsi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
index 9e5d3f7d29ae..b7c41aa9927c 100644
--- a/drivers/scsi/esp_scsi.c
+++ b/drivers/scsi/esp_scsi.c
@@ -800,13 +800,9 @@ static void esp_maybe_execute_command(struct esp *esp)
 
 build_identify:
 	/* If we don't have a lun-data struct yet, we're probing
-	 * so do not disconnect.  Also, do not disconnect unless
-	 * we have a tag on this command.
+	 * so do not disconnect.
 	 */
-	if (lp && (tp->flags & ESP_TGT_DISCONNECT) && ent->tag[0])
-		*p++ = IDENTIFY(1, lun);
-	else
-		*p++ = IDENTIFY(0, lun);
+	*p++ = IDENTIFY(lp && (tp->flags & ESP_TGT_DISCONNECT), lun);
 
 	if (ent->tag[0] && esp->rev == ESP100) {
 		/* ESP100 lacks select w/atn3 command, use select
-- 
2.16.4

