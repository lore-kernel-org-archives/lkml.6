Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE853C46465
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7215920869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V6TVW/K4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7215920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbeKFSz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:55:26 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38412 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730372AbeKFSzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:55:25 -0500
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so5838639pfi.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 01:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=03j09s75VsTqkZOJHb0MeFK1toWMKtdV6C+k4g28cQY=;
        b=V6TVW/K4V6TiC04O5bkrxC8N4QPwOTya1DZM9vP+oSRu3TYn4aJmqA3PXnBVB++c6N
         JF/SCNTbV1vg7C6XvvbqVVygfuYDzqjd3DXR1Tl8xZ3Th6/rGbr3T/I0FsLP91mKwXhv
         CGs/i9x8fWnu2bKS0D9L6wjwllLBfTrN2M4iI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=03j09s75VsTqkZOJHb0MeFK1toWMKtdV6C+k4g28cQY=;
        b=ioNcTQLo/FIhTjxAt260XYKXNB+lvXA6hCaqrsYUXquPlmrGvNO8gyTMSyVICBBLJy
         ajXuQHCcQ6IRPNhBJjmSPD0uRZeFuIsuG6JxpRUBKze9TNe3cK/J4NZHPHu3+bz6fY96
         shOoIg41snCAaY4B/0IgRwDVoxHiSetHZHti8Gv0tP8kvDYJbmgbuguTvYBTMvLUG3zB
         KfjvfNEbkw5m/nWx5HSRRKdjl5vl8zS/BhyY0gFggRAuf7rD4ngtIb6DSpyL+MMurSMi
         zW2vJkZ1Sc+7S/4XjwoZqlXmzoo0K0ryjcsMxpVzZBIgoZvYtxBqUuVAzwk5hzxZYCws
         i2tQ==
X-Gm-Message-State: AGRZ1gL2GwWN8XKCiOEKLkjw4TKzMP2ogsBHzVlSjyFn/CvZfRqMcE/9
        3G50gIWfeJGyEr93lgTmrZJvXBU51g==
X-Google-Smtp-Source: AJdET5erv76fRKDwBMAgfSbNi4NU0/g45MgseahPRsTShELMByBhhk5hvfvuVs3GAlLXBzNTDw+MHg==
X-Received: by 2002:a63:2f86:: with SMTP id v128mr22401055pgv.407.1541496665000;
        Tue, 06 Nov 2018 01:31:05 -0800 (PST)
Received: from vovoy-z840.tpe.corp.google.com ([2401:fa00:1:b:c11e:9571:ae83:d95b])
        by smtp.gmail.com with ESMTPSA id 64-v6sm55227192pgb.74.2018.11.06.01.31.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 01:31:04 -0800 (PST)
From:   Kuo-Hsin Yang <vovoy@chromium.org>
To:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mm@kvack.org
Cc:     Kuo-Hsin Yang <vovoy@chromium.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v6] mm, drm/i915: mark pinned shmemfs pages as unevictable
Date:   Tue,  6 Nov 2018 17:30:59 +0800
Message-Id: <20181106093100.71829-1-vovoy@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i915 driver uses shmemfs to allocate backing storage for gem
objects. These shmemfs pages can be pinned (increased ref count) by
shmem_read_mapping_page_gfp(). When a lot of pages are pinned, vmscan
wastes a lot of time scanning these pinned pages. In some extreme case,
all pages in the inactive anon lru are pinned, and only the inactive
anon lru is scanned due to inactive_ratio, the system cannot swap and
invokes the oom-killer. Mark these pinned pages as unevictable to speed
up vmscan.

Export pagevec API check_move_unevictable_pages().

This patch was inspired by Chris Wilson's change [1].

[1]: https://patchwork.kernel.org/patch/9768741/

Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Kuo-Hsin Yang <vovoy@chromium.org>
Acked-by: Michal Hocko <mhocko@suse.com> # mm part
---
Changes for v6:
 Tweak the acked-by.

Changes for v5:
 Modify doc and comments. Remove the ifdef surrounding
 check_move_unevictable_pages.

Changes for v4:
 Export pagevec API check_move_unevictable_pages().

Changes for v3:
 Use check_move_lru_page instead of shmem_unlock_mapping to move pages
 to appropriate lru lists.

Changes for v2:
 Squashed the two patches.

 Documentation/vm/unevictable-lru.rst |  6 +++++-
 drivers/gpu/drm/i915/i915_gem.c      | 28 ++++++++++++++++++++++++++--
 include/linux/swap.h                 |  4 +++-
 mm/shmem.c                           |  2 +-
 mm/vmscan.c                          | 22 +++++++++++-----------
 5 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/Documentation/vm/unevictable-lru.rst b/Documentation/vm/unevictable-lru.rst
index fdd84cb8d511..b8e29f977f2d 100644
--- a/Documentation/vm/unevictable-lru.rst
+++ b/Documentation/vm/unevictable-lru.rst
@@ -143,7 +143,7 @@ using a number of wrapper functions:
 	Query the address space, and return true if it is completely
 	unevictable.
 
-These are currently used in two places in the kernel:
+These are currently used in three places in the kernel:
 
  (1) By ramfs to mark the address spaces of its inodes when they are created,
      and this mark remains for the life of the inode.
@@ -154,6 +154,10 @@ These are currently used in two places in the kernel:
      swapped out; the application must touch the pages manually if it wants to
      ensure they're in memory.
 
+ (3) By the i915 driver to mark pinned address space until it's unpinned. The
+     amount of unevictable memory marked by i915 driver is roughly the bounded
+     object size in debugfs/dri/0/i915_gem_objects.
+
 
 Detecting Unevictable Pages
 ---------------------------
diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 0c8aa57ce83b..c620891e0d02 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -2381,12 +2381,25 @@ void __i915_gem_object_invalidate(struct drm_i915_gem_object *obj)
 	invalidate_mapping_pages(mapping, 0, (loff_t)-1);
 }
 
+/**
+ * Move pages to appropriate lru and release the pagevec. Decrement the ref
+ * count of these pages.
+ */
+static inline void check_release_pagevec(struct pagevec *pvec)
+{
+	if (pagevec_count(pvec)) {
+		check_move_unevictable_pages(pvec);
+		__pagevec_release(pvec);
+	}
+}
+
 static void
 i915_gem_object_put_pages_gtt(struct drm_i915_gem_object *obj,
 			      struct sg_table *pages)
 {
 	struct sgt_iter sgt_iter;
 	struct page *page;
+	struct pagevec pvec;
 
 	__i915_gem_object_release_shmem(obj, pages, true);
 
@@ -2395,6 +2408,9 @@ i915_gem_object_put_pages_gtt(struct drm_i915_gem_object *obj,
 	if (i915_gem_object_needs_bit17_swizzle(obj))
 		i915_gem_object_save_bit_17_swizzle(obj, pages);
 
+	mapping_clear_unevictable(file_inode(obj->base.filp)->i_mapping);
+
+	pagevec_init(&pvec);
 	for_each_sgt_page(page, sgt_iter, pages) {
 		if (obj->mm.dirty)
 			set_page_dirty(page);
@@ -2402,8 +2418,10 @@ i915_gem_object_put_pages_gtt(struct drm_i915_gem_object *obj,
 		if (obj->mm.madv == I915_MADV_WILLNEED)
 			mark_page_accessed(page);
 
-		put_page(page);
+		if (!pagevec_add(&pvec, page))
+			check_release_pagevec(&pvec);
 	}
+	check_release_pagevec(&pvec);
 	obj->mm.dirty = false;
 
 	sg_free_table(pages);
@@ -2526,6 +2544,7 @@ static int i915_gem_object_get_pages_gtt(struct drm_i915_gem_object *obj)
 	unsigned int sg_page_sizes;
 	gfp_t noreclaim;
 	int ret;
+	struct pagevec pvec;
 
 	/*
 	 * Assert that the object is not currently in any GPU domain. As it
@@ -2559,6 +2578,7 @@ static int i915_gem_object_get_pages_gtt(struct drm_i915_gem_object *obj)
 	 * Fail silently without starting the shrinker
 	 */
 	mapping = obj->base.filp->f_mapping;
+	mapping_set_unevictable(mapping);
 	noreclaim = mapping_gfp_constraint(mapping, ~__GFP_RECLAIM);
 	noreclaim |= __GFP_NORETRY | __GFP_NOWARN;
 
@@ -2673,8 +2693,12 @@ static int i915_gem_object_get_pages_gtt(struct drm_i915_gem_object *obj)
 err_sg:
 	sg_mark_end(sg);
 err_pages:
+	mapping_clear_unevictable(mapping);
+	pagevec_init(&pvec);
 	for_each_sgt_page(page, sgt_iter, st)
-		put_page(page);
+		if (!pagevec_add(&pvec, page))
+			check_release_pagevec(&pvec);
+	check_release_pagevec(&pvec);
 	sg_free_table(st);
 	kfree(st);
 
diff --git a/include/linux/swap.h b/include/linux/swap.h
index d8a07a4f171d..a8f6d5d89524 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -18,6 +18,8 @@ struct notifier_block;
 
 struct bio;
 
+struct pagevec;
+
 #define SWAP_FLAG_PREFER	0x8000	/* set if swap priority specified */
 #define SWAP_FLAG_PRIO_MASK	0x7fff
 #define SWAP_FLAG_PRIO_SHIFT	0
@@ -369,7 +371,7 @@ static inline int node_reclaim(struct pglist_data *pgdat, gfp_t mask,
 #endif
 
 extern int page_evictable(struct page *page);
-extern void check_move_unevictable_pages(struct page **, int nr_pages);
+extern void check_move_unevictable_pages(struct pagevec *pvec);
 
 extern int kswapd_run(int nid);
 extern void kswapd_stop(int nid);
diff --git a/mm/shmem.c b/mm/shmem.c
index ea26d7a0342d..de4893c904a3 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -756,7 +756,7 @@ void shmem_unlock_mapping(struct address_space *mapping)
 			break;
 		index = indices[pvec.nr - 1] + 1;
 		pagevec_remove_exceptionals(&pvec);
-		check_move_unevictable_pages(pvec.pages, pvec.nr);
+		check_move_unevictable_pages(&pvec);
 		pagevec_release(&pvec);
 		cond_resched();
 	}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 62ac0c488624..d070f431ff19 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -50,6 +50,7 @@
 #include <linux/printk.h>
 #include <linux/dax.h>
 #include <linux/psi.h>
+#include <linux/pagevec.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -4182,17 +4183,16 @@ int page_evictable(struct page *page)
 	return ret;
 }
 
-#ifdef CONFIG_SHMEM
 /**
- * check_move_unevictable_pages - check pages for evictability and move to appropriate zone lru list
- * @pages:	array of pages to check
- * @nr_pages:	number of pages to check
+ * check_move_unevictable_pages - check pages for evictability and move to
+ * appropriate zone lru list
+ * @pvec: pagevec with lru pages to check
  *
- * Checks pages for evictability and moves them to the appropriate lru list.
- *
- * This function is only used for SysV IPC SHM_UNLOCK.
+ * Checks pages for evictability, if an evictable page is in the unevictable
+ * lru list, moves it to the appropriate evictable lru list. This function
+ * should be only used for lru pages.
  */
-void check_move_unevictable_pages(struct page **pages, int nr_pages)
+void check_move_unevictable_pages(struct pagevec *pvec)
 {
 	struct lruvec *lruvec;
 	struct pglist_data *pgdat = NULL;
@@ -4200,8 +4200,8 @@ void check_move_unevictable_pages(struct page **pages, int nr_pages)
 	int pgrescued = 0;
 	int i;
 
-	for (i = 0; i < nr_pages; i++) {
-		struct page *page = pages[i];
+	for (i = 0; i < pvec->nr; i++) {
+		struct page *page = pvec->pages[i];
 		struct pglist_data *pagepgdat = page_pgdat(page);
 
 		pgscanned++;
@@ -4233,4 +4233,4 @@ void check_move_unevictable_pages(struct page **pages, int nr_pages)
 		spin_unlock_irq(&pgdat->lru_lock);
 	}
 }
-#endif /* CONFIG_SHMEM */
+EXPORT_SYMBOL_GPL(check_move_unevictable_pages);
-- 
2.19.1.930.g4563a0d9d0-goog

