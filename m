Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D99CC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1948620672
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1948620672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeLIWBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:01:00 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35982 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726692AbeLIVze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:34 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72x-0002if-Ik; Sun, 09 Dec 2018 21:55:31 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72i-0003aj-O7; Sun, 09 Dec 2018 21:55:16 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Alan Stern" <stern@rowland.harvard.edu>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.389376705@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 254/328] USB: remove LPM management from
 usb_driver_claim_interface()
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Stern <stern@rowland.harvard.edu>

commit c183813fcee44a249339b7c46e1ad271ca1870aa upstream.

usb_driver_claim_interface() disables and re-enables Link Power
Management, but it shouldn't do either one, for the reasons listed
below.  This patch removes the two LPM-related function calls from the
routine.

The reason for disabling LPM in the analogous function
usb_probe_interface() is so that drivers won't have to deal with
unwanted LPM transitions in their probe routine.  But
usb_driver_claim_interface() doesn't call the driver's probe routine
(or any other callbacks), so that reason doesn't apply here.

Furthermore, no driver other than usbfs will ever call
usb_driver_claim_interface() unless it is already bound to another
interface in the same device, which means disabling LPM here would be
redundant.  usbfs doesn't interact with LPM at all.

Lastly, the error return from usb_unlocked_disable_lpm() isn't handled
properly; the code doesn't clean up its earlier actions before
returning.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Fixes: 8306095fd2c1 ("USB: Disable USB 3.0 LPM in critical sections.")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/core/driver.c | 15 ---------------
 1 file changed, 15 deletions(-)

--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -522,7 +522,6 @@ int usb_driver_claim_interface(struct us
 	struct device *dev;
 	struct usb_device *udev;
 	int retval = 0;
-	int lpm_disable_error = -ENODEV;
 
 	if (!iface)
 		return -ENODEV;
@@ -539,16 +538,6 @@ int usb_driver_claim_interface(struct us
 
 	iface->condition = USB_INTERFACE_BOUND;
 
-	/* See the comment about disabling LPM in usb_probe_interface(). */
-	if (driver->disable_hub_initiated_lpm) {
-		lpm_disable_error = usb_unlocked_disable_lpm(udev);
-		if (lpm_disable_error) {
-			dev_err(&iface->dev, "%s Failed to disable LPM for driver %s\n.",
-					__func__, driver->name);
-			return -ENOMEM;
-		}
-	}
-
 	/* Claimed interfaces are initially inactive (suspended) and
 	 * runtime-PM-enabled, but only if the driver has autosuspend
 	 * support.  Otherwise they are marked active, to prevent the
@@ -567,10 +556,6 @@ int usb_driver_claim_interface(struct us
 	if (device_is_registered(dev))
 		retval = device_bind_driver(dev);
 
-	/* Attempt to re-enable USB3 LPM, if the disable was successful. */
-	if (!lpm_disable_error)
-		usb_unlocked_enable_lpm(udev);
-
 	return retval;
 }
 EXPORT_SYMBOL_GPL(usb_driver_claim_interface);

