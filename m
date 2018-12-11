Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0033C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C2D21473
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543401;
	bh=lHp+VSVR9D87A54sF5Oi8awE2vq2dXae/jkqjuzpUew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zrUTkEjnXxpLIyBdhaRlWTVDwBJf5S8UIVlttPEDAW4++wlYfWrB8+MLIQZ8usUhW
	 JRvd7MOJmXmHkHBX6+RcZ+dzrvsOFiAb5f4Id8xLhVG8jl33/jl4z3Ih7MQ/eM3T5m
	 WmxLO2vAYinZXpdPM8kaSdi36BmEiC7J/b3FhLCQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C2D21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbeLKPuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:50:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:38314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729163AbeLKPt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:49:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA1842084E;
        Tue, 11 Dec 2018 15:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543396;
        bh=lHp+VSVR9D87A54sF5Oi8awE2vq2dXae/jkqjuzpUew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XsR3uO97Hu/UqaRGcgp2vWDuT4MLx26LPgJK9CYmQdNVEUWcaOMRzYgtNc6/maEGM
         EYHHTlTB20RzrDhrI41DqtqVnqt3wdGBQfip5WJA5epvfRpRfaW4qvmT8Kh0tvJ8JU
         EJfLl/vDTEiyTReDcSH/R7A3kHdPg9llEipijv9A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Piotr Gabriel Kosinski <pg.kosinski@gmail.com>,
        Daniel Shapira <daniel@twistlock.com>,
        Kees Cook <keescook@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 35/51] sr: pass down correctly sized SCSI sense buffer
Date:   Tue, 11 Dec 2018 16:41:43 +0100
Message-Id: <20181211151616.962141872@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151612.328911565@linuxfoundation.org>
References: <20181211151612.328911565@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
 Backported to 4.9:
 - We always need to allocate a sense buffer in order to call
   scsi_normalize_sense()
 - Remove the existing conditional heap-allocation of the sense buffer]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/sr_ioctl.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/sr_ioctl.c b/drivers/scsi/sr_ioctl.c
index 03054c0e7689..3c3e8115f73d 100644
--- a/drivers/scsi/sr_ioctl.c
+++ b/drivers/scsi/sr_ioctl.c
@@ -187,30 +187,25 @@ int sr_do_ioctl(Scsi_CD *cd, struct packet_command *cgc)
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
@@ -261,8 +256,6 @@ int sr_do_ioctl(Scsi_CD *cd, struct packet_command *cgc)
 
 	/* Wake up a process waiting for device */
       out:
-	if (!cgc->sense)
-		kfree(sense);
 	cgc->stat = err;
 	return err;
 }
-- 
2.19.1



