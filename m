Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CE6C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 06:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD462073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 06:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfACGGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 01:06:08 -0500
Received: from mga04.intel.com ([192.55.52.120]:50787 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbfACGGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 01:06:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 22:06:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,433,1539673200"; 
   d="scan'208";a="264035062"
Received: from devel-ww.sh.intel.com ([10.239.48.119])
  by orsmga004.jf.intel.com with ESMTP; 02 Jan 2019 22:06:04 -0800
From:   Wei Wang <wei.w.wang@intel.com>
To:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        mst@redhat.com, cohuck@redhat.com
Cc:     borntraeger@de.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com,
        wei.w.wang@intel.com, pasic@linux.ibm.com
Subject: [PATCH v1 1/2] virtio-balloon: tweak config_changed implementation
Date:   Thu,  3 Jan 2019 13:31:01 +0800
Message-Id: <1546493462-32244-2-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546493462-32244-1-git-send-email-wei.w.wang@intel.com>
References: <1546493462-32244-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio-ccw has deadlock issues with reading config registers inside the
interrupt context, so we tweak the virtballoon_changed implementation
by moving the config read operations into the related workqueue contexts.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 drivers/virtio/virtio_balloon.c | 54 ++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 728ecd1..9a82a11 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -394,33 +394,15 @@ static void virtballoon_changed(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb = vdev->priv;
 	unsigned long flags;
-	s64 diff = towards_target(vb);
-
-	if (diff) {
-		spin_lock_irqsave(&vb->stop_update_lock, flags);
-		if (!vb->stop_update)
-			queue_work(system_freezable_wq,
-				   &vb->update_balloon_size_work);
-		spin_unlock_irqrestore(&vb->stop_update_lock, flags);
-	}
 
-	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
-		virtio_cread(vdev, struct virtio_balloon_config,
-			     free_page_report_cmd_id, &vb->cmd_id_received);
-		if (vb->cmd_id_received == VIRTIO_BALLOON_CMD_ID_DONE) {
-			/* Pass ULONG_MAX to give back all the free pages */
-			return_free_pages_to_mm(vb, ULONG_MAX);
-		} else if (vb->cmd_id_received != VIRTIO_BALLOON_CMD_ID_STOP &&
-			   vb->cmd_id_received !=
-			   virtio32_to_cpu(vdev, vb->cmd_id_active)) {
-			spin_lock_irqsave(&vb->stop_update_lock, flags);
-			if (!vb->stop_update) {
-				queue_work(vb->balloon_wq,
-					   &vb->report_free_page_work);
-			}
-			spin_unlock_irqrestore(&vb->stop_update_lock, flags);
-		}
+	spin_lock_irqsave(&vb->stop_update_lock, flags);
+	if (!vb->stop_update) {
+		queue_work(system_freezable_wq,
+			   &vb->update_balloon_size_work);
+		if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
+			queue_work(vb->balloon_wq, &vb->report_free_page_work);
 	}
+	spin_unlock_irqrestore(&vb->stop_update_lock, flags);
 }
 
 static void update_balloon_size(struct virtio_balloon *vb)
@@ -637,11 +619,9 @@ static int send_free_pages(struct virtio_balloon *vb)
 	return 0;
 }
 
-static void report_free_page_func(struct work_struct *work)
+static void virtio_balloon_report_free_page(struct virtio_balloon *vb)
 {
 	int err;
-	struct virtio_balloon *vb = container_of(work, struct virtio_balloon,
-						 report_free_page_work);
 	struct device *dev = &vb->vdev->dev;
 
 	/* Start by sending the received cmd id to host with an outbuf. */
@@ -659,6 +639,24 @@ static void report_free_page_func(struct work_struct *work)
 		dev_err(dev, "Failed to send a stop id, err = %d\n", err);
 }
 
+static void report_free_page_func(struct work_struct *work)
+{
+	struct virtio_balloon *vb = container_of(work, struct virtio_balloon,
+						 report_free_page_work);
+
+	virtio_cread(vb->vdev, struct virtio_balloon_config,
+		     free_page_report_cmd_id, &vb->cmd_id_received);
+
+	if (vb->cmd_id_received == VIRTIO_BALLOON_CMD_ID_DONE) {
+		/* Pass ULONG_MAX to give back all the free pages */
+		return_free_pages_to_mm(vb, ULONG_MAX);
+	} else if (vb->cmd_id_received != VIRTIO_BALLOON_CMD_ID_STOP &&
+		   vb->cmd_id_received !=
+		   virtio32_to_cpu(vb->vdev, vb->cmd_id_active)) {
+		virtio_balloon_report_free_page(vb);
+	}
+}
+
 #ifdef CONFIG_BALLOON_COMPACTION
 /*
  * virtballoon_migratepage - perform the balloon page migration on behalf of
-- 
2.7.4

