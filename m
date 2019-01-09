Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18350C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE23B214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="IK8L3t/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbfAIHLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:11:04 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:50458 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729986AbfAIHLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:11:01 -0500
Received: from localhost.localdomain (unknown [96.44.9.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 20283586;
        Wed,  9 Jan 2019 08:10:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1547017860;
        bh=ef3JcGcK988dlprFJ+Vxh9N9Bm3TcEizRPSoR9vwbGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IK8L3t/nyO2C2GqYG/LEPj3AwcZdZoHxzflaXKh1hzbmgvYk/e6hMatFpTwakv6gL
         HkG0WORNsFnRjCHKOJ43RAUhLJQk+jl+xfYVep6RNRtWPFyaMjrph2hMikKHZwOrN2
         qHiR0Nma2wz9DrWh4q2Dd3JpcQUnJM9gIu80cIAM=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Cc:     Paul Elder <paul.elder@ideasonboard.com>, rogerq@ti.com,
        balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] usb: gadget: uvc: synchronize streamon/off with uvc_function_set_alt
Date:   Wed,  9 Jan 2019 02:10:36 -0500
Message-Id: <20190109071039.27702-2-paul.elder@ideasonboard.com>
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

This could happen when uvc_function_set_alt 0 races and wins against
uvc_v4l2_streamon, or when userspace neglects to issue the
VIDIOC_STREAMOFF ioctl.

To fix this, add two more uvc states: starting and stopping. Use these
to prevent the racing, and to detect when VIDIOC_STREAMON is issued
without previously issuing VIDIOC_STREAMOFF.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
---
Changes in v3:

- add state guard to uvc_function_set_alt 1
- add documentation for newly added uvc states
- reorder uvc states to more or less follow the flow diagram
- add more state guards to ioctl handlers for streamon and streamoff

Changes in v2: Nothing

 drivers/usb/gadget/function/f_uvc.c    | 17 ++++++++----
 drivers/usb/gadget/function/uvc.h      | 37 ++++++++++++++++++++++++++
 drivers/usb/gadget/function/uvc_v4l2.c | 26 ++++++++++++++++--
 3 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 8c99392df593..2ec3b73b2b75 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -317,26 +317,31 @@ uvc_function_set_alt(struct usb_function *f, unsigned interface, unsigned alt)
 
 	switch (alt) {
 	case 0:
-		if (uvc->state != UVC_STATE_STREAMING)
+		if (uvc->state != UVC_STATE_STREAMING &&
+		    uvc->state != UVC_STATE_STARTING)
 			return 0;
 
 		if (uvc->video.ep)
 			usb_ep_disable(uvc->video.ep);
 
+		uvc->state = UVC_STATE_STOPPING;
+
 		memset(&v4l2_event, 0, sizeof(v4l2_event));
 		v4l2_event.type = UVC_EVENT_STREAMOFF;
 		v4l2_event_queue(&uvc->vdev, &v4l2_event);
 
-		uvc->state = UVC_STATE_CONNECTED;
 		return 0;
 
 	case 1:
-		if (uvc->state != UVC_STATE_CONNECTED)
-			return 0;
-
 		if (!uvc->video.ep)
 			return -EINVAL;
 
+		if (uvc->state == UVC_STATE_STOPPING)
+			return -EINVAL;
+
+		if (uvc->state != UVC_STATE_CONNECTED)
+			return 0;
+
 		uvcg_info(f, "reset UVC\n");
 		usb_ep_disable(uvc->video.ep);
 
@@ -346,6 +351,8 @@ uvc_function_set_alt(struct usb_function *f, unsigned interface, unsigned alt)
 			return ret;
 		usb_ep_enable(uvc->video.ep);
 
+		uvc->state = UVC_STATE_STARTING;
+
 		memset(&v4l2_event, 0, sizeof(v4l2_event));
 		v4l2_event.type = UVC_EVENT_STREAMON;
 		v4l2_event_queue(&uvc->vdev, &v4l2_event);
diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index 099d650082e5..f183e349499c 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -101,10 +101,47 @@ struct uvc_video {
 	unsigned int fid;
 };
 
+/**
+ * enum uvc_state - the states of a struct uvc_device
+ * @UVC_STATE_DISCONNECTED: not connected state
+ *			    - transition to connected state on .set_alt
+ * @UVC_STATE_CONNECTED:    connected state
+ *			    - transition to disconnected state on .disable
+ *			      and alloc
+ *			    - transition to starting state on .set_alt 1
+ * @UVC_STATE_STARTING:     starting state
+ *			    - transition to streaming state on streamon ioctl
+ *			    - transition to stopping state on set_alt 0
+ * @UVC_STATE_STREAMING:    streaming state
+ *			    - transition to stopping state on .set_alt 0
+ * @UVC_STATE_STOPPING:     stopping state
+ *			    - transition to connected on streamoff ioctl
+ *
+ * Diagram of state transitions:
+ *
+ *                  disable
+ *   +---------------------------+
+ *   v                           |
+ * +--------------+  set_alt   +-----------+
+ * | DISCONNECTED | ---------> | CONNECTED |
+ * +--------------+            +-----------+
+ *                                |     ^
+ *                 set_alt 1      |     |     streamoff
+ *         +----------------------+     --------------------+
+ *         V                                                |
+ *  +----------+  streamon   +-----------+  set_alt 0   +----------+
+ *  | STARTING | ----------> | STREAMING | -----------> | STOPPING |
+ *  +----------+             +-----------+              +----------+
+ *         |                                                ^
+ *         |                   set_alt 0                    |
+ *         +------------------------------------------------+
+ */
 enum uvc_state {
 	UVC_STATE_DISCONNECTED,
 	UVC_STATE_CONNECTED,
+	UVC_STATE_STARTING,
 	UVC_STATE_STREAMING,
+	UVC_STATE_STOPPING,
 };
 
 struct uvc_device {
diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index a1183eccee22..97e624214287 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -197,17 +197,24 @@ uvc_v4l2_streamon(struct file *file, void *fh, enum v4l2_buf_type type)
 	if (type != video->queue.queue.type)
 		return -EINVAL;
 
+	if (uvc->state == UVC_STATE_STREAMING)
+		return 0;
+
+	if (uvc->state != UVC_STATE_STARTING)
+		return -EINVAL;
+
 	/* Enable UVC video. */
 	ret = uvcg_video_enable(video, 1);
 	if (ret < 0)
 		return ret;
 
+	uvc->state = UVC_STATE_STREAMING;
+
 	/*
 	 * Complete the alternate setting selection setup phase now that
 	 * userspace is ready to provide video frames.
 	 */
 	uvc_function_setup_continue(uvc);
-	uvc->state = UVC_STATE_STREAMING;
 
 	return 0;
 }
@@ -218,11 +225,26 @@ uvc_v4l2_streamoff(struct file *file, void *fh, enum v4l2_buf_type type)
 	struct video_device *vdev = video_devdata(file);
 	struct uvc_device *uvc = video_get_drvdata(vdev);
 	struct uvc_video *video = &uvc->video;
+	int ret;
 
 	if (type != video->queue.queue.type)
 		return -EINVAL;
 
-	return uvcg_video_enable(video, 0);
+	/*
+	 * Check for connected state also because we want to reset buffers
+	 * if this is called when the stream is already off.
+	 */
+	if (uvc->state != UVC_STATE_STOPPING &&
+	    uvc->state != UVC_STATE_CONNECTED)
+		return 0;
+
+	ret = uvcg_video_enable(video, 0);
+	if (ret < 0)
+		return ret;
+
+	uvc->state = UVC_STATE_CONNECTED;
+
+	return 0;
 }
 
 static int
-- 
2.20.1

