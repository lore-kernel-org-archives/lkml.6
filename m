Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0261C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660A5241E5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:51:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660A5241E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753430AbeGDVvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:51:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:48755 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752899AbeGDVvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:51:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 14:51:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,309,1526367600"; 
   d="scan'208";a="70135955"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga001.jf.intel.com with ESMTP; 04 Jul 2018 14:51:03 -0700
Subject: [PATCH v5 08/11] mm,
 memory_failure: Teach memory_failure() about dev_pagemap pages
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jack@suse.cz,
        ross.zwisler@linux.intel.com
Date:   Wed, 04 Jul 2018 14:41:06 -0700
Message-ID: <153074046610.27838.329669845580014251.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153074042316.27838.17319837331947007626.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153074042316.27838.17319837331947007626.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    mce: Uncorrected hardware memory error in user-access at af34214200
    {1}[Hardware Error]: It has been corrected by h/w and requires no further action
    mce: [Hardware Error]: Machine check events logged
    {1}[Hardware Error]: event severity: corrected
    Memory failure: 0xaf34214: reserved kernel page still referenced by 1 users
    [..]
    Memory failure: 0xaf34214: recovery action for reserved kernel page: Failed
    mce: Memory error not recovered

In contrast to typical memory, dev_pagemap pages may be dax mapped. With
dax there is no possibility to map in another page dynamically since dax
establishes 1:1 physical address to file offset associations. Also
dev_pagemap pages associated with NVDIMM / persistent memory devices can
internal remap/repair addresses with poison. While memory_failure()
assumes that it can discard typical poisoned pages and keep them
unmapped indefinitely, dev_pagemap pages may be returned to service
after the error is cleared.

Teach memory_failure() to detect and handle MEMORY_DEVICE_HOST
dev_pagemap pages that have poison consumed by userspace. Mark the
memory as UC instead of unmapping it completely to allow ongoing access
via the device driver (nd_pmem). Later, nd_pmem will grow support for
marking the page back to WB when the error is cleared.

Cc: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/mm.h  |    1 
 mm/memory-failure.c |  124 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 123 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a0fbb9ffe380..374e5e9284f7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2725,6 +2725,7 @@ enum mf_action_page_type {
 	MF_MSG_TRUNCATED_LRU,
 	MF_MSG_BUDDY,
 	MF_MSG_BUDDY_2ND,
+	MF_MSG_DAX,
 	MF_MSG_UNKNOWN,
 };
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 4d70753af59c..161aa1b70212 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -55,6 +55,7 @@
 #include <linux/hugetlb.h>
 #include <linux/memory_hotplug.h>
 #include <linux/mm_inline.h>
+#include <linux/memremap.h>
 #include <linux/kfifo.h>
 #include <linux/ratelimit.h>
 #include "internal.h"
@@ -263,6 +264,39 @@ void shake_page(struct page *p, int access)
 }
 EXPORT_SYMBOL_GPL(shake_page);
 
+static unsigned long mapping_size(struct page *page, struct vm_area_struct *vma)
+{
+	unsigned long address = vma_address(page, vma);
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	pgd = pgd_offset(vma->vm_mm, address);
+	if (!pgd_present(*pgd))
+		return 0;
+	p4d = p4d_offset(pgd, address);
+	if (!p4d_present(*p4d))
+		return 0;
+	pud = pud_offset(p4d, address);
+	if (!pud_present(*pud))
+		return 0;
+	if (pud_devmap(*pud))
+		return PUD_SIZE;
+	pmd = pmd_offset(pud, address);
+	if (!pmd_present(*pmd))
+		return 0;
+	if (pmd_devmap(*pmd))
+		return PMD_SIZE;
+	pte = pte_offset_map(pmd, address);
+	if (!pte_present(*pte))
+		return 0;
+	if (pte_devmap(*pte))
+		return PAGE_SIZE;
+	return 0;
+}
+
 /*
  * Failure handling: if we can't find or can't kill a process there's
  * not much we can do.	We just print a message and ignore otherwise.
@@ -292,7 +326,10 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 	}
 	tk->addr = page_address_in_vma(p, vma);
 	tk->addr_valid = 1;
-	tk->size_shift = compound_order(compound_head(p)) + PAGE_SHIFT;
+	if (is_zone_device_page(p))
+		tk->size_shift = ilog2(mapping_size(p, vma));
+	else
+		tk->size_shift = compound_order(compound_head(p)) + PAGE_SHIFT;
 
 	/*
 	 * In theory we don't have to kill when the page was
@@ -300,7 +337,7 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 	 * likely very rare kill anyways just out of paranoia, but use
 	 * a SIGKILL because the error is not contained anymore.
 	 */
-	if (tk->addr == -EFAULT) {
+	if (tk->addr == -EFAULT || tk->size_shift == 0) {
 		pr_info("Memory failure: Unable to find user space address %lx in %s\n",
 			page_to_pfn(p), tsk->comm);
 		tk->addr_valid = 0;
@@ -514,6 +551,7 @@ static const char * const action_page_types[] = {
 	[MF_MSG_TRUNCATED_LRU]		= "already truncated LRU page",
 	[MF_MSG_BUDDY]			= "free buddy page",
 	[MF_MSG_BUDDY_2ND]		= "free buddy page (2nd try)",
+	[MF_MSG_DAX]			= "dax page",
 	[MF_MSG_UNKNOWN]		= "unknown page",
 };
 
@@ -1111,6 +1149,83 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	return res;
 }
 
+static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
+		struct dev_pagemap *pgmap)
+{
+	struct page *page = pfn_to_page(pfn);
+	const bool unmap_success = true;
+	unsigned long size = 0;
+	struct to_kill *tk;
+	LIST_HEAD(tokill);
+	int rc = -EBUSY;
+	loff_t start;
+
+	/*
+	 * Prevent the inode from being freed while we are interrogating
+	 * the address_space, typically this would be handled by
+	 * lock_page(), but dax pages do not use the page lock. This
+	 * also prevents changes to the mapping of this pfn until
+	 * poison signaling is complete.
+	 */
+	if (!dax_lock_mapping_entry(page))
+		goto out;
+
+	if (hwpoison_filter(page)) {
+		rc = 0;
+		goto unlock;
+	}
+
+	switch (pgmap->type) {
+	case MEMORY_DEVICE_PRIVATE:
+	case MEMORY_DEVICE_PUBLIC:
+		/*
+		 * TODO: Handle HMM pages which may need coordination
+		 * with device-side memory.
+		 */
+		goto unlock;
+	default:
+		break;
+	}
+
+	/*
+	 * Use this flag as an indication that the dax page has been
+	 * remapped UC to prevent speculative consumption of poison.
+	 */
+	SetPageHWPoison(page);
+
+	/*
+	 * Unlike System-RAM there is no possibility to swap in a
+	 * different physical page at a given virtual address, so all
+	 * userspace consumption of ZONE_DEVICE memory necessitates
+	 * SIGBUS (i.e. MF_MUST_KILL)
+	 */
+	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
+	collect_procs(page, &tokill, flags & MF_ACTION_REQUIRED);
+
+	list_for_each_entry(tk, &tokill, nd)
+		if (tk->size_shift)
+			size = max(size, 1UL << tk->size_shift);
+	if (size) {
+		/*
+		 * Unmap the largest mapping to avoid breaking up
+		 * device-dax mappings which are constant size. The
+		 * actual size of the mapping being torn down is
+		 * communicated in siginfo, see kill_proc()
+		 */
+		start = (page->index << PAGE_SHIFT) & ~(size - 1);
+		unmap_mapping_range(page->mapping, start, start + size, 0);
+	}
+	kill_procs(&tokill, flags & MF_MUST_KILL, !unmap_success, pfn, flags);
+	rc = 0;
+unlock:
+	dax_unlock_mapping_entry(page);
+out:
+	/* drop pgmap ref acquired in caller */
+	put_dev_pagemap(pgmap);
+	action_result(pfn, MF_MSG_DAX, rc ? MF_FAILED : MF_RECOVERED);
+	return rc;
+}
+
 /**
  * memory_failure - Handle memory failure of a page.
  * @pfn: Page Number of the corrupted page
@@ -1133,6 +1248,7 @@ int memory_failure(unsigned long pfn, int flags)
 	struct page *p;
 	struct page *hpage;
 	struct page *orig_head;
+	struct dev_pagemap *pgmap;
 	int res;
 	unsigned long page_flags;
 
@@ -1145,6 +1261,10 @@ int memory_failure(unsigned long pfn, int flags)
 		return -ENXIO;
 	}
 
+	pgmap = get_dev_pagemap(pfn, NULL);
+	if (pgmap)
+		return memory_failure_dev_pagemap(pfn, flags, pgmap);
+
 	p = pfn_to_page(pfn);
 	if (PageHuge(p))
 		return memory_failure_hugetlb(pfn, flags);

