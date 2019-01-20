Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D22C282DE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B1D20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="IJ1sV62W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbfAUHba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:31:30 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:45898 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfAUHb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:31:28 -0500
Received: from localhost.localdomain (unknown [96.44.9.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3BC9BE85;
        Sun, 20 Jan 2019 20:42:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1548013325;
        bh=uMszIWKQRJ00p2a9xxtOi/zb12GsAIqCRkjaC5/I/Pg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IJ1sV62WNg1F7bY7HIKb6ju3rr+CyfrSbSaLrLK1T6mTLHCE6XimOih8YoG9/50cy
         xMh5CfZ4mH6SIaOzL0o+TtCLBkRh6guE8LiP1lvO38V3z8L4llsCmk8lQruSzgakly
         dWavKFH+cU/6Gd3cXdQp0WkpkC4XjWtqlsvDWnzU=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Cc:     Paul Elder <paul.elder@ideasonboard.com>, b-liu@ti.com,
        stern@rowland.harvard.edu, rogerq@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/6] usb: gadget: uvc: allow ioctl to send response in status stage
Date:   Sun, 20 Jan 2019 14:41:36 -0500
Message-Id: <20190120194136.21870-7-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190120194136.21870-1-paul.elder@ideasonboard.com>
References: <20190120194136.21870-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now have a mechanism to signal the UDC driver to reply to a control
OUT request with STALL or ACK, and we have packaged the setup stage data
and the data stage data of a control OUT request into a single
UVC_EVENT_DATA for userspace to consume. After telling the UDC to delay
the status stage, the ioctl UVCIOC_SEND_RESPONSE should be called to
notify the UDC driver to reply with STALL or ACK, for control OUT
requests. In the case of a control IN request, the ioctl sends the UVC
data as before.

This means that the completion handler will also be called for the
status stage, so make the UVC gadget driver aware of if the
completion handler is called for the status stage, and do nothing (as
opposed to giving userspace the UVC data again).

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
---
Changes from v5:

- add event_status flag and use to keep track of whether or not the
  gadget is in the status stage or not
- do nothing if the completion handler is called during the status stage

No change from v4
No change from v3

Changes from v2:
- calling usb_ep_set_halt in uvc_send_response if data->length < 0 is
  now common for both IN and OUT transfers so make that check common
- remove now unnecessary field setting for the usb_request to be queued
  for the status stage

Changes from v1:
- remove usb_ep_delay_status call from the old proposed API
- changed portions of uvc_send_response to match v2 API
- remove UDC warning that send_response is not implemented

 drivers/usb/gadget/function/f_uvc.c    | 11 +++++++++--
 drivers/usb/gadget/function/uvc.h      |  1 +
 drivers/usb/gadget/function/uvc_v4l2.c | 24 ++++++++++++++++++------
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 6303ed346af9..dd3a06e28435 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -208,15 +208,19 @@ uvc_function_ep0_complete(struct usb_ep *ep, struct usb_request *req)
 	struct v4l2_event v4l2_event;
 	struct uvc_event *uvc_event = (void *)&v4l2_event.u.data;
 
-	if (uvc->event_setup_out) {
-		uvc->event_setup_out = 0;
+	if (uvc->event_status) {
+		uvc->event_status = 0;
+		return;
+	}
 
+	if (uvc->event_setup_out) {
 		memset(&v4l2_event, 0, sizeof(v4l2_event));
 		v4l2_event.type = UVC_EVENT_DATA;
 		uvc_event->data.length = req->actual;
 		memcpy(&uvc_event->data.data, req->buf, req->actual);
 		memcpy(&uvc_event->data.setup, &uvc->control_setup,
 		       sizeof(uvc_event->data.setup));
+
 		v4l2_event_queue(&uvc->vdev, &v4l2_event);
 	}
 }
@@ -242,6 +246,8 @@ uvc_function_setup(struct usb_function *f, const struct usb_ctrlrequest *ctrl)
 	uvc->event_length = le16_to_cpu(ctrl->wLength);
 	memcpy(&uvc->control_setup, ctrl, sizeof(uvc->control_setup));
 
+	uvc->event_status = 0;
+
 	if (uvc->event_setup_out) {
 		struct usb_request *req = uvc->control_req;
 
@@ -251,6 +257,7 @@ uvc_function_setup(struct usb_function *f, const struct usb_ctrlrequest *ctrl)
 		 */
 		req->length = uvc->event_length;
 		req->zero = 0;
+		req->explicit_status = 1;
 		usb_ep_queue(f->config->cdev->gadget->ep0, req, GFP_KERNEL);
 	} else {
 		struct v4l2_event v4l2_event;
diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index 1d89b1df4ba0..5754548d94c5 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -171,6 +171,7 @@ struct uvc_device {
 	/* Events */
 	unsigned int event_length;
 	unsigned int event_setup_out : 1;
+	unsigned int event_status : 1;
 };
 
 static inline struct uvc_device *to_uvc(struct usb_function *f)
diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index ac48f49d9f10..338811c612c5 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -35,15 +35,27 @@ uvc_send_response(struct uvc_device *uvc, struct uvc_request_data *data)
 	struct usb_composite_dev *cdev = uvc->func.config->cdev;
 	struct usb_request *req = uvc->control_req;
 
+	if (data->length < 0)
+		return usb_ep_set_halt(cdev->gadget->ep0);
+
 	/*
 	 * For control OUT transfers the request has been enqueued synchronously
-	 * by the setup handler, there's nothing to be done here.
+	 * by the setup handler, we just need to tell the UDC whether to ACK or
+	 * STALL the control transfer.
 	 */
-	if (uvc->event_setup_out)
-		return 0;
-
-	if (data->length < 0)
-		return usb_ep_set_halt(cdev->gadget->ep0);
+	if (uvc->event_setup_out) {
+		/*
+		 * The length field carries the control request status.
+		 * Negative values signal a STALL and zero values an ACK.
+		 * Positive values are not valid as there is no data to send
+		 * back in the status stage.
+		 */
+		if (data->length > 0)
+			return -EINVAL;
+
+		uvc->event_status = 1;
+		return usb_ep_queue(cdev->gadget->ep0, req, GFP_KERNEL);
+	}
 
 	req->length = min_t(unsigned int, uvc->event_length, data->length);
 	req->zero = data->length < uvc->event_length;
-- 
2.20.1

