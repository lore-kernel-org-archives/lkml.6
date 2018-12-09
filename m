Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DCAC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D61520855
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D61520855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbeLIWAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:00:08 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36058 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726437AbeLIVzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:35 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72x-0002ie-JN; Sun, 09 Dec 2018 21:55:31 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72i-0003ae-MX; Sun, 09 Dec 2018 21:55:16 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        "Mathias Nyman" <mathias.nyman@intel.com>,
        "Matthew Giassa" <matthew@giassa.net>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.154883928@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 253/328] USB: leave LPM alone if possible when
 binding/unbinding interface drivers
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

commit 6fb650d43da3e7054984dc548eaa88765a94d49f upstream.

When a USB driver is bound to an interface (either through probing or
by claiming it) or is unbound from an interface, the USB core always
disables Link Power Management during the transition and then
re-enables it afterward.  The reason is because the driver might want
to prevent hub-initiated link power transitions, in which case the HCD
would have to recalculate the various LPM parameters.  This
recalculation takes place when LPM is re-enabled and the new
parameters are sent to the device and its parent hub.

However, if the driver does not want to prevent hub-initiated link
power transitions then none of this work is necessary.  The parameters
don't need to be recalculated, and LPM doesn't need to be disabled and
re-enabled.

It turns out that disabling and enabling LPM can be time-consuming,
enough so that it interferes with user programs that want to claim and
release interfaces rapidly via usbfs.  Since the usbfs kernel driver
doesn't set the disable_hub_initiated_lpm flag, we can speed things up
and get the user programs to work by leaving LPM alone whenever the
flag isn't set.

And while we're improving the way disable_hub_initiated_lpm gets used,
let's also fix its kerneldoc.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Tested-by: Matthew Giassa <matthew@giassa.net>
CC: Mathias Nyman <mathias.nyman@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/core/driver.c | 40 ++++++++++++++++++++++-----------------
 include/linux/usb.h       |  2 +-
 2 files changed, 24 insertions(+), 18 deletions(-)

--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -298,7 +298,7 @@ static int usb_probe_interface(struct de
 	struct usb_device *udev = interface_to_usbdev(intf);
 	const struct usb_device_id *id;
 	int error = -ENODEV;
-	int lpm_disable_error;
+	int lpm_disable_error = -ENODEV;
 
 	dev_dbg(dev, "%s\n", __func__);
 
@@ -346,12 +346,14 @@ static int usb_probe_interface(struct de
 	 * setting during probe, that should also be fine.  usb_set_interface()
 	 * will attempt to disable LPM, and fail if it can't disable it.
 	 */
-	lpm_disable_error = usb_unlocked_disable_lpm(udev);
-	if (lpm_disable_error && driver->disable_hub_initiated_lpm) {
-		dev_err(&intf->dev, "%s Failed to disable LPM for driver %s\n.",
-				__func__, driver->name);
-		error = lpm_disable_error;
-		goto err;
+	if (driver->disable_hub_initiated_lpm) {
+		lpm_disable_error = usb_unlocked_disable_lpm(udev);
+		if (lpm_disable_error) {
+			dev_err(&intf->dev, "%s Failed to disable LPM for driver %s\n.",
+					__func__, driver->name);
+			error = lpm_disable_error;
+			goto err;
+		}
 	}
 
 	/* Carry out a deferred switch to altsetting 0 */
@@ -402,7 +404,8 @@ static int usb_unbind_interface(struct d
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct usb_host_endpoint *ep, **eps = NULL;
 	struct usb_device *udev;
-	int i, j, error, r, lpm_disable_error;
+	int i, j, error, r;
+	int lpm_disable_error = -ENODEV;
 
 	intf->condition = USB_INTERFACE_UNBINDING;
 
@@ -410,12 +413,13 @@ static int usb_unbind_interface(struct d
 	udev = interface_to_usbdev(intf);
 	error = usb_autoresume_device(udev);
 
-	/* Hub-initiated LPM policy may change, so attempt to disable LPM until
+	/* If hub-initiated LPM policy may change, attempt to disable LPM until
 	 * the driver is unbound.  If LPM isn't disabled, that's fine because it
 	 * wouldn't be enabled unless all the bound interfaces supported
 	 * hub-initiated LPM.
 	 */
-	lpm_disable_error = usb_unlocked_disable_lpm(udev);
+	if (driver->disable_hub_initiated_lpm)
+		lpm_disable_error = usb_unlocked_disable_lpm(udev);
 
 	/* Terminate all URBs for this interface unless the driver
 	 * supports "soft" unbinding.
@@ -518,7 +522,7 @@ int usb_driver_claim_interface(struct us
 	struct device *dev;
 	struct usb_device *udev;
 	int retval = 0;
-	int lpm_disable_error;
+	int lpm_disable_error = -ENODEV;
 
 	if (!iface)
 		return -ENODEV;
@@ -535,12 +539,14 @@ int usb_driver_claim_interface(struct us
 
 	iface->condition = USB_INTERFACE_BOUND;
 
-	/* Disable LPM until this driver is bound. */
-	lpm_disable_error = usb_unlocked_disable_lpm(udev);
-	if (lpm_disable_error && driver->disable_hub_initiated_lpm) {
-		dev_err(&iface->dev, "%s Failed to disable LPM for driver %s\n.",
-				__func__, driver->name);
-		return -ENOMEM;
+	/* See the comment about disabling LPM in usb_probe_interface(). */
+	if (driver->disable_hub_initiated_lpm) {
+		lpm_disable_error = usb_unlocked_disable_lpm(udev);
+		if (lpm_disable_error) {
+			dev_err(&iface->dev, "%s Failed to disable LPM for driver %s\n.",
+					__func__, driver->name);
+			return -ENOMEM;
+		}
 	}
 
 	/* Claimed interfaces are initially inactive (suspended) and
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1065,7 +1065,7 @@ struct usbdrv_wrap {
  *	for interfaces bound to this driver.
  * @soft_unbind: if set to 1, the USB core will not kill URBs and disable
  *	endpoints before calling the driver's disconnect method.
- * @disable_hub_initiated_lpm: if set to 0, the USB core will not allow hubs
+ * @disable_hub_initiated_lpm: if set to 1, the USB core will not allow hubs
  *	to initiate lower power link state transitions when an idle timeout
  *	occurs.  Device-initiated USB 3.0 link PM will still be allowed.
  *

