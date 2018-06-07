Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id GeiqA79FGVu8JAAAmS7hNA
	; Thu, 07 Jun 2018 14:48:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EF076608BF; Thu,  7 Jun 2018 14:48:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 61B136074D;
	Thu,  7 Jun 2018 14:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 61B136074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935082AbeFGOs3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:48:29 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40837 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934474AbeFGOsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:48:25 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbo-0005Zo-QM; Thu, 07 Jun 2018 15:09:48 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb2-0002sB-Qd; Thu, 07 Jun 2018 15:09:00 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Hans de Goede" <hdegoede@redhat.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.662392556@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 135/410] uas: Log error codes when logging errors
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit ce39fe6fa115d9fea0112c907773a400b98d2463 upstream.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/storage/uas.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -928,7 +928,8 @@ static int uas_eh_bus_reset_handler(stru
 	usb_unlock_device(udev);
 
 	if (err) {
-		shost_printk(KERN_INFO, sdev->host, "%s FAILED\n", __func__);
+		shost_printk(KERN_INFO, sdev->host, "%s FAILED err %d\n",
+			     __func__, err);
 		return FAILED;
 	}
 
@@ -1188,13 +1189,16 @@ static int uas_post_reset(struct usb_int
 	struct Scsi_Host *shost = usb_get_intfdata(intf);
 	struct uas_dev_info *devinfo = (struct uas_dev_info *)shost->hostdata;
 	unsigned long flags;
+	int err;
 
 	if (devinfo->shutdown)
 		return 0;
 
-	if (uas_configure_endpoints(devinfo) != 0) {
+	err = uas_configure_endpoints(devinfo);
+	if (err) {
 		shost_printk(KERN_ERR, shost,
-			     "%s: alloc streams error after reset", __func__);
+			     "%s: alloc streams error %d after reset",
+			     __func__, err);
 		return 1;
 	}
 
@@ -1232,10 +1236,13 @@ static int uas_reset_resume(struct usb_i
 	struct Scsi_Host *shost = usb_get_intfdata(intf);
 	struct uas_dev_info *devinfo = (struct uas_dev_info *)shost->hostdata;
 	unsigned long flags;
+	int err;
 
-	if (uas_configure_endpoints(devinfo) != 0) {
+	err = uas_configure_endpoints(devinfo);
+	if (err) {
 		shost_printk(KERN_ERR, shost,
-			     "%s: alloc streams error after reset", __func__);
+			     "%s: alloc streams error %d after reset",
+			     __func__, err);
 		return -EIO;
 	}
 
