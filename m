Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943C3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C07D214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rjd0YLJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbfAIHJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:09:58 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:50382 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729769AbfAIHJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:09:55 -0500
Received: from localhost.localdomain (unknown [96.44.9.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E2D8CB6A;
        Wed,  9 Jan 2019 08:09:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1547017793;
        bh=lkRf+frq/ryWTBFHPkmcO8JYrjI1siKHiDS4jShZZGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rjd0YLJA9qo47aVLhQolpqGGIdWctUmBx5BjCCrz7ldRydZBNYuD6AJo44uiwfnCV
         0e1crcyG9gQ/R1H3Ka0ENuR2joV1QCaG2YDFVnAkLqHj4m8kxORJE6XdPG9xrbxXIv
         E1RjRw6/EM2mEk16lJng0IFhPw/Oco/TjJIm9lYQ=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Cc:     Paul Elder <paul.elder@ideasonboard.com>, b-liu@ti.com,
        stern@rowland.harvard.edu, rogerq@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/6] usb: gadget: uvc: package setup and data for control OUT requests
Date:   Wed,  9 Jan 2019 02:08:53 -0500
Message-Id: <20190109070856.27460-4-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109070856.27460-1-paul.elder@ideasonboard.com>
References: <20190109070856.27460-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since "usb: gadget: uvc: enqueue uvc_request_data in setup handler
for control OUT requests" it is no longer necessary for userspace to
call ioctl UVCIOC_SEND_RESPONSE in response to receiving a
UVC_EVENT_SETUP from the uvc function driver for a control OUT request.

This change means that for control OUT userspace will receive a
UVC_EVENT_SETUP and not do anything with it. This is a waste of a pair
of context switches, so we put the setup and data stage data into a
single UVC_EVENT_DATA to give to userspace. Previously struct
uvc_request_data had 60 bytes allocated for data, and since uvc data at
most is 34 bytes in UVC 1.1 and 48 bytes in UVC 1.5, we can afford to
cut out 8 bytes to store the setup control.

Since the setup control is discarded after the handling of the setup
stage, it must be saved in struct uvc_device during the setup handler in
order for the data stage handler to be able to read it and send it to
userspace.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
No change from v4
No change from v3
No change from v2
No change from v1

 drivers/usb/gadget/function/f_uvc.c | 3 +++
 drivers/usb/gadget/function/uvc.h   | 1 +
 include/uapi/linux/usb/g_uvc.h      | 3 ++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 36de51ac30ed..58ed191f636e 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -215,6 +215,8 @@ uvc_function_ep0_complete(struct usb_ep *ep, struct usb_request *req)
 		v4l2_event.type = UVC_EVENT_DATA;
 		uvc_event->data.length = req->actual;
 		memcpy(&uvc_event->data.data, req->buf, req->actual);
+		memcpy(&uvc_event->data.setup, &uvc->control_setup,
+		       sizeof(uvc_event->data.setup));
 		v4l2_event_queue(&uvc->vdev, &v4l2_event);
 	}
 }
@@ -238,6 +240,7 @@ uvc_function_setup(struct usb_function *f, const struct usb_ctrlrequest *ctrl)
 	 */
 	uvc->event_setup_out = !(ctrl->bRequestType & USB_DIR_IN);
 	uvc->event_length = le16_to_cpu(ctrl->wLength);
+	memcpy(&uvc->control_setup, ctrl, sizeof(uvc->control_setup));
 
 	if (uvc->event_setup_out) {
 		struct usb_request *req = uvc->control_req;
diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index 671020c8a836..1d89b1df4ba0 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -163,6 +163,7 @@ struct uvc_device {
 	unsigned int control_intf;
 	struct usb_ep *control_ep;
 	struct usb_request *control_req;
+	struct usb_ctrlrequest control_setup;
 	void *control_buf;
 
 	unsigned int streaming_intf;
diff --git a/include/uapi/linux/usb/g_uvc.h b/include/uapi/linux/usb/g_uvc.h
index 6698c3263ae8..10fbb4382925 100644
--- a/include/uapi/linux/usb/g_uvc.h
+++ b/include/uapi/linux/usb/g_uvc.h
@@ -24,7 +24,8 @@
 
 struct uvc_request_data {
 	__s32 length;
-	__u8 data[60];
+	struct usb_ctrlrequest setup;
+	__u8 data[52];
 };
 
 struct uvc_event {
-- 
2.20.1

