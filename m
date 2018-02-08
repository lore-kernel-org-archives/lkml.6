Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752373AbeBHKKD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 05:10:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:2589 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752190AbeBHKJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 05:09:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,477,1511856000";
   d="scan'208";a="199626207"
From: Wei Wang <wei.w.wang@intel.com>
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org,
        akpm@linux-foundation.org
Cc: pbonzini@redhat.com, wei.w.wang@intel.com,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com,
        huangzhichao@huawei.com
Subject: [PATCH v28 4/4] virtio-balloon: VIRTIO_BALLOON_F_PAGE_POISON
Date: Thu,  8 Feb 2018 17:50:20 +0800
Message-Id: <1518083420-11108-5-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518083420-11108-1-git-send-email-wei.w.wang@intel.com>
References: <1518083420-11108-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VIRTIO_BALLOON_F_PAGE_POISON feature bit is used to indicate if the
guest is using page poisoning. Guest writes to the poison_val config
field to tell host about the page poisoning value in use.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/virtio/virtio_balloon.c     | 13 +++++++++++++
 include/uapi/linux/virtio_balloon.h |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 39ecce3..9fa7fcf 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -685,6 +685,7 @@ static struct file_system_type balloon_fs = {
 static int virtballoon_probe(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb;
+	__u32 poison_val;
 	int err;
 
 	if (!vdev->config->get) {
@@ -728,6 +729,12 @@ static int virtballoon_probe(struct virtio_device *vdev)
 			goto out_del_vqs;
 		}
 		INIT_WORK(&vb->report_free_page_work, report_free_page_func);
+		if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
+			page_poison_val_get((u8 *)&poison_val);
+			memset(&poison_val, poison_val, sizeof(poison_val));
+			virtio_cwrite(vb->vdev, struct virtio_balloon_config,
+				      poison_val, &poison_val);
+		}
 	}
 
 	vb->nb.notifier_call = virtballoon_oom_notify;
@@ -846,6 +853,11 @@ static int virtballoon_restore(struct virtio_device *vdev)
 
 static int virtballoon_validate(struct virtio_device *vdev)
 {
+	uint8_t unused;
+
+	if (!page_poison_val_get(&unused))
+		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
+
 	__virtio_clear_bit(vdev, VIRTIO_F_IOMMU_PLATFORM);
 	return 0;
 }
@@ -855,6 +867,7 @@ static unsigned int features[] = {
 	VIRTIO_BALLOON_F_STATS_VQ,
 	VIRTIO_BALLOON_F_DEFLATE_ON_OOM,
 	VIRTIO_BALLOON_F_FREE_PAGE_HINT,
+	VIRTIO_BALLOON_F_PAGE_POISON,
 };
 
 static struct virtio_driver virtio_balloon_driver = {
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index 0c654db..3f97067 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -35,6 +35,7 @@
 #define VIRTIO_BALLOON_F_STATS_VQ	1 /* Memory Stats virtqueue */
 #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
+#define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
@@ -47,6 +48,8 @@ struct virtio_balloon_config {
 	__u32 actual;
 	/* Free page report command id, readonly by guest */
 	__u32 free_page_report_cmd_id;
+	/* Stores PAGE_POISON if page poisoning is in use */
+	__u32 poison_val;
 };
 
 #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
-- 
2.7.4
