Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB54DC65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98322064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ijv+q4uF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98322064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbeLJBPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 20:15:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40277 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbeLJBPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 20:15:24 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so4539701pfo.7
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 17:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v53ohYgIFcKZc+mDiZ2r46NylU67jRR5KKW/neccYeA=;
        b=ijv+q4uFF8KDF+QVUFKj4U7gDtHtuEMw2oXVDmRjV9m90MMKozoV1SK3nr52Wfp0/J
         ajATJ4LwgXlkyBvI59+Xz/whZ5lXnl1xFMyxaVDC48lOag5w3FEwkupx/cXvgovw0NEw
         a4MdWfhyHdW1vGax/L6Sp9Y541uDVzZX/hMKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v53ohYgIFcKZc+mDiZ2r46NylU67jRR5KKW/neccYeA=;
        b=SA3NKYA4IEyLRLpbHAjsr0LPEQHEiV/j9x9ERJBVfVqFCKKpOtrrPtvDs0QEqB/g7J
         IKnBt/WK3C5cuyWcFzv+AHCwMYFrD5tumG5KJhEZTyGW9/gBEiftfR/X+ymIfX3W8r+Y
         NolgNEkxaTI+YckHMxQt/Xthkylr271wqONHhKR7ZB8f/sHjNrwLsARX4HY5WHexrmVk
         PKLeNGB2AIbIomNMps0Stxq/KUYvuXwE8YumrIbcQL3bDCmyv09UJcGTkeLF0Iu3kHwD
         J17Fy7IM6oTlvPSbFlKRFRbF2oRe76qkrj8N4tZWF6BspuEc1/bMxYJDMnFjr6X+/Hdx
         mt3w==
X-Gm-Message-State: AA+aEWYvIKzVFBZL9NBaZ43qv7uTy9zfaJ3nhHppsJEF5U96E5RKmAGA
        65x1ajhhZWKAyGk50wKR8sDjKg==
X-Google-Smtp-Source: AFSGD/XQbPEpb5m4zF9JWDJwwHdQG1vS8O1vSqI9U4Qq0Ub4rwSWo9QtX4mH9YSjDkYW879bfhIqJw==
X-Received: by 2002:a63:194f:: with SMTP id 15mr9299413pgz.192.1544404524069;
        Sun, 09 Dec 2018 17:15:24 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
        by smtp.gmail.com with ESMTPSA id b10sm16516336pfj.183.2018.12.09.17.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 17:15:23 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Levin Alexander <Alexander.Levin@microsoft.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com,
        hch@infradead.org, Matthew Wilcox <willy@infradead.org>,
        hsinyi@chromium.org, stable@vger.kernel.org
Subject: [PATCH v6 1/3] mm: Add support for kmem caches in DMA32 zone
Date:   Mon, 10 Dec 2018 09:15:02 +0800
Message-Id: <20181210011504.122604-2-drinkcat@chromium.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <20181210011504.122604-1-drinkcat@chromium.org>
References: <20181210011504.122604-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOMMUs using ARMv7 short-descriptor format require page tables
to be allocated within the first 4GB of RAM, even on 64-bit systems.
On arm64, this is done by passing GFP_DMA32 flag to memory allocation
functions.

For IOMMU L2 tables that only take 1KB, it would be a waste to allocate
a full page using get_free_pages, so we considered 3 approaches:
 1. This patch, adding support for GFP_DMA32 slab caches.
 2. genalloc, which requires pre-allocating the maximum number of L2
    page tables (4096, so 4MB of memory).
 3. page_frag, which is not very memory-efficient as it is unable
    to reuse freed fragments until the whole page is freed.

This change makes it possible to create a custom cache in DMA32 zone
using kmem_cache_create, then allocate memory using kmem_cache_alloc.

We do not create a DMA32 kmalloc cache array, as there are currently
no users of kmalloc(..., GFP_DMA32). These calls will continue to
trigger a warning, as we keep GFP_DMA32 in GFP_SLAB_BUG_MASK.

This implies that calls to kmem_cache_*alloc on a SLAB_CACHE_DMA32
kmem_cache must _not_ use GFP_DMA32 (it is anyway redundant and
unnecessary).

Cc: stable@vger.kernel.org
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---

Changes since v2:
 - Clarified commit message
 - Add entry in sysfs-kernel-slab to document the new sysfs file

(v3 used the page_frag approach)

Changes since v4:
 - Added details to commit message
 - Dropped change that removed GFP_DMA32 from GFP_SLAB_BUG_MASK:
   instead we can just call kmem_cache_*alloc without GFP_DMA32
   parameter. This also means that we can drop PATCH 1/3, as we
   do not make any changes in GFP flag verification.
 - Dropped hunks that added cache_dma32 sysfs file, and moved
   the hunks to PATCH 3/3, so that maintainer can decide whether
   to pick the change independently.

(no change since v5)

 include/linux/slab.h | 2 ++
 mm/slab.c            | 2 ++
 mm/slab.h            | 3 ++-
 mm/slab_common.c     | 2 +-
 mm/slub.c            | 5 +++++
 5 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 11b45f7ae4057c..9449b19c5f107a 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -32,6 +32,8 @@
 #define SLAB_HWCACHE_ALIGN	((slab_flags_t __force)0x00002000U)
 /* Use GFP_DMA memory */
 #define SLAB_CACHE_DMA		((slab_flags_t __force)0x00004000U)
+/* Use GFP_DMA32 memory */
+#define SLAB_CACHE_DMA32	((slab_flags_t __force)0x00008000U)
 /* DEBUG: Store the last owner for bug hunting */
 #define SLAB_STORE_USER		((slab_flags_t __force)0x00010000U)
 /* Panic if kmem_cache_create() fails */
diff --git a/mm/slab.c b/mm/slab.c
index 73fe23e649c91a..124f8c556d27fb 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2109,6 +2109,8 @@ int __kmem_cache_create(struct kmem_cache *cachep, slab_flags_t flags)
 	cachep->allocflags = __GFP_COMP;
 	if (flags & SLAB_CACHE_DMA)
 		cachep->allocflags |= GFP_DMA;
+	if (flags & SLAB_CACHE_DMA32)
+		cachep->allocflags |= GFP_DMA32;
 	if (flags & SLAB_RECLAIM_ACCOUNT)
 		cachep->allocflags |= __GFP_RECLAIMABLE;
 	cachep->size = size;
diff --git a/mm/slab.h b/mm/slab.h
index 4190c24ef0e9df..fcf717e12f0a86 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -127,7 +127,8 @@ static inline slab_flags_t kmem_cache_flags(unsigned int object_size,
 
 
 /* Legal flag mask for kmem_cache_create(), for various configurations */
-#define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | SLAB_PANIC | \
+#define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
+			 SLAB_CACHE_DMA32 | SLAB_PANIC | \
 			 SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS )
 
 #if defined(CONFIG_DEBUG_SLAB)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 70b0cc85db67f8..18b7b809c8d064 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -53,7 +53,7 @@ static DECLARE_WORK(slab_caches_to_rcu_destroy_work,
 		SLAB_FAILSLAB | SLAB_KASAN)
 
 #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
-			 SLAB_ACCOUNT)
+			 SLAB_CACHE_DMA32 | SLAB_ACCOUNT)
 
 /*
  * Merge control. If this is set then no merging of slab caches will occur.
diff --git a/mm/slub.c b/mm/slub.c
index c229a9b7dd5448..4caadb926838ef 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3583,6 +3583,9 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
 	if (s->flags & SLAB_CACHE_DMA)
 		s->allocflags |= GFP_DMA;
 
+	if (s->flags & SLAB_CACHE_DMA32)
+		s->allocflags |= GFP_DMA32;
+
 	if (s->flags & SLAB_RECLAIM_ACCOUNT)
 		s->allocflags |= __GFP_RECLAIMABLE;
 
@@ -5671,6 +5674,8 @@ static char *create_unique_id(struct kmem_cache *s)
 	 */
 	if (s->flags & SLAB_CACHE_DMA)
 		*p++ = 'd';
+	if (s->flags & SLAB_CACHE_DMA32)
+		*p++ = 'D';
 	if (s->flags & SLAB_RECLAIM_ACCOUNT)
 		*p++ = 'a';
 	if (s->flags & SLAB_CONSISTENCY_CHECKS)
-- 
2.20.0.rc2.403.gdbc3b29805-goog

