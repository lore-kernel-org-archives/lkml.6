Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B904C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5E5208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDfouqDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5E5208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbeK3BTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:19:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:40556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbeK3BTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:19:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50AE021104;
        Thu, 29 Nov 2018 14:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500861;
        bh=5QbaYuFL519dR4JffJ7BbBG+USLI3xv21ovHnXIRwDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mDfouqDwMd7pEbK8T7zLN4wRnVWdNDO2t+HwZjTYcZj9LpKgxTVWDDkrMholuDl5e
         fbeN84IaqKaqpgoTckgFiuVGx52YJoT3Th0ppbAwfcrup90G2U9kV0WSofua9EC7KU
         +kP8xVZ3mLYq8IYptOosAA0LNu0qGRLgA/p7DeK8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Rojtberg <rojtberg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 28/83] Input: xpad - remove needless bulk out URB used for LED setup
Date:   Thu, 29 Nov 2018 15:11:46 +0100
Message-Id: <20181129140139.566608123@linuxfoundation.org>
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

[ Upstream commit a306a65f46acb040d208523592a2d34f67d47a61 ]

This code was probably wrong ever since and is redundant with
xpad_send_led_command. Both try to send a similar command to the xbox360
controller. However xpad_send_led_command correctly uses the pad_nr instead
of bInterfaceNumber to select the led and re-uses the irq_out URB instead
of creating a new one.

Note that this change only affects the two supported wireless controllers.
Tested using the xbox360 wireless controller (PC).

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 79 +----------------------------------
 1 file changed, 1 insertion(+), 78 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index a395980bb816..afa232b415a5 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -330,9 +330,6 @@ struct usb_xpad {
 	unsigned char *idata;		/* input data */
 	dma_addr_t idata_dma;
 
-	struct urb *bulk_out;
-	unsigned char *bdata;
-
 	struct urb *irq_out;		/* urb for interrupt out report */
 	unsigned char *odata;		/* output data */
 	dma_addr_t odata_dma;
@@ -512,7 +509,6 @@ static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned cha
 	if (data[0] & 0x08) {
 		if (data[1] & 0x80) {
 			xpad->pad_present = 1;
-			usb_submit_urb(xpad->bulk_out, GFP_ATOMIC);
 			/*
 			 * Light up the segment corresponding to
 			 * controller number.
@@ -674,28 +670,6 @@ exit:
 			__func__, retval);
 }
 
-static void xpad_bulk_out(struct urb *urb)
-{
-	struct usb_xpad *xpad = urb->context;
-	struct device *dev = &xpad->intf->dev;
-
-	switch (urb->status) {
-	case 0:
-		/* success */
-		break;
-	case -ECONNRESET:
-	case -ENOENT:
-	case -ESHUTDOWN:
-		/* this urb is terminated, clean up */
-		dev_dbg(dev, "%s - urb shutting down with status: %d\n",
-			__func__, urb->status);
-		break;
-	default:
-		dev_dbg(dev, "%s - nonzero urb status received: %d\n",
-			__func__, urb->status);
-	}
-}
-
 static void xpad_irq_out(struct urb *urb)
 {
 	struct usb_xpad *xpad = urb->context;
@@ -1234,52 +1208,6 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	usb_set_intfdata(intf, xpad);
 
 	if (xpad->xtype == XTYPE_XBOX360W) {
-		/*
-		 * Setup the message to set the LEDs on the
-		 * controller when it shows up
-		 */
-		xpad->bulk_out = usb_alloc_urb(0, GFP_KERNEL);
-		if (!xpad->bulk_out) {
-			error = -ENOMEM;
-			goto fail7;
-		}
-
-		xpad->bdata = kzalloc(XPAD_PKT_LEN, GFP_KERNEL);
-		if (!xpad->bdata) {
-			error = -ENOMEM;
-			goto fail8;
-		}
-
-		xpad->bdata[2] = 0x08;
-		switch (intf->cur_altsetting->desc.bInterfaceNumber) {
-		case 0:
-			xpad->bdata[3] = 0x42;
-			break;
-		case 2:
-			xpad->bdata[3] = 0x43;
-			break;
-		case 4:
-			xpad->bdata[3] = 0x44;
-			break;
-		case 6:
-			xpad->bdata[3] = 0x45;
-		}
-
-		ep_irq_in = &intf->cur_altsetting->endpoint[1].desc;
-		if (usb_endpoint_is_bulk_out(ep_irq_in)) {
-			usb_fill_bulk_urb(xpad->bulk_out, udev,
-					  usb_sndbulkpipe(udev,
-							  ep_irq_in->bEndpointAddress),
-					  xpad->bdata, XPAD_PKT_LEN,
-					  xpad_bulk_out, xpad);
-		} else {
-			usb_fill_int_urb(xpad->bulk_out, udev,
-					 usb_sndintpipe(udev,
-							ep_irq_in->bEndpointAddress),
-					 xpad->bdata, XPAD_PKT_LEN,
-					 xpad_bulk_out, xpad, 0);
-		}
-
 		/*
 		 * Submit the int URB immediately rather than waiting for open
 		 * because we get status messages from the device whether
@@ -1290,13 +1218,11 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		xpad->irq_in->dev = xpad->udev;
 		error = usb_submit_urb(xpad->irq_in, GFP_KERNEL);
 		if (error)
-			goto fail9;
+			goto fail7;
 	}
 
 	return 0;
 
- fail9:	kfree(xpad->bdata);
- fail8:	usb_free_urb(xpad->bulk_out);
  fail7:	input_unregister_device(input_dev);
 	input_dev = NULL;
  fail6:	xpad_led_disconnect(xpad);
@@ -1320,8 +1246,6 @@ static void xpad_disconnect(struct usb_interface *intf)
 	xpad_deinit_output(xpad);
 
 	if (xpad->xtype == XTYPE_XBOX360W) {
-		usb_kill_urb(xpad->bulk_out);
-		usb_free_urb(xpad->bulk_out);
 		usb_kill_urb(xpad->irq_in);
 	}
 
@@ -1329,7 +1253,6 @@ static void xpad_disconnect(struct usb_interface *intf)
 	usb_free_coherent(xpad->udev, XPAD_PKT_LEN,
 			xpad->idata, xpad->idata_dma);
 
-	kfree(xpad->bdata);
 	kfree(xpad);
 
 	usb_set_intfdata(intf, NULL);
-- 
2.17.1



