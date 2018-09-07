Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4370BC43143
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14732086B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14732086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbeIGUY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:24:58 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36650 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbeIGUYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:24:55 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fyIup-00055Z-H1; Fri, 07 Sep 2018 17:43:23 +0200
Message-Id: <20180907152054.558544759@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 07 Sep 2018 17:01:21 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>
Subject: [patch 02/10] x86/mm/cpa: Rework static_protections()
References: <20180907150119.325866892@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-mm-cpa--Rework-static_protections--.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

static_protections() is pretty unreadable. Split it up into separate checks
for each protection area.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/mm/pageattr.c |  159 +++++++++++++++++++++++++++++--------------------
 1 file changed, 95 insertions(+), 64 deletions(-)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -286,84 +286,115 @@ static void cpa_flush_array(unsigned lon
 	}
 }
 
+#ifdef CONFIG_PCI_BIOS
 /*
- * Certain areas of memory on x86 require very specific protection flags,
- * for example the BIOS area or kernel text. Callers don't always get this
- * right (again, ioremap() on BIOS memory is not uncommon) so this function
- * checks and fixes these known static required protection bits.
+ * The BIOS area between 640k and 1Mb needs to be executable for PCI BIOS
+ * based config access (CONFIG_PCI_GOBIOS) support.
  */
-static inline pgprot_t static_protections(pgprot_t prot, unsigned long address,
-				   unsigned long pfn)
-{
-	pgprot_t forbidden = __pgprot(0);
+#define BIOS_PFN	PFN_DOWN(BIOS_BEGIN)
+#define BIOS_PFN_END	PFN_DOWN(BIOS_END)
 
-	/*
-	 * The BIOS area between 640k and 1Mb needs to be executable for
-	 * PCI BIOS based config access (CONFIG_PCI_GOBIOS) support.
-	 */
-#ifdef CONFIG_PCI_BIOS
-	if (pcibios_enabled && within(pfn, BIOS_BEGIN >> PAGE_SHIFT, BIOS_END >> PAGE_SHIFT))
-		pgprot_val(forbidden) |= _PAGE_NX;
+static pgprotval_t protect_pci_bios(unsigned long pfn)
+{
+	if (pcibios_enabled && within(pfn, BIOS_PFN, BIOS_PFN_END))
+		return _PAGE_NX;
+	return 0;
+}
+#else
+static pgprotval_t protect_pci_bios(unsigned long pfn)
+{
+	return 0;
+}
 #endif
 
-	/*
-	 * The kernel text needs to be executable for obvious reasons
-	 * Does not cover __inittext since that is gone later on. On
-	 * 64bit we do not enforce !NX on the low mapping
-	 */
-	if (within(address, (unsigned long)_text, (unsigned long)_etext))
-		pgprot_val(forbidden) |= _PAGE_NX;
+/*
+ * The .rodata section needs to be read-only. Using the pfn catches all
+ * aliases.  This also includes __ro_after_init, so do not enforce until
+ * kernel_set_to_readonly is true.
+ */
+static pgprotval_t protect_rodata(unsigned long pfn)
+{
+	unsigned long start_pfn = __pa_symbol(__start_rodata) >> PAGE_SHIFT;
+	unsigned long end_pfn = __pa_symbol(__end_rodata) >> PAGE_SHIFT;
 
-	/*
-	 * The .rodata section needs to be read-only. Using the pfn
-	 * catches all aliases.  This also includes __ro_after_init,
-	 * so do not enforce until kernel_set_to_readonly is true.
-	 */
-	if (kernel_set_to_readonly &&
-	    within(pfn, __pa_symbol(__start_rodata) >> PAGE_SHIFT,
-		   __pa_symbol(__end_rodata) >> PAGE_SHIFT))
-		pgprot_val(forbidden) |= _PAGE_RW;
+	if (kernel_set_to_readonly && within(pfn, start_pfn, end_pfn))
+		return _PAGE_RW;
+	return 0;
+}
+
+/*
+ * The kernel text needs to be executable for obvious reasons. This does
+ * not cover __inittext since that is gone after boot. On 64bit we do not
+ * enforce !NX on the low mapping
+ */
+static pgprotval_t protect_kernel_text(unsigned long address)
+{
+	if (within(address, (unsigned long)_text, (unsigned long)_etext))
+		return _PAGE_NX;
+	return 0;
+}
 
 #if defined(CONFIG_X86_64)
+/*
+ * Once the kernel maps the text as RO (kernel_set_to_readonly is set),
+ * kernel text mappings for the large page aligned text, rodata sections
+ * will be always read-only. For the kernel identity mappings covering the
+ * holes caused by this alignment can be anything that user asks.
+ *
+ * This will preserve the large page mappings for kernel text/data at no
+ * extra cost.
+ */
+static pgprotval_t protect_kernel_text_ro(unsigned long address)
+{
+	unsigned long end = (unsigned long)__end_rodata_hpage_align;
+	unsigned long start = (unsigned long)_text;
+	unsigned int level;
+
+	if (!kernel_set_to_readonly || !within(address, start, end))
+		return 0;
 	/*
-	 * Once the kernel maps the text as RO (kernel_set_to_readonly is set),
-	 * kernel text mappings for the large page aligned text, rodata sections
-	 * will be always read-only. For the kernel identity mappings covering
-	 * the holes caused by this alignment can be anything that user asks.
+	 * Don't enforce the !RW mapping for the kernel text mapping, if
+	 * the current mapping is already using small page mapping.  No
+	 * need to work hard to preserve large page mappings in this case.
 	 *
-	 * This will preserve the large page mappings for kernel text/data
-	 * at no extra cost.
+	 * This also fixes the Linux Xen paravirt guest boot failure caused
+	 * by unexpected read-only mappings for kernel identity
+	 * mappings. In this paravirt guest case, the kernel text mapping
+	 * and the kernel identity mapping share the same page-table pages,
+	 * so the protections for kernel text and identity mappings have to
+	 * be the same.
 	 */
-	if (kernel_set_to_readonly &&
-	    within(address, (unsigned long)_text,
-		   (unsigned long)__end_rodata_hpage_align)) {
-		unsigned int level;
-
-		/*
-		 * Don't enforce the !RW mapping for the kernel text mapping,
-		 * if the current mapping is already using small page mapping.
-		 * No need to work hard to preserve large page mappings in this
-		 * case.
-		 *
-		 * This also fixes the Linux Xen paravirt guest boot failure
-		 * (because of unexpected read-only mappings for kernel identity
-		 * mappings). In this paravirt guest case, the kernel text
-		 * mapping and the kernel identity mapping share the same
-		 * page-table pages. Thus we can't really use different
-		 * protections for the kernel text and identity mappings. Also,
-		 * these shared mappings are made of small page mappings.
-		 * Thus this don't enforce !RW mapping for small page kernel
-		 * text mapping logic will help Linux Xen parvirt guest boot
-		 * as well.
-		 */
-		if (lookup_address(address, &level) && (level != PG_LEVEL_4K))
-			pgprot_val(forbidden) |= _PAGE_RW;
-	}
+	if (lookup_address(address, &level) && (level != PG_LEVEL_4K))
+		return _PAGE_RW;
+	return 0;
+}
+#else
+static pgprotval_t protect_kernel_text_ro(unsigned long address)
+{
+	return 0;
+}
 #endif
 
-	prot = __pgprot(pgprot_val(prot) & ~pgprot_val(forbidden));
+/*
+ * Certain areas of memory on x86 require very specific protection flags,
+ * for example the BIOS area or kernel text. Callers don't always get this
+ * right (again, ioremap() on BIOS memory is not uncommon) so this function
+ * checks and fixes these known static required protection bits.
+ */
+static inline pgprot_t static_protections(pgprot_t prot, unsigned long address,
+					  unsigned long pfn)
+{
+	pgprotval_t forbidden;
+
+	/* Operate on the virtual address */
+	forbidden  = protect_kernel_text(address);
+	forbidden |= protect_kernel_text_ro(address);
+
+	/* Check the PFN directly */
+	forbidden |= protect_pci_bios(pfn);
+	forbidden |= protect_rodata(pfn);
 
-	return prot;
+	return __pgprot(pgprot_val(prot) & ~forbidden);
 }
 
 /*


