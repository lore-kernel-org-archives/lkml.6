Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C77CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BBD208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUEqYk3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39BBD208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbeK3BYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:24:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:46900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728756AbeK3BYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:24:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C28A6205C9;
        Thu, 29 Nov 2018 14:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501124;
        bh=1HQt5R1s+DElKxH0S2Q70owjBYvMLLlI+7qGOJWDNng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SUEqYk3uD7mk4LWmlhjOKtBx1p6ma7b6sHARDrvhAqwOl8MqSsvEWAbaRCTijL0/c
         MyGeJMQl5JwYbWiIC3E6SdHinZh6JUh8biqxISNTVXv+C05JJjKnY9iTbOVigYN4+m
         xm5nj8Pra+S5cQru1pvF8yKSIrnpU+8IwBCHbXuc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Rojtberg <rojtberg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 35/86] Input: xpad - workaround dead irq_out after suspend/ resume
Date:   Thu, 29 Nov 2018 15:12:00 +0100
Message-Id: <20181129140113.014264758@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140109.832117862@linuxfoundation.org>
References: <20181129140109.832117862@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4220f7db1e424f2a086ad41217b5770cc9f003a9 ]

The irq_out urb is dead after suspend/ resume on my x360 wr pad. (also
reproduced by Zachary Lund [0]) Work around this by implementing
suspend, resume, and reset_resume callbacks and properly shutting down
URBs on suspend and restarting them on resume.

[0]: https://github.com/paroj/xpad/issues/6

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 175 ++++++++++++++++++++++++++--------
 1 file changed, 137 insertions(+), 38 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index bfe94216621f..0caced4a68cc 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -82,6 +82,7 @@
 #include <linux/stat.h>
 #include <linux/module.h>
 #include <linux/usb/input.h>
+#include <linux/usb/quirks.h>
 
 #define DRIVER_AUTHOR "Marko Friedemann <mfr@bmx-chemnitz.de>"
 #define DRIVER_DESC "X-Box pad driver"
@@ -348,9 +349,10 @@ struct usb_xpad {
 	dma_addr_t idata_dma;
 
 	struct urb *irq_out;		/* urb for interrupt out report */
+	struct usb_anchor irq_out_anchor;
 	bool irq_out_active;		/* we must not use an active URB */
-	unsigned char *odata;		/* output data */
 	u8 odata_serial;		/* serial number for xbox one protocol */
+	unsigned char *odata;		/* output data */
 	dma_addr_t odata_dma;
 	spinlock_t odata_lock;
 
@@ -767,11 +769,13 @@ static int xpad_try_sending_next_out_packet(struct usb_xpad *xpad)
 	int error;
 
 	if (!xpad->irq_out_active && xpad_prepare_next_out_packet(xpad)) {
+		usb_anchor_urb(xpad->irq_out, &xpad->irq_out_anchor);
 		error = usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
 		if (error) {
 			dev_err(&xpad->intf->dev,
 				"%s - usb_submit_urb failed with result %d\n",
 				__func__, error);
+			usb_unanchor_urb(xpad->irq_out);
 			return -EIO;
 		}
 
@@ -813,11 +817,13 @@ static void xpad_irq_out(struct urb *urb)
 	}
 
 	if (xpad->irq_out_active) {
+		usb_anchor_urb(urb, &xpad->irq_out_anchor);
 		error = usb_submit_urb(urb, GFP_ATOMIC);
 		if (error) {
 			dev_err(dev,
 				"%s - usb_submit_urb failed with result %d\n",
 				__func__, error);
+			usb_unanchor_urb(urb);
 			xpad->irq_out_active = false;
 		}
 	}
@@ -834,6 +840,8 @@ static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad)
 	if (xpad->xtype == XTYPE_UNKNOWN)
 		return 0;
 
+	init_usb_anchor(&xpad->irq_out_anchor);
+
 	xpad->odata = usb_alloc_coherent(xpad->udev, XPAD_PKT_LEN,
 					 GFP_KERNEL, &xpad->odata_dma);
 	if (!xpad->odata) {
@@ -868,8 +876,14 @@ static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad)
 
 static void xpad_stop_output(struct usb_xpad *xpad)
 {
-	if (xpad->xtype != XTYPE_UNKNOWN)
-		usb_kill_urb(xpad->irq_out);
+	if (xpad->xtype != XTYPE_UNKNOWN) {
+		if (!usb_wait_anchor_empty_timeout(&xpad->irq_out_anchor,
+						   5000)) {
+			dev_warn(&xpad->intf->dev,
+				 "timed out waiting for output URB to complete, killing\n");
+			usb_kill_anchored_urbs(&xpad->irq_out_anchor);
+		}
+	}
 }
 
 static void xpad_deinit_output(struct usb_xpad *xpad)
@@ -1198,32 +1212,73 @@ static void xpad_led_disconnect(struct usb_xpad *xpad) { }
 static void xpad_identify_controller(struct usb_xpad *xpad) { }
 #endif
 
-static int xpad_open(struct input_dev *dev)
+static int xpad_start_input(struct usb_xpad *xpad)
 {
-	struct usb_xpad *xpad = input_get_drvdata(dev);
-
-	/* URB was submitted in probe */
-	if (xpad->xtype == XTYPE_XBOX360W)
-		return 0;
+	int error;
 
-	xpad->irq_in->dev = xpad->udev;
 	if (usb_submit_urb(xpad->irq_in, GFP_KERNEL))
 		return -EIO;
 
-	if (xpad->xtype == XTYPE_XBOXONE)
-		return xpad_start_xbox_one(xpad);
+	if (xpad->xtype == XTYPE_XBOXONE) {
+		error = xpad_start_xbox_one(xpad);
+		if (error) {
+			usb_kill_urb(xpad->irq_in);
+			return error;
+		}
+	}
 
 	return 0;
 }
 
-static void xpad_close(struct input_dev *dev)
+static void xpad_stop_input(struct usb_xpad *xpad)
 {
-	struct usb_xpad *xpad = input_get_drvdata(dev);
+	usb_kill_urb(xpad->irq_in);
+}
+
+static int xpad360w_start_input(struct usb_xpad *xpad)
+{
+	int error;
+
+	error = usb_submit_urb(xpad->irq_in, GFP_KERNEL);
+	if (error)
+		return -EIO;
 
-	if (xpad->xtype != XTYPE_XBOX360W)
+	/*
+	 * Send presence packet.
+	 * This will force the controller to resend connection packets.
+	 * This is useful in the case we activate the module after the
+	 * adapter has been plugged in, as it won't automatically
+	 * send us info about the controllers.
+	 */
+	error = xpad_inquiry_pad_presence(xpad);
+	if (error) {
 		usb_kill_urb(xpad->irq_in);
+		return error;
+	}
 
-	xpad_stop_output(xpad);
+	return 0;
+}
+
+static void xpad360w_stop_input(struct usb_xpad *xpad)
+{
+	usb_kill_urb(xpad->irq_in);
+
+	/* Make sure we are done with presence work if it was scheduled */
+	flush_work(&xpad->work);
+}
+
+static int xpad_open(struct input_dev *dev)
+{
+	struct usb_xpad *xpad = input_get_drvdata(dev);
+
+	return xpad_start_input(xpad);
+}
+
+static void xpad_close(struct input_dev *dev)
+{
+	struct usb_xpad *xpad = input_get_drvdata(dev);
+
+	xpad_stop_input(xpad);
 }
 
 static void xpad_set_up_abs(struct input_dev *input_dev, signed short abs)
@@ -1284,8 +1339,10 @@ static int xpad_init_input(struct usb_xpad *xpad)
 
 	input_set_drvdata(input_dev, xpad);
 
-	input_dev->open = xpad_open;
-	input_dev->close = xpad_close;
+	if (xpad->xtype != XTYPE_XBOX360W) {
+		input_dev->open = xpad_open;
+		input_dev->close = xpad_close;
+	}
 
 	__set_bit(EV_KEY, input_dev->evbit);
 
@@ -1459,21 +1516,17 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		 * exactly the message that a controller has arrived that
 		 * we're waiting for.
 		 */
-		xpad->irq_in->dev = xpad->udev;
-		error = usb_submit_urb(xpad->irq_in, GFP_KERNEL);
+		error = xpad360w_start_input(xpad);
 		if (error)
 			goto err_deinit_output;
-
 		/*
-		 * Send presence packet.
-		 * This will force the controller to resend connection packets.
-		 * This is useful in the case we activate the module after the
-		 * adapter has been plugged in, as it won't automatically
-		 * send us info about the controllers.
+		 * Wireless controllers require RESET_RESUME to work properly
+		 * after suspend. Ideally this quirk should be in usb core
+		 * quirk list, but we have too many vendors producing these
+		 * controllers and we'd need to maintain 2 identical lists
+		 * here in this driver and in usb core.
 		 */
-		error = xpad_inquiry_pad_presence(xpad);
-		if (error)
-			goto err_kill_in_urb;
+		udev->quirks |= USB_QUIRK_RESET_RESUME;
 	} else {
 		error = xpad_init_input(xpad);
 		if (error)
@@ -1481,8 +1534,6 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	}
 	return 0;
 
-err_kill_in_urb:
-	usb_kill_urb(xpad->irq_in);
 err_deinit_output:
 	xpad_deinit_output(xpad);
 err_free_in_urb:
@@ -1492,35 +1543,83 @@ err_free_idata:
 err_free_mem:
 	kfree(xpad);
 	return error;
-
 }
 
 static void xpad_disconnect(struct usb_interface *intf)
 {
-	struct usb_xpad *xpad = usb_get_intfdata (intf);
+	struct usb_xpad *xpad = usb_get_intfdata(intf);
 
 	if (xpad->xtype == XTYPE_XBOX360W)
-		usb_kill_urb(xpad->irq_in);
-
-	cancel_work_sync(&xpad->work);
+		xpad360w_stop_input(xpad);
 
 	xpad_deinit_input(xpad);
 
+	/*
+	 * Now that both input device and LED device are gone we can
+	 * stop output URB.
+	 */
+	xpad_stop_output(xpad);
+
+	xpad_deinit_output(xpad);
+
 	usb_free_urb(xpad->irq_in);
 	usb_free_coherent(xpad->udev, XPAD_PKT_LEN,
 			xpad->idata, xpad->idata_dma);
 
-	xpad_deinit_output(xpad);
-
 	kfree(xpad);
 
 	usb_set_intfdata(intf, NULL);
 }
 
+static int xpad_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	struct usb_xpad *xpad = usb_get_intfdata(intf);
+	struct input_dev *input = xpad->dev;
+
+	if (xpad->xtype == XTYPE_XBOX360W) {
+		/*
+		 * Wireless controllers always listen to input so
+		 * they are notified when controller shows up
+		 * or goes away.
+		 */
+		xpad360w_stop_input(xpad);
+	} else {
+		mutex_lock(&input->mutex);
+		if (input->users)
+			xpad_stop_input(xpad);
+		mutex_unlock(&input->mutex);
+	}
+
+	xpad_stop_output(xpad);
+
+	return 0;
+}
+
+static int xpad_resume(struct usb_interface *intf)
+{
+	struct usb_xpad *xpad = usb_get_intfdata(intf);
+	struct input_dev *input = xpad->dev;
+	int retval = 0;
+
+	if (xpad->xtype == XTYPE_XBOX360W) {
+		retval = xpad360w_start_input(xpad);
+	} else {
+		mutex_lock(&input->mutex);
+		if (input->users)
+			retval = xpad_start_input(xpad);
+		mutex_unlock(&input->mutex);
+	}
+
+	return retval;
+}
+
 static struct usb_driver xpad_driver = {
 	.name		= "xpad",
 	.probe		= xpad_probe,
 	.disconnect	= xpad_disconnect,
+	.suspend	= xpad_suspend,
+	.resume		= xpad_resume,
+	.reset_resume	= xpad_resume,
 	.id_table	= xpad_table,
 };
 
-- 
2.17.1



