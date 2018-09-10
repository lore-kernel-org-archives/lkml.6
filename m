Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0272C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6588920894
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6588920894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbeIJHJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:09:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725917AbeIJHJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:09:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C8CF4406C786;
        Mon, 10 Sep 2018 00:57:48 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-121-42.rdu2.redhat.com [10.10.121.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 127932016F00;
        Mon, 10 Sep 2018 00:57:48 +0000 (UTC)
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
Subject: [PATCH 2/2] gpu/i915: use HMM mirror for userptr buffer object.
Date:   Sun,  9 Sep 2018 20:57:36 -0400
Message-Id: <20180910005736.5805-3-jglisse@redhat.com>
In-Reply-To: <20180910005736.5805-1-jglisse@redhat.com>
References: <20180910005736.5805-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 10 Sep 2018 00:57:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 10 Sep 2018 00:57:48 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

This replace existing code that rely on get_user_page() aka GUP with
code that now use HMM mirror to mirror a range of virtual address as
a buffer object accessible by the GPU. There is no functional changes
from userspace point of view.

From kernel point of view we no longer pin pages for userptr buffer
object which is a welcome change (i am assuming that everyone dislike
page pin as i do).

Another change, from kernel point of view, is that it does no longer
have a fast path with get_user_pages_fast() this can eventually added
back through HMM.

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
 drivers/gpu/drm/i915/i915_gem_userptr.c | 206 ++++++++++++------------
 1 file changed, 102 insertions(+), 104 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gem_userptr.c b/drivers/gpu/drm/i915/i915_gem_userptr.c
index 5e09b654b5ad..378aab438ebd 100644
--- a/drivers/gpu/drm/i915/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/i915_gem_userptr.c
@@ -464,7 +464,7 @@ __i915_gem_userptr_alloc_pages(struct drm_i915_gem_object *obj,
 
 static int
 __i915_gem_userptr_set_active(struct drm_i915_gem_object *obj,
-			      bool value)
+			      struct hmm_range *range)
 {
 	int ret = 0;
 
@@ -486,86 +486,120 @@ __i915_gem_userptr_set_active(struct drm_i915_gem_object *obj,
 	/* In order to serialise get_pages with an outstanding
 	 * cancel_userptr, we must drop the struct_mutex and try again.
 	 */
-	if (!value)
+	if (range) {
+		if (!hmm_vma_range_done(range))
+			ret = -EAGAIN;
+		else
+			add_object(obj->userptr.mmu_object);
+	} else
 		del_object(obj->userptr.mmu_object);
-	else if (!work_pending(&obj->userptr.mmu_object->work))
-		add_object(obj->userptr.mmu_object);
-	else
-		ret = -EAGAIN;
 	spin_unlock(&obj->userptr.mmu_object->mirror->lock);
 #endif
 
 	return ret;
 }
 
-static void
-__i915_gem_userptr_get_pages_worker(struct work_struct *_work)
+static int
+i915_gem_userptr_map(struct drm_i915_gem_object *obj, bool try)
 {
-	struct get_pages_work *work = container_of(_work, typeof(*work), work);
-	struct drm_i915_gem_object *obj = work->obj;
-	const int npages = obj->base.size >> PAGE_SHIFT;
+#if defined(CONFIG_HMM_MIRROR)
+	static const uint64_t i915_range_flags[HMM_PFN_FLAG_MAX] = {
+		(1 << 0), /* HMM_PFN_VALID */
+		(1 << 1), /* HMM_PFN_WRITE */
+		0 /* HMM_PFN_DEVICE_PRIVATE */
+	};
+	static const uint64_t i915_range_values[HMM_PFN_VALUE_MAX] = {
+		0xfffffffffffffffeUL, /* HMM_PFN_ERROR */
+		0, /* HMM_PFN_NONE */
+		0xfffffffffffffffcUL /* HMM_PFN_SPECIAL */
+	};
+
+	const unsigned long npages = obj->base.size >> PAGE_SHIFT;
+	struct mm_struct *mm = obj->userptr.mm->mm;
+	struct sg_table *pages;
+	struct hmm_range range;
 	struct page **pvec;
-	int pinned, ret;
-
-	ret = -ENOMEM;
-	pinned = 0;
-
-	pvec = kvmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
-	if (pvec != NULL) {
-		struct mm_struct *mm = obj->userptr.mm->mm;
-		unsigned int flags = 0;
-
-		if (!i915_gem_object_is_readonly(obj))
-			flags |= FOLL_WRITE;
-
-		ret = -EFAULT;
-		if (mmget_not_zero(mm)) {
-			down_read(&mm->mmap_sem);
-			while (pinned < npages) {
-				ret = get_user_pages_remote
-					(work->task, mm,
-					 obj->userptr.ptr + pinned * PAGE_SIZE,
-					 npages - pinned,
-					 flags,
-					 pvec + pinned, NULL, NULL);
-				if (ret < 0)
-					break;
-
-				pinned += ret;
-			}
-			up_read(&mm->mmap_sem);
-			mmput(mm);
-		}
+	unsigned long i;
+	bool write = !i915_gem_object_is_readonly(obj);
+	int err;
+
+	range.pfns = kvmalloc_array(npages, sizeof(uint64_t),
+				    try ? GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN : GFP_KERNEL);
+	if (range.pfns == NULL)
+		return try ? -EAGAIN : -ENOMEM;
+
+	range.pfn_shift = 12;
+	range.start = obj->userptr.ptr;
+	range.flags = i915_range_flags;
+	range.values = i915_range_values;
+	range.end = range.start + obj->base.size;
+
+	range.vma = find_vma(mm, range.start);
+	if (!range.vma || range.vma->vm_file || range.vma->vm_end < range.end) {
+		kvfree(range.pfns);
+		return -EFAULT;
 	}
 
-	mutex_lock(&obj->mm.lock);
-	if (obj->userptr.work == &work->work) {
-		struct sg_table *pages = ERR_PTR(ret);
-
-		if (pinned == npages) {
-			pages = __i915_gem_userptr_alloc_pages(obj, pvec,
-							       npages);
-			if (!IS_ERR(pages)) {
-				pinned = 0;
-				pages = NULL;
+again:
+	for (i = 0; i < npages; ++i) {
+		range.pfns[i] = range.flags[HMM_PFN_VALID];
+		range.pfns[i] |= write ? range.flags[HMM_PFN_WRITE] : 0;
+	}
+
+	err = hmm_vma_fault(&range, true);
+	if (err) {
+		kvfree(range.pfns);
+		return err;
+	}
+
+	for (i = 0, pvec = (void *)range.pfns; i < npages; ++i) {
+		struct page *page = hmm_pfn_to_page(&range, range.pfns[i]);
+
+		if (page == NULL) {
+			hmm_vma_range_done(&range);
+
+			if (try) {
+				kvfree(range.pfns);
+				return -EAGAIN;
 			}
+			goto again;
 		}
-
-		obj->userptr.work = ERR_CAST(pages);
-		if (IS_ERR(pages))
-			__i915_gem_userptr_set_active(obj, false);
+		pvec[i] = page;
 	}
-	mutex_unlock(&obj->mm.lock);
 
-	release_pages(pvec, pinned);
-	kvfree(pvec);
+	if (!try)
+		mutex_lock(&obj->mm.lock);
+	pages = __i915_gem_userptr_alloc_pages(obj, pvec, npages);
+	if (!IS_ERR(pages))
+		__i915_gem_userptr_set_active(obj, &range);
+	else
+		hmm_vma_range_done(&range);
+	if (!try)
+		mutex_unlock(&obj->mm.lock);
+
+	kvfree(range.pfns);
+	return PTR_ERR_OR_ZERO(pages);
+#else /* CONFIG_HMM_MIRROR */
+	return -EFAULT;
+#endif
+}
+
+static void
+__i915_gem_userptr_get_pages_worker(struct work_struct *_work)
+{
+	struct get_pages_work *work = container_of(_work, typeof(*work), work);
+	struct drm_i915_gem_object *obj = work->obj;
+	int ret;
+
+	ret = i915_gem_userptr_map(obj, false);
+	obj->userptr.work = ERR_PTR(ret);
 
 	i915_gem_object_put(obj);
 	put_task_struct(work->task);
 	kfree(work);
 }
 
-static struct sg_table *
+static int
 __i915_gem_userptr_get_pages_schedule(struct drm_i915_gem_object *obj)
 {
 	struct get_pages_work *work;
@@ -591,7 +625,7 @@ __i915_gem_userptr_get_pages_schedule(struct drm_i915_gem_object *obj)
 	 */
 	work = kmalloc(sizeof(*work), GFP_KERNEL);
 	if (work == NULL)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	obj->userptr.work = &work->work;
 
@@ -603,17 +637,12 @@ __i915_gem_userptr_get_pages_schedule(struct drm_i915_gem_object *obj)
 	INIT_WORK(&work->work, __i915_gem_userptr_get_pages_worker);
 	queue_work(to_i915(obj->base.dev)->mm.userptr_wq, &work->work);
 
-	return ERR_PTR(-EAGAIN);
+	return -EAGAIN;
 }
 
 static int i915_gem_userptr_get_pages(struct drm_i915_gem_object *obj)
 {
-	const int num_pages = obj->base.size >> PAGE_SHIFT;
-	struct mm_struct *mm = obj->userptr.mm->mm;
-	struct page **pvec;
-	struct sg_table *pages;
-	bool active;
-	int pinned;
+	int ret;
 
 	/* If userspace should engineer that these pages are replaced in
 	 * the vma between us binding this page into the GTT and completion
@@ -640,40 +669,10 @@ static int i915_gem_userptr_get_pages(struct drm_i915_gem_object *obj)
 			return -EAGAIN;
 	}
 
-	pvec = NULL;
-	pinned = 0;
-
-	if (mm == current->mm) {
-		pvec = kvmalloc_array(num_pages, sizeof(struct page *),
-				      GFP_KERNEL |
-				      __GFP_NORETRY |
-				      __GFP_NOWARN);
-		if (pvec) /* defer to worker if malloc fails */
-			pinned = __get_user_pages_fast(obj->userptr.ptr,
-						       num_pages,
-						       !i915_gem_object_is_readonly(obj),
-						       pvec);
-	}
-
-	active = false;
-	if (pinned < 0) {
-		pages = ERR_PTR(pinned);
-		pinned = 0;
-	} else if (pinned < num_pages) {
-		pages = __i915_gem_userptr_get_pages_schedule(obj);
-		active = pages == ERR_PTR(-EAGAIN);
-	} else {
-		pages = __i915_gem_userptr_alloc_pages(obj, pvec, num_pages);
-		active = !IS_ERR(pages);
-	}
-	if (active)
-		__i915_gem_userptr_set_active(obj, true);
-
-	if (IS_ERR(pages))
-		release_pages(pvec, pinned);
-	kvfree(pvec);
-
-	return PTR_ERR_OR_ZERO(pages);
+	ret = i915_gem_userptr_map(obj, true);
+	if (ret == -EAGAIN)
+		ret = __i915_gem_userptr_get_pages_schedule(obj);
+	return ret;
 }
 
 static void
@@ -684,7 +683,7 @@ i915_gem_userptr_put_pages(struct drm_i915_gem_object *obj,
 	struct page *page;
 
 	BUG_ON(obj->userptr.work != NULL);
-	__i915_gem_userptr_set_active(obj, false);
+	__i915_gem_userptr_set_active(obj, NULL);
 
 	if (obj->mm.madv != I915_MADV_WILLNEED)
 		obj->mm.dirty = false;
@@ -696,7 +695,6 @@ i915_gem_userptr_put_pages(struct drm_i915_gem_object *obj,
 			set_page_dirty(page);
 
 		mark_page_accessed(page);
-		put_page(page);
 	}
 	obj->mm.dirty = false;
 
-- 
2.17.1

