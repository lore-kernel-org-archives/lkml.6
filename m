Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42464C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5957205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5957205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbeH2VPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 17:15:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727704AbeH2VPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 17:15:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB64E738F1;
        Wed, 29 Aug 2018 17:17:59 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-126-69.rdu2.redhat.com [10.10.126.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7776B278D;
        Wed, 29 Aug 2018 17:17:58 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Michal Hocko <mhocko@kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 4/7] mm/hmm: properly handle migration pmd v2
Date:   Wed, 29 Aug 2018 13:17:49 -0400
Message-Id: <20180829171749.9365-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20180824192549.30844-5-jglisse@redhat.com>
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 29 Aug 2018 17:17:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 29 Aug 2018 17:17:59 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

Before this patch migration pmd entry (!pmd_present()) would have
been treated as a bad entry (pmd_bad() returns true on migration
pmd entry). The outcome was that device driver would believe that
the range covered by the pmd was bad and would either SIGBUS or
simply kill all the device's threads (each device driver decide
how to react when the device tries to access poisonnous or invalid
range of memory).

This patch explicitly handle the case of migration pmd entry which
are non present pmd entry and either wait for the migration to
finish or report empty range (when device is just trying to pre-
fill a range of virtual address and thus do not want to wait or
trigger page fault).

Changed since v1:
  - use is_pmd_migration_entry() instead of open coding the
    equivalent.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/hmm.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index a16678d08127..fd3d19d98070 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -577,22 +577,44 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 {
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
+	struct vm_area_struct *vma = walk->vma;
 	uint64_t *pfns = range->pfns;
 	unsigned long addr = start, i;
 	pte_t *ptep;
+	pmd_t pmd;
 
-	i = (addr - range->start) >> PAGE_SHIFT;
 
 again:
-	if (pmd_none(*pmdp))
+	pmd = READ_ONCE(*pmdp);
+	if (pmd_none(pmd))
 		return hmm_vma_walk_hole(start, end, walk);
 
-	if (pmd_huge(*pmdp) && (range->vma->vm_flags & VM_HUGETLB))
+	if (pmd_huge(pmd) && (range->vma->vm_flags & VM_HUGETLB))
 		return hmm_pfns_bad(start, end, walk);
 
-	if (pmd_devmap(*pmdp) || pmd_trans_huge(*pmdp)) {
-		pmd_t pmd;
+	if (is_pmd_migration_entry(pmd)) {
+		swp_entry_t entry = pmd_to_swp_entry(pmd);
+
+		bool fault, write_fault;
+		unsigned long npages;
+		uint64_t *pfns;
+
+		i = (addr - range->start) >> PAGE_SHIFT;
+		npages = (end - addr) >> PAGE_SHIFT;
+		pfns = &range->pfns[i];
 
+		hmm_range_need_fault(hmm_vma_walk, pfns, npages,
+				     0, &fault, &write_fault);
+		if (fault || write_fault) {
+			hmm_vma_walk->last = addr;
+			pmd_migration_entry_wait(vma->vm_mm, pmdp);
+			return -EAGAIN;
+		}
+		return 0;
+	} else if (!pmd_present(pmd))
+		return hmm_pfns_bad(start, end, walk);
+
+	if (pmd_devmap(pmd) || pmd_trans_huge(pmd)) {
 		/*
 		 * No need to take pmd_lock here, even if some other threads
 		 * is splitting the huge pmd we will get that event through
@@ -607,13 +629,21 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		if (!pmd_devmap(pmd) && !pmd_trans_huge(pmd))
 			goto again;
 
+		i = (addr - range->start) >> PAGE_SHIFT;
 		return hmm_vma_handle_pmd(walk, addr, end, &pfns[i], pmd);
 	}
 
-	if (pmd_bad(*pmdp))
+	/*
+	 * We have handled all the valid case above ie either none, migration,
+	 * huge or transparent huge. At this point either it is a valid pmd
+	 * entry pointing to pte directory or it is a bad pmd that will not
+	 * recover.
+	 */
+	if (pmd_bad(pmd))
 		return hmm_pfns_bad(start, end, walk);
 
 	ptep = pte_offset_map(pmdp, addr);
+	i = (addr - range->start) >> PAGE_SHIFT;
 	for (; addr < end; addr += PAGE_SIZE, ptep++, i++) {
 		int r;
 
-- 
2.17.1

