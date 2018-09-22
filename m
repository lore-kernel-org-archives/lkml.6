Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25745C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B672156B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B672156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392069AbeIVGSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:18:18 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44081 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391850AbeIVGKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:42 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vds-0008Bd-QI; Sat, 22 Sep 2018 01:19:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdn-0000r6-Kv; Sat, 22 Sep 2018 01:19:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Daniel Shapira" <daniel@twistlock.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Piotr Gabriel Kosinski" <pg.kosinski@gmail.com>,
        "Jens Axboe" <axboe@kernel.dk>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.799827552@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 18/63] sr: pass down correctly sized SCSI sense buffer
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit f7068114d45ec55996b9040e98111afa56e010fe upstream.

We're casting the CDROM layer request_sense to the SCSI sense
buffer, but the former is 64 bytes and the latter is 96 bytes.
As we generally allocate these on the stack, we end up blowing
up the stack.

Fix this by wrapping the scsi_execute() call with a properly
sized sense buffer, and copying back the bits for the CDROM
layer.

Reported-by: Piotr Gabriel Kosinski <pg.kosinski@gmail.com>
Reported-by: Daniel Shapira <daniel@twistlock.com>
Tested-by: Kees Cook <keescook@chromium.org>
Fixes: 82ed4db499b8 ("block: split scsi_request out of struct request")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[bwh: Despite what the "Fixes" field says, a buffer overrun was already
 possible if the sense data was really > 64 bytes long.
 Backported to 3.16:
 - We always need to allocate a sense buffer in order to call
   scsi_normalize_sense()
 - Remove the existing conditional heap-allocation of the sense buffer]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/scsi/sr_ioctl.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/scsi/sr_ioctl.c
+++ b/drivers/scsi/sr_ioctl.c
@@ -188,30 +188,25 @@ int sr_do_ioctl(Scsi_CD *cd, struct pack
 	struct scsi_device *SDev;
 	struct scsi_sense_hdr sshdr;
 	int result, err = 0, retries = 0;
-	struct request_sense *sense = cgc->sense;
+	unsigned char sense_buffer[SCSI_SENSE_BUFFERSIZE];
 
 	SDev = cd->device;
 
-	if (!sense) {
-		sense = kmalloc(SCSI_SENSE_BUFFERSIZE, GFP_KERNEL);
-		if (!sense) {
-			err = -ENOMEM;
-			goto out;
-		}
-	}
-
       retry:
 	if (!scsi_block_when_processing_errors(SDev)) {
 		err = -ENODEV;
 		goto out;
 	}
 
-	memset(sense, 0, sizeof(*sense));
+	memset(sense_buffer, 0, sizeof(sense_buffer));
 	result = scsi_execute(SDev, cgc->cmd, cgc->data_direction,
-			      cgc->buffer, cgc->buflen, (char *)sense,
+			      cgc->buffer, cgc->buflen, sense_buffer,
 			      cgc->timeout, IOCTL_RETRIES, 0, NULL);
 
-	scsi_normalize_sense((char *)sense, sizeof(*sense), &sshdr);
+	scsi_normalize_sense(sense_buffer, sizeof(sense_buffer), &sshdr);
+
+	if (cgc->sense)
+		memcpy(cgc->sense, sense_buffer, sizeof(*cgc->sense));
 
 	/* Minimal error checking.  Ignore cases we know about, and report the rest. */
 	if (driver_byte(result) != 0) {
@@ -268,8 +263,6 @@ int sr_do_ioctl(Scsi_CD *cd, struct pack
 
 	/* Wake up a process waiting for device */
       out:
-	if (!cgc->sense)
-		kfree(sense);
 	cgc->stat = err;
 	return err;
 }

