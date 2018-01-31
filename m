Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753669AbeAaK0R (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 05:26:17 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36200 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753239AbeAaKZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 05:25:22 -0500
X-Google-Smtp-Source: AH8x226+wMnV0PhzYnPlyhX25MzeqG2tb1sQShxsyldG+P7z41dMDvmICBIaiIcPIbda4i+PWS3GFg==
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
        Hans Verkuil <hans.verkuil@cisco.com>,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [RFCv2 07/17] v4l2-ctrls: prepare internal structs for request API
Date: Wed, 31 Jan 2018 19:24:25 +0900
Message-Id: <20180131102427.207721-8-acourbot@chromium.org>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
In-Reply-To: <20180131102427.207721-1-acourbot@chromium.org>
References: <20180131102427.207721-1-acourbot@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hans.verkuil@cisco.com>

Add a refcount and is_request bool to struct v4l2_ctrl_handler:
this is used to refcount a handler that represents a request.

Add a p_req field to struct v4l2_ctrl_ref that will store the
request value.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 drivers/media/v4l2-core/v4l2-ctrls.c | 1 +
 include/media/v4l2-ctrls.h           | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index 54444e3b8883..9d99679b543c 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -1751,6 +1751,7 @@ int v4l2_ctrl_handler_init_class(struct v4l2_ctrl_handler *hdl,
 				      sizeof(hdl->buckets[0]),
 				      GFP_KERNEL | __GFP_ZERO);
 	hdl->error = hdl->buckets ? 0 : -ENOMEM;
+	hdl->is_request = false;
 	return hdl->error;
 }
 EXPORT_SYMBOL(v4l2_ctrl_handler_init_class);
diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
index a762f3392d90..a215f25a82cf 100644
--- a/include/media/v4l2-ctrls.h
+++ b/include/media/v4l2-ctrls.h
@@ -18,6 +18,7 @@
 #define _V4L2_CTRLS_H
 
 #include <linux/list.h>
+#include <linux/kref.h>
 #include <linux/mutex.h>
 #include <linux/videodev2.h>
 
@@ -250,6 +251,7 @@ struct v4l2_ctrl_ref {
 	struct v4l2_ctrl_ref *next;
 	struct v4l2_ctrl *ctrl;
 	struct v4l2_ctrl_helper *helper;
+	union v4l2_ctrl_ptr p_req;
 	bool from_other_dev;
 };
 
@@ -285,7 +287,9 @@ struct v4l2_ctrl_handler {
 	v4l2_ctrl_notify_fnc notify;
 	void *notify_priv;
 	u16 nr_of_buckets;
+	bool is_request;
 	int error;
+	struct kref ref;
 };
 
 /**
-- 
2.16.0.rc1.238.g530d649a79-goog
