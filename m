Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752319AbeDRFnB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 01:43:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751273AbeDRFnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 01:43:00 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
To: dri-devel@lists.freedesktop.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] qxl: fix qxl_release_{map,unmap}
Date: Wed, 18 Apr 2018 07:42:56 +0200
Message-Id: <20180418054257.15388-2-kraxel@redhat.com>
In-Reply-To: <20180418054257.15388-1-kraxel@redhat.com>
References: <20180418054257.15388-1-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/PAGE_SIZE/PAGE_MASK/

Luckily release_offset is never larger than PAGE_SIZE, so the bug has no
bad side effects and managed to stay unnoticed for years that way ...

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_ioctl.c   | 4 ++--
 drivers/gpu/drm/qxl/qxl_release.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index e238a1a2ec..6cc9f3367f 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -182,9 +182,9 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 		goto out_free_reloc;
 
 	/* TODO copy slow path code from i915 */
-	fb_cmd = qxl_bo_kmap_atomic_page(qdev, cmd_bo, (release->release_offset & PAGE_SIZE));
+	fb_cmd = qxl_bo_kmap_atomic_page(qdev, cmd_bo, (release->release_offset & PAGE_MASK));
 	unwritten = __copy_from_user_inatomic_nocache
-		(fb_cmd + sizeof(union qxl_release_info) + (release->release_offset & ~PAGE_SIZE),
+		(fb_cmd + sizeof(union qxl_release_info) + (release->release_offset & ~PAGE_MASK),
 		 u64_to_user_ptr(cmd->command), cmd->command_size);
 
 	{
diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 5d84a66fed..a0b4244d28 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -411,10 +411,10 @@ union qxl_release_info *qxl_release_map(struct qxl_device *qdev,
 	struct qxl_bo_list *entry = list_first_entry(&release->bos, struct qxl_bo_list, tv.head);
 	struct qxl_bo *bo = to_qxl_bo(entry->tv.bo);
 
-	ptr = qxl_bo_kmap_atomic_page(qdev, bo, release->release_offset & PAGE_SIZE);
+	ptr = qxl_bo_kmap_atomic_page(qdev, bo, release->release_offset & PAGE_MASK);
 	if (!ptr)
 		return NULL;
-	info = ptr + (release->release_offset & ~PAGE_SIZE);
+	info = ptr + (release->release_offset & ~PAGE_MASK);
 	return info;
 }
 
@@ -426,7 +426,7 @@ void qxl_release_unmap(struct qxl_device *qdev,
 	struct qxl_bo *bo = to_qxl_bo(entry->tv.bo);
 	void *ptr;
 
-	ptr = ((void *)info) - (release->release_offset & ~PAGE_SIZE);
+	ptr = ((void *)info) - (release->release_offset & ~PAGE_MASK);
 	qxl_bo_kunmap_atomic_page(qdev, bo, ptr);
 }
 
-- 
2.9.3
