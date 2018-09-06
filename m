Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7A3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F045206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F045206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbeIGDEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 23:04:54 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:56552 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728665AbeIGDEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 23:04:53 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 57924C00A2;
        Fri,  7 Sep 2018 00:27:15 +0200 (CEST)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 02B28C0F6B; Fri,  7 Sep 2018 00:27:13 +0200 (CEST)
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id A6596C0F58;
        Fri,  7 Sep 2018 00:25:05 +0200 (CEST)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devel@driverdev.osuosl.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Randy Li <ayaka@soulik.info>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v9 1/9] media: videobuf2-core: Rework and rename helper for request buffer count
Date:   Fri,  7 Sep 2018 00:24:34 +0200
Message-Id: <20180906222442.14825-2-contact@paulk.fr>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180906222442.14825-1-contact@paulk.fr>
References: <20180906222442.14825-1-contact@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper indicating whether buffers are associated with the request is
reworked and renamed to return the number of associated buffer objects.

This is useful for drivers that need to check how many buffers are in
the request to validate it.

Existing users of the helper don't need particular adaptation since the
meaning of zero/non-zero remains consistent.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 .../media/common/videobuf2/videobuf2-core.c    | 18 ++++++++----------
 .../media/common/videobuf2/videobuf2-v4l2.c    |  2 +-
 include/media/videobuf2-core.h                 |  4 ++--
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index cb86b02afd4a..194b9188ad3e 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -1368,23 +1368,21 @@ bool vb2_request_object_is_buffer(struct media_request_object *obj)
 }
 EXPORT_SYMBOL_GPL(vb2_request_object_is_buffer);
 
-bool vb2_request_has_buffers(struct media_request *req)
+unsigned int vb2_request_buffer_cnt(struct media_request *req)
 {
 	struct media_request_object *obj;
 	unsigned long flags;
-	bool has_buffers = false;
+	unsigned int buffer_cnt = 0;
 
 	spin_lock_irqsave(&req->lock, flags);
-	list_for_each_entry(obj, &req->objects, list) {
-		if (vb2_request_object_is_buffer(obj)) {
-			has_buffers = true;
-			break;
-		}
-	}
+	list_for_each_entry(obj, &req->objects, list)
+		if (vb2_request_object_is_buffer(obj))
+			buffer_cnt++;
 	spin_unlock_irqrestore(&req->lock, flags);
-	return has_buffers;
+
+	return buffer_cnt;
 }
-EXPORT_SYMBOL_GPL(vb2_request_has_buffers);
+EXPORT_SYMBOL_GPL(vb2_request_buffer_cnt);
 
 int vb2_core_prepare_buf(struct vb2_queue *q, unsigned int index, void *pb)
 {
diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index 6831a2eb1859..a17033ab2c22 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -1139,7 +1139,7 @@ int vb2_request_validate(struct media_request *req)
 	struct media_request_object *obj;
 	int ret = 0;
 
-	if (!vb2_request_has_buffers(req))
+	if (!vb2_request_buffer_cnt(req))
 		return -ENOENT;
 
 	list_for_each_entry(obj, &req->objects, list) {
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 6c76b9802589..e86981d615ae 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -1191,10 +1191,10 @@ int vb2_verify_memory_type(struct vb2_queue *q,
 bool vb2_request_object_is_buffer(struct media_request_object *obj);
 
 /**
- * vb2_request_has_buffers() - return true if the request contains buffers
+ * vb2_request_buffer_cnt() - return the number of buffers in the request
  *
  * @req:	the request.
  */
-bool vb2_request_has_buffers(struct media_request *req);
+unsigned int vb2_request_buffer_cnt(struct media_request *req);
 
 #endif /* _MEDIA_VIDEOBUF2_CORE_H */
-- 
2.18.0

