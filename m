Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12614C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 13:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B802620673
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 13:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYWoWyaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B802620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbeLBNpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 08:45:46 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43219 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeLBNpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 08:45:45 -0500
Received: by mail-qt1-f196.google.com with SMTP id i7so10926953qtj.10;
        Sun, 02 Dec 2018 05:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=iobg/h/4DxV5oE3KRSEqtE4+YURzS8XvkzWqOAdLLvQ=;
        b=TYWoWyaIUPqJ9DuyKzFJ+uOT7DjCUKm1eVQjVBtVtwsBhPcUEn/LQmRe5z179GJaIe
         YARVBb9DDAQeQ8+Pf5mtSZG8ZesoM+oybQegMOsPaldGA9BdfQgo8Z+H4lk6u6XT4H8R
         wmT8ofweeFYx1fXw7Ztyo6zBvoeHo6GQ5G7Oim/kFQ5hoH8K+Rns1RdCD37v/gEcShTZ
         iaqUZgheMhmvge7KJ/TCbT91+1m9VvgDq3R5LkMlZq55IDyU3tqn52XYRq3NlIdAvOLj
         3fDWxZQTKWE7F35QhF2hxM+o7jGjKrSr90FkRMfgSGpmXQfGhiZKUY5tiAsXpqUV1aVJ
         d6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=iobg/h/4DxV5oE3KRSEqtE4+YURzS8XvkzWqOAdLLvQ=;
        b=jVHZVCl0eZqbr/5pWwMCcYOca2Tc97tE+4HmvFPFBAnxwuvJPErWUFywQEKfixoF8A
         6tb3pQdRexGLTrTzWUeVEXrxHBCWnZUBSGGP2uMqFPB6WHl99boM2eUsOL6boxPnRmzk
         dkeXjJbVL5CmjQaffOxL+O+aU0Q5MiETyMIxyN/y2eud26h+fCoiaUeYH90uE+VBp27U
         jpL4cTz8iqteEcLOA+m9X7Quj1tXgX/VA1favamIlexLFvcR+DO1GZ2PjXPZwp6m6+GD
         ES3cfTBCzx7QO7XZgqKaYw7fptPBXNHBc39/cMpL6YNGsukR1JlTMzvtq4vskUAk1Iq9
         D9KQ==
X-Gm-Message-State: AA+aEWau/uEgSqbKuMCdM6FOTpfyPuENFT4+Ppmb4qSz20C4TuljW1wW
        1MfZ8e7FGmdZU/SSFoxYaBU=
X-Google-Smtp-Source: AFSGD/U/aMVshbUFKj7grfic6xl+6DhOMwBoTjqgv7m+VsqOmvg+Y2ZD0QOUZVqD7lykj/BiBaYEjw==
X-Received: by 2002:ac8:32dc:: with SMTP id a28mr12433560qtb.41.1543758341767;
        Sun, 02 Dec 2018 05:45:41 -0800 (PST)
Received: from gfm-note ([2804:14c:482:ff6:c8b0:e1bc:15cc:5411])
        by smtp.gmail.com with ESMTPSA id 190sm5287284qkh.25.2018.12.02.05.45.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Dec 2018 05:45:41 -0800 (PST)
Date:   Sun, 2 Dec 2018 11:45:38 -0200
From:   Gabriel Francisco Mandaji <gfmandaji@gmail.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lkcamp@lists.libreplanetbr.org
Subject: [PATCH v4] media: vivid: Improve timestamping
Message-ID: <20181202134538.GA18886@gfm-note>
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
Changes in v4:
    - fix calculations with 64 bit values
---
 drivers/media/platform/vivid/vivid-core.h        |  3 ++
 drivers/media/platform/vivid/vivid-kthread-cap.c | 51 +++++++++++++++++-------
 drivers/media/platform/vivid/vivid-vbi-cap.c     |  4 --
 3 files changed, 40 insertions(+), 18 deletions(-)

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
index 46e46e3..91c7c67 100644
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
@@ -667,10 +653,28 @@ static void vivid_overlay(struct vivid_dev *dev, struct vivid_buffer *buf)
 	}
 }
 
+static void vivid_cap_update_frame_period(struct vivid_dev *dev)
+{
+	u64 f_period;
+
+	f_period = (u64)dev->timeperframe_vid_cap.numerator * 1000000000;
+	do_div(f_period, dev->timeperframe_vid_cap.denominator);
+	if (dev->field_cap == V4L2_FIELD_ALTERNATE)
+		do_div(f_period, 2);
+	/*
+	 * If "End of Frame", then offset the exposure time by 0.9
+	 * of the frame period.
+	 */
+	dev->cap_frame_eof_offset = f_period * 9;
+	do_div(dev->cap_frame_eof_offset, 10);
+	dev->cap_frame_period = f_period;
+}
+
 static void vivid_thread_vid_cap_tick(struct vivid_dev *dev, int dropped_bufs)
 {
 	struct vivid_buffer *vid_cap_buf = NULL;
 	struct vivid_buffer *vbi_cap_buf = NULL;
+	u64 f_time = 0;
 
 	dprintk(dev, 1, "Video Capture Thread Tick\n");
 
@@ -702,6 +706,11 @@ static void vivid_thread_vid_cap_tick(struct vivid_dev *dev, int dropped_bufs)
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
@@ -721,9 +730,13 @@ static void vivid_thread_vid_cap_tick(struct vivid_dev *dev, int dropped_bufs)
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
@@ -736,6 +749,11 @@ static void vivid_thread_vid_cap_tick(struct vivid_dev *dev, int dropped_bufs)
 				VB2_BUF_STATE_ERROR : VB2_BUF_STATE_DONE);
 		dprintk(dev, 2, "vbi_cap %d done\n",
 				vbi_cap_buf->vb.vb2_buf.index);
+
+		/* If capturing a VBI, offset by 0.05 */
+		vbi_period = dev->cap_frame_period * 5;
+		do_div(vbi_period, 100);
+		vbi_cap_buf->vb.vb2_buf.timestamp = f_time + vbi_period;
 	}
 	dev->dqbuf_error = false;
 
@@ -767,6 +785,8 @@ static int vivid_thread_vid_cap(void *data)
 	dev->cap_seq_count = 0;
 	dev->cap_seq_resync = false;
 	dev->jiffies_vid_cap = jiffies;
+	dev->cap_stream_start = ktime_get_ns();
+	vivid_cap_update_frame_period(dev);
 
 	for (;;) {
 		try_to_freeze();
@@ -779,6 +799,9 @@ static int vivid_thread_vid_cap(void *data)
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

