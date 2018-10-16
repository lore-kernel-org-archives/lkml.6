Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB9FC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E586208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E586208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbeJPN2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 09:28:25 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:57206 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbeJPN2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 09:28:05 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 78C7C27FFB; Tue, 16 Oct 2018 01:39:21 -0400 (EDT)
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <4208077979dff12471046ab27be1d7a89887d1d3.1539667885.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1539667885.git.fthain@telegraphics.com.au>
References: <cover.1539667885.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v3 3/6] esp_scsi: Grant disconnect privilege for untagged
 commands
Date:   Tue, 16 Oct 2018 16:31:25 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A SCSI device is not granted disconnect privilege by an esp_scsi host
unless that device has its simple_tags flag set. However, a device may
support disconnect/reselect and not support command queueing. Allow
such devices to disconnect and thereby improve bus utilization.

Drop the redundant 'lp' check. The mid-layer invokes .slave_alloc and
.slave_destroy in such a way that we may rely on scmd->device->hostdata
for as long as scmd belongs to the low-level driver.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Michael Schmitz <schmitzmic@gmail.com>
---
Changed since v2:
 - Drop redundant 'lp' check.
---
 drivers/scsi/esp_scsi.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
index 9e5d3f7d29ae..5b24aa21a797 100644
--- a/drivers/scsi/esp_scsi.c
+++ b/drivers/scsi/esp_scsi.c
@@ -717,7 +717,6 @@ static struct esp_cmd_entry *find_and_prep_issuable_command(struct esp *esp)
 static void esp_maybe_execute_command(struct esp *esp)
 {
 	struct esp_target_data *tp;
-	struct esp_lun_data *lp;
 	struct scsi_device *dev;
 	struct scsi_cmnd *cmd;
 	struct esp_cmd_entry *ent;
@@ -743,7 +742,6 @@ static void esp_maybe_execute_command(struct esp *esp)
 	tgt = dev->id;
 	lun = dev->lun;
 	tp = &esp->target[tgt];
-	lp = dev->hostdata;
 
 	list_move(&ent->list, &esp->active_cmds);
 
@@ -799,14 +797,7 @@ static void esp_maybe_execute_command(struct esp *esp)
 	}
 
 build_identify:
-	/* If we don't have a lun-data struct yet, we're probing
-	 * so do not disconnect.  Also, do not disconnect unless
-	 * we have a tag on this command.
-	 */
-	if (lp && (tp->flags & ESP_TGT_DISCONNECT) && ent->tag[0])
-		*p++ = IDENTIFY(1, lun);
-	else
-		*p++ = IDENTIFY(0, lun);
+	*p++ = IDENTIFY(tp->flags & ESP_TGT_DISCONNECT, lun);
 
 	if (ent->tag[0] && esp->rev == ESP100) {
 		/* ESP100 lacks select w/atn3 command, use select
-- 
2.18.1

