Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756673AbeDZPGZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 11:06:25 -0400
Received: from mail.netline.ch ([148.251.143.178]:56512 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756611AbeDZPGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 11:06:23 -0400
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Roger He <Hongbo.He@amd.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/ttm: Add TTM_PAGE_FLAG_TRANSHUGE
Date: Thu, 26 Apr 2018 17:06:17 +0200
Message-Id: <20180426150618.13470-1-michel@daenzer.net>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michel Dänzer <michel.daenzer@amd.com>

When it's set, TTM tries to allocate huge pages if possible. Drivers
which can take advantage of huge pages should set it.

Drivers not setting this flag no longer incur any overhead related to
allocating or freeing huge pages.

Cc: stable@vger.kernel.org
Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c  |  2 +-
 drivers/gpu/drm/ttm/ttm_page_alloc.c     | 14 ++++++++++----
 drivers/gpu/drm/ttm/ttm_page_alloc_dma.c |  8 +++++---
 include/drm/ttm/ttm_tt.h                 |  1 +
 4 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index dfd22db13fb1..e03e9e361e2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -988,7 +988,7 @@ static struct ttm_tt *amdgpu_ttm_tt_create(struct ttm_buffer_object *bo,
 		return NULL;
 	}
 	gtt->ttm.ttm.func = &amdgpu_backend_func;
-	if (ttm_sg_tt_init(&gtt->ttm, bo, page_flags)) {
+	if (ttm_sg_tt_init(&gtt->ttm, bo, page_flags | TTM_PAGE_FLAG_TRANSHUGE)) {
 		kfree(gtt);
 		return NULL;
 	}
diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc.c b/drivers/gpu/drm/ttm/ttm_page_alloc.c
index f0481b7b60c5..2ce91272b111 100644
--- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
+++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
@@ -760,7 +760,7 @@ static void ttm_put_pages(struct page **pages, unsigned npages, int flags,
 {
 	struct ttm_page_pool *pool = ttm_get_pool(flags, false, cstate);
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	struct ttm_page_pool *huge = ttm_get_pool(flags, true, cstate);
+	struct ttm_page_pool *huge = NULL;
 #endif
 	unsigned long irq_flags;
 	unsigned i;
@@ -780,7 +780,8 @@ static void ttm_put_pages(struct page **pages, unsigned npages, int flags,
 			}
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-			if (!(flags & TTM_PAGE_FLAG_DMA32)) {
+			if ((flags & (TTM_PAGE_FLAG_DMA32 | TTM_PAGE_FLAG_TRANSHUGE)) ==
+			    TTM_PAGE_FLAG_TRANSHUGE) {
 				for (j = 0; j < HPAGE_PMD_NR; ++j)
 					if (p++ != pages[i + j])
 					    break;
@@ -805,6 +806,8 @@ static void ttm_put_pages(struct page **pages, unsigned npages, int flags,
 
 	i = 0;
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (flags & TTM_PAGE_FLAG_TRANSHUGE)
+		huge = ttm_get_pool(flags, true, cstate);
 	if (huge) {
 		unsigned max_size, n2free;
 
@@ -877,7 +880,7 @@ static int ttm_get_pages(struct page **pages, unsigned npages, int flags,
 {
 	struct ttm_page_pool *pool = ttm_get_pool(flags, false, cstate);
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	struct ttm_page_pool *huge = ttm_get_pool(flags, true, cstate);
+	struct ttm_page_pool *huge = NULL;
 #endif
 	struct list_head plist;
 	struct page *p = NULL;
@@ -906,7 +909,8 @@ static int ttm_get_pages(struct page **pages, unsigned npages, int flags,
 
 		i = 0;
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-		if (!(gfp_flags & GFP_DMA32)) {
+		if ((flags & (TTM_PAGE_FLAG_DMA32 | TTM_PAGE_FLAG_TRANSHUGE)) ==
+		    TTM_PAGE_FLAG_TRANSHUGE) {
 			while (npages >= HPAGE_PMD_NR) {
 				gfp_t huge_flags = gfp_flags;
 
@@ -946,6 +950,8 @@ static int ttm_get_pages(struct page **pages, unsigned npages, int flags,
 	count = 0;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (flags & TTM_PAGE_FLAG_TRANSHUGE)
+		huge = ttm_get_pool(flags, true, cstate);
 	if (huge && npages >= HPAGE_PMD_NR) {
 		INIT_LIST_HEAD(&plist);
 		ttm_page_pool_get_pages(huge, &plist, flags, cstate,
diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
index 8a25d1974385..291b04213ec5 100644
--- a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
+++ b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
@@ -949,7 +949,8 @@ int ttm_dma_populate(struct ttm_dma_tt *ttm_dma, struct device *dev,
 	type = ttm_to_type(ttm->page_flags, ttm->caching_state);
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (ttm->page_flags & TTM_PAGE_FLAG_DMA32)
+	if ((ttm->page_flags & (TTM_PAGE_FLAG_DMA32 | TTM_PAGE_FLAG_TRANSHUGE))
+	    != TTM_PAGE_FLAG_TRANSHUGE)
 		goto skip_huge;
 
 	pool = ttm_dma_find_pool(dev, type | IS_HUGE);
@@ -1035,7 +1036,7 @@ void ttm_dma_unpopulate(struct ttm_dma_tt *ttm_dma, struct device *dev)
 {
 	struct ttm_tt *ttm = &ttm_dma->ttm;
 	struct ttm_mem_global *mem_glob = ttm->bdev->glob->mem_glob;
-	struct dma_pool *pool;
+	struct dma_pool *pool = NULL;
 	struct dma_page *d_page, *next;
 	enum pool_type type;
 	bool is_cached = false;
@@ -1045,7 +1046,8 @@ void ttm_dma_unpopulate(struct ttm_dma_tt *ttm_dma, struct device *dev)
 	type = ttm_to_type(ttm->page_flags, ttm->caching_state);
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	pool = ttm_dma_find_pool(dev, type | IS_HUGE);
+	if (ttm->page_flags & TTM_PAGE_FLAG_TRANSHUGE)
+		pool = ttm_dma_find_pool(dev, type | IS_HUGE);
 	if (pool) {
 		count = 0;
 		list_for_each_entry_safe(d_page, next, &ttm_dma->pages_list,
diff --git a/include/drm/ttm/ttm_tt.h b/include/drm/ttm/ttm_tt.h
index c0e928abf592..c7d2120f0362 100644
--- a/include/drm/ttm/ttm_tt.h
+++ b/include/drm/ttm/ttm_tt.h
@@ -41,6 +41,7 @@ struct ttm_operation_ctx;
 #define TTM_PAGE_FLAG_DMA32           (1 << 7)
 #define TTM_PAGE_FLAG_SG              (1 << 8)
 #define TTM_PAGE_FLAG_NO_RETRY	      (1 << 9)
+#define TTM_PAGE_FLAG_TRANSHUGE       (1 << 10)
 
 enum ttm_caching_state {
 	tt_uncached,
-- 
2.17.0
