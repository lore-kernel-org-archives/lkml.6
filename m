Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CCAC41536
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521FE214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="FYnB8GPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521FE214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeJJKJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 06:09:27 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:44324 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeJJKJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 06:09:27 -0400
Received: from garnet.amanokami.net (unknown [96.44.9.229])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E18EC1C3E;
        Wed, 10 Oct 2018 04:49:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539139768;
        bh=JsxG7EJNzKYcwR9A4HHtrXqKQFblkhWA0v2DVZGe17w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FYnB8GPy1A+sLVazaXsMmQEU51x3iMWh8W9AxMGitLf+3WJQ8SzRx/dEc1V73muM1
         bl8MnhTk4rAjS8J8rcs3K9kJtyRV1+AonqWaCLBISKDGrWFzv51bt8Y6Lg8HkZ9n14
         KpAZMEfiBx52kx/PGQR92GXFK3sd6kx3tBo82NP4=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Cc:     Paul Elder <paul.elder@ideasonboard.com>, b-liu@ti.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, balbi@kernel.org,
        stern@rowland.harvard.edu, rogerq@ti.com
Subject: [PATCH 6/6] usb: gadget: uvc: allow ioctl to send response in status stage
Date:   Tue,  9 Oct 2018 22:49:03 -0400
Message-Id: <20181010024903.1633-7-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181010024903.1633-1-paul.elder@ideasonboard.com>
References: <20181010024903.1633-1-paul.elder@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now have a mechanism to signal the UDC driver to reply to a control
OUT request with STALL or ACK, and we have packaged the setup stage data
and the data stage data of a control OUT request into a single
UVC_EVENT_DATA for userspace to consume. The ioctl UVCIOC_SEND_RESPONSE
in the case of a control OUT request sends a response to the data stage,
and so the ioctl now notifies the UDC driver to reply with STALL or ACK.
In the case of a control IN request, the ioctl sends the UVC data as
before.

Also tell the UDC to delay the status stage for this to work.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
---
 drivers/usb/gadget/function/f_uvc.c    |  5 +++--
 drivers/usb/gadget/function/uvc_v4l2.c | 20 +++++++++++++++++---
 drivers/usb/gadget/udc/core.c          |  5 +++++
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 9df3eac440ea..ff89a76a7417 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -209,14 +209,15 @@ uvc_function_ep0_complete(struct usb_ep *ep, struct usb_request *req)
 	struct uvc_event *uvc_event = (void *)&v4l2_event.u.data;
 
 	if (uvc->event_setup_out) {
-		uvc->event_setup_out = 0;
-
 		memset(&v4l2_event, 0, sizeof(v4l2_event));
 		v4l2_event.type = UVC_EVENT_DATA;
 		uvc_event->data.length = req->actual;
 		memcpy(&uvc_event->data.data, req->buf, req->actual);
 		memcpy(&uvc_event->data.setup, &uvc->control_setup,
 		       sizeof(uvc_event->data.setup));
+
+		usb_ep_delay_status(ep);
+
 		v4l2_event_queue(&uvc->vdev, &v4l2_event);
 	}
 }
diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index 2e2251bdef03..caa6412c0bda 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -37,10 +37,24 @@ uvc_send_response(struct uvc_device *uvc, struct uvc_request_data *data)
 
 	/*
 	 * For control OUT transfers the request has been enqueued synchronously
-	 * by the setup handler, there's nothing to be done here.
+	 * by the setup handler, we just need to tell the UDC whether to ACK or
+	 * STALL the control transfer.
 	 */
-	if (uvc->event_setup_out)
-		return 0;
+	if (uvc->event_setup_out) {
+		struct usb_ep *ep = cdev->gadget->ep0;
+		bool stall = data->length < 0;
+
+		/*
+		 * The length field carries the control request status.
+		 * Negative values signal a STALL and zero values an ACK.
+		 * Positive values are not valid as there is no data to send
+		 * back in the status stage.
+		 */
+		if (data->length > 0)
+			return -EINVAL;
+
+		return usb_ep_send_response(ep, stall);
+	}
 
 	if (data->length < 0)
 		return usb_ep_set_halt(cdev->gadget->ep0);
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 1ec5ce6b43cd..0f62a3f1aa29 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1369,6 +1369,11 @@ static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *dri
 	dev_dbg(&udc->dev, "registering UDC driver [%s]\n",
 			driver->function);
 
+	if (!udc->gadget->ep0->ops->send_response) {
+		dev_warn(&udc->dev, "UDC doesn't implement send_response\n");
+		dev_warn(&udc->dev, "Proper operation can't be guaranteed\n");
+	}
+
 	udc->driver = driver;
 	udc->dev.driver = &driver->driver;
 	udc->gadget->dev.driver = &driver->driver;
-- 
2.18.0

