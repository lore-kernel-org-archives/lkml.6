Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2C2C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DB123FDB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S8VQ6XHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DB123FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933493AbeF0Ke6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 06:34:58 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46106 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932587AbeF0Ke4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 06:34:56 -0400
Received: by mail-pf0-f196.google.com with SMTP id q1-v6so772163pff.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 03:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HA7mE/vXDUkNbmGww86M0WLb1ZJKm18WbrqOSBWlOzE=;
        b=S8VQ6XHIGcqt8SNOHSI7mIHt4Rugs7LsT8IwQ1oNZgybJTGS1szHcP081jq9OD3VGe
         irplBYNjPLs8o3HzpMOl4r++GPkY4t6iEHqb9hyAaEUX+oSQR6hAtDJDIG0qR83mI0mA
         cvQ/VY4hzmLq+14g8DFqaTdbKvGlWYgMcOq8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HA7mE/vXDUkNbmGww86M0WLb1ZJKm18WbrqOSBWlOzE=;
        b=UTmQKUvXoSt5uUNXMf2aPI3wXFof2Qveim8OTaV+PVgOoSkoaBuOlsQI9ptZa1gOTG
         TRJ3ctPvatljUPXFRxW+Ijs3yEoRJ2BDCrn0pIJywEICIQfBNt9OU+ujYtEuWcNXJDu1
         LAuQOQyWE8dO4KEZFHp2pdgo/JHVm1/uhDQrEPhzL6zeb3FqGd/97rHrubU1cX5/lSGg
         IAFXosJKVSjYer3Tw+osmQQRmIaC2lrZrIvV9jHRtJvg3q96n0opmkMuzkuKtQg2CH0l
         vEC8oBX9tQbfVA9YqKEyPDx7oTTKLBRH7pL00CH7F3j31SUhHDq+pf1+FHq7PmFgRb6q
         93AA==
X-Gm-Message-State: APt69E204oJjl6yLisVHKdvlXh1LSKfBdcMoBE3dnweHWXQg/dNr3Irz
        lmvOBZfs48+VHftACyCZp9Qm7ckjJRY=
X-Google-Smtp-Source: AAOMgpcF1pC7RivaSbUv0kXJJ84iwsaYzBP4UD+C1AzLNRCSAxawcpiJvV44oEWyEQ7CaNX06ajLiw==
X-Received: by 2002:a62:5486:: with SMTP id i128-v6mr5258279pfb.166.1530095694758;
        Wed, 27 Jun 2018 03:34:54 -0700 (PDT)
Received: from keiichiw1.tok.corp.google.com ([2401:fa00:4:4:968c:de0d:27a3:4bef])
        by smtp.gmail.com with ESMTPSA id j133-v6sm6576663pgc.75.2018.06.27.03.34.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 03:34:53 -0700 (PDT)
From:   Keiichi Watanabe <keiichiw@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, kieran.bingham@ideasonboard.com,
        tfiga@chromium.org, dianders@chromium.org, keiichiw@chromium.org
Subject: [RFC PATCH v1] media: uvcvideo: Cache URB header data before processing
Date:   Wed, 27 Jun 2018 19:34:08 +0900
Message-Id: <20180627103408.33003-1-keiichiw@chromium.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms with non-coherent DMA (e.g. ARM), USB drivers use
uncached memory allocation methods. In such situations, it sometimes
takes a long time to access URB buffers.  This can be a cause of video
flickering problems if a resolution is high and a USB controller has
a very tight time limit. (e.g. dwc2) To avoid this problem, we copy
header data from (uncached) URB buffer into (cached) local buffer.

This change should make the elapsed time of the interrupt handler
shorter on platforms with non-coherent DMA. We measured the elapsed
time of each callback of uvc_video_complete without/with this patch
while capturing Full HD video in
https://webrtc.github.io/samples/src/content/getusermedia/resolution/.
I tested it on the top of Kieran Bingham's Asynchronous UVC series
https://www.mail-archive.com/linux-media@vger.kernel.org/msg128359.html.
The test device was Jerry Chromebook (RK3288) with Logitech Brio 4K.
I collected data for 5 seconds. (There were around 480 callbacks in
this case.) The following result shows that this patch makes
uvc_video_complete about 2x faster.

           | average | median  | min     | max     | standard deviation
w/o caching| 45319ns | 40250ns | 33834ns | 142625ns| 16611ns
w/  caching| 20620ns | 19250ns | 12250ns | 56583ns | 6285ns

In addition, we confirmed that this patch doesn't make it worse on
coherent DMA architecture by performing the same measurements on a
Broadwell Chromebox with the same camera.

           | average | median  | min     | max     | standard deviation
w/o caching| 21026ns | 21424ns | 12263ns | 23956ns | 1932ns
w/  caching| 20728ns | 20398ns |  8922ns | 45120ns | 3368ns

Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
---

After applying 6 patches in
https://www.mail-archive.com/linux-media@vger.kernel.org/msg128359.html,
I measured elapsed time by adding the following code to
/drivers/media/usb/uvc/uvc_video.c

@@ -XXXX,6 +XXXX,9 @@ static void uvc_video_complete(struct urb *urb)
        struct uvc_video_queue *queue = &stream->queue;
 	struct uvc_buffer *buf = NULL;
 	int ret;
+	ktime_t start, end;
+	int elapsed_time;
+	start = ktime_get();
 	switch (urb->status) {
 	case 0:

@@ -XXXX,6 +XXXX,10 @@ static void uvc_video_complete(struct urb *urb)

 	INIT_WORK(&uvc_urb->work, uvc_video_copy_data_work);
 	queue_work(stream->async_wq, &uvc_urb->work);
+
+	end = ktime_get();
+	elapsed_time = ktime_to_ns(ktime_sub(end, start));
+	pr_err("elapsed time: %d ns", elapsed_time);
 }

 /*


 drivers/media/usb/uvc/uvc_video.c | 92 +++++++++++++++----------------
 1 file changed, 43 insertions(+), 49 deletions(-)
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index a88b2e51a666..ff2eddc55530 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -391,36 +391,15 @@ static inline ktime_t uvc_video_get_time(void)

 static void
 uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
-		       const u8 *data, int len)
+		       const u8 *data, int len, unsigned int header_size,
+		       bool has_pts, bool has_scr)
 {
 	struct uvc_clock_sample *sample;
-	unsigned int header_size;
-	bool has_pts = false;
-	bool has_scr = false;
 	unsigned long flags;
 	ktime_t time;
 	u16 host_sof;
 	u16 dev_sof;

-	switch (data[1] & (UVC_STREAM_PTS | UVC_STREAM_SCR)) {
-	case UVC_STREAM_PTS | UVC_STREAM_SCR:
-		header_size = 12;
-		has_pts = true;
-		has_scr = true;
-		break;
-	case UVC_STREAM_PTS:
-		header_size = 6;
-		has_pts = true;
-		break;
-	case UVC_STREAM_SCR:
-		header_size = 8;
-		has_scr = true;
-		break;
-	default:
-		header_size = 2;
-		break;
-	}
-
 	/* Check for invalid headers. */
 	if (len < header_size)
 		return;
@@ -717,11 +696,10 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
  */

 static void uvc_video_stats_decode(struct uvc_streaming *stream,
-		const u8 *data, int len)
+				   const u8 *data, int len,
+				   unsigned int header_size, bool has_pts,
+				   bool has_scr)
 {
-	unsigned int header_size;
-	bool has_pts = false;
-	bool has_scr = false;
 	u16 uninitialized_var(scr_sof);
 	u32 uninitialized_var(scr_stc);
 	u32 uninitialized_var(pts);
@@ -730,25 +708,6 @@ static void uvc_video_stats_decode(struct uvc_streaming *stream,
 	    stream->stats.frame.nb_packets == 0)
 		stream->stats.stream.start_ts = ktime_get();

-	switch (data[1] & (UVC_STREAM_PTS | UVC_STREAM_SCR)) {
-	case UVC_STREAM_PTS | UVC_STREAM_SCR:
-		header_size = 12;
-		has_pts = true;
-		has_scr = true;
-		break;
-	case UVC_STREAM_PTS:
-		header_size = 6;
-		has_pts = true;
-		break;
-	case UVC_STREAM_SCR:
-		header_size = 8;
-		has_scr = true;
-		break;
-	default:
-		header_size = 2;
-		break;
-	}
-
 	/* Check for invalid headers. */
 	if (len < header_size || data[0] < header_size) {
 		stream->stats.frame.nb_invalid++;
@@ -957,10 +916,41 @@ static void uvc_video_stats_stop(struct uvc_streaming *stream)
  * to be called with a NULL buf parameter. uvc_video_decode_data and
  * uvc_video_decode_end will never be called with a NULL buffer.
  */
+static void uvc_video_decode_header_size(const u8 *data, int *header_size,
+					 bool *has_pts, bool *has_scr)
+{
+	switch (data[1] & (UVC_STREAM_PTS | UVC_STREAM_SCR)) {
+	case UVC_STREAM_PTS | UVC_STREAM_SCR:
+		*header_size = 12;
+		*has_pts = true;
+		*has_scr = true;
+		break;
+	case UVC_STREAM_PTS:
+		*header_size = 6;
+		*has_pts = true;
+		break;
+	case UVC_STREAM_SCR:
+		*header_size = 8;
+		*has_scr = true;
+		break;
+	default:
+		*header_size = 2;
+	}
+}
+
 static int uvc_video_decode_start(struct uvc_streaming *stream,
-		struct uvc_buffer *buf, const u8 *data, int len)
+				  struct uvc_buffer *buf, const u8 *urb_data,
+				  int len)
 {
 	u8 fid;
+	u8 data[12];
+	unsigned int header_size;
+	bool has_pts = false, has_scr = false;
+
+	/* Cache the header since urb_data is uncached memory. The size of
+	 * header is at most 12 bytes.
+	 */
+	memcpy(data, urb_data, min(len, 12));

 	/* Sanity checks:
 	 * - packet must be at least 2 bytes long
@@ -983,8 +973,12 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 			uvc_video_stats_update(stream);
 	}

-	uvc_video_clock_decode(stream, buf, data, len);
-	uvc_video_stats_decode(stream, data, len);
+	uvc_video_decode_header_size(data, &header_size, &has_pts, &has_scr);
+
+	uvc_video_clock_decode(stream, buf, data, len, header_size, has_pts,
+			       has_scr);
+	uvc_video_stats_decode(stream, data, len, header_size, has_pts,
+			       has_scr);

 	/* Store the payload FID bit and return immediately when the buffer is
 	 * NULL.
--
2.18.0.rc2.346.g013aa6912e-goog
