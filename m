Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A36EC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5323A2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543534;
	bh=FBT+qMkQezgb9uQXorza2zntSdd4DiFI+jXZkbiDlKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=laj6/jxFAjSMufwy8IrZits6vlbpb+g6mr6lojeTRkYkXt/UZI6JiozifjWvqy+nx
	 GsmpyMMA/AELV1ie4WrrNSBbkz9KOm14w1pBO7O5pSY4qv3SK5Gobgg0eGVpgUdWFv
	 VIY4zmm+8jL8GmG/JMtF+Myn6DFLW3rR29H7HAIk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5323A2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbeLKPwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:52:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729650AbeLKPwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:52:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A40732146D;
        Tue, 11 Dec 2018 15:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543528;
        bh=FBT+qMkQezgb9uQXorza2zntSdd4DiFI+jXZkbiDlKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zkcLBB8JQCG1R4T8mMbih5Ocajba6GSQZRvawIH1XOf9Z5q6xRdpw305eNGBQfMlY
         BeXjeHV8OfRaoKE0gb6lw3Kw8L3lkjxITYc7vZEmcZQYGX/l0Drs45e+BXFOh7rvXF
         T5kbsshvJ3ABzPFaGI8r0Fj8zmY05HrFEfp6j3G8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harry Pan <harry.pan@intel.com>
Subject: [PATCH 4.14 31/67] usb: quirk: add no-LPM quirk on SanDisk Ultra Flair device
Date:   Tue, 11 Dec 2018 16:41:31 +0100
Message-Id: <20181211151631.947956824@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/quirks.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -188,6 +188,10 @@ static const struct usb_device_id usb_qu
 	/* Midiman M-Audio Keystation 88es */
 	{ USB_DEVICE(0x0763, 0x0192), .driver_info = USB_QUIRK_RESET_RESUME },
 
+	/* SanDisk Ultra Fit and Ultra Flair */
+	{ USB_DEVICE(0x0781, 0x5583), .driver_info = USB_QUIRK_NO_LPM },
+	{ USB_DEVICE(0x0781, 0x5591), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* M-Systems Flash Disk Pioneers */
 	{ USB_DEVICE(0x08ec, 0x1000), .driver_info = USB_QUIRK_RESET_RESUME },
 


