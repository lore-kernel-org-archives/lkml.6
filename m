Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809EDC0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 09:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494BB21104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 09:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l7Tlciw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494BB21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeKKSwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 13:52:07 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46320 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbeKKSwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 13:52:07 -0500
Received: by mail-pf1-f193.google.com with SMTP id s9-v6so2846479pfm.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 01:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tHCTBgMG+6sJtZR5onayP64SmgPAtqMgziPQMQVZWKM=;
        b=l7Tlciw4q3K/mse2HceMtZDnrFM6ck6HToUmTsxs8jqxQdGLn9fB6x8w53HsMNvnTH
         RnBzgCGqDhuWKFO2CQ9TnefxUQWJI887Ol18UPHXQRc6lSN2Sh2R6hpIxxjJ+4jlSsKA
         FUktM+/wIwGDOTQ3nu7H7NgmdVXxlN0Iya5bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tHCTBgMG+6sJtZR5onayP64SmgPAtqMgziPQMQVZWKM=;
        b=A+i3xSFV1WtmPAqcu+WiX/mMiarC00NQWSd+kWuW2dKDDh+Zim7gRYgyxbflaNTYGn
         pNyjjDdZpjsghsFs4CeMpvCSHLek5Q5JdIw4USvWJpkQ/0oqVJburdtbzJ5fdb0KdoLn
         sl3uiSAsFqjBoZ22iTBt/kvB1PikTQdfhgMAPTzbo356S++4tV/DOdoRBrxbviscOy1j
         XAj64l9I68u19Bwi2MyLGwpKRyhlKb0V1/P1bfOlxbAhEFeMbii3bWvx98PRG5VN0/1w
         xCVBkidS9fLORlSfdG7DhKB7QwEBNRt67FbvvMWf+g4TkQGGVatTuKt8MWNPmvbJplgd
         RhEg==
X-Gm-Message-State: AGRZ1gKkod5xMT01aWJlCozxaYSXy18Og81J2yabtUT0dXCjp9QCTD1v
        nijdgUElnqlj9pVXi0nJr05h0w==
X-Google-Smtp-Source: AJdET5fqOgcNWbxIYJn57HFqDYGS+E0e9yJHKY4fkrYGQEuWX7H6W4a2yVrcs3FVlRHmJiNJMxoaDA==
X-Received: by 2002:a63:920a:: with SMTP id o10mr13137383pgd.141.1541927046794;
        Sun, 11 Nov 2018 01:04:06 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
        by smtp.gmail.com with ESMTPSA id 69sm8107956pgg.86.2018.11.11.01.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 01:04:06 -0800 (PST)
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
Subject: [PATCH v2 1/3] mm: slab/slub: Add check_slab_flags function to check for valid flags
Date:   Sun, 11 Nov 2018 17:03:39 +0800
Message-Id: <20181111090341.120786-2-drinkcat@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181111090341.120786-1-drinkcat@chromium.org>
References: <20181111090341.120786-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicated code between slab and slub, and will make it
easier to make the test more complicated in the next commits.

Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 mm/internal.h | 17 +++++++++++++++--
 mm/slab.c     |  8 +-------
 mm/slub.c     |  8 +-------
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 3b1ec1412fd2cd..7a500b232e4a43 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -33,8 +33,22 @@
 /* Control allocation cpuset and node placement constraints */
 #define GFP_CONSTRAINT_MASK (__GFP_HARDWALL|__GFP_THISNODE)
 
-/* Do not use these with a slab allocator */
-#define GFP_SLAB_BUG_MASK (__GFP_DMA32|__GFP_HIGHMEM|~__GFP_BITS_MASK)
+/* Check for flags that must not be used with a slab allocator */
+static inline gfp_t check_slab_flags(gfp_t flags)
+{
+	gfp_t bug_mask = __GFP_DMA32 | __GFP_HIGHMEM | ~__GFP_BITS_MASK;
+
+	if (unlikely(flags & bug_mask)) {
+		gfp_t invalid_mask = flags & bug_mask;
+
+		flags &= ~bug_mask;
+		pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
+				invalid_mask, &invalid_mask, flags, &flags);
+		dump_stack();
+	}
+
+	return flags;
+}
 
 void page_writeback_init(void);
 
diff --git a/mm/slab.c b/mm/slab.c
index 2a5654bb3b3ff3..251e09a5a3ef5c 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2656,13 +2656,7 @@ static struct page *cache_grow_begin(struct kmem_cache *cachep,
 	 * Be lazy and only check for valid flags here,  keeping it out of the
 	 * critical path in kmem_cache_alloc().
 	 */
-	if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
-		gfp_t invalid_mask = flags & GFP_SLAB_BUG_MASK;
-		flags &= ~GFP_SLAB_BUG_MASK;
-		pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
-				invalid_mask, &invalid_mask, flags, &flags);
-		dump_stack();
-	}
+	flags = check_slab_flags(flags);
 	WARN_ON_ONCE(cachep->ctor && (flags & __GFP_ZERO));
 	local_flags = flags & (GFP_CONSTRAINT_MASK|GFP_RECLAIM_MASK);
 
diff --git a/mm/slub.c b/mm/slub.c
index e3629cd7aff164..1cca562bebdc8d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1681,13 +1681,7 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 
 static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
 {
-	if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
-		gfp_t invalid_mask = flags & GFP_SLAB_BUG_MASK;
-		flags &= ~GFP_SLAB_BUG_MASK;
-		pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
-				invalid_mask, &invalid_mask, flags, &flags);
-		dump_stack();
-	}
+	flags = check_slab_flags(flags);
 
 	return allocate_slab(s,
 		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
-- 
2.19.1.930.g4563a0d9d0-goog

