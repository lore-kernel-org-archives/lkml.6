Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeDRFnG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 01:43:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751273AbeDRFnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 01:43:02 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
To: dri-devel@lists.freedesktop.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] qxl: keep separate release_bo pointer
Date: Wed, 18 Apr 2018 07:42:57 +0200
Message-Id: <20180418054257.15388-3-kraxel@redhat.com>
In-Reply-To: <20180418054257.15388-1-kraxel@redhat.com>
References: <20180418054257.15388-1-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qxl expects that list_first_entry(release->bos) returns the first
element qxl added to the list.  ttm_eu_reserve_buffers() may reorder
the list though.

Add a release_bo field to struct qxl_release and use that instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h     |  1 +
 drivers/gpu/drm/qxl/qxl_cmd.c     |  6 ++----
 drivers/gpu/drm/qxl/qxl_release.c | 12 ++++++------
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 00a1a66b05..864b456080 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -167,6 +167,7 @@ struct qxl_release {
 
 	int id;
 	int type;
+	struct qxl_bo *release_bo;
 	uint32_t release_offset;
 	uint32_t surface_release_id;
 	struct ww_acquire_ctx ticket;
diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index c0fb52c6d4..01665b98c5 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -179,10 +179,9 @@ qxl_push_command_ring_release(struct qxl_device *qdev, struct qxl_release *relea
 			      uint32_t type, bool interruptible)
 {
 	struct qxl_command cmd;
-	struct qxl_bo_list *entry = list_first_entry(&release->bos, struct qxl_bo_list, tv.head);
 
 	cmd.type = type;
-	cmd.data = qxl_bo_physical_address(qdev, to_qxl_bo(entry->tv.bo), release->release_offset);
+	cmd.data = qxl_bo_physical_address(qdev, release->release_bo, release->release_offset);
 
 	return qxl_ring_push(qdev->command_ring, &cmd, interruptible);
 }
@@ -192,10 +191,9 @@ qxl_push_cursor_ring_release(struct qxl_device *qdev, struct qxl_release *releas
 			     uint32_t type, bool interruptible)
 {
 	struct qxl_command cmd;
-	struct qxl_bo_list *entry = list_first_entry(&release->bos, struct qxl_bo_list, tv.head);
 
 	cmd.type = type;
-	cmd.data = qxl_bo_physical_address(qdev, to_qxl_bo(entry->tv.bo), release->release_offset);
+	cmd.data = qxl_bo_physical_address(qdev, release->release_bo, release->release_offset);
 
 	return qxl_ring_push(qdev->cursor_ring, &cmd, interruptible);
 }
diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index a0b4244d28..7cb2145772 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -173,6 +173,7 @@ qxl_release_free_list(struct qxl_release *release)
 		list_del(&entry->tv.head);
 		kfree(entry);
 	}
+	release->release_bo = NULL;
 }
 
 void
@@ -296,7 +297,6 @@ int qxl_alloc_surface_release_reserved(struct qxl_device *qdev,
 {
 	if (surface_cmd_type == QXL_SURFACE_CMD_DESTROY && create_rel) {
 		int idr_ret;
-		struct qxl_bo_list *entry = list_first_entry(&create_rel->bos, struct qxl_bo_list, tv.head);
 		struct qxl_bo *bo;
 		union qxl_release_info *info;
 
@@ -304,8 +304,9 @@ int qxl_alloc_surface_release_reserved(struct qxl_device *qdev,
 		idr_ret = qxl_release_alloc(qdev, QXL_RELEASE_SURFACE_CMD, release);
 		if (idr_ret < 0)
 			return idr_ret;
-		bo = to_qxl_bo(entry->tv.bo);
+		bo = create_rel->release_bo;
 
+		(*release)->release_bo = bo;
 		(*release)->release_offset = create_rel->release_offset + 64;
 
 		qxl_release_list_add(*release, bo);
@@ -365,6 +366,7 @@ int qxl_alloc_release_reserved(struct qxl_device *qdev, unsigned long size,
 
 	bo = qxl_bo_ref(qdev->current_release_bo[cur_idx]);
 
+	(*release)->release_bo = bo;
 	(*release)->release_offset = qdev->current_release_bo_offset[cur_idx] * release_size_per_bo[cur_idx];
 	qdev->current_release_bo_offset[cur_idx]++;
 
@@ -408,8 +410,7 @@ union qxl_release_info *qxl_release_map(struct qxl_device *qdev,
 {
 	void *ptr;
 	union qxl_release_info *info;
-	struct qxl_bo_list *entry = list_first_entry(&release->bos, struct qxl_bo_list, tv.head);
-	struct qxl_bo *bo = to_qxl_bo(entry->tv.bo);
+	struct qxl_bo *bo = release->release_bo;
 
 	ptr = qxl_bo_kmap_atomic_page(qdev, bo, release->release_offset & PAGE_MASK);
 	if (!ptr)
@@ -422,8 +423,7 @@ void qxl_release_unmap(struct qxl_device *qdev,
 		       struct qxl_release *release,
 		       union qxl_release_info *info)
 {
-	struct qxl_bo_list *entry = list_first_entry(&release->bos, struct qxl_bo_list, tv.head);
-	struct qxl_bo *bo = to_qxl_bo(entry->tv.bo);
+	struct qxl_bo *bo = release->release_bo;
 	void *ptr;
 
 	ptr = ((void *)info) - (release->release_offset & ~PAGE_MASK);
-- 
2.9.3
