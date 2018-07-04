Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BACC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323B123F16
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 323B123F16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753297AbeGDVuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:50:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:56991 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752957AbeGDVum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:50:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 14:50:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,309,1526367600"; 
   d="scan'208";a="52665161"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jul 2018 14:50:41 -0700
Subject: [PATCH v5 04/11] filesystem-dax: Set page->index
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Jan Kara <jack@suse.cz>, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jack@suse.cz,
        ross.zwisler@linux.intel.com
Date:   Wed, 04 Jul 2018 14:40:44 -0700
Message-ID: <153074044454.27838.11584443742245442258.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153074042316.27838.17319837331947007626.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153074042316.27838.17319837331947007626.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In support of enabling memory_failure() handling for filesystem-dax
mappings, set ->index to the pgoff of the page. The rmap implementation
requires ->index to bound the search through the vma interval tree. The
index is set and cleared at dax_associate_entry() and
dax_disassociate_entry() time respectively.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/dax.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 641192808bb6..4de11ed463ce 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -319,18 +319,27 @@ static unsigned long dax_radix_end_pfn(void *entry)
 	for (pfn = dax_radix_pfn(entry); \
 			pfn < dax_radix_end_pfn(entry); pfn++)
 
-static void dax_associate_entry(void *entry, struct address_space *mapping)
+/*
+ * TODO: for reflink+dax we need a way to associate a single page with
+ * multiple address_space instances at different linear_page_index()
+ * offsets.
+ */
+static void dax_associate_entry(void *entry, struct address_space *mapping,
+		struct vm_area_struct *vma, unsigned long address)
 {
-	unsigned long pfn;
+	unsigned long size = dax_entry_size(entry), pfn, index;
+	int i = 0;
 
 	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
 		return;
 
+	index = linear_page_index(vma, address & ~(size - 1));
 	for_each_mapped_pfn(entry, pfn) {
 		struct page *page = pfn_to_page(pfn);
 
 		WARN_ON_ONCE(page->mapping);
 		page->mapping = mapping;
+		page->index = index + i++;
 	}
 }
 
@@ -348,6 +357,7 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
 		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
 		WARN_ON_ONCE(page->mapping && page->mapping != mapping);
 		page->mapping = NULL;
+		page->index = 0;
 	}
 }
 
@@ -701,7 +711,7 @@ static void *dax_insert_mapping_entry(struct address_space *mapping,
 	new_entry = dax_radix_locked_entry(pfn, flags);
 	if (dax_entry_size(entry) != dax_entry_size(new_entry)) {
 		dax_disassociate_entry(entry, mapping, false);
-		dax_associate_entry(new_entry, mapping);
+		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address);
 	}
 
 	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {

