Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1DEC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2833D20656
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfACD0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 22:26:51 -0500
Received: from hermes.aosc.io ([199.195.250.187]:54770 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfACD0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 22:26:50 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id A044615E6BB;
        Thu,  3 Jan 2019 03:26:46 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Cc:     Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 1/2] USB: storage: don't insert sane sense for SPC3+ when bad sense specified
Date:   Thu,  3 Jan 2019 11:26:17 +0800
Message-Id: <20190103032618.9237-2-icenowy@aosc.io>
In-Reply-To: <20190103032618.9237-1-icenowy@aosc.io>
References: <20190103032618.9237-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the code will set US_FL_SANE_SENSE flag unconditionally if
device claims SPC3+, however we should allow US_FL_BAD_SENSE flag to
prevent this behavior, because SMI SM3350 UFS-USB bridge controller,
which claims SPC4, will show strange behavior with 96-byte sense
(put the chip into a wrong state that cannot read/write anything).

Check the presence of US_FL_BAD_SENSE when assuming US_FL_SANE_SENSE on
SPC4+ devices.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v2:
- Changed the comment to note the check.

 drivers/usb/storage/scsiglue.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
index fde2e71a6ade..a73ea495d5a7 100644
--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -235,8 +235,12 @@ static int slave_configure(struct scsi_device *sdev)
 		if (!(us->fflags & US_FL_NEEDS_CAP16))
 			sdev->try_rc_10_first = 1;
 
-		/* assume SPC3 or latter devices support sense size > 18 */
-		if (sdev->scsi_level > SCSI_SPC_2)
+		/*
+		 * assume SPC3 or latter devices support sense size > 18
+		 * unless US_FL_BAD_SENSE quirk is specified.
+		 */
+		if (sdev->scsi_level > SCSI_SPC_2 &&
+		    !(us->fflags & US_FL_BAD_SENSE))
 			us->fflags |= US_FL_SANE_SENSE;
 
 		/*
-- 
2.18.1

