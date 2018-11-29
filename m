Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB42C04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F90C20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F90C20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbeK2UGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:06:30 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34635 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbeK2UGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 15:06:30 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 64BAD20CFA; Thu, 29 Nov 2018 10:01:49 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id 08003209AB;
        Thu, 29 Nov 2018 10:01:39 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v2 1/1] media: cedrus: Remove global IRQ spin lock from the driver
Date:   Thu, 29 Nov 2018 10:00:48 +0100
Message-Id: <20181129090048.16482-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181129090048.16482-1-paul.kocialkowski@bootlin.com>
References: <20181129090048.16482-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We initially introduced a spin lock to ensure that the VPU registers
are not accessed concurrently between our setup function and IRQ
handler. The V4L2 M2M API ensures that only one decoding job runs at a
time, so the interrupt signaling the end of decoding will not occur
while the next picture is being configured.

Spurious interrupts are taken care of in the handler, by checking that
we have a valid M2M context and a decoding status available before
marking the buffers as done.

In addition, holding a spin lock could be problematic if non-atomic
operations are required in the setup process for future codec support.

As a result, remove the global IRQ spin lock.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c       |  1 -
 drivers/staging/media/sunxi/cedrus/cedrus.h       |  2 --
 drivers/staging/media/sunxi/cedrus/cedrus_dec.c   |  9 ---------
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c    | 13 +------------
 drivers/staging/media/sunxi/cedrus/cedrus_video.c |  5 -----
 5 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index f7f46fbc2bcf..928edc01bc46 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -281,7 +281,6 @@ static int cedrus_probe(struct platform_device *pdev)
 	dev->dec_ops[CEDRUS_CODEC_MPEG2] = &cedrus_dec_ops_mpeg2;
 
 	mutex_init(&dev->dev_mutex);
-	spin_lock_init(&dev->irq_lock);
 
 	ret = v4l2_device_register(&pdev->dev, &dev->v4l2_dev);
 	if (ret) {
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/staging/media/sunxi/cedrus/cedrus.h
index 3f61248c57ac..3acfdcf83691 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
@@ -105,8 +105,6 @@ struct cedrus_dev {
 
 	/* Device file mutex */
 	struct mutex		dev_mutex;
-	/* Interrupt spinlock */
-	spinlock_t		irq_lock;
 
 	void __iomem		*base;
 
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
index e40180a33951..6c5e310a7cf7 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
@@ -28,7 +28,6 @@ void cedrus_device_run(void *priv)
 	struct cedrus_dev *dev = ctx->dev;
 	struct cedrus_run run = { 0 };
 	struct media_request *src_req;
-	unsigned long flags;
 
 	run.src = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
 	run.dst = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
@@ -39,8 +38,6 @@ void cedrus_device_run(void *priv)
 	if (src_req)
 		v4l2_ctrl_request_setup(src_req, &ctx->hdl);
 
-	spin_lock_irqsave(&ctx->dev->irq_lock, flags);
-
 	switch (ctx->src_fmt.pixelformat) {
 	case V4L2_PIX_FMT_MPEG2_SLICE:
 		run.mpeg2.slice_params = cedrus_find_control_data(ctx,
@@ -55,16 +52,10 @@ void cedrus_device_run(void *priv)
 
 	dev->dec_ops[ctx->current_codec]->setup(ctx, &run);
 
-	spin_unlock_irqrestore(&ctx->dev->irq_lock, flags);
-
 	/* Complete request(s) controls if needed. */
 
 	if (src_req)
 		v4l2_ctrl_request_complete(src_req, &ctx->hdl);
 
-	spin_lock_irqsave(&ctx->dev->irq_lock, flags);
-
 	dev->dec_ops[ctx->current_codec]->trigger(ctx);
-
-	spin_unlock_irqrestore(&ctx->dev->irq_lock, flags);
 }
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
index 32adbcbe6175..0662906aab57 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
@@ -122,24 +122,17 @@ static irqreturn_t cedrus_irq(int irq, void *data)
 	struct vb2_v4l2_buffer *src_buf, *dst_buf;
 	enum vb2_buffer_state state;
 	enum cedrus_irq_status status;
-	unsigned long flags;
-
-	spin_lock_irqsave(&dev->irq_lock, flags);
 
 	ctx = v4l2_m2m_get_curr_priv(dev->m2m_dev);
 	if (!ctx) {
 		v4l2_err(&dev->v4l2_dev,
 			 "Instance released before the end of transaction\n");
-		spin_unlock_irqrestore(&dev->irq_lock, flags);
-
 		return IRQ_NONE;
 	}
 
 	status = dev->dec_ops[ctx->current_codec]->irq_status(ctx);
-	if (status == CEDRUS_IRQ_NONE) {
-		spin_unlock_irqrestore(&dev->irq_lock, flags);
+	if (status == CEDRUS_IRQ_NONE)
 		return IRQ_NONE;
-	}
 
 	dev->dec_ops[ctx->current_codec]->irq_disable(ctx);
 	dev->dec_ops[ctx->current_codec]->irq_clear(ctx);
@@ -150,8 +143,6 @@ static irqreturn_t cedrus_irq(int irq, void *data)
 	if (!src_buf || !dst_buf) {
 		v4l2_err(&dev->v4l2_dev,
 			 "Missing source and/or destination buffers\n");
-		spin_unlock_irqrestore(&dev->irq_lock, flags);
-
 		return IRQ_HANDLED;
 	}
 
@@ -163,8 +154,6 @@ static irqreturn_t cedrus_irq(int irq, void *data)
 	v4l2_m2m_buf_done(src_buf, state);
 	v4l2_m2m_buf_done(dst_buf, state);
 
-	spin_unlock_irqrestore(&dev->irq_lock, flags);
-
 	return IRQ_WAKE_THREAD;
 }
 
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_video.c b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
index 5c5fce678b93..8721b4a7d496 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_video.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
@@ -380,18 +380,13 @@ static void cedrus_queue_cleanup(struct vb2_queue *vq, u32 state)
 {
 	struct cedrus_ctx *ctx = vb2_get_drv_priv(vq);
 	struct vb2_v4l2_buffer *vbuf;
-	unsigned long flags;
 
 	for (;;) {
-		spin_lock_irqsave(&ctx->dev->irq_lock, flags);
-
 		if (V4L2_TYPE_IS_OUTPUT(vq->type))
 			vbuf = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
 		else
 			vbuf = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
 
-		spin_unlock_irqrestore(&ctx->dev->irq_lock, flags);
-
 		if (!vbuf)
 			return;
 
-- 
2.19.1

