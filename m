Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57572C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8FC2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDoTzNOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8FC2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbeJKXGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:06:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbeJKXGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:06:10 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7DF9213A2;
        Thu, 11 Oct 2018 15:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272307;
        bh=2HxU2clY8H6LpENKERPoTjwFvZ834lt2xRwgBnp47Jc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nDoTzNOv5RqbG6ukruC01KTApmYhsCR5vyp8ld5rrnTD2BHpSO5lAemL7faqC5saO
         olYOofLrqWEHRd2OQ8h0KC6U8bIZipwZU59YiIVlHOalo7YPSAvt4Cj9w7j7U1+Bcj
         XqIDrluCc7gQQ2N+wng+Icvi09p84oDNVrPg6WNA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 3.18 060/120] USB: remove LPM management from usb_driver_claim_interface()
Date:   Thu, 11 Oct 2018 17:34:01 +0200
Message-Id: <20181011152552.244459063@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -506,7 +506,6 @@ int usb_driver_claim_interface(struct us
 	struct device *dev;
 	struct usb_device *udev;
 	int retval = 0;
-	int lpm_disable_error = -ENODEV;
 
 	if (!iface)
 		return -ENODEV;
@@ -523,16 +522,6 @@ int usb_driver_claim_interface(struct us
 
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
@@ -551,10 +540,6 @@ int usb_driver_claim_interface(struct us
 	if (device_is_registered(dev))
 		retval = device_bind_driver(dev);
 
-	/* Attempt to re-enable USB3 LPM, if the disable was successful. */
-	if (!lpm_disable_error)
-		usb_unlocked_enable_lpm(udev);
-
 	if (retval) {
 		dev->driver = NULL;
 		usb_set_intfdata(iface, NULL);


