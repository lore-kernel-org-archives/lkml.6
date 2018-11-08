Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB552C0044B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD3F2133D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ybx42wjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD3F2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbeKIIME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:12:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:55158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729562AbeKIHhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:37:16 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14A122146E;
        Thu,  8 Nov 2018 21:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714388;
        bh=LZUBXsKa4xsfOpsv14PNTNDA6sw078o2DZaWj54VsGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ybx42wjHh74ehMOI7Hu2Gye65mCTuPOpMTVCHzlZGfX8qUSAa+ZM8/7sEY74gXODu
         v9MBCFWLezmNUhXP9MpOJq30eQDBo/Bm9Dy6QbeFvP4fndfLk0AskPQL5MxwW+fqfj
         x5NaorqlTLJnQWdzt6vpMxhJxJJwUVv+YsEH4kpk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Kris Lindgren <kris.lindgren@gmail.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 050/114] usb-storage: fix bogus hardware error messages for ATA pass-thru devices
Date:   Thu,  8 Nov 2018 13:51:05 -0800
Message-Id: <20181108215105.667838736@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a4fd4a724d6c30ad671046d83be2e9be2f11d275 ]

Ever since commit a621bac3044e ("scsi_lib: correctly retry failed zero
length REQ_TYPE_FS commands"), people have been getting bogus error
messages for USB disk drives using ATA pass-thru.  For example:

[ 1344.880193] sd 6:0:0:0: [sdb] Attached SCSI disk
[ 1345.069152] sd 6:0:0:0: [sdb] tag#0 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_SENSE
[ 1345.069159] sd 6:0:0:0: [sdb] tag#0 Sense Key : Hardware Error [current] [descriptor]
[ 1345.069162] sd 6:0:0:0: [sdb] tag#0 Add. Sense: No additional sense information
[ 1345.069168] sd 6:0:0:0: [sdb] tag#0 CDB: ATA command pass through(16) 85 06 20 00 00 00 00 00 00 00 00 00 00 00 e5 00
[ 1345.172252] sd 6:0:0:0: [sdb] tag#0 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_SENSE
[ 1345.172258] sd 6:0:0:0: [sdb] tag#0 Sense Key : Hardware Error [current] [descriptor]
[ 1345.172261] sd 6:0:0:0: [sdb] tag#0 Add. Sense: No additional sense information
[ 1345.172266] sd 6:0:0:0: [sdb] tag#0 CDB: ATA command pass through(12)/Blank a1 06 20 da 00 00 4f c2 00 b0 00 00

These messages can be quite annoying, because programs like udisks2
provoke them every 10 minutes or so.  Other programs can also have
this effect, such as those in smartmontools.

I don't fully understand how that commit induced the SCSI core to log
these error messages, but the underlying cause for them is code added
to usb-storage by commit f1a0743bc0e7 ("USB: storage: When a device
returns no sense data, call it a Hardware Error").  At the time it was
necessary to do this, in order to prevent an infinite retry loop with
some not-so-great mass storage devices.

However, the ATA pass-thru protocol uses SCSI sense data to return
command status values, and some devices always report Check Condition
status for ATA pass-thru commands to ensure that the host retrieves
the sense data, even if the command succeeded.  This violates the USB
mass-storage protocol (Check Condition status is supposed to mean the
command failed), but we can't help that.

This patch attempts to mitigate the problem of these bogus error
reports by changing usb-storage.  The HARDWARE ERROR sense key will be
inserted only for commands that aren't ATA pass-thru.

Thanks to Ewan Milne for pointing out that this mechanism was present
in usb-storage.  8 years after writing it, I had completely forgotten
its existence.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Tested-by: Kris Lindgren <kris.lindgren@gmail.com>
Ref: https://bugzilla.redhat.com/show_bug.cgi?id=1351305
CC: Ewan D. Milne <emilne@redhat.com>
CC: <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/storage/transport.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
index 02f86dd1a340..90a7bffe3484 100644
--- a/drivers/usb/storage/transport.c
+++ b/drivers/usb/storage/transport.c
@@ -808,12 +808,24 @@ Retry_Sense:
 			if (result == USB_STOR_TRANSPORT_GOOD) {
 				srb->result = SAM_STAT_GOOD;
 				srb->sense_buffer[0] = 0x0;
+			}
+
+			/*
+			 * ATA-passthru commands use sense data to report
+			 * the command completion status, and often devices
+			 * return Check Condition status when nothing is
+			 * wrong.
+			 */
+			else if (srb->cmnd[0] == ATA_16 ||
+					srb->cmnd[0] == ATA_12) {
+				/* leave the data alone */
+			}
 
 			/* If there was a problem, report an unspecified
 			 * hardware error to prevent the higher layers from
 			 * entering an infinite retry loop.
 			 */
-			} else {
+			else {
 				srb->result = DID_ERROR << 16;
 				if ((sshdr.response_code & 0x72) == 0x72)
 					srb->sense_buffer[1] = HARDWARE_ERROR;
-- 
2.17.1



