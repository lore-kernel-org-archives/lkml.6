Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8EAC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C66A2064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C66A2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387409AbeJBUUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:20:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36400 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731724AbeJBUUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:20:07 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 94DFE9D9;
        Tue,  2 Oct 2018 13:36:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 4.9 71/94] USB: remove LPM management from usb_driver_claim_interface()
Date:   Tue,  2 Oct 2018 06:25:25 -0700
Message-Id: <20181002132505.419347885@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132500.494838053@linuxfoundation.org>
References: <20181002132500.494838053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
CC: <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/driver.c |   15 ---------------
 1 file changed, 15 deletions(-)

--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -509,7 +509,6 @@ int usb_driver_claim_interface(struct us
 	struct device *dev;
 	struct usb_device *udev;
 	int retval = 0;
-	int lpm_disable_error = -ENODEV;
 
 	if (!iface)
 		return -ENODEV;
@@ -530,16 +529,6 @@ int usb_driver_claim_interface(struct us
 
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
@@ -558,10 +547,6 @@ int usb_driver_claim_interface(struct us
 	if (device_is_registered(dev))
 		retval = device_bind_driver(dev);
 
-	/* Attempt to re-enable USB3 LPM, if the disable was successful. */
-	if (!lpm_disable_error)
-		usb_unlocked_enable_lpm(udev);
-
 	if (retval) {
 		dev->driver = NULL;
 		usb_set_intfdata(iface, NULL);


