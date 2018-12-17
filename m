Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43A8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D0420675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="cbVAYCHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbeLQGDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 01:03:04 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:53890 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731529AbeLQGC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 01:02:59 -0500
Received: from localhost.localdomain (unknown [96.44.9.229])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 538BCE5C;
        Mon, 17 Dec 2018 07:02:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1545026577;
        bh=IFKKX+mirCGTL05HfK0wK6Mbk0XG4VRYk0eeVau3ypM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cbVAYCHG1tkApVfObg+dV9Pnf9ngJgbQmTILsoFNg8bzdhteDKp0coQ5w5I6AOCXO
         sLPcuGGBuS6pnPg4VctdFoOvqgz86mRC2NCW5rR+NOx5p40DfBGDWwvqY0grAUGLXa
         xCPlwRUNVLQSh/EgskRwkCYofFBdDEA+ma9uPBvo=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Cc:     Paul Elder <paul.elder@ideasonboard.com>, b-liu@ti.com,
        stern@rowland.harvard.edu, rogerq@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] usb: gadget: uvc: allow ioctl to send response in status stage
Date:   Mon, 17 Dec 2018 01:02:16 -0500
Message-Id: <20181217060216.26368-7-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181217060216.26368-1-paul.elder@ideasonboard.com>
References: <20181217060216.26368-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Changes from v1:
- remove usb_ep_delay_status call from the old proposed API
- changed portions of uvc_send_response to match v2 API
- remove UDC warning that send_response is not implemented

 drivers/usb/gadget/function/f_uvc.c    |  4 ++--
 drivers/usb/gadget/function/uvc_v4l2.c | 19 ++++++++++++++++---
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index d08957124e42..91388bb647e0 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -209,14 +209,13 @@ uvc_function_ep0_complete(struct usb_ep *ep, struct usb_request *req)
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
 		v4l2_event_queue(&uvc->vdev, &v4l2_event);
 	}
 }
@@ -251,6 +250,7 @@ uvc_function_setup(struct usb_function *f, const struct usb_ctrlrequest *ctrl)
 		 */
 		req->length = uvc->event_length;
 		req->zero = 0;
+		req->explicit_status = 1;
 		usb_ep_queue(f->config->cdev->gadget->ep0, req, GFP_KERNEL);
 	} else {
 		struct v4l2_event v4l2_event;
diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index 35353ffdf3b4..f09aa92a1b01 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -37,10 +37,23 @@ uvc_send_response(struct uvc_device *uvc, struct uvc_request_data *data)
 
 	/*
 	 * For control OUT transfers the request has been enqueued synchronously
-	 * by the setup handler, there's nothing to be done here.
+	 * by the setup handler, we just need to tell the UDC whether to ACK or
+	 * STALL the control transfer.
 	 */
-	if (uvc->event_setup_out)
-		return 0;
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
+		req->zero = !data->length;
+		req->explicit_status = 1;
+		return usb_ep_queue(cdev->gadget->ep0, req, GFP_KERNEL);
+	}
 
 	if (data->length < 0)
 		return usb_ep_set_halt(cdev->gadget->ep0);
-- 
2.19.2

