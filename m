Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CCCC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557C320866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557C320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbeIJIQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 04:16:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726100AbeIJIQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 04:16:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EFC3326A95;
        Mon, 10 Sep 2018 00:57:47 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-121-42.rdu2.redhat.com [10.10.121.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3828C2027EB6;
        Mon, 10 Sep 2018 00:57:47 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] gpu/i915: use HMM mirror instead of mmu_notifier
Date:   Sun,  9 Sep 2018 20:57:35 -0400
Message-Id: <20180910005736.5805-2-jglisse@redhat.com>
In-Reply-To: <20180910005736.5805-1-jglisse@redhat.com>
References: <20180910005736.5805-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 10 Sep 2018 00:57:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 10 Sep 2018 00:57:48 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
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
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/i915/Kconfig            |   4 +-
 drivers/gpu/drm/i915/i915_gem_userptr.c | 189 ++++++++++++------------
 2 files changed, 97 insertions(+), 96 deletions(-)

diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index 33a458b7f1fc..40bba0bd8124 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -87,10 +87,10 @@ config DRM_I915_COMPRESS_ERROR
 config DRM_I915_USERPTR
 	bool "Always enable userptr support"
 	depends on DRM_I915
-	select MMU_NOTIFIER
+	select HMM_MIRROR
 	default y
 	help
-	  This option selects CONFIG_MMU_NOTIFIER if it isn't already
+	  This option selects CONFIG_HMM_MIRROR if it isn't already
 	  selected to enabled full userptr support.
 
 	  If in doubt, say "Y".
diff --git a/drivers/gpu/drm/i915/i915_gem_userptr.c b/drivers/gpu/drm/i915/i915_gem_userptr.c
index 2c9b284036d1..5e09b654b5ad 100644
--- a/drivers/gpu/drm/i915/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/i915_gem_userptr.c
@@ -28,7 +28,7 @@
 #include "i915_trace.h"
 #include "intel_drv.h"
 #include <linux/mmu_context.h>
-#include <linux/mmu_notifier.h>
+#include <linux/hmm.h>
 #include <linux/mempolicy.h>
 #include <linux/swap.h>
 #include <linux/sched/mm.h>
@@ -36,25 +36,25 @@
 struct i915_mm_struct {
 	struct mm_struct *mm;
 	struct drm_i915_private *i915;
-	struct i915_mmu_notifier *mn;
+	struct i915_mirror *mirror;
 	struct hlist_node node;
 	struct kref kref;
 	struct work_struct work;
 };
 
-#if defined(CONFIG_MMU_NOTIFIER)
+#if defined(CONFIG_HMM_MIRROR)
 #include <linux/interval_tree.h>
 
-struct i915_mmu_notifier {
+struct i915_mirror {
 	spinlock_t lock;
 	struct hlist_node node;
-	struct mmu_notifier mn;
+	struct hmm_mirror mirror;
 	struct rb_root_cached objects;
 	struct workqueue_struct *wq;
 };
 
 struct i915_mmu_object {
-	struct i915_mmu_notifier *mn;
+	struct i915_mirror *mirror;
 	struct drm_i915_gem_object *obj;
 	struct interval_tree_node it;
 	struct list_head link;
@@ -99,7 +99,7 @@ static void add_object(struct i915_mmu_object *mo)
 	if (mo->attached)
 		return;
 
-	interval_tree_insert(&mo->it, &mo->mn->objects);
+	interval_tree_insert(&mo->it, &mo->mirror->objects);
 	mo->attached = true;
 }
 
@@ -108,33 +108,29 @@ static void del_object(struct i915_mmu_object *mo)
 	if (!mo->attached)
 		return;
 
-	interval_tree_remove(&mo->it, &mo->mn->objects);
+	interval_tree_remove(&mo->it, &mo->mirror->objects);
 	mo->attached = false;
 }
 
-static int i915_gem_userptr_mn_invalidate_range_start(struct mmu_notifier *_mn,
-						       struct mm_struct *mm,
-						       unsigned long start,
-						       unsigned long end,
-						       bool blockable)
+static int i915_sync_cpu_device_pagetables(struct hmm_mirror *_mirror,
+					   const struct hmm_update *update)
 {
-	struct i915_mmu_notifier *mn =
-		container_of(_mn, struct i915_mmu_notifier, mn);
+	struct i915_mirror *mirror =
+		container_of(_mirror, struct i915_mirror, mirror);
+	/* interval ranges are inclusive, but invalidate range is exclusive */
+	unsigned long end = update->end - 1;
 	struct i915_mmu_object *mo;
 	struct interval_tree_node *it;
 	LIST_HEAD(cancelled);
 
-	if (RB_EMPTY_ROOT(&mn->objects.rb_root))
+	if (RB_EMPTY_ROOT(&mirror->objects.rb_root))
 		return 0;
 
-	/* interval ranges are inclusive, but invalidate range is exclusive */
-	end--;
-
-	spin_lock(&mn->lock);
-	it = interval_tree_iter_first(&mn->objects, start, end);
+	spin_lock(&mirror->lock);
+	it = interval_tree_iter_first(&mirror->objects, update->start, end);
 	while (it) {
-		if (!blockable) {
-			spin_unlock(&mn->lock);
+		if (!update->blockable) {
+			spin_unlock(&mirror->lock);
 			return -EAGAIN;
 		}
 		/* The mmu_object is released late when destroying the
@@ -148,50 +144,56 @@ static int i915_gem_userptr_mn_invalidate_range_start(struct mmu_notifier *_mn,
 		 */
 		mo = container_of(it, struct i915_mmu_object, it);
 		if (kref_get_unless_zero(&mo->obj->base.refcount))
-			queue_work(mn->wq, &mo->work);
+			queue_work(mirror->wq, &mo->work);
 
 		list_add(&mo->link, &cancelled);
-		it = interval_tree_iter_next(it, start, end);
+		it = interval_tree_iter_next(it, update->start, end);
 	}
 	list_for_each_entry(mo, &cancelled, link)
 		del_object(mo);
-	spin_unlock(&mn->lock);
+	spin_unlock(&mirror->lock);
 
 	if (!list_empty(&cancelled))
-		flush_workqueue(mn->wq);
+		flush_workqueue(mirror->wq);
 
 	return 0;
 }
 
-static const struct mmu_notifier_ops i915_gem_userptr_notifier = {
-	.invalidate_range_start = i915_gem_userptr_mn_invalidate_range_start,
+static void
+i915_mirror_release(struct hmm_mirror *mirror)
+{
+}
+
+static const struct hmm_mirror_ops i915_mirror_ops = {
+	.sync_cpu_device_pagetables = &i915_sync_cpu_device_pagetables,
+	.release = &i915_mirror_release,
 };
 
-static struct i915_mmu_notifier *
-i915_mmu_notifier_create(struct mm_struct *mm)
+static struct i915_mirror*
+i915_mirror_create(struct mm_struct *mm)
 {
-	struct i915_mmu_notifier *mn;
+	struct i915_mirror *mirror;
 
-	mn = kmalloc(sizeof(*mn), GFP_KERNEL);
-	if (mn == NULL)
+	mirror = kmalloc(sizeof(*mirror), GFP_KERNEL);
+	if (mirror == NULL)
 		return ERR_PTR(-ENOMEM);
 
-	spin_lock_init(&mn->lock);
-	mn->mn.ops = &i915_gem_userptr_notifier;
-	mn->objects = RB_ROOT_CACHED;
-	mn->wq = alloc_workqueue("i915-userptr-release",
-				 WQ_UNBOUND | WQ_MEM_RECLAIM,
-				 0);
-	if (mn->wq == NULL) {
-		kfree(mn);
+	spin_lock_init(&mirror->lock);
+	mirror->mirror.ops = &i915_mirror_ops;
+	mirror->objects = RB_ROOT_CACHED;
+	mirror->wq = alloc_workqueue("i915-userptr-release",
+				     WQ_UNBOUND | WQ_MEM_RECLAIM,
+				     0);
+	if (mirror->wq == NULL) {
+		kfree(mirror);
 		return ERR_PTR(-ENOMEM);
 	}
 
-	return mn;
+	return mirror;
 }
 
 static void
-i915_gem_userptr_release__mmu_notifier(struct drm_i915_gem_object *obj)
+i915_gem_userptr_release__mirror(struct drm_i915_gem_object *obj)
 {
 	struct i915_mmu_object *mo;
 
@@ -199,38 +201,38 @@ i915_gem_userptr_release__mmu_notifier(struct drm_i915_gem_object *obj)
 	if (mo == NULL)
 		return;
 
-	spin_lock(&mo->mn->lock);
+	spin_lock(&mo->mirror->lock);
 	del_object(mo);
-	spin_unlock(&mo->mn->lock);
+	spin_unlock(&mo->mirror->lock);
 	kfree(mo);
 
 	obj->userptr.mmu_object = NULL;
 }
 
-static struct i915_mmu_notifier *
-i915_mmu_notifier_find(struct i915_mm_struct *mm)
+static struct i915_mirror *
+i915_mirror_find(struct i915_mm_struct *mm)
 {
-	struct i915_mmu_notifier *mn;
+	struct i915_mirror *mirror;
 	int err = 0;
 
-	mn = mm->mn;
-	if (mn)
-		return mn;
+	mirror = mm->mirror;
+	if (mirror)
+		return mirror;
 
-	mn = i915_mmu_notifier_create(mm->mm);
-	if (IS_ERR(mn))
-		err = PTR_ERR(mn);
+	mirror = i915_mirror_create(mm->mm);
+	if (IS_ERR(mirror))
+		err = PTR_ERR(mirror);
 
 	down_write(&mm->mm->mmap_sem);
 	mutex_lock(&mm->i915->mm_lock);
-	if (mm->mn == NULL && !err) {
+	if (mm->mirror == NULL && !err) {
 		/* Protected by mmap_sem (write-lock) */
-		err = __mmu_notifier_register(&mn->mn, mm->mm);
+		err = hmm_mirror_register(&mirror->mirror, mm->mm);
 		if (!err) {
 			/* Protected by mm_lock */
-			mm->mn = fetch_and_zero(&mn);
+			mm->mirror = fetch_and_zero(&mirror);
 		}
-	} else if (mm->mn) {
+	} else if (mm->mirror) {
 		/*
 		 * Someone else raced and successfully installed the mmu
 		 * notifier, we can cancel our own errors.
@@ -240,19 +242,19 @@ i915_mmu_notifier_find(struct i915_mm_struct *mm)
 	mutex_unlock(&mm->i915->mm_lock);
 	up_write(&mm->mm->mmap_sem);
 
-	if (mn && !IS_ERR(mn)) {
-		destroy_workqueue(mn->wq);
-		kfree(mn);
+	if (mirror && !IS_ERR(mirror)) {
+		destroy_workqueue(mirror->wq);
+		kfree(mirror);
 	}
 
-	return err ? ERR_PTR(err) : mm->mn;
+	return err ? ERR_PTR(err) : mm->mirror;
 }
 
 static int
-i915_gem_userptr_init__mmu_notifier(struct drm_i915_gem_object *obj,
+i915_gem_userptr_init__mirror(struct drm_i915_gem_object *obj,
 				    unsigned flags)
 {
-	struct i915_mmu_notifier *mn;
+	struct i915_mirror *mirror;
 	struct i915_mmu_object *mo;
 
 	if (flags & I915_USERPTR_UNSYNCHRONIZED)
@@ -261,15 +263,15 @@ i915_gem_userptr_init__mmu_notifier(struct drm_i915_gem_object *obj,
 	if (WARN_ON(obj->userptr.mm == NULL))
 		return -EINVAL;
 
-	mn = i915_mmu_notifier_find(obj->userptr.mm);
-	if (IS_ERR(mn))
-		return PTR_ERR(mn);
+	mirror = i915_mirror_find(obj->userptr.mm);
+	if (IS_ERR(mirror))
+		return PTR_ERR(mirror);
 
 	mo = kzalloc(sizeof(*mo), GFP_KERNEL);
 	if (mo == NULL)
 		return -ENOMEM;
 
-	mo->mn = mn;
+	mo->mirror = mirror;
 	mo->obj = obj;
 	mo->it.start = obj->userptr.ptr;
 	mo->it.last = obj->userptr.ptr + obj->base.size - 1;
@@ -280,26 +282,25 @@ i915_gem_userptr_init__mmu_notifier(struct drm_i915_gem_object *obj,
 }
 
 static void
-i915_mmu_notifier_free(struct i915_mmu_notifier *mn,
-		       struct mm_struct *mm)
+i915_mirror_free(struct i915_mirror *mirror, struct mm_struct *mm)
 {
-	if (mn == NULL)
+	if (mirror == NULL)
 		return;
 
-	mmu_notifier_unregister(&mn->mn, mm);
-	destroy_workqueue(mn->wq);
-	kfree(mn);
+	hmm_mirror_unregister(&mirror->mirror);
+	destroy_workqueue(mirror->wq);
+	kfree(mirror);
 }
 
 #else
 
 static void
-i915_gem_userptr_release__mmu_notifier(struct drm_i915_gem_object *obj)
+i915_gem_userptr_release__mirror(struct drm_i915_gem_object *obj)
 {
 }
 
 static int
-i915_gem_userptr_init__mmu_notifier(struct drm_i915_gem_object *obj,
+i915_gem_userptr_init__mirror(struct drm_i915_gem_object *obj,
 				    unsigned flags)
 {
 	if ((flags & I915_USERPTR_UNSYNCHRONIZED) == 0)
@@ -312,8 +313,8 @@ i915_gem_userptr_init__mmu_notifier(struct drm_i915_gem_object *obj,
 }
 
 static void
-i915_mmu_notifier_free(struct i915_mmu_notifier *mn,
-		       struct mm_struct *mm)
+i915_mirror_free(struct i915_mirror *mirror,
+		 struct mm_struct *mm)
 {
 }
 
@@ -364,7 +365,7 @@ i915_gem_userptr_init__mm_struct(struct drm_i915_gem_object *obj)
 		mm->mm = current->mm;
 		mmgrab(current->mm);
 
-		mm->mn = NULL;
+		mm->mirror = NULL;
 
 		/* Protected by dev_priv->mm_lock */
 		hash_add(dev_priv->mm_structs,
@@ -382,7 +383,7 @@ static void
 __i915_mm_struct_free__worker(struct work_struct *work)
 {
 	struct i915_mm_struct *mm = container_of(work, typeof(*mm), work);
-	i915_mmu_notifier_free(mm->mn, mm->mm);
+	i915_mirror_free(mm->mirror, mm->mm);
 	mmdrop(mm->mm);
 	kfree(mm);
 }
@@ -474,14 +475,14 @@ __i915_gem_userptr_set_active(struct drm_i915_gem_object *obj,
 	 * a GTT mmapping (possible with a MAP_FIXED) - then when we have
 	 * to invalidate that mmaping, mm_invalidate_range is called with
 	 * the userptr address *and* the struct_mutex held.  To prevent that
-	 * we set a flag under the i915_mmu_notifier spinlock to indicate
+	 * we set a flag under the i915_mirror spinlock to indicate
 	 * whether this object is valid.
 	 */
-#if defined(CONFIG_MMU_NOTIFIER)
+#if defined(CONFIG_HMM_MIRROR)
 	if (obj->userptr.mmu_object == NULL)
 		return 0;
 
-	spin_lock(&obj->userptr.mmu_object->mn->lock);
+	spin_lock(&obj->userptr.mmu_object->mirror->lock);
 	/* In order to serialise get_pages with an outstanding
 	 * cancel_userptr, we must drop the struct_mutex and try again.
 	 */
@@ -491,7 +492,7 @@ __i915_gem_userptr_set_active(struct drm_i915_gem_object *obj,
 		add_object(obj->userptr.mmu_object);
 	else
 		ret = -EAGAIN;
-	spin_unlock(&obj->userptr.mmu_object->mn->lock);
+	spin_unlock(&obj->userptr.mmu_object->mirror->lock);
 #endif
 
 	return ret;
@@ -625,10 +626,10 @@ static int i915_gem_userptr_get_pages(struct drm_i915_gem_object *obj)
 	 * the process may not be expecting that a particular piece of
 	 * memory is tied to the GPU.
 	 *
-	 * Fortunately, we can hook into the mmu_notifier in order to
-	 * discard the page references prior to anything nasty happening
-	 * to the vma (discard or cloning) which should prevent the more
-	 * egregious cases from causing harm.
+	 * Fortunately, we can hook into mirror callback in order to discard
+	 * the  page references prior to anything nasty happening to the vma
+	 * (discard or cloning) which should prevent the more egregious cases
+	 * from causing harm.
 	 */
 
 	if (obj->userptr.work) {
@@ -706,7 +707,7 @@ i915_gem_userptr_put_pages(struct drm_i915_gem_object *obj,
 static void
 i915_gem_userptr_release(struct drm_i915_gem_object *obj)
 {
-	i915_gem_userptr_release__mmu_notifier(obj);
+	i915_gem_userptr_release__mirror(obj);
 	i915_gem_userptr_release__mm_struct(obj);
 }
 
@@ -716,7 +717,7 @@ i915_gem_userptr_dmabuf_export(struct drm_i915_gem_object *obj)
 	if (obj->userptr.mmu_object)
 		return 0;
 
-	return i915_gem_userptr_init__mmu_notifier(obj, 0);
+	return i915_gem_userptr_init__mirror(obj, 0);
 }
 
 static const struct drm_i915_gem_object_ops i915_gem_userptr_ops = {
@@ -822,12 +823,12 @@ i915_gem_userptr_ioctl(struct drm_device *dev,
 		i915_gem_object_set_readonly(obj);
 
 	/* And keep a pointer to the current->mm for resolving the user pages
-	 * at binding. This means that we need to hook into the mmu_notifier
-	 * in order to detect if the mmu is destroyed.
+	 * at binding. This means that we need to hook into the mirror in order
+	 * to detect if the mmu is destroyed.
 	 */
 	ret = i915_gem_userptr_init__mm_struct(obj);
 	if (ret == 0)
-		ret = i915_gem_userptr_init__mmu_notifier(obj, args->flags);
+		ret = i915_gem_userptr_init__mirror(obj, args->flags);
 	if (ret == 0)
 		ret = drm_gem_handle_create(file, &obj->base, &handle);
 
-- 
2.17.1

