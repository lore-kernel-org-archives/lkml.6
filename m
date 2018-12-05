Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97497C07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0E620878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RJSBonDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0E620878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbeLEFsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 00:48:52 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40554 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbeLEFsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 00:48:50 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so9443654pfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 21:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mtj+5lLpDKXzv34oRdlikvP0Q/L3pkB7CbeDcaUQ2ak=;
        b=RJSBonDDmVEWs69m9HOjZuGuqOpCHmEu3NrRrK9BUoJUXpNKmfFBa/K9sBDN9HQqGh
         2ZMUshSZxpFyy3R/xn0fNdnzD/OwClqvrwVW7yxt56sC7V8w/aBqcc+M6P6ZdmJBInbV
         xpbXCfLfeacU+cokjOF3Z/mV3EHPLT5eakXq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mtj+5lLpDKXzv34oRdlikvP0Q/L3pkB7CbeDcaUQ2ak=;
        b=QKr5tUt5vXDG0Ofzf7Tqs0kcrPJSn2IGCpy7dHDsfK7xEpwtLZI2O8ktDeb6eNagFe
         6DBByPMbjya7g8LDGQMluEVnCUGuTamaxIp2LmISwyjPYN1FYP4ZsJZm5YQnwAVeRxOO
         3CdiD51m1n2eqToKs1S1DpYUbNDNFeA+5RcIUkCzhzV5DcH7OON8F5FIkd5O7F2vunsB
         mrbK52UpBT6Lq9mGoX0GUFTVQlJyTHtfkAjcv7bnI2oRmsEszdmoEwC8ME5w0f5/wBfL
         s2/K22Su1EyqP72VtqOSp945rqexyuyLUeDrAID5KEYnK5KuFUIAVdBj1Uf25FfZ9+YN
         daaQ==
X-Gm-Message-State: AA+aEWan/COISHzlMLTYkF4Hht2p7S3lErFjO3NJP1wNN/cHHtOG781m
        e3GW3ztGzE/zdbPMEYoA7Hyy1g==
X-Google-Smtp-Source: AFSGD/XIZbASUT86Hq6bBLcbgIr8yOKCqq/M0hjDPq1OmQpZfK1rdsqT2OjTw5YTsOUmsgwtOM+HyQ==
X-Received: by 2002:a62:7dcb:: with SMTP id y194mr23238987pfc.113.1543988930153;
        Tue, 04 Dec 2018 21:48:50 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
        by smtp.gmail.com with ESMTPSA id 4sm30806513pfq.10.2018.12.04.21.48.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 21:48:49 -0800 (PST)
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
        hch@infradead.org, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 1/3] mm: slab/slub: Add check_slab_flags function to check for valid flags
Date:   Wed,  5 Dec 2018 13:48:26 +0800
Message-Id: <20181205054828.183476-2-drinkcat@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181205054828.183476-1-drinkcat@chromium.org>
References: <20181205054828.183476-1-drinkcat@chromium.org>
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
 mm/internal.h | 18 ++++++++++++++++--
 mm/slab.c     |  8 +-------
 mm/slub.c     |  8 +-------
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index f0c9ccde3bdb9e..a2ee82a0cd44ae 100644
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
index 73fe23e649c91a..65a774f05e7836 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2643,13 +2643,7 @@ static struct page *cache_grow_begin(struct kmem_cache *cachep,
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
index c229a9b7dd5448..21a3f6866da472 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1685,13 +1685,7 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 
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
2.20.0.rc1.387.gf8505762e3-goog

