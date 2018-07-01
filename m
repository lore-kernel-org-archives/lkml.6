Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB37C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920BD25716
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920BD25716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934233AbeGARm7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:42:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35698 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031019AbeGAQex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:34:53 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 727CD92B;
        Sun,  1 Jul 2018 16:34:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.14 126/157] media: vsp1: Release buffers for each video node
Date:   Sun,  1 Jul 2018 18:23:18 +0200
Message-Id: <20180701160859.198671805@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

commit 83967993f2320575c0ab27a80bf1d7535909c2f4 upstream.

Commit 372b2b0399fc ("media: v4l: vsp1: Release buffers in
start_streaming error path") introduced a helper to clean up buffers on
error paths, but inadvertently changed the code such that only the
output WPF buffers were cleaned, rather than the video node being
operated on.

Since then vsp1_video_cleanup_pipeline() has grown to perform both video
node cleanup, as well as pipeline cleanup. Split the implementation into
two distinct functions that perform the required work, so that each
video node can release its buffers correctly on streamoff. The pipe
cleanup that was performed in the vsp1_video_stop_streaming() (releasing
the pipe->dl) is moved to the function for clarity.

Fixes: 372b2b0399fc ("media: v4l: vsp1: Release buffers in start_streaming error path")

Cc: stable@vger.kernel.org # v4.14+
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/vsp1/vsp1_video.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

--- a/drivers/media/platform/vsp1/vsp1_video.c
+++ b/drivers/media/platform/vsp1/vsp1_video.c
@@ -849,9 +849,8 @@ static int vsp1_video_setup_pipeline(str
 	return 0;
 }
 
-static void vsp1_video_cleanup_pipeline(struct vsp1_pipeline *pipe)
+static void vsp1_video_release_buffers(struct vsp1_video *video)
 {
-	struct vsp1_video *video = pipe->output->video;
 	struct vsp1_vb2_buffer *buffer;
 	unsigned long flags;
 
@@ -861,12 +860,18 @@ static void vsp1_video_cleanup_pipeline(
 		vb2_buffer_done(&buffer->buf.vb2_buf, VB2_BUF_STATE_ERROR);
 	INIT_LIST_HEAD(&video->irqqueue);
 	spin_unlock_irqrestore(&video->irqlock, flags);
+}
+
+static void vsp1_video_cleanup_pipeline(struct vsp1_pipeline *pipe)
+{
+	lockdep_assert_held(&pipe->lock);
 
 	/* Release our partition table allocation */
-	mutex_lock(&pipe->lock);
 	kfree(pipe->part_table);
 	pipe->part_table = NULL;
-	mutex_unlock(&pipe->lock);
+
+	vsp1_dl_list_put(pipe->dl);
+	pipe->dl = NULL;
 }
 
 static int vsp1_video_start_streaming(struct vb2_queue *vq, unsigned int count)
@@ -881,8 +886,9 @@ static int vsp1_video_start_streaming(st
 	if (pipe->stream_count == pipe->num_inputs) {
 		ret = vsp1_video_setup_pipeline(pipe);
 		if (ret < 0) {
-			mutex_unlock(&pipe->lock);
+			vsp1_video_release_buffers(video);
 			vsp1_video_cleanup_pipeline(pipe);
+			mutex_unlock(&pipe->lock);
 			return ret;
 		}
 
@@ -932,13 +938,12 @@ static void vsp1_video_stop_streaming(st
 		if (ret == -ETIMEDOUT)
 			dev_err(video->vsp1->dev, "pipeline stop timeout\n");
 
-		vsp1_dl_list_put(pipe->dl);
-		pipe->dl = NULL;
+		vsp1_video_cleanup_pipeline(pipe);
 	}
 	mutex_unlock(&pipe->lock);
 
 	media_pipeline_stop(&video->video.entity);
-	vsp1_video_cleanup_pipeline(pipe);
+	vsp1_video_release_buffers(video);
 	vsp1_video_pipeline_put(pipe);
 }
 


