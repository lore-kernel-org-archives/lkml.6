Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500F0C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102C7214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102C7214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733057AbeIXSaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:30:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57442 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730974AbeIXSaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:30:19 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 049BD1018;
        Mon, 24 Sep 2018 12:28:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 031/235] Input: pxrc - fix freeing URB on device teardown
Date:   Mon, 24 Sep 2018 13:50:17 +0200
Message-Id: <20180924113108.000942164@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 34dad2cf1104869ce2db2bddb34f8e6780c2ddaa ]

URB is the only resource that is not managed, and thus is destroyed too early,
before we unregister input device and stop URB in pxrc_close(). To fix it let's
install custom devm handler to free the URB at the right time in devm unwind
sequence.

Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Tested-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/joystick/pxrc.c |   68 +++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 37 deletions(-)

--- a/drivers/input/joystick/pxrc.c
+++ b/drivers/input/joystick/pxrc.c
@@ -120,48 +120,51 @@ static void pxrc_close(struct input_dev
 	mutex_unlock(&pxrc->pm_mutex);
 }
 
+static void pxrc_free_urb(void *_pxrc)
+{
+	struct pxrc *pxrc = _pxrc;
+
+	usb_free_urb(pxrc->urb);
+}
+
 static int pxrc_usb_init(struct pxrc *pxrc)
 {
 	struct usb_endpoint_descriptor *epirq;
 	unsigned int pipe;
-	int retval;
+	int error;
 
 	/* Set up the endpoint information */
 	/* This device only has an interrupt endpoint */
-	retval = usb_find_common_endpoints(pxrc->intf->cur_altsetting,
-			NULL, NULL, &epirq, NULL);
-	if (retval) {
-		dev_err(&pxrc->intf->dev,
-			"Could not find endpoint\n");
-		goto error;
+	error = usb_find_common_endpoints(pxrc->intf->cur_altsetting,
+					  NULL, NULL, &epirq, NULL);
+	if (error) {
+		dev_err(&pxrc->intf->dev, "Could not find endpoint\n");
+		return error;
 	}
 
 	pxrc->bsize = usb_endpoint_maxp(epirq);
 	pxrc->epaddr = epirq->bEndpointAddress;
 	pxrc->data = devm_kmalloc(&pxrc->intf->dev, pxrc->bsize, GFP_KERNEL);
-	if (!pxrc->data) {
-		retval = -ENOMEM;
-		goto error;
-	}
+	if (!pxrc->data)
+		return -ENOMEM;
 
 	usb_set_intfdata(pxrc->intf, pxrc);
 	usb_make_path(pxrc->udev, pxrc->phys, sizeof(pxrc->phys));
 	strlcat(pxrc->phys, "/input0", sizeof(pxrc->phys));
 
 	pxrc->urb = usb_alloc_urb(0, GFP_KERNEL);
-	if (!pxrc->urb) {
-		retval = -ENOMEM;
-		goto error;
-	}
+	if (!pxrc->urb)
+		return -ENOMEM;
+
+	error = devm_add_action_or_reset(&pxrc->intf->dev, pxrc_free_urb, pxrc);
+	if (error)
+		return error;
 
 	pipe = usb_rcvintpipe(pxrc->udev, pxrc->epaddr),
 	usb_fill_int_urb(pxrc->urb, pxrc->udev, pipe, pxrc->data, pxrc->bsize,
 						pxrc_usb_irq, pxrc, 1);
 
-error:
-	return retval;
-
-
+	return 0;
 }
 
 static int pxrc_input_init(struct pxrc *pxrc)
@@ -197,7 +200,7 @@ static int pxrc_probe(struct usb_interfa
 		      const struct usb_device_id *id)
 {
 	struct pxrc *pxrc;
-	int retval;
+	int error;
 
 	pxrc = devm_kzalloc(&intf->dev, sizeof(*pxrc), GFP_KERNEL);
 	if (!pxrc)
@@ -207,29 +210,20 @@ static int pxrc_probe(struct usb_interfa
 	pxrc->udev = usb_get_dev(interface_to_usbdev(intf));
 	pxrc->intf = intf;
 
-	retval = pxrc_usb_init(pxrc);
-	if (retval)
-		goto error;
-
-	retval = pxrc_input_init(pxrc);
-	if (retval)
-		goto err_free_urb;
+	error = pxrc_usb_init(pxrc);
+	if (error)
+		return error;
+
+	error = pxrc_input_init(pxrc);
+	if (error)
+		return error;
 
 	return 0;
-
-err_free_urb:
-	usb_free_urb(pxrc->urb);
-
-error:
-	return retval;
 }
 
 static void pxrc_disconnect(struct usb_interface *intf)
 {
-	struct pxrc *pxrc = usb_get_intfdata(intf);
-
-	usb_free_urb(pxrc->urb);
-	usb_set_intfdata(intf, NULL);
+	/* All driver resources are devm-managed. */
 }
 
 static int pxrc_suspend(struct usb_interface *intf, pm_message_t message)


