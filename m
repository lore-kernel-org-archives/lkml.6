Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868BDC43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5235220869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5235220869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbeKLG22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:28:28 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49592 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729999AbeKLFsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:08 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsT-0000lK-BR; Sun, 11 Nov 2018 19:58:37 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsQ-0001UA-Fi; Sun, 11 Nov 2018 19:58:34 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "ming_qian" <ming_qian@realsil.com.cn>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        "Ana Guerrero Lopez" <ana.guerrero@collabora.com>,
        "Kai-Heng Feng" <kai.heng.feng@canonical.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.111363442@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 092/366] media: uvcvideo: Support realtek's UVC 1.5
 device
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

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

Signed-off-by: ming_qian <ming_qian@realsil.com.cn>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Tested-by: Ana Guerrero Lopez <ana.guerrero@collabora.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/usb/uvc/uvc_video.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -155,14 +155,27 @@ static void uvc_fixup_video_ctrl(struct
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
+	u16 size = uvc_video_ctrl_size(stream);
 	__u8 *data;
-	__u16 size;
 	int ret;
 
-	size = stream->dev->uvc_version >= 0x0110 ? 34 : 26;
 	if ((stream->dev->quirks & UVC_QUIRK_PROBE_DEF) &&
 			query == UVC_GET_DEF)
 		return -EIO;
@@ -217,7 +230,7 @@ static int uvc_get_video_ctrl(struct uvc
 	ctrl->dwMaxVideoFrameSize = get_unaligned_le32(&data[18]);
 	ctrl->dwMaxPayloadTransferSize = get_unaligned_le32(&data[22]);
 
-	if (size == 34) {
+	if (size >= 34) {
 		ctrl->dwClockFrequency = get_unaligned_le32(&data[26]);
 		ctrl->bmFramingInfo = data[30];
 		ctrl->bPreferedVersion = data[31];
@@ -246,11 +259,10 @@ out:
 static int uvc_set_video_ctrl(struct uvc_streaming *stream,
 	struct uvc_streaming_control *ctrl, int probe)
 {
+	u16 size = uvc_video_ctrl_size(stream);
 	__u8 *data;
-	__u16 size;
 	int ret;
 
-	size = stream->dev->uvc_version >= 0x0110 ? 34 : 26;
 	data = kzalloc(size, GFP_KERNEL);
 	if (data == NULL)
 		return -ENOMEM;
@@ -267,7 +279,7 @@ static int uvc_set_video_ctrl(struct uvc
 	put_unaligned_le32(ctrl->dwMaxVideoFrameSize, &data[18]);
 	put_unaligned_le32(ctrl->dwMaxPayloadTransferSize, &data[22]);
 
-	if (size == 34) {
+	if (size >= 34) {
 		put_unaligned_le32(ctrl->dwClockFrequency, &data[26]);
 		data[30] = ctrl->bmFramingInfo;
 		data[31] = ctrl->bPreferedVersion;

