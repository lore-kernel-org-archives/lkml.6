Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D6EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2436320882
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ptnbHVtH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2436320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387762AbeKFGpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:45:12 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43258 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFGpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:45:12 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA5LIpZo089407;
        Mon, 5 Nov 2018 21:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=PYO4s9KjsdMbyiZbCDGxHkV6zQxg4GbHaBFwvvdliqE=;
 b=ptnbHVtHINwXDbf+3EFXFUAKMuPp/CVKG6nHjGg4qhnVSAAB/E/O0bGSnXzImsm9sftl
 Lqodat8HbYPiedi2jhHro9lLiPBpDOdpHO2SJ1yW2gY2a5umu8QIQmNIjNzKNEhxIVXe
 jZndHBMLytoMu4rUQ/hOALhdxAoT1jCQq1A3OxyJwAiwRanEseAys3iqXF9/w5uZXhn9
 uONEXQTaKNWB/+xxLF4bC1Iiiv48Jez5th9fWachYTjfzi9391nP8DPhE08XNzRxj8OI
 fUUKVaYlrhCHd/Vss8h9TzCAEaagvCaCOdejb4dvBo8+UoQIYyBFJFElaKhbyKUL/uSZ Dg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2nh4aqhhd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Nov 2018 21:23:21 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA5LNL4K031055
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Nov 2018 21:23:21 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA5LNKt1025528;
        Mon, 5 Nov 2018 21:23:20 GMT
Received: from monkey.oracle.com (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Nov 2018 13:23:19 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>, Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] hugetlbfs: fix kernel BUG at fs/hugetlbfs/inode.c:444!
Date:   Mon,  5 Nov 2018 13:23:15 -0800
Message-Id: <20181105212315.14125-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.17.2
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9068 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811050188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug has been experienced several times by Oracle DB team.
The BUG is in the routine remove_inode_hugepages() as follows:
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
Rather it was incorrectly incremented as the result of a bug in the
huge pmd sharing code.  Consider the following:
- Process A maps a hugetlbfs file of sufficient size and alignment
  (PUD_SIZE) that a pmd page could be shared.
- Process B maps the same hugetlbfs file with the same size and alignment
  such that a pmd page is shared.
- Process B then calls mprotect() to change protections for the mapping
  with the shared pmd.  As a result, the pmd is 'unshared'.
- Process B then calls mprotect() again to chage protections for the
  mapping back to their original value.  pmd remains unshared.
- Process B then forks and process C is created.  During the fork process,
  we do dup_mm -> dup_mmap -> copy_page_range to copy page tables.  Copying
  page tables for hugetlb mappings is done in the routine
  copy_hugetlb_page_range.

In copy_hugetlb_page_range(), the destination pte is obtained by:
	dst_pte = huge_pte_alloc(dst, addr, sz);
If pmd sharing is possible, the returned pointer will be to a pte in
an existing page table.  In the situation above, process C could share
with either process A or process B.  Since process A is first in the
list, the returned pte is a pointer to a pte in process A's page table.

However, the following check for pmd sharing is in copy_hugetlb_page_range.
	/* If the pagetables are shared don't copy or take references */
	if (dst_pte == src_pte)
		continue;

Since process C is sharing with process A instead of process B, the above
test fails.  The code in copy_hugetlb_page_range which follows assumes
dst_pte points to a huge_pte_none pte.  It copies the pte entry from
src_pte to dst_pte and increments this map count of the associated page.
This is how we end up with an elevated map count.

To solve, check the dst_pte entry for huge_pte_none.  If !none, this
implies PMD sharing so do not copy.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5c390f5a5207..0b391ef6448c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3233,7 +3233,7 @@ static int is_hugetlb_entry_hwpoisoned(pte_t pte)
 int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			    struct vm_area_struct *vma)
 {
-	pte_t *src_pte, *dst_pte, entry;
+	pte_t *src_pte, *dst_pte, entry, dst_entry;
 	struct page *ptepage;
 	unsigned long addr;
 	int cow;
@@ -3261,15 +3261,30 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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
-- 
2.17.2

