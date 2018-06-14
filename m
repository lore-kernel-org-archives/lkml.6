Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 74E04C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3A1208DE
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFVGhZPe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3A1208DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965929AbeFNOLy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:11:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965912AbeFNOLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:11:52 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05762208DB;
        Thu, 14 Jun 2018 14:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985511;
        bh=LYw4C3RMwGz8VJVPLuQeVqxplYisEkP5Gm3qevoVoXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OFVGhZPeEt2+IIYGHLFtBU8ZtxFQNBZyZZkcHLVXwJGVX1eN9X1OdHp8PpT9YqBYj
         CondtBNkMFiGv8REcwr5Ox2bcbzLVqPilBxO/39pXyEwwD4HmSAAtE8qZlRDguRlaI
         J8HyA3zU6FacDkUx4C4UODLHJZxH77G2+n5RXQww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Kappner <agk@godking.net>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 4.9 17/30] usb-storage: Add compatibility quirk flags for G-Technologies G-Drive
Date:   Thu, 14 Jun 2018 16:04:58 +0200
Message-Id: <20180614132600.975865587@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132600.255515394@linuxfoundation.org>
References: <20180614132600.255515394@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Kappner <agk@godking.net>

commit ca7d9515d0e6825351ce106066cea1f60e40b1c8 upstream.

The "G-Drive" (sold by G-Technology) external USB 3.0 drive
 hangs on write access under UAS and usb-storage:

[  136.079121] sd 15:0:0:0: [sdi] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[  136.079144] sd 15:0:0:0: [sdi] tag#0 Sense Key : Illegal Request [current]
[  136.079152] sd 15:0:0:0: [sdi] tag#0 Add. Sense: Invalid field in cdb
[  136.079176] sd 15:0:0:0: [sdi] tag#0 CDB: Write(16) 8a 08 00 00 00 00 00 00 00 00 00 00 00 08 00 00
[  136.079180] print_req_error: critical target error, dev sdi, sector 0
[  136.079183] Buffer I/O error on dev sdi, logical block 0, lost sync page write
[  136.173148] EXT4-fs (sdi): mounted filesystem with ordered data mode. Opts: (null)
[  140.583998] sd 15:0:0:0: [sdi] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[  140.584010] sd 15:0:0:0: [sdi] tag#0 Sense Key : Illegal Request [current]
[  140.584016] sd 15:0:0:0: [sdi] tag#0 Add. Sense: Invalid field in cdb
[  140.584022] sd 15:0:0:0: [sdi] tag#0 CDB: Write(16) 8a 08 00 00 00 00 e8 c4 00 18 00 00 00 08 00 00
[  140.584025] print_req_error: critical target error, dev sdi, sector 3905159192
[  140.584044] print_req_error: critical target error, dev sdi, sector 3905159192
[  140.584052] Aborting journal on device sdi-8.

The proposed patch adds compatibility quirks. Because the drive requires two
quirks (one to work with UAS, and another to work with usb-storage), adding this
under unusual_devs.h and not just unusual_uas.h so kernels compiled without UAS
receive the quirk. With the patch, the drive works reliably on UAS and usb-
storage.
(tested on NEC Corporation uPD720200 USB 3.0 host controller).

Signed-off-by: Alexander Kappner <agk@godking.net>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/storage/unusual_devs.h |    9 +++++++++
 drivers/usb/storage/unusual_uas.h  |    9 +++++++++
 2 files changed, 18 insertions(+)

--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -2340,6 +2340,15 @@ UNUSUAL_DEV(  0x4146, 0xba01, 0x0100, 0x
 		"Micro Mini 1GB",
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL, US_FL_NOT_LOCKABLE ),
 
+/* "G-DRIVE" external HDD hangs on write without these.
+ * Patch submitted by Alexander Kappner <agk@godking.net>
+ */
+UNUSUAL_DEV(0x4971, 0x8024, 0x0000, 0x9999,
+		"SimpleTech",
+		"External HDD",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_ALWAYS_SYNC),
+
 /*
  * Nick Bowler <nbowler@elliptictech.com>
  * SCSI stack spams (otherwise harmless) error messages.
--- a/drivers/usb/storage/unusual_uas.h
+++ b/drivers/usb/storage/unusual_uas.h
@@ -183,3 +183,12 @@ UNUSUAL_DEV(0x4971, 0x8017, 0x0000, 0x99
 		"External HDD",
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_NO_REPORT_OPCODES),
+
+/* "G-DRIVE" external HDD hangs on write without these.
+ * Patch submitted by Alexander Kappner <agk@godking.net>
+ */
+UNUSUAL_DEV(0x4971, 0x8024, 0x0000, 0x9999,
+		"SimpleTech",
+		"External HDD",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_ALWAYS_SYNC),


