Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86313C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A077240E3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A077240E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753436AbeGEG7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:59:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:22778 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752681AbeGEG7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:59:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 23:59:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,311,1526367600"; 
   d="scan'208";a="64302111"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jul 2018 23:59:15 -0700
Subject: [PATCH 03/13] mm: Teach memmap_init_zone() to initialize
 ZONE_DEVICE pages
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, vishal.l.verma@intel.com,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 04 Jul 2018 23:49:18 -0700
Message-ID: <153077335821.40830.17705033415231166642.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153077334130.40830.2714147692560185329.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153077334130.40830.2714147692560185329.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than run a loop over the freshly initialized pages in
devm_memremap_pages() *after* arch_add_memory() returns, teach
memmap_init_zone() to return the pages fully initialized. This is in
preparation for multi-threading page initialization work, but it also
has some straight line performance benefits to not incur another loop of
cache misses across a large (100s of GBs to TBs) address range.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 kernel/memremap.c |   16 +---------------
 mm/page_alloc.c   |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/kernel/memremap.c b/kernel/memremap.c
index b861fe909932..85e4a7c576b2 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -173,8 +173,8 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap,
 	struct vmem_altmap *altmap = pgmap->altmap_valid ?
 			&pgmap->altmap : NULL;
 	struct resource *res = &pgmap->res;
-	unsigned long pfn, pgoff, order;
 	pgprot_t pgprot = PAGE_KERNEL;
+	unsigned long pgoff, order;
 	int error, nid, is_ram;
 
 	if (!pgmap->ref || !kill)
@@ -251,20 +251,6 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap,
 	if (error)
 		goto err_add_memory;
 
-	for_each_device_pfn(pfn, pgmap) {
-		struct page *page = pfn_to_page(pfn);
-
-		/*
-		 * ZONE_DEVICE pages union ->lru with a ->pgmap back
-		 * pointer.  It is a bug if a ZONE_DEVICE page is ever
-		 * freed or placed on a driver-private list.  Seed the
-		 * storage with LIST_POISON* values.
-		 */
-		list_del(&page->lru);
-		page->pgmap = pgmap;
-		percpu_ref_get(pgmap->ref);
-	}
-
 	pgmap->kill = kill;
 	error = devm_add_action_or_reset(dev, devm_memremap_pages_release,
 			pgmap);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f83682ef006e..fb45cfeb4a50 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5548,6 +5548,25 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
 			cond_resched();
 		}
+
+		if (is_zone_device_page(page)) {
+			if (WARN_ON_ONCE(!pgmap))
+				continue;
+
+			/* skip invalid device pages */
+			if (altmap && (pfn < (altmap->base_pfn
+						+ vmem_altmap_offset(altmap))))
+				continue;
+			/*
+			 * ZONE_DEVICE pages union ->lru with a ->pgmap back
+			 * pointer.  It is a bug if a ZONE_DEVICE page is ever
+			 * freed or placed on a driver-private list.  Seed the
+			 * storage with poison.
+			 */
+			page->lru.prev = LIST_POISON2;
+			page->pgmap = pgmap;
+			percpu_ref_get(pgmap->ref);
+		}
 	}
 }
 

