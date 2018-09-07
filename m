Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0352AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B982E20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B982E20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbeIHCLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:11:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48832 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbeIHCLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:11:31 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 37BDDACC;
        Fri,  7 Sep 2018 21:28:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 56/89] KVM: PPC: Book3S: Fix guest DMA when guest partially backed by THP pages
Date:   Fri,  7 Sep 2018 23:09:50 +0200
Message-Id: <20180907210859.082538107@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210852.341064285@linuxfoundation.org>
References: <20180907210852.341064285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Mackerras <paulus@ozlabs.org>

commit 8cfbdbdc24815417a3ab35101ccf706b9a23ff17 upstream.

Commit 76fa4975f3ed ("KVM: PPC: Check if IOMMU page is contained in
the pinned physical page", 2018-07-17) added some checks to ensure
that guest DMA mappings don't attempt to map more than the guest is
entitled to access. However, errors in the logic mean that legitimate
guest requests to map pages for DMA are being denied in some
situations. Specifically, if the first page of the range passed to
mm_iommu_get() is mapped with a normal page, and subsequent pages are
mapped with transparent huge pages, we end up with mem->pageshift ==
0. That means that the page size checks in mm_iommu_ua_to_hpa() and
mm_iommu_up_to_hpa_rm() will always fail for every page in that
region, and thus the guest can never map any memory in that region for
DMA, typically leading to a flood of error messages like this:

  qemu-system-ppc64: VFIO_MAP_DMA: -22
  qemu-system-ppc64: vfio_dma_map(0x10005f47780, 0x800000000000000, 0x10000, 0x7fff63ff0000) = -22 (Invalid argument)

The logic errors in mm_iommu_get() are:

  (a) use of 'ua' not 'ua + (i << PAGE_SHIFT)' in the find_linux_pte()
      call (meaning that find_linux_pte() returns the pte for the
      first address in the range, not the address we are currently up
      to);
  (b) use of 'pageshift' as the variable to receive the hugepage shift
      returned by find_linux_pte() - for a normal page this gets set
      to 0, leading to us setting mem->pageshift to 0 when we conclude
      that the pte returned by find_linux_pte() didn't match the page
      we were looking at;
  (c) comparing 'compshift', which is a page order, i.e. log base 2 of
      the number of pages, with 'pageshift', which is a log base 2 of
      the number of bytes.

To fix these problems, this patch introduces 'cur_ua' to hold the
current user address and uses that in the find_linux_pte() call;
introduces 'pteshift' to hold the hugepage shift found by
find_linux_pte(); and compares 'pteshift' with 'compshift +
PAGE_SHIFT' rather than 'compshift'.

The patch also moves the local_irq_restore to the point after the PTE
pointer returned by find_linux_pte() has been dereferenced because
otherwise the PTE could change underneath us, and adds a check to
avoid doing the find_linux_pte() call once mem->pageshift has been
reduced to PAGE_SHIFT, as an optimization.

Fixes: 76fa4975f3ed ("KVM: PPC: Check if IOMMU page is contained in the pinned physical page")
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/mm/mmu_context_iommu.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -130,6 +130,7 @@ long mm_iommu_get(struct mm_struct *mm,
 	long i, j, ret = 0, locked_entries = 0;
 	unsigned int pageshift;
 	unsigned long flags;
+	unsigned long cur_ua;
 	struct page *page = NULL;
 
 	mutex_lock(&mem_list_mutex);
@@ -178,7 +179,8 @@ long mm_iommu_get(struct mm_struct *mm,
 	}
 
 	for (i = 0; i < entries; ++i) {
-		if (1 != get_user_pages_fast(ua + (i << PAGE_SHIFT),
+		cur_ua = ua + (i << PAGE_SHIFT);
+		if (1 != get_user_pages_fast(cur_ua,
 					1/* pages */, 1/* iswrite */, &page)) {
 			ret = -EFAULT;
 			for (j = 0; j < i; ++j)
@@ -197,7 +199,7 @@ long mm_iommu_get(struct mm_struct *mm,
 		if (is_migrate_cma_page(page)) {
 			if (mm_iommu_move_page_from_cma(page))
 				goto populate;
-			if (1 != get_user_pages_fast(ua + (i << PAGE_SHIFT),
+			if (1 != get_user_pages_fast(cur_ua,
 						1/* pages */, 1/* iswrite */,
 						&page)) {
 				ret = -EFAULT;
@@ -211,20 +213,21 @@ long mm_iommu_get(struct mm_struct *mm,
 		}
 populate:
 		pageshift = PAGE_SHIFT;
-		if (PageCompound(page)) {
+		if (mem->pageshift > PAGE_SHIFT && PageCompound(page)) {
 			pte_t *pte;
 			struct page *head = compound_head(page);
 			unsigned int compshift = compound_order(head);
+			unsigned int pteshift;
 
 			local_irq_save(flags); /* disables as well */
-			pte = find_linux_pte(mm->pgd, ua, NULL, &pageshift);
-			local_irq_restore(flags);
+			pte = find_linux_pte(mm->pgd, cur_ua, NULL, &pteshift);
 
 			/* Double check it is still the same pinned page */
 			if (pte && pte_page(*pte) == head &&
-					pageshift == compshift)
-				pageshift = max_t(unsigned int, pageshift,
+			    pteshift == compshift + PAGE_SHIFT)
+				pageshift = max_t(unsigned int, pteshift,
 						PAGE_SHIFT);
+			local_irq_restore(flags);
 		}
 		mem->pageshift = min(mem->pageshift, pageshift);
 		mem->hpas[i] = page_to_pfn(page) << PAGE_SHIFT;


