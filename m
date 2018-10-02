Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878EBC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594222064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594222064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733285AbeJBUUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:20:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36374 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733264AbeJBUUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:20:03 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7F070B4B;
        Tue,  2 Oct 2018 13:36:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, ming_qian <ming_qian@realsil.com.cn>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Ana Guerrero Lopez <ana.guerrero@collabora.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.9 67/94] media: uvcvideo: Support realteks UVC 1.5 device
Date:   Tue,  2 Oct 2018 06:25:21 -0700
Message-Id: <20181002132505.145041018@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132500.494838053@linuxfoundation.org>
References: <20181002132500.494838053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: ming_qian <ming_qian@realsil.com.cn>

commit f620d1d7afc7db57ab59f35000752840c91f67e7 upstream.

media: uvcvideo: Support UVC 1.5 video probe & commit controls

The length of UVC 1.5 video control is 48, and it is 34 for UVC 1.1.
Change it to 48 for UVC 1.5 device, and the UVC 1.5 device can be
recognized.

More changes to the driver are needed for full UVC 1.5 compatibility.
However, at least the UVC 1.5 Realtek RTS5847/RTS5852 cameras have been
reported to work well.

[laurent.pinchart@ideasonboard.com: Factor out code to helper function, update size checks]

Cc: stable@vger.kernel.org
Signed-off-by: ming_qian <ming_qian@realsil.com.cn>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Tested-by: Ana Guerrero Lopez <ana.guerrero@collabora.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/uvc/uvc_video.c |   24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -163,14 +163,27 @@ static void uvc_fixup_video_ctrl(struct
 	}
 }
 
+static size_t uvc_video_ctrl_size(struct uvc_streaming *stream)
+{
+	/*
+	 * Return the size of the video probe and commit controls, which depends
+	 * on the protocol version.
+	 */
+	if (stream->dev->uvc_version < 0x0110)
+		return 26;
+	else if (stream->dev->uvc_version < 0x0150)
+		return 34;
+	else
+		return 48;
+}
+
 static int uvc_get_video_ctrl(struct uvc_streaming *stream,
 	struct uvc_streaming_control *ctrl, int probe, __u8 query)
 {
+	__u16 size = uvc_video_ctrl_size(stream);
 	__u8 *data;
-	__u16 size;
 	int ret;
 
-	size = stream->dev->uvc_version >= 0x0110 ? 34 : 26;
 	if ((stream->dev->quirks & UVC_QUIRK_PROBE_DEF) &&
 			query == UVC_GET_DEF)
 		return -EIO;
@@ -225,7 +238,7 @@ static int uvc_get_video_ctrl(struct uvc
 	ctrl->dwMaxVideoFrameSize = get_unaligned_le32(&data[18]);
 	ctrl->dwMaxPayloadTransferSize = get_unaligned_le32(&data[22]);
 
-	if (size == 34) {
+	if (size >= 34) {
 		ctrl->dwClockFrequency = get_unaligned_le32(&data[26]);
 		ctrl->bmFramingInfo = data[30];
 		ctrl->bPreferedVersion = data[31];
@@ -254,11 +267,10 @@ out:
 static int uvc_set_video_ctrl(struct uvc_streaming *stream,
 	struct uvc_streaming_control *ctrl, int probe)
 {
+	__u16 size = uvc_video_ctrl_size(stream);
 	__u8 *data;
-	__u16 size;
 	int ret;
 
-	size = stream->dev->uvc_version >= 0x0110 ? 34 : 26;
 	data = kzalloc(size, GFP_KERNEL);
 	if (data == NULL)
 		return -ENOMEM;
@@ -275,7 +287,7 @@ static int uvc_set_video_ctrl(struct uvc
 	put_unaligned_le32(ctrl->dwMaxVideoFrameSize, &data[18]);
 	put_unaligned_le32(ctrl->dwMaxPayloadTransferSize, &data[22]);
 
-	if (size == 34) {
+	if (size >= 34) {
 		put_unaligned_le32(ctrl->dwClockFrequency, &data[26]);
 		data[30] = ctrl->bmFramingInfo;
 		data[31] = ctrl->bPreferedVersion;


