Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755357AbeEaNzM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 09:55:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:44355 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755155AbeEaNzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 09:55:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="59243464"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 2/2] mm/page_ext: Constify lookup_page_ext() argument
Date: Thu, 31 May 2018 16:54:57 +0300
Message-Id: <20180531135457.20167-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180531135457.20167-1-kirill.shutemov@linux.intel.com>
References: <20180531135457.20167-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lookup_page_ext() finds 'struct page_ext' for a given page. It requires
only read access to the given struct page.

Current implemnentation takes 'struct page *' as an argument. It makes
compiler complain when 'const struct page *' passed.

Change the argument to 'const struct page *'.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 include/linux/page_ext.h | 4 ++--
 mm/page_ext.c            | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index bbec618a614b..f84f167ec04c 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -50,7 +50,7 @@ static inline void page_ext_init(void)
 }
 #endif
 
-struct page_ext *lookup_page_ext(struct page *page);
+struct page_ext *lookup_page_ext(const struct page *page);
 
 #else /* !CONFIG_PAGE_EXTENSION */
 struct page_ext;
@@ -59,7 +59,7 @@ static inline void pgdat_page_ext_init(struct pglist_data *pgdat)
 {
 }
 
-static inline struct page_ext *lookup_page_ext(struct page *page)
+static inline struct page_ext *lookup_page_ext(const struct page *page)
 {
 	return NULL;
 }
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 5295ef331165..a9826da84ccb 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -120,7 +120,7 @@ void __meminit pgdat_page_ext_init(struct pglist_data *pgdat)
 	pgdat->node_page_ext = NULL;
 }
 
-struct page_ext *lookup_page_ext(struct page *page)
+struct page_ext *lookup_page_ext(const struct page *page)
 {
 	unsigned long pfn = page_to_pfn(page);
 	unsigned long index;
@@ -195,7 +195,7 @@ void __init page_ext_init_flatmem(void)
 
 #else /* CONFIG_FLAT_NODE_MEM_MAP */
 
-struct page_ext *lookup_page_ext(struct page *page)
+struct page_ext *lookup_page_ext(const struct page *page)
 {
 	unsigned long pfn = page_to_pfn(page);
 	struct mem_section *section = __pfn_to_section(pfn);
-- 
2.17.0
