Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D71DFC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97254208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97254208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935901AbeFMOJW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:09:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52367 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935781AbeFMOHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:07:20 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8544220A32; Wed, 13 Jun 2018 16:07:18 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-37-30.w90-88.abo.wanadoo.fr [90.88.156.30])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5A2DE20728;
        Wed, 13 Jun 2018 16:07:18 +0200 (CEST)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     hans.verkuil@cisco.com, acourbot@chromium.org,
        sakari.ailus@linux.intel.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     tfiga@chromium.org, posciak@chromium.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        nicolas.dufresne@collabora.com, jenskuske@gmail.com,
        linux-sunxi@googlegroups.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 5/9] media: cedrus: Remove MPEG1 support
Date:   Wed, 13 Jun 2018 16:07:10 +0200
Message-Id: <20180613140714.1686-6-maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180613140714.1686-1-maxime.ripard@bootlin.com>
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MPEG1 codec is obsolete, and that code hasn't been tested either. Since
it stands in the way of further refactoring, remove it entirely.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/media/platform/sunxi/cedrus/sunxi_cedrus_dec.c   | 4 +---
 drivers/media/platform/sunxi/cedrus/sunxi_cedrus_mpeg2.c | 8 ++------
 drivers/media/platform/sunxi/cedrus/sunxi_cedrus_mpeg2.h | 2 +-
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_dec.c b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_dec.c
index c19acf9626c4..f274408ab5a7 100644
--- a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_dec.c
+++ b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_dec.c
@@ -80,7 +80,6 @@ void sunxi_cedrus_device_run(void *priv)
 	struct sunxi_cedrus_run run = { 0 };
 	struct media_request *src_req, *dst_req;
 	unsigned long flags;
-	bool mpeg1 = false;
 
 	run.src = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
 	if (!run.src) {
@@ -123,7 +122,6 @@ void sunxi_cedrus_device_run(void *priv)
 		run.mpeg2.hdr = get_ctrl_ptr(ctx, SUNXI_CEDRUS_CTRL_DEC_MPEG2_FRAME_HDR);
 		sunxi_cedrus_mpeg2_setup(ctx, &run);
 
-		mpeg1 = run.mpeg2.hdr->type == MPEG1;
 		break;
 
 	default:
@@ -146,7 +144,7 @@ void sunxi_cedrus_device_run(void *priv)
 
 	if (!ctx->job_abort) {
 		if (ctx->vpu_src_fmt->fourcc == V4L2_PIX_FMT_MPEG2_FRAME)
-			sunxi_cedrus_mpeg2_trigger(ctx, mpeg1);
+			sunxi_cedrus_mpeg2_trigger(ctx);
 	} else {
 		v4l2_m2m_buf_done(run.src, VB2_BUF_STATE_ERROR);
 		v4l2_m2m_buf_done(run.dst, VB2_BUF_STATE_ERROR);
diff --git a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_mpeg2.c b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_mpeg2.c
index 85e6fc2fbdb2..d1d7a3cfce0d 100644
--- a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_mpeg2.c
+++ b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_mpeg2.c
@@ -148,13 +148,9 @@ void sunxi_cedrus_mpeg2_setup(struct sunxi_cedrus_ctx *ctx,
 	sunxi_cedrus_write(dev, src_buf_addr + VBV_SIZE - 1, VE_MPEG_VLD_END);
 }
 
-void sunxi_cedrus_mpeg2_trigger(struct sunxi_cedrus_ctx *ctx, bool mpeg1)
+void sunxi_cedrus_mpeg2_trigger(struct sunxi_cedrus_ctx *ctx)
 {
 	struct sunxi_cedrus_dev *dev = ctx->dev;
 
-	/* Trigger MPEG engine. */
-	if (mpeg1)
-		sunxi_cedrus_write(dev, VE_TRIG_MPEG1, VE_MPEG_TRIGGER);
-	else
-		sunxi_cedrus_write(dev, VE_TRIG_MPEG2, VE_MPEG_TRIGGER);
+	sunxi_cedrus_write(dev, VE_TRIG_MPEG2, VE_MPEG_TRIGGER);
 }
diff --git a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_mpeg2.h b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_mpeg2.h
index b572001d47f2..4c380becfa1a 100644
--- a/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_mpeg2.h
+++ b/drivers/media/platform/sunxi/cedrus/sunxi_cedrus_mpeg2.h
@@ -28,6 +28,6 @@ struct sunxi_cedrus_run;
 
 void sunxi_cedrus_mpeg2_setup(struct sunxi_cedrus_ctx *ctx,
 			      struct sunxi_cedrus_run *run);
-void sunxi_cedrus_mpeg2_trigger(struct sunxi_cedrus_ctx *ctx, bool mpeg1);
+void sunxi_cedrus_mpeg2_trigger(struct sunxi_cedrus_ctx *ctx);
 
 #endif
-- 
2.17.0

