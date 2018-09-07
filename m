Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E000C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0DA20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0DA20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbeIGUY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:24:57 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36647 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbeIGUYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:24:55 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fyIuq-00055e-7z; Fri, 07 Sep 2018 17:43:24 +0200
Message-Id: <20180907152054.639278518@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 07 Sep 2018 17:01:22 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>
Subject: [patch 03/10] x86/mm/cpa: Allow range check for static protections
References: <20180907150119.325866892@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-mm-cpa--Allow-range-check-for-static-protections.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking static protections only page by page is slow especially for huge
pages. To allow quick checks over a complete range, add the ability to do
that.

Make the checks inclusive so the ranges can be directly used for debug output
later.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/mm/pageattr.c |   67 +++++++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 24 deletions(-)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -286,22 +286,29 @@ static void cpa_flush_array(unsigned lon
 	}
 }
 
+static bool overlaps(unsigned long r1_start, unsigned long r1_end,
+		     unsigned long r2_start, unsigned long r2_end)
+{
+	return (r1_start <= r2_end && r1_end >= r2_start) ||
+		(r2_start <= r1_end && r2_end >= r1_start);
+}
+
 #ifdef CONFIG_PCI_BIOS
 /*
  * The BIOS area between 640k and 1Mb needs to be executable for PCI BIOS
  * based config access (CONFIG_PCI_GOBIOS) support.
  */
 #define BIOS_PFN	PFN_DOWN(BIOS_BEGIN)
-#define BIOS_PFN_END	PFN_DOWN(BIOS_END)
+#define BIOS_PFN_END	PFN_DOWN(BIOS_END - 1)
 
-static pgprotval_t protect_pci_bios(unsigned long pfn)
+static pgprotval_t protect_pci_bios(unsigned long spfn, unsigned long epfn)
 {
-	if (pcibios_enabled && within(pfn, BIOS_PFN, BIOS_PFN_END))
+	if (pcibios_enabled && overlaps(spfn, epfn, BIOS_PFN, BIOS_PFN_END))
 		return _PAGE_NX;
 	return 0;
 }
 #else
-static pgprotval_t protect_pci_bios(unsigned long pfn)
+static pgprotval_t protect_pci_bios(unsigned long spfn, unsigned long epfn)
 {
 	return 0;
 }
@@ -312,12 +319,17 @@ static pgprotval_t protect_pci_bios(unsi
  * aliases.  This also includes __ro_after_init, so do not enforce until
  * kernel_set_to_readonly is true.
  */
-static pgprotval_t protect_rodata(unsigned long pfn)
+static pgprotval_t protect_rodata(unsigned long spfn, unsigned long epfn)
 {
-	unsigned long start_pfn = __pa_symbol(__start_rodata) >> PAGE_SHIFT;
-	unsigned long end_pfn = __pa_symbol(__end_rodata) >> PAGE_SHIFT;
+	unsigned long epfn_ro, spfn_ro = PFN_DOWN(__pa_symbol(__start_rodata));
+
+	/*
+	 * Note: __end_rodata is at page aligned and not inclusive, so
+	 * subtract 1 to get the last enforced PFN in the rodata area.
+	 */
+	epfn_ro = PFN_DOWN(__pa_symbol(__end_rodata)) - 1;
 
-	if (kernel_set_to_readonly && within(pfn, start_pfn, end_pfn))
+	if (kernel_set_to_readonly && overlaps(spfn, epfn, spfn_ro, epfn_ro))
 		return _PAGE_RW;
 	return 0;
 }
@@ -327,9 +339,12 @@ static pgprotval_t protect_rodata(unsign
  * not cover __inittext since that is gone after boot. On 64bit we do not
  * enforce !NX on the low mapping
  */
-static pgprotval_t protect_kernel_text(unsigned long address)
+static pgprotval_t protect_kernel_text(unsigned long start, unsigned long end)
 {
-	if (within(address, (unsigned long)_text, (unsigned long)_etext))
+	unsigned long t_end = (unsigned long)_etext - 1;
+	unsigned long t_start = (unsigned long)_text;
+
+	if (overlaps(start, end, t_start, t_end))
 		return _PAGE_NX;
 	return 0;
 }
@@ -344,13 +359,14 @@ static pgprotval_t protect_kernel_text(u
  * This will preserve the large page mappings for kernel text/data at no
  * extra cost.
  */
-static pgprotval_t protect_kernel_text_ro(unsigned long address)
+static pgprotval_t protect_kernel_text_ro(unsigned long start,
+					  unsigned long end)
 {
-	unsigned long end = (unsigned long)__end_rodata_hpage_align;
-	unsigned long start = (unsigned long)_text;
+	unsigned long t_end = (unsigned long)__end_rodata_hpage_align - 1;
+	unsigned long t_start = (unsigned long)_text;
 	unsigned int level;
 
-	if (!kernel_set_to_readonly || !within(address, start, end))
+	if (!kernel_set_to_readonly || !overlaps(start, end, t_start, t_end))
 		return 0;
 	/*
 	 * Don't enforce the !RW mapping for the kernel text mapping, if
@@ -364,12 +380,13 @@ static pgprotval_t protect_kernel_text_r
 	 * so the protections for kernel text and identity mappings have to
 	 * be the same.
 	 */
-	if (lookup_address(address, &level) && (level != PG_LEVEL_4K))
+	if (lookup_address(start, &level) && (level != PG_LEVEL_4K))
 		return _PAGE_RW;
 	return 0;
 }
 #else
-static pgprotval_t protect_kernel_text_ro(unsigned long address)
+static pgprotval_t protect_kernel_text_ro(unsigned long start,
+					  unsigned long end)
 {
 	return 0;
 }
@@ -381,18 +398,20 @@ static pgprotval_t protect_kernel_text_r
  * right (again, ioremap() on BIOS memory is not uncommon) so this function
  * checks and fixes these known static required protection bits.
  */
-static inline pgprot_t static_protections(pgprot_t prot, unsigned long address,
-					  unsigned long pfn)
+static inline pgprot_t static_protections(pgprot_t prot, unsigned long start,
+					  unsigned long pfn, unsigned long npg)
 {
 	pgprotval_t forbidden;
+	unsigned long end;
 
 	/* Operate on the virtual address */
-	forbidden  = protect_kernel_text(address);
-	forbidden |= protect_kernel_text_ro(address);
+	end = start + npg * PAGE_SIZE - 1;
+	forbidden  = protect_kernel_text(start, end);
+	forbidden |= protect_kernel_text_ro(start, end);
 
 	/* Check the PFN directly */
-	forbidden |= protect_pci_bios(pfn);
-	forbidden |= protect_rodata(pfn);
+	forbidden |= protect_pci_bios(pfn, pfn + npg - 1);
+	forbidden |= protect_rodata(pfn, pfn + npg - 1);
 
 	return __pgprot(pgprot_val(prot) & ~forbidden);
 }
@@ -667,7 +686,7 @@ static int __should_split_large_page(pte
 	new_prot = static_protections(req_prot, address, pfn, 1);
 	pfn = old_pfn;
 	for (i = 0, addr = lpaddr; i < numpages; i++, addr += PAGE_SIZE, pfn++) {
-		pgprot_t chk_prot = static_protections(req_prot, addr, pfn);
+		pgprot_t chk_prot = static_protections(req_prot, addr, pfn, 1);
 
 		if (pgprot_val(chk_prot) != pgprot_val(new_prot))
 			return 1;
@@ -1277,7 +1296,7 @@ static int __change_page_attr(struct cpa
 		pgprot_val(new_prot) &= ~pgprot_val(cpa->mask_clr);
 		pgprot_val(new_prot) |= pgprot_val(cpa->mask_set);
 
-		new_prot = static_protections(new_prot, address, pfn);
+		new_prot = static_protections(new_prot, address, pfn, 1);
 
 		new_prot = pgprot_clear_protnone_bits(new_prot);
 


