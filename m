Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C830EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80ED520866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80ED520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeIJIQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 04:16:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726045AbeIJIQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 04:16:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 476148E7A0;
        Mon, 10 Sep 2018 00:57:57 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-121-42.rdu2.redhat.com [10.10.121.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88E8E637B2;
        Mon, 10 Sep 2018 00:57:56 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>,
        amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 1/2] gpu/radeon: use HMM mirror instead of mmu_notifier
Date:   Sun,  9 Sep 2018 20:57:52 -0400
Message-Id: <20180910005753.5860-2-jglisse@redhat.com>
In-Reply-To: <20180910005753.5860-1-jglisse@redhat.com>
References: <20180910005753.5860-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 10 Sep 2018 00:57:57 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 10 Sep 2018 00:57:57 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

HMM provide a sets of helpers to avoid individual drivers re-doing
their own. This patch convert the radeon to use HMM mirror to track
CPU page table update and invalidate accordingly for userptr object.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: David (ChunMing) Zhou <David1.Zhou@amd.com>
Cc: Nicolai Hähnle <nicolai.haehnle@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/radeon/radeon_mn.c | 126 ++++++++++++++---------------
 1 file changed, 63 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_mn.c b/drivers/gpu/drm/radeon/radeon_mn.c
index f8b35df44c60..a3bf74c1a3fc 100644
--- a/drivers/gpu/drm/radeon/radeon_mn.c
+++ b/drivers/gpu/drm/radeon/radeon_mn.c
@@ -30,7 +30,7 @@
 
 #include <linux/firmware.h>
 #include <linux/module.h>
-#include <linux/mmu_notifier.h>
+#include <linux/hmm.h>
 #include <drm/drmP.h>
 #include <drm/drm.h>
 
@@ -40,7 +40,7 @@ struct radeon_mn {
 	/* constant after initialisation */
 	struct radeon_device	*rdev;
 	struct mm_struct	*mm;
-	struct mmu_notifier	mn;
+	struct hmm_mirror	mirror;
 
 	/* only used on destruction */
 	struct work_struct	work;
@@ -87,72 +87,67 @@ static void radeon_mn_destroy(struct work_struct *work)
 	}
 	mutex_unlock(&rmn->lock);
 	mutex_unlock(&rdev->mn_lock);
-	mmu_notifier_unregister(&rmn->mn, rmn->mm);
+	hmm_mirror_unregister(&rmn->mirror);
 	kfree(rmn);
 }
 
 /**
  * radeon_mn_release - callback to notify about mm destruction
  *
- * @mn: our notifier
- * @mn: the mm this callback is about
+ * @mirror: our mirror struct
  *
  * Shedule a work item to lazy destroy our notifier.
  */
-static void radeon_mn_release(struct mmu_notifier *mn,
-			      struct mm_struct *mm)
+static void radeon_mirror_release(struct hmm_mirror *mirror)
 {
-	struct radeon_mn *rmn = container_of(mn, struct radeon_mn, mn);
+	struct radeon_mn *rmn = container_of(mirror, struct radeon_mn, mirror);
 	INIT_WORK(&rmn->work, radeon_mn_destroy);
 	schedule_work(&rmn->work);
 }
 
 /**
- * radeon_mn_invalidate_range_start - callback to notify about mm change
+ * radeon_sync_cpu_device_pagetables - callback to synchronize with mm changes
  *
- * @mn: our notifier
- * @mn: the mm this callback is about
- * @start: start of updated range
- * @end: end of updated range
+ * @mirror: our HMM mirror
+ * @update: update informations (start, end, event, blockable, ...)
  *
- * We block for all BOs between start and end to be idle and
- * unmap them by move them into system domain again.
+ * We block for all BOs between start and end to be idle and unmap them by
+ * moving them into system domain again (trigger a call to ttm_backend_func.
+ * unbind see radeon_ttm.c).
  */
-static int radeon_mn_invalidate_range_start(struct mmu_notifier *mn,
-					     struct mm_struct *mm,
-					     unsigned long start,
-					     unsigned long end,
-					     bool blockable)
+static int radeon_sync_cpu_device_pagetables(struct hmm_mirror *mirror,
+					     const struct hmm_update *update)
 {
-	struct radeon_mn *rmn = container_of(mn, struct radeon_mn, mn);
+	struct radeon_mn *rmn = container_of(mirror, struct radeon_mn, mirror);
 	struct ttm_operation_ctx ctx = { false, false };
 	struct interval_tree_node *it;
+	unsigned long end;
 	int ret = 0;
 
 	/* notification is exclusive, but interval is inclusive */
-	end -= 1;
+	end = update->end - 1;
 
 	/* TODO we should be able to split locking for interval tree and
 	 * the tear down.
 	 */
-	if (blockable)
+	if (update->blockable)
 		mutex_lock(&rmn->lock);
 	else if (!mutex_trylock(&rmn->lock))
 		return -EAGAIN;
 
-	it = interval_tree_iter_first(&rmn->objects, start, end);
+	it = interval_tree_iter_first(&rmn->objects, update->start, end);
 	while (it) {
 		struct radeon_mn_node *node;
 		struct radeon_bo *bo;
 		long r;
 
-		if (!blockable) {
+		if (!update->blockable) {
 			ret = -EAGAIN;
 			goto out_unlock;
 		}
 
 		node = container_of(it, struct radeon_mn_node, it);
-		it = interval_tree_iter_next(it, start, end);
+		it = interval_tree_iter_next(it, update->start, end);
 
 		list_for_each_entry(bo, &node->bos, mn_list) {
 
@@ -178,16 +173,16 @@ static int radeon_mn_invalidate_range_start(struct mmu_notifier *mn,
 			radeon_bo_unreserve(bo);
 		}
 	}
-	
+
 out_unlock:
 	mutex_unlock(&rmn->lock);
 
 	return ret;
 }
 
-static const struct mmu_notifier_ops radeon_mn_ops = {
-	.release = radeon_mn_release,
-	.invalidate_range_start = radeon_mn_invalidate_range_start,
+static const struct hmm_mirror_ops radeon_mirror_ops = {
+	.sync_cpu_device_pagetables = &radeon_sync_cpu_device_pagetables,
+	.release = &radeon_mirror_release,
 };
 
 /**
@@ -200,48 +195,53 @@ static const struct mmu_notifier_ops radeon_mn_ops = {
 static struct radeon_mn *radeon_mn_get(struct radeon_device *rdev)
 {
 	struct mm_struct *mm = current->mm;
-	struct radeon_mn *rmn;
+	struct radeon_mn *rmn, *new;
 	int r;
 
-	if (down_write_killable(&mm->mmap_sem))
-		return ERR_PTR(-EINTR);
-
 	mutex_lock(&rdev->mn_lock);
-
-	hash_for_each_possible(rdev->mn_hash, rmn, node, (unsigned long)mm)
-		if (rmn->mm == mm)
-			goto release_locks;
-
-	rmn = kzalloc(sizeof(*rmn), GFP_KERNEL);
-	if (!rmn) {
-		rmn = ERR_PTR(-ENOMEM);
-		goto release_locks;
+	hash_for_each_possible(rdev->mn_hash, rmn, node, (unsigned long)mm) {
+		if (rmn->mm == mm) {
+			mutex_unlock(&rdev->mn_lock);
+			return rmn;
+		}
 	}
-
-	rmn->rdev = rdev;
-	rmn->mm = mm;
-	rmn->mn.ops = &radeon_mn_ops;
-	mutex_init(&rmn->lock);
-	rmn->objects = RB_ROOT_CACHED;
-	
-	r = __mmu_notifier_register(&rmn->mn, mm);
-	if (r)
-		goto free_rmn;
-
-	hash_add(rdev->mn_hash, &rmn->node, (unsigned long)mm);
-
-release_locks:
 	mutex_unlock(&rdev->mn_lock);
-	up_write(&mm->mmap_sem);
 
-	return rmn;
+	new = kzalloc(sizeof(*rmn), GFP_KERNEL);
+	if (!new) {
+		return ERR_PTR(-ENOMEM);
+	}
+	new->mm = mm;
+	new->rdev = rdev;
+	mutex_init(&new->lock);
+	new->objects = RB_ROOT_CACHED;
+	new->mirror.ops = &radeon_mirror_ops;
+
+	if (down_write_killable(&mm->mmap_sem)) {
+		kfree(new);
+		return ERR_PTR(-EINTR);
+	}
+	r = hmm_mirror_register(&new->mirror, mm);
+	up_write(&mm->mmap_sem);
+	if (r) {
+		kfree(new);
+		return ERR_PTR(r);
+	}
 
-free_rmn:
+	mutex_lock(&rdev->mn_lock);
+	/* Check again in case some other thread raced with us ... */
+	hash_for_each_possible(rdev->mn_hash, rmn, node, (unsigned long)mm) {
+		if (rmn->mm == mm) {
+			mutex_unlock(&rdev->mn_lock);
+			hmm_mirror_unregister(&new->mirror);
+			kfree(new);
+			return rmn;
+		}
+	}
+	hash_add(rdev->mn_hash, &new->node, (unsigned long)mm);
 	mutex_unlock(&rdev->mn_lock);
-	up_write(&mm->mmap_sem);
-	kfree(rmn);
 
-	return ERR_PTR(r);
+	return new;
 }
 
 /**
-- 
2.17.1

