Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDF4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF8120675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MnXBz5dU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731605AbeLQGDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 01:03:25 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:53890 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeLQGCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 01:02:53 -0500
Received: from localhost.localdomain (unknown [96.44.9.229])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4AF89B64;
        Mon, 17 Dec 2018 07:02:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1545026571;
        bh=/9/TlpL0HgEKiDoc59BeQYVF5j1clAqim0IPOslwtQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MnXBz5dUI6InXngwuTH0sIH+ituyT6UEt4bDK78SjPReLLQaG4UqY6eD5jeNcu5IB
         sVXk9JAXMLtKnE7dL2GAXuIwynDGDJBkrNrJBq/YkXVEl/HgCJI9OfCML8jLubAsaA
         bUc9eaIbWfhU664aAblDQPlc9aIo5FB3sYnENakc=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Cc:     Paul Elder <paul.elder@ideasonboard.com>, b-liu@ti.com,
        stern@rowland.harvard.edu, rogerq@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] usb: gadget: uvc: enqueue usb request in setup handler for control OUT
Date:   Mon, 17 Dec 2018 01:02:12 -0500
Message-Id: <20181217060216.26368-3-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181217060216.26368-1-paul.elder@ideasonboard.com>
References: <20181217060216.26368-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, for uvc class-specific control IN and OUT requests, in the
setup handler a UVC_EVENT_SETUP with the setup control is enqueued to
userspace. In response to this, the uvc function driver expects
userspace to call ioctl UVCIOC_SEND_RESPONSE containing uvc request
data.

In the case of control IN this is fine, but for control OUT it causes a
problem. Since the host sends data immediately after the setup stage
completes, it is possible that the empty uvc request data is not
enqueued in time for the UDC driver to put the data stage data into
(this causes some UDC drivers, such as MUSB, to reply with a STALL).
This problem is remedied by having the setup handler enqueue the empty
uvc request data, instead of waiting for userspace to do it.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
No change from v1

 drivers/usb/gadget/function/f_uvc.c    | 25 +++++++++++++++++++------
 drivers/usb/gadget/function/uvc_v4l2.c |  7 +++++++
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 3e07dcb885b7..772c99c297fc 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -223,8 +223,6 @@ static int
 uvc_function_setup(struct usb_function *f, const struct usb_ctrlrequest *ctrl)
 {
 	struct uvc_device *uvc = to_uvc(f);
-	struct v4l2_event v4l2_event;
-	struct uvc_event *uvc_event = (void *)&v4l2_event.u.data;
 
 	if ((ctrl->bRequestType & USB_TYPE_MASK) != USB_TYPE_CLASS) {
 		uvcg_info(f, "invalid request type\n");
@@ -241,10 +239,25 @@ uvc_function_setup(struct usb_function *f, const struct usb_ctrlrequest *ctrl)
 	uvc->event_setup_out = !(ctrl->bRequestType & USB_DIR_IN);
 	uvc->event_length = le16_to_cpu(ctrl->wLength);
 
-	memset(&v4l2_event, 0, sizeof(v4l2_event));
-	v4l2_event.type = UVC_EVENT_SETUP;
-	memcpy(&uvc_event->req, ctrl, sizeof(uvc_event->req));
-	v4l2_event_queue(&uvc->vdev, &v4l2_event);
+	if (uvc->event_setup_out) {
+		struct usb_request *req = uvc->control_req;
+
+		/*
+		 * Enqueue the request immediately for control OUT as the
+		 * host will start the data stage straight away.
+		 */
+		req->length = uvc->event_length;
+		req->zero = 0;
+		usb_ep_queue(f->config->cdev->gadget->ep0, req, GFP_KERNEL);
+	} else {
+		struct v4l2_event v4l2_event;
+		struct uvc_event *uvc_event = (void *)&v4l2_event.u.data;
+
+		memset(&v4l2_event, 0, sizeof(v4l2_event));
+		v4l2_event.type = UVC_EVENT_SETUP;
+		memcpy(&uvc_event->req, ctrl, sizeof(uvc_event->req));
+		v4l2_event_queue(&uvc->vdev, &v4l2_event);
+	}
 
 	return 0;
 }
diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index 7bfa43dbef9e..35353ffdf3b4 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -35,6 +35,13 @@ uvc_send_response(struct uvc_device *uvc, struct uvc_request_data *data)
 	struct usb_composite_dev *cdev = uvc->func.config->cdev;
 	struct usb_request *req = uvc->control_req;
 
+	/*
+	 * For control OUT transfers the request has been enqueued synchronously
+	 * by the setup handler, there's nothing to be done here.
+	 */
+	if (uvc->event_setup_out)
+		return 0;
+
 	if (data->length < 0)
 		return usb_ep_set_halt(cdev->gadget->ep0);
 
-- 
2.19.2

