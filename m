Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C953FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BE020855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MAme0Iyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BE020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeKISEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 13:04:33 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39251 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeKISEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 13:04:33 -0500
Received: by mail-pg1-f194.google.com with SMTP id r9-v6so552391pgv.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 00:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=InnuhSOGBaveThAeEjWNNfjdxk+ZL+DS5Ky3lmpgzcQ=;
        b=MAme0Iyr8teK/Ki5Pc6avc9NyM1ZACSxW+qUvWNMrPDfd+5+hhO3XR+a7YzIULs9Xw
         LTuccIQILw7lwgZkGKEYJ8IkgnwH17FFLvdUjMzhtytWGx+RpaPlb9jroe0/Joy2LiKV
         ehgDDj7Tu9x1mC2VMBhEPgXrCnbFfg6c2FBlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=InnuhSOGBaveThAeEjWNNfjdxk+ZL+DS5Ky3lmpgzcQ=;
        b=tVclQ/eEIM0pwvY3Vs74CBuKbZoDTTtaJW9fVU97n3edmRSQrtsDikzEnwlOno3c4V
         SmlrIZYh/ybhSu4hI277p6nHL09wkUfPypz5WqLETI0ZPJmpv5sDjYFfRkJvb9HBY5p/
         D8pMmyhzFMZeCGIA6vleJG9GC30ODnHFPaeXHt51BqI+5Va9cpOFvgXwkKRKXXDek6BX
         iWNsRG0FD1JthOD4uXMq/uqVIxwMKcXl/CO3oRdhZutNFyfaMcrHOCTQg6YoVKACdtHr
         y54JoYeR9XkyGs/WLtei1M7N256K8586c8VCQpqROqOlrCzdW7Xf1r2tEegdyKcciBV3
         Lw9Q==
X-Gm-Message-State: AGRZ1gIi1jDsb8sGH/03fCG9DhJ40uegcg7bV7qlcVIRJ5LHUguJmq9s
        Sz4GH10tVFYrDFWN1i9XWJqCLQ==
X-Google-Smtp-Source: AJdET5f+WYjZSeRCglfwtnuJ6P5AzPDF6WiYotJEhF1tiG0JcbiXu7QnCbiBFLT3EFeBo3Z6Nv0E6w==
X-Received: by 2002:a62:5e83:: with SMTP id s125-v6mr7944253pfb.232.1541751902866;
        Fri, 09 Nov 2018 00:25:02 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
        by smtp.gmail.com with ESMTPSA id u2-v6sm6415667pfn.50.2018.11.09.00.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 00:25:02 -0800 (PST)
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
        Levin Alexander <alexander.levin@verizon.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com
Subject: [PATCH RFC 1/3] mm: When CONFIG_ZONE_DMA32 is set, use DMA32 for SLAB_CACHE_DMA
Date:   Fri,  9 Nov 2018 16:24:46 +0800
Message-Id: <20181109082448.150302-2-drinkcat@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181109082448.150302-1-drinkcat@chromium.org>
References: <20181109082448.150302-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some callers, namely iommu/io-pgtable-arm-v7s, expect the physical
address returned by kmem_cache_alloc with GFP_DMA parameter to be
a 32-bit address.

Instead of adding a separate SLAB_CACHE_DMA32 (and then audit
all the calls to check if they require memory from DMA or DMA32
zone), we simply allocate SLAB_CACHE_DMA cache in DMA32 region,
if CONFIG_ZONE_DMA32 is set.

Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 include/linux/slab.h | 13 ++++++++++++-
 mm/slab.c            |  2 +-
 mm/slub.c            |  2 +-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 918f374e7156f4..390afe90c5dec0 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -30,7 +30,7 @@
 #define SLAB_POISON		((slab_flags_t __force)0x00000800U)
 /* Align objs on cache lines */
 #define SLAB_HWCACHE_ALIGN	((slab_flags_t __force)0x00002000U)
-/* Use GFP_DMA memory */
+/* Use GFP_DMA or GFP_DMA32 memory */
 #define SLAB_CACHE_DMA		((slab_flags_t __force)0x00004000U)
 /* DEBUG: Store the last owner for bug hunting */
 #define SLAB_STORE_USER		((slab_flags_t __force)0x00010000U)
@@ -126,6 +126,17 @@
 #define ZERO_OR_NULL_PTR(x) ((unsigned long)(x) <= \
 				(unsigned long)ZERO_SIZE_PTR)
 
+/*
+ * When ZONE_DMA32 is defined, have SLAB_CACHE_DMA allocate memory with
+ * GFP_DMA32 instead of GFP_DMA, as this is what some of the callers
+ * require (instead of duplicating cache for DMA and DMA32 zones).
+ */
+#ifdef CONFIG_ZONE_DMA32
+#define SLAB_CACHE_DMA_GFP GFP_DMA32
+#else
+#define SLAB_CACHE_DMA_GFP GFP_DMA
+#endif
+
 #include <linux/kasan.h>
 
 struct mem_cgroup;
diff --git a/mm/slab.c b/mm/slab.c
index 2a5654bb3b3ff3..8810daa052dcdc 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2121,7 +2121,7 @@ int __kmem_cache_create(struct kmem_cache *cachep, slab_flags_t flags)
 	cachep->flags = flags;
 	cachep->allocflags = __GFP_COMP;
 	if (flags & SLAB_CACHE_DMA)
-		cachep->allocflags |= GFP_DMA;
+		cachep->allocflags |= SLAB_CACHE_DMA_GFP;
 	if (flags & SLAB_RECLAIM_ACCOUNT)
 		cachep->allocflags |= __GFP_RECLAIMABLE;
 	cachep->size = size;
diff --git a/mm/slub.c b/mm/slub.c
index e3629cd7aff164..fdd05323e54cbd 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3575,7 +3575,7 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
 		s->allocflags |= __GFP_COMP;
 
 	if (s->flags & SLAB_CACHE_DMA)
-		s->allocflags |= GFP_DMA;
+		s->allocflags |= SLAB_CACHE_DMA_GFP;
 
 	if (s->flags & SLAB_RECLAIM_ACCOUNT)
 		s->allocflags |= __GFP_RECLAIMABLE;
-- 
2.19.1.930.g4563a0d9d0-goog

