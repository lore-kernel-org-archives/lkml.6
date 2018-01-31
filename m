Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753862AbeAaK14 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 05:27:56 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37431 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753713AbeAaK0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 05:26:43 -0500
X-Google-Smtp-Source: AH8x226F9SLMqy5ot8HntXnmWXjkYc4UoEycK9qe9dddAz1SMBhFYnZmG02h3hDy02QrdkoVGolA4Q==
From: Alexandre Courbot <acourbot@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [RFCv2 14/17] v4l2-ctrls: support requests in EXT_CTRLS ioctls
Date: Wed, 31 Jan 2018 19:26:22 +0900
Message-Id: <20180131102625.208021-5-acourbot@chromium.org>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
In-Reply-To: <20180131102625.208021-1-acourbot@chromium.org>
References: <20180131102625.208021-1-acourbot@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read and use the request_fd field of struct v4l2_ext_controls to apply
VIDIOC_G_EXT_CTRLS or VIDIOC_S_EXT_CTRLS to a request when asked by
userspace.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 3b44f1fe4f23..0b4c9024c96b 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -30,6 +30,7 @@
 #include <media/videobuf2-v4l2.h>
 #include <media/v4l2-mc.h>
 #include <media/media-request.h>
+#include <media/v4l2-request.h>
 
 #include <trace/events/v4l2.h>
 
@@ -2182,6 +2183,24 @@ static int v4l_g_ext_ctrls(const struct v4l2_ioctl_ops *ops,
 		test_bit(V4L2_FL_USES_V4L2_FH, &vfd->flags) ? fh : NULL;
 
 	p->error_idx = p->count;
+
+	if (p->request_fd > 0) {
+		struct media_request *req = NULL;
+		struct media_request_entity_data *_data;
+		struct media_request_v4l2_entity_data *data;
+		int ret;
+
+		req = check_request(p->request_fd, file, fh, &_data);
+		if (IS_ERR(req))
+			return PTR_ERR(req);
+		data = to_v4l2_entity_data(_data);
+
+		ret = v4l2_g_ext_ctrls(&data->ctrls, p);
+
+		media_request_put(req);
+		return ret;
+	}
+
 	if (vfh && vfh->ctrl_handler)
 		return v4l2_g_ext_ctrls(vfh->ctrl_handler, p);
 	if (vfd->ctrl_handler)
@@ -2201,6 +2220,23 @@ static int v4l_s_ext_ctrls(const struct v4l2_ioctl_ops *ops,
 		test_bit(V4L2_FL_USES_V4L2_FH, &vfd->flags) ? fh : NULL;
 
 	p->error_idx = p->count;
+	if (p->request_fd > 0) {
+		struct media_request *req = NULL;
+		struct media_request_entity_data *_data;
+		struct media_request_v4l2_entity_data *data;
+		int ret;
+
+		req = check_request(p->request_fd, file, fh, &_data);
+		if (IS_ERR(req))
+			return PTR_ERR(req);
+		data = to_v4l2_entity_data(_data);
+
+		ret = v4l2_s_ext_ctrls(vfh, &data->ctrls, p);
+
+		media_request_put(req);
+		return ret;
+	}
+
 	if (vfh && vfh->ctrl_handler)
 		return v4l2_s_ext_ctrls(vfh, vfh->ctrl_handler, p);
 	if (vfd->ctrl_handler)
-- 
2.16.0.rc1.238.g530d649a79-goog
