Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E70C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03040218AE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="P7EijclU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbfAIHLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:11:07 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:50476 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbfAIHLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:11:04 -0500
Received: from localhost.localdomain (unknown [96.44.9.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BA7C156D;
        Wed,  9 Jan 2019 08:11:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1547017862;
        bh=XMOhArTyjyUfJQCtfanZ3uJls7zGFrNOdjbT81IsVYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P7EijclU2F1+JAOtldNhHVDwt1F5jIBhX+/cvB5n9/kmWSnc8/50tdMhd9ZnnHv6g
         zONBfqELjtlBLPUmDO519w/Kh7894h/YOJJdoKK8VbpT+P2fx6sYgiABr0cP3FW7z4
         CrO9gm5eAN0sR5EimtZB9B34FA7TCeJZ6Gg96xrw=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Cc:     Paul Elder <paul.elder@ideasonboard.com>, rogerq@ti.com,
        balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] usb: gadget: uvc: disable stream when disconnected
Date:   Wed,  9 Jan 2019 02:10:38 -0500
Message-Id: <20190109071039.27702-4-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109071039.27702-1-paul.elder@ideasonboard.com>
References: <20190109071039.27702-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the streamon ioctl is issued while the stream is already on, then the
kernel BUGs. This happens at the BUG_ON in uvc_video_alloc_requests
within the call stack from the ioctl handler for VIDIOC_STREAMON.

This can also be triggered by starting the stream and then physically
disconnecting usb. To fix this, do the streamoff procedures on usb
disconnect. Since uvcg_video_enable is not interrupt-safe, add an
interrupt-safe version uvcg_video_cancel, and use that.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
v2 Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
Changes in v3:

- added interrupt-safe uvcg_video_cancel and used instead of the
  non-interrupt-save uvcg_video_enable 0

Changes in v2: Nothing

 drivers/usb/gadget/function/f_uvc.c     |  3 +++
 drivers/usb/gadget/function/uvc_video.c | 13 +++++++++++++
 drivers/usb/gadget/function/uvc_video.h |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index b407b10a95ed..4134117b5f81 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -369,9 +369,12 @@ uvc_function_disable(struct usb_function *f)
 {
 	struct uvc_device *uvc = to_uvc(f);
 	struct v4l2_event v4l2_event;
+	struct uvc_video *video = &uvc->video;
 
 	uvcg_info(f, "%s()\n", __func__);
 
+	uvcg_video_cancel(video, 1);
+
 	memset(&v4l2_event, 0, sizeof(v4l2_event));
 	v4l2_event.type = UVC_EVENT_DISCONNECT;
 	v4l2_event_queue(&uvc->vdev, &v4l2_event);
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 5c042f380708..5f3ed9e0b5ad 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -348,6 +348,19 @@ int uvcg_video_pump(struct uvc_video *video)
 	return 0;
 }
 
+int uvcg_video_cancel(struct uvc_video *video, int disconnect)
+{
+	unsigned int i;
+
+	for (i = 0; i < UVC_NUM_REQUESTS; ++i)
+		if (video->req[i])
+			usb_ep_dequeue(video->ep, video->req[i]);
+
+	uvc_video_free_requests(video);
+	uvcg_queue_cancel(&video->queue, disconnect);
+	return 0;
+}
+
 /*
  * Enable or disable the video stream.
  */
diff --git a/drivers/usb/gadget/function/uvc_video.h b/drivers/usb/gadget/function/uvc_video.h
index 278dc52c7604..1f310fa58ce5 100644
--- a/drivers/usb/gadget/function/uvc_video.h
+++ b/drivers/usb/gadget/function/uvc_video.h
@@ -16,6 +16,8 @@ struct uvc_video;
 
 int uvcg_video_pump(struct uvc_video *video);
 
+int uvcg_video_cancel(struct uvc_video *video, int disconnect);
+
 int uvcg_video_enable(struct uvc_video *video, int enable);
 
 int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc);
-- 
2.20.1

