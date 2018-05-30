Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753152AbeE3LLA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:11:00 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60788 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752731AbeE3LHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:46 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Alex Deucher" <alexander.deucher@amd.com>,
        "Felix Kuehling" <Felix.Kuehling@amd.com>,
        "Christian =?UTF-8?Q?K=C3=B6nig?=" <christian.koenig@amd.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.717443662@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 054/153] drm/ttm: Don't add swapped BOs to swap-LRU list
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Kuehling <Felix.Kuehling@amd.com>

commit fd5002d6a3c602664b07668a24df4ef7a43bf078 upstream.

A BO that's already swapped would be added back to the swap-LRU list
for example if its validation failed under high memory pressure. This
could later lead to swapping it out again and leaking previous swap
storage.

This commit adds a condition to prevent that from happening.

v2: Check page_flags instead of swap_storage

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[bwh: Backported to 3.2: We aren't checking for TTM_PAGE_FLAG_SG here as that's
 not defined]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -184,7 +184,7 @@ void ttm_bo_add_to_lru(struct ttm_buffer
 		list_add_tail(&bo->lru, &man->lru);
 		kref_get(&bo->list_kref);
 
-		if (bo->ttm != NULL) {
+		if (bo->ttm && !(bo->ttm->page_flags & TTM_PAGE_FLAG_SWAPPED)) {
 			list_add_tail(&bo->swap, &bo->glob->swap_lru);
 			kref_get(&bo->list_kref);
 		}
