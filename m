Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07740ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 23:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9864220652
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 23:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgeWf343"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9864220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbeJVHQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 03:16:29 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:32994 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbeJVHQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 03:16:29 -0400
Received: by mail-qk1-f196.google.com with SMTP id o89so520026qko.0;
        Sun, 21 Oct 2018 16:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=HAKf361b0KxazQQubFIdtrsGmXLxBmfp3brFA2/eyh8=;
        b=cgeWf343T0BvB4aOt7AmRUaoffmUJGxSNLqxVcQ93mkgQMDhmiwlbKwsNxVSbnzCZq
         VnaEWNa/LB1VcBw0tP47iJZ4FpmHUcqExi4/aNfjFm6izUEVArmCYwfyPw6t1Mov+Yly
         HHt44fEyJseVsrdp8aaKFIDMZGL6xxBsmf5NEHkWMXCz+zp+nTTXbknOYBjCVeO/+2LD
         Pe6H8N5bB8pKj2qX8JmPeddZbjghVge4Cla3csKc5ilZc49LTiDLven9awfIabaS6gAK
         MWTZ+MqQHDP6L5CFVM+3EBKU+XfPJO/BZrn88WPe7BQ15TmHasPG9d0IlQKIG17JI917
         MSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HAKf361b0KxazQQubFIdtrsGmXLxBmfp3brFA2/eyh8=;
        b=Xx5Z+uRPKlzzrNOyPoisdtqjEJnRaLdaI58v1PrGSbu7U3AGtIQort7O48Dld4Ut7G
         iXU5qIbDBaSgzv6rqd18YcRPZby8VFymD0c2CC7AFCU0eMeGPrvDv4DcmoxSXbLIaI9r
         TIwMBIV4+8t7XAE7OsuyEXKcPhowQhPw/lZVKJQzyTKSzuUvHB3B0kzxE9cyApFRv6+l
         Ma+vR3IWNO89lRmmI9jK9jSCkzxc2JLoNOzPNUCVvea1qefW6ilpOtVpeI7CDbISvpga
         QkpR6k+H64HYft4cM0wb7wTcNxa5PI8gQRY+Kt9mtLOqz9MFM9AKCjaqszE56ka7PbU1
         5mxw==
X-Gm-Message-State: ABuFfoiG5gMVwIHuL8N9t8/u6+9g17IaX51RO5Jmf7GXvTj+Y1/1HG4k
        B+fJ1Xe7ogqCEAPPD6Ewn/I=
X-Google-Smtp-Source: ACcGV61joaYDx+oKLYzJo33c9okIfmxxhHPdfnp9dDweiop6dVhnpwhup2pL/X5ollJMv9d45c6pbg==
X-Received: by 2002:a37:3094:: with SMTP id w142-v6mr21104609qkw.131.1540162830414;
        Sun, 21 Oct 2018 16:00:30 -0700 (PDT)
Received: from gfm-note ([2804:14c:482:ff6:8dfd:493a:5bd4:d6b9])
        by smtp.gmail.com with ESMTPSA id f44-v6sm27240490qtc.42.2018.10.21.16.00.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Oct 2018 16:00:29 -0700 (PDT)
Date:   Sun, 21 Oct 2018 21:00:26 -0200
From:   Gabriel Francisco Mandaji <gfmandaji@gmail.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lkcamp@lists.libreplanetbr.org
Subject: [PATCH v2] media: vivid: Improve timestamping
Message-ID: <20181021230026.GA19458@gfm-note>
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

If 'Start of Exposure'/'End of Frame' changes mid-capture, it will be
completely ignored. If that's an issue, I'll change how the frame
period and cap_stream_start are calculated.

Also, should I modify the output's timestamp on this patch or on a
separated one?
---
 drivers/media/platform/vivid/vivid-core.h        |  2 +
 drivers/media/platform/vivid/vivid-kthread-cap.c | 47 +++++++++++++++++-------
 drivers/media/platform/vivid/vivid-vbi-cap.c     |  4 --
 3 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/media/platform/vivid/vivid-core.h b/drivers/media/platform/vivid/vivid-core.h
index cd4c823..ba6fb3a 100644
--- a/drivers/media/platform/vivid/vivid-core.h
+++ b/drivers/media/platform/vivid/vivid-core.h
@@ -384,6 +384,8 @@ struct vivid_dev {
 	/* thread for generating video capture stream */
 	struct task_struct		*kthread_vid_cap;
 	unsigned long			jiffies_vid_cap;
+	u64				cap_stream_start;
+	u64				cap_frame_period;
 	u32				cap_seq_offset;
 	u32				cap_seq_count;
 	bool				cap_seq_resync;
diff --git a/drivers/media/platform/vivid/vivid-kthread-cap.c b/drivers/media/platform/vivid/vivid-kthread-cap.c
index f06003b..828a58c 100644
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
@@ -667,10 +653,27 @@ static void vivid_overlay(struct vivid_dev *dev, struct vivid_buffer *buf)
 	}
 }
 
+static void vivid_cap_update_frame_period(struct vivid_dev *dev)
+{
+	u64 f_period = dev->timeperframe_vid_cap.numerator * 1000000000 /
+		       dev->timeperframe_vid_cap.denominator;
+	if (dev->field_cap == V4L2_FIELD_ALTERNATE)
+		f_period /= 2;
+	/*
+	 * If "End of Frame", then calculate the exposure time as 0.9
+	 * of the frame period.
+	 */
+	if (!dev->tstamp_src_is_soe)
+		f_period += f_period / 10 * 9;
+
+	dev->cap_frame_period = f_period;
+}
+
 static void vivid_thread_vid_cap_tick(struct vivid_dev *dev, int dropped_bufs)
 {
 	struct vivid_buffer *vid_cap_buf = NULL;
 	struct vivid_buffer *vbi_cap_buf = NULL;
+	u64 f_time = 0;
 
 	dprintk(dev, 1, "Video Capture Thread Tick\n");
 
@@ -702,6 +705,9 @@ static void vivid_thread_vid_cap_tick(struct vivid_dev *dev, int dropped_bufs)
 	if (!vid_cap_buf && !vbi_cap_buf)
 		goto update_mv;
 
+	f_time = dev->cap_frame_period * dev->vid_cap_seq_count +
+		 dev->cap_stream_start + dev->time_wrap_offset;
+
 	if (vid_cap_buf) {
 		/* Fill buffer */
 		vivid_fillbuff(dev, vid_cap_buf);
@@ -717,9 +723,13 @@ static void vivid_thread_vid_cap_tick(struct vivid_dev *dev, int dropped_bufs)
 				VB2_BUF_STATE_ERROR : VB2_BUF_STATE_DONE);
 		dprintk(dev, 2, "vid_cap buffer %d done\n",
 				vid_cap_buf->vb.vb2_buf.index);
+
+		vid_cap_buf->vb.vb2_buf.timestamp = f_time;
 	}
 
 	if (vbi_cap_buf) {
+		u64 vbi_period;
+
 		if (dev->stream_sliced_vbi_cap)
 			vivid_sliced_vbi_cap_process(dev, vbi_cap_buf);
 		else
@@ -728,6 +738,10 @@ static void vivid_thread_vid_cap_tick(struct vivid_dev *dev, int dropped_bufs)
 				VB2_BUF_STATE_ERROR : VB2_BUF_STATE_DONE);
 		dprintk(dev, 2, "vbi_cap %d done\n",
 				vbi_cap_buf->vb.vb2_buf.index);
+
+		/* If capturing a VBI, offset by 0.05 */
+		vbi_period = dev->cap_frame_period / 100 * 5;
+		vbi_cap_buf->vb.vb2_buf.timestamp = f_time + vbi_period;
 	}
 	dev->dqbuf_error = false;
 
@@ -759,6 +773,8 @@ static int vivid_thread_vid_cap(void *data)
 	dev->cap_seq_count = 0;
 	dev->cap_seq_resync = false;
 	dev->jiffies_vid_cap = jiffies;
+	dev->cap_stream_start = ktime_get_ns();
+	vivid_cap_update_frame_period(dev);
 
 	for (;;) {
 		try_to_freeze();
@@ -771,6 +787,9 @@ static int vivid_thread_vid_cap(void *data)
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
index 92a8529..c7cacc6 100644
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

