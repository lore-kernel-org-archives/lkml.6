Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF804C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BF321738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfAIQkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:40:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:57516 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726551AbfAIQki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:40:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 500A7AF74;
        Wed,  9 Jan 2019 16:40:37 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Joe Perches <joe@perches.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 02/15] mm/vmalloc: move common logic from  __vmalloc_area_node to a separate func
Date:   Wed,  9 Jan 2019 17:40:12 +0100
Message-Id: <20190109164025.24554-3-rpenyaev@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190109164025.24554-1-rpenyaev@suse.de>
References: <20190109164025.24554-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This one moves logic related to pages array creation to a separate
function, which will be used by vrealloc() call as well, which
implementation will follow.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Joe Perches <joe@perches.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/vmalloc.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 4851b4a67f55..ad6cd807f6db 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1662,21 +1662,26 @@ EXPORT_SYMBOL(vmap);
 static void *__vmalloc_node(unsigned long size, unsigned long align,
 			    gfp_t gfp_mask, pgprot_t prot,
 			    int node, const void *caller);
-static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
-				 pgprot_t prot, int node)
+
+static int alloc_vm_area_array(struct vm_struct *area, gfp_t gfp_mask, int node)
 {
+	unsigned int nr_pages, array_size;
 	struct page **pages;
-	unsigned int nr_pages, array_size, i;
+
 	const gfp_t nested_gfp = (gfp_mask & GFP_RECLAIM_MASK) | __GFP_ZERO;
-	const gfp_t alloc_mask = gfp_mask | __GFP_NOWARN;
 	const gfp_t highmem_mask = (gfp_mask & (GFP_DMA | GFP_DMA32)) ?
 					0 :
 					__GFP_HIGHMEM;
 
+	if (WARN_ON(area->pages))
+		return -EINVAL;
+
 	nr_pages = get_vm_area_size(area) >> PAGE_SHIFT;
+	if (!nr_pages)
+		return -EINVAL;
+
 	array_size = (nr_pages * sizeof(struct page *));
 
-	area->nr_pages = nr_pages;
 	/* Please note that the recursion is strictly bounded. */
 	if (array_size > PAGE_SIZE) {
 		pages = __vmalloc_node(array_size, 1, nested_gfp|highmem_mask,
@@ -1684,8 +1689,25 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	} else {
 		pages = kmalloc_node(array_size, nested_gfp, node);
 	}
+	if (!pages)
+		return -ENOMEM;
+
+	area->nr_pages = nr_pages;
 	area->pages = pages;
-	if (!area->pages) {
+
+	return 0;
+}
+
+static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
+				 pgprot_t prot, int node)
+{
+	const gfp_t alloc_mask = gfp_mask | __GFP_NOWARN;
+	const gfp_t highmem_mask = (gfp_mask & (GFP_DMA | GFP_DMA32)) ?
+					0 :
+					__GFP_HIGHMEM;
+	unsigned int i;
+
+	if (alloc_vm_area_array(area, gfp_mask, node)) {
 		remove_vm_area(area->addr);
 		kfree(area);
 		return NULL;
@@ -1709,7 +1731,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 			cond_resched();
 	}
 
-	if (map_vm_area(area, prot, pages))
+	if (map_vm_area(area, prot, area->pages))
 		goto fail;
 	return area->addr;
 
-- 
2.19.1

