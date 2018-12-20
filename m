Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDDBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60B92176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545299167;
	bh=eQCkzWFd646MgTWK44jKntqgLVz5BhqPzGZ4+9tb+lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SA7rC1KHwQo7mqx1Wiri6bHPZnjRW8Xv6ydARma73wedSSYtgGBfI8h92/MhhIufh
	 RX3kdu3pUi7kHb80pqFF+n7Wvo7pUW1C4cPG6b4rBTRP61auZ6JKux3TKVw9OkXd/T
	 at2eADmGBTca9PtfWJ1/cGTp+3bWFKQUwpmI1LOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbeLTJqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:46:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730616AbeLTJU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:20:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F5BD21720;
        Thu, 20 Dec 2018 09:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297625;
        bh=eQCkzWFd646MgTWK44jKntqgLVz5BhqPzGZ4+9tb+lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AlvQNVbIT3U1xP+etdowreaE+I1OlQ3UsUuyVthQMZ+IP5pMaVVjDMQjFGtCx+MFv
         MSkUPmMttn9iaK1QqdCVWtcIlydQ0lqUN3rwYn7NS/HFe4Xrorw/FfJm7qJcXSTv9z
         jH1YwwHgNZks0XgxaYupis41lSsMVXtcItU02suQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Piotr Gabriel Kosinski <pg.kosinski@gmail.com>,
        Daniel Shapira <daniel@twistlock.com>,
        Kees Cook <keescook@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 3.18 29/31] sr: pass down correctly sized SCSI sense buffer
Date:   Thu, 20 Dec 2018 10:18:41 +0100
Message-Id: <20181220085743.753335991@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085742.601260254@linuxfoundation.org>
References: <20181220085742.601260254@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
 Backported to 4.4:
 - We always need to allocate a sense buffer in order to call
   scsi_normalize_sense()
 - Remove the existing conditional heap-allocation of the sense buffer]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/sr_ioctl.c |   21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

--- a/drivers/scsi/sr_ioctl.c
+++ b/drivers/scsi/sr_ioctl.c
@@ -187,30 +187,25 @@ int sr_do_ioctl(Scsi_CD *cd, struct pack
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
@@ -272,8 +267,6 @@ int sr_do_ioctl(Scsi_CD *cd, struct pack
 
 	/* Wake up a process waiting for device */
       out:
-	if (!cgc->sense)
-		kfree(sense);
 	cgc->stat = err;
 	return err;
 }


