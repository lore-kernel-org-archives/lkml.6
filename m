Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423109AbeE1LFV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:05:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422945AbeE1LFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:05:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Piotr Gabriel Kosinski <pg.kosinski@gmail.com>,
        Daniel Shapira <daniel@twistlock.com>,
        Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.16 029/272] sr: pass down correctly sized SCSI sense buffer
Date: Mon, 28 May 2018 12:01:02 +0200
Message-Id: <20180528100243.141095651@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

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

Cc: stable@vger.kernel.org
Reported-by: Piotr Gabriel Kosinski <pg.kosinski@gmail.com>
Reported-by: Daniel Shapira <daniel@twistlock.com>
Tested-by: Kees Cook <keescook@chromium.org>
Fixes: 82ed4db499b8 ("block: split scsi_request out of struct request")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sr_ioctl.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/scsi/sr_ioctl.c
+++ b/drivers/scsi/sr_ioctl.c
@@ -188,9 +188,13 @@ int sr_do_ioctl(Scsi_CD *cd, struct pack
 	struct scsi_device *SDev;
 	struct scsi_sense_hdr sshdr;
 	int result, err = 0, retries = 0;
+	unsigned char sense_buffer[SCSI_SENSE_BUFFERSIZE], *senseptr = NULL;
 
 	SDev = cd->device;
 
+	if (cgc->sense)
+		senseptr = sense_buffer;
+
       retry:
 	if (!scsi_block_when_processing_errors(SDev)) {
 		err = -ENODEV;
@@ -198,10 +202,12 @@ int sr_do_ioctl(Scsi_CD *cd, struct pack
 	}
 
 	result = scsi_execute(SDev, cgc->cmd, cgc->data_direction,
-			      cgc->buffer, cgc->buflen,
-			      (unsigned char *)cgc->sense, &sshdr,
+			      cgc->buffer, cgc->buflen, senseptr, &sshdr,
 			      cgc->timeout, IOCTL_RETRIES, 0, 0, NULL);
 
+	if (cgc->sense)
+		memcpy(cgc->sense, sense_buffer, sizeof(*cgc->sense));
+
 	/* Minimal error checking.  Ignore cases we know about, and report the rest. */
 	if (driver_byte(result) != 0) {
 		switch (sshdr.sense_key) {
