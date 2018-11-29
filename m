Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43D9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C0021019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2T9yd23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C0021019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbeK3BVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:21:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:42498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728241AbeK3BVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:21:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6E18205C9;
        Thu, 29 Nov 2018 14:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500945;
        bh=GepExcUhAaYTGEK9tV4wohCU6Y8xrrtq2vzr9I2+vZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m2T9yd23y2ncIvn78bj1SRjXBO+VSk4HVTQVvqoIBnQgKsprUTEprvAnnjlXr/fe4
         +LVK1LLtR82VU+M0HZufZSxMiOPMGBLYm6lNerue5iKmXmJ8xryVNJIw7oo4v9+ju/
         o2STP8EVAEt/9haRdNlcBDKroUHjJqxgkscNhuLE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Pavel Rojtberg <rojtberg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 35/83] Input: xpad - handle "present" and "gone" correctly
Date:   Thu, 29 Nov 2018 15:11:53 +0100
Message-Id: <20181129140139.869097114@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140138.002176596@linuxfoundation.org>
References: <20181129140138.002176596@linuxfoundation.org>
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

[ Upstream commit 09c8b00ae3e16c8d0fd4beb2ca064502a76c0f17 ]

Handle the "a new device is present" message properly by dynamically
creating the input device at this point in time. This means we now do not
"preallocate" all 4 devices when a single wireless base station is seen.
This requires a workqueue as we are in interrupt context when we learn
about this.

Also properly disconnect any devices that we are told are removed.

Signed-off-by: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 107 ++++++++++++++++++++++------------
 1 file changed, 69 insertions(+), 38 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 33c3071c56f9..15477de1608d 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -76,6 +76,8 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/input.h>
+#include <linux/rcupdate.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/module.h>
@@ -321,10 +323,12 @@ MODULE_DEVICE_TABLE(usb, xpad_table);
 
 struct usb_xpad {
 	struct input_dev *dev;		/* input device interface */
+	struct input_dev __rcu *x360w_dev;
 	struct usb_device *udev;	/* usb device */
 	struct usb_interface *intf;	/* usb interface */
 
-	int pad_present;
+	bool pad_present;
+	bool input_created;
 
 	struct urb *irq_in;		/* urb for interrupt in report */
 	unsigned char *idata;		/* input data */
@@ -345,8 +349,12 @@ struct usb_xpad {
 	int xtype;			/* type of xbox device */
 	int pad_nr;			/* the order x360 pads were attached */
 	const char *name;		/* name of the device */
+	struct work_struct work;	/* init/remove device from callback */
 };
 
+static int xpad_init_input(struct usb_xpad *xpad);
+static void xpad_deinit_input(struct usb_xpad *xpad);
+
 /*
  *	xpad_process_packet
  *
@@ -426,11 +434,9 @@ static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *d
  *		http://www.free60.org/wiki/Gamepad
  */
 
-static void xpad360_process_packet(struct usb_xpad *xpad,
+static void xpad360_process_packet(struct usb_xpad *xpad, struct input_dev *dev,
 				   u16 cmd, unsigned char *data)
 {
-	struct input_dev *dev = xpad->dev;
-
 	/* digital pad */
 	if (xpad->mapping & MAP_DPAD_TO_BUTTONS) {
 		/* dpad as buttons (left, right, up, down) */
@@ -497,7 +503,30 @@ static void xpad360_process_packet(struct usb_xpad *xpad,
 	input_sync(dev);
 }
 
-static void xpad_identify_controller(struct usb_xpad *xpad);
+static void xpad_presence_work(struct work_struct *work)
+{
+	struct usb_xpad *xpad = container_of(work, struct usb_xpad, work);
+	int error;
+
+	if (xpad->pad_present) {
+		error = xpad_init_input(xpad);
+		if (error) {
+			/* complain only, not much else we can do here */
+			dev_err(&xpad->dev->dev,
+				"unable to init device: %d\n", error);
+		} else {
+			rcu_assign_pointer(xpad->x360w_dev, xpad->dev);
+		}
+	} else {
+		RCU_INIT_POINTER(xpad->x360w_dev, NULL);
+		synchronize_rcu();
+		/*
+		 * Now that we are sure xpad360w_process_packet is not
+		 * using input device we can get rid of it.
+		 */
+		xpad_deinit_input(xpad);
+	}
+}
 
 /*
  * xpad360w_process_packet
@@ -515,24 +544,28 @@ static void xpad_identify_controller(struct usb_xpad *xpad);
  */
 static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
 {
+	struct input_dev *dev;
+	bool present;
+
 	/* Presence change */
 	if (data[0] & 0x08) {
-		if (data[1] & 0x80) {
-			xpad->pad_present = 1;
-			/*
-			 * Light up the segment corresponding to
-			 * controller number.
-			 */
-			xpad_identify_controller(xpad);
-		} else
-			xpad->pad_present = 0;
+		present = (data[1] & 0x80) != 0;
+
+		if (xpad->pad_present != present) {
+			xpad->pad_present = present;
+			schedule_work(&xpad->work);
+		}
 	}
 
 	/* Valid pad data */
 	if (data[1] != 0x1)
 		return;
 
-	xpad360_process_packet(xpad, cmd, &data[4]);
+	rcu_read_lock();
+	dev = rcu_dereference(xpad->x360w_dev);
+	if (dev)
+		xpad360_process_packet(xpad, dev, cmd, &data[4]);
+	rcu_read_unlock();
 }
 
 /*
@@ -661,7 +694,7 @@ static void xpad_irq_in(struct urb *urb)
 
 	switch (xpad->xtype) {
 	case XTYPE_XBOX360:
-		xpad360_process_packet(xpad, 0, xpad->idata);
+		xpad360_process_packet(xpad, xpad->dev, 0, xpad->idata);
 		break;
 	case XTYPE_XBOX360W:
 		xpad360w_process_packet(xpad, 0, xpad->idata);
@@ -1003,14 +1036,7 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 	if (error)
 		goto err_free_id;
 
-	if (xpad->xtype == XTYPE_XBOX360) {
-		/*
-		 * Light up the segment corresponding to controller
-		 * number on wired devices. On wireless we'll do that
-		 * when they respond to "presence" packet.
-		 */
-		xpad_identify_controller(xpad);
-	}
+	xpad_identify_controller(xpad);
 
 	return 0;
 
@@ -1099,8 +1125,11 @@ static void xpad_set_up_abs(struct input_dev *input_dev, signed short abs)
 
 static void xpad_deinit_input(struct usb_xpad *xpad)
 {
-	xpad_led_disconnect(xpad);
-	input_unregister_device(xpad->dev);
+	if (xpad->input_created) {
+		xpad->input_created = false;
+		xpad_led_disconnect(xpad);
+		input_unregister_device(xpad->dev);
+	}
 }
 
 static int xpad_init_input(struct usb_xpad *xpad)
@@ -1183,6 +1212,7 @@ static int xpad_init_input(struct usb_xpad *xpad)
 	if (error)
 		goto err_disconnect_led;
 
+	xpad->input_created = true;
 	return 0;
 
 err_disconnect_led:
@@ -1246,6 +1276,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	xpad->mapping = xpad_device[i].mapping;
 	xpad->xtype = xpad_device[i].xtype;
 	xpad->name = xpad_device[i].name;
+	INIT_WORK(&xpad->work, xpad_presence_work);
 
 	if (xpad->xtype == XTYPE_UNKNOWN) {
 		if (intf->cur_altsetting->desc.bInterfaceClass == USB_CLASS_VENDOR_SPEC) {
@@ -1282,10 +1313,6 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 
 	usb_set_intfdata(intf, xpad);
 
-	error = xpad_init_input(xpad);
-	if (error)
-		goto err_deinit_output;
-
 	if (xpad->xtype == XTYPE_XBOX360W) {
 		/*
 		 * Submit the int URB immediately rather than waiting for open
@@ -1297,7 +1324,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		xpad->irq_in->dev = xpad->udev;
 		error = usb_submit_urb(xpad->irq_in, GFP_KERNEL);
 		if (error)
-			goto err_deinit_input;
+			goto err_deinit_output;
 
 		/*
 		 * Send presence packet.
@@ -1309,13 +1336,15 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		error = xpad_inquiry_pad_presence(xpad);
 		if (error)
 			goto err_kill_in_urb;
+	} else {
+		error = xpad_init_input(xpad);
+		if (error)
+			goto err_deinit_output;
 	}
 	return 0;
 
 err_kill_in_urb:
 	usb_kill_urb(xpad->irq_in);
-err_deinit_input:
-	xpad_deinit_input(xpad);
 err_deinit_output:
 	xpad_deinit_output(xpad);
 err_free_in_urb:
@@ -1332,17 +1361,19 @@ static void xpad_disconnect(struct usb_interface *intf)
 {
 	struct usb_xpad *xpad = usb_get_intfdata (intf);
 
-	xpad_deinit_input(xpad);
-	xpad_deinit_output(xpad);
-
-	if (xpad->xtype == XTYPE_XBOX360W) {
+	if (xpad->xtype == XTYPE_XBOX360W)
 		usb_kill_urb(xpad->irq_in);
-	}
+
+	cancel_work_sync(&xpad->work);
+
+	xpad_deinit_input(xpad);
 
 	usb_free_urb(xpad->irq_in);
 	usb_free_coherent(xpad->udev, XPAD_PKT_LEN,
 			xpad->idata, xpad->idata_dma);
 
+	xpad_deinit_output(xpad);
+
 	kfree(xpad);
 
 	usb_set_intfdata(intf, NULL);
-- 
2.17.1



