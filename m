Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33647C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05614218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfBCN4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:56:46 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53926 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728395AbfBCNuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:50:04 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9o-0003tl-Ee; Sun, 03 Feb 2019 13:50:00 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9i-0007Dy-62; Sun, 03 Feb 2019 14:49:54 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Prakash Sangappa" <prakash.sangappa@oracle.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        "Naoya Horiguchi" <n-horiguchi@ah.jp.nec.com>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        "Michal Hocko" <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        "Hugh Dickins" <hughd@google.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.777713642@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 208/305] hugetlbfs: fix kernel BUG at fs/hugetlbfs/inode.c:444!
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Kravetz <mike.kravetz@oracle.com>

commit 5e41540c8a0f0e98c337dda8b391e5dda0cde7cf upstream.

This bug has been experienced several times by the Oracle DB team.  The
BUG is in remove_inode_hugepages() as follows:

	/*
	 * If page is mapped, it was faulted in after being
	 * unmapped in caller.  Unmap (again) now after taking
	 * the fault mutex.  The mutex will prevent faults
	 * until we finish removing the page.
	 *
	 * This race can only happen in the hole punch case.
	 * Getting here in a truncate operation is a bug.
	 */
	if (unlikely(page_mapped(page))) {
		BUG_ON(truncate_op);

In this case, the elevated map count is not the result of a race.
Rather it was incorrectly incremented as the result of a bug in the huge
pmd sharing code.  Consider the following:

 - Process A maps a hugetlbfs file of sufficient size and alignment
   (PUD_SIZE) that a pmd page could be shared.

 - Process B maps the same hugetlbfs file with the same size and
   alignment such that a pmd page is shared.

 - Process B then calls mprotect() to change protections for the mapping
   with the shared pmd. As a result, the pmd is 'unshared'.

 - Process B then calls mprotect() again to chage protections for the
   mapping back to their original value. pmd remains unshared.

 - Process B then forks and process C is created. During the fork
   process, we do dup_mm -> dup_mmap -> copy_page_range to copy page
   tables. Copying page tables for hugetlb mappings is done in the
   routine copy_hugetlb_page_range.

In copy_hugetlb_page_range(), the destination pte is obtained by:

	dst_pte = huge_pte_alloc(dst, addr, sz);

If pmd sharing is possible, the returned pointer will be to a pte in an
existing page table.  In the situation above, process C could share with
either process A or process B.  Since process A is first in the list,
the returned pte is a pointer to a pte in process A's page table.

However, the check for pmd sharing in copy_hugetlb_page_range is:

	/* If the pagetables are shared don't copy or take references */
	if (dst_pte == src_pte)
		continue;

Since process C is sharing with process A instead of process B, the
above test fails.  The code in copy_hugetlb_page_range which follows
assumes dst_pte points to a huge_pte_none pte.  It copies the pte entry
from src_pte to dst_pte and increments this map count of the associated
page.  This is how we end up with an elevated map count.

To solve, check the dst_pte entry for huge_pte_none.  If !none, this
implies PMD sharing so do not copy.

Link: http://lkml.kernel.org/r/20181105212315.14125-1-mike.kravetz@oracle.com
Fixes: c5c99429fa57 ("fix hugepages leak due to pagetable page sharing")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Prakash Sangappa <prakash.sangappa@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 mm/hugetlb.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2606,7 +2606,7 @@ static int is_hugetlb_entry_hwpoisoned(p
 int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			    struct vm_area_struct *vma)
 {
-	pte_t *src_pte, *dst_pte, entry;
+	pte_t *src_pte, *dst_pte, entry, dst_entry;
 	struct page *ptepage;
 	unsigned long addr;
 	int cow;
@@ -2634,15 +2634,30 @@ int copy_hugetlb_page_range(struct mm_st
 			break;
 		}
 
-		/* If the pagetables are shared don't copy or take references */
-		if (dst_pte == src_pte)
+		/*
+		 * If the pagetables are shared don't copy or take references.
+		 * dst_pte == src_pte is the common case of src/dest sharing.
+		 *
+		 * However, src could have 'unshared' and dst shares with
+		 * another vma.  If dst_pte !none, this implies sharing.
+		 * Check here before taking page table lock, and once again
+		 * after taking the lock below.
+		 */
+		dst_entry = huge_ptep_get(dst_pte);
+		if ((dst_pte == src_pte) || !huge_pte_none(dst_entry))
 			continue;
 
 		dst_ptl = huge_pte_lock(h, dst, dst_pte);
 		src_ptl = huge_pte_lockptr(h, src, src_pte);
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 		entry = huge_ptep_get(src_pte);
-		if (huge_pte_none(entry)) { /* skip none entry */
+		dst_entry = huge_ptep_get(dst_pte);
+		if (huge_pte_none(entry) || !huge_pte_none(dst_entry)) {
+			/*
+			 * Skip if src entry none.  Also, skip in the
+			 * unlikely case dst entry !none as this implies
+			 * sharing with another vma.
+			 */
 			;
 		} else if (unlikely(is_hugetlb_entry_migration(entry) ||
 				    is_hugetlb_entry_hwpoisoned(entry))) {

