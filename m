Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F288C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1BA2214F1
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqoFpsaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1BA2214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391373AbeKLI3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:29:41 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44469 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731327AbeKLI3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:29:41 -0500
Received: by mail-qk1-f196.google.com with SMTP id n12so10454617qkh.11;
        Sun, 11 Nov 2018 14:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ayCkxTSroQcRFBVF+MIBQeWaJVzVErRweizpOr2d3sg=;
        b=NqoFpsaXoGigq0EMhpXMshRju8zyAGJ+9c8oaoXLgas1wwm/jjWj7KMeoNLAry+zXc
         YT3NRzuyKQ8I3G3cIpFou89qhsiNqjYzvubvMeaPLPphjG7dTSOi2TlkvRHwbgyLtIeU
         6EA4ZNGes/eT8iJ4sgYhP/u2RTTr86KuQoHK0xH315mdV4dLBdk4Kz/yn5T+KR8XhYhA
         /xsot57rD38wPgh54Wh9YxvLMHLx8RaMAjRH+GHamDXEPX8V7hlFrAK2DtVtC8DbQgJb
         HDj6bix0Q8jEaGHIUj7hdFqvQKObtknpcuDBUGgt0BQ/QoHk6Q+Mqc9wfN2b4sQa0ofa
         CROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ayCkxTSroQcRFBVF+MIBQeWaJVzVErRweizpOr2d3sg=;
        b=aY558JrzDEblZfcKthLUzfVdRZVNzxpLowRTocsyvBsG7zVZRW0qivDCrRSZRm+Z1n
         QPjp0DRo7puvO5ERvhw+A2JowqDvy60jJg2TMVFLkB8jiaScItKRneKJs/b1pzQjb39L
         Ji8UxLNyR2dFadMsxvCVLhrHcEWu1pHQuTXxUdfQv8+iLXVk0bmgppArnoff78LFCGS+
         l5nWa+MH2L1Qb9QtAtdVJIKpNS+inLaNssGAgp5Bn1wsplF8xIy274d8cHpFFDgZcWmc
         switKcHynz/K+tRyti/qyJPHSiipcou2fJ4ysd2yeiSGgC7fFyMII4wvytq2CUWXVSuY
         kHUA==
X-Gm-Message-State: AGRZ1gJqzp3zeGqyqmw9YcaQwBRjRPDmoMfJnAuBI7+/z/faalF9JEn4
        xVgfm8RaHl0g4NN2iIOHNhQ=
X-Google-Smtp-Source: AJdET5fbFwQ27K7zw3ecNQHoGoWjgr6qzQ7v0MVsi/yTyXn1/pI56WwG479mB/3URCtG4yBwM2uWyA==
X-Received: by 2002:ac8:278a:: with SMTP id w10mr17081104qtw.149.1541975980772;
        Sun, 11 Nov 2018 14:39:40 -0800 (PST)
Received: from gfm-note ([2804:14c:482:ff6:8406:5d12:9a1a:dbc8])
        by smtp.gmail.com with ESMTPSA id 5sm1511167qtw.50.2018.11.11.14.39.39
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Nov 2018 14:39:40 -0800 (PST)
Date:   Sun, 11 Nov 2018 20:39:37 -0200
From:   Gabriel Francisco Mandaji <gfmandaji@gmail.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lkcamp@lists.libreplanetbr.org
Subject: [PATCH v3] media: vivid: Improve timestamping
Message-ID: <20181111223937.GA24963@gfm-note>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simulate a more precise timestamp by calculating it based on the
current framerate.

Signed-off-by: Gabriel Francisco Mandaji <gfmandaji@gmail.com>
---
Changes in v2:
    - fix spelling
    - end of exposure is offset by 90% of the frame period
    - fix timestamp calculation for FIELD_ALTERNATE (untested)
    - timestamp is now calculated and set from vivid_thread_cap_tick()
    - capture vbi uses the same timestamp as non-vbi, but offset by 5%
    - timestamp stays consistent even if the FPS changes
    - tested with dropped frames
Changes in v3:
    - fix calculating offset for 'End of Frame'
    - fix changing 'Timestamp Source' mid-capture
    - change order of operation when calculating the VBI's offset
---
 drivers/media/platform/vivid/vivid-core.h        |  3 ++
 drivers/media/platform/vivid/vivid-kthread-cap.c | 47 +++++++++++++++++-------
 drivers/media/platform/vivid/vivid-vbi-cap.c     |  4 --
 3 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/media/platform/vivid/vivid-core.h b/drivers/media/platform/vivid/vivid-core.h
index 1891254..f7b2a0b 100644
--- a/drivers/media/platform/vivid/vivid-core.h
+++ b/drivers/media/platform/vivid/vivid-core.h
@@ -392,6 +392,9 @@ struct vivid_dev {
 	/* thread for generating video capture stream */
 	struct task_struct		*kthread_vid_cap;
 	unsigned long			jiffies_vid_cap;
+	u64				cap_stream_start;
+	u64				cap_frame_period;
+	u64				cap_frame_eof_offset;
 	u32				cap_seq_offset;
 	u32				cap_seq_count;
 	bool				cap_seq_resync;
diff --git a/drivers/media/platform/vivid/vivid-kthread-cap.c b/drivers/media/platform/vivid/vivid-kthread-cap.c
index eebfff2..f97cb6a 100644
--- a/drivers/media/platform/vivid/vivid-kthread-cap.c
+++ b/drivers/media/platform/vivid/vivid-kthread-cap.c
@@ -425,12 +425,6 @@ static void vivid_fillbuff(struct vivid_dev *dev, struct vivid_buffer *buf)
 		is_loop = true;
 
 	buf->vb.sequence = dev->vid_cap_seq_count;
-	/*
-	 * Take the timestamp now if the timestamp source is set to
-	 * "Start of Exposure".
-	 */
-	if (dev->tstamp_src_is_soe)
-		buf->vb.vb2_buf.timestamp = ktime_get_ns();
 	if (dev->field_cap == V4L2_FIELD_ALTERNATE) {
 		/*
 		 * 60 Hz standards start with the bottom field, 50 Hz standards
@@ -554,14 +548,6 @@ static void vivid_fillbuff(struct vivid_dev *dev, struct vivid_buffer *buf)
 			}
 		}
 	}
-
-	/*
-	 * If "End of Frame" is specified at the timestamp source, then take
-	 * the timestamp now.
-	 */
-	if (!dev->tstamp_src_is_soe)
-		buf->vb.vb2_buf.timestamp = ktime_get_ns();
-	buf->vb.vb2_buf.timestamp += dev->time_wrap_offset;
 }
 
 /*
@@ -667,10 +653,25 @@ static void vivid_overlay(struct vivid_dev *dev, struct vivid_buffer *buf)
 	}
 }
 
+static void vivid_cap_update_frame_period(struct vivid_dev *dev)
+{
+	u64 f_period = dev->timeperframe_vid_cap.numerator * 1000000000 /
+		       dev->timeperframe_vid_cap.denominator;
+	if (dev->field_cap == V4L2_FIELD_ALTERNATE)
+		f_period /= 2;
+	/*
+	 * If "End of Frame", then offset the exposure time by 0.9
+	 * of the frame period.
+	 */
+	dev->cap_frame_eof_offset = f_period * 9 / 10;
+	dev->cap_frame_period = f_period;
+}
+
 static void vivid_thread_vid_cap_tick(struct vivid_dev *dev, int dropped_bufs)
 {
 	struct vivid_buffer *vid_cap_buf = NULL;
 	struct vivid_buffer *vbi_cap_buf = NULL;
+	u64 f_time = 0;
 
 	dprintk(dev, 1, "Video Capture Thread Tick\n");
 
@@ -702,6 +703,11 @@ static void vivid_thread_vid_cap_tick(struct vivid_dev *dev, int dropped_bufs)
 	if (!vid_cap_buf && !vbi_cap_buf)
 		goto update_mv;
 
+	f_time = dev->cap_frame_period * dev->vid_cap_seq_count +
+		 dev->cap_stream_start + dev->time_wrap_offset;
+	if (!dev->tstamp_src_is_soe)
+		f_time += dev->cap_frame_eof_offset;
+
 	if (vid_cap_buf) {
 		v4l2_ctrl_request_setup(vid_cap_buf->vb.vb2_buf.req_obj.req,
 					&dev->ctrl_hdl_vid_cap);
@@ -721,9 +727,13 @@ static void vivid_thread_vid_cap_tick(struct vivid_dev *dev, int dropped_bufs)
 				VB2_BUF_STATE_ERROR : VB2_BUF_STATE_DONE);
 		dprintk(dev, 2, "vid_cap buffer %d done\n",
 				vid_cap_buf->vb.vb2_buf.index);
+
+		vid_cap_buf->vb.vb2_buf.timestamp = f_time;
 	}
 
 	if (vbi_cap_buf) {
+		u64 vbi_period;
+
 		v4l2_ctrl_request_setup(vbi_cap_buf->vb.vb2_buf.req_obj.req,
 					&dev->ctrl_hdl_vbi_cap);
 		if (dev->stream_sliced_vbi_cap)
@@ -736,6 +746,10 @@ static void vivid_thread_vid_cap_tick(struct vivid_dev *dev, int dropped_bufs)
 				VB2_BUF_STATE_ERROR : VB2_BUF_STATE_DONE);
 		dprintk(dev, 2, "vbi_cap %d done\n",
 				vbi_cap_buf->vb.vb2_buf.index);
+
+		/* If capturing a VBI, offset by 0.05 */
+		vbi_period = dev->cap_frame_period * 5 / 100;
+		vbi_cap_buf->vb.vb2_buf.timestamp = f_time + vbi_period;
 	}
 	dev->dqbuf_error = false;
 
@@ -767,6 +781,8 @@ static int vivid_thread_vid_cap(void *data)
 	dev->cap_seq_count = 0;
 	dev->cap_seq_resync = false;
 	dev->jiffies_vid_cap = jiffies;
+	dev->cap_stream_start = ktime_get_ns();
+	vivid_cap_update_frame_period(dev);
 
 	for (;;) {
 		try_to_freeze();
@@ -779,6 +795,9 @@ static int vivid_thread_vid_cap(void *data)
 			dev->jiffies_vid_cap = cur_jiffies;
 			dev->cap_seq_offset = dev->cap_seq_count + 1;
 			dev->cap_seq_count = 0;
+			dev->cap_stream_start += dev->cap_frame_period *
+						 dev->cap_seq_offset;
+			vivid_cap_update_frame_period(dev);
 			dev->cap_seq_resync = false;
 		}
 		numerator = dev->timeperframe_vid_cap.numerator;
diff --git a/drivers/media/platform/vivid/vivid-vbi-cap.c b/drivers/media/platform/vivid/vivid-vbi-cap.c
index 903cebe..17aa4b0 100644
--- a/drivers/media/platform/vivid/vivid-vbi-cap.c
+++ b/drivers/media/platform/vivid/vivid-vbi-cap.c
@@ -95,8 +95,6 @@ void vivid_raw_vbi_cap_process(struct vivid_dev *dev, struct vivid_buffer *buf)
 
 	if (!VIVID_INVALID_SIGNAL(dev->std_signal_mode))
 		vivid_vbi_gen_raw(&dev->vbi_gen, &vbi, vbuf);
-
-	buf->vb.vb2_buf.timestamp = ktime_get_ns() + dev->time_wrap_offset;
 }
 
 
@@ -119,8 +117,6 @@ void vivid_sliced_vbi_cap_process(struct vivid_dev *dev,
 		for (i = 0; i < 25; i++)
 			vbuf[i] = dev->vbi_gen.data[i];
 	}
-
-	buf->vb.vb2_buf.timestamp = ktime_get_ns() + dev->time_wrap_offset;
 }
 
 static int vbi_cap_queue_setup(struct vb2_queue *vq,
-- 
1.9.1

