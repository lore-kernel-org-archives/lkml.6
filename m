Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74E6C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 09:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA502087C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 09:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eF3UiDtK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA502087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeKKSwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 13:52:11 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38081 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbeKKSwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 13:52:10 -0500
Received: by mail-pg1-f196.google.com with SMTP id f8-v6so2696636pgq.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 01:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KPUtoMHx+zKgWw/50SWdFRpPElnQtOmRn5WZTUEVzYs=;
        b=eF3UiDtKNpGLH8WDQRLmzM+lV68Qvk9qt98jNj/eWRr7yTj7wjQWF1pKGRyZXBAlGQ
         5fjUfzRE3brXvb77u6LrT66F3nBShPfa2Rju+ADlBiwz33Qo7SW4AaTP/CLlzen61UU9
         040zOTA/bUzkYsIGgDps0XsOwB+8LXkf0POOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KPUtoMHx+zKgWw/50SWdFRpPElnQtOmRn5WZTUEVzYs=;
        b=Thd7FhOJy5dok3ThfBD4ku561rMqbWdQsqJNlWVHN/CSUemTrmIHBGYh1473zO2XBX
         vuoGXbkBdcl8lJjCk8d8BAQg9umEij9iAhiQp1gHO4PF8cF17O4GU84bWTA+yMcwBcsB
         ym5zHLdAaVy5UInGVt/Lg5blD7dUp2PLsxI3HtPRsAqpon9BqtR04srgyHcq/l762/N3
         bKo+fXYWqTwi5nFSpp+xswQBf2+EpJUfWKZWoE/L68c3U3RMh93rrS82IkW6nKwmVHhJ
         vv6B8Eq64lPfpkkJJZ8adCI2F/esA/gBVzRkkZPEIwQUY615K1R1nTeWYCWwew1AK7MS
         JD5Q==
X-Gm-Message-State: AGRZ1gK5uYFRCfy7j/iOAaP01JEUQSDaFSKwoXyoi2y5+5cpW9I7xEp6
        4/XWRWIpTbdWG3u1wk/GoZlLDw==
X-Google-Smtp-Source: AJdET5f/RljYx3hHMrWqmXXwAtzTLJd4Rp8hdBqNgeWi6cSE9Td3CGTMfaHibnnZLHGJsOXrRRNlZQ==
X-Received: by 2002:a63:9a52:: with SMTP id e18mr13479722pgo.14.1541927050533;
        Sun, 11 Nov 2018 01:04:10 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
        by smtp.gmail.com with ESMTPSA id 69sm8107956pgg.86.2018.11.11.01.04.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 01:04:09 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>,
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
        Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com
Subject: [PATCH v2 2/3] mm: Add support for SLAB_CACHE_DMA32
Date:   Sun, 11 Nov 2018 17:03:40 +0800
Message-Id: <20181111090341.120786-3-drinkcat@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181111090341.120786-1-drinkcat@chromium.org>
References: <20181111090341.120786-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SLAB_CACHE_DMA32 is only available after explicit kmem_cache_create calls,
no default cache is created for kmalloc. Add a test in check_slab_flags
for this.

Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 include/linux/slab.h |  2 ++
 mm/internal.h        |  8 ++++++--
 mm/slab.c            |  4 +++-
 mm/slab.h            |  3 ++-
 mm/slab_common.c     |  2 +-
 mm/slub.c            | 18 +++++++++++++++++-
 6 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 918f374e7156f4..afc51ee1dae5d4 100644
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
diff --git a/mm/internal.h b/mm/internal.h
index 7a500b232e4a43..2aa9c8491d2ca2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -14,6 +14,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
+#include <linux/slab.h>
 #include <linux/tracepoint-defs.h>
 
 /*
@@ -34,9 +35,12 @@
 #define GFP_CONSTRAINT_MASK (__GFP_HARDWALL|__GFP_THISNODE)
 
 /* Check for flags that must not be used with a slab allocator */
-static inline gfp_t check_slab_flags(gfp_t flags)
+static inline gfp_t check_slab_flags(gfp_t flags, slab_flags_t slab_flags)
 {
-	gfp_t bug_mask = __GFP_DMA32 | __GFP_HIGHMEM | ~__GFP_BITS_MASK;
+	gfp_t bug_mask = __GFP_HIGHMEM | ~__GFP_BITS_MASK;
+
+	if (!IS_ENABLED(CONFIG_ZONE_DMA32) || !(slab_flags & SLAB_CACHE_DMA32))
+		bug_mask |= __GFP_DMA32;
 
 	if (unlikely(flags & bug_mask)) {
 		gfp_t invalid_mask = flags & bug_mask;
diff --git a/mm/slab.c b/mm/slab.c
index 251e09a5a3ef5c..6efcaad6a02b70 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2122,6 +2122,8 @@ int __kmem_cache_create(struct kmem_cache *cachep, slab_flags_t flags)
 	cachep->allocflags = __GFP_COMP;
 	if (flags & SLAB_CACHE_DMA)
 		cachep->allocflags |= GFP_DMA;
+	if (flags & SLAB_CACHE_DMA32)
+		cachep->allocflags |= GFP_DMA32;
 	if (flags & SLAB_RECLAIM_ACCOUNT)
 		cachep->allocflags |= __GFP_RECLAIMABLE;
 	cachep->size = size;
@@ -2656,7 +2658,7 @@ static struct page *cache_grow_begin(struct kmem_cache *cachep,
 	 * Be lazy and only check for valid flags here,  keeping it out of the
 	 * critical path in kmem_cache_alloc().
 	 */
-	flags = check_slab_flags(flags);
+	flags = check_slab_flags(flags, cachep->flags);
 	WARN_ON_ONCE(cachep->ctor && (flags & __GFP_ZERO));
 	local_flags = flags & (GFP_CONSTRAINT_MASK|GFP_RECLAIM_MASK);
 
diff --git a/mm/slab.h b/mm/slab.h
index 58c6c1c2a78ee3..9632772e14beb2 100644
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
index 7eb8dc136c1cb8..f204385553bbac 100644
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
index 1cca562bebdc8d..c639bd008e8c11 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1681,7 +1681,7 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 
 static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
 {
-	flags = check_slab_flags(flags);
+	flags = check_slab_flags(flags, s->flags);
 
 	return allocate_slab(s,
 		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
@@ -3571,6 +3571,9 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
 	if (s->flags & SLAB_CACHE_DMA)
 		s->allocflags |= GFP_DMA;
 
+	if (s->flags & SLAB_CACHE_DMA32)
+		s->allocflags |= GFP_DMA32;
+
 	if (s->flags & SLAB_RECLAIM_ACCOUNT)
 		s->allocflags |= __GFP_RECLAIMABLE;
 
@@ -5090,6 +5093,14 @@ static ssize_t cache_dma_show(struct kmem_cache *s, char *buf)
 SLAB_ATTR_RO(cache_dma);
 #endif
 
+#ifdef CONFIG_ZONE_DMA32
+static ssize_t cache_dma32_show(struct kmem_cache *s, char *buf)
+{
+	return sprintf(buf, "%d\n", !!(s->flags & SLAB_CACHE_DMA32));
+}
+SLAB_ATTR_RO(cache_dma32);
+#endif
+
 static ssize_t usersize_show(struct kmem_cache *s, char *buf)
 {
 	return sprintf(buf, "%u\n", s->usersize);
@@ -5430,6 +5441,9 @@ static struct attribute *slab_attrs[] = {
 #ifdef CONFIG_ZONE_DMA
 	&cache_dma_attr.attr,
 #endif
+#ifdef CONFIG_ZONE_DMA32
+	&cache_dma32_attr.attr,
+#endif
 #ifdef CONFIG_NUMA
 	&remote_node_defrag_ratio_attr.attr,
 #endif
@@ -5660,6 +5674,8 @@ static char *create_unique_id(struct kmem_cache *s)
 	 */
 	if (s->flags & SLAB_CACHE_DMA)
 		*p++ = 'd';
+	if (s->flags & SLAB_CACHE_DMA32)
+		*p++ = 'D';
 	if (s->flags & SLAB_RECLAIM_ACCOUNT)
 		*p++ = 'a';
 	if (s->flags & SLAB_CONSISTENCY_CHECKS)
-- 
2.19.1.930.g4563a0d9d0-goog

