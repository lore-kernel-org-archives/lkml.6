Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B0AECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0A32083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0A32083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388256AbeIXShc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:37:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58532 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbeIXShc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:37:32 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AD9061092;
        Mon, 24 Sep 2018 12:35:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tim Anderson <tsa@biglakesoftware.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 4.18 121/235] USB: Add quirk to support DJI CineSSD
Date:   Mon, 24 Sep 2018 13:51:47 +0200
Message-Id: <20180924113118.223401340@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tim Anderson <tsa@biglakesoftware.com>

commit f45681f9becaa65111ed0a691ccf080a0cd5feb8 upstream.

This device does not correctly handle the LPM operations.

Also, the device cannot handle ATA pass-through commands
and locks up when attempted while running in super speed.

This patch adds the equivalent quirk logic as found in uas.

Signed-off-by: Tim Anderson <tsa@biglakesoftware.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/quirks.c          |    3 +++
 drivers/usb/storage/scsiglue.c     |    9 +++++++++
 drivers/usb/storage/unusual_devs.h |    7 +++++++
 3 files changed, 19 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -406,6 +406,9 @@ static const struct usb_device_id usb_qu
 	{ USB_DEVICE(0x2040, 0x7200), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },
 
+	/* DJI CineSSD */
+	{ USB_DEVICE(0x2ca3, 0x0031), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* INTEL VALUE SSD */
 	{ USB_DEVICE(0x8086, 0xf1a5), .driver_info = USB_QUIRK_RESET_RESUME },
 
--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -376,6 +376,15 @@ static int queuecommand_lck(struct scsi_
 		return 0;
 	}
 
+	if ((us->fflags & US_FL_NO_ATA_1X) &&
+			(srb->cmnd[0] == ATA_12 || srb->cmnd[0] == ATA_16)) {
+		memcpy(srb->sense_buffer, usb_stor_sense_invalidCDB,
+		       sizeof(usb_stor_sense_invalidCDB));
+		srb->result = SAM_STAT_CHECK_CONDITION;
+		done(srb);
+		return 0;
+	}
+
 	/* enqueue the command and wake up the control thread */
 	srb->scsi_done = done;
 	us->srb = srb;
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -2288,6 +2288,13 @@ UNUSUAL_DEV(  0x2735, 0x100b, 0x0000, 0x
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_GO_SLOW ),
 
+/* Reported-by: Tim Anderson <tsa@biglakesoftware.com> */
+UNUSUAL_DEV(  0x2ca3, 0x0031, 0x0000, 0x9999,
+		"DJI",
+		"CineSSD",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_NO_ATA_1X),
+
 /*
  * Reported by Frederic Marchal <frederic.marchal@wowcompany.com>
  * Mio Moov 330


