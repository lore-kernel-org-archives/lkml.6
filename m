Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EB4ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0C3206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0C3206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbeGPRjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:39:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:28780 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728129AbeGPRjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:39:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 10:10:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,362,1526367600"; 
   d="scan'208";a="58100609"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006.jf.intel.com with ESMTP; 16 Jul 2018 10:10:45 -0700
Subject: [PATCH v2 05/14] mm, memremap: Up-level foreach_order_pgoff()
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Matthew Wilcox <willy@infradead.org>, vishal.l.verma@intel.com,
        hch@lst.de, linux-mm@kvack.org, jack@suse.cz,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Mon, 16 Jul 2018 10:00:48 -0700
Message-ID: <153176044796.12695.10692625606054072713.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153176041838.12695.3365448145295112857.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153176041838.12695.3365448145295112857.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The foreach_order_pgoff() helper takes advantage of the ability to
insert multi-order entries into a radix. It is currently used by
devm_memremap_pages() to minimize the number of entries in the pgmap
radix. Instead of dividing a range by a constant power-of-2 sized unit
and inserting an entry for each unit, it determines the maximum
power-of-2 sized entry (subject to alignment offset) that can be
inserted at each iteration.

Up-level this helper so it can be used for populating other radix
instances. For example asynchronous-memmap-initialization-thread lookups
arriving in a follow on change.

Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/memremap.h |   25 +++++++++++++++++++++++++
 kernel/memremap.c        |   25 -------------------------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index bfdc7363b13b..bff314de3f55 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -126,6 +126,31 @@ struct dev_pagemap {
 	enum memory_type type;
 };
 
+static inline unsigned long order_at(struct resource *res, unsigned long pgoff)
+{
+	unsigned long phys_pgoff = PHYS_PFN(res->start) + pgoff;
+	unsigned long nr_pages, mask;
+
+	nr_pages = PHYS_PFN(resource_size(res));
+	if (nr_pages == pgoff)
+		return ULONG_MAX;
+
+	/*
+	 * What is the largest aligned power-of-2 range available from
+	 * this resource pgoff to the end of the resource range,
+	 * considering the alignment of the current pgoff?
+	 */
+	mask = phys_pgoff | rounddown_pow_of_two(nr_pages - pgoff);
+	if (!mask)
+		return ULONG_MAX;
+
+	return find_first_bit(&mask, BITS_PER_LONG);
+}
+
+#define foreach_order_pgoff(res, order, pgoff) \
+	for (pgoff = 0, order = order_at((res), pgoff); order < ULONG_MAX; \
+			pgoff += 1UL << order, order = order_at((res), pgoff))
+
 #ifdef CONFIG_ZONE_DEVICE
 void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap,
 		void (*kill)(struct percpu_ref *));
diff --git a/kernel/memremap.c b/kernel/memremap.c
index 85e4a7c576b2..fc2f28033460 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -16,31 +16,6 @@ static RADIX_TREE(pgmap_radix, GFP_KERNEL);
 #define SECTION_MASK ~((1UL << PA_SECTION_SHIFT) - 1)
 #define SECTION_SIZE (1UL << PA_SECTION_SHIFT)
 
-static unsigned long order_at(struct resource *res, unsigned long pgoff)
-{
-	unsigned long phys_pgoff = PHYS_PFN(res->start) + pgoff;
-	unsigned long nr_pages, mask;
-
-	nr_pages = PHYS_PFN(resource_size(res));
-	if (nr_pages == pgoff)
-		return ULONG_MAX;
-
-	/*
-	 * What is the largest aligned power-of-2 range available from
-	 * this resource pgoff to the end of the resource range,
-	 * considering the alignment of the current pgoff?
-	 */
-	mask = phys_pgoff | rounddown_pow_of_two(nr_pages - pgoff);
-	if (!mask)
-		return ULONG_MAX;
-
-	return find_first_bit(&mask, BITS_PER_LONG);
-}
-
-#define foreach_order_pgoff(res, order, pgoff) \
-	for (pgoff = 0, order = order_at((res), pgoff); order < ULONG_MAX; \
-			pgoff += 1UL << order, order = order_at((res), pgoff))
-
 #if IS_ENABLED(CONFIG_DEVICE_PRIVATE)
 int device_private_entry_fault(struct vm_area_struct *vma,
 		       unsigned long addr,

