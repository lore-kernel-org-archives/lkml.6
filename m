Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64229C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B5B21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B5B21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbeKUUjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:39:25 -0500
Received: from mga18.intel.com ([134.134.136.126]:14789 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729526AbeKUUjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:39:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 02:05:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,260,1539673200"; 
   d="scan'208";a="275727057"
Received: from btwcube1.sh.intel.com ([10.67.104.173])
  by orsmga005.jf.intel.com with ESMTP; 21 Nov 2018 02:05:32 -0800
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org
Cc:     wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com,
        tiwei.bie@intel.com
Subject: [PATCH net-next v3 05/13] virtio_ring: introduce debug helpers
Date:   Wed, 21 Nov 2018 18:03:22 +0800
Message-Id: <20181121100330.24846-6-tiwei.bie@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181121100330.24846-1-tiwei.bie@intel.com>
References: <20181121100330.24846-1-tiwei.bie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce debug helpers for last_add_time update, check and
invalid. They will be used by packed ring too.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 drivers/virtio/virtio_ring.c | 49 ++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 0b97e5c79654..10d407910aa2 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -44,6 +44,26 @@
 	} while (0)
 #define END_USE(_vq) \
 	do { BUG_ON(!(_vq)->in_use); (_vq)->in_use = 0; } while(0)
+#define LAST_ADD_TIME_UPDATE(_vq)				\
+	do {							\
+		ktime_t now = ktime_get();			\
+								\
+		/* No kick or get, with .1 second between?  Warn. */ \
+		if ((_vq)->last_add_time_valid)			\
+			WARN_ON(ktime_to_ms(ktime_sub(now,	\
+				(_vq)->last_add_time)) > 100);	\
+		(_vq)->last_add_time = now;			\
+		(_vq)->last_add_time_valid = true;		\
+	} while (0)
+#define LAST_ADD_TIME_CHECK(_vq)				\
+	do {							\
+		if ((_vq)->last_add_time_valid) {		\
+			WARN_ON(ktime_to_ms(ktime_sub(ktime_get(), \
+				      (_vq)->last_add_time)) > 100); \
+		}						\
+	} while (0)
+#define LAST_ADD_TIME_INVALID(_vq)				\
+	((_vq)->last_add_time_valid = false)
 #else
 #define BAD_RING(_vq, fmt, args...)				\
 	do {							\
@@ -53,6 +73,9 @@
 	} while (0)
 #define START_USE(vq)
 #define END_USE(vq)
+#define LAST_ADD_TIME_UPDATE(vq)
+#define LAST_ADD_TIME_CHECK(vq)
+#define LAST_ADD_TIME_INVALID(vq)
 #endif
 
 struct vring_desc_state {
@@ -295,18 +318,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		return -EIO;
 	}
 
-#ifdef DEBUG
-	{
-		ktime_t now = ktime_get();
-
-		/* No kick or get, with .1 second between?  Warn. */
-		if (vq->last_add_time_valid)
-			WARN_ON(ktime_to_ms(ktime_sub(now, vq->last_add_time))
-					    > 100);
-		vq->last_add_time = now;
-		vq->last_add_time_valid = true;
-	}
-#endif
+	LAST_ADD_TIME_UPDATE(vq);
 
 	BUG_ON(total_sg == 0);
 
@@ -467,13 +479,8 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
 	new = vq->split.avail_idx_shadow;
 	vq->num_added = 0;
 
-#ifdef DEBUG
-	if (vq->last_add_time_valid) {
-		WARN_ON(ktime_to_ms(ktime_sub(ktime_get(),
-					      vq->last_add_time)) > 100);
-	}
-	vq->last_add_time_valid = false;
-#endif
+	LAST_ADD_TIME_CHECK(vq);
+	LAST_ADD_TIME_INVALID(vq);
 
 	if (vq->event) {
 		needs_kick = vring_need_event(virtio16_to_cpu(_vq->vdev,
@@ -597,9 +604,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 				&vring_used_event(&vq->split.vring),
 				cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
 
-#ifdef DEBUG
-	vq->last_add_time_valid = false;
-#endif
+	LAST_ADD_TIME_INVALID(vq);
 
 	END_USE(vq);
 	return ret;
-- 
2.14.5

