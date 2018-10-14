Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876F8C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A8E20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A8E20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbeJNX1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:27:13 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37172 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728141AbeJNX1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:27:12 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLx-0004cp-EI; Sun, 14 Oct 2018 16:30:49 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLU-0000Ot-Ik; Sun, 14 Oct 2018 16:30:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jan Hoeppner" <hoeppner@linux.ibm.com>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        "Stefan Haberland" <sth@linux.vnet.ibm.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.908692646@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 192/366] s390/dasd: fix IO error for newly defined
 devices
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Haberland <sth@linux.vnet.ibm.com>

commit 5d27a2bf6e14f5c7d1033ad1e993fcd0eba43e83 upstream.

When a new CKD storage volume is defined at the storage server, Linux
may be relying on outdated information about that volume, which leads to
the following errors:

1. Command Reject Errors for minidisk on z/VM:

dasd-eckd.b3193d: 0.0.XXXX: An error occurred in the DASD device driver,
		  reason=09
dasd(eckd): I/O status report for device 0.0.XXXX:
dasd(eckd): in req: 00000000XXXXXXXX CC:00 FC:04 AC:00 SC:17 DS:02 CS:00
	    RC:0
dasd(eckd): device 0.0.2046: Failing CCW: 00000000XXXXXXXX
dasd(eckd): Sense(hex)  0- 7: 80 00 00 00 00 00 00 00
dasd(eckd): Sense(hex)  8-15: 00 00 00 00 00 00 00 00
dasd(eckd): Sense(hex) 16-23: 00 00 00 00 e1 00 0f 00
dasd(eckd): Sense(hex) 24-31: 00 00 40 e2 00 00 00 00
dasd(eckd): 24 Byte: 0 MSG 0, no MSGb to SYSOP

2. Equipment Check errors on LPAR or for dedicated devices on z/VM:

dasd(eckd): I/O status report for device 0.0.XXXX:
dasd(eckd): in req: 00000000XXXXXXXX CC:00 FC:04 AC:00 SC:17 DS:0E CS:40
	    fcxs:01 schxs:00 RC:0
dasd(eckd): device 0.0.9713: Failing TCW: 00000000XXXXXXXX
dasd(eckd): Sense(hex)  0- 7: 10 00 00 00 13 58 4d 0f
dasd(eckd): Sense(hex)  8-15: 67 00 00 00 00 00 00 04
dasd(eckd): Sense(hex) 16-23: e5 18 05 33 97 01 0f 0f
dasd(eckd): Sense(hex) 24-31: 00 00 40 e2 00 04 58 0d
dasd(eckd): 24 Byte: 0 MSG f, no MSGb to SYSOP

Fix this problem by using the up-to-date information provided during
online processing via the device specific SNEQ to detect the case of
outdated LCU data. If there is a difference, perform a re-read of that
data.

Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
[bwh: Backported to 3.16:
 - Move up assignment of "private"
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/s390/block/dasd_alias.c
+++ b/drivers/s390/block/dasd_alias.c
@@ -608,18 +608,26 @@ static int _schedule_lcu_update(struct a
 
 int dasd_alias_add_device(struct dasd_device *device)
 {
-	struct dasd_eckd_private *private;
-	struct alias_lcu *lcu;
+	struct dasd_eckd_private *private = device->private;
+	__u8 uaddr = private->uid.real_unit_addr;
+	struct alias_lcu *lcu = private->lcu;
 	unsigned long flags;
 	int rc;
 
-	private = (struct dasd_eckd_private *) device->private;
-	lcu = private->lcu;
 	rc = 0;
 
 	/* need to take cdev lock before lcu lock */
 	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
 	spin_lock(&lcu->lock);
+	/*
+	 * Check if device and lcu type differ. If so, the uac data may be
+	 * outdated and needs to be updated.
+	 */
+	if (private->uid.type !=  lcu->uac->unit[uaddr].ua_type) {
+		lcu->flags |= UPDATE_PENDING;
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
+			      "uid type mismatch - trigger rescan");
+	}
 	if (!(lcu->flags & UPDATE_PENDING)) {
 		rc = _add_device_to_lcu(lcu, device, device);
 		if (rc)

