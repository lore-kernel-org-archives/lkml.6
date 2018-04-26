Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756647AbeDZPGY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 11:06:24 -0400
Received: from mail.netline.ch ([148.251.143.178]:56507 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756204AbeDZPGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 11:06:23 -0400
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Roger He <Hongbo.He@amd.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/ttm: Use GFP_TRANSHUGE_LIGHT for allocating huge pages
Date: Thu, 26 Apr 2018 17:06:18 +0200
Message-Id: <20180426150618.13470-2-michel@daenzer.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180426150618.13470-1-michel@daenzer.net>
References: <20180426150618.13470-1-michel@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michel Dänzer <michel.daenzer@amd.com>

GFP_TRANSHUGE tries very hard to allocate huge pages, which can result
in long delays with high memory pressure. I have observed firefox
freezing for up to around a minute due to this while restic was taking
a full system backup.

Since we don't really need huge pages, use GFP_TRANSHUGE_LIGHT |
__GFP_NORETRY instead, in order to fail quickly when there are no huge
pages available.

Set __GFP_KSWAPD_RECLAIM as well, in order for huge pages to be freed
up in the background if necessary.

With these changes, I'm no longer seeing freezes during a restic backup.

Cc: stable@vger.kernel.org
Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
---
 drivers/gpu/drm/ttm/ttm_page_alloc.c     | 11 ++++++++---
 drivers/gpu/drm/ttm/ttm_page_alloc_dma.c |  3 ++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc.c b/drivers/gpu/drm/ttm/ttm_page_alloc.c
index 2ce91272b111..6794f15461d9 100644
--- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
+++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
@@ -914,7 +914,8 @@ static int ttm_get_pages(struct page **pages, unsigned npages, int flags,
 			while (npages >= HPAGE_PMD_NR) {
 				gfp_t huge_flags = gfp_flags;
 
-				huge_flags |= GFP_TRANSHUGE;
+				huge_flags |= GFP_TRANSHUGE_LIGHT | __GFP_NORETRY |
+					__GFP_KSWAPD_RECLAIM;
 				huge_flags &= ~__GFP_MOVABLE;
 				huge_flags &= ~__GFP_COMP;
 				p = alloc_pages(huge_flags, HPAGE_PMD_ORDER);
@@ -1033,11 +1034,15 @@ int ttm_page_alloc_init(struct ttm_mem_global *glob, unsigned max_pages)
 				  GFP_USER | GFP_DMA32, "uc dma", 0);
 
 	ttm_page_pool_init_locked(&_manager->wc_pool_huge,
-				  GFP_TRANSHUGE	& ~(__GFP_MOVABLE | __GFP_COMP),
+				  (GFP_TRANSHUGE_LIGHT | __GFP_NORETRY |
+				   __GFP_KSWAPD_RECLAIM) &
+				  ~(__GFP_MOVABLE | __GFP_COMP),
 				  "wc huge", order);
 
 	ttm_page_pool_init_locked(&_manager->uc_pool_huge,
-				  GFP_TRANSHUGE	& ~(__GFP_MOVABLE | __GFP_COMP)
+				  (GFP_TRANSHUGE_LIGHT | __GFP_NORETRY |
+				   __GFP_KSWAPD_RECLAIM) &
+				  ~(__GFP_MOVABLE | __GFP_COMP)
 				  , "uc huge", order);
 
 	_manager->options.max_size = max_pages;
diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
index 291b04213ec5..5a551158c289 100644
--- a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
+++ b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
@@ -910,7 +910,8 @@ static gfp_t ttm_dma_pool_gfp_flags(struct ttm_dma_tt *ttm_dma, bool huge)
 		gfp_flags |= __GFP_ZERO;
 
 	if (huge) {
-		gfp_flags |= GFP_TRANSHUGE;
+		gfp_flags |= GFP_TRANSHUGE_LIGHT | __GFP_NORETRY |
+			__GFP_KSWAPD_RECLAIM;
 		gfp_flags &= ~__GFP_MOVABLE;
 		gfp_flags &= ~__GFP_COMP;
 	}
-- 
2.17.0
