Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C090DC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740DF2411E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740DF2411E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752698AbeGEFrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:47:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:20160 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750904AbeGEFrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:47:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 22:47:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,310,1526367600"; 
   d="scan'208";a="54546859"
Received: from shbuild000.sh.intel.com (HELO byang_ol.sh.intel.com) ([10.239.144.215])
  by orsmga008.jf.intel.com with ESMTP; 04 Jul 2018 22:47:18 -0700
From:   Bin Yang <bin.yang@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, bin.yang@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/mm: fix cpu stuck issue in __change_page_attr_set_clr
Date:   Thu,  5 Jul 2018 05:47:16 +0000
Message-Id: <1530769636-26603-1-git-send-email-bin.yang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When changing a 4K page attr inside 1G/2M large page range,
__change_page_attr() will call try_preserve_large_page() to decide
to split the big page or not. And try_preserve_large_page() will
call static_protections() to check all 4K pages inside the large page
range one by one. The check loop is very inefficient. In worst case,
static_protections() will be called for 1G/4K (262144) times.

This issue can be triggered by free_initmem() during kernel boot.
free_initmem()  <-- free N pages
  free_init_pages()
    set_memory_rw()
      change_page_attr_set()
        change_page_attr_set_clr()
	  __change_page_attr_set_clr()
	    __change_page_attr() <-- loop N times
	      try_preserve_large_page()
                static_protections() <-- worst case: loop 262144 * N times

Instead of checking all pages, it can only check one page for same
overlapping range. This patch enhances static_protections() to return the
page num that all following pages are in the same overlapping range with
same protection flags. It can reduce the check loop from 262144 to less
than 10 times.

Signed-off-by: Bin Yang <bin.yang@intel.com>
---
 arch/x86/mm/pageattr.c | 72 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 14 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 3bded76e..dee23ef 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -292,17 +292,27 @@ static void cpa_flush_array(unsigned long *start, int numpages, int cache,
  * checks and fixes these known static required protection bits.
  */
 static inline pgprot_t static_protections(pgprot_t prot, unsigned long address,
-				   unsigned long pfn)
+				   unsigned long pfn, unsigned long *page_num)
 {
 	pgprot_t forbidden = __pgprot(0);
+	unsigned long tmp;
+	unsigned long num = PUD_PAGE_SIZE >> PAGE_SHIFT;
 
 	/*
 	 * The BIOS area between 640k and 1Mb needs to be executable for
 	 * PCI BIOS based config access (CONFIG_PCI_GOBIOS) support.
 	 */
 #ifdef CONFIG_PCI_BIOS
-	if (pcibios_enabled && within(pfn, BIOS_BEGIN >> PAGE_SHIFT, BIOS_END >> PAGE_SHIFT))
-		pgprot_val(forbidden) |= _PAGE_NX;
+	if (pcibios_enabled) {
+		tmp = (BIOS_BEGIN >> PAGE_SHIFT) > pfn ?
+			(BIOS_BEGIN >> PAGE_SHIFT) - pfn : ULONG_MAX;
+		if (within(pfn, BIOS_BEGIN >> PAGE_SHIFT,
+		    BIOS_END >> PAGE_SHIFT)) {
+			pgprot_val(forbidden) |= _PAGE_NX;
+			tmp = (BIOS_END >> PAGE_SHIFT) - pfn;
+		}
+		num = num > tmp ? tmp : num;
+	}
 #endif
 
 	/*
@@ -310,18 +320,30 @@ static inline pgprot_t static_protections(pgprot_t prot, unsigned long address,
 	 * Does not cover __inittext since that is gone later on. On
 	 * 64bit we do not enforce !NX on the low mapping
 	 */
-	if (within(address, (unsigned long)_text, (unsigned long)_etext))
+	tmp = (unsigned long)_text > address ?
+		((unsigned long)_text - address) >> PAGE_SHIFT : ULONG_MAX;
+	if (within(address, (unsigned long)_text, (unsigned long)_etext)) {
 		pgprot_val(forbidden) |= _PAGE_NX;
+		tmp = ((unsigned long)_etext - address) >> PAGE_SHIFT;
+	}
+	num = num > tmp ? tmp : num;
 
 	/*
 	 * The .rodata section needs to be read-only. Using the pfn
 	 * catches all aliases.  This also includes __ro_after_init,
 	 * so do not enforce until kernel_set_to_readonly is true.
 	 */
-	if (kernel_set_to_readonly &&
-	    within(pfn, __pa_symbol(__start_rodata) >> PAGE_SHIFT,
-		   __pa_symbol(__end_rodata) >> PAGE_SHIFT))
-		pgprot_val(forbidden) |= _PAGE_RW;
+	if (kernel_set_to_readonly) {
+		tmp = (__pa_symbol(__start_rodata) >> PAGE_SHIFT) > pfn ?
+			(__pa_symbol(__start_rodata) >> PAGE_SHIFT) - pfn :
+			ULONG_MAX;
+		if (within(pfn, __pa_symbol(__start_rodata) >> PAGE_SHIFT,
+		    __pa_symbol(__end_rodata) >> PAGE_SHIFT)) {
+			pgprot_val(forbidden) |= _PAGE_RW;
+			tmp = (__pa_symbol(__end_rodata) >> PAGE_SHIFT) - pfn;
+		}
+		num = num > tmp ? tmp : num;
+	}
 
 #if defined(CONFIG_X86_64)
 	/*
@@ -333,11 +355,15 @@ static inline pgprot_t static_protections(pgprot_t prot, unsigned long address,
 	 * This will preserve the large page mappings for kernel text/data
 	 * at no extra cost.
 	 */
+	tmp = kernel_set_to_readonly && (unsigned long)_text > address ?
+		((unsigned long)_text - address) >> PAGE_SHIFT : ULONG_MAX;
 	if (kernel_set_to_readonly &&
 	    within(address, (unsigned long)_text,
 		   (unsigned long)__end_rodata_hpage_align)) {
 		unsigned int level;
 
+		tmp = ((unsigned long)__end_rodata_hpage_align
+				- address) >> PAGE_SHIFT;
 		/*
 		 * Don't enforce the !RW mapping for the kernel text mapping,
 		 * if the current mapping is already using small page mapping.
@@ -355,13 +381,28 @@ static inline pgprot_t static_protections(pgprot_t prot, unsigned long address,
 		 * text mapping logic will help Linux Xen parvirt guest boot
 		 * as well.
 		 */
-		if (lookup_address(address, &level) && (level != PG_LEVEL_4K))
+		if (lookup_address(address, &level) && (level != PG_LEVEL_4K)) {
+			unsigned long psize = page_level_size(level);
+			unsigned long pmask = page_level_mask(level);
+			unsigned long nextpage_addr =
+				(address + psize) & pmask;
+			unsigned long numpages =
+				(nextpage_addr - address) >> PAGE_SHIFT;
+
 			pgprot_val(forbidden) |= _PAGE_RW;
+			tmp = tmp > numpages ? numpages : tmp;
+		}
 	}
+	num = kernel_set_to_readonly && num > tmp ? tmp : num;
 #endif
 
 	prot = __pgprot(pgprot_val(prot) & ~pgprot_val(forbidden));
 
+	if (num == 0)
+		num = 1;
+	if (page_num)
+		*page_num = num;
+
 	return prot;
 }
 
@@ -552,7 +593,8 @@ static int
 try_preserve_large_page(pte_t *kpte, unsigned long address,
 			struct cpa_data *cpa)
 {
-	unsigned long nextpage_addr, numpages, pmask, psize, addr, pfn, old_pfn;
+	unsigned long nextpage_addr, numpages, pmask, psize, pnum,
+		      addr, pfn, old_pfn;
 	pte_t new_pte, old_pte, *tmp;
 	pgprot_t old_prot, new_prot, req_prot;
 	int i, do_split = 1;
@@ -625,7 +667,7 @@ try_preserve_large_page(pte_t *kpte, unsigned long address,
 	pfn = old_pfn + ((address & (psize - 1)) >> PAGE_SHIFT);
 	cpa->pfn = pfn;
 
-	new_prot = static_protections(req_prot, address, pfn);
+	new_prot = static_protections(req_prot, address, pfn, NULL);
 
 	/*
 	 * We need to check the full range, whether
@@ -634,8 +676,10 @@ try_preserve_large_page(pte_t *kpte, unsigned long address,
 	 */
 	addr = address & pmask;
 	pfn = old_pfn;
-	for (i = 0; i < (psize >> PAGE_SHIFT); i++, addr += PAGE_SIZE, pfn++) {
-		pgprot_t chk_prot = static_protections(req_prot, addr, pfn);
+	for (i = 0; i < (psize >> PAGE_SHIFT);
+	    i += pnum, addr += PAGE_SIZE * pnum, pfn += pnum) {
+		pgprot_t chk_prot =
+			static_protections(req_prot, addr, pfn, &pnum);
 
 		if (pgprot_val(chk_prot) != pgprot_val(new_prot))
 			goto out_unlock;
@@ -1246,7 +1290,7 @@ static int __change_page_attr(struct cpa_data *cpa, int primary)
 		pgprot_val(new_prot) &= ~pgprot_val(cpa->mask_clr);
 		pgprot_val(new_prot) |= pgprot_val(cpa->mask_set);
 
-		new_prot = static_protections(new_prot, address, pfn);
+		new_prot = static_protections(new_prot, address, pfn, NULL);
 
 		new_prot = pgprot_clear_protnone_bits(new_prot);
 
-- 
2.7.4

