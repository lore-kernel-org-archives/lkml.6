Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2B1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2A92151B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yr7NSOYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B2A92151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436480AbeKTDbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:31:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:46274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405956AbeKTDbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:31:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56B9D214F1;
        Mon, 19 Nov 2018 17:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542647204;
        bh=9bXzMK8D9Cho741P8eqY3dOOZ6DBB7CamHMvf0Q2cR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yr7NSOYQ3REM+cUemjXJWqLLnv5BziKTT+BTHEf9zxcDD5dgZsHdkb9xPo5KjL9wR
         j73UgNA7kOeASpuW76tpEqFZtaJSTLamyuDIU12A7CRPTeuHosPDs3qjkN1PNm3hsJ
         S5+azJFPv2OSpBcsRK37q4qw8XyrNR8Ml4Yy0YDg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3.18 90/90] hugetlbfs: fix kernel BUG at fs/hugetlbfs/inode.c:444!
Date:   Mon, 19 Nov 2018 17:30:12 +0100
Message-Id: <20181119162634.181292799@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162620.585061184@linuxfoundation.org>
References: <20181119162620.585061184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/hugetlb.c |   23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2576,7 +2576,7 @@ static int is_hugetlb_entry_hwpoisoned(p
 int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			    struct vm_area_struct *vma)
 {
-	pte_t *src_pte, *dst_pte, entry;
+	pte_t *src_pte, *dst_pte, entry, dst_entry;
 	struct page *ptepage;
 	unsigned long addr;
 	int cow;
@@ -2604,15 +2604,30 @@ int copy_hugetlb_page_range(struct mm_st
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


