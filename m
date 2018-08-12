Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19F9C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 18:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B604E2199B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 18:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B604E2199B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbeHLVN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 17:13:57 -0400
Received: from smtprelay0119.hostedemail.com ([216.40.44.119]:46931 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727550AbeHLVN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 17:13:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 986F518028E9F;
        Sun, 12 Aug 2018 18:35:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: size83_831fd4dc17922
X-Filterd-Recvd-Size: 4678
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sun, 12 Aug 2018 18:35:00 +0000 (UTC)
Message-ID: <10f9f13a5421299a6efda1e1f84ab304ef18ddec.camel@perches.com>
Subject: Re: [PATCH] USB: core: devio: fixed a trailing statement code style
 issue
From:   Joe Perches <joe@perches.com>
To:     Tom Todd <thomas.m.a.todd@gmail.com>, gregkh@linuxfoundation.org
Cc:     stern@rowland.harvard.edu, dan.carpenter@oracle.com,
        arvind.yadav.cs@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 12 Aug 2018 11:34:59 -0700
In-Reply-To: <20180812180656.26079-1-thomas.m.a.todd@gmail.com>
References: <20180812180656.26079-1-thomas.m.a.todd@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-08-12 at 19:06 +0100, Tom Todd wrote:
> Fixed a code styling issue

while it's OK to fix style only issues, it's much better
to reorganize the code for reader clarity.

For this code, something like:

o use memdup_user
o use an exit label to free allocated memory
o invert tests to return on unexpected results
o move logical continuations to EOL
o don't use successive code like:
  	if (foo)
  		return -ERRNO;
  	else if (bar)
  		return -ERRNO;
  	else
  		baz;
  simpler and less indentation is:
  	if (foo)
		return -ERRNO;
	if (bar)
		return -ERRNO;
	baz;

---
 drivers/usb/core/devio.c | 68 ++++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 6ce77b33da61..74ae4e052357 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -2118,68 +2118,74 @@ static int proc_ioctl(struct usb_dev_state *ps, struct usbdevfs_ioctl *ctl)
 	/* alloc buffer */
 	size = _IOC_SIZE(ctl->ioctl_code);
 	if (size > 0) {
-		buf = kmalloc(size, GFP_KERNEL);
-		if (buf == NULL)
-			return -ENOMEM;
-		if ((_IOC_DIR(ctl->ioctl_code) & _IOC_WRITE)) {
-			if (copy_from_user(buf, ctl->data, size)) {
-				kfree(buf);
+		if (_IOC_DIR(ctl->ioctl_code) & _IOC_WRITE) {
+			buf = memdup_user(ctl->data, size);
+			if (!buf)
 				return -EFAULT;
-			}
 		} else {
-			memset(buf, 0, size);
+			buf = kzalloc(size, GFP_KERNEL);
+			if (!buf)
+				return -ENOMEM;
 		}
 	}
 
 	if (!connected(ps)) {
-		kfree(buf);
-		return -ENODEV;
+		retval = -ENODEV;
+		goto exit;
 	}
-
-	if (ps->dev->state != USB_STATE_CONFIGURED)
+	if (ps->dev->state != USB_STATE_CONFIGURED) {
 		retval = -EHOSTUNREACH;
-	else if (!(intf = usb_ifnum_to_if(ps->dev, ctl->ifno)))
+		goto exit;
+	}
+	intf = usb_ifnum_to_if(ps->dev, ctl->ifno);
+	if (!intf) {
 		retval = -EINVAL;
-	else switch (ctl->ioctl_code) {
+		goto exit;
+	}
 
+	switch (ctl->ioctl_code) {
 	/* disconnect kernel driver from interface */
 	case USBDEVFS_DISCONNECT:
-		if (intf->dev.driver) {
-			driver = to_usb_driver(intf->dev.driver);
-			dev_dbg(&intf->dev, "disconnect by usbfs\n");
-			usb_driver_release_interface(driver, intf);
-		} else
+		if (!intf->dev.driver) {
 			retval = -ENODATA;
+			goto exit;
+		}
+		driver = to_usb_driver(intf->dev.driver);
+		dev_dbg(&intf->dev, "disconnect by usbfs\n");
+		usb_driver_release_interface(driver, intf);
 		break;
 
 	/* let kernel drivers try to (re)bind to the interface */
 	case USBDEVFS_CONNECT:
-		if (!intf->dev.driver)
-			retval = device_attach(&intf->dev);
-		else
+		if (!intf->dev.driver) {
 			retval = -EBUSY;
+			goto exit;
+		}
+		retval = device_attach(&intf->dev);
 		break;
 
 	/* talk directly to the interface's driver */
 	default:
 		if (intf->dev.driver)
 			driver = to_usb_driver(intf->dev.driver);
-		if (driver == NULL || driver->unlocked_ioctl == NULL) {
+		if (!driver || !driver->unlocked_ioctl) {
 			retval = -ENOTTY;
-		} else {
-			retval = driver->unlocked_ioctl(intf, ctl->ioctl_code, buf);
-			if (retval == -ENOIOCTLCMD)
-				retval = -ENOTTY;
+			goto exit;
+		}
+		retval = driver->unlocked_ioctl(intf, ctl->ioctl_code, buf);
+		if (retval == -ENOIOCTLCMD) {
+			retval = -ENOTTY;
+			goto exit;
 		}
+		break;
 	}
 
 	/* cleanup and return */
-	if (retval >= 0
-			&& (_IOC_DIR(ctl->ioctl_code) & _IOC_READ) != 0
-			&& size > 0
-			&& copy_to_user(ctl->data, buf, size) != 0)
+	if (retval >= 0 && (_IOC_DIR(ctl->ioctl_code) & _IOC_READ) != 0 &&
+	    size > 0 && copy_to_user(ctl->data, buf, size) != 0)
 		retval = -EFAULT;
 
+exit:
 	kfree(buf);
 	return retval;
 }
