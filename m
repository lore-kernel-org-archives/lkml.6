Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EA6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3419C218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbeLZNjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:39:13 -0500
Received: from mga04.intel.com ([192.55.52.120]:33941 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbeLZNhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:37:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 05:37:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,400,1539673200"; 
   d="scan'208";a="121185464"
Received: from wangdan1-mobl1.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.210.154])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Dec 2018 05:37:02 -0800
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1gc9Mr-0005Oo-FY; Wed, 26 Dec 2018 21:37:01 +0800
Message-Id: <20181226133351.770245668@intel.com>
User-Agent: quilt/0.65
Date:   Wed, 26 Dec 2018 21:14:58 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Fengguang Wu <fengguang.wu@intel.com>
cc:     kvm@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
cc:     Fan Du <fan.du@intel.com>
cc:     Yao Yuan <yuan.yao@intel.com>
cc:     Peng Dong <dongx.peng@intel.com>
cc:     Huang Ying <ying.huang@intel.com>
CC:     Liu Jingqi <jingqi.liu@intel.com>
cc:     Dong Eddie <eddie.dong@intel.com>
cc:     Dave Hansen <dave.hansen@intel.com>
cc:     Zhang Yi <yi.z.zhang@linux.intel.com>
cc:     Dan Williams <dan.j.williams@intel.com>
Subject: [RFC][PATCH v2 12/21] x86/pgtable: allocate page table pages from DRAM
References: <20181226131446.330864849@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0018-pgtable-force-pgtable-allocation-from-DRAM-node-0.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On rand read/writes on large data, we find near half memory accesses
caused by TLB misses, hence hit the page table pages. So better keep
page table pages in faster DRAM nodes.

Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 arch/x86/include/asm/pgalloc.h |   10 +++++++---
 arch/x86/mm/pgtable.c          |   22 ++++++++++++++++++----
 2 files changed, 25 insertions(+), 7 deletions(-)

--- linux.orig/arch/x86/mm/pgtable.c	2018-12-26 19:41:57.494900885 +0800
+++ linux/arch/x86/mm/pgtable.c	2018-12-26 19:42:35.531621035 +0800
@@ -22,17 +22,30 @@ EXPORT_SYMBOL(physical_mask);
 #endif
 
 gfp_t __userpte_alloc_gfp = PGALLOC_GFP | PGALLOC_USER_GFP;
+nodemask_t all_node_mask = NODE_MASK_ALL;
+
+unsigned long __get_free_pgtable_pages(gfp_t gfp_mask,
+						     unsigned int order)
+{
+	struct page *page;
+
+	page = __alloc_pages_nodemask(gfp_mask, order, numa_node_id(), &all_node_mask);
+	if (!page)
+		return 0;
+	return (unsigned long) page_address(page);
+}
+EXPORT_SYMBOL(__get_free_pgtable_pages);
 
 pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
-	return (pte_t *)__get_free_page(PGALLOC_GFP & ~__GFP_ACCOUNT);
+	return (pte_t *)__get_free_pgtable_pages(PGALLOC_GFP & ~__GFP_ACCOUNT, 0);
 }
 
 pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	struct page *pte;
 
-	pte = alloc_pages(__userpte_alloc_gfp, 0);
+	pte = __alloc_pages_nodemask(__userpte_alloc_gfp, 0, numa_node_id(), &all_node_mask);
 	if (!pte)
 		return NULL;
 	if (!pgtable_page_ctor(pte)) {
@@ -241,7 +254,7 @@ static int preallocate_pmds(struct mm_st
 		gfp &= ~__GFP_ACCOUNT;
 
 	for (i = 0; i < count; i++) {
-		pmd_t *pmd = (pmd_t *)__get_free_page(gfp);
+		pmd_t *pmd = (pmd_t *)__get_free_pgtable_pages(gfp, 0);
 		if (!pmd)
 			failed = true;
 		if (pmd && !pgtable_pmd_page_ctor(virt_to_page(pmd))) {
@@ -422,7 +435,8 @@ static inline void _pgd_free(pgd_t *pgd)
 
 static inline pgd_t *_pgd_alloc(void)
 {
-	return (pgd_t *)__get_free_pages(PGALLOC_GFP, PGD_ALLOCATION_ORDER);
+	return (pgd_t *)__get_free_pgtable_pages(PGALLOC_GFP,
+						 PGD_ALLOCATION_ORDER);
 }
 
 static inline void _pgd_free(pgd_t *pgd)
--- linux.orig/arch/x86/include/asm/pgalloc.h	2018-12-26 19:40:12.992251270 +0800
+++ linux/arch/x86/include/asm/pgalloc.h	2018-12-26 19:42:35.531621035 +0800
@@ -96,10 +96,11 @@ static inline pmd_t *pmd_alloc_one(struc
 {
 	struct page *page;
 	gfp_t gfp = GFP_KERNEL_ACCOUNT | __GFP_ZERO;
+	nodemask_t all_node_mask = NODE_MASK_ALL;
 
 	if (mm == &init_mm)
 		gfp &= ~__GFP_ACCOUNT;
-	page = alloc_pages(gfp, 0);
+	page = __alloc_pages_nodemask(gfp, 0, numa_node_id(), &all_node_mask);
 	if (!page)
 		return NULL;
 	if (!pgtable_pmd_page_ctor(page)) {
@@ -141,13 +142,16 @@ static inline void p4d_populate(struct m
 	set_p4d(p4d, __p4d(_PAGE_TABLE | __pa(pud)));
 }
 
+extern unsigned long __get_free_pgtable_pages(gfp_t gfp_mask,
+					      unsigned int order);
+
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
 	gfp_t gfp = GFP_KERNEL_ACCOUNT;
 
 	if (mm == &init_mm)
 		gfp &= ~__GFP_ACCOUNT;
-	return (pud_t *)get_zeroed_page(gfp);
+	return (pud_t *)__get_free_pgtable_pages(gfp | __GFP_ZERO, 0);
 }
 
 static inline void pud_free(struct mm_struct *mm, pud_t *pud)
@@ -179,7 +183,7 @@ static inline p4d_t *p4d_alloc_one(struc
 
 	if (mm == &init_mm)
 		gfp &= ~__GFP_ACCOUNT;
-	return (p4d_t *)get_zeroed_page(gfp);
+	return (p4d_t *)__get_free_pgtable_pages(gfp | __GFP_ZERO, 0);
 }
 
 static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)


