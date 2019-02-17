Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB82BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 07:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE7921A4A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 07:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i5yQOJ1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbfBQHV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 02:21:57 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44778 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfBQHVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 02:21:55 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so6957143pfh.11
        for <linux-kernel@vger.kernel.org>; Sat, 16 Feb 2019 23:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=IsR40mg9Ce6c5QV73d3O/4yPWwcefsy47mVst6TYP+k=;
        b=i5yQOJ1tqTcuY8PNCfesgHMBj8Ao+WA4oxkHiZJ05yetnpTquMGhT2hi4wv59SdbSm
         U8qiTUPdtJb76rJ4tQoM46PblMqs4lKcAV4ayn+jn+WfKz9BXernEDHUNkfeTI/NcWPv
         fzGYPRj+HVcjtpRZ/6CH6NVr6YtROfG6Am0tI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=IsR40mg9Ce6c5QV73d3O/4yPWwcefsy47mVst6TYP+k=;
        b=myk20XRIxd8Mzlz4JfV1Zlufl+LN92lomwXUg5Xi3VSHIuKiK/hovEIa+26uHWSZ0e
         WrZlS0Xl7VqXAOuY5gGlTM2x7XerJIgfpzGqUaovWRNwCYID891O42ZPPkKU0rIfU2hY
         6sq+tJPxHlC0BImSqzg3XU/PWcgP9ZHD5BJTOTi0kAe9lpGMuAfNQ8oeAotnfyR5jISX
         zUqRqypCDE6EACq9qVEta99ySiwVBVANTVxH2e2zdkEoF5zOaXVECNqHoaaSGDjjFQl+
         SfLxwPiHBdcRBVxUeJhHSAM5n95f5uFQDTXVEXI44m/ghOhdamw2nQ1nWoMVBzTvx6ni
         q1gw==
X-Gm-Message-State: AHQUAub2uzIsxFZ/DIHHsuIVwHcHBWN97cPxRxw1pYkQ6TckeBCRb7if
        AvbY86U2ZX6aon7twVOUL+TFYTLboKE=
X-Google-Smtp-Source: AHgI3Ib7jN89RAemWe8ZRX+mNAzmv/0bpkeIXkM3hQMcNXGKyujgT9/Zm2oro5uhkbNOWKRjdDqXUg==
X-Received: by 2002:a62:170b:: with SMTP id 11mr17852458pfx.47.1550388114805;
        Sat, 16 Feb 2019 23:21:54 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id s73sm25376812pfi.124.2019.02.16.23.21.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 23:21:53 -0800 (PST)
Date:   Sat, 16 Feb 2019 23:21:51 -0800
From:   Dmitry Torokhov <dtor@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH] usb: core: add option of only authorizing internal devices
Message-ID: <20190217072151.GA244815@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Chrome OS we want to use USBguard to potentially limit access to USB
devices based on policy. We however to do not want to wait for userspace to
come up before initializing fixed USB devices to not regress our boot
times.

This patch adds option to instruct the kernel to only authorize devices
connected to the internal ports. Previously we could either authorize
all or none (or, by default, we'd only authorize wired devices).

The behavior is controlled via usbcore.authorized_default command line
option.

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
---
 .../admin-guide/kernel-parameters.txt         |  3 +-
 Documentation/usb/authorization.txt           |  4 +-
 drivers/usb/core/hcd.c                        | 51 +++++++++++--------
 drivers/usb/core/usb.c                        | 33 +++++++++---
 include/linux/usb/hcd.h                       | 10 ++--
 5 files changed, 69 insertions(+), 32 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index aefd358a5ca3..4446919089b9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4675,7 +4675,8 @@
 	usbcore.authorized_default=
 			[USB] Default USB device authorization:
 			(default -1 = authorized except for wireless USB,
-			0 = not authorized, 1 = authorized)
+			0 = not authorized, 1 = authorized, 2 = authorized
+			if device connected to internal port)
 
 	usbcore.autosuspend=
 			[USB] The autosuspend time delay (in seconds) used
diff --git a/Documentation/usb/authorization.txt b/Documentation/usb/authorization.txt
index c7e985f05d8f..68c001aca78c 100644
--- a/Documentation/usb/authorization.txt
+++ b/Documentation/usb/authorization.txt
@@ -34,7 +34,9 @@ $ echo 1 > /sys/bus/usb/devices/usbX/authorized_default
 By default, Wired USB devices are authorized by default to
 connect. Wireless USB hosts deauthorize by default all new connected
 devices (this is so because we need to do an authentication phase
-before authorizing).
+before authorizing). Writing "2" to the authorized_default attribute
+causes kernel to only authorize by default devices connected to internal
+USB ports.
 
 
 Example system lockdown (lame)
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 487025d31d44..4a78bf191d78 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -373,13 +373,19 @@ static const u8 ss_rh_config_descriptor[] = {
  * -1 is authorized for all devices except wireless (old behaviour)
  * 0 is unauthorized for all devices
  * 1 is authorized for all devices
+ * 2 is authorized for internal devices
  */
-static int authorized_default = -1;
+#define USB_AUTHORIZE_WIRED	-1
+#define USB_AUTHORIZE_NONE	0
+#define USB_AUTHORIZE_ALL	1
+#define USB_AUTHORIZE_INTERNAL	2
+
+static int authorized_default = USB_AUTHORIZE_WIRED;
 module_param(authorized_default, int, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(authorized_default,
 		"Default USB device authorization: 0 is not authorized, 1 is "
-		"authorized, -1 is authorized except for wireless USB (default, "
-		"old behaviour");
+		"authorized, 2 is authorized for internal devices, -1 is "
+		"authorized except for wireless USB (default, old behaviour");
 /*-------------------------------------------------------------------------*/
 
 /**
@@ -884,7 +890,7 @@ static ssize_t authorized_default_show(struct device *dev,
 	struct usb_hcd *hcd;
 
 	hcd = bus_to_hcd(usb_bus);
-	return snprintf(buf, PAGE_SIZE, "%u\n", !!HCD_DEV_AUTHORIZED(hcd));
+	return snprintf(buf, PAGE_SIZE, "%u\n", hcd->dev_policy);
 }
 
 static ssize_t authorized_default_store(struct device *dev,
@@ -900,11 +906,8 @@ static ssize_t authorized_default_store(struct device *dev,
 	hcd = bus_to_hcd(usb_bus);
 	result = sscanf(buf, "%u\n", &val);
 	if (result == 1) {
-		if (val)
-			set_bit(HCD_FLAG_DEV_AUTHORIZED, &hcd->flags);
-		else
-			clear_bit(HCD_FLAG_DEV_AUTHORIZED, &hcd->flags);
-
+		hcd->dev_policy = val <= USB_DEVICE_AUTHORIZE_INTERNAL ?
+			val : USB_DEVICE_AUTHORIZE_ALL;
 		result = size;
 	} else {
 		result = -EINVAL;
@@ -2745,18 +2748,26 @@ int usb_add_hcd(struct usb_hcd *hcd,
 
 	dev_info(hcd->self.controller, "%s\n", hcd->product_desc);
 
-	/* Keep old behaviour if authorized_default is not in [0, 1]. */
-	if (authorized_default < 0 || authorized_default > 1) {
-		if (hcd->wireless)
-			clear_bit(HCD_FLAG_DEV_AUTHORIZED, &hcd->flags);
-		else
-			set_bit(HCD_FLAG_DEV_AUTHORIZED, &hcd->flags);
-	} else {
-		if (authorized_default)
-			set_bit(HCD_FLAG_DEV_AUTHORIZED, &hcd->flags);
-		else
-			clear_bit(HCD_FLAG_DEV_AUTHORIZED, &hcd->flags);
+	switch (authorized_default) {
+	case USB_AUTHORIZE_NONE:
+		hcd->dev_policy = USB_DEVICE_AUTHORIZE_NONE;
+		break;
+
+	case USB_AUTHORIZE_ALL:
+		hcd->dev_policy = USB_DEVICE_AUTHORIZE_ALL;
+		break;
+
+	case USB_AUTHORIZE_INTERNAL:
+		hcd->dev_policy = USB_DEVICE_AUTHORIZE_INTERNAL;
+		break;
+
+	case USB_AUTHORIZE_WIRED:
+	default:
+		hcd->dev_policy = hcd->wireless ?
+			USB_DEVICE_AUTHORIZE_NONE : USB_DEVICE_AUTHORIZE_ALL;
+		break;
 	}
+
 	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 
 	/* per default all interfaces are authorized */
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 4ebfbd737905..9b5852e313f5 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -46,8 +46,7 @@
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
 
-#include "usb.h"
-
+#include "hub.h"
 
 const char *usbcore_name = "usbcore";
 
@@ -536,6 +535,27 @@ static unsigned usb_bus_is_wusb(struct usb_bus *bus)
 	return hcd->wireless;
 }
 
+static bool usb_dev_authorized(struct usb_device *dev, struct usb_hcd *hcd)
+{
+	struct usb_hub *hub;
+
+	if (!dev->parent)
+		return true; /* Root hub always ok [and always wired] */
+
+	switch (hcd->dev_policy) {
+	case USB_DEVICE_AUTHORIZE_NONE:
+	default:
+		return false;
+
+	case USB_DEVICE_AUTHORIZE_ALL:
+		return true;
+
+	case USB_DEVICE_AUTHORIZE_INTERNAL:
+		hub = usb_hub_to_struct_hub(dev->parent);
+		return hub->ports[dev->portnum - 1]->connect_type ==
+				USB_PORT_CONNECT_TYPE_HARD_WIRED;
+	}
+}
 
 /**
  * usb_alloc_dev - usb device constructor (usbcore-internal)
@@ -663,12 +683,11 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
 	dev->connect_time = jiffies;
 	dev->active_duration = -jiffies;
 #endif
-	if (root_hub)	/* Root hub always ok [and always wired] */
-		dev->authorized = 1;
-	else {
-		dev->authorized = !!HCD_DEV_AUTHORIZED(usb_hcd);
+
+	dev->authorized = usb_dev_authorized(dev, usb_hcd);
+	if (!root_hub)
 		dev->wusb = usb_bus_is_wusb(bus) ? 1 : 0;
-	}
+
 	return dev;
 }
 EXPORT_SYMBOL_GPL(usb_alloc_dev);
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 97e2ddec18b1..7c46951701ca 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -72,6 +72,12 @@ struct giveback_urb_bh {
 	struct usb_host_endpoint *completing_ep;
 };
 
+enum usb_dev_authorize_policy {
+	USB_DEVICE_AUTHORIZE_NONE	= 0,
+	USB_DEVICE_AUTHORIZE_ALL	= 1,
+	USB_DEVICE_AUTHORIZE_INTERNAL	= 2,
+};
+
 struct usb_hcd {
 
 	/*
@@ -117,7 +123,6 @@ struct usb_hcd {
 #define HCD_FLAG_RH_RUNNING		5	/* root hub is running? */
 #define HCD_FLAG_DEAD			6	/* controller has died? */
 #define HCD_FLAG_INTF_AUTHORIZED	7	/* authorize interfaces? */
-#define HCD_FLAG_DEV_AUTHORIZED		8	/* authorize devices? */
 
 	/* The flags can be tested using these macros; they are likely to
 	 * be slightly faster than test_bit().
@@ -142,8 +147,7 @@ struct usb_hcd {
 	 * or they require explicit user space authorization; this bit is
 	 * settable through /sys/class/usb_host/X/authorized_default
 	 */
-#define HCD_DEV_AUTHORIZED(hcd) \
-	((hcd)->flags & (1U << HCD_FLAG_DEV_AUTHORIZED))
+	enum usb_dev_authorize_policy dev_policy;
 
 	/* Flags that get set only during HCD registration or removal. */
 	unsigned		rh_registered:1;/* is root hub registered? */
-- 
2.21.0.rc0.258.g878e2cd30e-goog


-- 
Dmitry
