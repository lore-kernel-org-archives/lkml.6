Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9107CC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E5921904
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbfBCOaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:30:03 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55372 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729872AbfBCOUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:21 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqId9-0006IS-Pk; Sun, 03 Feb 2019 14:20:19 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9q-0007Nw-Mx; Sun, 03 Feb 2019 14:50:02 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Harry Pan" <harry.pan@intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.13786680@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 263/305] usb: quirk: add no-LPM quirk on SanDisk
 Ultra Flair device
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Harry Pan <harry.pan@intel.com>

commit 2f2dde6ba89b1ef1fe23c1138131b315d9aa4019 upstream.

Some lower volume SanDisk Ultra Flair in 16GB, which the VID:PID is
in 0781:5591, will aggressively request LPM of U1/U2 during runtime,
when using this thumb drive as the OS installation key we found the
device will generate failure during U1 exit path making it dropped
from the USB bus, this causes a corrupted installation in system at
the end.

i.e.,
[  166.918296] hub 2-0:1.0: state 7 ports 7 chg 0000 evt 0004
[  166.918327] usb usb2-port2: link state change
[  166.918337] usb usb2-port2: do warm reset
[  166.970039] usb usb2-port2: not warm reset yet, waiting 50ms
[  167.022040] usb usb2-port2: not warm reset yet, waiting 200ms
[  167.276043] usb usb2-port2: status 02c0, change 0041, 5.0 Gb/s
[  167.276050] usb 2-2: USB disconnect, device number 2
[  167.276058] usb 2-2: unregistering device
[  167.276060] usb 2-2: unregistering interface 2-2:1.0
[  167.276170] xhci_hcd 0000:00:15.0: shutdown urb ffffa3c7cc695cc0 ep1in-bulk
[  167.284055] sd 0:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
[  167.284064] sd 0:0:0:0: [sda] tag#0 CDB: Read(10) 28 00 00 33 04 90 00 01 00 00
...

Analyzed the USB trace in the link layer we realized it is because
of the 6-ms timer of tRecoveryConfigurationTimeout which documented
on the USB 3.2 Revision 1.0, the section 7.5.10.4.2 of "Exit from
Recovery.Configuration"; device initiates U1 exit -> Recovery.Active
-> Recovery.Configuration, then the host timer timeout makes the link
transits to eSS.Inactive -> Rx.Detect follows by a Warm Reset.

Interestingly, the other higher volume of SanDisk Ultra Flair sharing
the same VID:PID, such as 64GB, would not request LPM during runtime,
it sticks at U0 always, thus disabling LPM does not affect those thumb
drives at all.

The same odd occures in SanDisk Ultra Fit 16GB, VID:PID in 0781:5583.

Signed-off-by: Harry Pan <harry.pan@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/core/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -185,6 +185,10 @@ static const struct usb_device_id usb_qu
 	/* Midiman M-Audio Keystation 88es */
 	{ USB_DEVICE(0x0763, 0x0192), .driver_info = USB_QUIRK_RESET_RESUME },
 
+	/* SanDisk Ultra Fit and Ultra Flair */
+	{ USB_DEVICE(0x0781, 0x5583), .driver_info = USB_QUIRK_NO_LPM },
+	{ USB_DEVICE(0x0781, 0x5591), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* M-Systems Flash Disk Pioneers */
 	{ USB_DEVICE(0x08ec, 0x1000), .driver_info = USB_QUIRK_RESET_RESUME },
 

