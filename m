Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751593AbeBTEpc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 23:45:32 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35424 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbeBTEpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 23:45:30 -0500
X-Google-Smtp-Source: AH8x227ZYXbQhx+wz5XDmlF3xfZ4mAWgDpbgnsjUpyxQi4qljV2ai3oR3tJHPJTvq1BQDvUVYkVM4w==
From: Alexandre Courbot <acourbot@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Gustavo Padovan <gustavo.padovan@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [RFCv4 17/21] media: mem2mem: support for requests
Date: Tue, 20 Feb 2018 13:44:21 +0900
Message-Id: <20180220044425.169493-18-acourbot@chromium.org>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180220044425.169493-1-acourbot@chromium.org>
References: <20180220044425.169493-1-acourbot@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add generic support for requests to the mem2mem framework. This just
requires calling vb2_qbuf_request() instead of vb2_qbuf() in
v4l2_m2m_qbuf().

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 drivers/media/v4l2-core/v4l2-mem2mem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index c4f963d96a79..d9ae428651c4 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -388,11 +388,12 @@ EXPORT_SYMBOL_GPL(v4l2_m2m_querybuf);
 int v4l2_m2m_qbuf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
 		  struct v4l2_buffer *buf)
 {
+	struct v4l2_fh *fh = file->private_data;
 	struct vb2_queue *vq;
 	int ret;
 
 	vq = v4l2_m2m_get_vq(m2m_ctx, buf->type);
-	ret = vb2_qbuf(vq, buf);
+	ret = vb2_qbuf_request(vq, buf, fh->entity);
 	if (!ret)
 		v4l2_m2m_try_schedule(m2m_ctx);
 
-- 
2.16.1.291.g4437f3f132-goog
