Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B4AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21539214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="seKkao0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfAIHLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:11:05 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:50468 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfAIHLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:11:03 -0500
Received: from localhost.localdomain (unknown [96.44.9.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6F6C758E;
        Wed,  9 Jan 2019 08:11:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1547017861;
        bh=7FAhrG8dWLyaXh0nhu5tcaIeNRjx99LWsziSWMPYnTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=seKkao0g9RbRutzOGpZshL13DNyH7MMDcYYtjktGxnePJTioldtaMoXG2XtPXQx00
         VeasAkC7sNYQPvR90FMtGAofTirq18zJ1V6XY7mYhm+/BRq8QT2Jazb+XVqMePd5UI
         IEij5GgklgPKCxKkqSfkGlh3TAODVYIppUIRjjW4=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Cc:     Paul Elder <paul.elder@ideasonboard.com>, rogerq@ti.com,
        balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] usb: gadget: uvc: don't delay the status phase of non-zero SET_INTERFACE requests
Date:   Wed,  9 Jan 2019 02:10:37 -0500
Message-Id: <20190109071039.27702-3-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109071039.27702-1-paul.elder@ideasonboard.com>
References: <20190109071039.27702-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reception of a SET_INTERFACE request with a non-zero alternate setting
signals the start of the video stream. The gadget has to enable the
video streaming endpoint and to signal stream start to userspace, in
order to start receiving video frames to transmit over USB. As userspace
can be slow to react, the UVC function driver delays the status phase of
the SET_INTERFACE control transfer until userspace is ready.

The status phase is delayed by returning USB_GADGET_DELAYED_STATUS from
the function's .set_alt() handler. This creates a race condition as the
userspace application could process the stream start event before the
composite layer processes the USB_GADGET_DELAYED_STATUS return value.
The race has been observed in practice, and can't be solved without a
change to the USB_GADGET_DELAYED_STATUS API.

Fortunately the UVC function driver doesn't strictly require delaying
the status phase for non-zero SET_INTERFACE, as the only requirement
from a USB point of view is that the streaming endpoint must be enabled
before the status phase completes, and that is already guaranteed by the
current code. We can thus complete the status phase synchronously,
removing the race condition at the same time.

Without delaying the status phase the host will likely start issuing
isochronous transfers before we queue the first USB requests. The UDC
will reply with NAKs which should be handled properly by the host. If
this ends up causing issues another option will be to modify the status
phase delay API to fix the race condition.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
---
Changes in v3: Nothing

Changes in v2:
	1. Remove delay usb status phase

 drivers/usb/gadget/function/f_uvc.c    | 3 ++-
 drivers/usb/gadget/function/uvc_v4l2.c | 6 ------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 2ec3b73b2b75..b407b10a95ed 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -356,7 +356,8 @@ uvc_function_set_alt(struct usb_function *f, unsigned interface, unsigned alt)
 		memset(&v4l2_event, 0, sizeof(v4l2_event));
 		v4l2_event.type = UVC_EVENT_STREAMON;
 		v4l2_event_queue(&uvc->vdev, &v4l2_event);
-		return USB_GADGET_DELAYED_STATUS;
+
+		return 0;
 
 	default:
 		return -EINVAL;
diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index 97e624214287..7816ea9886e1 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -210,12 +210,6 @@ uvc_v4l2_streamon(struct file *file, void *fh, enum v4l2_buf_type type)
 
 	uvc->state = UVC_STATE_STREAMING;
 
-	/*
-	 * Complete the alternate setting selection setup phase now that
-	 * userspace is ready to provide video frames.
-	 */
-	uvc_function_setup_continue(uvc);
-
 	return 0;
 }
 
-- 
2.20.1

