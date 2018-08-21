Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA57C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5433217C9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dpGHh12L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5433217C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbeHVAVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 20:21:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52750 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbeHVAVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 20:21:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7LKuw5l017113;
        Tue, 21 Aug 2018 20:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=EMUsyMD++FbCjeWKHZ1xj6y0FD6wedPmRsDrc6Pm4QY=;
 b=dpGHh12LG8aPmIZROt1nt9FpZmkR6ySb4W64twUE5LBrXfP393jPdcFo2gOylNzc9/10
 O6lgtto5cmq9mSeeV9mf8fyh73Vrm0dbLq2sBsftklCz89gNYSlU4zlGuckbv9ENzBNC
 cBdR/rotyyrJGx8KJONldHHR9Vc3awDWgHf/dyG12o7iHuT+GAbBqyD+0C8hmhNK5wS1
 SUBuKz7IRvMAK1KkwsmBg0lERefl8oGb4UYebecoTN3Qne21Ji21baATCSBTX6wfyM2A
 URT4KDcu2Ar+npDA9UZNLlbcS9q71uuXtGEX509Urtr1Ysr4aziBW4lv4enYKuL1xUSn /A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2kxc3qq2aq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Aug 2018 20:59:10 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7LKx94A000435
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Aug 2018 20:59:10 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7LKx9jC015319;
        Tue, 21 Aug 2018 20:59:09 GMT
Received: from monkey.oracle.com (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Aug 2018 13:59:09 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 2/2] hugetlb: take PMD sharing into account when flushing tlb/caches
Date:   Tue, 21 Aug 2018 13:59:02 -0700
Message-Id: <20180821205902.21223-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180821205902.21223-1-mike.kravetz@oracle.com>
References: <20180821205902.21223-1-mike.kravetz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8992 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=815
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808210212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fixing an issue with PMD sharing and migration, it was discovered
via code inspection that other callers of huge_pmd_unshare potentially
have an issue with cache and tlb flushing.

Use the routine huge_pmd_sharing_possible() to calculate worst case
ranges for mmu notifiers.  Ensure that this range is flushed if
huge_pmd_unshare succeeds and unmaps a PUD_SUZE area.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 53 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fd155dc52117..c31d92889775 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3333,8 +3333,8 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	struct page *page;
 	struct hstate *h = hstate_vma(vma);
 	unsigned long sz = huge_page_size(h);
-	const unsigned long mmun_start = start;	/* For mmu_notifiers */
-	const unsigned long mmun_end   = end;	/* For mmu_notifiers */
+	unsigned long mmun_start = start;	/* For mmu_notifiers */
+	unsigned long mmun_end   = end;		/* For mmu_notifiers */
 
 	WARN_ON(!is_vm_hugetlb_page(vma));
 	BUG_ON(start & ~huge_page_mask(h));
@@ -3346,6 +3346,11 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 */
 	tlb_remove_check_page_size_change(tlb, sz);
 	tlb_start_vma(tlb, vma);
+
+	/*
+	 * If sharing possible, alert mmu notifiers of worst case.
+	 */
+	(void)huge_pmd_sharing_possible(vma, &mmun_start, &mmun_end);
 	mmu_notifier_invalidate_range_start(mm, mmun_start, mmun_end);
 	address = start;
 	for (; address < end; address += sz) {
@@ -3356,6 +3361,10 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		ptl = huge_pte_lock(h, mm, ptep);
 		if (huge_pmd_unshare(mm, &address, ptep)) {
 			spin_unlock(ptl);
+			/*
+			 * We just unmapped a page of PMDs by clearing a PUD.
+			 * The caller's TLB flush range should cover this area.
+			 */
 			continue;
 		}
 
@@ -3438,12 +3447,23 @@ void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start,
 {
 	struct mm_struct *mm;
 	struct mmu_gather tlb;
+	unsigned long tlb_start = start;
+	unsigned long tlb_end = end;
+
+	/*
+	 * If shared PMDs were possibly used within this vma range, adjust
+	 * start/end for worst case tlb flushing.
+	 * Note that we can not be sure if PMDs are shared until we try to
+	 * unmap pages.  However, we want to make sure TLB flushing covers
+	 * the largest possible range.
+	 */
+	(void)huge_pmd_sharing_possible(vma, &tlb_start, &tlb_end);
 
 	mm = vma->vm_mm;
 
-	tlb_gather_mmu(&tlb, mm, start, end);
+	tlb_gather_mmu(&tlb, mm, tlb_start, tlb_end);
 	__unmap_hugepage_range(&tlb, vma, start, end, ref_page);
-	tlb_finish_mmu(&tlb, start, end);
+	tlb_finish_mmu(&tlb, tlb_start, tlb_end);
 }
 
 /*
@@ -4309,11 +4329,21 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
 	unsigned long pages = 0;
+	unsigned long f_start = start;
+	unsigned long f_end = end;
+	bool shared_pmd = false;
+
+	/*
+	 * In the case of shared PMDs, the area to flush could be beyond
+	 * start/end.  Set f_start/f_end to cover the maximum possible
+	 * range if PMD sharing is possible.
+	 */
+	(void)huge_pmd_sharing_possible(vma, &f_start, &f_end);
 
 	BUG_ON(address >= end);
-	flush_cache_range(vma, address, end);
+	flush_cache_range(vma, f_start, f_end);
 
-	mmu_notifier_invalidate_range_start(mm, start, end);
+	mmu_notifier_invalidate_range_start(mm, f_start, f_end);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
 	for (; address < end; address += huge_page_size(h)) {
 		spinlock_t *ptl;
@@ -4324,6 +4354,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 		if (huge_pmd_unshare(mm, &address, ptep)) {
 			pages++;
 			spin_unlock(ptl);
+			shared_pmd = true;
 			continue;
 		}
 		pte = huge_ptep_get(ptep);
@@ -4359,9 +4390,13 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	 * Must flush TLB before releasing i_mmap_rwsem: x86's huge_pmd_unshare
 	 * may have cleared our pud entry and done put_page on the page table:
 	 * once we release i_mmap_rwsem, another task can do the final put_page
-	 * and that page table be reused and filled with junk.
+	 * and that page table be reused and filled with junk.  If we actually
+	 * did unshare a page of pmds, flush the range corresponding to the pud.
 	 */
-	flush_hugetlb_tlb_range(vma, start, end);
+	if (shared_pmd)
+		flush_hugetlb_tlb_range(vma, f_start, f_end);
+	else
+		flush_hugetlb_tlb_range(vma, start, end);
 	/*
 	 * No need to call mmu_notifier_invalidate_range() we are downgrading
 	 * page table protection not changing it to point to a new page.
@@ -4369,7 +4404,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	 * See Documentation/vm/mmu_notifier.rst
 	 */
 	i_mmap_unlock_write(vma->vm_file->f_mapping);
-	mmu_notifier_invalidate_range_end(mm, start, end);
+	mmu_notifier_invalidate_range_end(mm, f_start, f_end);
 
 	return pages << h->order;
 }
-- 
2.17.1

