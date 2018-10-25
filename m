Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13B3C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DFF2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2DH1hiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DFF2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbeJYWu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:50:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729833AbeJYWu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:50:57 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A227320834;
        Thu, 25 Oct 2018 14:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477080;
        bh=jE9kzEEH3FboVy2PDI6AOzLt41Rsa+gPzLUe490b3Oc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W2DH1hiD7KEqhK+GuIDzdRaFSGEq0y8YU0aSDWsYRo31WnYLIvi3tv3EABgV/lbXL
         3KbHGceJzyOESu4xUJ95EH8JmZG+ptlXru43p+sAMXxRRhoWGUK5mp/c0Apfas5XWZ
         NHOrlHYwjHnFzeIpeSOBcGnQs5AR8SGu9MhiNEJs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 32/65] usb-storage: fix bogus hardware error messages for ATA pass-thru devices
Date:   Thu, 25 Oct 2018 10:16:32 -0400
Message-Id: <20181025141705.213937-32-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

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
@@ -808,12 +808,24 @@ void usb_stor_invoke_transport(struct scsi_cmnd *srb, struct us_data *us)
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

