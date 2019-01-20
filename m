Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC298C282DE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E910214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="k/vfs1A5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfAUHbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:31:36 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:45900 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbfAUHbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:31:33 -0500
Received: from localhost.localdomain (unknown [96.44.9.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 01A2FE46;
        Sun, 20 Jan 2019 20:41:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1548013319;
        bh=e3y5eq3pWQILXCkoJ1/Ruo8CBZq3bYdfhPm3gOvlNPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k/vfs1A5usErhwm01SEEc8p7IXTAS6stFZIeSq1PRRgdsJSi9HObCd4L8EgNAqlcx
         QJO8965/nbkKM3pFtg9SXnilaBxz0aS9HfCzgv+OcLxArZrLrAtA+DTqAuV5Ea87uN
         AalHkmrsA08HxuguSentExVSeqfbdzxpRhSW3cac=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Cc:     Paul Elder <paul.elder@ideasonboard.com>, b-liu@ti.com,
        stern@rowland.harvard.edu, rogerq@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/6] usb: gadget: uvc: enqueue usb request in setup handler for control OUT
Date:   Sun, 20 Jan 2019 14:41:32 -0500
Message-Id: <20190120194136.21870-3-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190120194136.21870-1-paul.elder@ideasonboard.com>
References: <20190120194136.21870-1-paul.elder@ideasonboard.com>
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
No change from v5
No change from v4
No change from v3
No change from v2
No change from v1

 drivers/usb/gadget/function/f_uvc.c    | 25 +++++++++++++++++++------
 drivers/usb/gadget/function/uvc_v4l2.c |  7 +++++++
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 4134117b5f81..f571623cc6e4 100644
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
index 7816ea9886e1..ac48f49d9f10 100644
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
2.20.1

